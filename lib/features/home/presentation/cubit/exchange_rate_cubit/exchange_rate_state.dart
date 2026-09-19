import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/exchange_rate.dart';


part 'exchange_rate_state.freezed.dart';

@freezed
class ExchangeRateState with _$ExchangeRateState {
  const factory ExchangeRateState.initial() = _ExchangeRateInitial;
  const factory ExchangeRateState.loading() = _ExchangeRateLoading;
  const factory ExchangeRateState.loaded(ExchangeRate rate) = _ExchangeRateLoaded;
  const factory ExchangeRateState.failure(String message) = _ExchangeRateFailure;
}
