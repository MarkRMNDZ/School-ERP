import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/dtos/dto.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;

abstract class BaseCrudRepository<C extends CreateDTO, U extends UpdateDTO> {
  final Table table;
  final PowerSyncDatabase database;

  BaseCrudRepository({required this.table, PowerSyncDatabase? database})
      : database = database ?? ps.db;

  Map<String, dynamic> toCreateMap(C dto);
  Map<String, dynamic> toUpdateMap(U dto);

  Future<ResultSet> create(C dto) async {
    final map = toCreateMap(dto);
    return await database.execute(
      await _sqlCreateStatement(map),
      map.values.toList(),
    );
  }

  Future<ResultSet> createTransaction(C dto, SqliteWriteContext tx) async {
    final map = toCreateMap(dto);
    return await tx.execute(
      await _sqlCreateStatement(map),
      map.values.toList(),
    );
  }

  Future<String> _sqlCreateStatement(Map<String, dynamic> map) async {
    _validateMapKeys(map);

    final columns = ['id', ...map.keys];
    final placeholders = ['uuid()', ...List.filled(map.length, '?')];
    _addCreatedAtUpdatedAt(columns, placeholders);

    if (table.columns.any((column) => column.name == 'updated_at')) {
      columns.add('updated_at');
      placeholders.add('datetime(\'now\')');
    }

    final queryString = """
      INSERT INTO ${table.name} (${columns.join(', ')})
      VALUES (${placeholders.join(', ')})
      RETURNING *
    """;

    return queryString;
  }

  Future<ResultSet> update(U dto) {
    final map = toUpdateMap(dto);
    _validateMapKeys(map);

    final setClause = map.keys.map((key) => '$key = ?').join(', ');

    return database.execute(
      """
      UPDATE ${table.name}
      SET $setClause
      WHERE id = ?
      RETURNING *
      """,
      [...map.values, dto.id],
    );
  }

  void _validateMapKeys(Map<String, dynamic> map) {
    final columnNames =
        table.columns.map((Column column) => column.name).toList();
    for (final key in map.keys) {
      if (!columnNames.contains(key)) {
        throw ArgumentError('Invalid column name: $key');
      }
    }
  }

  void _addCreatedAtUpdatedAt(
      List<String> columns, List<dynamic> placeholders) {
    if (table.columns.any((column) => column.name == 'created_at')) {
      columns.add('created_at');
      placeholders.add('datetime(\'now\')');
    }
    if (table.columns.any((column) => column.name == 'updated_at')) {
      columns.add('updated_at');
      placeholders.add('datetime(\'now\')');
    }
  }
}
