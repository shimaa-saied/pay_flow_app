import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';

import '../cubit/account_cubit/account_cubit.dart';
import '../cubit/account_cubit/account_state.dart';
import '../widgets/home_bank_card_section_widget.dart';
import '../widgets/recent_transactions_header_widget.dart';
import '../widgets/transaction_tile_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          final hasTransactions = state.maybeWhen(
            loaded: (_, __, transactions, ___) => transactions.isNotEmpty,
            orElse: () => false,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeBankCardSectionWidget(state: state),
              RecentTransactionsHeaderWidget(hasTransactions: hasTransactions),
              Expanded(
                child: state.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  failure: (message) => Center(
                    child: AppTextWidget(
                      text: message,
                      textColor: AppColors.error,
                      isTextCenter: true,
                    ),
                  ),
                  loaded: (_, __, transactions, ___) => transactions.isEmpty
                      ? const Center(
                          child: AppTextWidget(
                            text: 'No transactions yet.',
                            textColor: AppColors.textMuted,
                            isTextCenter: true,
                          ),
                        )
                      : ListView.builder(
                          itemCount: transactions.take(5).length,
                          itemBuilder: (context, index) =>
                              TransactionTileWidget(
                            transaction: transactions[index],
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
