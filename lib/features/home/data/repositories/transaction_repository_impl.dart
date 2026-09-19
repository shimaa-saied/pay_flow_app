import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasource/remote/transaction_remote_datasource_impl.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSourceImpl _dataSource;

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
  Stream<List<Transaction>> watchTransactions() =>
      _dataSource.watchTransactions();
}