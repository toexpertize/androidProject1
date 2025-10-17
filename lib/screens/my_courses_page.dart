import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/course_details_page.dart';

class MyCoursesPage extends StatelessWidget {
  final User currentUser;
  const MyCoursesPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final enrolledCourses = courseBox.values
        .where((course) => course.isEnrolled && course.isActive)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('My Courses')),
      body: enrolledCourses.isEmpty
          ? const Center(child: Text('You are not enrolled in any courses.'))
          : ListView.builder(
        itemCount: enrolledCourses.length,
        itemBuilder: (_, index) {
          final course = enrolledCourses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(course.title),
              subtitle: Text('${course.instructor} • Progress: ${(course.progress * 100).toStringAsFixed(1)}%'),
              trailing: const Icon(Icons.arrow_forward_ios),
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