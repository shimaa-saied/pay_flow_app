import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';
import '../cubit/account_cubit/account_cubit.dart';
import '../cubit/account_cubit/account_state.dart';
import '../widgets/transaction_tile_widget.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTextWidget(
          text: 'Transaction History',
          fontWeightIndex: 5,
        ),
      ),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (_, __, transactions, ___) {
              if (transactions.isEmpty) {
                return const Center(
                  child: AppTextWidget(
                    text: 'No transactions yet.',
                    textColor: AppColors.textMuted,
                    isTextCenter: true,
                  ),
                );
              }
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) => TransactionTileWidget(
                  transaction: transactions[index],
                ),
              );
            },
            failure: (message) => Center(
              child: AppTextWidget(
                text: message,
                textColor: AppColors.error,
                isTextCenter: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
