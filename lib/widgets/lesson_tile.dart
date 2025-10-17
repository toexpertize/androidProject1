// lib/widgets/lesson_tile.dart

import 'package:flutter/material.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/screens/lesson_page.dart'; // Ensure this import is correct, LessonPage is in 'screens'

class LessonTile extends StatelessWidget {
  final String courseId; // The ID of the parent course
  final Lesson lesson; // The lesson object to display

  const LessonTile({
    super.key,
    required this.courseId, // We need the courseId to pass to LessonPage
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Added horizontal margin for better spacing
      elevation: 2, // A subtle shadow for the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Slightly rounded corners
      child: ListTile(
        // Leading icon to indicate completion status
        leading: Icon(
          lesson.isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: lesson.isCompleted ? Colors.green : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          size: 28, // Slightly larger icon
        ),
        // Lesson title
        title: Text(
          lesson.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        // Lesson content snippet as subtitle
        subtitle: Text(
          lesson.content.length > 70 // Show a bit more content in the subtitle
              ? '${lesson.content.substring(0, 70)}...'
              : lesson.content,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          maxLines: 2, // Allow subtitle to span two lines
          overflow: TextOverflow.ellipsis,
        ),
        // Trailing icon if there's video content
        trailing: lesson.videoUrl != null && lesson.videoUrl!.isNotEmpty
            ? Icon(Icons.play_circle_fill, color: Theme.of(context).primaryColor, size: 28)
            : null,
        // Action when the tile is tapped
        onTap: () {
          // Navigate to the LessonPage, passing both courseId and the lesson object
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonPage(
                courseId: courseId, // Pass the courseId to LessonPage
                lesson: lesson,     // Pass the specific lesson object
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding
      ),
    );
  }
}