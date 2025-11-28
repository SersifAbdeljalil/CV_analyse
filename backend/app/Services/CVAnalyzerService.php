<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Smalot\PdfParser\Parser as PdfParser;
use PhpOffice\PhpWord\IOFactory;
use Exception;

class CVAnalyzerService
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

    public function extractTextFromPdf($filePath)
    {
        try {
            // Vérifier que le fichier existe
            if (!file_exists($filePath)) {
                throw new Exception("Le fichier PDF n'existe pas : {$filePath}");
            }

            Log::info("Extraction PDF : {$filePath}");

            // Première tentative avec Smalot
            $text = $this->extractPdfUsingSmalot($filePath);

            // Si échec, essayer une alternative
            if (empty(trim($text))) {
                Log::warning("Smalot n'a pas extrait de texte, essai d'une méthode alternative");
                $text = $this->extractPdfUsingPopen($filePath);
            }

            Log::info("Texte extrait (longueur) : " . strlen($text));

            if (empty(trim($text))) {
                throw new Exception("Aucun texte n'a pu être extrait du PDF");
            }

            return $this->cleanText($text);
        } catch (Exception $e) {
            Log::error("Erreur extraction PDF : " . $e->getMessage());
            throw new Exception("Erreur lors de l'extraction du PDF : " . $e->getMessage());
        }
    }

    private function extractPdfUsingSmalot($filePath)
    {
        try {
            $parser = new PdfParser();
            $pdf = $parser->parseFile($filePath);
            $text = $pdf->getText();
            return $text ?? '';
        } catch (Exception $e) {
            Log::warning("Smalot error : " . $e->getMessage());
            return '';
        }
    }

    private function extractPdfUsingPopen($filePath)
    {
        try {
            // Utiliser pdftotext si disponible sur le système
            $escapedPath = escapeshellarg($filePath);
            $command = "pdftotext {$escapedPath} -";
            
            $handle = popen($command, 'r');
            if ($handle === false) {
                return '';
            }

            $text = stream_get_contents($handle);
            pclose($handle);
            
            return $text ?? '';
        } catch (Exception $e) {
            Log::warning("Popen error : " . $e->getMessage());
            return '';
        }
    }

    public function extractTextFromDocx($filePath)
    {
        try {
            // Vérifier que le fichier existe
            if (!file_exists($filePath)) {
                throw new Exception("Le fichier DOCX n'existe pas : {$filePath}");
            }

            Log::info("Extraction DOCX : {$filePath}");

            $phpWord = IOFactory::load($filePath);
            $text = '';
            
            foreach ($phpWord->getSections() as $section) {
                $elements = $section->getElements();
                foreach ($elements as $element) {
                    // TextRun
                    if (method_exists($element, 'getText')) {
                        $text .= $element->getText() . "\n";
                    }
                    // Text
                    elseif (method_exists($element, 'getElements')) {
                        foreach ($element->getElements() as $childElement) {
                            if (method_exists($childElement, 'getText')) {
                                $text .= $childElement->getText() . " ";
                            }
                        }
                    }
                }
            }

            Log::info("Texte extrait (longueur) : " . strlen($text));

            if (empty(trim($text))) {
                throw new Exception("Aucun texte n'a pu être extrait du DOCX");
            }
            
            return $this->cleanText($text);
        } catch (Exception $e) {
            Log::error("Erreur extraction DOCX : " . $e->getMessage());
            throw new Exception("Erreur lors de l'extraction du DOCX : " . $e->getMessage());
        }
    }

    private function cleanText($text)
    {
        // Convertir en UTF-8 si nécessaire
        if (!mb_check_encoding($text, 'UTF-8')) {
            $text = mb_convert_encoding($text, 'UTF-8', 'auto');
        }
        
        // Supprimer les caractères de contrôle
        $text = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/u', '', $text);
        
        // Nettoyer les espaces multiples (mais garder les nouvelles lignes)
        $text = preg_replace('/[ \t]+/', ' ', $text);
        $text = preg_replace('/\n\s*\n/', "\n", $text);
        
        // Supprimer les caractères UTF-8 invalides
        $text = mb_convert_encoding($text, 'UTF-8', 'UTF-8');
        
        // Trim
        $text = trim($text);
        
        return $text;
    }

    public function analyzeCV($cvText)
    {
        Log::info("Analyse CV - Longueur texte : " . strlen($cvText));

        // Réduire le seuil minimum et être plus tolérant
        if (empty($cvText) || strlen(trim($cvText)) < 20) {
            Log::error("Texte trop court ou vide : " . strlen($cvText) . " caractères");
            throw new Exception("Le texte du CV est vide ou trop court (minimum 20 caractères)");
        }

        $prompt = $this->buildPrompt($cvText);

        try {
            $response = Http::withHeaders([
                'Content-Type' => 'application/json; charset=utf-8',
                'Authorization' => 'Bearer ' . $this->apiKey,
            ])
            ->withoutVerifying()
            ->timeout(60)
            ->post($this->apiUrl, [
                'messages' => [
                    [
                        'role' => 'system',
                        'content' => 'Tu es un expert en analyse de CV. Tu dois analyser les CVs et fournir des évaluations détaillées en JSON uniquement, sans texte additionnel.'
                    ],
                    [
                        'role' => 'user',
                        'content' => $prompt
                    ]
                ],
                'model' => $this->model,
                'temperature' => 0.7,
                'max_tokens' => 2048
            ]);

            if ($response->failed()) {
                Log::error("Erreur API Groq : " . $response->body());
                throw new Exception("Erreur API Groq : " . $response->body());
            }

            $result = $response->json();
            $analysisText = $result['choices'][0]['message']['content'] ?? '';

            if (empty($analysisText)) {
                throw new Exception("Réponse vide de l'API Groq");
            }

            Log::info("Réponse API reçue : " . substr($analysisText, 0, 200));

            return $this->parseAnalysis($analysisText);

        } catch (\JsonException $e) {
            Log::error("json_encode error: " . $e->getMessage());
            throw new Exception("json_encode error: " . $e->getMessage());
        } catch (Exception $e) {
            Log::error("Erreur analyse IA : " . $e->getMessage());
            throw new Exception("Erreur lors de l'analyse IA : " . $e->getMessage());
        }
    }

    private function buildPrompt($cvText)
    {
        return "Analyse ce CV et fournis une évaluation détaillée au format JSON suivant :

{
  \"overall_score\": [score entre 0 et 100],
  \"section_scores\": {
    \"presentation\": [score 0-100],
    \"experience\": [score 0-100],
    \"formation\": [score 0-100],
    \"competences\": [score 0-100],
    \"coherence\": [score 0-100]
  },
  \"summary\": \"[Résumé de l'analyse en 2-3 phrases]\",
  \"strengths\": [
    \"Point fort 1\",
    \"Point fort 2\",
    \"Point fort 3\"
  ],
  \"weaknesses\": [
    \"Point faible 1\",
    \"Point faible 2\",
    \"Point faible 3\"
  ],
  \"recommendations\": [
    {
      \"category\": \"Présentation\",
      \"priority\": \"haute\",
      \"suggestion\": \"Recommandation détaillée\"
    },
    {
      \"category\": \"Expérience\",
      \"priority\": \"moyenne\",
      \"suggestion\": \"Recommandation détaillée\"
    },
    {
      \"category\": \"Compétences\",
      \"priority\": \"basse\",
      \"suggestion\": \"Recommandation détaillée\"
    }
  ]
}

IMPORTANT : Réponds UNIQUEMENT avec le JSON valide, sans texte additionnel avant ou après, et sans balises markdown (pas de ```json).

CV à analyser :
---
$cvText
---";
    }

    private function parseAnalysis($analysisText)
    {
        // Nettoyer les balises markdown si présentes
        $analysisText = preg_replace('/```json\s*|\s*```/', '', $analysisText);
        $analysisText = trim($analysisText);

        // Vérifier l'encodage UTF-8
        if (!mb_check_encoding($analysisText, 'UTF-8')) {
            $analysisText = mb_convert_encoding($analysisText, 'UTF-8', 'UTF-8');
        }

        $analysis = json_decode($analysisText, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            Log::error("Erreur parsing JSON : " . json_last_error_msg());
            Log::error("Réponse brute : " . $analysisText);
            throw new Exception("Erreur lors du parsing JSON : " . json_last_error_msg() . " | Réponse : " . substr($analysisText, 0, 200));
        }

        if (!isset($analysis['overall_score']) || !isset($analysis['recommendations'])) {
            throw new Exception("Format de réponse invalide de l'IA");
        }

        return $analysis;
    }
}