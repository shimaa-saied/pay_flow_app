import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Stream<List<Transaction>> watchTransactions();
}