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
  final double serviceFee;
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
    this.serviceFee = 0.0,
    required this.supportsPrepaid,
    required this.supportsPostpaid,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasAmountLimits => minAmount != null && maxAmount != null;
  bool get supportsBothMeterTypes => supportsPrepaid && supportsPostpaid;

  Map<String, dynamic> toJson() => {
        'id': id,
        'providerCode': providerCode,
        'providerName': providerName,
        'country': country,
        'logoUrl': logoUrl,
        'description': description,
        'minAmount': minAmount,
        'maxAmount': maxAmount,
        'serviceFee': serviceFee,
        'supportsPrepaid': supportsPrepaid,
        'supportsPostpaid': supportsPostpaid,
        'isActive': isActive,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory ElectricityProviderEntity.fromJson(Map<String, dynamic> json) =>
      ElectricityProviderEntity(
        id: json['id'] as String,
        providerCode: json['providerCode'] as String,
        providerName: json['providerName'] as String,
        country: json['country'] as String,
        logoUrl: json['logoUrl'] as String?,
        description: json['description'] as String?,
        minAmount: (json['minAmount'] as num?)?.toDouble(),
        maxAmount: (json['maxAmount'] as num?)?.toDouble(),
        serviceFee: (json['serviceFee'] as num?)?.toDouble() ?? 0.0,
        supportsPrepaid: json['supportsPrepaid'] as bool,
        supportsPostpaid: json['supportsPostpaid'] as bool,
        isActive: json['isActive'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

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
        serviceFee,
        supportsPrepaid,
        supportsPostpaid,
        isActive,
        createdAt,
        updatedAt,
      ];
}
