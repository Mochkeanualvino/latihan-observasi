<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\ViolationController;
use App\Http\Controllers\AchievementController;
use App\Http\Controllers\DashboardController;

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Auth
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);

    // Dashboard
    Route::get('/dashboard', [DashboardController::class, 'stats']);

    // Students
    Route::apiResource('students', StudentController::class);

    // Violations
    Route::apiResource('violations', ViolationController::class)->only(['index', 'store', 'destroy']);

    // Achievements
    Route::apiResource('achievements', AchievementController::class)->only(['index', 'store', 'destroy']);
});
