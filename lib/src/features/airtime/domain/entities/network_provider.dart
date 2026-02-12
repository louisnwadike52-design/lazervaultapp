import 'dart:ui';
import 'package:equatable/equatable.dart';

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

extension NetworkProviderTypeExtension on NetworkProviderType {
  String get displayName {
    switch (this) {
      // Nigerian providers
      case NetworkProviderType.mtn:
        return 'MTN Nigeria';
      case NetworkProviderType.airtel:
        return 'Airtel Nigeria';
      case NetworkProviderType.glo:
        return 'Glo Mobile';
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return '9mobile';
        
      // US providers
      case NetworkProviderType.verizon:
        return 'Verizon';
      case NetworkProviderType.att:
        return 'AT&T';
      case NetworkProviderType.tmobile:
        return 'T-Mobile';
      case NetworkProviderType.sprint:
        return 'Sprint';
        
      // UK providers
      case NetworkProviderType.ee:
        return 'EE';
      case NetworkProviderType.vodafone:
        return 'Vodafone UK';
      case NetworkProviderType.o2:
        return 'O2';
      case NetworkProviderType.three:
        return 'Three UK';
        
      // Indian providers
      case NetworkProviderType.jio:
        return 'Jio';
      case NetworkProviderType.airtelIndia:
        return 'Airtel India';
      case NetworkProviderType.vi:
        return 'Vi (Vodafone Idea)';
      case NetworkProviderType.bsnl:
        return 'BSNL';
        
      // South African providers
      case NetworkProviderType.vodacomSa:
        return 'Vodacom';
      case NetworkProviderType.mtnSa:
        return 'MTN South Africa';
      case NetworkProviderType.cellC:
        return 'Cell C';
      case NetworkProviderType.telkomMobile:
        return 'Telkom Mobile';
        
      // Kenyan providers
      case NetworkProviderType.safaricom:
        return 'Safaricom';
      case NetworkProviderType.airtelKenya:
        return 'Airtel Kenya';
      case NetworkProviderType.telkomKenya:
        return 'Telkom Kenya';
        
      // Ghanaian providers
      case NetworkProviderType.mtnGhana:
        return 'MTN Ghana';
      case NetworkProviderType.vodafoneGhana:
        return 'Vodafone Ghana';
      case NetworkProviderType.airtelTigo:
        return 'AirtelTigo';
    }
  }

  Color get color {
    switch (this) {
      case NetworkProviderType.mtn:
      case NetworkProviderType.mtnSa:
      case NetworkProviderType.mtnGhana:
        return const Color(0xFFFFCC00);
      case NetworkProviderType.airtel:
      case NetworkProviderType.airtelIndia:
      case NetworkProviderType.airtelKenya:
        return const Color(0xFFFF0000);
      case NetworkProviderType.glo:
        return const Color(0xFF00B04F);
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return const Color(0xFF00AA4F);
      case NetworkProviderType.verizon:
        return const Color(0xFFCD040B);
      case NetworkProviderType.att:
        return const Color(0xFF00A8E0);
      case NetworkProviderType.tmobile:
        return const Color(0xFFE20074);
      case NetworkProviderType.sprint:
        return const Color(0xFFFFD100);
      case NetworkProviderType.ee:
        return const Color(0xFFF6A01A);
      case NetworkProviderType.vodafone:
      case NetworkProviderType.vodacomSa:
      case NetworkProviderType.vodafoneGhana:
        return const Color(0xFFE60000);
      case NetworkProviderType.o2:
        return const Color(0xFF0066CC);
      case NetworkProviderType.three:
        return const Color(0xFF006B5B);
      case NetworkProviderType.jio:
        return const Color(0xFF0073E6);
      case NetworkProviderType.vi:
        return const Color(0xFF8B2635);
      case NetworkProviderType.bsnl:
        return const Color(0xFFFF6B35);
      case NetworkProviderType.cellC:
        return const Color(0xFF4A90E2);
      case NetworkProviderType.telkomMobile:
      case NetworkProviderType.telkomKenya:
        return const Color(0xFF008744);
      case NetworkProviderType.safaricom:
        return const Color(0xFF00B140);
      case NetworkProviderType.airtelTigo:
        return const Color(0xFFFF6B35);
    }
  }

