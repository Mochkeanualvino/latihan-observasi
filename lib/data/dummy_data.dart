import 'models/student.dart';
import 'models/violation.dart';
import 'models/achievement.dart';

class DummyData {
  static List<Student> getStudents() {
    return [
      Student(id: '1', name: 'Ahmad Rizky Pratama', nis: '2024001', className: 'X-A', gender: 'L', totalViolationPoints: 10, totalAchievementPoints: 20, violationCount: 2, achievementCount: 3),
      Student(id: '2', name: 'Siti Nurhaliza', nis: '2024002', className: 'X-A', gender: 'P', totalViolationPoints: 0, totalAchievementPoints: 35, violationCount: 0, achievementCount: 4),
      Student(id: '3', name: 'Budi Santoso', nis: '2024003', className: 'X-B', gender: 'L', totalViolationPoints: 25, totalAchievementPoints: 5, violationCount: 3, achievementCount: 1),
      Student(id: '4', name: 'Dewi Anggraini', nis: '2024004', className: 'X-B', gender: 'P', totalViolationPoints: 5, totalAchievementPoints: 15, violationCount: 1, achievementCount: 2),
      Student(id: '5', name: 'Fajar Nugroho', nis: '2024005', className: 'XI-A', gender: 'L', totalViolationPoints: 35, totalAchievementPoints: 0, violationCount: 4, achievementCount: 0),
      Student(id: '6', name: 'Putri Rahayu', nis: '2024006', className: 'XI-A', gender: 'P', totalViolationPoints: 0, totalAchievementPoints: 40, violationCount: 0, achievementCount: 5),
      Student(id: '7', name: 'Rendi Wijaya', nis: '2024007', className: 'XI-B', gender: 'L', totalViolationPoints: 15, totalAchievementPoints: 10, violationCount: 2, achievementCount: 2),
      Student(id: '8', name: 'Anisa Fitri', nis: '2024008', className: 'XII-A', gender: 'P', totalViolationPoints: 0, totalAchievementPoints: 50, violationCount: 0, achievementCount: 6),
      Student(id: '9', name: 'Dimas Arya', nis: '2024009', className: 'XII-A', gender: 'L', totalViolationPoints: 20, totalAchievementPoints: 25, violationCount: 3, achievementCount: 3),
      Student(id: '10', name: 'Maya Sari', nis: '2024010', className: 'XII-B', gender: 'P', totalViolationPoints: 5, totalAchievementPoints: 30, violationCount: 1, achievementCount: 4),
    ];
  }

  static List<Violation> getViolations() {
    return [
      Violation(id: 'v1', studentId: '1', studentName: 'Ahmad Rizky Pratama', className: 'X-A', category: 'Terlambat', severity: 'Ringan', points: 5, description: 'Datang terlambat 15 menit', date: DateTime.now().subtract(const Duration(days: 1)), reportedBy: 'Pak Joko'),
      Violation(id: 'v2', studentId: '1', studentName: 'Ahmad Rizky Pratama', className: 'X-A', category: 'Tidak Berseragam', severity: 'Ringan', points: 5, description: 'Tidak memakai dasi', date: DateTime.now().subtract(const Duration(days: 3)), reportedBy: 'Bu Sari'),
      Violation(id: 'v3', studentId: '3', studentName: 'Budi Santoso', className: 'X-B', category: 'Bolos', severity: 'Sedang', points: 15, description: 'Tidak masuk tanpa keterangan', date: DateTime.now().subtract(const Duration(days: 2)), reportedBy: 'Pak Ahmad'),
      Violation(id: 'v4', studentId: '3', studentName: 'Budi Santoso', className: 'X-B', category: 'Membawa HP', severity: 'Ringan', points: 10, description: 'Ketahuan bermain HP saat pelajaran', date: DateTime.now().subtract(const Duration(days: 5)), reportedBy: 'Bu Dewi'),
      Violation(id: 'v5', studentId: '5', studentName: 'Fajar Nugroho', className: 'XI-A', category: 'Berkelahi', severity: 'Berat', points: 30, description: 'Berkelahi dengan teman sekelas', date: DateTime.now().subtract(const Duration(days: 1)), reportedBy: 'Pak Budi'),
      Violation(id: 'v6', studentId: '5', studentName: 'Fajar Nugroho', className: 'XI-A', category: 'Terlambat', severity: 'Ringan', points: 5, description: 'Terlambat masuk kelas setelah istirahat', date: DateTime.now().subtract(const Duration(days: 4)), reportedBy: 'Bu Ani'),
      Violation(id: 'v7', studentId: '7', studentName: 'Rendi Wijaya', className: 'XI-B', category: 'Tidak Mengerjakan Tugas', severity: 'Ringan', points: 5, description: 'Tidak mengumpulkan PR Matematika', date: DateTime.now().subtract(const Duration(days: 2)), reportedBy: 'Pak Hasan'),
      Violation(id: 'v8', studentId: '7', studentName: 'Rendi Wijaya', className: 'XI-B', category: 'Membawa HP', severity: 'Ringan', points: 10, description: 'Bermain game saat jam pelajaran', date: DateTime.now().subtract(const Duration(days: 6)), reportedBy: 'Bu Rina'),
      Violation(id: 'v9', studentId: '9', studentName: 'Dimas Arya', className: 'XII-A', category: 'Merokok', severity: 'Berat', points: 25, description: 'Kedapatan merokok di belakang kantin', date: DateTime.now().subtract(const Duration(days: 3)), reportedBy: 'Pak Joko'),
      Violation(id: 'v10', studentId: '4', studentName: 'Dewi Anggraini', className: 'X-B', category: 'Terlambat', severity: 'Ringan', points: 5, description: 'Terlambat 10 menit', date: DateTime.now().subtract(const Duration(days: 7)), reportedBy: 'Bu Sari'),
      Violation(id: 'v11', studentId: '10', studentName: 'Maya Sari', className: 'XII-B', category: 'Tidak Berseragam', severity: 'Ringan', points: 5, description: 'Sepatu bukan warna hitam', date: DateTime.now().subtract(const Duration(days: 4)), reportedBy: 'Pak Ahmad'),
    ];
  }

