// features/exchange_rate/data/datasources/exchange_rate_remote_datasource.dart
//
// الطبقة الوحيدة اللي بتعرف تفاصيل الـ HTTP الفعلية (Dio, endpoint, timeout).

import 'package:dio/dio.dart';

import '../models/exchange_rate_model.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<ExchangeRateModel> getRate({required String base, required String target});
}

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final Dio dio;

  ExchangeRateRemoteDataSourceImpl(this.dio);

  static const _baseUrl = 'https://api.frankfurter.app';

  @override
  Future<ExchangeRateModel> getRate({
    required String base,
    required String target,
  }) async {
    // Edge case مقصود للديمو: لو النت وقع أو الـ API اتأخر أكتر من
    // الـ timeout المضبوط في DioFactory، هيرمي DioException بنوعه
    // (connectionTimeout / connectionError) وده اللي بنمسكه هنا.
    try {
      final response = await dio.get(
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
        throw Exception('استغرق الطلب وقتًا طويلاً — تأكد من اتصالك بالإنترنت.');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('لا يوجد اتصال بالإنترنت حاليًا.');
      }
      throw Exception('فشل جلب سعر الصرف: ${e.message}');
    }
  }
}
