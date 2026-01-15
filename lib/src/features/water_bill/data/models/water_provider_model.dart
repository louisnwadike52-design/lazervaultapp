import '../../domain/entities/water_provider_entity.dart';

class WaterProviderModel extends WaterProviderEntity {
  const WaterProviderModel({
    required super.providerCode,
    required super.providerName,
    super.logoUrl,
    super.supportedStates,
    super.isActive,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_code': providerCode,
      'provider_name': providerName,
      'logo_url': logoUrl,
      'supported_states': supportedStates,
      'is_active': isActive,
    };
  }

  WaterProviderModel copyWith({
    String? providerCode,
    String? providerName,
    String? logoUrl,
    List<String>? supportedStates,
    bool? isActive,
  }) {
    return WaterProviderModel(
      providerCode: providerCode ?? this.providerCode,
      providerName: providerName ?? this.providerName,
      logoUrl: logoUrl ?? this.logoUrl,
      supportedStates: supportedStates ?? this.supportedStates,
      isActive: isActive ?? this.isActive,
    );
  }
}
