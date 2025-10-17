import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 14)
class Category extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int iconCodePoint; // ✅ Store icon as int

  @HiveField(3)
  int colorValue; // ✅ Store color as int

  Category({
    required this.id,
    required this.title,
    required this.iconCodePoint,
    required this.colorValue,
  });

  /// ✅ Convert back to usable types
  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
  Color get color => Color(colorValue);
}