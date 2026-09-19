import '../../models/exchange_rate_model.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<ExchangeRateModel> getRate({required String base, required String target});
}
