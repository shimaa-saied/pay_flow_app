import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository _repository;

  const GetTransactionsUseCase(this._repository);

  Stream<List<Transaction>> call() => _repository.watchTransactions();
}