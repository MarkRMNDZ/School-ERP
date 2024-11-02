import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_taker_create_dto.dart';
import 'package:school_erp/repositories/assessment_repository.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/repositories/assessment_taker_repository.dart';

class AssessmentService {
  late PowerSyncDatabase db;
  late AssessmentRepository assessmentRepository;
  late AssessmentTakerRepository assessmentTakerRepository;

  AssessmentService({PowerSyncDatabase? database}) {
    db = database ?? ps.db;
    assessmentRepository = AssessmentRepository(database: db);
    assessmentTakerRepository = AssessmentTakerRepository(database: db);
  }

  Future<(bool, (ResultSet, ResultSet))> create({
    required AssessmentCreateDTOBuilder assessmentDTOBuilder,
    required AssessmentTakerCreateDTOBuilder assessmentTakerDTOBuilder,
  }) async {
    try {
      final result = await db.writeTransaction((tx) async {
        final ResultSet resultAssessment = await assessmentRepository
            .createTransaction(assessmentDTOBuilder.build(), tx);

        assessmentTakerDTOBuilder.assessmentId = resultAssessment.first['id'];

        final ResultSet resultAssessmentTaker = await assessmentTakerRepository
            .createTransaction(assessmentTakerDTOBuilder.build(), tx);

        return (true, (resultAssessment, resultAssessmentTaker));
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
