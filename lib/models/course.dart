import 'package:hive/hive.dart';
import 'enums.dart';

part 'course.g.dart';

@HiveType(typeId: 2)
class Course extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String instructor;

  @HiveField(3)
  String description;

  @HiveField(4)
  String syllabus;

  @HiveField(5)
  CourseLevel level;

  @HiveField(6)
  CourseLanguage language;

  @HiveField(7)
  double progress;

  @HiveField(8)
  List<String> tags;

  @HiveField(9)
  List<String> categoryIds;

  @HiveField(10)
  List<String> lessonIds;

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  DateTime updatedAt;

  @HiveField(13)
  DateTime? publishedAt;

  @HiveField(14)
  bool isPublished;

  @HiveField(15)
  bool isArchived;

  @HiveField(16)
  double ratingAverage;

  @HiveField(17)
  int ratingCount;

  @HiveField(18)
  int enrollmentCount;

  @HiveField(19)
  Map<String, String> metadata;

  @HiveField(20)
  String? remoteId;

  @HiveField(21)
  DateTime? lastSyncedAt;

  @HiveField(22)
  bool dirty;

  @HiveField(23)
  DateTime? startDate;

  @HiveField(24)
  DateTime? endDate;

  @HiveField(25)
  bool isFavorite;

  @HiveField(26)
  DateTime? lastAccessedAt;

  @HiveField(27)
  String? slug;

  @HiveField(28)
  String? location;

  @HiveField(29)
  double? latitude;

  @HiveField(30)
  double? longitude;

  @HiveField(31)
  String? mapsUrl;

  @HiveField(32)
  String? imageUrl;

  @HiveField(33)
  bool isCompleted;

  @HiveField(34)
  bool isEnrolled;

  @HiveField(35)
  bool isPaid;

  @HiveField(36)
  bool isActive;

  @HiveField(37)
  String duration;

  @HiveField(38)
  String audience;

  @HiveField(39)
  String assignedTo;

  @HiveField(40)
  String instructorId;

  @HiveField(41) // ✅ NEW FIELD
  List<String> completedLessonIds;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.description,
    required this.syllabus,
    required this.level,
    required this.language,
    this.progress = 0.0,
    this.tags = const [],
    this.categoryIds = const [],
    this.lessonIds = const [],
    this.completedLessonIds = const [], // ✅ default empty
    DateTime? createdAt,
    DateTime? updatedAt,
    this.publishedAt,
    this.isPublished = false,
    this.isArchived = false,
    this.ratingAverage = 0.0,
    this.ratingCount = 0,
    this.enrollmentCount = 0,
    this.metadata = const {},
    this.remoteId,
    this.lastSyncedAt,
    this.dirty = false,
    this.startDate,
    this.endDate,
    this.isFavorite = false,
    this.lastAccessedAt,
    this.slug,
    this.location,
    this.latitude,
    this.longitude,
    this.mapsUrl,
    this.imageUrl,
    this.isCompleted = false,
    this.isEnrolled = false,
    this.isPaid = false,
    this.isActive = true,
    this.duration = '',
    this.audience = '',
    this.assignedTo = '',
    this.instructorId = '',
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isCourseCompleted => progress >= 1.0;

  int get completedLessonCount {
    return lessonIds.where((id) => completedLessonIds.contains(id)).length;
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      instructor: json['instructor'] ?? '',
      description: json['description'] ?? '',
      syllabus: json['syllabus'] ?? '',
      level: CourseLevel.values.firstWhere(
            (e) => e.name == json['level'],
        orElse: () => CourseLevel.beginner,
      ),
      language: CourseLanguage.values.firstWhere(
            (e) => e.name == json['language'],
        orElse: () => CourseLanguage.ar,
      ),
      progress: (json['progress'] ?? 0.0).toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      categoryIds: List<String>.from(json['categoryIds'] ?? []),
      lessonIds: List<String>.from(json['lessonIds'] ?? []),
      completedLessonIds: List<String>.from(json['completedLessonIds'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      publishedAt: DateTime.tryParse(json['publishedAt'] ?? ''),
      isPublished: json['isPublished'] ?? false,
      isArchived: json['isArchived'] ?? false,
      ratingAverage: (json['ratingAverage'] ?? 0.0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      enrollmentCount: json['enrollmentCount'] ?? 0,
      metadata: Map<String, String>.from(json['metadata'] ?? {}),
      remoteId: json['remoteId'],
      lastSyncedAt: DateTime.tryParse(json['lastSyncedAt'] ?? ''),
      dirty: json['dirty'] ?? false,
      startDate: DateTime.tryParse(json['startDate'] ?? ''),
      endDate: DateTime.tryParse(json['endDate'] ?? ''),
      isFavorite: json['isFavorite'] ?? false,
      lastAccessedAt: DateTime.tryParse(json['lastAccessedAt'] ?? ''),
      slug: json['slug'],
      location: json['location'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      mapsUrl: json['mapsUrl'],
      imageUrl: json['imageUrl'],
      isCompleted: json['isCompleted'] ?? false,
      isEnrolled: json['isEnrolled'] ?? false,
      isPaid: json['isPaid'] ?? false,
      isActive: json['isActive'] ?? true,
      duration: json['duration'] ?? '',
      audience: json['audience'] ?? '',
      assignedTo: json['assignedTo'] ?? '',
      instructorId: json['instructorId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instructor': instructor,
      'description': description,
      'syllabus': syllabus,
      'level': level.name,
      'language': language.name,
      'progress': progress,
      'tags': tags,
      'categoryIds': categoryIds,
      'lessonIds': lessonIds,
      'completedLessonIds': completedLessonIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
      'isPublished': isPublished,
      'isArchived': isArchived,
      'ratingAverage': ratingAverage,
      'ratingCount': ratingCount,
      'enrollmentCount': enrollmentCount,
      'metadata': metadata,
      'remoteId': remoteId,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
      'dirty': dirty,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isFavorite': isFavorite,
      'lastAccessedAt': lastAccessedAt?.toIso8601String(),
      'slug': slug,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'mapsUrl': mapsUrl,
      'imageUrl': imageUrl,
      'isCompleted': isCompleted,
      'isEnrolled': isEnrolled,
      'isPaid': isPaid,
      'isActive': isActive,
      'duration': duration,
      'audience': audience,
      'assignedTo': assignedTo,
      'instructorId': instructorId,
    };
  }
}