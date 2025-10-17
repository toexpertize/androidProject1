import 'package:hive/hive.dart';

part 'enums.g.dart'; // Required for Hive code generation

@HiveType(typeId: 1)
enum UserRole {
  @HiveField(0)
  admin,
  @HiveField(1)
  teacher,
  @HiveField(2)
  student,
}

@HiveType(typeId: 2)
enum CourseCategory {
  @HiveField(0)
  programming,
  @HiveField(1)
  design,
  @HiveField(2)
  business,
  @HiveField(3)
  marketing,
  @HiveField(4)
  science,
  @HiveField(5)
  language,
}

@HiveType(typeId: 3)
enum ContentFormat {
  @HiveField(0)
  video,
  @HiveField(1)
  pdf,
  @HiveField(2)
  text,
  @HiveField(3)
  quiz,
}

@HiveType(typeId: 4)
enum QuestionType {
  @HiveField(0)
  multipleChoice,
  @HiveField(1)
  trueFalse,
  @HiveField(2)
  shortAnswer,
}

@HiveType(typeId: 5)
enum DifficultyLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
}

@HiveType(typeId: 6)
enum EnrollmentStatus {
  @HiveField(0)
  enrolled,
  @HiveField(1)
  completed,
  @HiveField(2)
  dropped,
  @HiveField(3)
  pending,
}

@HiveType(typeId: 7)
enum NotificationType {
  @HiveField(0)
  announcement,
  @HiveField(1)
  assignmentDue,
  @HiveField(2)
  gradeUpdate,
  @HiveField(3)
  newContent,
}

@HiveType(typeId: 8)
enum QuizStatus {
  @HiveField(0)
  notStarted,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  completed,
  @HiveField(3)
  graded,
}

@HiveType(typeId: 9)
enum SubmissionStatus {
  @HiveField(0)
  notSubmitted,
  @HiveField(1)
  submitted,
  @HiveField(2)
  graded,
  @HiveField(3)
  late,
}

@HiveType(typeId: 10)
enum UserStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  inactive,
  @HiveField(2)
  suspended,
}

@HiveType(typeId: 11)
enum CourseLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
}

@HiveType(typeId: 12)
enum CourseLanguage {
  @HiveField(0)
  en,
  @HiveField(1)
  ar,
}