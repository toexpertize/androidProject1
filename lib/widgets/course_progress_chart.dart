import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lmsalfa/models/course.dart';

/// 📊 CourseProgressChart
/// Visualizes key course metrics: Completed, Enrolled, Active, Inactive
/// Used in dashboards for Admin, Teacher, and future analytics

class CourseProgressChart extends StatelessWidget {
  final List<Course> courses;

  const CourseProgressChart({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final completed = courses.where((c) => c.isCompleted).length;
    final enrolled = courses.where((c) => c.isEnrolled).length;
    final active = courses.where((c) => c.isActive).length;
    final inactive = courses.length - active;

    final data = [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: completed.toDouble(), color: Colors.green),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: enrolled.toDouble(), color: Colors.blue),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: active.toDouble(), color: Colors.teal),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(toY: inactive.toDouble(), color: Colors.grey),
      ]),
    ];

    return SizedBox(
      height: 220,
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
                    case 0:
                      return const Text('Completed');
                    case 1:
                      return const Text('Enrolled');
                    case 2:
                      return const Text('Active');
                    case 3:
                      return const Text('Inactive');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
          ),
          barGroups: data,
        ),
      ),
    );
  }
}