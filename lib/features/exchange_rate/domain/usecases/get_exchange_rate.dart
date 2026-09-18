// features/exchange_rate/domain/usecases/get_exchange_rate.dart
//
// UseCase: هدف واحد بس — "هات سعر الصرف". الـ Cubit بينادي الكلاس ده
// وميعرفش حاجة عن الـ Repository أو الـ DataSource.

import '../entities/exchange_rate.dart';
import '../repositories/exchange_rate_repository.dart';

class GetExchangeRate {
  final ExchangeRateRepository repository;

  const GetExchangeRate(this.repository);

  Future<ExchangeRate> call({required String base, required String target}) {
    return repository.getRate(base: base, target: target);
  }
}
