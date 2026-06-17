import 'package:equatable/equatable.dart';

class IntlAirtimeCountry extends Equatable {
  final String id;
  final String countryCode;
  final String countryName;
  final String dialCode;
  final String currencyCode;
  final String currencySymbol;
  final String flagEmoji;
  final bool isActive;
  final bool reloadlySupported;
  final bool vtpassSupported;
  final int operatorCount;

  const IntlAirtimeCountry({
    required this.id,
    required this.countryCode,
    required this.countryName,
    required this.dialCode,
    required this.currencyCode,
    required this.currencySymbol,
    required this.flagEmoji,
    this.isActive = true,
    this.reloadlySupported = false,
    this.vtpassSupported = false,
    this.operatorCount = 0,
  });

  factory IntlAirtimeCountry.empty() {
    return const IntlAirtimeCountry(
      id: '',
      countryCode: '',
      countryName: '',
      dialCode: '',
      currencyCode: '',
      currencySymbol: '',
      flagEmoji: '',
    );
  }

  IntlAirtimeCountry copyWith({
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
    return IntlAirtimeCountry(
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

  @override
  List<Object?> get props => [
        id,
        countryCode,
        countryName,
        dialCode,
        currencyCode,
        currencySymbol,
        flagEmoji,
        isActive,
        reloadlySupported,
        vtpassSupported,
        operatorCount,
      ];
}
