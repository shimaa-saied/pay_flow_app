import 'package:dio/dio.dart';

import '../../../../../../core/errors/failures.dart';
import '../../models/exchange_rate_model.dart';
import 'exchange_rate_remote_datasource.dart';

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final Dio _dio;

  ExchangeRateRemoteDataSourceImpl(this._dio);

  static const _baseUrl = 'https://api.frankfurter.app';

  @override
  Future<ExchangeRateModel> getRate({
    required String base,
    required String target,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/latest',
        queryParameters: {'from': base, 'to': target},
      );
      return ExchangeRateModel.fromJson(
        response.data as Map<String, dynamic>,
        target,
      );
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
