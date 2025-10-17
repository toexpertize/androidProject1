import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:lmsalfa/models/user.dart';

import '../models/enums.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    print('🔍 Attempting login with:');
    print('Entered email: $email');
    print('Entered password: $password');

    final userBox = Hive.box<User>('users');
    for (var u in userBox.values) {
      print('Stored user: ${u.email} | ${u.password} | ${u.role}');
    }

    final user = userBox.values.firstWhereOrNull(
          (u) => u.email == email && u.password == password,
    );

    if (user == null) {
      setState(() {
        errorMessage = 'Invalid credentials';
      });
      print('❌ No matching user found.');
      return;
    }

    print('✅ Logged in as: ${user.name} (${user.role})');

    switch (user.role) {
      case UserRole.student:
        Navigator.pushNamed(context, '/student-dashboard', arguments: user);
        break;
      case UserRole.teacher:
      // Replace with your teacher dashboard route
        Navigator.pushNamed(context, '/teacher-dashboard', arguments: user);
        break;
      case UserRole.admin:
      // Replace with your admin dashboard route
        Navigator.pushNamed(context, '/admin-dashboard', arguments: user);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}