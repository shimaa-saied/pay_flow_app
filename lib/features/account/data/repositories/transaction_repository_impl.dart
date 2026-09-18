// features/account/data/repositories/transaction_repository_impl.dart
//
// بيحوّل الـ Domain entities لـ Data models قبل ما يبعتها للـ DataSource،
// وبيرجع نتائج الـ DataSource مباشرة للـ Cubit (هي بالفعل Transaction
// لأن TransactionModel بيـextend Transaction).

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource _dataSource;

  TransactionRepositoryImpl(this._dataSource);

  @override
  Future<void> addTransaction(Transaction transaction) {
    return _dataSource.addTransaction(
      TransactionModel(
        type: transaction.type,
        amount: transaction.amount,
        date: transaction.date,
      ),
    );
  }

  @override
  Stream<List<Transaction>> watchTransactions() {
    return _dataSource.watchTransactions();
  }
}
