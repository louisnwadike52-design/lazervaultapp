import 'package:equatable/equatable.dart';

class ElectricityProviderEntity extends Equatable {
  final String id;
  final String providerCode;
  final String providerName;
  final String country;
  final String? logoUrl;
  final String? description;
  final double? minAmount;
  final double? maxAmount;
  final bool supportsPrepaid;
  final bool supportsPostpaid;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ElectricityProviderEntity({
    required this.id,
    required this.providerCode,
    required this.providerName,
    required this.country,
    this.logoUrl,
    this.description,
    this.minAmount,
    this.maxAmount,
    required this.supportsPrepaid,
    required this.supportsPostpaid,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasAmountLimits => minAmount != null && maxAmount != null;
  bool get supportsBothMeterTypes => supportsPrepaid && supportsPostpaid;

  @override
  List<Object?> get props => [
        id,
        providerCode,
        providerName,
        country,
        logoUrl,
        description,
        minAmount,
        maxAmount,
        supportsPrepaid,
        supportsPostpaid,
        isActive,
        createdAt,
        updatedAt,
      ];
}
