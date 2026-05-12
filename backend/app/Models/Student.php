<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Student extends Authenticatable
{
    use HasApiTokens;

    protected $fillable = [
        'name',
        'nis',
        'class_name',
        'gender',
        'photo_url',
        'password',
        'total_violation_points',
        'total_achievement_points',
        'violation_count',
        'achievement_count',
    ];

    protected $hidden = [
        'password',
    ];

    protected $casts = [
        'total_violation_points' => 'integer',
        'total_achievement_points' => 'integer',
        'violation_count' => 'integer',
        'achievement_count' => 'integer',
    ];

    public function violations(): HasMany
    {
        return $this->hasMany(Violation::class);
    }

    public function achievements(): HasMany
    {
        return $this->hasMany(Achievement::class);
    }

    public function getBehaviorScoreAttribute(): int
    {
        return 100 - $this->total_violation_points + $this->total_achievement_points;
    }

    public function getBehaviorGradeAttribute(): string
    {
        $score = $this->behavior_score;
        if ($score >= 90) return 'A';
        if ($score >= 80) return 'B';
        if ($score >= 70) return 'C';
        if ($score >= 60) return 'D';
        return 'E';
    }

    public function recalculatePoints(): void
    {
        $this->total_violation_points = $this->violations()->sum('points');
        $this->violation_count = $this->violations()->count();
        $this->total_achievement_points = $this->achievements()->sum('points');
        $this->achievement_count = $this->achievements()->count();
        $this->save();
    }
}
