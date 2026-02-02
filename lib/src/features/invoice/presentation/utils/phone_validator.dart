/// Phone validation rules per country for invoice phone fields.
class PhoneValidationRule {
  final int minLength;
  final int maxLength;
  final RegExp? pattern;
  final String hintText;

  const PhoneValidationRule({
    required this.minLength,
    required this.maxLength,
    this.pattern,
    required this.hintText,
  });
}

class PhoneValidator {
  static final Map<String, PhoneValidationRule> _rules = {
    'NG': PhoneValidationRule(
      minLength: 11,
      maxLength: 11,
      pattern: RegExp(r'^0[789]\d{9}$'),
      hintText: 'e.g., 08012345678',
    ),
    'US': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^\d{10}$'),
      hintText: 'e.g., 2025551234',
    ),
    'CA': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^\d{10}$'),
      hintText: 'e.g., 6135551234',
    ),
    'GB': PhoneValidationRule(
      minLength: 10,
      maxLength: 11,
      pattern: RegExp(r'^0\d{9,10}$'),
      hintText: 'e.g., 07911123456',
    ),
    'IN': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^[6-9]\d{9}$'),
      hintText: 'e.g., 9876543210',
    ),
    'DE': PhoneValidationRule(
      minLength: 10,
      maxLength: 12,
      pattern: RegExp(r'^0\d{9,11}$'),
      hintText: 'e.g., 015112345678',
    ),
    'FR': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^0\d{9}$'),
      hintText: 'e.g., 0612345678',
    ),
    'ZA': PhoneValidationRule(
      minLength: 10,
      maxLength: 10,
      pattern: RegExp(r'^0\d{9}$'),
      hintText: 'e.g., 0821234567',
    ),
    'AU': PhoneValidationRule(
      minLength: 9,
      maxLength: 10,
      pattern: RegExp(r'^0?\d{9}$'),
      hintText: 'e.g., 0412345678',
    ),
    'JP': PhoneValidationRule(
      minLength: 10,
      maxLength: 11,
      pattern: RegExp(r'^0\d{9,10}$'),
      hintText: 'e.g., 09012345678',
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

    // Strip spaces and dashes for validation
    final digits = phone.replaceAll(RegExp(r'[\s\-()]'), '');

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
}
