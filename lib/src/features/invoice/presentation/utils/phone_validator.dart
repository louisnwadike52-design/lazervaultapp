/// Phone validation rules per country for invoice phone fields.
class PhoneValidationRule {
  final int minLength;
  final int maxLength;
  final RegExp? pattern;
  final String hintText;

  /// E.164 country calling code, digits only ("44" for GB).
  ///
  /// Needed because the invoice phone fields render numbers in INTERNATIONAL
  /// form ("+44 7911123456") while every rule below describes the NATIONAL
  /// form ("07911123456"). Without the dial code there is no way to convert
  /// between them, and validation rejected the app's own display format.
  final String dialCode;

  /// National trunk prefix that the dial code replaces — "0" for GB/NG/DE/FR/
  /// ZA/AU, empty for NANP (US/CA) and JP-style numbering where the national
  /// form carries no leading zero.
  final String trunkPrefix;

  const PhoneValidationRule({
    required this.minLength,
    required this.maxLength,
    this.pattern,
    required this.hintText,
    required this.dialCode,
    this.trunkPrefix = '',
  });
}

class PhoneValidator {
  static final Map<String, PhoneValidationRule> _rules = {
    'NG': PhoneValidationRule(
      minLength: 11,
      maxLength: 11,
      pattern: RegExp(r'^0[789]\d{9}$'),
      hintText: 'e.g., 08012345678',
      dialCode: '234',
      trunkPrefix: '0',
    ),
    'US': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^\d{10}$'),
      hintText: 'e.g., 2025551234',
      dialCode: '1',
    ),
    'CA': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^\d{10}$'),
      hintText: 'e.g., 6135551234',
      dialCode: '1',
    ),
    'GB': PhoneValidationRule(
      minLength: 10,
      maxLength: 11,
      pattern: RegExp(r'^0\d{9,10}$'),
      hintText: 'e.g., 07911123456',
      dialCode: '44',
      trunkPrefix: '0',
    ),
    'IN': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^[6-9]\d{9}$'),
      hintText: 'e.g., 9876543210',
      dialCode: '91',
    ),
    'DE': PhoneValidationRule(
      minLength: 10,
      maxLength: 12,
      pattern: RegExp(r'^0\d{9,11}$'),
      hintText: 'e.g., 015112345678',
      dialCode: '49',
      trunkPrefix: '0',
    ),
    'FR': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^0\d{9}$'),
      hintText: 'e.g., 0612345678',
      dialCode: '33',
      trunkPrefix: '0',
    ),
    'ZA': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^0\d{9}$'),
      hintText: 'e.g., 0821234567',
      dialCode: '27',
      trunkPrefix: '0',
    ),
    'AU': PhoneValidationRule(
      minLength: 9,
      maxLength: 10,
      pattern: RegExp(r'^0?\d{9}$'),
      hintText: 'e.g., 0412345678',
      dialCode: '61',
      trunkPrefix: '0',
    ),
    'JP': PhoneValidationRule(
      minLength: 10,
      maxLength: 11,
      pattern: RegExp(r'^0\d{9,10}$'),
      hintText: 'e.g., 09012345678',
      dialCode: '81',
      trunkPrefix: '0',
    ),
  };

  /// Get the validation rule for a country code. Returns null if unknown.
  static PhoneValidationRule? getRule(String countryCode) {
    return _rules[countryCode.toUpperCase()];
  }

  /// Validate a phone number against the country's rules.
  /// Returns null if valid, or an error message if invalid.
  static String? validate(String phone, String countryCode) {
    final rule = _rules[countryCode.toUpperCase()];
    if (rule == null) return null; // No rule = no validation

    final digits = toNationalDigits(phone, rule);

    if (digits.length < rule.minLength || digits.length > rule.maxLength) {
      if (rule.minLength == rule.maxLength) {
        return 'Phone number must be ${rule.minLength} digits';
      }
      return 'Phone number must be ${rule.minLength}-${rule.maxLength} digits';
    }

    if (rule.pattern != null && !rule.pattern!.hasMatch(digits)) {
      return 'Invalid phone format. ${rule.hintText}';
    }

    return null;
  }

  /// Normalises a phone number to the NATIONAL form the rules describe.
  ///
  /// The invoice fields display international format ("+44 7911123456") while
  /// every rule describes national format ("07911123456"). This previously
  /// stripped only spaces, dashes and parens — leaving the "+" and the country
  /// code in the string, so a GB number arrived as 15 characters and was
  /// rejected against a 10-11 digit rule. EVERY number entered in the app's
  /// own display format failed, for all ten countries.
  ///
  /// Conversion is deliberately conservative: the dial code is only stripped
  /// when the number is unambiguously international (a leading "+", or a
  /// leading dial code on a string too long to be national). A number already
  /// in national form is returned untouched, so nothing that used to pass
  /// starts failing.
  static String toNationalDigits(String phone, PhoneValidationRule rule) {
    var s = phone.replaceAll(RegExp(r'[\s\-().]'), '');
    if (s.isEmpty) return s;

    final hadPlus = s.startsWith('+');
    if (hadPlus) s = s.substring(1);
    // "0044…" is the other common international spelling.
    if (!hadPlus && s.startsWith('00')) s = s.substring(2);

    if (s.startsWith(rule.dialCode)) {
      final rest = s.substring(rule.dialCode.length);
      // Only treat it as a country code if what remains could plausibly be a
      // national number. Guards against stripping "1" from a US number that
      // legitimately starts with it, or "44" from a local string.
      final couldBeNational =
          rest.length >= rule.minLength - rule.trunkPrefix.length &&
          rest.length <= rule.maxLength;
      if (hadPlus || couldBeNational) {
        s = rule.trunkPrefix + rest;
      }
    }
    return s;
  }

  /// Get the max digit length for input formatting.
  static int getMaxLength(String countryCode) {
    final rule = _rules[countryCode.toUpperCase()];
    return rule?.maxLength ?? 15;
  }

  /// Get hint text for the phone field.
  static String getHintText(String countryCode) {
    final rule = _rules[countryCode.toUpperCase()];
    return rule?.hintText ?? 'Enter phone number';
  }

  /// Lenient, COUNTRY-AGNOSTIC validation for an optional invoice phone.
  ///
  /// An invoice recipient/payer can be in ANY country, so validating against
  /// the invoice's own country (as [validate] does) is wrong — it rejected a
  /// perfectly good foreign number with "Phone number must be 10 digits". This
  /// only rejects strings that cannot be a real phone number at all. Country
  /// code is optional here; [toE164] supplies a default when it's absent.
  ///
  /// Accepts, all valid:
  ///   +44 7911 123456 · 07911123456 · 7911123456 · +2348012345678 ·
  ///   08012345678 · 8012345678   (with or without a leading trunk 0)
  static String? validateInternational(String phone) {
    final trimmed = phone.trim();
    if (trimmed.isEmpty) return null; // optional field

    final international =
        trimmed.startsWith('+') || trimmed.startsWith('00');
    final digits = trimmed.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return 'Enter a valid phone number';

    // E.164 caps a full number at 15 digits. A national number is at least a
    // few digits; require a country code + national body when '+' is present.
    final min = international ? 8 : 5;
    if (digits.length < min) return 'Phone number is too short';
    if (digits.length > 15) return 'Phone number is too long';
    return null;
  }

  /// Normalise any entry to E.164 (`+<cc><national>`) for storage/sending.
  ///
  /// - Already international ("+44…", "0044…") → kept as-is.
  /// - National ("08012345678" or "8012345678") → the [defaultDialCode]
  ///   country code is attached, dropping a single national trunk 0 so the
  ///   number is correct whether or not the user typed the leading zero.
  ///
  /// [defaultDialCode] is digits only (e.g. "234"). Callers pass the invoice
  /// country's dial code when known, falling back to Nigeria ("234").
  static String toE164(String phone, {String defaultDialCode = '234'}) {
    var s = phone.trim().replaceAll(RegExp(r'[\s\-()]'), '');
    if (s.isEmpty) return '';
    if (s.startsWith('+')) return s;
    if (s.startsWith('00')) return '+${s.substring(2)}';
    final national = s.startsWith('0') ? s.substring(1) : s;
    final cc = defaultDialCode.replaceAll(RegExp(r'[^0-9]'), '');
    return '+${cc.isEmpty ? '234' : cc}$national';
  }

  /// The dial code (digits only) to default to for a given invoice country,
  /// falling back to Nigeria ("234") when the country is unknown.
  static String defaultDialCodeFor(String countryCode) {
    final rule = _rules[countryCode.toUpperCase()];
    final dc = rule?.dialCode ?? '';
    return dc.isEmpty ? '234' : dc;
  }
}
