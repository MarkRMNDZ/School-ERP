import 'dart:convert';

import 'package:school_erp/features/shared/api_client.dart';

class PowerSyncApiClient extends ApiClient {
  PowerSyncApiClient({
    super.httpClient,
    super.storage,
  });

  Future<void> upsertRecord(Map<String, dynamic> record) async {
    await put('/api/upload_data', record);
  }

  Future<void> updateRecord(Map<String, dynamic> record) async {
    await patch('/api/upload_data', record);
  }

  Future<void> deleteRecord(Map<String, dynamic>? record) async {
    await httpClient.delete(Uri.http(baseUrl, '/api/upload_data'),
        headers: await super.getHeaders(),
        body: record != null ? jsonEncode(record) : null);
  }

  Future<Map<String, dynamic>> getPowersyncToken() async {
    final res = await get('/api/get_powersync_token');
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to fetch powersync token ${res.statusCode}');
    }
  }
}
