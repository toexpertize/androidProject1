import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/screens/login_page.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.student;

  void handleRegister() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final userBox = Hive.box<User>('users');
    final existingUser = userBox.values.any((u) => u.email == email);

    if (existingUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email already registered')),
      );
      return;
    }

    final newUser = User(
      id: const Uuid().v4(),
      name: name,
      email: email,
      password: password,
      role: _selectedRole,
      status: UserStatus.active,
    );

    userBox.add(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            DropdownButton<UserRole>(
              value: _selectedRole,
              onChanged: (role) {
                if (role != null) {
                  setState(() => _selectedRole = role);
                }
              },
              items: UserRole.values.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role.name.toUpperCase()),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: handleRegister,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}