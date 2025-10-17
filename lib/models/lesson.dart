import 'package:hive/hive.dart';
import 'enums.dart';

part 'lesson.g.dart';

@HiveType(typeId: 30)
class Lesson extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  String content;

  @HiveField(4)
  String? videoUrl;

  @HiveField(5)
  ContentFormat format; // ✅ Required for composer

  @HiveField(6)
  String courseId;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  String? duration; // ⏱️ Optional: "5 min", "12 min"

  @HiveField(9)
  String? attachmentUrl; // 📎 Optional: PDF, slides, etc.

  Lesson({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.content,
    this.videoUrl,
    required this.format,
    required this.courseId,
    required this.createdAt,
    this.duration,
    this.attachmentUrl,
  });
}