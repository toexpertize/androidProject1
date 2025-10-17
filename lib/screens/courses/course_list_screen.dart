import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/screens/courses/course_access_gate.dart';

class CourseListScreen extends StatefulWidget {
  final User currentUser;

  const CourseListScreen({super.key, required this.currentUser});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final allCourses = courseBox.values.toList();

    final filteredCourses = allCourses.where((course) {
      final query = _searchQuery.toLowerCase();
      return course.title.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Available Courses')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by title or instructor',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredCourses.isEmpty
                  ? const Center(child: Text('No matching courses found'))
                  : ListView.builder(
                itemCount: filteredCourses.length,
                itemBuilder: (_, index) {
                  final course = filteredCourses[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(course.title),
                      subtitle: Text('Instructor: ${course.instructor}'),
                      trailing: Icon(
                        course.isEnrolled
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: course.isEnrolled
                            ? Colors.green
                            : Colors.grey,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CourseAccessGate(
                            course: course,
                            student: widget.currentUser,
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