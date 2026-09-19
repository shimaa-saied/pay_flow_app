import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_constants.dart';
import '../../../../../core/errors/failures.dart';

import '../../../domain/usecases/get_exchange_rate_usecase.dart';
import 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final GetExchangeRateUseCase _getExchangeRate;

  ExchangeRateCubit(this._getExchangeRate)
      : super(const ExchangeRateState.initial());

  Future<void> fetchRate({
    String base = AppConstants.defaultBaseCurrency,
    String target = AppConstants.defaultCurrency,
  }) async {
    emit(const ExchangeRateState.loading());
    try {
      final rate = await _getExchangeRate(base: base, target: target);
      emit(ExchangeRateState.loaded(rate));
    } on Failure catch (f) {
      emit(ExchangeRateState.failure(f.message));
    } catch (_) {
      emit(const ExchangeRateState.failure('Failed to fetch exchange rate.'));
    }
  }
}
