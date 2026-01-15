import 'package:equatable/equatable.dart';

class TVProviderEntity extends Equatable {
  final String providerCode;
  final String providerName;
  final String? logoUrl;
  final String category; // 'tv' or 'internet'
  final List<String> supportedCountries;
  final bool isActive;

  const TVProviderEntity({
    required this.providerCode,
    required this.providerName,
    this.logoUrl,
    required this.category,
    this.supportedCountries = const [],
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        providerCode,
        providerName,
        logoUrl,
        category,
        supportedCountries,
        isActive,
      ];
}
