import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';

class MyCourseProgressPage extends StatefulWidget {
  final User currentUser;
  const MyCourseProgressPage({super.key, required this.currentUser});

  @override
  State<MyCourseProgressPage> createState() => _MyCourseProgressPageState();
}

class _MyCourseProgressPageState extends State<MyCourseProgressPage> {
  late List<Course> enrolledCourses;

  @override
  void initState() {
    super.initState();
    final courseBox = Hive.box<Course>('courses');
    enrolledCourses = courseBox.values
        .where((c) => c.isEnrolled && c.isActive)
        .toList();
  }

  void updateProgress(Course course, double newProgress) {
    setState(() {
      course.progress = newProgress;
      course.isCompleted = newProgress >= 1.0;
      course.updatedAt = DateTime.now();
      course.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Course Progress')),
      body: enrolledCourses.isEmpty
          ? const Center(child: Text('You are not enrolled in any courses.'))
          : ListView.builder(
        itemCount: enrolledCourses.length,
        itemBuilder: (_, index) {
          final course = enrolledCourses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Instructor: ${course.instructor}'),
                  Text('Progress: ${(course.progress * 100).toStringAsFixed(1)}%'),
                  Slider(
                    value: course.progress,
                    onChanged: (value) => updateProgress(course, value),
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    label: '${(course.progress * 100).toStringAsFixed(0)}%',
                  ),
                  if (course.isCompleted)
                    const Text('✅ Completed', style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}