// features/exchange_rate/presentation/cubit/exchange_rate_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_exchange_rate.dart';
import 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final GetExchangeRate _getExchangeRate;

  ExchangeRateCubit(this._getExchangeRate) : super(ExchangeRateInitial());

  Future<void> fetchRate({String base = 'USD', String target = 'EGP'}) async {
    emit(ExchangeRateLoading());
    try {
      final rate = await _getExchangeRate(base: base, target: target);
      emit(ExchangeRateLoaded(rate));
    } catch (e) {
      emit(ExchangeRateError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
