import 'package:hive/hive.dart';
import 'package:lmsalfa/models/enums.dart';

part 'user.g.dart';

@HiveType(typeId: 13)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String name;

  @HiveField(4)
  UserRole role;

  @HiveField(5)
  UserStatus status;

  @HiveField(6)
  List<String> completedLessonIds; // ✅ New field for tracking



  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    this.status = UserStatus.active,
    this.completedLessonIds = const [], // ✅ Default empty


  });
}