import '../entities/exchange_rate.dart';

abstract class ExchangeRateRepository {
  Future<ExchangeRate> getRate({required String base, required String target});
}
