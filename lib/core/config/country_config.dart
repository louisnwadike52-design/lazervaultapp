/// Country codes supported by the app
enum CountryCode {
  nigeria('NG', 'Nigeria', '🇳🇬', 'NGN', '₦', '+234'),
  uk('GB', 'United Kingdom', '🇬🇧', 'GBP', '£', '+44'),
  usa('US', 'United States', '🇺🇸', 'USD', r'$', '+1'),
  ghana('GH', 'Ghana', '🇬🇭', 'GHS', 'GH₵', '+233'),
  kenya('KE', 'Kenya', '🇰🇪', 'KES', 'KSh', '+254'),
  southAfrica('ZA', 'South Africa', '🇿🇦', 'ZAR', 'R', '+27');

  final String code;
  final String name;
  final String flag;
  final String currency;
  final String currencySymbol;
  final String dialingCode;

  const CountryCode(
    this.code,
    this.name,
    this.flag,
    this.currency,
    this.currencySymbol,
    this.dialingCode,
  );

  /// Get CountryCode enum from string code
  static CountryCode? fromCode(String code) {
    try {
      return CountryCode.values.firstWhere((c) => c.code == code);
    } catch (_) {
      return null;
    }
  }
}

/// Identity document types available for KYC
enum IdentityDocumentType {
  // Nigeria
  bvn('BVN', 'Bank Verification Number', 11, 'numeric', '12345678901'),
  nin('NIN', 'National Identification Number', 11, 'numeric', '12345678901'),
  intlPassport('INTL_PASSPORT', 'International Passport', 9, 'alphanumeric', 'A12345678'),
  driverLicense('DRIVER_LICENSE', "Driver's License", 11, 'alphanumeric', 'ABC12345678'),

  // UK
  ukPassport('UK_PASSPORT', 'UK Passport', 9, 'numeric', '123456789'),
  ukDriverLicense('UK_DRIVER_LICENSE', 'UK Driving Licence', 16, 'alphanumeric', 'MORGA657054SM9IJ'),
  niNumber('NI_NUMBER', 'National Insurance Number', 9, 'alphanumeric', 'QQ123456C'),

  // US
  ssn('SSN', 'Social Security Number', 9, 'numeric', '123456789'),
  ssnLast4('SSN_LAST4', 'SSN (Last 4 Digits)', 4, 'numeric', '1234'),
  usPassport('US_PASSPORT', 'US Passport', 9, 'numeric', '123456789'),
  usStateId('US_STATE_ID', 'State ID', 20, 'alphanumeric', 'D12345678'),
  usItin('US_ITIN', 'ITIN', 9, 'alphanumeric', '123456789'),

  // Ghana
  ghanaCard('GHANA_CARD', 'Ghana Card', 15, 'alphanumeric', 'GHA-123456789-1'),
  ghanaVoterCard('GHANA_VOTER_CARD', "Voter's Card", 10, 'numeric', '1234567890'),
  ghanaSsnit('GHANA_SSNIT', 'SSNIT Number', 13, 'alphanumeric', 'A123456789012'),
  ghanaPassport('GHANA_PASSPORT', 'Ghana Passport', 8, 'alphanumeric', 'G1234567'),

  // Kenya
  kenyaNationalId('KENYA_NATIONAL_ID', 'National ID', 8, 'numeric', '12345678'),
  kenyaKraPin('KENYA_KRA_PIN', 'KRA PIN', 11, 'alphanumeric', 'A123456789B'),
  kenyaPassport('KENYA_PASSPORT', 'Kenya Passport', 9, 'alphanumeric', 'AB1234567'),
  kenyaAlienId('KENYA_ALIEN_ID', 'Alien ID', 8, 'numeric', '12345678'),

  // South Africa
  saId('SA_ID', 'South African ID', 13, 'numeric', '9001015009087'),
  saPassport('SA_PASSPORT', 'South African Passport', 9, 'alphanumeric', 'A12345678');

  final String id;
  final String displayName;
  final int? maxLength;
  final String inputType;
  final String exampleFormat;

  const IdentityDocumentType(
    this.id,
    this.displayName,
    this.maxLength,
    this.inputType,
    this.exampleFormat,
  );
}

/// KYC levels
enum KycLevel {
  basic(1, 'Basic', 'Email/Phone verified'),
  standard(2, 'Standard', 'ID verified'),
  advanced(3, 'Advanced', 'ID + Address + Face verified');

  final int level;
  final String name;
  final String description;

  const KycLevel(this.level, this.name, this.description);
}

/// Document requirement for a specific country and KYC level
class DocumentRequirement {
  final String documentTypeId;
  final IdentityDocumentType documentType;
  final bool isRequired;
  final String? description;
  final bool needsFrontPhoto;
  final bool needsBackPhoto;
  final bool needsSelfie;
  final bool needsOcrExtraction;

  const DocumentRequirement({
    required this.documentTypeId,
    required this.documentType,
    required this.isRequired,
    this.description,
    this.needsFrontPhoto = true,
    this.needsBackPhoto = false,
    this.needsSelfie = false,
    this.needsOcrExtraction = true,
  });
}

/// Country-specific configuration including KYC requirements
class CountryConfig {
  final CountryCode country;
  final List<IdentityDocumentType> supportedIdTypes;
  final IdentityDocumentType defaultIdType;
  final List<DocumentRequirement> documentRequirements;
  final KycLevel requiredKycLevel;
  final Map<KycLevel, int> dailyLimits;
  final List<String> regulatoryNotes;
  final bool isActive;
  final bool isBeta;

