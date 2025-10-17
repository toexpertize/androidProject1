import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';

class AssignmentTrackingPage extends StatelessWidget {
  final User currentUser;
  const AssignmentTrackingPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    if (currentUser.role == UserRole.student) {
      return const Scaffold(
        body: Center(child: Text('Access denied: Students cannot view assignments')),
      );
    }

    final courseBox = Hive.box<Course>('courses');
    final userBox = Hive.box<User>('users');

    final enrolledCourses = courseBox.values
        .where((c) => c.isEnrolled && c.isActive)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Tracking')),
      body: enrolledCourses.isEmpty
          ? const Center(child: Text('No assigned courses found.'))
          : ListView.builder(
        itemCount: enrolledCourses.length,
        itemBuilder: (_, index) {
          final course = enrolledCourses[index];
          final studentNames = userBox.values
              .where((u) => u.role == UserRole.student)
              .map((u) => u.name)
              .toList();

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(course.title),
              subtitle: Text('Instructor: ${course.instructor}'),
              trailing: const Icon(Icons.assignment_turned_in),
            ),
          );
        },
      ),
    );
  }
}