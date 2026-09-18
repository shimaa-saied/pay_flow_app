// features/account/domain/usecases/get_account_usecase.dart
//
// UseCase واحد، هدف واحد: "هات كل المعاملات للحساب الحالي."
// الـ AccountCubit بينادي الكلاس ده وميعرفش حاجة عن Firestore أو
// TransactionRepository — ده دوره هو فقط.

import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetAccountUseCase {
  final TransactionRepository repository;

  const GetAccountUseCase(this.repository);

  Stream<List<Transaction>> call() {
    return repository.watchTransactions();
  }
}
