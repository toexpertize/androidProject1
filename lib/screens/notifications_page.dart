import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/notification.dart';

class NotificationsPage extends StatefulWidget {
  final User user;
  const NotificationsPage({super.key, required this.user});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final notificationBox = Hive.box<AppNotification>('notifications');

    final allNotifications = notificationBox.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final userRole = widget.user.role.toString().split('.').last;

    final filtered = allNotifications.where((n) {
      final matchesSearch = n.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          n.message.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesFilter = true;
      if (_selectedFilter == 'Role') {
        matchesFilter = n.role == userRole;
      } else if (_selectedFilter == 'Global') {
        matchesFilter = n.role == 'all';
      }

      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search notifications',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: ['All', 'Role', 'Global'].map((label) {
                final isSelected = _selectedFilter == label;
                return ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedFilter = label),
                  selectedColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            filtered.isEmpty
                ? const Expanded(child: Center(child: Text('No notifications available.')))
                : Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, index) {
                  final notification = filtered[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(notification.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification.message),
                          const SizedBox(height: 4),
                          Text(
                            'Posted: ${notification.timestamp.toLocal().toString().split('.').first}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}