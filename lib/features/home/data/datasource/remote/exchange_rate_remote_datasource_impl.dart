import 'package:dio/dio.dart';

import '../../../../../../core/api/api_services.dart';
import '../../../../../../core/errors/failures.dart';
import '../../models/exchange_rate_model.dart';
import 'exchange_rate_remote_datasource.dart';

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final ApiServices _apiServices;

  ExchangeRateRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ExchangeRateModel> getRate({
    required String base,
    required String target,
  }) async {
    try {
      final data = await _apiServices.getLatestRate(base, target);
      return ExchangeRateModel.fromJson(data, target);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkFailure('Request timed out. Check your connection.');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection.');
      }
      throw ServerFailure('Failed to fetch exchange rate: ${e.message}');
    } on FormatException catch (e) {
      throw ServerFailure('Unexpected API response: ${e.message}');
    }
  }
}
