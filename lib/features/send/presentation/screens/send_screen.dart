import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/widgets/app_text_widget.dart';
import '../../../home/presentation/cubit/account_cubit/account_cubit.dart';
import '../../../home/presentation/cubit/account_cubit/account_state.dart';
import '../widgets/send_header_widget.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount.')),
      );
      return;
    }
    context.read<AccountCubit>().withdraw(amount);
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listenWhen: (_, current) =>
          current is AccountLoaded && current.errorMessage != null,
      listener: (context, state) {
        final msg =
            state.maybeWhen(loaded: (_, __, ___, e) => e, orElse: () => null);
        if (msg != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg)));
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SendHeaderWidget(),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final balance = state.maybeWhen(
                    loaded: (b, _, __, ___) => b,
                    orElse: () => 0.0,
                  );
                  final currency = state.maybeWhen(
                    loaded: (_, c, __, ___) => c,
                    orElse: () => AppConstants.defaultCurrency,
                  );
                  return AppTextWidget(
                    text: 'Available: ${balance.toStringAsFixed(2)} $currency',
                    textColor: AppColors.textMuted,
                    textSize: 13,
                    textAlign: TextAlign.right,
                  );
                },
              ),
              const SizedBox(height: 8),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final currency = state.maybeWhen(
                    loaded: (_, c, __, ___) => c,
                    orElse: () => AppConstants.defaultCurrency,
                  );
                  return TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      prefixText: '$currency  ',
                      border: const OutlineInputBorder(),
                      hintText: '0.00',
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                icon: const Icon(Icons.send),
                label: const AppTextWidget(
                  text: 'Send',
                  textColor: AppColors.textOnCard,
                  fontWeightIndex: 5,
                ),
                onPressed: () => _submit(context),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
