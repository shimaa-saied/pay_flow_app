import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'profile_info_cards_widget.dart';

class ProfileBodyWidget extends StatelessWidget {
  final String email;

  const ProfileBodyWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ProfileInfoCardsWidget(email: email),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              await context.read<AuthCubit>().logout();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.error.withAlpha(15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.error.withAlpha(80)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.logout, color: AppColors.error, size: 20),
                  SizedBox(width: 12),
                  AppTextWidget(
                    text: 'Sign Out',
                    textColor: AppColors.error,
                    fontWeightIndex: 5,
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right, color: AppColors.error, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
