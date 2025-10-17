import 'package:flutter/material.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/lessons/lesson_viewer.dart';

class LessonListScreen extends StatefulWidget {
  final String courseTitle;
  final List<Lesson> lessons;
  final User? currentUser; // ✅ Optional user for tracking

  const LessonListScreen({
    super.key,
    required this.courseTitle,
    required this.lessons,
    this.currentUser,
  });

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final completed = widget.lessons.where((l) =>
    widget.currentUser?.completedLessonIds.contains(l.id) ?? false
    ).length;

    final total = widget.lessons.length;
    final progress = total == 0 ? 0.0 : completed / total;

    final filteredLessons = widget.lessons.where((lesson) {
      final matchesSearch = lesson.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final isCompleted = widget.currentUser?.completedLessonIds.contains(lesson.id) ?? false;

      bool matchesFilter = true;
      if (_selectedFilter == 'Completed') {
        matchesFilter = isCompleted;
      } else if (_selectedFilter == 'Incomplete') {
        matchesFilter = !isCompleted;
      }

      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.courseTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Progress: ${(progress * 100).toStringAsFixed(1)}% '
                  '($completed/$total lessons completed)',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search lessons by title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: ['All', 'Completed', 'Incomplete'].map((label) {
                final isSelected = _selectedFilter == label;
                return ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedFilter = label),
                  selectedColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (filteredLessons.isEmpty)
              const Expanded(child: Center(child: Text('No lessons available')))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLessons.length,
                  itemBuilder: (context, index) {
                    final lesson = filteredLessons[index];
                    final isCompleted = widget.currentUser?.completedLessonIds.contains(lesson.id) ?? false;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          lesson.format == ContentFormat.video
                              ? Icons.play_circle
                              : Icons.article,
                          color: isCompleted ? Colors.green : Colors.blue,
                        ),
                        title: Text(lesson.title),
                        subtitle: Text('${lesson.duration ?? 'Unknown'} • ${lesson.format.name}'),
                        trailing: Icon(
                          isCompleted ? Icons.check_circle : Icons.arrow_forward,
                          color: isCompleted ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => LessonViewer(
                              lessons: widget.lessons,
                              initialIndex: widget.lessons.indexOf(lesson),
                              currentUser: widget.currentUser,
                            ),
                          ));
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}