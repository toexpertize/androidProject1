import 'package:hive/hive.dart';

part 'course_grading.g.dart';

@HiveType(typeId: 21)
class CourseGrading {
  @HiveField(0)
  int quizzesWeight;

  @HiveField(1)
  int homeworkWeight;

  @HiveField(2)
  int finalExamWeight;

  CourseGrading({
    required this.quizzesWeight,
    required this.homeworkWeight,
    required this.finalExamWeight,
  });

  int get total => quizzesWeight + homeworkWeight + finalExamWeight;
}