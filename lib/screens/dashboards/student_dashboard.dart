import 'package:flutter/material.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';

class StudentDashboard extends StatefulWidget {
  final String studentName;
  final List<Course> courses;
  final User currentUser;

  const StudentDashboard({
    super.key,
    required this.studentName,
    required this.courses,
    required this.currentUser,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final _searchController = TextEditingController();
  String _filter = 'All';
  List<Course> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _applyFilters();
    _searchController.addListener(_applyFilters);
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    final filtered = widget.courses.where((course) {
      final matchesQuery = course.title.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query);
      final matchesStatus = _filter == 'All' ||
          (_filter == 'Completed' && course.isCompleted);
      return matchesQuery && matchesStatus;
    }).toList();

    setState(() {
      _filteredCourses = filtered;
    });
  }

  void _setFilter(String label) {
    setState(() {
      _filter = label;
    });
    _applyFilters();
  }

  void _openNotifications() {
    Navigator.pushNamed(context, '/notifications');
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final totalCourses = widget.courses.length;
    final completedCourses = widget.courses.where((c) => c.isCompleted).length;

    final totalLessons = widget.courses.fold<double>(
      0.0,
          (sum, c) => sum + c.lessonIds.length.toDouble(),
    );

    final completedLessons = widget.courses.fold<double>(
      0.0,
          (sum, c) => sum + c.completedLessonCount,
    );

    final progress = totalLessons == 0 ? 0.0 : (completedLessons / totalLessons) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/notification.png',
              width: 24,
              height: 24,
              errorBuilder: (_, __, ___) => const Icon(Icons.notifications),
            ),
            tooltip: 'Notifications',
            onPressed: _openNotifications,
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/logout.png',
              width: 24,
              height: 24,
              errorBuilder: (_, __, ___) => const Icon(Icons.logout),
            ),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${widget.studentName}', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatBlock('Courses', totalCourses, Colors.blue),
                const SizedBox(width: 12),
                _buildStatBlock('Completed', completedCourses, Colors.green),
                const SizedBox(width: 12),
                Expanded(child: _buildProgressBlock(progress)),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Course List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by title or instructor',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildFilterButton('All'),
                _buildFilterButton('Completed'),
              ],
            ),
            const SizedBox(height: 16),
            _filteredCourses.isEmpty
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('No courses found.', style: TextStyle(color: Colors.grey)),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredCourses.length,
              itemBuilder: (_, index) {
                final course = _filteredCourses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(course.title),
                    subtitle: Text('Instructor: ${course.instructor}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/course-details', arguments: course);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBlock(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text('$label: $value', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProgressBlock(double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress: ${progress.toStringAsFixed(1)}%'),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = _filter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () => _setFilter(label),
        child: Text(label),
      ),
    );
  }
}