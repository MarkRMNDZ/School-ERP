
import 'dart:convert';

import 'package:school_erp/features/shared/http_response/http_result.dart';
import 'package:school_erp/features/shared/api_service.dart';

import 'schemas/schemas.dart';
import 'package:school_erp/features/shared/constants/http_status.dart';
import 'package:http/http.dart' as http;

// TODO: handling access token expiries and refresh token

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<AuthResult> login(String email, String password) async {

    try {
      final clientToken =  await _apiService.getClientToken();
      final http.Response res = await _apiService.post('api/login',
          body: {
            "email": email,
            "password": password
          },
          headers: {
            "Authorization" : "Bearer $clientToken"
          }
      );

      final loginResponse = HttpResult.fromResponse(res);

      if (loginResponse.statusCode != HttpStatus.ok) {
          return AuthResult.failure(loginResponse.statusCode, loginResponse.message);
      }

      return AuthRequestSuccess.fromJson(loginResponse.data);
    }catch (e) {
      return AuthResult.failure(500,e.toString());
    }
  }

  Future<bool> logout(String accessToken) async {
    
    try {
      final http.Response res = await _apiService.post('api/logout');
      final logoutResponse = HttpResult.fromResponse(res);
      return logoutResponse.statusCode == HttpStatus.ok;
    }catch (e) {
      print("Error logging out: $e");
      return false;
    }
  }

}
