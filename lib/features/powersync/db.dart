import 'package:school_erp/models/schema.dart';
import 'package:logging/logging.dart';

import 'package:powersync/powersync.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'backend_connector.dart';

final Logger attachedLogger = Logger('Powersync');

// global ref to db
late final PowerSyncDatabase db;
bool _dbInitialized = false;
FlutterSecureStorage storage = const FlutterSecureStorage();

Future<String> getDatabasePath() async {
  final dir = await getApplicationSupportDirectory();
  return join(dir.path, 'school-erp.db');
}

Future<void> openDatabase() async {
  if (!_dbInitialized) {
    db = PowerSyncDatabase(
      schema: schema,
      path: await getDatabasePath(),
      logger: attachedLogger,
    );
    await db.initialize();

    _dbInitialized = true;
  }

  if (await isLoggedIn()) {
    final connector = SchoolERPBackendConnector();
    db.connect(connector: connector);
  }
}

Future<bool> isLoggedIn() async {
  final user = await storage.read(key: 'user');
  return user != null;
}
