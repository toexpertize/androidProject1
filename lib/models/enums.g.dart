// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRoleAdapter extends TypeAdapter<UserRole> {
  @override
  final int typeId = 1;

  @override
  UserRole read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserRole.admin;
      case 1:
        return UserRole.teacher;
      case 2:
        return UserRole.student;
      default:
        return UserRole.admin;
    }
  }

  @override
  void write(BinaryWriter writer, UserRole obj) {
    switch (obj) {
      case UserRole.admin:
        writer.writeByte(0);
        break;
      case UserRole.teacher:
        writer.writeByte(1);
        break;
      case UserRole.student:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CourseCategoryAdapter extends TypeAdapter<CourseCategory> {
  @override
  final int typeId = 2;

  @override
  CourseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CourseCategory.programming;
      case 1:
        return CourseCategory.design;
      case 2:
        return CourseCategory.business;
      case 3:
        return CourseCategory.marketing;
      case 4:
        return CourseCategory.science;
      case 5:
        return CourseCategory.language;
      default:
        return CourseCategory.programming;
    }
  }

  @override
  void write(BinaryWriter writer, CourseCategory obj) {
    switch (obj) {
      case CourseCategory.programming:
        writer.writeByte(0);
        break;
      case CourseCategory.design:
        writer.writeByte(1);
        break;
      case CourseCategory.business:
        writer.writeByte(2);
        break;
      case CourseCategory.marketing:
        writer.writeByte(3);
        break;
      case CourseCategory.science:
        writer.writeByte(4);
        break;
      case CourseCategory.language:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentFormatAdapter extends TypeAdapter<ContentFormat> {
  @override
  final int typeId = 3;

  @override
  ContentFormat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContentFormat.video;
      case 1:
        return ContentFormat.pdf;
      case 2:
        return ContentFormat.text;
      case 3:
        return ContentFormat.quiz;
      default:
        return ContentFormat.video;
    }
  }

  @override
  void write(BinaryWriter writer, ContentFormat obj) {
    switch (obj) {
      case ContentFormat.video:
        writer.writeByte(0);
        break;
      case ContentFormat.pdf:
        writer.writeByte(1);
        break;
      case ContentFormat.text:
        writer.writeByte(2);
        break;
      case ContentFormat.quiz:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentFormatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionTypeAdapter extends TypeAdapter<QuestionType> {
  @override
  final int typeId = 4;

  @override
  QuestionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return QuestionType.multipleChoice;
      case 1:
        return QuestionType.trueFalse;
      case 2:
        return QuestionType.shortAnswer;
      default:
        return QuestionType.multipleChoice;
    }
  }

  @override
  void write(BinaryWriter writer, QuestionType obj) {
    switch (obj) {
      case QuestionType.multipleChoice:
        writer.writeByte(0);
        break;
      case QuestionType.trueFalse:
        writer.writeByte(1);
        break;
      case QuestionType.shortAnswer:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DifficultyLevelAdapter extends TypeAdapter<DifficultyLevel> {
  @override
  final int typeId = 5;

  @override
  DifficultyLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DifficultyLevel.beginner;
      case 1:
        return DifficultyLevel.intermediate;
      case 2:
        return DifficultyLevel.advanced;
      default:
        return DifficultyLevel.beginner;
    }
  }

  @override
  void write(BinaryWriter writer, DifficultyLevel obj) {
    switch (obj) {
      case DifficultyLevel.beginner:
        writer.writeByte(0);
        break;
      case DifficultyLevel.intermediate:
        writer.writeByte(1);
        break;
      case DifficultyLevel.advanced:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultyLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EnrollmentStatusAdapter extends TypeAdapter<EnrollmentStatus> {
  @override
  final int typeId = 6;

  @override
  EnrollmentStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EnrollmentStatus.enrolled;
      case 1:
        return EnrollmentStatus.completed;
      case 2:
        return EnrollmentStatus.dropped;
      case 3:
        return EnrollmentStatus.pending;
      default:
        return EnrollmentStatus.enrolled;
    }
  }

  @override
  void write(BinaryWriter writer, EnrollmentStatus obj) {
    switch (obj) {
      case EnrollmentStatus.enrolled:
        writer.writeByte(0);
        break;
      case EnrollmentStatus.completed:
        writer.writeByte(1);
        break;
      case EnrollmentStatus.dropped:
        writer.writeByte(2);
        break;
      case EnrollmentStatus.pending:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnrollmentStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationTypeAdapter extends TypeAdapter<NotificationType> {
  @override
  final int typeId = 7;

  @override
  NotificationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationType.announcement;
      case 1:
        return NotificationType.assignmentDue;
      case 2:
        return NotificationType.gradeUpdate;
      case 3:
        return NotificationType.newContent;
      default:
        return NotificationType.announcement;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationType obj) {
    switch (obj) {
      case NotificationType.announcement:
        writer.writeByte(0);
        break;
      case NotificationType.assignmentDue:
        writer.writeByte(1);
        break;
      case NotificationType.gradeUpdate:
        writer.writeByte(2);
        break;
      case NotificationType.newContent:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuizStatusAdapter extends TypeAdapter<QuizStatus> {
  @override
  final int typeId = 8;

  @override
  QuizStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return QuizStatus.notStarted;
      case 1:
        return QuizStatus.inProgress;
      case 2:
        return QuizStatus.completed;
      case 3:
        return QuizStatus.graded;
      default:
        return QuizStatus.notStarted;
    }
  }

  @override
  void write(BinaryWriter writer, QuizStatus obj) {
    switch (obj) {
      case QuizStatus.notStarted:
        writer.writeByte(0);
        break;
      case QuizStatus.inProgress:
        writer.writeByte(1);
        break;
      case QuizStatus.completed:
        writer.writeByte(2);
        break;
      case QuizStatus.graded:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubmissionStatusAdapter extends TypeAdapter<SubmissionStatus> {
  @override
  final int typeId = 9;

  @override
  SubmissionStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubmissionStatus.notSubmitted;
      case 1:
        return SubmissionStatus.submitted;
      case 2:
        return SubmissionStatus.graded;
      case 3:
        return SubmissionStatus.late;
      default:
        return SubmissionStatus.notSubmitted;
    }
  }

  @override
  void write(BinaryWriter writer, SubmissionStatus obj) {
    switch (obj) {
      case SubmissionStatus.notSubmitted:
        writer.writeByte(0);
        break;
      case SubmissionStatus.submitted:
        writer.writeByte(1);
        break;
      case SubmissionStatus.graded:
        writer.writeByte(2);
        break;
      case SubmissionStatus.late:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserStatusAdapter extends TypeAdapter<UserStatus> {
  @override
  final int typeId = 10;

  @override
  UserStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserStatus.active;
      case 1:
        return UserStatus.inactive;
      case 2:
        return UserStatus.suspended;
      default:
        return UserStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, UserStatus obj) {
    switch (obj) {
      case UserStatus.active:
        writer.writeByte(0);
        break;
      case UserStatus.inactive:
        writer.writeByte(1);
        break;
      case UserStatus.suspended:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CourseLevelAdapter extends TypeAdapter<CourseLevel> {
  @override
  final int typeId = 11;

  @override
  CourseLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CourseLevel.beginner;
      case 1:
        return CourseLevel.intermediate;
      case 2:
        return CourseLevel.advanced;
      default:
        return CourseLevel.beginner;
    }
  }

  @override
  void write(BinaryWriter writer, CourseLevel obj) {
    switch (obj) {
      case CourseLevel.beginner:
        writer.writeByte(0);
        break;
      case CourseLevel.intermediate:
        writer.writeByte(1);
        break;
      case CourseLevel.advanced:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CourseLanguageAdapter extends TypeAdapter<CourseLanguage> {
  @override
  final int typeId = 12;

  @override
  CourseLanguage read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CourseLanguage.en;
      case 1:
        return CourseLanguage.ar;
      default:
        return CourseLanguage.en;
    }
  }

  @override
  void write(BinaryWriter writer, CourseLanguage obj) {
    switch (obj) {
      case CourseLanguage.en:
        writer.writeByte(0);
        break;
      case CourseLanguage.ar:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
