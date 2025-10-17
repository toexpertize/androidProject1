// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_grading.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseGradingAdapter extends TypeAdapter<CourseGrading> {
  @override
  final int typeId = 21;

  @override
  CourseGrading read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseGrading(
      quizzesWeight: fields[0] as int,
      homeworkWeight: fields[1] as int,
      finalExamWeight: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CourseGrading obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.quizzesWeight)
      ..writeByte(1)
      ..write(obj.homeworkWeight)
      ..writeByte(2)
      ..write(obj.finalExamWeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseGradingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
