import 'package:flutter/material.dart';
import 'package:lmsalfa/widgets/course_form.dart';

class CreateCoursePage extends StatelessWidget {
  const CreateCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Course')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: CourseForm(
          onSaved: (course) {
            Navigator.of(context).pop(); // Or refresh course list
          },
        ),
      ),
    );
  }
}