import './bloc/auth_state.dart';

String getTeacherId(AuthState state) {
  return state.maybeWhen(
    authenticated: (user, _) {
      if (user.loginType != 'teacher') {
        throw Exception('Only teachers can create assignments');
      }

      if (user.loginId == null) {
        throw Exception('Teacher ID not found');
      }
      return user.loginId!;
    },
    orElse: () {
      throw Exception('User is not authenticated');
    },
  );
}
