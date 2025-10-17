import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/user.dart';

class LessonComposer extends StatefulWidget {
  final User teacher;
  const LessonComposer({super.key, required this.teacher});

  @override
  State<LessonComposer> createState() => _LessonComposerState();
}

class _LessonComposerState extends State<LessonComposer> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  ContentFormat _selectedFormat = ContentFormat.text;
  String? _selectedCourseId;
  String? _message;

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final lessonBox = Hive.box<Lesson>('lessons');

    final teacherCourses = courseBox.values
        .where((c) => c.instructorId == widget.teacher.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Compose Lesson')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Lesson Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Lesson Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ContentFormat>(
              initialValue: _selectedFormat,
              items: ContentFormat.values.map((format) {
                return DropdownMenuItem(
                  value: format,
                  child: Text(format.name),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedFormat = val!),
              decoration: const InputDecoration(labelText: 'Format'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedCourseId,
              items: teacherCourses.map((course) {
                return DropdownMenuItem(
                  value: course.id,
                  child: Text(course.title),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedCourseId = val),
              decoration: const InputDecoration(labelText: 'Assign to Course'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim();
                final content = _contentController.text.trim();

                if (title.isEmpty || content.isEmpty || _selectedCourseId == null) {
                  setState(() => _message = 'Please fill all fields');
                  return;
                }

                final newLesson = Lesson(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  content: content,
                  format: _selectedFormat,
                  courseId: _selectedCourseId!,
                  createdAt: DateTime.now(),
                );

                await lessonBox.put(newLesson.id, newLesson);

                final course = courseBox.get(_selectedCourseId!);
                if (course != null) {
                  course.lessonIds.add(newLesson.id);
                  course.save();
                }

                setState(() {
                  _message = '✅ Lesson saved';
                  _titleController.clear();
                  _contentController.clear();
                  _selectedCourseId = null;
                });
              },
              child: const Text('Save Lesson'),
            ),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(_message!, style: const TextStyle(color: Colors.green)),
              ),
          ],
        ),
      ),
    );
  }
}