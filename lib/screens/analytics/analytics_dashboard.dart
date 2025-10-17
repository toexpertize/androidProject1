import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/lesson.dart';

class AnalyticsDashboard extends StatelessWidget {
  final String studentId;

  const AnalyticsDashboard({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final lessonBox = Hive.box<Lesson>('lessons');

    final enrolledCourses = courseBox.values
        .where((c) => c.assignedTo == studentId && c.isEnrolled)
        .toList();

    final totalCourses = enrolledCourses.length;
    final completedCourses = enrolledCourses.where((c) => c.isCompleted).length;
    final averageProgress = totalCourses == 0
        ? 0.0
        : enrolledCourses.map((c) => c.progress).reduce((a, b) => a + b) / totalCourses;

    final allLessons = lessonBox.values
        .where((l) => enrolledCourses.any((c) => c.id == l.courseId))
        .toList();

    final completedLessons = allLessons.where((l) => l.isCompleted).length;
    final totalLessons = allLessons.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Your Learning Stats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _statTile('Courses Enrolled', totalCourses.toString(), Icons.school),
            _statTile('Courses Completed', completedCourses.toString(), Icons.check_circle),
            _statTile('Average Progress', '${(averageProgress * 100).toStringAsFixed(1)}%', Icons.bar_chart),
            const Divider(height: 32),
            _statTile('Lessons Viewed', completedLessons.toString(), Icons.visibility),
            _statTile('Total Lessons', totalLessons.toString(), Icons.menu_book),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: averageProgress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Overall Progress: ${(averageProgress * 100).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statTile(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      trailing: Text(value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}