import 'package:powersync/powersync.dart';
import 'package:school_erp/models/schema.dart';

late final PowerSyncDatabase testDB;
bool _dbInitialized = false;

Future<void> openTestDatabase() async {
  if (!_dbInitialized) {
    testDB = PowerSyncDatabase(
      schema: schema,
      path: 'test.db',
      logger: attachedLogger,
    );
    await testDB.initialize();
  }
}
