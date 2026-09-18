// features/account/presentation/cubit/account_state.dart
//
// AccountStatus.error مش "حالة تحميل فاشلة" بس — بنستخدمه كمان لعرض
// رسائل validation لحظية (زي محاولة سحب مبلغ أكبر من الرصيد) من غير
// ما نفقد قيمة الـ balance الحالية على الشاشة.

import 'package:equatable/equatable.dart';

enum AccountStatus { initial, loading, ready, error }

class AccountState extends Equatable {
  final AccountStatus status;
  final double balance;
  final String currency;
  final String? errorMessage;

  const AccountState({
    this.status = AccountStatus.initial,
    this.balance = 1000, // رصيد افتراضي للديمو
    this.currency = 'EGP',
    this.errorMessage,
  });

  AccountState copyWith({
    AccountStatus? status,
    double? balance,
    String? currency,
    String? errorMessage,
  }) {
    return AccountState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, balance, currency, errorMessage];
}
