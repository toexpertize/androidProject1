import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/enums.dart';
import 'package:lmsalfa/widgets/course_progress_chart.dart';
import 'package:lmsalfa/screens/notifications_page.dart';
import 'package:lmsalfa/models/notification.dart'; // ✅ AppNotification

class AdminDashboard extends StatefulWidget {
  final User user;

  const AdminDashboard({super.key, required this.user});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _searchController = TextEditingController();
  String _statusFilter = 'All';
  List<Course> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _applyFilters();
    _searchController.addListener(_applyFilters);
  }

  void _applyFilters() {
    final courseBox = Hive.box<Course>('courses');
    final query = _searchController.text.toLowerCase();
    final allCourses = courseBox.values.toList();

    final filtered = allCourses.where((course) {
      final matchesQuery = course.title.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query);
      final matchesStatus = _statusFilter == 'All' ||
          (_statusFilter == 'Active' && course.isActive) ||
          (_statusFilter == 'Inactive' && !course.isActive);
      return matchesQuery && matchesStatus;
    }).toList();

    setState(() {
      _filteredCourses = filtered;
    });
  }

  void _setStatusFilter(String status) {
    setState(() {
      _statusFilter = status;
    });
    _applyFilters();
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotificationsPage(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('users');
    final courseBox = Hive.box<Course>('courses');
    final notificationBox = Hive.box<AppNotification>('notifications'); // ✅ Correct type

    final students = userBox.values.where((u) => u.role == UserRole.student).length;
    final teachers = userBox.values.where((u) => u.role == UserRole.teacher).length;
    final admins = userBox.values.where((u) => u.role == UserRole.admin).length;

    final allUsers = userBox.values.toList();
    final allCourses = courseBox.values.toList();
    final activeCourses = allCourses.where((c) => c.isActive).length;
    final inactiveCourses = allCourses.where((c) => !c.isActive).length;
    final assignedCourses = allCourses.where((c) => c.isEnrolled).length;
    final completedCourses = allCourses.where((c) => c.isCompleted).length;

    final userRole = widget.user.role.toString().split('.').last;
    final notificationCount = notificationBox.values
        .where((n) => n.role == userRole)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/notification.png', width: 24, height: 24),
            tooltip: 'Notifications',
            onPressed: _openNotifications,
          ),
          IconButton(
            icon: Image.asset('assets/icons/logout.png', width: 24, height: 24),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Admin ${widget.user.name}', style: const TextStyle(fontSize: 22)),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit_notifications),
              label: const Text('Compose Notification'),
              onPressed: () {
                Navigator.pushNamed(context, '/compose-notification');
              },
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStat('Students', students, Colors.blue, 'assets/icons/student.png'),
                  _buildStat('Teachers', teachers, Colors.indigo, 'assets/icons/teacher.png'),
                  _buildStat('Admins', admins, Colors.purple, 'assets/icons/admin.png'),
                  _buildStat('Courses', allCourses.length, Colors.teal, 'assets/icons/courses.png'),
                  _buildStat('Active', activeCourses, Colors.green, 'assets/icons/active.png'),
                  _buildStat('Inactive', inactiveCourses, Colors.grey, 'assets/icons/inactive.png'),
                  _buildStat('Assigned', assignedCourses, Colors.orange, 'assets/icons/assigned.png'),
                  _buildStat('Completed', completedCourses, Colors.red, 'assets/icons/completed.png'),
                  _buildStat('Notifications', notificationCount, Colors.deepPurple, 'assets/icons/notification.png'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            CourseProgressChart(courses: allCourses),
            const SizedBox(height: 32),
            const Text('Course List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by title or instructor',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildFilterButton('All'),
                _buildFilterButton('Active'),
                _buildFilterButton('Inactive'),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredCourses.length,
              itemBuilder: (_, index) {
                final course = _filteredCourses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(course.title),
                    subtitle: Text('Instructor: ${course.instructor}'),
                    trailing: Icon(
                      course.isActive ? Icons.check_circle : Icons.cancel,
                      color: course.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            const Text('User List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allUsers.length,
              itemBuilder: (_, index) {
                final u = allUsers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(u.name),
                    subtitle: Text('${u.email} • ${u.role.name}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, int count, Color color, String iconPath) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 6),
          Text(
            '$label: $count',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = _statusFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () => _setStatusFilter(label),
        child: Text(label),
      ),
    );
  }
}