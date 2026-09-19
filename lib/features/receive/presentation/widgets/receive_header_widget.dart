import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';

class ReceiveHeaderWidget extends StatelessWidget {
  const ReceiveHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.deposit.withAlpha(50),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            size: 40,
            color: AppColors.deposit,
          ),
        ),
        const SizedBox(height: 20),
        const AppTextWidget(
          text: 'Receive Money',
          textSize: 22,
          fontWeightIndex: 6,
          isTextCenter: true,
        ),
        const SizedBox(height: 8),
        const AppTextWidget(
          text: 'Enter the amount you want to add',
          textColor: AppColors.textMuted,
          isTextCenter: true,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
