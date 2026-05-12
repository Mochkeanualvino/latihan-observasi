<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Achievement extends Model
{
    protected $fillable = [
        'student_id',
        'student_name',
        'class_name',
        'category',
        'level',
        'points',
        'title',
        'description',
        'date',
        'verified_by',
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
