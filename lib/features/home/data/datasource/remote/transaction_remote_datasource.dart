import '../../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<void> addTransaction(TransactionModel model);
  Stream<List<TransactionModel>> watchTransactions();
}