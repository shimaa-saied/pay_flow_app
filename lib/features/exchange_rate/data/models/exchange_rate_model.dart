// features/exchange_rate/data/models/exchange_rate_model.dart
//
// Model = Entity + معرفة إزاي نحوّله من/لـ JSON. الـ fromJson هنا مبني
// على استجابة Frankfurter API (https://api.frankfurter.app) — API عام
// مجاني وبدون مفتاح.
// شكل الاستجابة تقريبًا:
// { "base": "USD", "rates": { "EGP": 48.9 } }

import '../../domain/entities/exchange_rate.dart';

class ExchangeRateModel extends ExchangeRate {
  const ExchangeRateModel({
    required super.base,
    required super.target,
    required super.rate,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json, String target) {
    final rates = json['rates'] as Map<String, dynamic>?;

    // Edge case: لو الـ API رجّع شكل غير متوقع (target مش موجود في rates)
    // منرميش null pointer — بنرمي Exception واضحة تتلقط في الـ DataSource.
    if (rates == null || rates[target] == null) {
      throw const FormatException('صيغة استجابة غير متوقعة من مزوّد أسعار الصرف.');
    }

    return ExchangeRateModel(
      base: json['base'] as String? ?? 'USD',
      target: target,
      rate: (rates[target] as num).toDouble(),
    );
  }
}
