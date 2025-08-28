<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthApiController;

Route::post('/register', [AuthApiController::class, 'register']);
Route::post('/login', [AuthApiController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthApiController::class, 'logout']);
    Route::get('/me', [AuthApiController::class, 'me']);
    Route::post('/change-password', [AuthApiController::class, 'changePassword']);

    Route::get('/dashboard', function (Request $request) {
        $user = $request->user();
        return response()->json([
            'message' => "Selamat datang {$user->role}!",
            'user' => $user
        ]);
    });
});
