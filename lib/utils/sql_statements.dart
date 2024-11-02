// GENERAL
const assessmentsSql = """
  SELECT assessments.*, subjects.name AS subject_name
  FROM assessments
  LEFT JOIN assessment_takers ON assessment_takers.assessment_id = assessments.id
  LEFT JOIN subject_years ON subject_years.id = assessment_takers.subject_year_id
  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
  WHERE assessment_type = ?
  ORDER BY created_at DESC
""";

// TEACHER
// on the assumption that only the current academic year gets synced
const teacherActiveSubjectsSql = """
  SELECT subject_years.*, subjects.name AS subject_name
  FROM teacher_subjects
  LEFT JOIN subject_years ON subject_years.id = teacher_subjects.subject_year_id
  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
""";

const teacherActiveSectionsSql = """
  SELECT sections.*
  FROM teacher_sections
  LEFT JOIN sections ON sections.id = teacher_sections.section_id
""";

const defaultSqlConsoleQuery = """
  SELECT * FROM ps_crud
""";
