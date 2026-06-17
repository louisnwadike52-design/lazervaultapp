import 'package:equatable/equatable.dart';

class WaterProviderEntity extends Equatable {
  final String providerCode;
  final String providerName;
  final String? logoUrl;
  final List<String> supportedStates;
  final bool isActive;
  /// Per-disco amount bounds sourced from VTpass (via the backend's
  /// `bill_providers` row that the seeder populates from the provider's
  /// service-variation catalogue). When either is zero, the Flutter
  /// amount input treats the bound as absent and applies a safe
  /// fallback (1 → +infinity) so old builds keep working.
  final double minAmount;
  final double maxAmount;

  const WaterProviderEntity({
    required this.providerCode,
    required this.providerName,
    this.logoUrl,
    this.supportedStates = const [],
    this.isActive = true,
    this.minAmount = 0,
    this.maxAmount = 0,
  });

  bool get hasAmountLimits => minAmount > 0 && maxAmount > 0;

  @override
  List<Object?> get props => [
        providerCode,
        providerName,
        logoUrl,
        supportedStates,
        isActive,
        minAmount,
        maxAmount,
      ];
}
