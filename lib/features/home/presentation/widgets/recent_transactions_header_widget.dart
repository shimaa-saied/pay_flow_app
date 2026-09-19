import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';

class RecentTransactionsHeaderWidget extends StatelessWidget {
  final bool hasTransactions;

  const RecentTransactionsHeaderWidget({
    super.key,
    required this.hasTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppTextWidget(
            text: 'Recent Transactions',
            fontWeightIndex: 6,
          ),
          if (hasTransactions)
            TextButton(
              onPressed: () => context.push('/history'),
              child: const AppTextWidget(
                text: 'View All',
                textColor: AppColors.primary,
                fontWeightIndex: 4,
              ),
            ),
        ],
      ),
    );
  }
}
