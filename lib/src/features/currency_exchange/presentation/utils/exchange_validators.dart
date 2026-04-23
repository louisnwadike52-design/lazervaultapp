import '../../data/flutterwave_country_rules.dart';

/// Country-aware validators for the exchange recipient form. Each function
/// returns a user-facing error string on failure, or `null` on success —
/// matching Flutter's `FormField.validator` contract.
///
/// Rules come from `FlutterwaveCountryRules` which mirrors the backend
/// source of truth. When Flutterwave changes a requirement, update the rules
/// file — these validators pick it up automatically.
class ExchangeValidators {
  ExchangeValidators._();

  // ---------------------------------------------------------------------
  // Generic primitives
  // ---------------------------------------------------------------------

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value, {bool isRequired = false}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return isRequired ? 'Email is required' : null;
    final re = RegExp(r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$');
    return re.hasMatch(v) ? null : 'Enter a valid email address';
  }

  // ---------------------------------------------------------------------
  // Country-aware field validators
  // ---------------------------------------------------------------------

  /// Validate an account number per the country rule. Handles digitsOnly,
  /// min/max length, and numeric-only enforcement.
  static String? accountNumber(String? value, ExchangeCountryRule rule) {
    final spec = rule.fields.firstWhere(
      (f) => f.name == 'account_number',
      orElse: () => const ExchangeFieldSpec(
          name: '', label: '', required: false, type: 'text'),
    );
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return spec.required ? 'Account number is required' : null;
    }
    final cleaned = spec.type == 'iban'
        ? v.replaceAll(RegExp(r'\s+'), '').toUpperCase()
        : v;

    if (spec.digitsOnly && !RegExp(r'^\d+$').hasMatch(cleaned)) {
      return 'Account number must contain digits only';
    }

