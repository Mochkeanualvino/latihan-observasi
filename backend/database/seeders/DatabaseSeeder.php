<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Student;
use App\Models\Violation;
use App\Models\Achievement;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create default guru user
        User::create([
            'name' => 'Guru EduTrack',
            'nip' => '198001012005011003',
            'password' => Hash::make('password123'),
        ]);

        // Create students (SMP Kelas 7-9)
        $students = [
            ['name' => 'Ahmad Rizky Pratama', 'nis' => '2024001', 'class_name' => '7-A', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Siti Nurhaliza', 'nis' => '2024002', 'class_name' => '7-A', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Budi Santoso', 'nis' => '2024003', 'class_name' => '7-B', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Dewi Anggraini', 'nis' => '2024004', 'class_name' => '7-C', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Fajar Nugroho', 'nis' => '2024005', 'class_name' => '8-A', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Putri Rahayu', 'nis' => '2024006', 'class_name' => '8-A', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Rendi Wijaya', 'nis' => '2024007', 'class_name' => '8-B', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Anisa Fitri', 'nis' => '2024008', 'class_name' => '9-A', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Dimas Arya', 'nis' => '2024009', 'class_name' => '9-A', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Maya Sari', 'nis' => '2024010', 'class_name' => '9-B', 'gender' => 'P', 'password' => Hash::make('password123')],
        ];

        foreach ($students as $s) {
            Student::create($s);
        }

        // Create violations
        $violations = [
            ['student_id' => 1, 'category' => 'Terlambat', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Datang terlambat 15 menit', 'date' => now()->subDays(1), 'reported_by' => 'Pak Joko'],
            ['student_id' => 1, 'category' => 'Tidak Berseragam', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Tidak memakai dasi', 'date' => now()->subDays(3), 'reported_by' => 'Bu Sari'],
            ['student_id' => 3, 'category' => 'Bolos', 'severity' => 'Sedang', 'points' => 15, 'description' => 'Tidak masuk tanpa keterangan', 'date' => now()->subDays(2), 'reported_by' => 'Pak Ahmad'],
            ['student_id' => 5, 'category' => 'Berkelahi', 'severity' => 'Berat', 'points' => 30, 'description' => 'Berkelahi dengan teman sekelas', 'date' => now()->subDays(1), 'reported_by' => 'Pak Budi'],
            ['student_id' => 7, 'category' => 'Tidak Mengerjakan Tugas', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Tidak mengumpulkan PR Matematika', 'date' => now()->subDays(2), 'reported_by' => 'Pak Hasan'],
            ['student_id' => 9, 'category' => 'Merokok', 'severity' => 'Berat', 'points' => 25, 'description' => 'Kedapatan merokok di belakang kantin', 'date' => now()->subDays(3), 'reported_by' => 'Pak Joko'],
            ['student_id' => 4, 'category' => 'Terlambat', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Terlambat 10 menit', 'date' => now()->subDays(7), 'reported_by' => 'Bu Sari'],
        ];

        foreach ($violations as $v) {
            $student = Student::find($v['student_id']);
            Violation::create(array_merge($v, [
                'student_name' => $student->name,
                'class_name' => $student->class_name,
            ]));
        }

        // Create achievements
        $achievements = [
            ['student_id' => 2, 'category' => 'Akademik', 'level' => 'Kabupaten/Kota', 'points' => 20, 'title' => 'Juara 1 Olimpiade Matematika', 'description' => 'Meraih juara 1 lomba olimpiade matematika tingkat kabupaten', 'date' => now()->subDays(10), 'verified_by' => 'Kepala Sekolah'],
            ['student_id' => 6, 'category' => 'Akademik', 'level' => 'Provinsi', 'points' => 25, 'title' => 'Juara 2 OSN IPA', 'description' => 'Meraih juara 2 OSN bidang IPA tingkat provinsi', 'date' => now()->subDays(15), 'verified_by' => 'Kepala Sekolah'],
            ['student_id' => 8, 'category' => 'Sains & Teknologi', 'level' => 'Nasional', 'points' => 30, 'title' => 'Finalis Kompetisi Robotik', 'description' => 'Lolos hingga final kompetisi robotik tingkat nasional', 'date' => now()->subDays(5), 'verified_by' => 'Kepala Sekolah'],
            ['student_id' => 1, 'category' => 'Olahraga', 'level' => 'Kabupaten/Kota', 'points' => 15, 'title' => 'Juara 2 Lomba Futsal', 'description' => 'Meraih juara 2 turnamen futsal antar SMP', 'date' => now()->subDays(12), 'verified_by' => 'Guru Olahraga'],
            ['student_id' => 10, 'category' => 'Seni & Budaya', 'level' => 'Kecamatan', 'points' => 10, 'title' => 'Juara 1 Lomba Tari', 'description' => 'Juara 1 lomba tari tradisional tingkat kecamatan', 'date' => now()->subDays(18), 'verified_by' => 'Guru Seni'],
            ['student_id' => 4, 'category' => 'Keagamaan', 'level' => 'Kecamatan', 'points' => 10, 'title' => 'Juara 1 MTQ', 'description' => 'Juara 1 Musabaqah Tilawatil Quran tingkat kecamatan', 'date' => now()->subDays(22), 'verified_by' => 'Guru Agama'],
        ];

        foreach ($achievements as $a) {
            $student = Student::find($a['student_id']);
            Achievement::create(array_merge($a, [
                'student_name' => $student->name,
                'class_name' => $student->class_name,
            ]));
        }

        // Recalculate all student points
        Student::all()->each(function ($student) {
            $student->recalculatePoints();
        });
    }
}
