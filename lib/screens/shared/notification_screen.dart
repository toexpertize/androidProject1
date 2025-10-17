import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/notification.dart';
import 'package:lmsalfa/models/user.dart';

class NotificationScreen extends StatelessWidget {
  final User user;

  const NotificationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<AppNotification>('notifications');
    final notifications = box.values
        .where((n) => n.role == user.role.name || n.role == 'all')
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications available'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(n.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(n.message),
                  const SizedBox(height: 4),
                  Text(
                    '${n.timestamp.toLocal()}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}