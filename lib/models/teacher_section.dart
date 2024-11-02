import 'package:powersync/sqlite3_common.dart' as sqlite;

class TeacherSection {
  final String id;
  final String teacherId;
  final String sectionId;

  TeacherSection({
    required this.id,
    required this.teacherId,
    required this.sectionId,
  });

  factory TeacherSection.fromRow(sqlite.Row row) {
    return TeacherSection(
      id: row['id'],
      teacherId: row['teacher_id'],
      sectionId: row['section_id'],
    );
  }
}
