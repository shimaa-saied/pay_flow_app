// core/widgets/bank_card_widget.dart
//
// ويدجت جاهزة (مش هتتكتب لايف) بتعرض شكل الكارت البنكي.
// اتعملت shared widget عشان نستخدمها في أكتر من شاشة من غير تكرار كود
// (مبدأ Avoid duplicate code في متطلبات كل التاسكات).

import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2B2E83), Color(0xFF7A5CFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PayFlow',
              style: TextStyle(
                  color: Colors.white70, fontSize: 14, letterSpacing: 2)),
          const SizedBox(height: 20),
          Text(
            '${balance.toStringAsFixed(2)} $currencyCode',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(ownerName,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}
