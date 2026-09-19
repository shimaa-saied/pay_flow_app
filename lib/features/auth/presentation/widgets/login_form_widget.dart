import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/widgets/app_text_widget.dart';
import '../cubit/auth_cubit.dart';

class LoginFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;

  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppTextWidget(
          text: AppConstants.appName,
          textSize: 32,
          fontWeightIndex: 6,
          isTextCenter: true,
        ),
        const SizedBox(height: 8),
        const AppTextWidget(
          text: 'Sign in to your account',
          textColor: AppColors.textMuted,
          isTextCenter: true,
        ),
        const SizedBox(height: 32),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: isLoading
                ? null
                : () => context.read<AuthCubit>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textOnCard,
                    ),
                  )
                : const AppTextWidget(
                    text: 'Sign In',
                    textColor: AppColors.textOnCard,
                    fontWeightIndex: 5,
                  ),
          ),
        ),
      ],
    );
  }
}