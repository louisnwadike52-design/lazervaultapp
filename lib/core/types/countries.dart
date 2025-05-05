class Country {
  final String flag;
  final String name;
  final String code;
  final String symbol;

  const Country(
      {required this.flag,
      required this.name,
      required this.code,
      required this.symbol});
}

class ExchangeRate {
  final String base;
  final DateTime timestamp;
  final Map<String, double> rates;

  const ExchangeRate({
    required this.base,
    required this.timestamp,
    required this.rates,
  });
}

class CountryRateDetails {
  final Country from;
  final Country to;
  final double rate;

  const CountryRateDetails({
    required this.from,
    required this.to,
    required this.rate,
  });
}
