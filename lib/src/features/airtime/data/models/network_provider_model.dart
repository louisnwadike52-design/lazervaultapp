import '../../../../generated/utility-payments.pb.dart' as pb;
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
    super.operatorId,
  });

  factory NetworkProviderModel.fromProto(pb.AirtimeProvider provider) {
    final network = provider.network.toLowerCase();
    return NetworkProviderModel(
      id: provider.id,
      type: _networkTypeFromString(network),
      name: provider.name,
      shortName: provider.network,
      logo: provider.logoUrl,
      primaryColor: _colorForNetwork(network),
      prefixes: const [], // Prefixes come from local data / phone number detection
      countryCode: provider.countryCode,
      isActive: provider.isActive,
      discount: provider.commissionRate,
      minAmount: provider.minAmount,
      maxAmount: provider.maxAmount,
      operatorId: provider.operatorId.isNotEmpty ? provider.operatorId : null,
    );
  }

  static NetworkProviderType _networkTypeFromString(String network) {
    switch (network) {
      case 'mtn':
        return NetworkProviderType.mtn;
      case 'airtel':
        return NetworkProviderType.airtel;
      case 'glo':
        return NetworkProviderType.glo;
      case '9mobile':
      case 'ninemobile':
      case 'etisalat':
        return NetworkProviderType.ninemobile;
      case 'safaricom':
        return NetworkProviderType.safaricom;
      case 'vodafone':
        return NetworkProviderType.vodafone;
      case 'vodacom':
        return NetworkProviderType.vodacomSa;
      default:
        return NetworkProviderType.mtn;
    }
  }

  static String _colorForNetwork(String network) {
    switch (network) {
      case 'mtn':
        return '#FFCC00';
      case 'airtel':
        return '#FF0000';
      case 'glo':
        return '#00B04F';
      case '9mobile':
      case 'ninemobile':
        return '#00AA4F';
      default:
        return '#3B82F6';
    }
  }

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
      operatorId: json['operatorId'] as String?,
    );
  }

  @override
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
      'operatorId': operatorId,
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
    String? operatorId,
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
      operatorId: operatorId ?? this.operatorId,
    );
  }
} 