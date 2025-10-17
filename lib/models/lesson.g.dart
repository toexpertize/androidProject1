// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonAdapter extends TypeAdapter<Lesson> {
  @override
  final int typeId = 30;

  @override
  Lesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lesson(
      id: fields[0] as String,
      title: fields[1] as String,
      isCompleted: fields[2] as bool,
      content: fields[3] as String,
      videoUrl: fields[4] as String?,
      format: fields[5] as ContentFormat,
      courseId: fields[6] as String,
      createdAt: fields[7] as DateTime,
      duration: fields[8] as String?,
      attachmentUrl: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Lesson obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.videoUrl)
      ..writeByte(5)
      ..write(obj.format)
      ..writeByte(6)
      ..write(obj.courseId)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.duration)
      ..writeByte(9)
      ..write(obj.attachmentUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
