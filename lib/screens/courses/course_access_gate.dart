import 'package:flutter/material.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/courses/course_preview.dart';

class CourseAccessGate extends StatelessWidget {
  final Course course;
  final User student;

  const CourseAccessGate({
    super.key,
    required this.course,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final hasAccess = !course.isPaid || course.assignedTo == student.id;

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: hasAccess
            ? CoursePreview(course: course)
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'This course requires payment to access.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment),
              label: const Text('Unlock Course'),
              onPressed: () {
                // Simulate payment success
                course.assignedTo = student.id;
                course.save();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Course unlocked')),
                );

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (_) => CoursePreview(course: course),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}