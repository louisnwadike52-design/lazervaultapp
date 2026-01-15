import 'package:equatable/equatable.dart';

class WaterProviderEntity extends Equatable {
  final String providerCode;
  final String providerName;
  final String? logoUrl;
  final List<String> supportedStates;
  final bool isActive;

  const WaterProviderEntity({
    required this.providerCode,
    required this.providerName,
    this.logoUrl,
    this.supportedStates = const [],
    this.isActive = true,
  });

  @override
  List<Object?> get props => [providerCode, providerName, logoUrl, supportedStates, isActive];
}
