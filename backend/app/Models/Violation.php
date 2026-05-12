<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Violation extends Model
{
    protected $fillable = [
        'student_id',
        'student_name',
        'class_name',
        'category',
        'severity',
        'points',
        'description',
        'date',
        'reported_by',
    ];

    protected $casts = [
        'points' => 'integer',
        'date' => 'date',
        'student_id' => 'integer',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(Student::class);
    }
}
