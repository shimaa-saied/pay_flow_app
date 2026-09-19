// lib/main.dart
//
// ملحوظة عمدية: هنا بنسجّل بس الـ Cubits اللي محتاجة قبل تسجيل الدخول
// (AuthCubit, ExchangeRateCubit). AccountCubit مش بيتسجّل هنا خالص —
// بيتسجّل جوه core/di/injection.dart بعد نجاح تسجيل الدخول (شوف الملف
// ده لشرح السبب)، وبيتاخد من GetIt عند دخول CardPage.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/di/injection.dart' as di;
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/exchange_rate/presentation/cubit/exchange_rate_cubit.dart';
import 'features/account/presentation/cubit/account_cubit.dart';
import 'features/shell/presentation/pages/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: قبل التشغيل الفعلي، اربط مشروع Firebase حقيقي:
  // 1) شغّل: flutterfire configure
  // 2) استبدل السطر التالي بـ:
  //    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();

  di.setupCoreDependencies();

  runApp(const PayFlowApp());
}

class PayFlowApp extends StatelessWidget {
  const PayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => di.sl<ExchangeRateCubit>()),
      ],
      child: MaterialApp(
        title: 'PayFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF7A5CFA),
          useMaterial3: true,
        ),
        home: const _RootRouter(),
      ),
    );
  }
}

/// بيقرر يبدأ بـ LoginPage أو CardPage حسب حالة تسجيل الدخول الحالية
/// (Firebase بيحتفظ بالـ session، فلو اليوزر مسجل دخول من قبل منعرضلوش
/// شاشة اللوجين تاني).
class _RootRouter extends StatelessWidget {
  const _RootRouter();

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const LoginPage();
    }

    di.setupUserDependencies(currentUser.uid);
    return BlocProvider(
      create: (_) => di.sl<AccountCubit>(),
      child: const MainShell(),
    );
  }
}
