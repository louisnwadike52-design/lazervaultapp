/// A currency the exchange UI can offer.
///
/// DELIBERATELY CARRIES NO RATE. It used to have an `exchangeRate` field
/// ("Rate to USD") populated from six constants in currency_data.dart — NGN
/// 411.0, GBP 0.73, EUR 0.85, GHS 6.1, KES 107.0 — which were years out of
/// date and were never read by anything that displays a rate. A stale number
/// on an identity object is a trap: the next person to need "the rate" finds
/// one already sitting on the currency and uses it.
///
/// Rates come from the exchange service, through
/// `IExchangeRepository.getExchangeRate`, which is the one source the
/// dashboard and the exchange screen both read.
class Currency {
  final String code;
  final String name;
  final String symbol;
  final String flagUrl;
  final String countryCode;
  final String countryName;
  final bool isPopular;
  final bool isSupported;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flagUrl,
    required this.countryCode,
    required this.countryName,
    this.isPopular = false,
    this.isSupported = true,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      flagUrl: json['flagUrl'] ?? '',
      countryCode: json['countryCode'] ?? '',
      countryName: json['countryName'] ?? '',
      isPopular: json['isPopular'] ?? false,
      isSupported: json['isSupported'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'symbol': symbol,
      'flagUrl': flagUrl,
      'countryCode': countryCode,
      'countryName': countryName,
      'isPopular': isPopular,
      'isSupported': isSupported,
    };
  }

  Currency copyWith({
    String? code,
    String? name,
    String? symbol,
    String? flagUrl,
    String? countryCode,
    String? countryName,
    bool? isPopular,
    bool? isSupported,
  }) {
    return Currency(
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      flagUrl: flagUrl ?? this.flagUrl,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      isPopular: isPopular ?? this.isPopular,
      isSupported: isSupported ?? this.isSupported,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Currency && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, symbol: $symbol)';
  }
}
