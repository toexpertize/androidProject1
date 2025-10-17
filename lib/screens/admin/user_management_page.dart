import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';

class UserManagementPage extends StatelessWidget {
  final User currentUser;
  const UserManagementPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    if (currentUser.role != UserRole.admin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Access Denied')),
        body: const Center(child: Text('You do not have permission to view this page.')),
      );
    }

    final userBox = Hive.box<User>('users');
    final users = userBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text('${user.email} • ${user.role.name.toUpperCase()}'),
            trailing: Text(user.status.name.toUpperCase()),
          );
        },
      ),
    );
  }
}