import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/notification.dart';

class ComposeNotificationPage extends StatefulWidget {
  const ComposeNotificationPage({super.key});

  @override
  State<ComposeNotificationPage> createState() => _ComposeNotificationPageState();
}

class _ComposeNotificationPageState extends State<ComposeNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedRole = 'all';

  final List<String> roles = ['admin', 'teacher', 'student', 'all'];

  void _submitNotification() {
    if (_formKey.currentState!.validate()) {
      final notificationBox = Hive.box<AppNotification>('notifications');
      final newNotification = AppNotification(
        title: _titleController.text.trim(),
        message: _messageController.text.trim(),
        timestamp: DateTime.now(),
        role: _selectedRole, id: '',
      );
      notificationBox.add(newNotification);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification sent successfully')),
      );

      _formKey.currentState!.reset();
      setState(() => _selectedRole = 'all');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Notification'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Send To:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: roles.map((role) {
                  final isSelected = _selectedRole == role;
                  return ChoiceChip(
                    label: Text(role),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedRole = role),
                    selectedColor: Colors.blue.shade100,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) =>
                value == null || value.trim().isEmpty ? 'Message is required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Send Notification'),
                onPressed: _submitNotification,
              ),
            ],
          ),
        ),
      ),
    );
  }
}