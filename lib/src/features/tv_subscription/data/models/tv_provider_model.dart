import '../../domain/entities/tv_provider_entity.dart';

class TVProviderModel extends TVProviderEntity {
  const TVProviderModel({
    required super.providerCode,
    required super.providerName,
    super.logoUrl,
    required super.category,
    super.supportedCountries,
    super.isActive,
  });

  factory TVProviderModel.fromJson(Map<String, dynamic> json) {
    return TVProviderModel(
      providerCode: json['provider_code'] as String? ?? '',
      providerName: json['provider_name'] as String? ?? '',
      logoUrl: json['logo_url'] as String?,
      category: json['category'] as String? ?? 'tv',
      supportedCountries: json['supported_countries'] != null
          ? List<String>.from(json['supported_countries'] as List)
          : [],
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_code': providerCode,
      'provider_name': providerName,
      'logo_url': logoUrl,
      'category': category,
      'supported_countries': supportedCountries,
      'is_active': isActive,
    };
  }
}
