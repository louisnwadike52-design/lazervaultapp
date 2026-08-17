part of 'country_config.dart';

/// Country codes supported by the app
enum CountryCode {
  nigeria('NG', 'Nigeria', '🇳🇬', 'NGN', '₦', '+234'),
  uk('GB', 'United Kingdom', '🇬🇧', 'GBP', '£', '+44'),
  usa('US', 'United States', '🇺🇸', 'USD', r'$', '+1'),
  ghana('GH', 'Ghana', '🇬🇭', 'GHS', 'GH₵', '+233'),
  kenya('KE', 'Kenya', '🇰🇪', 'KES', 'KSh', '+254'),
  southAfrica('ZA', 'South Africa', '🇿🇦', 'ZAR', 'R', '+27'),
  // Klasha-provisioned countries (Flutterwave has no coverage).
  philippines('PH', 'Philippines', '🇵🇭', 'PHP', '₱', '+63'),
  canada('CA', 'Canada', '🇨🇦', 'CAD', r'C$', '+1');

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

  /// National Significant Number length (digits AFTER the country code and the
  /// optional national trunk "0"). Used to limit phone input and validate length
  /// per country. e.g. NG "+234 803 123 4567" -> NSN "8031234567" = 10 digits.
  int get nationalNumberLength {
    switch (this) {
      case CountryCode.nigeria:
        return 10;
      case CountryCode.uk:
        return 10;
      case CountryCode.usa:
        return 10;
      case CountryCode.ghana:
        return 9;
      case CountryCode.kenya:
        return 9;
      case CountryCode.southAfrica:
        return 9;
      case CountryCode.philippines:
        return 10; // PH mobile NSN, e.g. 9XXXXXXXXX
      case CountryCode.canada:
        return 10; // NANP 10-digit
    }
  }

  /// Country-specific mobile-number pattern over the National Significant
  /// Number (NSN — digits after the dialing code and trunk "0"). Null means we
  /// don't (yet) have a strict prefix rule for the country, so only the length
  /// check applies. Kept conservative to avoid rejecting valid numbers.
  RegExp? get _mobilePattern {
    switch (this) {
      case CountryCode.nigeria:
        // NG mobile prefixes 070/071/080/081/090/091 -> NSN starts [789][01].
        return RegExp(r'^[789][01]\d{8}$');
      default:
        return null;
    }
  }

  /// Validate a National Significant Number. Returns a user-friendly error
  /// message, or null when the number is acceptable. Checks BOTH the length
  /// AND (where known) the mobile prefix, so a right-length but otherwise
  /// invalid number (e.g. "1234567890") is rejected instead of silently
  /// proceeding.
  String? validateNationalNumber(String nsn) {
    final digits = nsn.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length != nationalNumberLength) {
      return 'Enter a valid $name phone number '
          '($nationalNumberLength digits after $dialingCode).';
    }
    final pattern = _mobilePattern;
    if (pattern != null && !pattern.hasMatch(digits)) {
      return 'That doesn\'t look like a valid $name mobile number. '
          'Please check it and try again.';
    }
    return null;
  }

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
  /// Tier-specific mandatory ID types (CBN compliance)
  /// Maps KYC level to the ONLY accepted ID types for that tier
  final Map<KycLevel, List<IdentityDocumentType>> tierIdTypes;

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
    this.tierIdTypes = const {},
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

  /// National Significant Number length for this country (see CountryCode).
  int get nationalNumberLength => country.nationalNumberLength;

  /// Validate a National Significant Number for this country (length + mobile
  /// prefix where known). Returns a user-friendly error, or null when valid.
  String? validateNationalNumber(String nsn) =>
      country.validateNationalNumber(nsn);

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
