<?php

use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

// Redirect root (/) langsung ke halaman login
Route::get('/', function () {
    return redirect()->route('login');
});

// Register
Route::get('/register', [AuthController::class, 'showRegister'])->name('register');
Route::post('/register', [AuthController::class, 'register']);

// Login
Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
Route::post('/login', [AuthController::class, 'login']);

// Logout
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

// Dashboard masing-masing role
Route::middleware(['auth', 'role:admin'])->get('/admin/dashboard', function () {
    return view('dashboard.admin'); // Bisa buat file resources/views/dashboard/admin.blade.php
})->name('admin.dashboard');

Route::middleware(['auth', 'role:petugas'])->get('/petugas/dashboard', function () {
    return view('dashboard.petugas');
})->name('petugas.dashboard');

Route::middleware(['auth', 'role:user'])->get('/user/dashboard', function () {
    return view('dashboard.user');
})->name('user.dashboard');
