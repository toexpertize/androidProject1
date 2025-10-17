import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 6)
class AppNotification extends HiveObject {
  @HiveField(0)
  final String id; // ✅ Unique identifier for each notification

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final String role; // 'admin', 'teacher', 'student'

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.role,
  });
}