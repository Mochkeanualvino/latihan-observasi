<?php

namespace App\Http\Controllers;

use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class StudentController extends Controller
{
    public function index(Request $request)
    {
        $query = Student::query();

        if ($request->has('class_name') && $request->class_name !== 'Semua') {
            $query->where('class_name', $request->class_name);
        }

        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('nis', 'like', "%{$search}%");
            });
        }

        $students = $query->orderBy('name')->get();

        return response()->json([
            'success' => true,
            'data' => $students,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'nis' => 'required|string|unique:students',
            'class_name' => 'required|string',
            'gender' => 'required|in:L,P',
        ]);

        $data = $request->only(['name', 'nis', 'class_name', 'gender', 'photo_url']);
        $data['password'] = Hash::make('password123'); // Default password

        $student = Student::create($data);

        return response()->json([
            'success' => true,
            'message' => 'Siswa berhasil ditambahkan',
            'data' => $student,
        ], 201);
    }

    public function show(Student $student)
    {
        $student->load(['violations', 'achievements']);

        return response()->json([
            'success' => true,
            'data' => $student,
        ]);
    }

    public function update(Request $request, Student $student)
    {
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'nis' => 'sometimes|string|unique:students,nis,' . $student->id,
            'class_name' => 'sometimes|string',
            'gender' => 'sometimes|in:L,P',
        ]);

        $student->update($request->only([
            'name', 'nis', 'class_name', 'gender', 'photo_url',
        ]));

        return response()->json([
            'success' => true,
            'message' => 'Data siswa berhasil diperbarui',
            'data' => $student,
        ]);
    }

    public function destroy(Student $student)
    {
        $student->delete();

        return response()->json([
            'success' => true,
            'message' => 'Siswa berhasil dihapus',
        ]);
    }
}
