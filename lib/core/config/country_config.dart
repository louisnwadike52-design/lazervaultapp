part 'country_config_widgets.dart';


/// Country configurations for all supported countries
class CountryConfigs {
  /// Nigeria Configuration
  static const nigeria = CountryConfig(
    country: CountryCode.nigeria,
    supportedIdTypes: [
      IdentityDocumentType.bvn,
      IdentityDocumentType.nin,
      IdentityDocumentType.intlPassport,
      IdentityDocumentType.driverLicense,
    ],
    defaultIdType: IdentityDocumentType.bvn,
    tierIdTypes: {
      KycLevel.standard: [IdentityDocumentType.bvn],  // CBN: BVN mandatory for Tier 2
      KycLevel.advanced: [IdentityDocumentType.nin],   // CBN: NIN mandatory for Tier 3
    },
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'bvn',
        documentType: IdentityDocumentType.bvn,
        isRequired: true,
        description: '11-digit Bank Verification Number linked to your bank accounts',
        needsOcrExtraction: false,
        needsFrontPhoto: false,
        needsBackPhoto: false,
        needsSelfie: false,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    // Display baseline ONLY — the authoritative per-tier limits live in the
    // backend (auth-service, sourced from shared/kyctiers). Kept in lock-step
    // with the CBN canonical model so the UI never contradicts enforcement:
    // Tier 1 ₦50,000/day, Tier 2 ₦200,000/day, Tier 3 UNLIMITED (0 = no cap).
    dailyLimits: {
      KycLevel.basic: 50000, // ₦50,000
      KycLevel.standard: 200000, // ₦200,000 (CBN Tier-2 daily)
      KycLevel.advanced: 0, // Unlimited
    },
    regulatoryNotes: [
      'BVN verification required for Tier 2 (CBN mandate)',
      'NIN + address proof required for Tier 3 (Enhanced KYC)',
      'Central Bank of Nigeria (CBN) regulated',
    ],
    isActive: true,
    isBeta: false,
  );

  /// UK Configuration
  static const uk = CountryConfig(
    country: CountryCode.uk,
    supportedIdTypes: [
      IdentityDocumentType.ukPassport,
      IdentityDocumentType.ukDriverLicense,
      IdentityDocumentType.niNumber,
    ],
    defaultIdType: IdentityDocumentType.ukPassport,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'uk_passport',
        documentType: IdentityDocumentType.ukPassport,
        isRequired: true,
        description: '9-digit UK passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
      DocumentRequirement(
        documentTypeId: 'uk_driver_license',
        documentType: IdentityDocumentType.ukDriverLicense,
        isRequired: false,
        description: 'UK driving licence number from your photocard licence',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: true,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 500, // £500
      KycLevel.standard: 10000, // £10,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'PSD2 compliant, FSCS protection via ClearBank',
      'Financial Conduct Authority (FCA) regulated',
    ],
    isActive: true,
    isBeta: true,
  );

  /// USA Configuration
  static const usa = CountryConfig(
    country: CountryCode.usa,
    supportedIdTypes: [
      IdentityDocumentType.ssn,
      IdentityDocumentType.ssnLast4,
      IdentityDocumentType.usPassport,
      IdentityDocumentType.usStateId,
    ],
    defaultIdType: IdentityDocumentType.ssnLast4,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'ssn',
        documentType: IdentityDocumentType.ssn,
        isRequired: true,
        description: '9-digit Social Security Number (we only need last 4 for verification)',
        needsOcrExtraction: false, // SSN is manual entry only
        needsFrontPhoto: false,
        needsBackPhoto: false,
        needsSelfie: false,
      ),
      DocumentRequirement(
        documentTypeId: 'us_passport',
        documentType: IdentityDocumentType.usPassport,
        isRequired: false,
        description: '9-digit US passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
      DocumentRequirement(
        documentTypeId: 'us_state_id',
        documentType: IdentityDocumentType.usStateId,
        isRequired: false,
        description: 'State-issued identification card',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: true,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 500, // $500
      KycLevel.standard: 10000, // $10,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'FDIC insured via Stripe partner banks',
      'FinCEN + State Money Transmitter Licenses',
    ],
    isActive: true,
    isBeta: true,
  );

