import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _rollController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFaculty = false;

  void _handleLogin() {
    final id = _rollController.text.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isFaculty ? 'Enter Faculty ID' : 'Enter Student Roll Number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'role': _isFaculty ? 'faculty' : 'student',
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color navyPrimary = Color(0xFF0F1E36);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Portal Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.school, size: 64, color: navyPrimary),
            const SizedBox(height: 16),
            const Text(
              'Student Marks Viewer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Department of Robotics and Automation',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Student Login')),
                ButtonSegment(value: true, label: Text('Faculty Login')),
              ],
              selected: {_isFaculty},
              onSelectionChanged: (set) {
                setState(() => _isFaculty = set.first);
              },
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _rollController,
              decoration: InputDecoration(
                labelText: _isFaculty ? 'Faculty Email / ID' : 'Student Roll Number',
                hintText: _isFaculty ? 'v.sharma@college.edu' : 'e.g. RA-2401',
                prefixIcon: Icon(_isFaculty ? Icons.person : Icons.badge),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password / PIN',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: navyPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(_isFaculty ? 'Login as Faculty' : 'Login as Student'),
            ),
          ],
        ),
      ),
    );
  }
}
