// features/account/presentation/pages/history_page.dart
//
// بتستخدم StreamBuilder مباشرة على الـ repository (بدون Cubit وسيط)
// لأن الشاشة دي read-only — بس بتعرض البيانات، مفيش business logic.

import 'package:flutter/material.dart';

import 'package:pay_flow_app/core/di/injection.dart' as di;
import 'package:pay_flow_app/features/account/domain/entities/transaction.dart';
import 'package:pay_flow_app/features/account/domain/repositories/transaction_repository.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل المعاملات')),
      body: StreamBuilder<List<Transaction>>(
        stream: di.sl<TransactionRepository>().watchTransactions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final transactions = snapshot.data!;

          if (transactions.isEmpty) {
            return const Center(child: Text('لا توجد معاملات بعد.'));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              final isDeposit = tx.type == TransactionType.deposit;
              return ListTile(
                leading: Icon(
                  isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isDeposit ? Colors.green : Colors.red,
                ),
                title: Text(
                  '${isDeposit ? '+' : '-'}${tx.amount.toStringAsFixed(2)} EGP',
                ),
                subtitle: Text(tx.date.toLocal().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
