import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/transaction.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState.initial() = _AccountInitial;
  const factory AccountState.loading() = _AccountLoading;
  const factory AccountState.loaded(
    double balance,
    String currency,
    List<Transaction> transactions,
    String? errorMessage,
  ) = AccountLoaded;
  const factory AccountState.failure(String message) = _AccountFailure;
}