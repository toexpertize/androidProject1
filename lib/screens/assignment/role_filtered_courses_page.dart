import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/screens/course_details_page.dart';

class RoleFilteredCoursesPage extends StatelessWidget {
  final User currentUser;
  const RoleFilteredCoursesPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    List<Course> filteredCourses;

    if (currentUser.role == UserRole.student) {
      filteredCourses = courseBox.values
          .where((c) => c.isEnrolled && c.isActive)
          .toList();
    } else {
      filteredCourses = courseBox.values
          .where((c) => c.instructor == currentUser.name && c.isActive)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Assigned Courses')),
      body: filteredCourses.isEmpty
          ? const Center(child: Text('No courses found for your role.'))
          : ListView.builder(
        itemCount: filteredCourses.length,
        itemBuilder: (_, index) {
          final course = filteredCourses[index];
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