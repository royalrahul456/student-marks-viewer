import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;

  const StudentDetailsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final overall = student.cumulativeAverage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Academic Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(student.studentName[0])),
                title: Text(student.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Roll: ${student.rollNo} · ${student.classDivision}'),
                trailing: Text('${overall.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            _buildBar('10th Marks', student.tenthMarks),
            _buildBar('12th Marks', student.twelfthMarks),
            _buildBar('Semester 1', student.sem1Marks),
            _buildBar('Semester 2', student.sem2Marks),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String title, double score) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                Text('${score.toStringAsFixed(1)} / 100'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (score / 100.0).clamp(0.0, 1.0)),
          ],
        ),
      ),
    );
  }
}
