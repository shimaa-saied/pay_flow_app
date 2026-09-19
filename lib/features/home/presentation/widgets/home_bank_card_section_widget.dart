import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/widgets/app_text_widget.dart';
import '../../../../core/widgets/bank_card_widget.dart';
import '../cubit/account_cubit/account_state.dart';
import '../cubit/exchange_rate_cubit/exchange_rate_cubit.dart';
import '../cubit/exchange_rate_cubit/exchange_rate_state.dart';

class HomeBankCardSectionWidget extends StatelessWidget {
  final AccountState state;

  const HomeBankCardSectionWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final balance = state.maybeWhen(
      loaded: (balance, _, __, ___) => balance,
      orElse: () => 0.0,
    );
    final currency = state.maybeWhen(
      loaded: (_, currency, __, ___) => currency,
      orElse: () => AppConstants.defaultCurrency,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          BankCardWidget(
            balance: balance,
            currencyCode: currency,
            ownerName: 'Demo Account',
          ),
          const SizedBox(height: 12),
          BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
            builder: (context, rateState) {
              return rateState.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LinearProgressIndicator(),
                ),
                loaded: (rate) => AppTextWidget(
                  text:
                      '1 ${rate.base} = ${rate.rate.toStringAsFixed(2)} ${rate.target}',
                  textSize: 12,
                  textColor: AppColors.textMuted,
                  isTextCenter: true,
                ),
                failure: (message) => AppTextWidget(
                  text: message,
                  textColor: AppColors.error,
                  isTextCenter: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
