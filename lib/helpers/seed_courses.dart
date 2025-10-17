import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';

Future<void> seedSampleCourses() async {
  final courseBox = Hive.box<Course>('courses');

  if (courseBox.isNotEmpty) {
    print('ℹ️ Courses already exist.');
    return;
  }

  final now = DateTime.now();

  final sampleCourses = [
    Course(
      id: 'C101',
      title: 'Flutter for Beginners',
      instructor: 'Ahmed AlTech',
      instructorId: 'T001',
      description: 'Learn Flutter from scratch.',
      syllabus: 'Widgets, State, Navigation',
      level: CourseLevel.beginner,
      language: CourseLanguage.en,
      isPublished: true,
      isActive: true,
      isCompleted: false,
      isEnrolled: true,
      assignedTo: 'S001',
      createdAt: now,
      updatedAt: now,
    ),
    Course(
      id: 'C102',
      title: 'Advanced Dart',
      instructor: 'Ahmed AlTech',
      instructorId: 'T001',
      description: 'Master Dart language features.',
      syllabus: 'Streams, Futures, Generics',
      level: CourseLevel.advanced,
      language: CourseLanguage.en,
      isPublished: true,
      isActive: false,
      isCompleted: true,
      isEnrolled: true,
      assignedTo: 'S001',
      createdAt: now,
      updatedAt: now,
    ),
    Course(
      id: 'C103',
      title: 'UI/UX Design Principles',
      instructor: 'Sara Creative',
      instructorId: 'T002',
      description: 'Design beautiful and usable apps.',
      syllabus: 'Color, Typography, Layout',
      level: CourseLevel.intermediate,
      language: CourseLanguage.en,
      isPublished: true,
      isActive: true,
      isCompleted: false,
      isEnrolled: false,
      assignedTo: '',
      createdAt: now,
      updatedAt: now,
    ),
  ];

  for (final course in sampleCourses) {
    await courseBox.put(course.id, course);
  }

  print('✅ Sample courses seeded.');
}