import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/utils/sql_statements.dart';

class Assessment {
  final String id;
  final String subject;
  final String preparedById;
  final AssessmentType assessmentType;
  final String title;
  final int totalQuestions;
  final DateTime startTime;
  final DateTime deadLine;
  final int? durationMinutes;
  final AssessmentStatus status;

  Assessment({
    required this.id,
    required this.subject,
    required this.preparedById,
    required this.assessmentType,
    required this.title,
    required this.totalQuestions,
    required this.startTime,
    required this.deadLine,
    this.durationMinutes,
    required this.status,
  });

  factory Assessment.fromRow(sqlite.Row row) {
    return Assessment(
      id: row['id'],
      subject: row['subject_name'],
      preparedById: row['prepared_by'],
      assessmentType: AssessmentType.fromString(row['assessment_type']),
      title: row['title'],
      totalQuestions: row['total_questions'],
      startTime: DateTime.parse(row['start_time']),
      deadLine: DateTime.parse(row['dead_line']),
      durationMinutes: row['duration_mins'],
      status: AssessmentStatus.fromString(row['status']),
    );
  }

  static Stream<List<Assessment?>> watchLists(AssessmentType assessmentType) {
    return db.watch(
      assessmentsSql,
      parameters: [assessmentType.value],
    ).map((results) {
      return results.map(Assessment.fromRow).toList(growable: false);
    });
  }
}
