// features/account/presentation/cubit/account_cubit.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/factories/transaction_factory.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/get_account_usecase.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final TransactionRepository _transactionRepository;
  final GetAccountUseCase _getAccountUseCase;

  StreamSubscription<List<Transaction>>? _subscription;

  AccountCubit(this._transactionRepository, this._getAccountUseCase)
      : super(const AccountState());

  void loadAccount() {
    emit(state.copyWith(status: AccountStatus.loading));

    _subscription = _getAccountUseCase().listen(
      (transactions) {
        final balance = transactions.fold(
          0.0,
          (sum, tx) =>
              tx.type == TransactionType.deposit
                  ? sum + tx.amount
                  : sum - tx.amount,
        );
        emit(state.copyWith(status: AccountStatus.ready, balance: balance));
      },
      onError: (_) => emit(state.copyWith(
        status: AccountStatus.error,
        errorMessage: 'Failed to load account.',
      )),
    );
  }

  Future<void> deposit(double amount) async {
    if (amount <= 0) {
      emit(state.copyWith(
        status: AccountStatus.error,
        errorMessage: 'أدخل مبلغًا أكبر من صفر.',
      ));
      return;
    }
    await _transactionRepository.addTransaction(
      TransactionFactory.create(TransactionType.deposit, amount),
    );
  }

  Future<void> withdraw(double amount) async {
    if (amount <= 0) {
      emit(state.copyWith(
        status: AccountStatus.error,
        errorMessage: 'أدخل مبلغًا أكبر من صفر.',
      ));
      return;
    }
    if (amount > state.balance) {
      emit(state.copyWith(
        status: AccountStatus.error,
        errorMessage: 'رصيدك غير كافٍ لإتمام هذه العملية.',
      ));
      return;
    }
    await _transactionRepository.addTransaction(
      TransactionFactory.create(TransactionType.withdraw, amount),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
