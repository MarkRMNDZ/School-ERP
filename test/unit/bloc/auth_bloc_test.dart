import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_erp/features/auth/auth.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthService mockAuthService;
  late AuthBloc authBloc;

  // test user info
  const int id = 1;
  const String email = 'text@example.com';
  const String firstName = 'Test';
  const String lastName = 'User';
  const String role = 'teacher';

  setUp(() {
    mockAuthService = MockAuthService();
    authBloc = AuthBloc(mockAuthService);
  });

  tearDown(() {
    authBloc.close();
  });

  blocTest<AuthBloc, AuthState>(
    'emits [Authenticated] when AuthCheckRequested is added and user is logged in',
    build: () {
      when(() => mockAuthService.isLoggedIn()).thenAnswer((_) async => true);
      when(() => mockAuthService.getToken())
          .thenAnswer((_) async => 'mockAccessToken');
      when(() => mockAuthService.getUser()).thenAnswer(
        (_) async => const AuthenticatedUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          role: role,
        ),
      );
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthCheckRequested()),
    expect: () => [
      const AuthState.authenticated(
        AuthenticatedUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          role: role,
        ),
        'mockAccessToken',
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [Unauthenticated] when AuthCheckRequested is added and user is not logged in',
    build: () {
      when(() => mockAuthService.isLoggedIn()).thenAnswer((_) async => false);
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthCheckRequested()),
    expect: () => [const AuthState.unauthenticated()],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Authenticated] when LoginRequested is successful',
    build: () {
      when(() => mockAuthService.login(any(), any()))
          .thenAnswer((_) async => const AuthRequestSuccess(
                AuthenticatedUser(
                  id: id,
                  email: email,
                  firstName: firstName,
                  lastName: lastName,
                  role: role,
                ),
                'mockAccessToken',
              ));
      return authBloc;
    },
    act: (bloc) => bloc.add(LoginRequested('test@example.com', 'password')),
    expect: () => [
      const AuthState.loading(),
      const AuthState.authenticated(
        AuthenticatedUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          role: role,
        ),
        'mockAccessToken',
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Failure] when LoginRequested fails',
    build: () {
      when(() => mockAuthService.login(any(), any())).thenAnswer(
          (_) async => const AuthRequestFailure(401, 'Invalid credentials'));
      return authBloc;
    },
    act: (bloc) =>
        bloc.add(LoginRequested('test@example.com', 'wrong_password')),
    expect: () => [
      const AuthState.loading(),
      const AuthState.failure(401, 'Invalid credentials'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Unauthenticated] when LogoutRequested is successful',
    build: () {
      when(() => mockAuthService.logout()).thenAnswer((_) async => true);
      return authBloc;
    },
    act: (bloc) => bloc.add(LogoutRequested()),
    expect: () => [
      const AuthState.loading(),
      const AuthState.unauthenticated(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Failure] when LogoutRequested fails',
    build: () {
      when(() => mockAuthService.logout()).thenAnswer((_) async => false);
      return authBloc;
    },
    act: (bloc) => bloc.add(LogoutRequested()),
    expect: () => [
      const AuthState.loading(),
      const AuthState.failure(null, 'logout failed'),
    ],
  );
}
