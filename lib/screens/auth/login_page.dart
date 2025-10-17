import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/screens/dashboards/admin_dashboard.dart';
import 'package:lmsalfa/screens/dashboards/teacher_dashboard.dart';
import 'package:lmsalfa/screens/dashboards/student_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  void login() {
    if (_formKey.currentState!.validate()) {
      final userBox = Hive.box<User>('users');

      try {
        final user = userBox.values.firstWhere(
              (u) =>
          u.email == _emailController.text &&
              u.password == _passwordController.text,
        );

        switch (user.role) {
          case UserRole.admin:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AdminDashboard(user: user)),
            );
            break;

          case UserRole.teacher:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => TeacherDashboard(user: user)),
            );
            break;

          case UserRole.student:
            final courseBox = Hive.box<Course>('courses');
            final courses = courseBox.values
                .where((c) => c.assignedTo == user.id)
                .toList();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => StudentDashboard(
                  studentName: user.name,
                  courses: courses,
                  currentUser: user,
                ),
              ),
            );
            break;
        }
      } catch (e) {
        setState(() => _error = 'Invalid credentials');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}