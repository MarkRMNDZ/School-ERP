import 'package:powersync/powersync.dart';
import 'package:school_erp/dtos/assessment/assessment_update_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/models/tables/assessments_table.dart';
import 'package:school_erp/repositories/base_crud_repository.dart';

class AssessmentRepository
    extends BaseCrudRepository<AssessmentCreateDTO, AssessmentUpdateDTO> {
  AssessmentRepository({required PowerSyncDatabase database})
      : super(table: assessmentsTable, database: database);

  @override
  Map<String, dynamic> toCreateMap(AssessmentCreateDTO dto) {
    return {
      'prepared_by': dto.preparedById,
      'assessment_type': dto.assessmentType.value,
      'title': dto.title,
      'total_questions': dto.totalQuestions,
      'start_time': dto.startTime.toIso8601String(),
      'dead_line': dto.deadLine.toIso8601String(),
      'duration_mins': dto.durationMinutes,
      'status': dto.status.value,
    };
  }

  @override
  Map<String, dynamic> toUpdateMap(AssessmentUpdateDTO dto) {
    return {
      'status': 'no implementation', // no implementation yet
    };
  }
}
