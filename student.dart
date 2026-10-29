class Student {
  final dynamic srNo;
  final String rollNo;
  final String studentName;
  final double tenthMarks;
  final double twelfthMarks;
  final double sem1Marks;
  final double sem2Marks;
  final String classDivision;

  const Student({
    required this.srNo,
    required this.rollNo,
    required this.studentName,
    required this.tenthMarks,
    required this.twelfthMarks,
    required this.sem1Marks,
    required this.sem2Marks,
    this.classDivision = 'SE - Div A',
  });

  factory Student.fromJson(Map<String, dynamic> json, [int fallbackIndex = 1]) {
    double parseMarks(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        final cleaned = value.replaceAll('%', '').trim();
        return double.tryParse(cleaned) ?? 0.0;
      }
      return 0.0;
    }

    return Student(
      srNo: json['Sr No'] ?? json['srNo'] ?? json['sr_no'] ?? fallbackIndex,
      rollNo: (json['Roll No'] ?? json['rollNo'] ?? json['roll_no'] ?? 'N/A').toString().trim(),
      studentName: (json['Student Name'] ?? json['studentName'] ?? json['name'] ?? 'Unnamed Student').toString().trim(),
      tenthMarks: parseMarks(json['10th'] ?? json['tenth'] ?? json['tenthMarks']),
      twelfthMarks: parseMarks(json['12th'] ?? json['twelfth'] ?? json['twelfthMarks']),
      sem1Marks: parseMarks(json['Sem 1'] ?? json['sem1'] ?? json['sem1Marks']),
      sem2Marks: parseMarks(json['Sem 2'] ?? json['sem2'] ?? json['sem2Marks']),
      classDivision: (json['Class'] ?? json['class'] ?? json['Division'] ?? 'SE - Div A').toString().trim(),
    );
  }

  double get cumulativeAverage =>
      (tenthMarks + twelfthMarks + sem1Marks + sem2Marks) / 4.0;

  String get gradeClassification {
    final avg = cumulativeAverage;
    if (avg >= 75.0) return 'Distinction';
    if (avg >= 60.0) return 'First Class';
    if (avg >= 50.0) return 'Second Class';
    if (avg >= 40.0) return 'Pass Class';
    return 'Needs Improvement';
  }
}
