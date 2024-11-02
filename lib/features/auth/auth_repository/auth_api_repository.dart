import 'schemas/schemas.dart';
import 'package:school_erp/features/shared/constants/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

// TODO: handling access token expiries and refresh token
// TODO: update and use ApiClient
class AuthRepository {
  AuthRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  String get baseUrl => dotenv.get('BASE_URL');
  String get clientSecret => dotenv.get('CLIENT_SECRET');
  String get clientId => dotenv.get('CLIENT_ID');

  Future<AuthResult> login(String email, String password) async {
    try {
      final clientToken = await _getClientToken();
      final uri = Uri.http(baseUrl, "/api/login");
      final res = await _httpClient.post(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $clientToken",
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      final parsed = jsonDecode(res.body);
      final String message = parsed['message'] ?? '';
      final data = parsed['data'];

      if (res.statusCode != HttpStatus.ok) {
        return AuthResult.failure(res.statusCode, message);
      }
      return AuthRequestSuccess.fromJson(data);
    } catch (e) {
      print(e);
      return AuthResult.failure(500, e.toString());
    }
  }

  Future<bool> logout(String accessToken) async {
    final uri = Uri.http(baseUrl, "/api/logout");
    final res = await _httpClient.post(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    return (res.statusCode == HttpStatus.ok);
  }

  Future<String> _getClientToken() async {
    final uri = Uri.http(baseUrl, "/oauth/token");
    final res = await _httpClient.post(uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "grant_type": "client_credentials",
          "client_id": clientId,
          "client_secret": clientSecret
        }));
    final parsed = jsonDecode(res.body);
    print(res.body);
    final String accessToken = parsed['access_token'];
    print(accessToken);

    return accessToken;
  }
}
