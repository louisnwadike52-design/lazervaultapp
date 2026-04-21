import '../../domain/entities/water_provider_entity.dart';

class WaterProviderModel extends WaterProviderEntity {
  const WaterProviderModel({
    required super.providerCode,
    required super.providerName,
    super.logoUrl,
    super.supportedStates,
    super.isActive,
    super.minAmount,
    super.maxAmount,
  });

  factory WaterProviderModel.fromJson(Map<String, dynamic> json) {
    return WaterProviderModel(
      providerCode: json['provider_code'] as String? ?? '',
      providerName: json['provider_name'] as String? ?? '',
      logoUrl: json['logo_url'] as String?,
      supportedStates: json['supported_states'] != null
          ? List<String>.from(json['supported_states'] as List)
          : [],
      isActive: json['is_active'] as bool? ?? true,
      minAmount: (json['min_amount'] as num?)?.toDouble() ?? 0,
      maxAmount: (json['max_amount'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_code': providerCode,
      'provider_name': providerName,
      'logo_url': logoUrl,
      'supported_states': supportedStates,
      'is_active': isActive,
      'min_amount': minAmount,
      'max_amount': maxAmount,
    };
  }

  WaterProviderModel copyWith({
    String? providerCode,
    String? providerName,
    String? logoUrl,
    List<String>? supportedStates,
    bool? isActive,
    double? minAmount,
    double? maxAmount,
  }) {
    return WaterProviderModel(
      providerCode: providerCode ?? this.providerCode,
      providerName: providerName ?? this.providerName,
      logoUrl: logoUrl ?? this.logoUrl,
      supportedStates: supportedStates ?? this.supportedStates,
      isActive: isActive ?? this.isActive,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
    );
  }
}
