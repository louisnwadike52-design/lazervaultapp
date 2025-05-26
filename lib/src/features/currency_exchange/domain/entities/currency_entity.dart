class Currency {
  final String code;
  final String name;
  final String symbol;
  final String flagUrl;
  final String countryCode;
  final String countryName;
  final double exchangeRate; // Rate to USD
  final bool isPopular;
  final bool isSupported;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flagUrl,
    required this.countryCode,
    required this.countryName,
    required this.exchangeRate,
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
      exchangeRate: (json['exchangeRate'] ?? 0.0).toDouble(),
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
      'exchangeRate': exchangeRate,
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
    double? exchangeRate,
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
      exchangeRate: exchangeRate ?? this.exchangeRate,
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