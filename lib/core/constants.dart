class AppConstants {
  static const String appName = 'EduTrack+';
  static const String appTagline = 'Pantau Pelanggaran & Prestasi Siswa';

  // Violation Categories
  static const List<String> violationCategories = [
    'Terlambat',
    'Bolos',
    'Tidak Berseragam',
    'Berkelahi',
    'Merokok',
    'Merusak Fasilitas',
    'Bullying',
    'Membawa HP',
    'Tidak Mengerjakan Tugas',
    'Lainnya',
  ];

  // Violation Points (negative)
  static const Map<String, int> violationPoints = {
    'Terlambat': 5,
    'Bolos': 15,
    'Tidak Berseragam': 5,
    'Berkelahi': 30,
    'Merokok': 25,
    'Merusak Fasilitas': 20,
    'Bullying': 35,
    'Membawa HP': 10,
    'Tidak Mengerjakan Tugas': 5,
    'Lainnya': 5,
  };

  // Achievement Categories
  static const List<String> achievementCategories = [
    'Akademik',
    'Olahraga',
    'Seni & Budaya',
    'Sains & Teknologi',
    'Kepemimpinan',
    'Keagamaan',
    'Sosial & Kemanusiaan',
    'Lainnya',
  ];

  // Achievement Points (positive)
  static const Map<String, int> achievementPoints = {
    'Akademik': 20,
    'Olahraga': 15,
    'Seni & Budaya': 15,
    'Sains & Teknologi': 20,
    'Kepemimpinan': 15,
    'Keagamaan': 10,
    'Sosial & Kemanusiaan': 10,
    'Lainnya': 5,
  };

  // Achievement Levels
  static const List<String> achievementLevels = [
    'Sekolah',
    'Kecamatan',
    'Kabupaten/Kota',
    'Provinsi',
    'Nasional',
    'Internasional',
  ];

  // Classes
  static const List<String> classes = [
    'X-A', 'X-B', 'X-C',
    'XI-A', 'XI-B', 'XI-C',
    'XII-A', 'XII-B', 'XII-C',
  ];

  // Violation Severity
  static const Map<String, String> violationSeverity = {
    'Terlambat': 'Ringan',
    'Bolos': 'Sedang',
    'Tidak Berseragam': 'Ringan',
    'Berkelahi': 'Berat',
    'Merokok': 'Berat',
    'Merusak Fasilitas': 'Sedang',
    'Bullying': 'Berat',
    'Membawa HP': 'Ringan',
    'Tidak Mengerjakan Tugas': 'Ringan',
    'Lainnya': 'Ringan',
  };
}
