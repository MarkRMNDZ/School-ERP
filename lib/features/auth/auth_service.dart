import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class UserNotLoggedInException implements Exception {}

class AuthService {
  AuthService(this.authRepository, {FlutterSecureStorage? storage})
      : storage = storage ?? const FlutterSecureStorage();

  AuthRepository authRepository;
  FlutterSecureStorage storage;

  Future<AuthResult> login(String email, password) async {
    // TODO: handle potential errors
    final result = await authRepository.login(email, password);

    if (result is AuthRequestSuccess) {
      await storage.write(
        key: 'user',
        value: jsonEncode(
          result.user.toJson(),
        ),
      );
      await storage.write(key: 'access_token', value: result.accessToken);
    }
    return result;
  }

  Future<bool> logout() async {
    if (await isLoggedIn() == false) {
      throw UserNotLoggedInException();
    }
    // TODO: handle potential errors
    final token = await getToken();
    final result = await authRepository.logout(token!);

    if (result) {
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'user');
    }
    return result;
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<bool> isLoggedIn() async {
    final user = await storage.read(key: 'user');
    return user != null;
  }

  Future<AuthenticatedUser?> getUser() async {
    if (await isLoggedIn() == false) {
      return null;
    }
    final userData = await storage.read(key: 'user');
    return AuthenticatedUser.fromJson(jsonDecode(userData!));
  }
}
