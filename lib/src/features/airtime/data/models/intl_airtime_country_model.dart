import '../../domain/entities/intl_airtime_country.dart';

class IntlAirtimeCountryModel extends IntlAirtimeCountry {
  const IntlAirtimeCountryModel({
    required super.id,
    required super.countryCode,
    required super.countryName,
    required super.dialCode,
    required super.currencyCode,
    required super.currencySymbol,
    required super.flagEmoji,
    super.isActive,
    super.reloadlySupported,
    super.vtpassSupported,
    super.operatorCount,
  });

  /// Deserializes from JSON produced by the commerce-gateway HTTP/JSON endpoint.
  /// Field names match proto snake_case JSON serialization.
  factory IntlAirtimeCountryModel.fromJson(Map<String, dynamic> json) {
    return IntlAirtimeCountryModel(
      id: json['id'] as String? ?? json['country_code'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
      countryName: json['country_name'] as String? ?? '',
      dialCode: json['dial_code'] as String? ?? '',
      currencyCode: json['currency_code'] as String? ?? '',
      currencySymbol: json['currency_symbol'] as String? ?? '',
      flagEmoji: json['flag_emoji'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      reloadlySupported: json['reloadly_supported'] as bool? ?? false,
      vtpassSupported: json['vtpass_supported'] as bool? ?? false,
      operatorCount: (json['operator_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_code': countryCode,
      'country_name': countryName,
      'dial_code': dialCode,
      'currency_code': currencyCode,
      'currency_symbol': currencySymbol,
      'flag_emoji': flagEmoji,
      'is_active': isActive,
      'reloadly_supported': reloadlySupported,
      'vtpass_supported': vtpassSupported,
      'operator_count': operatorCount,
    };
  }

  @override
  IntlAirtimeCountryModel copyWith({
    String? id,
    String? countryCode,
    String? countryName,
    String? dialCode,
    String? currencyCode,
    String? currencySymbol,
    String? flagEmoji,
    bool? isActive,
    bool? reloadlySupported,
    bool? vtpassSupported,
    int? operatorCount,
  }) {
    return IntlAirtimeCountryModel(
      id: id ?? this.id,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      dialCode: dialCode ?? this.dialCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      isActive: isActive ?? this.isActive,
      reloadlySupported: reloadlySupported ?? this.reloadlySupported,
      vtpassSupported: vtpassSupported ?? this.vtpassSupported,
      operatorCount: operatorCount ?? this.operatorCount,
    );
  }
}
