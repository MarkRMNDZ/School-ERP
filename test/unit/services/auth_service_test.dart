import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:school_erp/features/auth/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthService authService;
  late MockAuthRepository mockAuthRepository;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    authService =
        AuthService(mockAuthRepository, storage: mockFlutterSecureStorage);

    when(() => mockFlutterSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenAnswer((_) async => Future.value());

    when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
        .thenAnswer((_) async => Future.value());
  });

  group('AuthService', () {
    const email = 'test@example.com';
    const password = 'password123';
    const accessToken = 'access_token';
    const user = AuthenticatedUser(
      id: 1,
      email: email,
      firstName: 'Test',
      lastName: 'User',
    );

    test('login saves user and access token on success', () async {
      const authResult = AuthRequestSuccess(user, accessToken);
      when(() => mockAuthRepository.login(email, password))
          .thenAnswer((_) async => authResult);

      final result = await authService.login(email, password);

      expect(result, authResult);
      verify(() => mockFlutterSecureStorage.write(
          key: 'user', value: jsonEncode(user.toJson()))).called(1);
      verify(() => mockFlutterSecureStorage.write(
          key: 'access_token', value: accessToken)).called(1);
    });

    test('logout deletes user and access token on success', () async {
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => accessToken);
      when(() => mockAuthRepository.logout(accessToken))
          .thenAnswer((_) async => true);

      final result = await authService.logout();

      expect(result, true);
      verify(() => mockFlutterSecureStorage.delete(key: 'access_token'))
          .called(1);
      verify(() => mockFlutterSecureStorage.delete(key: 'user')).called(1);
    });

    test('getToken returns access token', () async {
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => accessToken);

      final token = await authService.getToken();

      expect(token, accessToken);
      verify(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .called(1);
    });

    test('isLoggedIn returns true if token is stored', () async {
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => accessToken);

      final isLoggedIn = await authService.isLoggedIn();

      expect(isLoggedIn, true);
      verify(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .called(1);
    });

    test('isLoggedIn returns false if no token is stored', () async {
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => null);

      final isLoggedIn = await authService.isLoggedIn();

      expect(isLoggedIn, false);
      verify(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .called(1);
    });

    test('getUser returns the user if logged in', () async {
      when(() => mockFlutterSecureStorage.read(key: 'user'))
          .thenAnswer((_) async => jsonEncode(user.toJson()));
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => accessToken);

      final result = await authService.getUser();

      expect(result, user);
      verify(() => mockFlutterSecureStorage.read(key: 'user')).called(1);
    });

    test('getUser throws UserNotLoggedInException if not logged in', () async {
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => null);

      expect(() => authService.getUser(),
          throwsA(isA<UserNotLoggedInException>()));
    });
  });
}
