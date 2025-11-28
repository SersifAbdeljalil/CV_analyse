<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\ChatService;
use Exception;

class ChatController extends Controller
{
    private $chatService;

    public function __construct(ChatService $chatService)
    {
        $this->chatService = $chatService;
    }

    /**
     * Envoyer un message dans le chat
     * POST /api/cv/chat
     */
    public function sendMessage(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'cv_analysis_id' => 'required|integer|exists:cv_analyses,id',
            'message' => 'required|string|min:1|max:1000',
        ], [
            'cv_analysis_id.required' => 'L\'ID de l\'analyse est requis',
            'cv_analysis_id.exists' => 'Cette analyse n\'existe pas',
            'message.required' => 'Le message est requis',
            'message.max' => 'Le message ne doit pas dépasser 1000 caractères',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur de validation',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $user = $request->user();
            $cvAnalysisId = $request->cv_analysis_id;
            $message = $request->message;

            $response = $this->chatService->chat($cvAnalysisId, $message, $user->id);

            return response()->json([
                'success' => true,
                'data' => $response
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de l\'envoi du message',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Récupérer l'historique de conversation
     * GET /api/cv/chat/{cvAnalysisId}
     */
    public function getHistory(Request $request, $cvAnalysisId)
    {
        try {
            $user = $request->user();
            $history = $this->chatService->getConversationHistory($cvAnalysisId, $user->id);

            return response()->json([
                'success' => true,
                'data' => $history
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération de l\'historique',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}