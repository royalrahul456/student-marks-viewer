import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const StudentCard({super.key, required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(student.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(student.rollNo, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('10th: ${student.tenthMarks}%'),
                  Text('12th: ${student.twelfthMarks}%'),
                  Text('S1: ${student.sem1Marks}%'),
                  Text('S2: ${student.sem2Marks}%'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