  String get shortName {
    switch (this) {
      case NetworkProviderType.mtn:
      case NetworkProviderType.mtnSa:
      case NetworkProviderType.mtnGhana:
        return 'MTN';
      case NetworkProviderType.airtel:
      case NetworkProviderType.airtelIndia:
      case NetworkProviderType.airtelKenya:
        return 'Airtel';
      case NetworkProviderType.glo:
        return 'Glo';
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return '9mobile';
      case NetworkProviderType.verizon:
        return 'Verizon';
      case NetworkProviderType.att:
        return 'AT&T';
      case NetworkProviderType.tmobile:
        return 'T-Mobile';
      case NetworkProviderType.sprint:
        return 'Sprint';
      case NetworkProviderType.ee:
        return 'EE';
      case NetworkProviderType.vodafone:
      case NetworkProviderType.vodacomSa:
      case NetworkProviderType.vodafoneGhana:
        return 'Vodafone';
      case NetworkProviderType.o2:
        return 'O2';
      case NetworkProviderType.three:
        return 'Three';
      case NetworkProviderType.jio:
        return 'Jio';
      case NetworkProviderType.vi:
        return 'Vi';
      case NetworkProviderType.bsnl:
        return 'BSNL';
      case NetworkProviderType.cellC:
        return 'Cell C';
      case NetworkProviderType.telkomMobile:
      case NetworkProviderType.telkomKenya:
        return 'Telkom';
      case NetworkProviderType.safaricom:
        return 'Safaricom';
      case NetworkProviderType.airtelTigo:
        return 'AirtelTigo';
    }
  }

  String get logo {
    switch (this) {
      case NetworkProviderType.mtn:
      case NetworkProviderType.mtnSa:
      case NetworkProviderType.mtnGhana:
        return 'assets/images/mtn_logo.png';
      case NetworkProviderType.airtel:
      case NetworkProviderType.airtelIndia:
      case NetworkProviderType.airtelKenya:
        return 'assets/images/airtel_logo.png';
      case NetworkProviderType.glo:
        return 'assets/images/glo_logo.png';
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return 'assets/images/9mobile_logo.png';
      case NetworkProviderType.verizon:
        return 'assets/images/verizon_logo.png';
      case NetworkProviderType.att:
        return 'assets/images/att_logo.png';
      case NetworkProviderType.tmobile:
        return 'assets/images/tmobile_logo.png';
      case NetworkProviderType.sprint:
        return 'assets/images/sprint_logo.png';
      case NetworkProviderType.ee:
        return 'assets/images/ee_logo.png';
      case NetworkProviderType.vodafone:
      case NetworkProviderType.vodacomSa:
      case NetworkProviderType.vodafoneGhana:
        return 'assets/images/vodafone_logo.png';
      case NetworkProviderType.o2:
        return 'assets/images/o2_logo.png';
      case NetworkProviderType.three:
        return 'assets/images/three_logo.png';
      case NetworkProviderType.jio:
        return 'assets/images/jio_logo.png';
      case NetworkProviderType.vi:
        return 'assets/images/vi_logo.png';
      case NetworkProviderType.bsnl:
        return 'assets/images/bsnl_logo.png';
      case NetworkProviderType.cellC:
        return 'assets/images/cellc_logo.png';
      case NetworkProviderType.telkomMobile:
      case NetworkProviderType.telkomKenya:
        return 'assets/images/telkom_logo.png';
      case NetworkProviderType.safaricom:
        return 'assets/images/safaricom_logo.png';
      case NetworkProviderType.airtelTigo:
        return 'assets/images/airteltigo_logo.png';
    }
  }

  String get primaryColor {
    switch (this) {
      case NetworkProviderType.mtn:
      case NetworkProviderType.mtnSa:
      case NetworkProviderType.mtnGhana:
        return '#FFCC00';
      case NetworkProviderType.airtel:
      case NetworkProviderType.airtelIndia:
      case NetworkProviderType.airtelKenya:
        return '#FF0000';
      case NetworkProviderType.glo:
        return '#00B04F';
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return '#00AA4F';
      case NetworkProviderType.verizon:
        return '#CD040B';
      case NetworkProviderType.att:
        return '#00A8E0';
      case NetworkProviderType.tmobile:
        return '#E20074';
      case NetworkProviderType.sprint:
        return '#FFD100';
      case NetworkProviderType.ee:
        return '#F6A01A';
      case NetworkProviderType.vodafone:
      case NetworkProviderType.vodacomSa:
      case NetworkProviderType.vodafoneGhana:
        return '#E60000';
      case NetworkProviderType.o2:
        return '#0066CC';
      case NetworkProviderType.three:
        return '#006B5B';
      case NetworkProviderType.jio:
        return '#0073E6';
      case NetworkProviderType.vi:
        return '#8B2635';
      case NetworkProviderType.bsnl:
        return '#FF6B35';
      case NetworkProviderType.cellC:
        return '#4A90E2';
      case NetworkProviderType.telkomMobile:
      case NetworkProviderType.telkomKenya:
        return '#008744';
      case NetworkProviderType.safaricom:
        return '#00B140';
      case NetworkProviderType.airtelTigo:
        return '#FF6B35';
    }
  }

