
//assignment_submission.dart

import 'package:hive/hive.dart';

part 'assignment_submission.g.dart';

@HiveType(typeId: 11) // ✅ Unique typeId
class AssignmentSubmission extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String studentId;

  @HiveField(2)
  String courseId;

  @HiveField(3)
  String filePath;

  @HiveField(4)
  DateTime submittedAt;

  @HiveField(5)
  DateTime deadline;

  @HiveField(6)
  String status;

  @HiveField(7)
  String? instructorFeedback;

  AssignmentSubmission({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.filePath,
    required this.submittedAt,
    required this.deadline,
    required this.status,
    this.instructorFeedback,
  });
}