<?php

namespace App\Http\Controllers;

use App\Models\Achievement;
use App\Models\Student;
use Illuminate\Http\Request;

class AchievementController extends Controller
{
    public function index(Request $request)
    {
        $query = Achievement::query()->orderBy('date', 'desc');

        if ($request->has('student_id')) {
            $query->where('student_id', $request->student_id);
        }

        $achievements = $query->get();

        return response()->json([
            'success' => true,
            'data' => $achievements,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'category' => 'required|string',
            'level' => 'required|string',
            'points' => 'required|integer|min:1',
            'title' => 'required|string',
            'description' => 'required|string',
            'date' => 'required|date',
            'verified_by' => 'required|string',
        ]);

        $student = Student::findOrFail($request->student_id);

        $achievement = Achievement::create([
            'student_id' => $student->id,
            'student_name' => $student->name,
            'class_name' => $student->class_name,
            'category' => $request->category,
            'level' => $request->level,
            'points' => $request->points,
            'title' => $request->title,
            'description' => $request->description,
            'date' => $request->date,
            'verified_by' => $request->verified_by,
        ]);

        $student->recalculatePoints();

        return response()->json([
            'success' => true,
            'message' => 'Prestasi berhasil dicatat',
            'data' => $achievement,
        ], 201);
    }

    public function destroy(Achievement $achievement)
    {
        $student = $achievement->student;
        $achievement->delete();
        $student->recalculatePoints();

        return response()->json([
            'success' => true,
            'message' => 'Prestasi berhasil dihapus',
        ]);
    }
}
