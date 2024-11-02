import 'package:powersync/powersync.dart';
import 'package:school_erp/dtos/assessment/assessment_taker_create_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_update_dto.dart';
import 'package:school_erp/models/tables/assessment_takers_table.dart';
import 'package:school_erp/repositories/base_crud_repository.dart';

class AssessmentTakerRepository
    extends BaseCrudRepository<AssessmentTakerCreateDTO, AssessmentUpdateDTO> {
  AssessmentTakerRepository({required PowerSyncDatabase database})
      : super(table: assessmentTakersTable, database: database);

  @override
  Map<String, dynamic> toCreateMap(AssessmentTakerCreateDTO dto) {
    return {
      'assessment_id': dto.assessmentId,
      'section_id': dto.sectionId,
      'subject_year_id': dto.subjectYearId,
    };
  }

  @override
  Map<String, dynamic> toUpdateMap(AssessmentUpdateDTO dto) {
    return {
      'status': 'no implementation', // no implementation yet
    };
  }
}
