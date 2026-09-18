// features/account/domain/repositories/transaction_repository.dart
//
// الـ contract بس — الـ domain layer مش بيعرف Firestore ولا Dio.
// التنفيذ الفعلي في الـ data layer (TransactionRepositoryImpl).

import '../entities/transaction.dart';

// ============================================================
// 🎯 LIVE CODE — Write this part during the session
// ============================================================
abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Stream<List<Transaction>> watchTransactions();
}
