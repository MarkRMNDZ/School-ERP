import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/shared/api_service.dart';
import 'package:school_erp/pages/home/home_page.dart';
import 'package:school_erp/pages/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(apiService: ApiService()),
        ),
      ],
      child: BlocProvider<AuthBloc>(
        create: (context) {
          final authRepository = RepositoryProvider.of<AuthRepository>(context);
          final authService = AuthService(authRepository);
          return AuthBloc(authService)..add(AuthCheckRequested());
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {}, // do nothing here atm
              authenticated: (user, token) {
                _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomePage(user)),
                  (route) => false,
                );
              },
              unauthenticated: () {
                _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              failure: (statusCode, message) {},
            );
          },
          child: child,
        );
      },
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (_) => const SizedBox.shrink()),
    );
  }
}
