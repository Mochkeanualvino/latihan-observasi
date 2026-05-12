<?php

namespace App\Http\Controllers;

use App\Models\Violation;
use App\Models\Student;
use Illuminate\Http\Request;

class ViolationController extends Controller
{
    public function index(Request $request)
    {
        $query = Violation::query()->orderBy('date', 'desc');

        if ($request->has('student_id')) {
            $query->where('student_id', $request->student_id);
        }

        $violations = $query->get();

        return response()->json([
            'success' => true,
            'data' => $violations,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'category' => 'required|string',
            'severity' => 'required|string',
            'points' => 'required|integer|min:1',
            'description' => 'required|string',
            'date' => 'required|date',
            'reported_by' => 'required|string',
        ]);

        $student = Student::findOrFail($request->student_id);

        $violation = Violation::create([
            'student_id' => $student->id,
            'student_name' => $student->name,
            'class_name' => $student->class_name,
            'category' => $request->category,
            'severity' => $request->severity,
            'points' => $request->points,
            'description' => $request->description,
            'date' => $request->date,
            'reported_by' => $request->reported_by,
        ]);

        $student->recalculatePoints();

        return response()->json([
            'success' => true,
            'message' => 'Pelanggaran berhasil dicatat',
            'data' => $violation,
        ], 201);
    }

    public function destroy(Violation $violation)
    {
        $student = $violation->student;
        $violation->delete();
        $student->recalculatePoints();

        return response()->json([
            'success' => true,
            'message' => 'Pelanggaran berhasil dihapus',
        ]);
    }
}
