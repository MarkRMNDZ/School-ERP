import 'package:school_erp/dtos/dto.dart';
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';

class AssessmentCreateDTO extends CreateDTO {
  final AssessmentType assessmentType;
  final String preparedById;
  final String title;
  final int totalQuestions;
  final bool randomizeSequence;
  final DateTime startTime;
  final DateTime deadLine;
  final int? durationMinutes;
  final AssessmentStatus status;

  AssessmentCreateDTO({
    required this.assessmentType,
    required this.preparedById,
    required this.title,
    required this.totalQuestions,
    required this.randomizeSequence,
    required this.startTime,
    required this.deadLine,
    this.durationMinutes,
  }) : status = AssessmentStatus.toBeCompleted;
}

class AssessmentCreateDTOBuilder {
  late AssessmentType assessmentType;
  late String preparedById;
  late String subjectYearId;
  late String sectionId;
  late String title;
  late int totalQuestions;
  late bool randomizeSequence;
  late DateTime startTime;
  late DateTime deadLine;
  late int? durationMinutes;

  AssessmentCreateDTOBuilder() {
    durationMinutes = null;
  }

  AssessmentCreateDTO build() {
    return AssessmentCreateDTO(
      assessmentType: assessmentType,
      preparedById: preparedById,
      title: title,
      totalQuestions: totalQuestions,
      randomizeSequence: randomizeSequence,
      startTime: startTime,
      deadLine: deadLine,
      durationMinutes: durationMinutes,
    );
  }
}
