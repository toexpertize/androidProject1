import 'package:flutter/material.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';

class CourseDetailsPage extends StatelessWidget {
  final Course course;
  final User currentUser;

  const CourseDetailsPage({
    super.key,
    required this.course,
    required this.currentUser,
  });

  void enrollStudent(BuildContext context) {
    if (currentUser.role != UserRole.student) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only students can enroll in courses')),
      );
      return;
    }

    course.isEnrolled = true;
    course.enrollmentCount += 1;
    course.lastAccessedAt = DateTime.now();
    course.save();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enrolled successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(course.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Instructor: ${course.instructor}'),
            Text('Level: ${course.level.name.toUpperCase()}'),
            Text('Language: ${course.language.name.toUpperCase()}'),
            Text('Duration: ${course.duration}'),
            Text('Audience: ${course.audience}'),
            const SizedBox(height: 16),
            Text('Description:', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(course.description),
            const SizedBox(height: 16),
            Text('Syllabus:', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(course.syllabus),
            const SizedBox(height: 24),
            if (currentUser.role == UserRole.student && !course.isEnrolled)
              ElevatedButton(
                onPressed: () => enrollStudent(context),
                child: const Text('Enroll in this course'),
              ),
            if (course.isEnrolled)
              const Text('✅ You are enrolled in this course', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}