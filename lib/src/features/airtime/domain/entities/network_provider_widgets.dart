part of 'network_provider.dart';

enum NetworkProviderType {
  // Nigerian providers
  mtn,
  airtel,
  glo,
  etisalat,
  ninemobile,
  
  // US providers
  verizon,
  att,
  tmobile,
  sprint,
  
  // UK providers
  ee,
  vodafone,
  o2,
  three,
  
  // Indian providers
  jio,
  airtelIndia,
  vi,
  bsnl,
  
  // South African providers
  vodacomSa,
  mtnSa,
  cellC,
  telkomMobile,
  
  // Kenyan providers
  safaricom,
  airtelKenya,
  telkomKenya,
  
  // Ghanaian providers
  mtnGhana,
  vodafoneGhana,
  airtelTigo,
}

class NetworkProvider extends Equatable {
  final String id;
  final NetworkProviderType type;
  final String name;
  final String shortName;
  final String logo;
  final String primaryColor;
  final List<String> prefixes;
  final String countryCode;
  final bool isActive;
  final double? discount;
  final String? promoMessage;
  final double minAmount;
  final double maxAmount;
  final String? operatorId;
  final String? reloadlyOperatorId;

  const NetworkProvider({
    required this.id,
    required this.type,
    required this.name,
    required this.shortName,
    required this.logo,
    required this.primaryColor,
    required this.prefixes,
    required this.countryCode,
    this.isActive = true,
    this.discount,
    this.promoMessage,
    this.minAmount = 1.0,
    this.maxAmount = 1000.0,
    this.operatorId,
    this.reloadlyOperatorId,
  });

  bool canHandleNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.length < 3) return false;
    
    // Check if any prefix matches the beginning of the phone number
    for (final prefix in prefixes) {
      if (cleanNumber.startsWith(prefix)) {
        return true;
      }
    }
    return false;
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
      'operatorId': operatorId,
      'reloadlyOperatorId': reloadlyOperatorId,
    };
  }

  factory NetworkProvider.fromJson(Map<String, dynamic> json) {
    return NetworkProvider(
      id: json['id'] as String,
      type: NetworkProviderType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NetworkProviderType.mtn,
      ),
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      logo: json['logo'] as String,
      primaryColor: json['primaryColor'] as String,
      prefixes: (json['prefixes'] as List).cast<String>(),
      countryCode: json['countryCode'] as String,
      isActive: json['isActive'] as bool? ?? true,
      discount: json['discount'] as double?,
      promoMessage: json['promoMessage'] as String?,
      minAmount: (json['minAmount'] as num?)?.toDouble() ?? 1.0,
      maxAmount: (json['maxAmount'] as num?)?.toDouble() ?? 1000.0,
      operatorId: json['operatorId'] as String?,
      reloadlyOperatorId: json['reloadlyOperatorId'] as String?,
    );
  }

  NetworkProvider copyWith({
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
    String? reloadlyOperatorId,
  }) {
    return NetworkProvider(
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
      reloadlyOperatorId: reloadlyOperatorId ?? this.reloadlyOperatorId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        shortName,
        logo,
        primaryColor,
        prefixes,
        countryCode,
        isActive,
        discount,
        promoMessage,
        minAmount,
        maxAmount,
        operatorId,
        reloadlyOperatorId,
      ];
}
