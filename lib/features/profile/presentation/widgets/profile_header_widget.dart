import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String email;

  const ProfileHeaderWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final initial = email.isNotEmpty ? email[0].toUpperCase() : 'U';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.textOnCard.withAlpha(50),
            child: AppTextWidget(
              text: initial,
              textSize: 38,
              fontWeightIndex: 6,
              textColor: AppColors.textOnCard,
            ),
          ),
          const SizedBox(height: 14),
          AppTextWidget(
            text: email,
            textColor: AppColors.textOnCard,
            textSize: 15,
            fontWeightIndex: 4,
            isTextCenter: true,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.textOnCard.withAlpha(50),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 13, color: AppColors.successAccent),
                SizedBox(width: 4),
                AppTextWidget(
                  text: 'Active',
                  textColor: AppColors.textOnCardMuted,
                  textSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