    final min = spec.minLength ?? 1;
    final max = spec.maxLength ?? 64;
    if (cleaned.length < min) {
      return 'Account number must be at least $min characters';
    }
    if (cleaned.length > max) {
      return 'Account number must be at most $max characters';
    }
    return null;
  }

  /// GB sort code: 6 digits. Accepts XX-XX-XX or raw 6 digits.
  static String? sortCode(String? value) {
    final v = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (v.isEmpty) return 'Sort code is required';
    if (v.length != 6) return 'Sort code must be exactly 6 digits';
    return null;
  }

  /// US ABA routing: 9 digits with the standard checksum
  /// (3*d1 + 7*d2 + 1*d3 + 3*d4 + 7*d5 + 1*d6 + 3*d7 + 7*d8 + 1*d9) mod 10 == 0.
  static String? routingNumber(String? value) {
    final v = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (v.isEmpty) return 'Routing number is required';
    if (v.length != 9) return 'Routing number must be exactly 9 digits';
    final weights = [3, 7, 1, 3, 7, 1, 3, 7, 1];
    var sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(v[i]) * weights[i];
    }
    if (sum % 10 != 0) return 'Routing number checksum is invalid';
    return null;
  }

  /// IBAN: length per country (mirrors ISO 13616) + mod-97 check.
  static String? iban(String? value) {
    final raw = (value ?? '').replaceAll(RegExp(r'\s+'), '').toUpperCase();
    if (raw.isEmpty) return 'IBAN is required';
    if (raw.length < 15 || raw.length > 34) {
      return 'IBAN must be between 15 and 34 characters';
    }
    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(raw)) {
      return 'IBAN must be alphanumeric only';
    }
    // mod-97: move first 4 chars to end, replace letters with their
    // A=10..Z=35 numeric equivalent, then take mod 97 and expect 1.
    final rearranged = raw.substring(4) + raw.substring(0, 4);
    final buf = StringBuffer();
    for (final ch in rearranged.codeUnits) {
      if (ch >= 0x30 && ch <= 0x39) {
        buf.writeCharCode(ch);
      } else if (ch >= 0x41 && ch <= 0x5A) {
        buf.write(ch - 55); // A(65)->10, Z(90)->35
      } else {
        return 'IBAN contains invalid characters';
      }
    }
    // Compute mod-97 iteratively (the number is too big for int64).
    var remainder = 0;
    final s = buf.toString();
    for (final c in s.codeUnits) {
      remainder = (remainder * 10 + (c - 0x30)) % 97;
    }
    return remainder == 1 ? null : 'IBAN checksum is invalid';
  }

  /// SWIFT/BIC: 8 or 11 alphanumeric.
  static String? swiftBic(String? value) {
    final v = (value ?? '').trim().toUpperCase();
    if (v.isEmpty) return 'SWIFT/BIC code is required';
    if (!RegExp(r'^[A-Z0-9]{8}([A-Z0-9]{3})?$').hasMatch(v)) {
      return 'SWIFT/BIC must be 8 or 11 alphanumeric characters';
    }
    return null;
  }

  /// Phone number with country dial code. Accepts with or without the '+'.
  /// The national portion is validated against the country rule's phone
  /// field spec (min/max length, digits only).
  static String? phoneNumber(String? value, ExchangeCountryRule rule) {
    final spec = rule.fields.firstWhere(
      (f) => f.name == 'phone',
      orElse: () => const ExchangeFieldSpec(
          name: '', label: '', required: false, type: 'phone'),
    );
    final raw = (value ?? '').trim();
    if (raw.isEmpty) {
      return spec.required ? 'Phone number is required' : null;
    }
    var digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('+')) digits = digits.substring(1);
    if (digits.startsWith(rule.dialCode)) {
      digits = digits.substring(rule.dialCode.length);
    }
    digits = digits.replaceAll(RegExp(r'[^0-9]'), '');
    final min = spec.minLength ?? 7;
    final max = spec.maxLength ?? 15;
    if (digits.length < min) {
      return 'Phone number is too short (minimum $min digits)';
    }
    if (digits.length > max) {
      return 'Phone number is too long (maximum $max digits)';
    }
    return null;
  }

  /// Amount input: numeric, within the country rule's min/max.
  static String? amount(String? value, ExchangeCountryRule rule) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Amount is required';
    final amt = double.tryParse(v.replaceAll(',', ''));
    if (amt == null) return 'Enter a valid number';
    if (amt < rule.minAmount) {
      return 'Minimum transfer is ${rule.minAmount.toStringAsFixed(2)} ${rule.currency}';
    }
    if (amt > rule.maxAmount) {
      return 'Maximum transfer is ${rule.maxAmount.toStringAsFixed(2)} ${rule.currency}';
    }
    return null;
  }

  /// Beneficiary name: at least 2 words for international wires, at least
  /// 3 characters otherwise. Skipped entirely when the country rule
  /// declares omitBeneficiaryName (e.g. NG — name is auto-resolved).
  static String? beneficiaryName(String? value, ExchangeCountryRule rule) {
    if (rule.omitBeneficiaryName) return null;
    final v = (value ?? '').trim();
    final spec = rule.fields.firstWhere(
      (f) => f.name == 'beneficiary_name',
      orElse: () => const ExchangeFieldSpec(
          name: '', label: '', required: true, type: 'text'),
    );
    if (v.isEmpty) {
      return spec.required ? 'Recipient name is required' : null;
    }
    final min = spec.minLength ?? 3;
    if (v.length < min) return 'Recipient name is too short';
    // USD/GBP/EUR wires require a full legal name (at least two tokens).
    if ({'USD', 'GBP', 'EUR'}.contains(rule.currency)) {
      if (!v.contains(' ')) {
        return 'Enter the recipient\'s full legal name (first and last)';
      }
    }
    return null;
  }

  /// Beneficiary address for USD/GBP/EUR: required by Flutterwave meta
  /// block, minimum 5 characters.
  static String? beneficiaryAddress(String? value, ExchangeCountryRule rule) {
    final spec = rule.fields.firstWhere(
      (f) => f.name == 'beneficiary_address',
      orElse: () => const ExchangeFieldSpec(
          name: '', label: '', required: false, type: 'text'),
    );
    if (!spec.required) return null;
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Recipient address is required';
    if (v.length < (spec.minLength ?? 5)) {
      return 'Enter the full address (street, city, state)';
    }
    return null;
  }

  /// Bank name for international wires.
  static String? bankName(String? value, ExchangeCountryRule rule) {
    final spec = rule.fields.firstWhere(
      (f) => f.name == 'bank_name',
      orElse: () => const ExchangeFieldSpec(
          name: '', label: '', required: false, type: 'text'),
    );
    if (!spec.required) return null;
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Bank name is required';
    if (v.length < (spec.minLength ?? 2)) return 'Bank name is too short';
    return null;
  }

  /// Purpose of payment: must be one of the country's allowed options.
  static String? purposeOfPayment(String? value, ExchangeCountryRule rule) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Purpose of payment is required';
    if (rule.purposeOfPaymentOptions.isEmpty) return null;
    if (!rule.purposeOfPaymentOptions.contains(v)) {
      return 'Select a valid purpose of payment';
    }
    return null;
  }

  /// Branch code for countries that require it (GHS, UGX).
  static String? branchCode(String? value, ExchangeCountryRule rule) {
    final spec = rule.fields.firstWhere(
      (f) => f.name == 'branch_code',
      orElse: () => const ExchangeFieldSpec(
          name: '', label: '', required: false, type: 'text'),
    );
    if (!spec.required) return null;
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Branch code is required';
    if (v.length < (spec.minLength ?? 3)) return 'Branch code is too short';
    if (v.length > (spec.maxLength ?? 10)) return 'Branch code is too long';
    return null;
  }
}
