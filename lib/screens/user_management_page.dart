import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            trailing: DropdownButton<UserRole>(
              value: user.role,
              onChanged: (newRole) {
                if (newRole != null) {
                  user.role = newRole;
                  user.save();
                }
              },
              items: UserRole.values.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role.name.toUpperCase()),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}