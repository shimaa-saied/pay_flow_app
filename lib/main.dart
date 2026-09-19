import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_colors.dart';
import 'core/app_constants.dart';
import 'core/dependency_injection/injection.dart';
import 'core/router/app_router.dart';
import 'core/services/user_session.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/home/presentation/cubit/exchange_rate_cubit/exchange_rate_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupGetIt();
  // Restore persisted session if Firebase already has a logged-in user.
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    getIt<UserSession>().login(
      currentUser.uid,
      currentUser.email ?? '',
    );
  }
  runApp(const PayFlowApp());
}

class PayFlowApp extends StatelessWidget {
  const PayFlowApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<ExchangeRateCubit>()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: AppColors.primary,
          useMaterial3: true,
        ),
        routerConfig: getIt<AppRouter>().router,
      ),
    );
  }
}
