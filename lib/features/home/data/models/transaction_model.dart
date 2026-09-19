import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.type,
    required super.amount,
    required super.date,
  });

  Map<String, dynamic> toFirestore() => {
        'type': type.name,
        'amount': amount,
        'date': Timestamp.fromDate(date),
      };

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
    final rawType = data['type'] as String?;
    final type = TransactionType.values.firstWhere(
      (t) => t.name == rawType,
      orElse: () => TransactionType.deposit,
    );
    return TransactionModel(
      type: type,
      amount: (data['amount'] as num?)?.toDouble() ?? 0,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}