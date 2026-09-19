import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_endpoints.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  /// GET /latest?from=USD&to=EGP
  @GET(ApiEndpoints.latestRate)
  Future<Map<String, dynamic>> getLatestRate(
    @Query('from') String base,
    @Query('to') String target,
  );
}