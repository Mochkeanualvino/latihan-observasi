<?php

namespace App\Http\Controllers;

use App\Models\Student;
use App\Models\Violation;
use App\Models\Achievement;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function stats()
    {
        $totalStudents = Student::count();
        $totalViolations = Violation::count();
        $totalAchievements = Achievement::count();
        $totalViolationPoints = Violation::sum('points');
        $totalAchievementPoints = Achievement::sum('points');

        // Weekly data (last 7 days)
        $weeklyViolations = [];
        $weeklyAchievements = [];
        for ($i = 6; $i >= 0; $i--) {
            $date = now()->subDays($i)->toDateString();
            $weeklyViolations[] = Violation::whereDate('date', $date)->count();
            $weeklyAchievements[] = Achievement::whereDate('date', $date)->count();
        }

        // Violation category distribution
        $violationDistribution = Violation::select('category', DB::raw('count(*) as total'))
            ->groupBy('category')
            ->pluck('total', 'category');

        // Class stats
        $classStats = Student::select('class_name')
            ->selectRaw('count(*) as student_count')
            ->selectRaw('sum(violation_count) as total_violations')
            ->selectRaw('sum(achievement_count) as total_achievements')
            ->groupBy('class_name')
            ->orderBy('class_name')
            ->get();

        // Top 5 students by achievement
        $topStudents = Student::orderBy('total_achievement_points', 'desc')
            ->limit(5)
            ->get();

        // Recent activities
        $recentViolations = Violation::orderBy('date', 'desc')->limit(5)->get()->map(function ($v) {
            return [
                'type' => 'violation',
                'title' => $v->category,
                'subtitle' => $v->student_name,
                'class_name' => $v->class_name,
                'points' => $v->points,
                'date' => $v->date->toIso8601String(),
                'severity' => $v->severity,
            ];
        });

        $recentAchievements = Achievement::orderBy('date', 'desc')->limit(5)->get()->map(function ($a) {
            return [
                'type' => 'achievement',
                'title' => $a->title,
                'subtitle' => $a->student_name,
                'class_name' => $a->class_name,
                'points' => $a->points,
                'date' => $a->date->toIso8601String(),
                'level' => $a->level,
            ];
        });

        $recentActivities = $recentViolations->merge($recentAchievements)
            ->sortByDesc('date')
            ->take(10)
            ->values();

        return response()->json([
            'success' => true,
            'data' => [
                'total_students' => $totalStudents,
                'total_violations' => $totalViolations,
                'total_achievements' => $totalAchievements,
                'total_violation_points' => $totalViolationPoints,
                'total_achievement_points' => $totalAchievementPoints,
                'weekly_violations' => $weeklyViolations,
                'weekly_achievements' => $weeklyAchievements,
                'violation_distribution' => $violationDistribution,
                'class_stats' => $classStats,
                'top_students' => $topStudents,
                'recent_activities' => $recentActivities,
            ],
        ]);
    }
}
