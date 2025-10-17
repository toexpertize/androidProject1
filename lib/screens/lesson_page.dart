// lib/screens/lesson_page.dart

import 'package:flutter/material.dart';
import 'package:lmsalfa/models/lesson.dart';
// If you plan to update completion status via a service, you'd import it here:
// import 'package:lms_pro/services/course_service.dart';

class LessonPage extends StatefulWidget {
  final String courseId; // Added: The ID of the parent course
  final Lesson lesson;

  const LessonPage({
    super.key,
    required this.courseId, // Added: Make courseId required
    required this.lesson,
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  // In a real app, you might manage lesson completion here
  bool _isCompleted = false;
  // final CourseService _courseService = CourseService(); // Uncomment if using service

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.lesson.isCompleted;
  }

  Future<void> _toggleCompletion() async {
    setState(() {
      _isCompleted = !_isCompleted;
      // In a real app, you would update the lesson completion status
      // via a service call here and potentially update the parent Course.
      // Example (requires CourseService import and logic):
      /*
      try {
        final updatedLesson = widget.lesson.copyWith(isCompleted: _isCompleted);
        await _courseService.updateLessonCompletion(widget.courseId, updatedLesson);
        // If successful, you might want to pop with a result or refresh parent
      } catch (e) {
        print('Error updating lesson completion: $e');
        setState(() {
          _isCompleted = !_isCompleted; // Revert on error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update lesson completion: $e')),
        );
      }
      */
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Lesson "${widget.lesson.title}" marked as ${_isCompleted ? 'completed' : 'incomplete'}'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: [
          IconButton(
            icon: Icon(
              _isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: _isCompleted ? Colors.green : Colors.grey,
            ),
            onPressed: _toggleCompletion,
            tooltip: _isCompleted ? 'Mark as Incomplete' : 'Mark as Complete',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.lesson.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.lesson.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            if (widget.lesson.videoUrl != null && widget.lesson.videoUrl!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Video Content:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Placeholder for video player. In a real app, you'd integrate
                  // a video player package like `video_player` or `chewie`.
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
                          const SizedBox(height: 8),
                          Text(
                            'Play Video: ${widget.lesson.videoUrl}',
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            '(Video player integration needed)',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.lesson.videoUrl == null || widget.lesson.videoUrl!.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'No video content available for this lesson.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _toggleCompletion,
                icon: Icon(_isCompleted ? Icons.undo : Icons.check),
                label: Text(_isCompleted ? 'Mark as Incomplete' : 'Mark as Complete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isCompleted ? Colors.orange : Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}