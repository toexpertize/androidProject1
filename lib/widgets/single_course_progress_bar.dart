import 'package:flutter/material.dart';

class SingleCourseProgressBar extends StatelessWidget {
  final double progress;

  const SingleCourseProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).clamp(0, 100).toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          color: progress >= 1.0 ? Colors.green : Colors.blue,
        ),
        const SizedBox(height: 8),
        Text('$percentage% completed'),
      ],
    );
  }
}