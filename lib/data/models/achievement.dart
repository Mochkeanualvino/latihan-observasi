class Achievement {
  final String id;
  final String studentId;
  final String studentName;
  final String className;
  final String category;
  final String level;
  final int points;
  final String title;
  final String description;
  final DateTime date;
  final String verifiedBy;

  Achievement({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.className,
    required this.category,
    required this.level,
    required this.points,
    required this.title,
    required this.description,
    required this.date,
    required this.verifiedBy,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'].toString(),
      studentId: json['student_id'].toString(),
      studentName: json['student_name'] ?? '',
      className: json['class_name'] ?? '',
      category: json['category'] ?? '',
      level: json['level'] ?? '',
      points: json['points'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      verifiedBy: json['verified_by'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': int.tryParse(studentId) ?? (studentId.startsWith('s') ? int.tryParse(studentId.substring(1)) : 0),
      'category': category,
      'level': level,
      'points': points,
      'title': title,
      'description': description,
      'date': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      'verified_by': verifiedBy,
    };
  }
}
