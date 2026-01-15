import '../../domain/entities/tv_package_entity.dart';

class TVPackageModel extends TVPackageEntity {
  const TVPackageModel({
    required super.packageCode,
    required super.packageName,
    required super.providerCode,
    required super.price,
    required super.currency,
    required super.duration,
    super.description,
    super.channels,
    super.features,
    super.isActive,
  });

  factory TVPackageModel.fromJson(Map<String, dynamic> json) {
    return TVPackageModel(
      packageCode: json['package_code'] as String? ?? '',
      packageName: json['package_name'] as String? ?? '',
      providerCode: json['provider_code'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'NGN',
      duration: json['duration'] as int? ?? 30,
      description: json['description'] as String?,
      channels: json['channels'] != null
          ? List<String>.from(json['channels'] as List)
          : [],
      features: json['features'] != null
          ? List<String>.from(json['features'] as List)
          : [],
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'package_code': packageCode,
      'package_name': packageName,
      'provider_code': providerCode,
      'price': price,
      'currency': currency,
      'duration': duration,
      'description': description,
      'channels': channels,
      'features': features,
      'is_active': isActive,
    };
  }
}
