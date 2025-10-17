import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/models/course.dart';

import 'dashboards/admin_dashboard.dart';
import 'dashboards/teacher_dashboard.dart';
import 'dashboards/student_dashboard.dart';
import 'course_catalog_page.dart';
import 'shared/course_creation_page.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser;

  const HomeScreen({super.key, required this.currentUser});

  void navigateToDashboard(BuildContext context) {
    Widget dashboard;

    switch (currentUser.role) {
      case UserRole.admin:
        dashboard = AdminDashboard(user: currentUser);
        break;
      case UserRole.teacher:
        dashboard = TeacherDashboard(user: currentUser);
        break;
      case UserRole.student:
        final courseBox = Hive.box<Course>('courses');
        final enrolledCourses = courseBox.values
            .where((c) => c.assignedTo == currentUser.id)
            .toList();

        dashboard = StudentDashboard(
          studentName: currentUser.name,
          courses: enrolledCourses,
          currentUser: currentUser,
        );
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => dashboard),
    );
  }

  void navigateToCourseCatalog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseCatalogPage(currentUser: currentUser),
      ),
    );
  }

  void navigateToCourseCreation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseCreationPage(currentUser: currentUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome ${currentUser.name}', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => navigateToDashboard(context),
              child: const Text('Go to Dashboard'),
            ),
            ElevatedButton(
              onPressed: () => navigateToCourseCatalog(context),
              child: const Text('Browse Courses'),
            ),
            if (currentUser.role != UserRole.student)
              ElevatedButton(
                onPressed: () => navigateToCourseCreation(context),
                child: const Text('Create Course'),
              ),
          ],
        ),
      ),
    );
  }
}