  const CountryConfig({
    required this.country,
    required this.supportedIdTypes,
    required this.defaultIdType,
    required this.documentRequirements,
    required this.requiredKycLevel,
    required this.dailyLimits,
    required this.regulatoryNotes,
    this.isActive = true,
    this.isBeta = false,
  });

  /// Get document requirements for a specific KYC level
  List<DocumentRequirement> getRequirementsForLevel(KycLevel level) {
    return documentRequirements.where((req) => req.isRequired).toList();
  }

  /// Check if a document type is supported
  bool isDocumentTypeSupported(IdentityDocumentType type) {
    return supportedIdTypes.contains(type);
  }

  /// Get dialing code for phone input
  String get dialingCode => country.dialingCode;

  /// Get country flag emoji
  String get flag => country.flag;

  /// Get country name
  String get name => country.name;

  /// Get country code (ISO 3166-1 alpha-2)
  String get code => country.code;

  /// Get currency code
  String get currency => country.currency;

  /// Get currency symbol
  String get currencySymbol => country.currencySymbol;

  /// Get daily limit for a KYC level
  int getDailyLimit(KycLevel level) {
    return dailyLimits[level] ?? dailyLimits[KycLevel.basic]!;
  }

  /// Check if country is available for signup
  bool get isAvailableForSignup => isActive;
}

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
    documentRequirements: [
      DocumentRequirement(
        documentTypeId: 'bvn',
        documentType: IdentityDocumentType.bvn,
        isRequired: true,
        description: '11-digit Bank Verification Number linked to your bank accounts',
        needsOcrExtraction: false, // BVN is manual entry + API verification
        needsFrontPhoto: false,
        needsBackPhoto: false,
        needsSelfie: false,
      ),
    ],
    requiredKycLevel: KycLevel.standard,
    dailyLimits: {
      KycLevel.basic: 50000, // ₦50,000
      KycLevel.standard: 500000, // ₦500,000
      KycLevel.advanced: 5000000, // ₦5,000,000
    },
    regulatoryNotes: [
      'KYC via BVN/NIN verification required for all accounts',
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
      KycLevel.advanced: 250000, // £250,000
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
      KycLevel.advanced: 250000, // $250,000
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
      KycLevel.advanced: 100000, // GHS 100,000
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
      KycLevel.advanced: 500000, // KES 500,000
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
      KycLevel.advanced: 500000, // R500,000
    },
    regulatoryNotes: [
      'South African Reserve Bank (SARB) / FSCA regulated',
      'FSCA License via Stitch partnership',
    ],
    isActive: true,
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
}

/// Helper class for document-specific operations
class DocumentHelper {
  /// Get the regex pattern for validating a document type
  static String getValidationPattern(IdentityDocumentType type) {
    switch (type) {
      // Nigeria
      case IdentityDocumentType.bvn:
      case IdentityDocumentType.nin:
        return r'^\d{11}$';
      case IdentityDocumentType.intlPassport:
        return r'^[A-Z]\d{8}$';
      case IdentityDocumentType.driverLicense:
        return r'^[A-Z]{3}\d{8}[A-Z]{2}$';

      // UK
      case IdentityDocumentType.ukPassport:
        return r'^\d{9}$';
      case IdentityDocumentType.ukDriverLicense:
        return r'^[A-Z]{5}\d{6}[A-Z]{2}\d{2}$';
      case IdentityDocumentType.niNumber:
        return r'^[A-Z]{2}\d{6}[A-Z]$';

      // US
      case IdentityDocumentType.ssn:
        return r'^\d{9}$';
      case IdentityDocumentType.ssnLast4:
        return r'^\d{4}$';
      case IdentityDocumentType.usPassport:
        return r'^\d{9}$';
      case IdentityDocumentType.usStateId:
      case IdentityDocumentType.usItin:
        return r'^[A-Z0-9]{4,20}$';

      // Ghana
      case IdentityDocumentType.ghanaCard:
        return r'^GHA-\d{9}-\d$';
      case IdentityDocumentType.ghanaVoterCard:
        return r'^\d{10}$';
      case IdentityDocumentType.ghanaSsnit:
        return r'^[A-Z]\d{12}$';
      case IdentityDocumentType.ghanaPassport:
        return r'^G\d{7}$';

      // Kenya
      case IdentityDocumentType.kenyaNationalId:
      case IdentityDocumentType.kenyaAlienId:
        return r'^\d{7,8}$';
      case IdentityDocumentType.kenyaKraPin:
        return r'^[A-Z]\d{9}[A-Z]$';
      case IdentityDocumentType.kenyaPassport:
        return r'^[A-Z]{2}\d{7}$';

      // South Africa
      case IdentityDocumentType.saId:
        return r'^\d{13}$';
      case IdentityDocumentType.saPassport:
        return r'^[A-Z]\d{8}$';
    }
  }

  /// Validate a document value against its type
  static bool validateDocument(IdentityDocumentType type, String value) {
    final pattern = RegExp(getValidationPattern(type));
    return pattern.hasMatch(value);
  }

  /// Get placeholder text for a document type
  static String getPlaceholder(IdentityDocumentType type) {
    return 'Enter your ${type.displayName}';
  }

  /// Get input type for a document type
  static String getInputType(IdentityDocumentType type) {
    return type.inputType;
  }
}
