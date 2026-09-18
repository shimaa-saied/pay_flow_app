// features/exchange_rate/domain/repositories/exchange_rate_repository.dart
//
// الـ Domain layer بيعرف الـ contract بس (abstract) — مش عارف ولا مهتم
// إن التنفيذ الفعلي بيستخدم Dio أو أي حاجة تانية.

import '../entities/exchange_rate.dart';

abstract class ExchangeRateRepository {
  Future<ExchangeRate> getRate({required String base, required String target});
}
