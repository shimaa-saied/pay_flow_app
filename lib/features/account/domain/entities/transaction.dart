// features/account/domain/entities/transaction.dart
//
// كيان نقي يمثّل عملية مالية واحدة (إيداع أو سحب).
// مفيش Firestore هنا — ده دور TransactionModel في الـ data layer.

enum TransactionType { deposit, withdraw }

class Transaction {
  final TransactionType type;
  final double amount;
  final DateTime date;

  const Transaction({
    required this.type,
    required this.amount,
    required this.date,
  });
}
