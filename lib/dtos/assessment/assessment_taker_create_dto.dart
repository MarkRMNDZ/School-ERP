import 'package:school_erp/dtos/dto.dart';

class AssessmentTakerCreateDTO extends CreateDTO {
  final String assessmentId;
  final String subjectYearId;
  final String sectionId;

  AssessmentTakerCreateDTO({
    required this.assessmentId,
    required this.subjectYearId,
    required this.sectionId,
  });
}

class AssessmentTakerCreateDTOBuilder {
  late String assessmentId;
  late String subjectYearId;
  late String sectionId;

  AssessmentTakerCreateDTOBuilder();

  AssessmentTakerCreateDTO build() {
    return AssessmentTakerCreateDTO(
      assessmentId: assessmentId,
      subjectYearId: subjectYearId,
      sectionId: sectionId,
    );
  }
}
