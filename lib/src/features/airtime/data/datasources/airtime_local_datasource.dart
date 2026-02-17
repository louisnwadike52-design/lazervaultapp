import '../models/airtime_transaction_model.dart';
import '../models/country_model.dart';
import '../models/network_provider_model.dart';

abstract class AirtimeLocalDataSource {
  Future<List<CountryModel>> getCountries();
  Future<CountryModel?> getCountryByCode(String countryCode);
  Future<List<NetworkProviderModel>> getNetworkProviders(String countryCode);
  Future<NetworkProviderModel?> getNetworkProviderById(String providerId);
  Future<NetworkProviderModel?> detectNetworkFromPhoneNumber(String phoneNumber, String countryCode);
  Future<List<AirtimeTransactionModel>> getTransactionHistory(String userId);
  Future<AirtimeTransactionModel?> getTransactionById(String transactionId);
}

class AirtimeLocalDataSourceImpl implements AirtimeLocalDataSource {
  // Mock countries data
  static const List<Map<String, dynamic>> _countriesData = [
    {
      'id': 'NG',
      'code': 'NG',
      'name': 'Nigeria',
      'flag': '🇳🇬',
      'dialCode': '+234',
      'currency': 'NGN',
      'currencySymbol': '₦',
      'popularPrefixes': ['0803', '0806', '0813', '0816', '0903', '0906', '0813', '0816'],
      'isActive': true,
    },
    {
      'id': 'US',
      'code': 'US',
      'name': 'United States',
      'flag': '🇺🇸',
      'dialCode': '+1',
      'currency': 'USD',
      'currencySymbol': '\$',
      'popularPrefixes': ['555', '202', '212', '310', '415', '713', '917', '646'],
      'isActive': true,
    },
    {
      'id': 'GB',
      'code': 'GB',
      'name': 'United Kingdom',
      'flag': '🇬🇧',
      'dialCode': '+44',
      'currency': 'GBP',
      'currencySymbol': '£',
      'popularPrefixes': ['07700', '07701', '07702', '07703', '07704', '07705'],
      'isActive': true,
    },
    {
      'id': 'IN',
      'code': 'IN',
      'name': 'India',
      'flag': '🇮🇳',
      'dialCode': '+91',
      'currency': 'INR',
      'currencySymbol': '₹',
      'popularPrefixes': ['98', '99', '97', '96', '95', '94', '93', '92'],
      'isActive': true,
    },
    {
      'id': 'ZA',
      'code': 'ZA',
      'name': 'South Africa',
      'flag': '🇿🇦',
      'dialCode': '+27',
      'currency': 'ZAR',
      'currencySymbol': 'R',
      'popularPrefixes': ['072', '073', '074', '076', '078', '079', '081', '082'],
      'isActive': true,
    },
    {
      'id': 'KE',
      'code': 'KE',
      'name': 'Kenya',
      'flag': '🇰🇪',
      'dialCode': '+254',
      'currency': 'KES',
      'currencySymbol': 'KSh',
      'popularPrefixes': ['0700', '0701', '0702', '0703', '0704', '0705', '0706', '0707'],
      'isActive': true,
    },
    {
      'id': 'GH',
      'code': 'GH',
      'name': 'Ghana',
      'flag': '🇬🇭',
      'dialCode': '+233',
      'currency': 'GHS',
      'currencySymbol': 'GH₵',
      'popularPrefixes': ['024', '025', '026', '027', '028', '020', '023', '050'],
      'isActive': true,
    },
  ];

