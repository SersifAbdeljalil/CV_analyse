<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cv_analyses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cv_upload_id')->constrained('cv_uploads')->onDelete('cascade');
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->integer('overall_score'); // Score global 0-100
            $table->json('section_scores'); // Scores par section
            $table->text('summary'); // Résumé de l'analyse
            $table->json('recommendations'); // Liste des recommandations
            $table->json('strengths')->nullable(); // Points forts
            $table->json('weaknesses')->nullable(); // Points faibles
            $table->text('extracted_text')->nullable(); // Texte extrait du CV
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv_analyses');
    }
};