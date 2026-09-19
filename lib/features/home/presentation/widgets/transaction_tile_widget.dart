import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/transaction.dart';

class TransactionTileWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionTileWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDeposit = transaction.type == TransactionType.deposit;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            isDeposit ? AppColors.deposit.withOpacity(0.1) : AppColors.withdraw.withOpacity(0.1),
        child: Icon(
          isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
          color: isDeposit ? AppColors.deposit : AppColors.withdraw,
        ),
      ),
      title: Text(isDeposit ? 'Deposit' : 'Withdrawal'),
      subtitle: Text(
        '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      ),
      trailing: Text(
        '${isDeposit ? '+' : '-'}${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: isDeposit ? AppColors.deposit : AppColors.withdraw,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}