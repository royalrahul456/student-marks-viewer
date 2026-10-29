import 'package:flutter/material.dart';
import '../models/student.dart';

class StatisticsCard extends StatelessWidget {
  final List<Student> students;

  const StatisticsCard({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) return const SizedBox.shrink();

    final count = students.length;
    final avg10 = students.map((s) => s.tenthMarks).reduce((a, b) => a + b) / count;
    final avg12 = students.map((s) => s.twelfthMarks).reduce((a, b) => a + b) / count;
    final avgS1 = students.map((s) => s.sem1Marks).reduce((a, b) => a + b) / count;
    final avgS2 = students.map((s) => s.sem2Marks).reduce((a, b) => a + b) / count;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1E36),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text('Class Overview (${students.length} Students)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('10th: ${avg10.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white70)),
              Text('12th: ${avg12.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white70)),
              Text('Sem 1: ${avgS1.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white70)),
              Text('Sem 2: ${avgS2.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}