  // Mock network providers data
  static const List<Map<String, dynamic>> _networkProvidersData = [
    // Nigeria
    {
      'id': 'mtn_ng',
      'name': 'MTN Nigeria',
      'shortName': 'MTN',
      'type': 'mtn',
      'countryCode': 'NG',
      'prefixes': ['0803', '0806', '0813', '0816', '0903', '0906', '0913', '0916'],
      'logo': 'assets/images/mtn_logo.png',
      'primaryColor': '#FFCC00',
      'isActive': true,
      'discount': 2.0,
      'minAmount': 50.0,
      'maxAmount': 10000.0,
      'operatorId': 'MTN',
    },
    {
      'id': 'airtel_ng',
      'name': 'Airtel Nigeria',
      'shortName': 'Airtel',
      'type': 'airtel',
      'countryCode': 'NG',
      'prefixes': ['0802', '0808', '0812', '0901', '0904', '0907', '0912'],
      'logo': 'assets/images/airtel_logo.png',
      'primaryColor': '#FF0000',
      'isActive': true,
      'discount': 1.5,
      'minAmount': 50.0,
      'maxAmount': 10000.0,
      'operatorId': 'AIRTEL',
    },
    {
      'id': 'glo_ng',
      'name': 'Globacom Nigeria',
      'type': 'glo',
      'countryCode': 'NG',
      'prefixes': ['0805', '0807', '0815', '0905', '0915'],
      'logoUrl': null,
      'primaryColor': '#00FF00',
      'isActive': true,
      'discountPercentage': 1.0,
      'operatorId': 'GLO',
    },
    {
      'id': '9mobile_ng',
      'name': '9mobile Nigeria',
      'type': 'ninemobile',
      'countryCode': 'NG',
      'prefixes': ['0809', '0817', '0818', '0908', '0909'],
      'logoUrl': null,
      'primaryColor': '#009900',
      'isActive': true,
      'discountPercentage': 1.0,
      'operatorId': '9MOBILE',
    },
    // United States
    {
      'id': 'verizon_us',
      'name': 'Verizon',
      'type': 'verizon',
      'countryCode': 'US',
      'prefixes': ['555', '202', '212'],
      'logoUrl': null,
      'primaryColor': '#FF0000',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    {
      'id': 'att_us',
      'name': 'AT&T',
      'type': 'att',
      'countryCode': 'US',
      'prefixes': ['310', '415', '713'],
      'logoUrl': null,
      'primaryColor': '#00A8E6',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    {
      'id': 'tmobile_us',
      'name': 'T-Mobile',
      'type': 'tmobile',
      'countryCode': 'US',
      'prefixes': ['917', '646'],
      'logoUrl': null,
      'primaryColor': '#E20074',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    // United Kingdom
    {
      'id': 'ee_gb',
      'name': 'EE',
      'type': 'ee',
      'countryCode': 'GB',
      'prefixes': ['07700', '07701'],
      'logoUrl': null,
      'primaryColor': '#FF6600',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    {
      'id': 'vodafone_gb',
      'name': 'Vodafone UK',
      'type': 'vodafone',
      'countryCode': 'GB',
      'prefixes': ['07702', '07703'],
      'logoUrl': null,
      'primaryColor': '#E60000',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    {
      'id': 'o2_gb',
      'name': 'O2 UK',
      'type': 'o2',
      'countryCode': 'GB',
      'prefixes': ['07704', '07705'],
      'logoUrl': null,
      'primaryColor': '#0066CC',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    // India
    {
      'id': 'jio_in',
      'name': 'Reliance Jio',
      'type': 'jio',
      'countryCode': 'IN',
      'prefixes': ['98', '99'],
      'logoUrl': null,
      'primaryColor': '#003399',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    {
      'id': 'vi_in',
      'name': 'Vi (Vodafone Idea)',
      'type': 'vi',
      'countryCode': 'IN',
      'prefixes': ['97', '96'],
      'logoUrl': null,
      'primaryColor': '#E60000',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    {
      'id': 'airtel_in',
      'name': 'Airtel India',
      'type': 'airtel',
      'countryCode': 'IN',
      'prefixes': ['95', '94'],
      'logoUrl': null,
      'primaryColor': '#FF0000',
      'isActive': true,
      'discountPercentage': 0.0,
    },
    // South Africa
    {
      'id': 'mtn_za',
      'name': 'MTN South Africa',
      'type': 'mtn',
      'countryCode': 'ZA',
      'prefixes': ['072', '073', '074'],
      'logoUrl': null,
      'primaryColor': '#FFD700',
      'isActive': true,
      'discountPercentage': 1.0,
    },
    {
      'id': 'vodacom_za',
      'name': 'Vodacom',
      'type': 'vodacom',
      'countryCode': 'ZA',
      'prefixes': ['076', '078', '079'],
      'logoUrl': null,
      'primaryColor': '#E60000',
      'isActive': true,
      'discountPercentage': 0.5,
    },
    // Kenya
    {
      'id': 'safaricom_ke',
      'name': 'Safaricom',
      'type': 'safaricom',
      'countryCode': 'KE',
      'prefixes': ['0700', '0701', '0702'],
      'logoUrl': null,
      'primaryColor': '#00AA00',
      'isActive': true,
      'discountPercentage': 1.0,
    },
    {
      'id': 'airtel_ke',
      'name': 'Airtel Kenya',
      'type': 'airtel',
      'countryCode': 'KE',
      'prefixes': ['0703', '0704', '0705'],
      'logoUrl': null,
      'primaryColor': '#FF0000',
      'isActive': true,
      'discountPercentage': 0.5,
    },
    // Ghana
    {
      'id': 'mtn_gh',
      'name': 'MTN Ghana',
      'type': 'mtn',
      'countryCode': 'GH',
      'prefixes': ['024', '025', '026'],
      'logoUrl': null,
      'primaryColor': '#FFD700',
      'isActive': true,
      'discountPercentage': 2.0,
    },
    {
      'id': 'vodafone_gh',
      'name': 'Vodafone Ghana',
      'type': 'vodafone',
      'countryCode': 'GH',
      'prefixes': ['020', '023', '050'],
      'logoUrl': null,
      'primaryColor': '#E60000',
      'isActive': true,
      'discountPercentage': 1.0,
    },
  ];

  @override
  Future<List<CountryModel>> getCountries() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return _countriesData.map((data) => CountryModel.fromJson(data)).toList();
  }

  @override
  Future<CountryModel?> getCountryByCode(String countryCode) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final countryData = _countriesData.firstWhere(
      (country) => country['code'] == countryCode,
      orElse: () => <String, dynamic>{},
    );
    
    if (countryData.isEmpty) return null;
    return CountryModel.fromJson(countryData);
  }

  @override
  Future<List<NetworkProviderModel>> getNetworkProviders(String countryCode) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final providers = _networkProvidersData
        .where((provider) => provider['countryCode'] == countryCode)
        .map((data) => NetworkProviderModel.fromJson(data))
        .toList();
    return providers;
  }

  @override
  Future<NetworkProviderModel?> getNetworkProviderById(String providerId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final providerData = _networkProvidersData.firstWhere(
      (provider) => provider['id'] == providerId,
      orElse: () => <String, dynamic>{},
    );
    
    if (providerData.isEmpty) return null;
    return NetworkProviderModel.fromJson(providerData);
  }

  @override
  Future<NetworkProviderModel?> detectNetworkFromPhoneNumber(String phoneNumber, String countryCode) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Clean phone number
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // Get providers for the country
    final providers = await getNetworkProviders(countryCode);
    
    // Find matching provider based on prefixes
    for (final provider in providers) {
      for (final prefix in provider.prefixes) {
        if (cleanNumber.startsWith(prefix)) {
          return provider;
        }
      }
    }
    
    return null;
  }

  @override
  Future<List<AirtimeTransactionModel>> getTransactionHistory(String userId) async {
    return [];
  }

  @override
  Future<AirtimeTransactionModel?> getTransactionById(String transactionId) async {
    return null;
  }
} 