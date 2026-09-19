import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_constants.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/add_transaction_usecase.dart';
import '../../../domain/usecases/get_transactions_usecase.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetTransactionsUseCase _getTransactions;
  final AddTransactionUseCase _addTransaction;

  StreamSubscription<List<Transaction>>? _subscription;

  AccountCubit(this._getTransactions, this._addTransaction)
      : super(const AccountState.initial());

  void loadAccount() {
    emit(const AccountState.loading());
    _subscription = _getTransactions().listen(
      (transactions) {
        final balance = transactions.fold(
          0.0,
          (sum, tx) => tx.type == TransactionType.deposit
              ? sum + tx.amount
              : sum - tx.amount,
        );
        emit(AccountState.loaded(
          balance,
          AppConstants.defaultCurrency,
          transactions,
          null,
        ));
      },
      onError: (_) => emit(const AccountState.failure('Failed to load account.')),
    );
  }

  Future<void> deposit(double amount) async {
    if (amount <= 0) {
      _emitError('Please enter an amount greater than zero.');
      return;
    }
    await _addTransaction(Transaction(
      type: TransactionType.deposit,
      amount: amount,
      date: DateTime.now(),
    ));
  }

  Future<void> withdraw(double amount) async {
    if (amount <= 0) {
      _emitError('Please enter an amount greater than zero.');
      return;
    }
    final current = state;
    final balance =
        current is AccountLoaded ? current.balance : 0.0;
    if (amount > balance) {
      _emitError('Insufficient balance.');
      return;
    }
    await _addTransaction(Transaction(
      type: TransactionType.withdraw,
      amount: amount,
      date: DateTime.now(),
    ));
  }

  void _emitError(String message) {
    final current = state;
    if (current is AccountLoaded) {
      emit(AccountState.loaded(
        current.balance,
        current.currency,
        current.transactions,
        message,
      ));
    } else {
      emit(AccountState.failure(message));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}