<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Exception;

class ChatService
{
    private $apiKey;
    private $model;
    private $apiUrl;

    public function __construct()
    {
        $this->apiKey = config('services.groq.api_key');
        $this->model = config('services.groq.model');
        $this->apiUrl = config('services.groq.api_url');
    }

    public function chat($cvAnalysisId, $userMessage, $userId)
    {
        try {
            // Récupérer l'analyse du CV et l'historique de conversation
            $cvAnalysis = DB::table('cv_analyses')
                ->where('id', $cvAnalysisId)
                ->where('user_id', $userId)
                ->first();

            if (!$cvAnalysis) {
                throw new Exception("Analyse non trouvée");
            }

            // Récupérer l'historique des 10 derniers messages
            $conversationHistory = DB::table('cv_conversations')
                ->where('cv_analysis_id', $cvAnalysisId)
                ->where('user_id', $userId)
                ->orderBy('created_at', 'desc')
                ->limit(10)
                ->get()
                ->reverse();

            // Construire les messages pour l'API
            $messages = $this->buildMessages($cvAnalysis, $conversationHistory, $userMessage);

            // Appeler l'API Groq
            $response = Http::withHeaders([
                'Content-Type' => 'application/json; charset=utf-8',
                'Authorization' => 'Bearer ' . $this->apiKey,
            ])
            ->withoutVerifying()
            ->timeout(60)
            ->post($this->apiUrl, [
                'messages' => $messages,
                'model' => $this->model,
                'temperature' => 0.7,
                'max_tokens' => 1024
            ]);

            if ($response->failed()) {
                throw new Exception("Erreur API Groq : " . $response->body());
            }

            $result = $response->json();
            $assistantResponse = $result['choices'][0]['message']['content'] ?? '';

            if (empty($assistantResponse)) {
                throw new Exception("Réponse vide de l'API");
            }

            // Sauvegarder la conversation
            $conversationId = DB::table('cv_conversations')->insertGetId([
                'user_id' => $userId,
                'cv_analysis_id' => $cvAnalysisId,
                'message' => $userMessage,
                'response' => $assistantResponse,
                'role' => 'user',
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            return [
                'id' => $conversationId,
                'message' => $userMessage,
                'response' => $assistantResponse,
                'created_at' => now()->format('Y-m-d H:i:s')
            ];

        } catch (Exception $e) {
            throw new Exception("Erreur lors du chat : " . $e->getMessage());
        }
    }

    private function buildMessages($cvAnalysis, $conversationHistory, $userMessage)
    {
        $messages = [];

        // Message système avec le contexte du CV
        $systemPrompt = "Tu es un assistant expert en ressources humaines et analyse de CV. ";
        $systemPrompt .= "Tu discutes avec l'utilisateur à propos de son CV qui a été analysé. ";
        $systemPrompt .= "\n\nVoici le résumé de l'analyse du CV :\n";
        $systemPrompt .= "- Score global : {$cvAnalysis->overall_score}/100\n";
        $systemPrompt .= "- Résumé : {$cvAnalysis->summary}\n";
        
        $strengths = json_decode($cvAnalysis->strengths, true);
        if ($strengths) {
            $systemPrompt .= "\nPoints forts :\n";
            foreach ($strengths as $strength) {
                $systemPrompt .= "- {$strength}\n";
            }
        }

        $weaknesses = json_decode($cvAnalysis->weaknesses, true);
        if ($weaknesses) {
            $systemPrompt .= "\nPoints faibles :\n";
            foreach ($weaknesses as $weakness) {
                $systemPrompt .= "- {$weakness}\n";
            }
        }

        $systemPrompt .= "\n\nTon rôle est de :\n";
        $systemPrompt .= "1. Répondre aux questions sur l'analyse du CV\n";
        $systemPrompt .= "2. Donner des conseils personnalisés pour améliorer le CV\n";
        $systemPrompt .= "3. Expliquer les scores et recommandations\n";
        $systemPrompt .= "4. Aider l'utilisateur à comprendre comment optimiser son CV\n";
        $systemPrompt .= "\nRéponds de manière claire, professionnelle et constructive.";

        $messages[] = [
            'role' => 'system',
            'content' => $systemPrompt
        ];

        // Ajouter l'historique de conversation
        foreach ($conversationHistory as $conv) {
            $messages[] = [
                'role' => 'user',
                'content' => $conv->message
            ];
            $messages[] = [
                'role' => 'assistant',
                'content' => $conv->response
            ];
        }

        // Ajouter le nouveau message de l'utilisateur
        $messages[] = [
            'role' => 'user',
            'content' => $userMessage
        ];

        return $messages;
    }

    public function getConversationHistory($cvAnalysisId, $userId)
    {
        return DB::table('cv_conversations')
            ->where('cv_analysis_id', $cvAnalysisId)
            ->where('user_id', $userId)
            ->orderBy('created_at', 'asc')
            ->get();
    }
}