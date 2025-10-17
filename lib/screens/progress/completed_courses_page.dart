import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/course_details_page.dart';

class CompletedCoursesPage extends StatelessWidget {
  final User currentUser;
  const CompletedCoursesPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final completedCourses = courseBox.values
        .where((c) => c.isCompleted && c.isEnrolled && c.isActive)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Completed Courses')),
      body: completedCourses.isEmpty
          ? const Center(child: Text('You haven’t completed any courses yet.'))
          : ListView.builder(
        itemCount: completedCourses.length,
        itemBuilder: (_, index) {
          final course = completedCourses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(course.title),
              subtitle: Text('Instructor: ${course.instructor}'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailsPage(
                      course: course,
                      currentUser: currentUser,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}