  static List<Achievement> getAchievements() {
    return [
      Achievement(id: 'a1', studentId: '2', studentName: 'Siti Nurhaliza', className: 'X-A', category: 'Akademik', level: 'Kabupaten/Kota', points: 20, title: 'Juara 1 Olimpiade Matematika', description: 'Meraih juara 1 lomba olimpiade matematika tingkat kabupaten', date: DateTime.now().subtract(const Duration(days: 10)), verifiedBy: 'Kepala Sekolah'),
      Achievement(id: 'a2', studentId: '2', studentName: 'Siti Nurhaliza', className: 'X-A', category: 'Seni & Budaya', level: 'Sekolah', points: 15, title: 'Juara 1 Lomba Pidato', description: 'Meraih juara 1 lomba pidato Bahasa Indonesia', date: DateTime.now().subtract(const Duration(days: 20)), verifiedBy: 'Waka Kesiswaan'),
      Achievement(id: 'a3', studentId: '6', studentName: 'Putri Rahayu', className: 'XI-A', category: 'Akademik', level: 'Provinsi', points: 25, title: 'Juara 2 OSN Biologi', description: 'Meraih juara 2 Olimpiade Sains Nasional bidang Biologi tingkat provinsi', date: DateTime.now().subtract(const Duration(days: 15)), verifiedBy: 'Kepala Sekolah'),
      Achievement(id: 'a4', studentId: '6', studentName: 'Putri Rahayu', className: 'XI-A', category: 'Kepemimpinan', level: 'Sekolah', points: 15, title: 'Ketua OSIS', description: 'Terpilih sebagai Ketua OSIS periode 2024/2025', date: DateTime.now().subtract(const Duration(days: 30)), verifiedBy: 'Kepala Sekolah'),
      Achievement(id: 'a5', studentId: '8', studentName: 'Anisa Fitri', className: 'XII-A', category: 'Sains & Teknologi', level: 'Nasional', points: 30, title: 'Finalis Kompetisi Robotik', description: 'Lolos hingga final kompetisi robotik tingkat nasional', date: DateTime.now().subtract(const Duration(days: 5)), verifiedBy: 'Kepala Sekolah'),
      Achievement(id: 'a6', studentId: '8', studentName: 'Anisa Fitri', className: 'XII-A', category: 'Akademik', level: 'Provinsi', points: 20, title: 'Juara 1 Lomba KIR', description: 'Juara 1 Lomba Karya Ilmiah Remaja tingkat provinsi', date: DateTime.now().subtract(const Duration(days: 25)), verifiedBy: 'Waka Kesiswaan'),
      Achievement(id: 'a7', studentId: '1', studentName: 'Ahmad Rizky Pratama', className: 'X-A', category: 'Olahraga', level: 'Kabupaten/Kota', points: 15, title: 'Juara 2 Lomba Futsal', description: 'Meraih juara 2 turnamen futsal antar SMA', date: DateTime.now().subtract(const Duration(days: 12)), verifiedBy: 'Guru Olahraga'),
      Achievement(id: 'a8', studentId: '10', studentName: 'Maya Sari', className: 'XII-B', category: 'Seni & Budaya', level: 'Kecamatan', points: 10, title: 'Juara 1 Lomba Tari', description: 'Juara 1 lomba tari tradisional tingkat kecamatan', date: DateTime.now().subtract(const Duration(days: 18)), verifiedBy: 'Guru Seni'),
      Achievement(id: 'a9', studentId: '9', studentName: 'Dimas Arya', className: 'XII-A', category: 'Olahraga', level: 'Provinsi', points: 25, title: 'Juara 3 Karate', description: 'Meraih juara 3 kejuaraan karate tingkat provinsi', date: DateTime.now().subtract(const Duration(days: 8)), verifiedBy: 'Guru Olahraga'),
      Achievement(id: 'a10', studentId: '4', studentName: 'Dewi Anggraini', className: 'X-B', category: 'Keagamaan', level: 'Kecamatan', points: 10, title: 'Juara 1 MTQ', description: 'Juara 1 Musabaqah Tilawatil Quran tingkat kecamatan', date: DateTime.now().subtract(const Duration(days: 22)), verifiedBy: 'Guru Agama'),
    ];
  }
}
