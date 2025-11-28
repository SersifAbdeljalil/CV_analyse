<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Services\CVAnalyzerService;
use Exception;

class CVController extends Controller
{
    private $cvAnalyzer;

    public function __construct(CVAnalyzerService $cvAnalyzer)
    {
        $this->cvAnalyzer = $cvAnalyzer;
    }

    /**
     * Analyser un CV
     * POST /api/cv/analyze
     */
    public function analyze(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'cv_file' => 'required|file|mimes:pdf,doc,docx|max:5120',
        ], [
            'cv_file.required' => 'Veuillez sélectionner un fichier CV',
            'cv_file.mimes' => 'Le fichier doit être au format PDF, DOC ou DOCX',
            'cv_file.max' => 'Le fichier ne doit pas dépasser 5 Mo',
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
            $file = $request->file('cv_file');

            $originalName = $file->getClientOriginalName();
            $extension = $file->getClientOriginalExtension();
            $storedName = time() . '_' . $user->id . '.' . $extension;
            $filePath = $file->storeAs('cvs', $storedName, 'public');

            $cvUpload = DB::table('cv_uploads')->insertGetId([
                'user_id' => $user->id,
                'original_filename' => $originalName,
                'stored_filename' => $storedName,
                'file_path' => $filePath,
                'file_type' => $extension,
                'file_size' => $file->getSize(),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $fullPath = storage_path('app/public/' . $filePath);
            
            if ($extension === 'pdf') {
                $extractedText = $this->cvAnalyzer->extractTextFromPdf($fullPath);
            } else {
                $extractedText = $this->cvAnalyzer->extractTextFromDocx($fullPath);
            }

            $analysis = $this->cvAnalyzer->analyzeCV($extractedText);

            $cvAnalysisId = DB::table('cv_analyses')->insertGetId([
                'cv_upload_id' => $cvUpload,
                'user_id' => $user->id,
                'overall_score' => $analysis['overall_score'],
                'section_scores' => json_encode($analysis['section_scores']),
                'summary' => $analysis['summary'],
                'recommendations' => json_encode($analysis['recommendations']),
                'strengths' => json_encode($analysis['strengths'] ?? []),
                'weaknesses' => json_encode($analysis['weaknesses'] ?? []),
                'extracted_text' => $extractedText,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Analyse terminée avec succès',
                'data' => [
                    'analysis_id' => $cvAnalysisId,
                    'overall_score' => $analysis['overall_score'],
                    'section_scores' => $analysis['section_scores'],
                    'summary' => $analysis['summary'],
                    'strengths' => $analysis['strengths'] ?? [],
                    'weaknesses' => $analysis['weaknesses'] ?? [],
                    'recommendations' => $analysis['recommendations'],
                    'filename' => $originalName,
                    'analyzed_at' => now()->format('Y-m-d H:i:s'),
                ]
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de l\'analyse',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Récupérer l'historique des analyses
     * GET /api/cv/history
     */
    public function history(Request $request)
    {
        try {
            $user = $request->user();

            $analyses = DB::table('cv_analyses')
                ->join('cv_uploads', 'cv_analyses.cv_upload_id', '=', 'cv_uploads.id')
                ->where('cv_analyses.user_id', $user->id)
                ->select(
                    'cv_analyses.id',
                    'cv_analyses.overall_score',
                    'cv_analyses.summary',
                    'cv_analyses.created_at',
                    'cv_uploads.original_filename'
                )
                ->orderBy('cv_analyses.created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $analyses
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération de l\'historique',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Récupérer une analyse spécifique
     * GET /api/cv/analysis/{id}
     */
    public function getAnalysis(Request $request, $id)
    {
        try {
            $user = $request->user();

            $analysis = DB::table('cv_analyses')
                ->join('cv_uploads', 'cv_analyses.cv_upload_id', '=', 'cv_uploads.id')
                ->where('cv_analyses.id', $id)
                ->where('cv_analyses.user_id', $user->id)
                ->select(
                    'cv_analyses.*',
                    'cv_uploads.original_filename'
                )
                ->first();

            if (!$analysis) {
                return response()->json([
                    'success' => false,
                    'message' => 'Analyse non trouvée'
                ], 404);
            }

            $analysis->section_scores = json_decode($analysis->section_scores);
            $analysis->recommendations = json_decode($analysis->recommendations);
            $analysis->strengths = json_decode($analysis->strengths);
            $analysis->weaknesses = json_decode($analysis->weaknesses);

            return response()->json([
                'success' => true,
                'data' => $analysis
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération de l\'analyse',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}