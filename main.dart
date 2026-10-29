import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const StudentMarksViewerApp());
}

class StudentMarksViewerApp extends StatefulWidget {
  const StudentMarksViewerApp({super.key});

  @override
  State<StudentMarksViewerApp> createState() => _StudentMarksViewerAppState();
}

class _StudentMarksViewerAppState extends State<StudentMarksViewerApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color navyPrimary = Color(0xFF0F1E36);
    const Color navySecondary = Color(0xFF1E3A8A);
    const Color lightBlueAccent = Color(0xFF38BDF8);

    return MaterialApp(
      title: 'Student Marks Viewer',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: navyPrimary,
          primary: navyPrimary,
          secondary: navySecondary,
          tertiary: lightBlueAccent,
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navyPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B132B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: navyPrimary,
          brightness: Brightness.dark,
          surface: const Color(0xFF1C2541),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F1E36),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: HomeScreen(onToggleTheme: toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
