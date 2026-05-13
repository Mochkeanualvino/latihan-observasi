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
            'nip' => 'required|string|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'nip' => $request->nip,
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
            'nip' => 'nullable|string',
            'nis' => 'nullable|string',
            'password' => 'required|string',
        ]);

        if ($request->has('nip')) {
            if (!Auth::guard('web')->attempt($request->only('nip', 'password'))) {
                throw ValidationException::withMessages([
                    'nip' => ['NIP atau password salah.'],
                ]);
            }
            $user = User::where('nip', $request->nip)->firstOrFail();
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
                'nip' => ['NIP atau NIS diperlukan.'],
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
