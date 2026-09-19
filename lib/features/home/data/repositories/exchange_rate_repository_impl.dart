import '../../../../../core/errors/failures.dart';
import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../datasource/remote/exchange_rate_remote_datasource.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateRemoteDataSource _dataSource;

  ExchangeRateRepositoryImpl(this._dataSource);

  @override
  Future<ExchangeRate> getRate({
    required String base,
    required String target,
  }) async {
    try {
      final model = await _dataSource.getRate(base: base, target: target);
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure('Unexpected error: ${e.toString()}');
    }
  }
}
