// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 2;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      id: fields[0] as String,
      title: fields[1] as String,
      instructor: fields[2] as String,
      description: fields[3] as String,
      syllabus: fields[4] as String,
      level: fields[5] as CourseLevel,
      language: fields[6] as CourseLanguage,
      progress: fields[7] as double,
      tags: (fields[8] as List).cast<String>(),
      categoryIds: (fields[9] as List).cast<String>(),
      lessonIds: (fields[10] as List).cast<String>(),
      completedLessonIds: (fields[41] as List).cast<String>(),
      createdAt: fields[11] as DateTime?,
      updatedAt: fields[12] as DateTime?,
      publishedAt: fields[13] as DateTime?,
      isPublished: fields[14] as bool,
      isArchived: fields[15] as bool,
      ratingAverage: fields[16] as double,
      ratingCount: fields[17] as int,
      enrollmentCount: fields[18] as int,
      metadata: (fields[19] as Map).cast<String, String>(),
      remoteId: fields[20] as String?,
      lastSyncedAt: fields[21] as DateTime?,
      dirty: fields[22] as bool,
      startDate: fields[23] as DateTime?,
      endDate: fields[24] as DateTime?,
      isFavorite: fields[25] as bool,
      lastAccessedAt: fields[26] as DateTime?,
      slug: fields[27] as String?,
      location: fields[28] as String?,
      latitude: fields[29] as double?,
      longitude: fields[30] as double?,
      mapsUrl: fields[31] as String?,
      imageUrl: fields[32] as String?,
      isCompleted: fields[33] as bool,
      isEnrolled: fields[34] as bool,
      isPaid: fields[35] as bool,
      isActive: fields[36] as bool,
      duration: fields[37] as String,
      audience: fields[38] as String,
      assignedTo: fields[39] as String,
      instructorId: fields[40] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(42)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.instructor)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.syllabus)
      ..writeByte(5)
      ..write(obj.level)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.progress)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.categoryIds)
      ..writeByte(10)
      ..write(obj.lessonIds)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.publishedAt)
      ..writeByte(14)
      ..write(obj.isPublished)
      ..writeByte(15)
      ..write(obj.isArchived)
      ..writeByte(16)
      ..write(obj.ratingAverage)
      ..writeByte(17)
      ..write(obj.ratingCount)
      ..writeByte(18)
      ..write(obj.enrollmentCount)
      ..writeByte(19)
      ..write(obj.metadata)
      ..writeByte(20)
      ..write(obj.remoteId)
      ..writeByte(21)
      ..write(obj.lastSyncedAt)
      ..writeByte(22)
      ..write(obj.dirty)
      ..writeByte(23)
      ..write(obj.startDate)
      ..writeByte(24)
      ..write(obj.endDate)
      ..writeByte(25)
      ..write(obj.isFavorite)
      ..writeByte(26)
      ..write(obj.lastAccessedAt)
      ..writeByte(27)
      ..write(obj.slug)
      ..writeByte(28)
      ..write(obj.location)
      ..writeByte(29)
      ..write(obj.latitude)
      ..writeByte(30)
      ..write(obj.longitude)
      ..writeByte(31)
      ..write(obj.mapsUrl)
      ..writeByte(32)
      ..write(obj.imageUrl)
      ..writeByte(33)
      ..write(obj.isCompleted)
      ..writeByte(34)
      ..write(obj.isEnrolled)
      ..writeByte(35)
      ..write(obj.isPaid)
      ..writeByte(36)
      ..write(obj.isActive)
      ..writeByte(37)
      ..write(obj.duration)
      ..writeByte(38)
      ..write(obj.audience)
      ..writeByte(39)
      ..write(obj.assignedTo)
      ..writeByte(40)
      ..write(obj.instructorId)
      ..writeByte(41)
      ..write(obj.completedLessonIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