  String get countryCode {
    switch (this) {
      case NetworkProviderType.mtn:
      case NetworkProviderType.airtel:
      case NetworkProviderType.glo:
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return 'NG';
      case NetworkProviderType.verizon:
      case NetworkProviderType.att:
      case NetworkProviderType.tmobile:
      case NetworkProviderType.sprint:
        return 'US';
      case NetworkProviderType.ee:
      case NetworkProviderType.vodafone:
      case NetworkProviderType.o2:
      case NetworkProviderType.three:
        return 'GB';
      case NetworkProviderType.jio:
      case NetworkProviderType.airtelIndia:
      case NetworkProviderType.vi:
      case NetworkProviderType.bsnl:
        return 'IN';
      case NetworkProviderType.vodacomSa:
      case NetworkProviderType.mtnSa:
      case NetworkProviderType.cellC:
      case NetworkProviderType.telkomMobile:
        return 'ZA';
      case NetworkProviderType.safaricom:
      case NetworkProviderType.airtelKenya:
      case NetworkProviderType.telkomKenya:
        return 'KE';
      case NetworkProviderType.mtnGhana:
      case NetworkProviderType.vodafoneGhana:
      case NetworkProviderType.airtelTigo:
        return 'GH';
    }
  }

  List<String> get prefixes {
    switch (this) {
      // Nigerian providers
      case NetworkProviderType.mtn:
        return ['0803', '0806', '0813', '0814', '0816', '0903', '0906', '0913', '0916', '0703', '0706', '0704'];
      case NetworkProviderType.airtel:
        return ['0802', '0808', '0812', '0701', '0708', '0901', '0902', '0904', '0907', '0912'];
      case NetworkProviderType.glo:
        return ['0805', '0807', '0815', '0811', '0705', '0905', '0915'];
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return ['0809', '0817', '0818', '0819', '0909', '0908'];
        
      // US providers (area codes are different, using sample patterns)
      case NetworkProviderType.verizon:
        return ['212', '646', '917', '347', '718', '929', '332'];
      case NetworkProviderType.att:
        return ['214', '469', '945', '972', '213', '323', '424'];
      case NetworkProviderType.tmobile:
        return ['206', '253', '360', '425', '564', '202', '771'];
      case NetworkProviderType.sprint:
        return ['316', '620', '785', '913', '785', '316', '620'];
        
      // UK providers
      case NetworkProviderType.ee:
        return ['07700', '07701', '07702', '07703', '07704'];
      case NetworkProviderType.vodafone:
        return ['07710', '07711', '07712', '07713', '07714'];
      case NetworkProviderType.o2:
        return ['07720', '07721', '07722', '07723', '07724'];
      case NetworkProviderType.three:
        return ['07730', '07731', '07732', '07733', '07734'];
        
      // Indian providers
      case NetworkProviderType.jio:
        return ['8999', '8998', '8997', '7999', '7998', '6999'];
      case NetworkProviderType.airtelIndia:
        return ['9999', '9998', '9997', '8999', '8998', '7999'];
      case NetworkProviderType.vi:
        return ['9899', '9898', '9897', '8899', '8898', '7899'];
      case NetworkProviderType.bsnl:
        return ['9799', '9798', '9797', '8799', '8798', '7799'];
        
      // South African providers
      case NetworkProviderType.vodacomSa:
        return ['082', '083', '084', '060', '061', '062'];
      case NetworkProviderType.mtnSa:
        return ['081', '083', '072', '073', '074', '076'];
      case NetworkProviderType.cellC:
        return ['084', '074', '076', '078', '079', '080'];
      case NetworkProviderType.telkomMobile:
        return ['081', '082', '083', '084', '085', '086'];
        
      // Kenyan providers
      case NetworkProviderType.safaricom:
        return ['0722', '0721', '0720', '0799', '0798', '0797'];
      case NetworkProviderType.airtelKenya:
        return ['0733', '0734', '0735', '0736', '0737', '0738'];
      case NetworkProviderType.telkomKenya:
        return ['0770', '0771', '0772', '0773', '0774', '0775'];
        
      // Ghanaian providers
      case NetworkProviderType.mtnGhana:
        return ['0244', '0245', '0246', '0247', '0248', '0249'];
      case NetworkProviderType.vodafoneGhana:
        return ['0202', '0203', '0204', '0205', '0206', '0207'];
      case NetworkProviderType.airtelTigo:
        return ['0277', '0278', '0279', '0270', '0271', '0272'];
    }
  }
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
      ];
} 