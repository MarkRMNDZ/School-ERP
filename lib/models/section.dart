import 'package:powersync/sqlite3_common.dart' as sqlite;

class Section {
  final String id;
  final String academicYearId;
  final String? advisorId;
  final String name;

  Section({
    required this.id,
    required this.name,
    required this.academicYearId,
    this.advisorId,
  });

  factory Section.fromRow(sqlite.Row row) {
    return Section(
      id: row['id'],
      academicYearId: row['academic_year_id'],
      advisorId: row['advisor_id'],
      name: row['name'],
    );
  }
}
