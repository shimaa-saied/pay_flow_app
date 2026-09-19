import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../app_constants.dart';
import 'app_text_widget.dart';

class BankCardWidget extends StatelessWidget {
  final double balance;
  final String currencyCode;
  final String ownerName;

  const BankCardWidget({
    super.key,
    required this.balance,
    required this.currencyCode,
    required this.ownerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTextWidget(
            text: AppConstants.appName,
            textColor: AppColors.textOnCardMuted,
            textSize: 13,
            letterSpacing: 1.5,
          ),
          const SizedBox(height: 20),
          AppTextWidget(
            text: '${balance.toStringAsFixed(2)} $currencyCode',
            textColor: AppColors.textOnCard,
            textSize: 28,
            fontWeightIndex: 6,
            letterSpacing: 1,
          ),
          const SizedBox(height: 16),
          AppTextWidget(
            text: ownerName,
            textColor: AppColors.textOnCardMuted,
            textSize: 14,
          ),
        ],
      ),
    );
  }
}
