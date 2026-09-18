// features/account/presentation/pages/card_page.dart
//
// الشاشة دي بتجمّع 3 Cubits شغالين مع بعض:
//   - AccountCubit: الرصيد (BlocConsumer: builder + listener).
//   - ExchangeRateCubit: سعر الصرف (BlocBuilder بسيط).
//
// ملحوظة Bug تعليمي: BlocListener هنا واحد بس (listenWhen افتراضيًا
// بيتنفذ مع كل state جديد يختلف عن السابق بفضل Equatable). لو حد ضاعف
// BlocListener لنفس الـ Cubit في نفس الشجرة، الـ SnackBar هيظهر مرتين
// — جرّب تعمل الغلطة دي قصادهم عمدًا وورّيهم الفرق.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pay_flow_app/core/widgets/bank_card_widget.dart';
import 'package:pay_flow_app/features/exchange_rate/presentation/cubit/exchange_rate_cubit.dart';
import 'package:pay_flow_app/features/exchange_rate/presentation/cubit/exchange_rate_state.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';
import 'history_page.dart';
import 'package:pay_flow_app/features/profile/presentation/pages/profile_page.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // بننادي الـ Cubit بعد أول frame عشان نضمن إن الـ context جاهز.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountCubit>().loadAccount();
      context.read<ExchangeRateCubit>().fetchRate(base: 'USD', target: 'EUR');
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayFlow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const HistoryPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<AccountCubit, AccountState>(
            listenWhen: (previous, current) =>
                current.status == AccountStatus.error && current.errorMessage != null,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            },
            builder: (context, accountState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BankCardWidget(
                    balance: accountState.balance,
                    currencyCode: accountState.currency,
                    ownerName: 'حساب تجريبي',
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
                    builder: (context, rateState) {
                      if (rateState is ExchangeRateLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: LinearProgressIndicator(),
                        );
                      }
                      if (rateState is ExchangeRateLoaded) {
                        return Text(
                          '1 ${rateState.rate.base} = ${rateState.rate.rate.toStringAsFixed(2)} ${rateState.rate.target}',
                          textAlign: TextAlign.center,
                        );
                      }
                      if (rateState is ExchangeRateError) {
                        return Text(
                          rateState.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: 'المبلغ', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _submit(context, isDeposit: true),
                          child: const Text('إيداع'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _submit(context, isDeposit: false),
                          child: const Text('سحب'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, {required bool isDeposit}) {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك أدخل رقمًا صحيحًا.')),
      );
      return;
    }

    if (isDeposit) {
      context.read<AccountCubit>().deposit(amount);
    } else {
      context.read<AccountCubit>().withdraw(amount);
    }
    _amountController.clear();
  }
}
