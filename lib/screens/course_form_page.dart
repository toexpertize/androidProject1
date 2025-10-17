import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';

class CourseFormPage extends StatefulWidget {
  const CourseFormPage({super.key});

  @override
  State<CourseFormPage> createState() => _CourseFormPageState();
}

class _CourseFormPageState extends State<CourseFormPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final syllabusController = TextEditingController();
  final imageUrlController = TextEditingController();
  final durationController = TextEditingController();
  final audienceController = TextEditingController();

  CourseLevel selectedLevel = CourseLevel.beginner;
  CourseLanguage selectedLanguage = CourseLanguage.ar;
  bool isPaid = false;
  bool isActive = true;
  String selectedInstructor = 'Instructor A';

  void saveCourse() {
    final courseBox = Hive.box<Course>('courses');
    final newCourse = Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      instructor: selectedInstructor,
      description: descriptionController.text.trim(),
      syllabus: syllabusController.text.trim(),
      level: selectedLevel,
      language: selectedLanguage,
      imageUrl: imageUrlController.text.trim(),
      duration: durationController.text.trim(),
      audience: audienceController.text.trim(),
      isPaid: isPaid,
      isActive: isActive,
      isCompleted: false,
      isEnrolled: false,
      tags: [],
      categoryIds: [],
      lessonIds: [],
    );
    courseBox.add(newCourse);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Course')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            TextField(controller: syllabusController, decoration: const InputDecoration(labelText: 'Syllabus')),
            TextField(controller: imageUrlController, decoration: const InputDecoration(labelText: 'Image URL')),
            TextField(controller: durationController, decoration: const InputDecoration(labelText: 'Duration')),
            TextField(controller: audienceController, decoration: const InputDecoration(labelText: 'Audience')),

            const SizedBox(height: 12),
            DropdownButton<CourseLevel>(
              value: selectedLevel,
              onChanged: (val) => setState(() => selectedLevel = val!),
              items: CourseLevel.values.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level.name.toUpperCase()),
                );
              }).toList(),
            ),
            DropdownButton<CourseLanguage>(
              value: selectedLanguage,
              onChanged: (val) => setState(() => selectedLanguage = val!),
              items: CourseLanguage.values.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang.name.toUpperCase()),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Paid Course'),
              value: isPaid,
              onChanged: (val) => setState(() => isPaid = val),
            ),
            SwitchListTile(
              title: const Text('Active Course'),
              value: isActive,
              onChanged: (val) => setState(() => isActive = val),
            ),

            const SizedBox(height: 24),
            ElevatedButton(onPressed: saveCourse, child: const Text('Save Course')),
          ],
        ),
      ),
    );
  }
}