// features/exchange_rate/presentation/cubit/exchange_rate_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/exchange_rate.dart';

abstract class ExchangeRateState extends Equatable {
  const ExchangeRateState();

  @override
  List<Object?> get props => [];
}

class ExchangeRateInitial extends ExchangeRateState {}

class ExchangeRateLoading extends ExchangeRateState {}

class ExchangeRateLoaded extends ExchangeRateState {
  final ExchangeRate rate;

  const ExchangeRateLoaded(this.rate);

  @override
  List<Object?> get props => [rate.base, rate.target, rate.rate];
}

class ExchangeRateError extends ExchangeRateState {
  final String message;

  const ExchangeRateError(this.message);

  @override
  List<Object?> get props => [message];
}
