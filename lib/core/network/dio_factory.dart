// core/network/dio_factory.dart
//
// نقطة واحدة لإنشاء Dio مضبوط (timeout + interceptors).
// أي feature محتاجة تتكلم مع API خارجي بتاخد نفس الـ instance من هنا.

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio getDio() {
    final dio = Dio();

    dio.options
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }
}
