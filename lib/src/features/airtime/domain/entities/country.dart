import 'package:equatable/equatable.dart';

/// Default countries used throughout the airtime feature
class DefaultCountries {
  DefaultCountries._();

  static const nigeria = Country(
    id: 'ng',
    code: 'NG',
    name: 'Nigeria',
    currency: 'NGN',
    dialCode: '+234',
    flag: '\u{1F1F3}\u{1F1EC}',
    currencySymbol: '₦',
  );
}

class Country extends Equatable {
  final String id;
  final String name;
  final String code; // ISO country code (e.g., 'NG', 'US', 'UK')
  final String dialCode; // Phone dial code (e.g., '+234', '+1', '+44')
  final String flag; // Emoji flag or asset path
  final String currency;
  final String currencySymbol;
  final bool isActive;
  final List<String> popularPrefixes; // Most common phone prefixes

  const Country({
    required this.id,
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
    required this.currency,
    required this.currencySymbol,
    this.isActive = true,
    this.popularPrefixes = const [],
  });

  String get displayName => name;
  String get flagAndName => '$flag $name';
  String get fullDialCode => '($dialCode)';

  Country copyWith({
    String? id,
    String? name,
    String? code,
    String? dialCode,
    String? flag,
    String? currency,
    String? currencySymbol,
    bool? isActive,
    List<String>? popularPrefixes,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      dialCode: dialCode ?? this.dialCode,
      flag: flag ?? this.flag,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      isActive: isActive ?? this.isActive,
      popularPrefixes: popularPrefixes ?? this.popularPrefixes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        dialCode,
        flag,
        currency,
        currencySymbol,
        isActive,
        popularPrefixes,
      ];
} 