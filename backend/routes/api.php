<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CVController;
use App\Http\Controllers\ChatController;

// Routes publiques
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Routes protégées
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
    
    // Routes CV
    Route::post('/cv/analyze', [CVController::class, 'analyze']);
    Route::get('/cv/history', [CVController::class, 'history']);
    Route::get('/cv/analysis/{id}', [CVController::class, 'getAnalysis']);
    
    // Routes Chat
    Route::post('/cv/chat', [ChatController::class, 'sendMessage']);
    Route::get('/cv/chat/{cvAnalysisId}', [ChatController::class, 'getHistory']);
});