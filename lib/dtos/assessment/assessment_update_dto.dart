import 'package:school_erp/dtos/dto.dart';
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';

class AssessmentUpdateDTO extends UpdateDTO {
  @override
  final String id;
  final AssessmentType assessmentType;
  final String preparedById;
  final String subjectYearId;
  final String sectionId;
  final String title;
  final int totalQuestions;
  final bool randomizeSequence;
  final DateTime startTime;
  final DateTime deadLine;
  final int? durationMinutes;
  final AssessmentStatus status;

  AssessmentUpdateDTO({
    required this.id,
    required this.assessmentType,
    required this.preparedById,
    required this.subjectYearId,
    required this.sectionId,
    required this.title,
    required this.totalQuestions,
    required this.randomizeSequence,
    required this.startTime,
    required this.deadLine,
    this.durationMinutes,
  }) : status = AssessmentStatus.toBeCompleted;
}
