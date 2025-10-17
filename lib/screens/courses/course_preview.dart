import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/lessons/lesson_list_screen.dart';

class CoursePreview extends StatelessWidget {
  final Course course;
  final User? currentUser; // ✅ Optional user for future progress tracking

  const CoursePreview({
    super.key,
    required this.course,
    this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final lessonBox = Hive.box<Lesson>('lessons');
    final lessons = course.lessonIds
        .map((id) => lessonBox.get(id))
        .whereType<Lesson>()
        .toList();

    final completedLessons = lessons.where((l) => l.isCompleted).length;
    final progressPercent = lessons.isEmpty ? 0.0 : completedLessons / lessons.length;

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Instructor: ${course.instructor}', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Syllabus: ${course.syllabus}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text('Duration: ${course.duration}'),
            Text('Level: ${course.level.name}'),
            Text('Language: ${course.language.name}'),
            Text('Audience: ${course.audience}'),
            const SizedBox(height: 12),
            Text(course.description),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: progressPercent,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Progress: ${(progressPercent * 100).toStringAsFixed(1)}% '
                  '($completedLessons/${lessons.length} lessons)',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(course.isEnrolled ? Icons.cancel : Icons.check_circle),
              label: Text(course.isEnrolled ? 'Unenroll from Course' : 'Enroll in Course'),
              style: ElevatedButton.styleFrom(
                backgroundColor: course.isEnrolled ? Colors.redAccent : Colors.green,
              ),
              onPressed: () {
                course.isEnrolled = !course.isEnrolled;
                course.enrollmentCount += course.isEnrolled ? 1 : -1;
                course.save();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(course.isEnrolled
                        ? '✅ Enrolled successfully'
                        : '❌ Unenrolled from course'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.menu_book),
              label: const Text('View Lessons'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonListScreen(
                      courseTitle: course.title,
                      lessons: lessons,
                      currentUser: currentUser, // ✅ Pass user for tracking
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}