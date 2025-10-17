import 'package:flutter/material.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/models/user.dart';

class LessonViewer extends StatefulWidget {
  final List<Lesson> lessons;
  final int initialIndex;
  final User? currentUser;

  const LessonViewer({
    super.key,
    required this.lessons,
    required this.initialIndex,
    this.currentUser,
  });

  @override
  State<LessonViewer> createState() => _LessonViewerState();
}

class _LessonViewerState extends State<LessonViewer> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _toggleCompletion() {
    final lesson = widget.lessons[_currentIndex];
    final user = widget.currentUser;

    if (user == null) return;

    setState(() {
      if (user.completedLessonIds.contains(lesson.id)) {
        user.completedLessonIds.remove(lesson.id);
      } else {
        user.completedLessonIds.add(lesson.id);
      }
    });

    user.save();
  }

  void _goToLesson(int index) {
    if (index >= 0 && index < widget.lessons.length) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lessons[_currentIndex];
    final isCompleted = widget.currentUser?.completedLessonIds.contains(lesson.id) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson ${_currentIndex + 1}/${widget.lessons.length}'),
        actions: [
          IconButton(
            icon: Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
            tooltip: isCompleted ? 'Mark as Incomplete' : 'Mark as Complete',
            onPressed: _toggleCompletion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lesson.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('${lesson.duration ?? 'Unknown duration'} • ${lesson.format.name}'),
            const SizedBox(height: 16),
            Expanded(
              child: lesson.format == ContentFormat.text
                  ? SingleChildScrollView(child: Text(lesson.content))
                  : Column(
                children: [
                  const Text('Video Lesson', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  if (lesson.videoUrl != null)
                    Text('📺 Video URL:\n${lesson.videoUrl}', style: const TextStyle(color: Colors.blue))
                  else
                    const Text('No video URL provided'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  onPressed: _currentIndex > 0 ? () => _goToLesson(_currentIndex - 1) : null,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  onPressed: _currentIndex < widget.lessons.length - 1
                      ? () => _goToLesson(_currentIndex + 1)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}