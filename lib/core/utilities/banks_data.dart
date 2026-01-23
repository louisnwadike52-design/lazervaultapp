// Banks Data by Country
// Comprehensive list of banks for recipient bank selection by country/locale
//
// Banks are listed with their name and bank code for verification APIs.
// Popular banks are listed first for quick selection.

/// Provides static bank data for multiple countries with fallback support
/// when the backend API is unavailable.
class BanksData {
  /// Get banks for a specific country code
  static List<Map<String, String>> getBanksForCountry(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'NG':
        return nigerianBanks;
      case 'GB':
        return ukBanks;
      case 'US':
        return usBanks;
      case 'GH':
        return ghanaBanks;
      case 'KE':
        return kenyaBanks;
      case 'ZA':
        return southAfricaBanks;
      default:
        return nigerianBanks; // Default to Nigeria
    }
  }

  /// Get popular banks for a specific country code (first 6 banks)
  static List<Map<String, String>> getPopularBanksForCountry(String countryCode) {
    final banks = getBanksForCountry(countryCode);
    return banks.take(6).toList();
  }

  /// Get country display name
  static String getCountryDisplayName(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'NG':
        return 'Nigeria';
      case 'GB':
        return 'United Kingdom';
      case 'US':
        return 'United States';
      case 'GH':
        return 'Ghana';
      case 'KE':
        return 'Kenya';
      case 'ZA':
        return 'South Africa';
      default:
        return countryCode;
    }
  }

  /// Get country flag emoji
  static String getCountryFlag(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'NG':
        return '🇳🇬';
      case 'GB':
        return '🇬🇧';
      case 'US':
        return '🇺🇸';
      case 'GH':
        return '🇬🇭';
      case 'KE':
        return '🇰🇪';
      case 'ZA':
        return '🇿🇦';
      default:
        return '🏳️';
    }
  }

  /// Search banks by query within a country
  static List<Map<String, String>> searchBanks(String countryCode, String query) {
    final banks = getBanksForCountry(countryCode);
    if (query.trim().isEmpty) {
      return banks;
    }

    final lowerQuery = query.toLowerCase();
    return banks.where((bank) =>
      bank['name']!.toLowerCase().contains(lowerQuery) ||
      bank['code']!.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  /// Get bank logo URL by bank code (Nigerian banks use nigerianbanks.xyz CDN)
  static String? getBankLogoUrl(String bankCode, {String country = 'NG'}) {
    if (country.toUpperCase() == 'NG') {
      // Nigerian banks logo CDN (Paystack/Mono compatible)
      return 'https://nigerianbanks.xyz/logo/$bankCode.png';
    }
    // For other countries, return null to use fallback
    return null;
  }

  /// Get bank logo URL by bank name (searches for code first)
  static String? getBankLogoUrlByName(String bankName, {String country = 'NG'}) {
    final banks = getBanksForCountry(country);
    final bank = banks.firstWhere(
      (b) => b['name']!.toLowerCase() == bankName.toLowerCase(),
      orElse: () => {},
    );
    if (bank.isNotEmpty && bank['code'] != null) {
      return getBankLogoUrl(bank['code']!, country: country);
    }
    return null;
  }

  /// Get bank code by name
  static String? getBankCodeByName(String bankName, {String country = 'NG'}) {
    final banks = getBanksForCountry(country);
    final bank = banks.firstWhere(
      (b) => b['name']!.toLowerCase() == bankName.toLowerCase(),
      orElse: () => {},
    );
    return bank.isNotEmpty ? bank['code'] : null;
  }

  // ============================================================
  // NIGERIAN BANKS - Real Nigerian banks with Flutterwave codes
  // ============================================================
  static const List<Map<String, String>> nigerianBanks = [
    // Popular Banks (Top 6)
    {'name': 'Access Bank', 'code': '044'},
    {'name': 'GTBank (Guaranty Trust Bank)', 'code': '058'},
    {'name': 'First Bank of Nigeria', 'code': '011'},
    {'name': 'UBA (United Bank for Africa)', 'code': '033'},
    {'name': 'Zenith Bank', 'code': '057'},
    {'name': 'Kuda Bank', 'code': '50211'},

    // Other Major Banks
    {'name': 'Access Bank (Diamond)', 'code': '063'},
    {'name': 'Citibank Nigeria', 'code': '023'},
    {'name': 'Ecobank Nigeria', 'code': '050'},
    {'name': 'Fidelity Bank', 'code': '070'},
    {'name': 'FCMB (First City Monument Bank)', 'code': '214'},
    {'name': 'Heritage Bank', 'code': '030'},
    {'name': 'Keystone Bank', 'code': '082'},
    {'name': 'Polaris Bank', 'code': '076'},
    {'name': 'Stanbic IBTC Bank', 'code': '221'},
    {'name': 'Standard Chartered Bank', 'code': '068'},
    {'name': 'Sterling Bank', 'code': '232'},
    {'name': 'Union Bank of Nigeria', 'code': '032'},
    {'name': 'Unity Bank', 'code': '215'},
    {'name': 'Wema Bank', 'code': '035'},

    // Digital/Mobile Banks
    {'name': 'OPay', 'code': '999992'},
    {'name': 'PalmPay', 'code': '999991'},
    {'name': 'Moniepoint MFB', 'code': '50515'},
    {'name': 'VFD Microfinance Bank', 'code': '566'},
    {'name': 'Carbon (formerly Paylater)', 'code': '565'},
    {'name': 'Rubies Bank (Rubies MFB)', 'code': '125'},
    {'name': 'Sparkle Microfinance Bank', 'code': '51310'},
    {'name': 'Eyowo MFB', 'code': '50126'},
    {'name': 'ALAT by Wema', 'code': '035'},
    {'name': 'OneBank MFB', 'code': '51244'},

    // Microfinance Banks
    {'name': 'AB Microfinance Bank', 'code': '51259'},
    {'name': 'Accion MFB', 'code': '602'},
    {'name': 'Bowen MFB', 'code': '50931'},
    {'name': 'Coronation Merchant Bank', 'code': '559'},
    {'name': 'FSDH Merchant Bank', 'code': '501'},
    {'name': 'Globus Bank', 'code': '00103'},
    {'name': 'Hasal MFB', 'code': '50383'},
    {'name': 'Jaiz Bank', 'code': '301'},
    {'name': 'Lotus Bank', 'code': '303'},
    {'name': 'LAPO MFB', 'code': '50549'},
    {'name': 'Mint MFB', 'code': '50304'},
    {'name': 'NPF MFB', 'code': '552'},
    {'name': 'Parallex Bank', 'code': '526'},
    {'name': 'Providus Bank', 'code': '101'},
    {'name': 'Rand Merchant Bank', 'code': '502'},
    {'name': 'Rephidim MFB', 'code': '50994'},
    {'name': 'Rolez MFB', 'code': '51316'},
    {'name': 'Safe Haven MFB', 'code': '51113'},
    {'name': 'SunTrust Bank', 'code': '100'},
    {'name': 'TAJ Bank', 'code': '302'},
    {'name': 'Tangerine MFB', 'code': '51269'},
    {'name': 'TCF MFB', 'code': '51211'},
    {'name': 'Titan Trust Bank', 'code': '102'},
    {'name': 'Unical MFB', 'code': '50871'},
    {'name': '9 Payment Service Bank', 'code': '120001'},
    {'name': 'Abbey Mortgage Bank', 'code': '801'},
    {'name': 'Covenant MFB', 'code': '559001'},
  ];

  // ============================================================
  // UK BANKS
  // ============================================================
  static const List<Map<String, String>> ukBanks = [
    // Popular Banks
    {'name': 'Barclays', 'code': 'BARC'},
    {'name': 'HSBC', 'code': 'HSBC'},
    {'name': 'Lloyds Bank', 'code': 'LOYD'},
    {'name': 'NatWest', 'code': 'NWBK'},
    {'name': 'Santander UK', 'code': 'SANT'},
    {'name': 'Nationwide Building Society', 'code': 'NAIA'},

    // Other Banks
    {'name': 'Royal Bank of Scotland (RBS)', 'code': 'RBOS'},
    {'name': 'Halifax', 'code': 'HLFX'},
    {'name': 'Bank of Scotland', 'code': 'BOFS'},
    {'name': 'TSB Bank', 'code': 'TSBS'},
    {'name': 'Metro Bank', 'code': 'MYNT'},
    {'name': 'First Direct', 'code': 'MIDL'},
    {'name': 'Monzo', 'code': 'MONZ'},
    {'name': 'Starling Bank', 'code': 'SRLG'},
    {'name': 'Revolut', 'code': 'REVO'},
    {'name': 'Virgin Money', 'code': 'CLYD'},
    {'name': 'Co-operative Bank', 'code': 'CPBK'},
    {'name': 'Tide', 'code': 'CLRB'},
    {'name': 'Wise (TransferWise)', 'code': 'TRWI'},
    {'name': 'Atom Bank', 'code': 'ATOM'},
    {'name': 'OakNorth Bank', 'code': 'OAKN'},
    {'name': 'Tesco Bank', 'code': 'TESC'},
    {'name': 'Sainsbury\'s Bank', 'code': 'SAIN'},
    {'name': 'M&S Bank', 'code': 'MAND'},
  ];

  // ============================================================
  // US BANKS
  // ============================================================
  static const List<Map<String, String>> usBanks = [
    // Popular Banks
    {'name': 'Chase (JPMorgan Chase)', 'code': 'CHASUS33'},
    {'name': 'Bank of America', 'code': 'BOFAUS3N'},
    {'name': 'Wells Fargo', 'code': 'WFBIUS6S'},
    {'name': 'Citibank', 'code': 'CITIUS33'},
    {'name': 'US Bank', 'code': 'USBKUS44'},
    {'name': 'Capital One', 'code': 'NFBKUS33'},

    // Other Banks
    {'name': 'PNC Bank', 'code': 'PNCCUS33'},
    {'name': 'TD Bank', 'code': 'TDOMUS33'},
    {'name': 'Truist Bank', 'code': 'BRBTUS33'},
    {'name': 'Goldman Sachs (Marcus)', 'code': 'GSAMUS33'},
    {'name': 'Charles Schwab', 'code': 'SCHBUS33'},
    {'name': 'American Express', 'code': 'ABORUSN1'},
    {'name': 'Ally Bank', 'code': 'ALFIUS31'},
    {'name': 'Discover Bank', 'code': 'DISBUS33'},
    {'name': 'SoFi', 'code': 'SOFI'},
    {'name': 'Chime', 'code': 'CHIME'},
    {'name': 'Varo Bank', 'code': 'VAROUS31'},
    {'name': 'Current', 'code': 'CURRENT'},
  ];

  // ============================================================
  // GHANA BANKS
  // ============================================================
  static const List<Map<String, String>> ghanaBanks = [
    // Popular Banks
    {'name': 'Ghana Commercial Bank (GCB)', 'code': 'GCB'},
    {'name': 'Ecobank Ghana', 'code': 'ECO'},
    {'name': 'Stanbic Bank Ghana', 'code': 'SBG'},
    {'name': 'Standard Chartered Ghana', 'code': 'SCB'},
    {'name': 'Fidelity Bank Ghana', 'code': 'FBG'},
    {'name': 'Zenith Bank Ghana', 'code': 'ZBG'},

    // Other Banks
    {'name': 'Absa Bank Ghana', 'code': 'ABG'},
    {'name': 'Access Bank Ghana', 'code': 'ABN'},
    {'name': 'Agricultural Development Bank', 'code': 'ADB'},
    {'name': 'Bank of Africa Ghana', 'code': 'BOA'},
    {'name': 'CalBank', 'code': 'CAL'},
    {'name': 'Consolidated Bank Ghana', 'code': 'CBG'},
    {'name': 'First Atlantic Bank', 'code': 'FAB'},
    {'name': 'First National Bank Ghana', 'code': 'FNB'},
    {'name': 'GTBank Ghana', 'code': 'GTB'},
    {'name': 'National Investment Bank', 'code': 'NIB'},
    {'name': 'Prudential Bank', 'code': 'PBL'},
    {'name': 'Republic Bank Ghana', 'code': 'RBG'},
    {'name': 'Societe Generale Ghana', 'code': 'SGB'},
    {'name': 'UBA Ghana', 'code': 'UBA'},
    {'name': 'Universal Merchant Bank', 'code': 'UMB'},
    {'name': 'MTN Mobile Money', 'code': 'MTN'},
    {'name': 'Vodafone Cash', 'code': 'VOD'},
    {'name': 'AirtelTigo Money', 'code': 'ATM'},
  ];

  // ============================================================
  // KENYA BANKS
  // ============================================================
  static const List<Map<String, String>> kenyaBanks = [
    // Popular Banks
    {'name': 'Equity Bank Kenya', 'code': 'EQBL'},
    {'name': 'KCB Bank (Kenya Commercial Bank)', 'code': 'KCBL'},
    {'name': 'Co-operative Bank of Kenya', 'code': 'COOP'},
    {'name': 'ABSA Bank Kenya', 'code': 'ABSA'},
    {'name': 'Standard Chartered Kenya', 'code': 'SCBL'},
    {'name': 'NCBA Bank Kenya', 'code': 'NCBA'},

    // Other Banks
    {'name': 'I&M Bank Kenya', 'code': 'IMBL'},
    {'name': 'DTB Bank (Diamond Trust)', 'code': 'DTBK'},
    {'name': 'Stanbic Bank Kenya', 'code': 'SBIC'},
    {'name': 'Family Bank', 'code': 'FAMI'},
    {'name': 'Bank of Africa Kenya', 'code': 'BOAK'},
    {'name': 'Prime Bank Kenya', 'code': 'PRIM'},
    {'name': 'Victoria Commercial Bank', 'code': 'VICB'},
    {'name': 'Sidian Bank', 'code': 'SIDI'},
    {'name': 'GT Bank Kenya', 'code': 'GTBK'},
    {'name': 'M-Pesa (Safaricom)', 'code': 'MPESA'},
    {'name': 'Airtel Money Kenya', 'code': 'AIRT'},
  ];

  // ============================================================
  // SOUTH AFRICA BANKS
  // ============================================================
  static const List<Map<String, String>> southAfricaBanks = [
    // Popular Banks (Big 5)
    {'name': 'Standard Bank', 'code': 'SBSA'},
    {'name': 'ABSA Bank', 'code': 'ABSZ'},
    {'name': 'FirstRand Bank (FNB)', 'code': 'FIRN'},
    {'name': 'Nedbank', 'code': 'NEDB'},
    {'name': 'Capitec Bank', 'code': 'CABI'},
    {'name': 'Investec', 'code': 'IVBZ'},

    // Other Banks
    {'name': 'African Bank', 'code': 'AFRB'},
    {'name': 'Bidvest Bank', 'code': 'BIDV'},
    {'name': 'Discovery Bank', 'code': 'DISC'},
    {'name': 'Grindrod Bank', 'code': 'GRIN'},
    {'name': 'Mercantile Bank', 'code': 'MERC'},
    {'name': 'Sasfin Bank', 'code': 'SASF'},
    {'name': 'TymeBank', 'code': 'TYME'},
    {'name': 'Bank Zero', 'code': 'BKZR'},
    {'name': 'Ubank', 'code': 'UBNK'},
  ];
}
