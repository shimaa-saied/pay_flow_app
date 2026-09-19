import '../../domain/entities/exchange_rate.dart';

class ExchangeRateModel {
  final String base;
  final String target;
  final double rate;

  const ExchangeRateModel({
    required this.base,
    required this.target,
    required this.rate,
  });

  ExchangeRate toEntity() => ExchangeRate(
        base: base,
        target: target,
        rate: rate,
      );

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json, String target) {
    final rates = json['rates'] as Map<String, dynamic>?;
    if (rates == null || rates[target] == null) {
      throw const FormatException('Unexpected response from exchange rate provider.');
    }
    return ExchangeRateModel(
      base: json['base'] as String? ?? 'USD',
      target: target,
      rate: (rates[target] as num).toDouble(),
    );
  }
}
