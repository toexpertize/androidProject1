import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/course_details_page.dart';

class CourseListPage extends StatelessWidget {
  final User currentUser;
  const CourseListPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final courses = courseBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('All Courses')),
      body: courses.isEmpty
          ? const Center(child: Text('No courses available.'))
          : ListView.builder(
        itemCount: courses.length,
        itemBuilder: (_, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(course.title),
              subtitle: Text('${course.instructor} • ${course.level.name.toUpperCase()}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailsPage(course: course, currentUser: currentUser),
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