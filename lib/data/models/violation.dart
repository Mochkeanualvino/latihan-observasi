class Violation {
  final String id;
  final String studentId;
  final String studentName;
  final String className;
  final String category;
  final String severity;
  final int points;
  final String description;
  final DateTime date;
  final String reportedBy;

  Violation({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.className,
    required this.category,
    required this.severity,
    required this.points,
    required this.description,
    required this.date,
    required this.reportedBy,
  });

  factory Violation.fromJson(Map<String, dynamic> json) {
    return Violation(
      id: json['id'].toString(),
      studentId: json['student_id'].toString(),
      studentName: json['student_name'] ?? '',
      className: json['class_name'] ?? '',
      category: json['category'] ?? '',
      severity: json['severity'] ?? 'Ringan',
      points: json['points'] ?? 0,
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      reportedBy: json['reported_by'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': int.tryParse(studentId) ?? (studentId.startsWith('s') ? int.tryParse(studentId.substring(1)) : 0),
      'category': category,
      'severity': severity,
      'points': points,
      'description': description,
      'date': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      'reported_by': reportedBy,
    };
  }
}
