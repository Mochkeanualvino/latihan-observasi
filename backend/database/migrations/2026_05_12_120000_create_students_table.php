<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('students', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('nis')->unique();
            $table->string('class_name');
            $table->enum('gender', ['L', 'P']);
            $table->string('photo_url')->nullable();
            $table->integer('total_violation_points')->default(0);
            $table->integer('total_achievement_points')->default(0);
            $table->integer('violation_count')->default(0);
            $table->integer('achievement_count')->default(0);
            $table->string('password');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};
