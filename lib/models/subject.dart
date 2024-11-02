import 'package:powersync/sqlite3_common.dart' as sqlite;

class Subject {
  final String id;
  final String name;

  Subject({
    required this.id,
    required this.name,
  });

  factory Subject.fromRow(sqlite.Row row) {
    return Subject(
      id: row['id'],
      name: row['name'],
    );
  }
}
