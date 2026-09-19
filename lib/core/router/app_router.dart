import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/main_layout/presentation/screens/main_layout.dart';
import '../dependency_injection/injection.dart';
import '../services/user_session.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/cubit/account_cubit/account_cubit.dart';
import '../../features/home/presentation/screens/history_screen.dart';

class AppRouter {
  final UserSession _userSession;

  AppRouter(this._userSession);

  late final GoRouter router = GoRouter(
    refreshListenable: _userSession,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = _userSession.isAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) return '/login';
      if (isAuthenticated && isLoginRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (_, __) => BlocProvider(
          create: (_) => getIt<AccountCubit>()..loadAccount(),
          child: const MainLayout(),
        ),
        routes: [
          GoRoute(
            path: 'history',
            builder: (context, _) => BlocProvider.value(
              value: BlocProvider.of<AccountCubit>(context),
              child: const HistoryScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
