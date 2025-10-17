import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/enums.dart';

class LessonEditor extends StatefulWidget {
  final String courseId;

  const LessonEditor({super.key, required this.courseId});

  @override
  State<LessonEditor> createState() => _LessonEditorState();
}

class _LessonEditorState extends State<LessonEditor> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _videoUrlController = TextEditingController();
  final _durationController = TextEditingController();
  final _attachmentUrlController = TextEditingController();

  ContentFormat _selectedFormat = ContentFormat.text;

  void _saveLesson() {
    if (_formKey.currentState!.validate()) {
      final lessonBox = Hive.box<Lesson>('lessons');
      final newLesson = Lesson(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        videoUrl: _videoUrlController.text.trim().isEmpty
            ? null
            : _videoUrlController.text.trim(),
        format: _selectedFormat,
        courseId: widget.courseId,
        createdAt: DateTime.now(),
        duration: _durationController.text.trim().isEmpty
            ? null
            : _durationController.text.trim(),
        attachmentUrl: _attachmentUrlController.text.trim().isEmpty
            ? null
            : _attachmentUrlController.text.trim(),
      );

      lessonBox.put(newLesson.id, newLesson);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Lesson saved successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Lesson')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Lesson Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ContentFormat>(
                initialValue: _selectedFormat,
                decoration: const InputDecoration(labelText: 'Format'),
                items: ContentFormat.values.map((format) {
                  return DropdownMenuItem(
                    value: format,
                    child: Text(format.name),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedFormat = val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 4,
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _videoUrlController,
                decoration: const InputDecoration(labelText: 'Video URL'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration (e.g. 5 min)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _attachmentUrlController,
                decoration: const InputDecoration(labelText: 'Attachment URL'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Lesson'),
                onPressed: _saveLesson,
              ),
            ],
          ),
        ),
      ),
    );
  }
}