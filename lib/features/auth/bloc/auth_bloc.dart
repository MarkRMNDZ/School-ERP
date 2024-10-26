import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/powersync/db.dart';
import '../auth_repository/auth_repository.dart';
import '../auth_service.dart';
import 'auth_state.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authService) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final AuthService authService;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (await authService.isLoggedIn()) {
      final accessToken = (await authService.getToken())!;
      final user = (await authService.getUser());
      openDatabase(); // connect powersync db if user is already logged in
      emit(AuthState.authenticated(user!, accessToken));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await authService.login(event.email, event.password);

    if (result is AuthRequestSuccess) {
      openDatabase(); // connect powersync db if user logs in
      emit(AuthState.authenticated(result.user, result.accessToken));
    } else if (result is AuthRequestFailure) {
      emit(AuthState.failure(result.statusCode, result.message));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await authService.logout();

    if (result) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(const AuthState.failure(null, "logout failed"));
    }
  }
}
