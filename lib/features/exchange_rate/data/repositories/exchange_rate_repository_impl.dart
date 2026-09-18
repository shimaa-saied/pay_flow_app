// features/exchange_rate/data/repositories/exchange_rate_repository_impl.dart
//
// بيربط الـ Domain بالـ Data: بينفّذ الـ contract اللي الـ Repository
// abstract عرّفه، مستخدمًا الـ DataSource.

import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../datasources/exchange_rate_remote_datasource.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateRemoteDataSource remoteDataSource;

  ExchangeRateRepositoryImpl(this.remoteDataSource);

  @override
  Future<ExchangeRate> getRate({
    required String base,
    required String target,
  }) {
    return remoteDataSource.getRate(base: base, target: target);
  }
}
