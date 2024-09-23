import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final http.Client _httpClient;
  final FlutterSecureStorage storage;
  String? _accessToken;

  ApiService({http.Client? httpClient, this.storage = const FlutterSecureStorage()})
      : _httpClient = httpClient ?? http.Client();

  String get baseUrl {
    if (kIsWeb) {
      return dotenv.get('BASE_URL_WEB');
    }
    return dotenv.get('BASE_URL');
  }

  String get clientSecret => dotenv.get('CLIENT_SECRET');
  String get clientId => dotenv.get('CLIENT_ID');

  // Method to set or update access token
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    await storage.write(key: 'access_token', value: token); // Save to secure storage
  }

  // Load access token from storage if not already set
  Future<void> _loadAccessToken() async {
    _accessToken ??= await storage.read(key: 'access_token');
  }

  // Add the Authorization header automatically if an access token is present
  Map<String, String> _getHeaders([Map<String, String>? headers]) {
    final defaultHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    // Ensure the access token is loaded
    _loadAccessToken().then((_) {
      if (_accessToken != null) {
        defaultHeaders["Authorization"] = "Bearer $_accessToken";
      }
    });

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return defaultHeaders;
  }

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final uri = Uri.http(baseUrl, path);
    final response = await _httpClient.get(uri, headers: await _getHeaders(headers));
    return _handleResponse(response);
  }

  Future<http.Response> post(String path, {dynamic body, Map<String, String>? headers}) async {
    final uri = Uri.http(baseUrl, path);
    final finalHeaders =  await _getHeaders(headers);
    final response = await _httpClient.post(
      uri,
      headers: finalHeaders,
      body: body != null ? jsonEncode(body) : null, // Handle null body
    );
    print(finalHeaders);
    print(response.body);

    return _handleResponse(response);
  }

  Future<http.Response> put(String path, {dynamic body, Map<String, String>? headers}) async {
    final uri = Uri.http(baseUrl, path);
    final response = await _httpClient.put(
      uri,
      headers: await _getHeaders(headers),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<http.Response> delete(String path, {Map<String, String>? headers}) async {
    final uri = Uri.http(baseUrl, path);
    final response = await _httpClient.delete(uri, headers: await _getHeaders(headers));
    return _handleResponse(response);
  }

  Future<http.Response> patch(String path, {Map<String, String>? headers, dynamic body}) async {
    final uri = Uri.http(baseUrl, path);
    final response = await _httpClient.patch(
      uri,
      headers: await _getHeaders(headers),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<String> getClientToken() async {
    final uri = Uri.http(baseUrl, "/oauth/token");
    final res = await _httpClient.post(uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "grant_type": "client_credentials",
          "client_id": clientId,
          "client_secret": clientSecret
        }));
    
    if (res.statusCode == 200) {
      final parsed = jsonDecode(res.body);
      final String accessToken = parsed['access_token'];
      await setAccessToken(accessToken); // Save token
      return accessToken;
    } else {
      throw Exception('Failed to get client token: ${res.statusCode}');
    }
  }
}
