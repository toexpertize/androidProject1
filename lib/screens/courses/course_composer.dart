import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/models/user.dart';

class CourseComposer extends StatefulWidget {
  final User teacher;

  const CourseComposer({super.key, required this.teacher});

  @override
  State<CourseComposer> createState() => _CourseComposerState();
}

class _CourseComposerState extends State<CourseComposer> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _syllabusController = TextEditingController();
  CourseLevel _selectedLevel = CourseLevel.beginner;
  CourseLanguage _selectedLanguage = CourseLanguage.en;
  final String _assignedStudentId = 'student-id'; // Default for demo

  void saveCourse() {
    if (_formKey.currentState!.validate()) {
      final courseBox = Hive.box<Course>('courses');
      final newCourse = Course(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        instructor: widget.teacher.name,
        instructorId: widget.teacher.id,
        description: _descController.text,
        syllabus: _syllabusController.text,
        level: _selectedLevel,
        language: _selectedLanguage,
        progress: 0.0,
        tags: [],
        categoryIds: [],
        lessonIds: [],
        isPublished: true,
        isArchived: false,
        ratingAverage: 0.0,
        ratingCount: 0,
        enrollmentCount: 0,
        metadata: {},
        remoteId: null,
        dirty: false,
        isFavorite: false,
        isCompleted: false,
        isEnrolled: true,
        isPaid: false,
        isActive: true,
        duration: '2 weeks',
        audience: 'General',
        assignedTo: _assignedStudentId,
      );

      courseBox.put(newCourse.id, newCourse);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Course created successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compose Course')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Course Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _syllabusController,
                decoration: const InputDecoration(labelText: 'Syllabus'),
                maxLines: 2,
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CourseLevel>(
                initialValue: _selectedLevel,
                items: CourseLevel.values
                    .map((level) => DropdownMenuItem(
                  value: level,
                  child: Text(level.name),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedLevel = val!),
                decoration: const InputDecoration(labelText: 'Level'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CourseLanguage>(
                initialValue: _selectedLanguage,
                items: CourseLanguage.values
                    .map((lang) => DropdownMenuItem(
                  value: lang,
                  child: Text(lang.name),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedLanguage = val!),
                decoration: const InputDecoration(labelText: 'Language'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Course'),
                onPressed: saveCourse,
              ),
            ],
          ),
        ),
      ),
    );
  }
}