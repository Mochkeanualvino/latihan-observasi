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
        // Create default admin user
        User::create([
            'name' => 'Admin EduTrack',
            'email' => 'admin@edutrack.com',
            'password' => Hash::make('password123'),
        ]);

        // Create students
        $students = [
            ['name' => 'Ahmad Rizky Pratama', 'nis' => '2024001', 'class_name' => 'X-A', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Siti Nurhaliza', 'nis' => '2024002', 'class_name' => 'X-A', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Budi Santoso', 'nis' => '2024003', 'class_name' => 'X-B', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Dewi Anggraini', 'nis' => '2024004', 'class_name' => 'X-B', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Fajar Nugroho', 'nis' => '2024005', 'class_name' => 'XI-A', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Putri Rahayu', 'nis' => '2024006', 'class_name' => 'XI-A', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Rendi Wijaya', 'nis' => '2024007', 'class_name' => 'XI-B', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Anisa Fitri', 'nis' => '2024008', 'class_name' => 'XII-A', 'gender' => 'P', 'password' => Hash::make('password123')],
            ['name' => 'Dimas Arya', 'nis' => '2024009', 'class_name' => 'XII-A', 'gender' => 'L', 'password' => Hash::make('password123')],
            ['name' => 'Maya Sari', 'nis' => '2024010', 'class_name' => 'XII-B', 'gender' => 'P', 'password' => Hash::make('password123')],
        ];

        foreach ($students as $s) {
            Student::create($s);
        }

        // Create violations
        $violations = [
            ['student_id' => 1, 'category' => 'Terlambat', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Datang terlambat 15 menit', 'date' => now()->subDays(1), 'reported_by' => 'Pak Joko'],
            ['student_id' => 1, 'category' => 'Tidak Berseragam', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Tidak memakai dasi', 'date' => now()->subDays(3), 'reported_by' => 'Bu Sari'],
            ['student_id' => 3, 'category' => 'Bolos', 'severity' => 'Sedang', 'points' => 15, 'description' => 'Tidak masuk tanpa keterangan', 'date' => now()->subDays(2), 'reported_by' => 'Pak Ahmad'],
            ['student_id' => 3, 'category' => 'Membawa HP', 'severity' => 'Ringan', 'points' => 10, 'description' => 'Ketahuan bermain HP saat pelajaran', 'date' => now()->subDays(5), 'reported_by' => 'Bu Dewi'],
            ['student_id' => 5, 'category' => 'Berkelahi', 'severity' => 'Berat', 'points' => 30, 'description' => 'Berkelahi dengan teman sekelas', 'date' => now()->subDays(1), 'reported_by' => 'Pak Budi'],
            ['student_id' => 5, 'category' => 'Terlambat', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Terlambat masuk kelas setelah istirahat', 'date' => now()->subDays(4), 'reported_by' => 'Bu Ani'],
            ['student_id' => 7, 'category' => 'Tidak Mengerjakan Tugas', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Tidak mengumpulkan PR Matematika', 'date' => now()->subDays(2), 'reported_by' => 'Pak Hasan'],
            ['student_id' => 7, 'category' => 'Membawa HP', 'severity' => 'Ringan', 'points' => 10, 'description' => 'Bermain game saat jam pelajaran', 'date' => now()->subDays(6), 'reported_by' => 'Bu Rina'],
            ['student_id' => 9, 'category' => 'Merokok', 'severity' => 'Berat', 'points' => 25, 'description' => 'Kedapatan merokok di belakang kantin', 'date' => now()->subDays(3), 'reported_by' => 'Pak Joko'],
            ['student_id' => 4, 'category' => 'Terlambat', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Terlambat 10 menit', 'date' => now()->subDays(7), 'reported_by' => 'Bu Sari'],
            ['student_id' => 10, 'category' => 'Tidak Berseragam', 'severity' => 'Ringan', 'points' => 5, 'description' => 'Sepatu bukan warna hitam', 'date' => now()->subDays(4), 'reported_by' => 'Pak Ahmad'],
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
            ['student_id' => 2, 'category' => 'Seni & Budaya', 'level' => 'Sekolah', 'points' => 15, 'title' => 'Juara 1 Lomba Pidato', 'description' => 'Meraih juara 1 lomba pidato Bahasa Indonesia', 'date' => now()->subDays(20), 'verified_by' => 'Waka Kesiswaan'],
            ['student_id' => 6, 'category' => 'Akademik', 'level' => 'Provinsi', 'points' => 25, 'title' => 'Juara 2 OSN Biologi', 'description' => 'Meraih juara 2 OSN bidang Biologi tingkat provinsi', 'date' => now()->subDays(15), 'verified_by' => 'Kepala Sekolah'],
            ['student_id' => 6, 'category' => 'Kepemimpinan', 'level' => 'Sekolah', 'points' => 15, 'title' => 'Ketua OSIS', 'description' => 'Terpilih sebagai Ketua OSIS periode 2024/2025', 'date' => now()->subDays(30), 'verified_by' => 'Kepala Sekolah'],
            ['student_id' => 8, 'category' => 'Sains & Teknologi', 'level' => 'Nasional', 'points' => 30, 'title' => 'Finalis Kompetisi Robotik', 'description' => 'Lolos hingga final kompetisi robotik tingkat nasional', 'date' => now()->subDays(5), 'verified_by' => 'Kepala Sekolah'],
            ['student_id' => 8, 'category' => 'Akademik', 'level' => 'Provinsi', 'points' => 20, 'title' => 'Juara 1 Lomba KIR', 'description' => 'Juara 1 Lomba Karya Ilmiah Remaja tingkat provinsi', 'date' => now()->subDays(25), 'verified_by' => 'Waka Kesiswaan'],
            ['student_id' => 1, 'category' => 'Olahraga', 'level' => 'Kabupaten/Kota', 'points' => 15, 'title' => 'Juara 2 Lomba Futsal', 'description' => 'Meraih juara 2 turnamen futsal antar SMA', 'date' => now()->subDays(12), 'verified_by' => 'Guru Olahraga'],
            ['student_id' => 10, 'category' => 'Seni & Budaya', 'level' => 'Kecamatan', 'points' => 10, 'title' => 'Juara 1 Lomba Tari', 'description' => 'Juara 1 lomba tari tradisional tingkat kecamatan', 'date' => now()->subDays(18), 'verified_by' => 'Guru Seni'],
            ['student_id' => 9, 'category' => 'Olahraga', 'level' => 'Provinsi', 'points' => 25, 'title' => 'Juara 3 Karate', 'description' => 'Meraih juara 3 kejuaraan karate tingkat provinsi', 'date' => now()->subDays(8), 'verified_by' => 'Guru Olahraga'],
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
