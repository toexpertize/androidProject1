import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/notification.dart';
import 'package:lmsalfa/models/enums.dart';

import 'package:lmsalfa/screens/login_page.dart';
import 'package:lmsalfa/screens/dashboards/student_dashboard.dart';
import 'package:lmsalfa/screens/dashboards/admin_dashboard.dart';
import 'package:lmsalfa/screens/dashboards/teacher_dashboard.dart';
import 'package:lmsalfa/screens/notifications_page.dart';
import 'package:lmsalfa/screens/courses/course_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserRoleAdapter());
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(LessonAdapter());
  Hive.registerAdapter(ContentFormatAdapter());
  Hive.registerAdapter(AppNotificationAdapter());
  Hive.registerAdapter(UserStatusAdapter());

  await Hive.openBox<User>('users');
  await Hive.openBox<Course>('courses');
  await Hive.openBox<Lesson>('lessons');
  await Hive.openBox<AppNotification>('notifications');

  // ✅ Dummy data seeding
  final userBox = Hive.box<User>('users');
  final courseBox = Hive.box<Course>('courses');
  final lessonBox = Hive.box<Lesson>('lessons');
  final notificationBox = Hive.box<AppNotification>('notifications');

  if (userBox.isEmpty) {
    final admin = User(
      id: 'u1',
      name: 'Admin A',
      role: UserRole.admin,
      email: 'admin',
      password: '123',
    );
    final teacher = User(
      id: 'u2',
      name: 'Teacher T',
      role: UserRole.teacher,
      email: 'teacher',
      password: '123',
      completedLessonIds: [], // ✅ Added

    );
    final student = User(
      id: 'u3',
      name: 'Student S',
      role: UserRole.student,
      email: 'student',
      password: '123',
      completedLessonIds: [], // ✅ Added

    );
    userBox.put(admin.id, admin);
    userBox.put(teacher.id, teacher);
    userBox.put(student.id, student);
  }

  if (courseBox.isEmpty) {
    final course = Course(
      id: 'c1',
      title: 'Flutter Basics',
      instructor: 'Teacher T',
      description: 'Learn the basics of Flutter development.',
      syllabus: 'Widgets, Layouts, Navigation, State Management',
      level: CourseLevel.beginner,
      language: CourseLanguage.en,
      instructorId: 'u2',
      assignedTo: 'u3',
      isActive: true,
      progress: 0.0,
      isCompleted: false,
    );
    courseBox.put(course.id, course);
  }

  if (lessonBox.isEmpty) {
    final lesson1 = Lesson(
      id: 'l1',
      title: 'Intro to Flutter',
      content: 'Welcome to Flutter!',
      format: ContentFormat.text,
      courseId: 'c1',
      createdAt: DateTime.now(),
      duration: '5 min',
      isCompleted: false,
      attachmentUrl: null,
    );
    final lesson2 = Lesson(
      id: 'l2',
      title: 'Flutter Widgets',
      content: 'Explore core widgets in Flutter.',
      format: ContentFormat.video,
      courseId: 'c1',
      createdAt: DateTime.now(),
      duration: '8 min',
      videoUrl: 'https://example.com/flutter-widgets',
      isCompleted: false,
      attachmentUrl: null,
    );
    lessonBox.put(lesson1.id, lesson1);
    lessonBox.put(lesson2.id, lesson2);
  }

  if (notificationBox.isEmpty) {
    final notif = AppNotification(
      id: 'n1',
      title: 'Welcome!',
      message: 'Your LMS Alfa account is ready.',
      role: 'all',
      timestamp: DateTime.now(),
    );
    notificationBox.put(notif.id, notif);
  }

  runApp(const LMSAlfaApp());
}

class LMSAlfaApp extends StatelessWidget {
  const LMSAlfaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS Alfa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());

          case '/student-dashboard':
            if (args is User) {
              final courseBox = Hive.box<Course>('courses');
              final courses = courseBox.values
                  .where((c) => c.assignedTo == args.id)
                  .toList();
              return MaterialPageRoute(
                builder: (_) => StudentDashboard(
                  studentName: args.name,
                  courses: courses,
                  currentUser: args,
                ),
              );
            }
            return _errorRoute('Missing or invalid user for student dashboard');

          case '/admin-dashboard':
            if (args is User) {
              return MaterialPageRoute(
                builder: (_) => AdminDashboard(user: args),
              );
            }
            return _errorRoute('Missing or invalid user for admin dashboard');

          case '/teacher-dashboard':
            if (args is User) {
              return MaterialPageRoute(
                builder: (_) => TeacherDashboard(user: args),
              );
            }
            return _errorRoute('Missing or invalid user for teacher dashboard');

          case '/notifications':
            if (args is User) {
              return MaterialPageRoute(
                builder: (_) => NotificationsPage(user: args),
              );
            }
            return _errorRoute('Missing or invalid user for notifications');

          case '/course-details':
            if (args is Course) {
              return MaterialPageRoute(
                builder: (_) => CoursePreview(course: args),
              );
            }
            return _errorRoute('Missing or invalid course for preview');

          default:
            return _errorRoute('Route not found: ${settings.name}');
        }
      },
    );
  }

  Route _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Navigation Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}