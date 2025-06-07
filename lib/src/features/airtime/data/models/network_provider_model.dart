import '../../domain/entities/network_provider.dart';

class NetworkProviderModel extends NetworkProvider {
  const NetworkProviderModel({
    required super.id,
    required super.type,
    required super.name,
    required super.shortName,
    required super.logo,
    required super.primaryColor,
    required super.prefixes,
    required super.countryCode,
    super.isActive,
    super.discount,
    super.promoMessage,
    super.minAmount,
    super.maxAmount,
  });

  factory NetworkProviderModel.fromJson(Map<String, dynamic> json) {
    return NetworkProviderModel(
      id: json['id'] as String,
      type: NetworkProviderType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NetworkProviderType.mtn,
      ),
      name: json['name'] as String,
      shortName: json['shortName'] as String? ?? json['name'] as String,
      logo: json['logo'] as String? ?? '',
      primaryColor: json['primaryColor'] as String? ?? '#000000',
      prefixes: List<String>.from(json['prefixes'] as List),
      countryCode: json['countryCode'] as String,
      isActive: json['isActive'] as bool? ?? true,
      discount: (json['discount'] as num?)?.toDouble(),
      promoMessage: json['promoMessage'] as String?,
      minAmount: (json['minAmount'] as num?)?.toDouble() ?? 1.0,
      maxAmount: (json['maxAmount'] as num?)?.toDouble() ?? 1000.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'name': name,
      'shortName': shortName,
      'logo': logo,
      'primaryColor': primaryColor,
      'prefixes': prefixes,
      'countryCode': countryCode,
      'isActive': isActive,
      'discount': discount,
      'promoMessage': promoMessage,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
    };
  }

  @override
  NetworkProviderModel copyWith({
    String? id,
    NetworkProviderType? type,
    String? name,
    String? shortName,
    String? logo,
    String? primaryColor,
    List<String>? prefixes,
    String? countryCode,
    bool? isActive,
    double? discount,
    String? promoMessage,
    double? minAmount,
    double? maxAmount,
  }) {
    return NetworkProviderModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      logo: logo ?? this.logo,
      primaryColor: primaryColor ?? this.primaryColor,
      prefixes: prefixes ?? this.prefixes,
      countryCode: countryCode ?? this.countryCode,
      isActive: isActive ?? this.isActive,
      discount: discount ?? this.discount,
      promoMessage: promoMessage ?? this.promoMessage,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
    );
  }
} 