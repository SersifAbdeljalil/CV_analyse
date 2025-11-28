<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cv_conversations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('cv_analysis_id');
            $table->text('message');
            $table->text('response');
            $table->string('role'); // 'user' ou 'assistant'
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('cv_analysis_id')->references('id')->on('cv_analyses')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cv_conversations');
    }
};