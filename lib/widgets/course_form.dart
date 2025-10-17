import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';

class CourseForm extends StatefulWidget {
  final void Function(Course course)? onSaved;

  const CourseForm({super.key, this.onSaved});

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructorController = TextEditingController();
  final _syllabusController = TextEditingController();
  final _durationController = TextEditingController();
  final _audienceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  CourseLevel selectedLevel = CourseLevel.beginner;
  CourseLanguage selectedLanguage = CourseLanguage.ar;
  bool isPaid = false;
  bool isActive = true;

  void saveCourse() {
    if (_formKey.currentState!.validate()) {
      final course = Course(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        instructor: _instructorController.text.trim(),
        syllabus: _syllabusController.text.trim(),
        level: selectedLevel,
        language: selectedLanguage,
        duration: _durationController.text.trim(),
        audience: _audienceController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        progress: 0.0,
        isCompleted: false,
        isEnrolled: false,
        isPaid: isPaid,
        isActive: isActive,
        tags: [],
        categoryIds: [],
        lessonIds: [],
      );

      Hive.box<Course>('courses').put(course.id, course);
      widget.onSaved?.call(course);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course saved successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Course Title'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _instructorController,
            decoration: const InputDecoration(labelText: 'Instructor'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _syllabusController,
            decoration: const InputDecoration(labelText: 'Syllabus'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _durationController,
            decoration: const InputDecoration(labelText: 'Duration'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _audienceController,
            decoration: const InputDecoration(labelText: 'Target Audience'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _imageUrlController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<CourseLevel>(
            initialValue: selectedLevel,
            decoration: const InputDecoration(labelText: 'Course Level'),
            onChanged: (val) => setState(() => selectedLevel = val!),
            items: CourseLevel.values.map((level) {
              return DropdownMenuItem(
                value: level,
                child: Text(level.name.toUpperCase()),
              );
            }).toList(),
          ),
          DropdownButtonFormField<CourseLanguage>(
            initialValue: selectedLanguage,
            decoration: const InputDecoration(labelText: 'Course Language'),
            onChanged: (val) => setState(() => selectedLanguage = val!),
            items: CourseLanguage.values.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang.name.toUpperCase()),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('Course Type'),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: isPaid,
                onChanged: (value) => setState(() => isPaid = value!),
              ),
              const Text('Paid'),
              Radio<bool>(
                value: false,
                groupValue: isPaid,
                onChanged: (value) => setState(() => isPaid = value!),
              ),
              const Text('Free'),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Course Status'),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: isActive,
                onChanged: (value) => setState(() => isActive = value!),
              ),
              const Text('Active'),
              Radio<bool>(
                value: false,
                groupValue: isActive,
                onChanged: (value) => setState(() => isActive = value!),
              ),
              const Text('Inactive'),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: saveCourse,
            icon: const Icon(Icons.save),
            label: const Text('Save Course'),
          ),
        ],
      ),
    );
  }
}