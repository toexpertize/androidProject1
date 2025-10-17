import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/notification.dart';

class NotificationComposer extends StatefulWidget {
  const NotificationComposer({super.key});

  @override
  State<NotificationComposer> createState() => _NotificationComposerState();
}

class _NotificationComposerState extends State<NotificationComposer> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedRole = 'student'; // Default target

  void sendNotification() {
    if (_formKey.currentState!.validate()) {
      final box = Hive.box<AppNotification>('notifications');
      final notification = AppNotification(
        title: _titleController.text,
        message: _messageController.text,
        timestamp: DateTime.now(),
        role: _selectedRole, id: '',
      );
      box.add(notification);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Notification sent')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compose Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 3,
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedRole,
                items: ['admin', 'teacher', 'student', 'all']
                    .map((role) => DropdownMenuItem(
                  value: role,
                  child: Text(role),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val!),
                decoration: const InputDecoration(labelText: 'Target Role'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Send Notification'),
                onPressed: sendNotification,
              ),
            ],
          ),
        ),
      ),
    );
  }
}