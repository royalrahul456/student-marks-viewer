import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class StudentService {
  static const String _configuredGoogleAppsScriptUrl =
      'YOUR_GOOGLE_APPS_SCRIPT_WEB_APP_URL_HERE';

  static const Duration _timeoutDuration = Duration(seconds: 12);

  static bool get isApiConfigured =>
      _configuredGoogleAppsScriptUrl.isNotEmpty &&
      _configuredGoogleAppsScriptUrl != 'YOUR_GOOGLE_APPS_SCRIPT_WEB_APP_URL_HERE' &&
      _configuredGoogleAppsScriptUrl.startsWith('https://script.google.com/');

  static Future<List<Student>> fetchStudents({
    String? customUrl,
    bool useSampleFallback = false,
  }) async {
    final targetUrl = (customUrl != null && customUrl.isNotEmpty)
        ? customUrl
        : _configuredGoogleAppsScriptUrl;

    if (targetUrl == 'YOUR_GOOGLE_APPS_SCRIPT_WEB_APP_URL_HERE' || targetUrl.isEmpty) {
      if (useSampleFallback) {
        await Future.delayed(const Duration(milliseconds: 600));
        return getSampleStudents();
      }
      throw const FormatException(
        'Google Apps Script Web App URL is not configured.',
      );
    }

    try {
      final uri = Uri.parse(targetUrl);
      final response = await http.get(uri).timeout(_timeoutDuration);

      if (response.statusCode == 200 || response.statusCode == 302) {
        final decoded = json.decode(response.body);
        List<dynamic> rows = [];
        if (decoded is List) {
          rows = decoded;
        } else if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          rows = decoded['data'];
        }

        return rows.map((item) => Student.fromJson(item)).toList();
      } else {
        throw HttpException('HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static List<Student> getSampleStudents() {
    return const [
      Student(srNo: 1, rollNo: "RA-2401", studentName: "Aarav Sharma", tenthMarks: 88.5, twelfthMarks: 84.0, sem1Marks: 78.2, sem2Marks: 82.5, classDivision: "SE - Div A"),
      Student(srNo: 2, rollNo: "RA-2402", studentName: "Ananya Deshmukh", tenthMarks: 94.2, twelfthMarks: 91.5, sem1Marks: 88.4, sem2Marks: 92.8, classDivision: "SE - Div A"),
      Student(srNo: 3, rollNo: "RA-2403", studentName: "Rohan Kulkarni", tenthMarks: 81.0, twelfthMarks: 79.4, sem1Marks: 73.0, sem2Marks: 76.8, classDivision: "SE - Div A"),
      Student(srNo: 4, rollNo: "RA-2404", studentName: "Priya Nair", tenthMarks: 92.0, twelfthMarks: 89.2, sem1Marks: 85.5, sem2Marks: 87.0, classDivision: "SE - Div A"),
      Student(srNo: 11, rollNo: "RB-2401", studentName: "Aditya Choudhary", tenthMarks: 86.0, twelfthMarks: 82.5, sem1Marks: 79.0, sem2Marks: 81.5, classDivision: "SE - Div B"),
    ];
  }
}
