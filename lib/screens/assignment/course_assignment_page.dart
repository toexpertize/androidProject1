import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';

class CourseAssignmentPage extends StatefulWidget {
  final User currentUser;
  const CourseAssignmentPage({super.key, required this.currentUser});

  @override
  State<CourseAssignmentPage> createState() => _CourseAssignmentPageState();
}

class _CourseAssignmentPageState extends State<CourseAssignmentPage> {
  late List<User> students;
  late List<Course> courses;
  User? selectedStudent;
  Course? selectedCourse;

  @override
  void initState() {
    super.initState();
    final userBox = Hive.box<User>('users');
    final courseBox = Hive.box<Course>('courses');

    students = userBox.values
        .where((u) => u.role == UserRole.student)
        .toList();

    courses = courseBox.values
        .where((c) => c.isActive && !c.isArchived)
        .toList();
  }

  void assignCourse() {
    if (selectedStudent == null || selectedCourse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both student and course')),
      );
      return;
    }

    selectedCourse!.isEnrolled = true;
    selectedCourse!.enrollmentCount += 1;
    selectedCourse!.lastAccessedAt = DateTime.now();
    selectedCourse!.save();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Course assigned to ${selectedStudent!.name}')),
    );

    setState(() {
      selectedStudent = null;
      selectedCourse = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Course')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Select Student:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<User>(
              value: selectedStudent,
              hint: const Text('Choose a student'),
              onChanged: (user) => setState(() => selectedStudent = user),
              items: students.map((user) {
                return DropdownMenuItem(
                  value: user,
                  child: Text(user.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Select Course:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<Course>(
              value: selectedCourse,
              hint: const Text('Choose a course'),
              onChanged: (course) => setState(() => selectedCourse = course),
              items: courses.map((course) {
                return DropdownMenuItem(
                  value: course,
                  child: Text(course.title),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: assignCourse,
              child: const Text('Assign Course'),
            ),
          ],
        ),
      ),
    );
  }
}