import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:lmsalfa/models/course.dart';
import 'package:lmsalfa/models/notification.dart';
import 'package:lmsalfa/screens/notifications_page.dart';
import 'package:lmsalfa/screens/login_page.dart';

class TeacherDashboard extends StatefulWidget {
  final User user;
  const TeacherDashboard({super.key, required this.user});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final courseBox = Hive.box<Course>('courses');
    final notificationBox = Hive.box<AppNotification>('notifications');

    final allCourses = courseBox.values
        .where((c) => c.instructorId == widget.user.id)
        .toList();

    final filteredCourses = allCourses.where((c) {
      final matchesSearch = c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.instructor.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = switch (_selectedFilter) {
        'All' => true,
        'Active' => c.isActive,
        'Inactive' => !c.isActive,
        'Assigned' => c.assignedTo.isNotEmpty,
        _ => true,
      };

      return matchesSearch && matchesFilter;
    }).toList();

    final active = allCourses.where((c) => c.isActive).length;
    final assigned = allCourses.where((c) => c.assignedTo.isNotEmpty).length;
    final inactive = allCourses.length - active;
    final unassigned = allCourses.length - assigned;

    final notificationCount = notificationBox.values
        .where((n) => n.role == widget.user.role.name || n.role == 'all')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/notification.png', width: 24, height: 24),
                tooltip: 'Notifications',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotificationsPage(user: widget.user),
                    ),
                  );
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Image.asset('assets/icons/logout.png', width: 24, height: 24),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Teacher ${widget.user.name}', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildKPI('assets/icons/assigned.png', 'Assigned', assigned.toString()),
                _buildKPI('assets/icons/active.png', 'Active', active.toString()),
                _buildKPI('assets/icons/inactive.png', 'Inactive', inactive.toString()),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/compose-course'),
              icon: const Icon(Icons.add),
              label: const Text('Create New Course'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/compose-notification'),
              icon: const Icon(Icons.edit_notifications),
              label: const Text('Send Notification'),
            ),
            const SizedBox(height: 24),
            const Text('Course Analytics', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          switch (value.toInt()) {
                            case 0: return const Text('Active');
                            case 1: return const Text('Inactive');
                            default: return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(toY: active.toDouble(), color: Colors.green),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: inactive.toDouble(), color: Colors.red),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Assignment Distribution', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: assigned.toDouble(),
                      title: 'Assigned',
                      color: Colors.blue,
                      radius: 60,
                    ),
                    PieChartSectionData(
                      value: unassigned.toDouble(),
                      title: 'Unassigned',
                      color: Colors.grey,
                      radius: 60,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Course List', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by title or instructor',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: ['All', 'Active', 'Inactive', 'Assigned'].map((label) {
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
            filteredCourses.isEmpty
                ? const Center(child: Text('No matching courses found.'))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredCourses.length,
              itemBuilder: (_, index) {
                final course = filteredCourses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(course.title),
                    subtitle: Text('Status: ${course.isActive ? 'Active' : 'Inactive'}'),
                    trailing: Icon(
                      course.isActive ? Icons.check_circle : Icons.block,
                      color: course.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPI(String assetPath, String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(assetPath, width: 28, height: 28),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}