  /// Ghana Configuration
  static const ghana = CountryConfig(
    country: CountryCode.ghana,
    supportedIdTypes: [
      IdentityDocumentType.ghanaCard,
      IdentityDocumentType.ghanaVoterCard,
      IdentityDocumentType.ghanaSsnit,
      IdentityDocumentType.ghanaPassport,
    ],
    defaultIdType: IdentityDocumentType.ghanaCard,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'ghana_card',
        documentType: IdentityDocumentType.ghanaCard,
        isRequired: true,
        description: 'Ghana Card national ID number (GHA-XXXXXXXXX-X format)',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: true,
        needsSelfie: true,
      ),
      DocumentRequirement(
        documentTypeId: 'ghana_passport',
        documentType: IdentityDocumentType.ghanaPassport,
        isRequired: false,
        description: 'Ghana passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 500, // GHS 500
      KycLevel.standard: 10000, // GHS 10,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'Bank of Ghana regulated',
      'EMI license required',
    ],
    isActive: true,
    isBeta: true,
  );

  /// Kenya Configuration
  static const kenya = CountryConfig(
    country: CountryCode.kenya,
    supportedIdTypes: [
      IdentityDocumentType.kenyaNationalId,
      IdentityDocumentType.kenyaKraPin,
      IdentityDocumentType.kenyaPassport,
      IdentityDocumentType.kenyaAlienId,
    ],
    defaultIdType: IdentityDocumentType.kenyaNationalId,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'kenya_national_id',
        documentType: IdentityDocumentType.kenyaNationalId,
        isRequired: true,
        description: 'Kenya National ID number (7-8 digits)',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: true,
        needsSelfie: true,
      ),
      DocumentRequirement(
        documentTypeId: 'kenya_passport',
        documentType: IdentityDocumentType.kenyaPassport,
        isRequired: false,
        description: 'Kenya passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 100, // KES 100
      KycLevel.standard: 300000, // KES 300,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'Central Bank of Kenya (CBK) regulated',
      'E-Money Issuer License required, M-Pesa integration critical',
    ],
    isActive: true,
    isBeta: true,
  );

  /// South Africa Configuration
  static const southAfrica = CountryConfig(
    country: CountryCode.southAfrica,
    supportedIdTypes: [
      IdentityDocumentType.saId,
      IdentityDocumentType.saPassport,
    ],
    defaultIdType: IdentityDocumentType.saId,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'sa_id',
        documentType: IdentityDocumentType.saId,
        isRequired: true,
        description: '13-digit South African ID number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: true,
        needsSelfie: true,
      ),
      DocumentRequirement(
        documentTypeId: 'sa_passport',
        documentType: IdentityDocumentType.saPassport,
        isRequired: false,
        description: 'South African passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 1000, // R1,000
      KycLevel.standard: 50000, // R50,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'South African Reserve Bank (SARB) / FSCA regulated',
      'FSCA License via Stitch partnership',
    ],
    isActive: true,
    isBeta: true,
  );

  /// Philippines Configuration (Klasha)
  static const philippines = CountryConfig(
    country: CountryCode.philippines,
    supportedIdTypes: [
      IdentityDocumentType.intlPassport,
    ],
    defaultIdType: IdentityDocumentType.intlPassport,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'intl_passport',
        documentType: IdentityDocumentType.intlPassport,
        isRequired: true,
        description: 'Passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 25000, // ₱25,000
      KycLevel.standard: 500000, // ₱500,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'International-transfer destination only (via Klasha)',
    ],
    // NOT a signup country: Klasha virtual accounts cover only NGN+GHS, so a PHP
    // wallet can't be created. PH is exchange-INTERNATIONAL-only (send to a PH
    // bank). isActive:false keeps it out of the signup country dropdown.
    isActive: false,
    isBeta: true,
  );

  /// Canada Configuration (Klasha)
  static const canada = CountryConfig(
    country: CountryCode.canada,
    supportedIdTypes: [
      IdentityDocumentType.intlPassport,
    ],
    defaultIdType: IdentityDocumentType.intlPassport,
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'intl_passport',
        documentType: IdentityDocumentType.intlPassport,
        isRequired: true,
        description: 'Passport number',
        needsOcrExtraction: true,
        needsFrontPhoto: true,
        needsBackPhoto: false,
        needsSelfie: true,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 500, // C$500
      KycLevel.standard: 10000, // C$10,000
      KycLevel.advanced: 0, // Unlimited (backend Tier 3 = unlimited)
    },
    regulatoryNotes: [
      'International-transfer destination only (via Klasha)',
    ],
    // NOT a signup country (see PH): Klasha VAs cover only NGN+GHS. CA is
    // exchange-INTERNATIONAL-only. isActive:false keeps it out of the dropdown.
    isActive: false,
    isBeta: true,
  );

  /// Get all country configurations
  static const List<CountryConfig> all = [
    nigeria,
    uk,
    usa,
    ghana,
    kenya,
    southAfrica,
    philippines,
    canada,
  ];

  /// Get all active countries available for signup
  static List<CountryConfig> get activeCountries =>
      all.where((config) => config.isActive).toList();

  /// Get country config by country code
  static CountryConfig? getByCode(String countryCode) {
    try {
      return all.firstWhere((config) => config.code == countryCode);
    } catch (_) {
      return null;
    }
  }

  /// Get country config by CountryCode enum
  static CountryConfig? getByCountryCode(CountryCode countryCode) {
    try {
      return all.firstWhere((config) => config.country == countryCode);
    } catch (_) {
      return null;
    }
  }

  /// Get all supported country codes (for validation)
  static List<String> get supportedCountryCodes =>
      all.map((config) => config.code).toList();

  /// Check if a country code is supported
  static bool isCountrySupported(String countryCode) {
    return supportedCountryCodes.contains(countryCode);
  }

  /// Get dialing code for a country
  static String? getDialingCode(String countryCode) {
    final config = getByCode(countryCode);
    return config?.dialingCode;
  }

  /// Get currency symbol for a country
  static String? getCurrencySymbol(String countryCode) {
    final config = getByCode(countryCode);
    return config?.currencySymbol;
  }

  // ==================== Locale Utilities ====================

  /// Extract country code from a locale string (e.g., "en-NG" -> "NG")
  static String? getCountryCodeFromLocale(String? locale) {
    if (locale == null || locale.isEmpty) return null;
    final parts = locale.split('-');
    if (parts.length >= 2) {
      return parts.last.toUpperCase();
    }
    // If no country code in locale, check if it's a direct country code
    final upperLocale = locale.toUpperCase();
    if (supportedCountryCodes.contains(upperLocale)) {
      return upperLocale;
    }
    return null;
  }

  /// Get the full locale for a country (language + country code)
  /// Defaults to "en" for language prefix
  static String getLocaleForCountry(String countryCode, {String language = 'en'}) {
    final config = getByCode(countryCode);
    if (config == null) return 'en-$countryCode';
    return '$language-${config.code}';
  }

  /// Get CountryConfig from a locale string
  static CountryConfig? fromLocale(String? locale) {
    final countryCode = getCountryCodeFromLocale(locale);
    if (countryCode != null) {
      return getByCode(countryCode);
    }
    return null;
  }

  /// Get default locale (Nigeria/English)
  static const String defaultLocale = 'en-NG';

  /// Get list of all supported locales
  static List<String> get supportedLocales {
    return all
        .map((config) => 'en-${config.code}')
        .toList();
  }

  /// Check if a locale is supported
  static bool isLocaleSupported(String? locale) {
    return fromLocale(locale) != null;
  }

  /// Format a phone number with country dialing code from locale
  static String? formatPhoneFromLocale(String? locale, String phoneNumber) {
    final config = fromLocale(locale);
    if (config == null) return null;

    // Remove existing country code if present
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'^\+\d+'), '');

    return '${config.dialingCode}$cleanedNumber';
  }

  /// Get currency code from locale
  static String? getCurrencyFromLocale(String? locale) {
    final config = fromLocale(locale);
    return config?.currency;
  }

  /// Get currency symbol from locale
  static String? getCurrencySymbolFromLocale(String? locale) {
    final config = fromLocale(locale);
    return config?.currencySymbol;
  }
}
