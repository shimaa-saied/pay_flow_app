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