import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              listenWhen: (_, current) =>
                  current is Unauthenticated && current.errorMessage != null,
              listener: (context, state) {
                final message = state.maybeWhen(
                  unauthenticated: (msg) => msg,
                  orElse: () => null,
                );
                if (message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );
                return LoginFormWidget(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isLoading: isLoading,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
