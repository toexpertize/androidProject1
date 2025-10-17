import 'package:flutter/material.dart';
import 'package:lmsalfa/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Safe image check
              if (course.imageUrl != null && course.imageUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    course.imageUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
              if (course.imageUrl != null && course.imageUrl!.isNotEmpty)
                const SizedBox(height: 12.0),

              Text(
                course.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.0),

              Text(
                'Instructor: ${course.instructor}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8.0),

              Text(
                course.description,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (course.isEnrolled)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Progress:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: course.progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                            minHeight: 8,
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${(course.progress * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Not Enrolled',
                        style: TextStyle(color: Colors.green[800], fontSize: 13),
                      ),
                    ),
                  if (course.isEnrolled) const SizedBox(width: 16),
                  if (course.isCompleted)
                    Chip(
                      label: const Text('Completed'),
                      backgroundColor: Colors.amber[100],
                      labelStyle: TextStyle(color: Colors.amber[800]),
                      avatar: Icon(Icons.check_circle, color: Colors.amber[800]),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}