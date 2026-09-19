import '../entities/exchange_rate.dart';
import '../repositories/exchange_rate_repository.dart';

class GetExchangeRateUseCase {
  final ExchangeRateRepository _repository;

  const GetExchangeRateUseCase(this._repository);

  Future<ExchangeRate> call({required String base, required String target}) =>
      _repository.getRate(base: base, target: target);
}
