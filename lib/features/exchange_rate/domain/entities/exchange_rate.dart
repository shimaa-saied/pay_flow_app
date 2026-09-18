// features/exchange_rate/domain/entities/exchange_rate.dart
//
// كيان نقي (Pure Domain Entity): مفيش Dio, مفيش Firebase, مفيش Flutter.
// ده اللي باقي الـ app بيتعامل معاه — مش مرتبط بأي تفاصيل تقنية.

class ExchangeRate {
  final String base;
  final String target;
  final double rate;

  const ExchangeRate({
    required this.base,
    required this.target,
    required this.rate,
  });
}
