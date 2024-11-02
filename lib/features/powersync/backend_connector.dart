import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:powersync/powersync.dart';
import 'package:logging/logging.dart';
import 'package:school_erp/features/auth/auth_repository/auth_api_repository.dart';
import 'package:school_erp/features/auth/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './powersync_api_client.dart';

final log = Logger('powersync-backend');

class SchoolERPBackendConnector extends PowerSyncBackendConnector {
  final FlutterSecureStorage storage;
  final AuthService authService;

  SchoolERPBackendConnector()
      : storage = const FlutterSecureStorage(),
        authService = AuthService(AuthRepository());

  final PowerSyncApiClient apiClient = PowerSyncApiClient();

  String get powersyncUrl {
    if (kIsWeb) {
      return dotenv.get('POWERSYNC_URL_WEB');
    }
    return dotenv.get('POWERSYNC_URL');
  }

  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    final user = await authService.getUser();
    if (user == null) {
      throw Exception('User is not logged in');
    }
    final session = await apiClient.getPowersyncToken();
    return PowerSyncCredentials(
        endpoint: powersyncUrl, token: session['token']);
  }

  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();

    if (transaction == null) {
      return;
    }

    try {
      for (var op in transaction.crud) {
        final record = {
          'table': op.table,
          'data': {'id': op.id, ...?op.opData},
        };

        switch (op.op) {
          case UpdateType.put:
            await apiClient.upsertRecord(record);
            break;
          case UpdateType.patch:
            await apiClient.updateRecord(record);
            break;
          case UpdateType.delete:
            await apiClient.deleteRecord(record);
            break;
        }
      }
      await transaction.complete();
    } on Exception catch (e) {
      log.severe('Error uploading data', e);
      // Error may be retryable - e.g. network error or temporary server error.
      // Throwing an error here causes this call to be retried after a delay.
      rethrow;
    }
  }
}
