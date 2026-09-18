// features/auth/presentation/pages/login_page.dart
//
// مثال حي لـ BlocConsumer:
//   - builder: يبني الزرار كـ loading indicator وقت AuthLoading.
//   - listener: بينفّذ side effect (Navigation أو SnackBar) مرة واحدة
//     بس لكل state جديد، من غير ما يعيد بناء الـ UI بتاعه.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pay_flow_app/core/di/injection.dart' as di;
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'package:pay_flow_app/features/account/presentation/cubit/account_cubit.dart';
import 'package:pay_flow_app/features/account/presentation/pages/card_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  di.setupUserDependencies(state.userId);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => di.sl<AccountCubit>(),
                        child: const CardPage(),
                      ),
                    ),
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('PayFlow',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: 'البريد الإلكتروني'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'كلمة المرور'),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => context.read<AuthCubit>().login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('تسجيل الدخول'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
