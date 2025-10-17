import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/models/user.dart';

class CourseCreationPage extends StatefulWidget {
  final User currentUser;
  const CourseCreationPage({super.key, required this.currentUser});

  @override
  State<CourseCreationPage> createState() => _CourseCreationPageState();
}

class _CourseCreationPageState extends State<CourseCreationPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _syllabusController = TextEditingController();
  final _durationController = TextEditingController();
  final _audienceController = TextEditingController();
  CourseLevel _selectedLevel = CourseLevel.beginner;
  CourseLanguage _selectedLanguage = CourseLanguage.ar;

  void handleCreateCourse() {
    if (widget.currentUser.role == UserRole.student) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Students cannot create courses')),
      );
      return;
    }

    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final syllabus = _syllabusController.text.trim();
    final duration = _durationController.text.trim();
    final audience = _audienceController.text.trim();

    if (title.isEmpty || desc.isEmpty || syllabus.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final courseBox = Hive.box<Course>('courses');
    final newCourse = Course(
      id: const Uuid().v4(),
      title: title,
      instructor: widget.currentUser.name,
      description: desc,
      syllabus: syllabus,
      level: _selectedLevel,
      language: _selectedLanguage,
      duration: duration,
      audience: audience,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPublished: false,
      isArchived: false,
      isActive: true,
      ratingAverage: 0.0,
      ratingCount: 0,
      enrollmentCount: 0,
      tags: [],
      categoryIds: [],
      lessonIds: [],
      metadata: {},
    );

    courseBox.add(newCourse);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Course created successfully')),
    );

    _titleController.clear();
    _descController.clear();
    _syllabusController.clear();
    _durationController.clear();
    _audienceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Course')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Course Title'),
              ),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _syllabusController,
                decoration: const InputDecoration(labelText: 'Syllabus'),
              ),
              DropdownButton<CourseLevel>(
                value: _selectedLevel,
                onChanged: (level) {
                  if (level != null) setState(() => _selectedLevel = level);
                },
                items: CourseLevel.values.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level.name.toUpperCase()),
                  );
                }).toList(),
              ),
              DropdownButton<CourseLanguage>(
                value: _selectedLanguage,
                onChanged: (lang) {
                  if (lang != null) setState(() => _selectedLanguage = lang);
                },
                items: CourseLanguage.values.map((lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Text(lang.name.toUpperCase()),
                  );
                }).toList(),
              ),
              TextField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              TextField(
                controller: _audienceController,
                decoration: const InputDecoration(labelText: 'Audience'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: handleCreateCourse,
                child: const Text('Create Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}