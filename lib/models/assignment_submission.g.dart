// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_submission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentSubmissionAdapter extends TypeAdapter<AssignmentSubmission> {
  @override
  final int typeId = 11;

  @override
  AssignmentSubmission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssignmentSubmission(
      id: fields[0] as String,
      studentId: fields[1] as String,
      courseId: fields[2] as String,
      filePath: fields[3] as String,
      submittedAt: fields[4] as DateTime,
      deadline: fields[5] as DateTime,
      status: fields[6] as String,
      instructorFeedback: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AssignmentSubmission obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentId)
      ..writeByte(2)
      ..write(obj.courseId)
      ..writeByte(3)
      ..write(obj.filePath)
      ..writeByte(4)
      ..write(obj.submittedAt)
      ..writeByte(5)
      ..write(obj.deadline)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.instructorFeedback);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentSubmissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
