import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/screens/lessons/lesson_editor.dart';

class LessonEditorLauncher extends StatelessWidget {
  const LessonEditorLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final courses = courseBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Course')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: courses.isEmpty
            ? const Center(child: Text('No courses available'))
            : ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(course.title),
                subtitle: Text('Instructor: ${course.instructor}'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LessonEditor(courseId: course.id),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}