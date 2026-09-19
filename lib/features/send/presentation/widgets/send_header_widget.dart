import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';

class SendHeaderWidget extends StatelessWidget {
  const SendHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 24),
        CircleAvatar(
          radius: 48,
          backgroundColor: colorScheme.primaryContainer.withAlpha(120),
          child: Icon(
            Icons.send_rounded,
            size: 40,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        const AppTextWidget(
          text: 'Send Money',
          textSize: 22,
          fontWeightIndex: 6,
          isTextCenter: true,
        ),
        const SizedBox(height: 8),
        const AppTextWidget(
          text: 'Enter the amount you want to send',
          textColor: AppColors.textMuted,
          isTextCenter: true,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
