import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import '../widgets/statistics_card.dart';
import '../widgets/student_card.dart';
import 'student_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Student> _allStudents = [];
  List<Student> _filteredStudents = [];
  String _selectedClass = 'All Classes';
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  Future<void> _fetchRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final students = await StudentService.fetchStudents(useSampleFallback: true);
      setState(() {
        _allStudents = students;
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredStudents = _allStudents.where((student) {
        final matchesClass = _selectedClass == 'All Classes' || student.classDivision == _selectedClass;
        final matchesQuery = query.isEmpty ||
            student.studentName.toLowerCase().contains(query) ||
            student.rollNo.toLowerCase().contains(query);
        return matchesClass && matchesQuery;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Student Marks Viewer', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Text('Dept. of Robotics and Automation · Unit 6 Activity 6', style: TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchRecords,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchRecords,
        child: CustomScrollView(
          slivers: [
            if (!_isLoading && _allStudents.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: StatisticsCard(students: _filteredStudents),
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final student = _filteredStudents[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StudentCard(
                        student: student,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetailsScreen(student: student),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: _filteredStudents.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
