<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Registrasi berhasil',
            'data' => [
                'user' => $user,
                'token' => $token,
            ],
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'nullable|string|email',
            'nis' => 'nullable|string',
            'password' => 'required|string',
        ]);

        if ($request->has('email')) {
            if (!Auth::guard('web')->attempt($request->only('email', 'password'))) {
                throw ValidationException::withMessages([
                    'email' => ['Email atau password salah.'],
                ]);
            }
            $user = User::where('email', $request->email)->firstOrFail();
            $token = $user->createToken('auth_token')->plainTextToken;
            $userData = $user;
        } else if ($request->has('nis')) {
            $student = \App\Models\Student::where('nis', $request->nis)->first();
            if (!$student || !Hash::check($request->password, $student->password)) {
                throw ValidationException::withMessages([
                    'nis' => ['NIS atau password salah.'],
                ]);
            }
            $token = $student->createToken('auth_token')->plainTextToken;
            $userData = $student;
        } else {
            throw ValidationException::withMessages([
                'email' => ['Email atau NIS diperlukan.'],
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Login berhasil',
            'data' => [
                'user' => $userData,
                'token' => $token,
            ],
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logout berhasil',
        ]);
    }

    public function user(Request $request)
    {
        return response()->json([
            'success' => true,
            'data' => $request->user(),
        ]);
    }
}
