// Per-currency Flutterwave transfer requirements, mirrored from the Go
// source of truth in:
//   microservices/exchange-service/.../internal/provider/flutterwave_requirements.go
//
// This file is the client-side twin: the Flutter recipient form reads from
// this map to decide which fields to render, which regex to validate, and
// which amounts to clamp. Keep the two files in sync — when Flutterwave
// publishes a change, update both places in the same PR.

class ExchangeFieldSpec {
  final String name;
  final String label;
  final bool required;
  final String type; // 'text' | 'select' | 'phone' | 'email' | 'iban'
  final String? hint;
  final RegExp? pattern;
  final int? minLength;
  final int? maxLength;
  final bool digitsOnly;

  const ExchangeFieldSpec({
    required this.name,
    required this.label,
    required this.required,
    required this.type,
    this.hint,
    this.pattern,
    this.minLength,
    this.maxLength,
    this.digitsOnly = false,
  });
}

class ExchangeCountryRule {
  final String currency;
  final String countryCode; // ISO-2
  final String countryName;
  final String dialCode; // E.164 without the '+' (e.g. "234" for NG)
  final bool requiresBankCode;
  final bool requiresBranchCode;
  final bool supportsPaystackNameResolve; // NG/GH/KE/ZA via /recipients/verify-account
  final bool omitBeneficiaryName; // NG: resolved from bank+account
  // UK/EU/US banks run Confirmation-of-Payee and reject name-pattern
  // mismatches (individual name on a business account or vice versa).
  // When true we render the Individual|Business segmented control and
  // plumb the choice to meta.beneficiary_type. African corridors don't
  // CoP so the control is hidden to reduce form friction.
  final bool supportsBeneficiaryType;
  final double minAmount; // minor-unit equivalent is enforced server-side
  final double maxAmount;
  final List<ExchangeFieldSpec> fields;
  final List<String> purposeOfPaymentOptions;

  const ExchangeCountryRule({
    required this.currency,
    required this.countryCode,
    required this.countryName,
    required this.dialCode,
    required this.requiresBankCode,
    this.requiresBranchCode = false,
    this.supportsPaystackNameResolve = false,
    this.omitBeneficiaryName = false,
    this.supportsBeneficiaryType = false,
    required this.minAmount,
    required this.maxAmount,
    required this.fields,
    this.purposeOfPaymentOptions = const [],
  });
}

/// Canonical purpose-of-payment values accepted by Flutterwave for USD/GBP/EUR
/// international transfers. Short enum — users pick one and it's sent in
/// meta.
const _internationalPurposes = <String>[
  'Personal payment',
  'Family support',
  'Education fees',
  'Medical expenses',
  'Property purchase',
  'Investment',
  'Business payment',
  'Other',
];

/// Africa: same enum (Flutterwave accepts free-text but backend normalises).
const _africanPurposes = <String>[
  'Personal payment',
  'Family support',
  'Business payment',
  'Other',
];

class FlutterwaveCountryRules {
  FlutterwaveCountryRules._();

  static const Map<String, ExchangeCountryRule> byCurrency = {
    'NGN': ExchangeCountryRule(
      currency: 'NGN',
      countryCode: 'NG',
      countryName: 'Nigeria',
      dialCode: '234',
      requiresBankCode: true,
      supportsPaystackNameResolve: true,
      omitBeneficiaryName: true,
      minAmount: 100,           // ₦100
      maxAmount: 50000000,    // ₦50m per NIBSS cap
      fields: [
        ExchangeFieldSpec(
          name: 'bank_code',
          label: 'Bank',
          required: true,
          type: 'select',
          hint: 'Select Nigerian bank',
        ),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          hint: 'NUBAN — 10 digits',
          minLength: 10,
          maxLength: 10,
          digitsOnly: true,
        ),
        // beneficiary_name is auto-resolved via Paystack — no field rendered.
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'GHS': ExchangeCountryRule(
      currency: 'GHS',
      countryCode: 'GH',
      countryName: 'Ghana',
      dialCode: '233',
      requiresBankCode: true,
      requiresBranchCode: true,
      supportsPaystackNameResolve: true,
      minAmount: 5,
      maxAmount: 1000000,
      fields: [
        ExchangeFieldSpec(
          name: 'bank_code',
          label: 'Bank',
          required: true,
          type: 'select',
        ),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          hint: '10-13 digits',
          minLength: 10,
          maxLength: 16,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'branch_code',
          label: 'Branch Code',
          required: true,
          type: 'text',
          hint: 'Bank branch code',
          minLength: 3,
          maxLength: 10,
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
          hint: 'Full legal name',
          minLength: 3,
        ),
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'KES': ExchangeCountryRule(
      currency: 'KES',
      countryCode: 'KE',
      countryName: 'Kenya',
      dialCode: '254',
      requiresBankCode: true,
      supportsPaystackNameResolve: true,
      minAmount: 100,
      maxAmount: 10000000,
      fields: [
        ExchangeFieldSpec(name: 'bank_code', label: 'Bank', required: true, type: 'select'),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          minLength: 6,
          maxLength: 15,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
          minLength: 3,
        ),
        // Email + phone were previously rendered as "optional" but
        // Flutterwave's Kenya bank_kes recipient shape doesn't require
        // them and the transfer goes through without them. Dropped to
        // reduce friction.
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'ZAR': ExchangeCountryRule(
      currency: 'ZAR',
      countryCode: 'ZA',
      countryName: 'South Africa',
      dialCode: '27',
      requiresBankCode: true,
      supportsPaystackNameResolve: true,
      minAmount: 10,
      maxAmount: 5000000,
      fields: [
        ExchangeFieldSpec(name: 'bank_code', label: 'Bank', required: true, type: 'select'),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          minLength: 6,
          maxLength: 11,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
          minLength: 3,
        ),
        // Address (street + city) is the only extra field ZAR's
        // bank_zar type wants beyond name + bank + account. Email/phone
        // were previously rendered as optional but Flutterwave doesn't
        // mandate them — dropped to reduce form friction.
        ExchangeFieldSpec(
          name: 'beneficiary_address',
          label: 'Recipient Address',
          required: true,
          type: 'text',
          hint: 'Street, City',
          minLength: 5,
        ),
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'UGX': ExchangeCountryRule(
      currency: 'UGX',
      countryCode: 'UG',
      countryName: 'Uganda',
      dialCode: '256',
      requiresBankCode: true,
      requiresBranchCode: true,
      minAmount: 1000,
      maxAmount: 500000000,
      fields: [
        ExchangeFieldSpec(name: 'bank_code', label: 'Bank', required: true, type: 'select'),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          minLength: 9,
          maxLength: 16,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'branch_code',
          label: 'Branch Code',
          required: true,
          type: 'text',
          hint: 'e.g. UG280103',
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
        ),
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'TZS': ExchangeCountryRule(
      currency: 'TZS',
      countryCode: 'TZ',
      countryName: 'Tanzania',
      dialCode: '255',
      requiresBankCode: true,
      minAmount: 1000,
      maxAmount: 500000000,
      fields: [
        ExchangeFieldSpec(name: 'bank_code', label: 'Bank', required: true, type: 'select'),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          minLength: 8,
          maxLength: 16,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
        ),
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'XOF': ExchangeCountryRule(
      currency: 'XOF',
      countryCode: 'SN',
      countryName: 'West Africa (CFA)',
      dialCode: '221',
      requiresBankCode: true,
      minAmount: 1000,
      maxAmount: 100000000,
      fields: [
        ExchangeFieldSpec(name: 'bank_code', label: 'Bank', required: true, type: 'select'),
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          minLength: 8,
          maxLength: 28, // XOF often uses an IBAN-like format
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
        ),
      ],
      purposeOfPaymentOptions: _africanPurposes,
    ),

    'USD': ExchangeCountryRule(
      currency: 'USD',
      countryCode: 'US',
      countryName: 'United States',
      dialCode: '1',
      requiresBankCode: false,
      supportsBeneficiaryType: true,
      minAmount: 1,
      maxAmount: 1000000,
      fields: [
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          hint: '4-17 digit US account number',
          minLength: 4,
          maxLength: 17,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'routing_number',
          label: 'ABA Routing Number',
          required: true,
          type: 'text',
          hint: '9-digit ABA routing number',
          minLength: 9,
          maxLength: 9,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'swift_code',
          label: 'SWIFT/BIC Code',
          required: true,
          type: 'text',
          hint: 'e.g. CHASUS33',
          minLength: 8,
          maxLength: 11,
        ),
        ExchangeFieldSpec(
          name: 'bank_name',
          label: 'Bank Name',
          required: true,
          type: 'text',
          minLength: 2,
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
          minLength: 2,
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_address',
          label: 'Recipient Address',
          required: true,
          type: 'text',
          hint: 'Street, City, State',
          minLength: 5,
        ),
      ],
      purposeOfPaymentOptions: _internationalPurposes,
    ),

    'GBP': ExchangeCountryRule(
      currency: 'GBP',
      countryCode: 'GB',
      countryName: 'United Kingdom',
      dialCode: '44',
      requiresBankCode: false,
      supportsBeneficiaryType: true,
      minAmount: 1,
      maxAmount: 500000,
      fields: [
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'Account Number',
          required: true,
          type: 'text',
          hint: '8-digit UK account number',
          minLength: 8,
          maxLength: 8,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'routing_number',
          label: 'Sort Code',
          required: true,
          type: 'text',
          hint: '6 digits (XX-XX-XX)',
          minLength: 6,
          maxLength: 6,
          digitsOnly: true,
        ),
        ExchangeFieldSpec(
          name: 'swift_code',
          label: 'SWIFT/BIC Code',
          required: true,
          type: 'text',
          hint: 'e.g. BUKBGB22',
          minLength: 8,
          maxLength: 11,
        ),
        ExchangeFieldSpec(
          name: 'bank_name',
          label: 'Bank Name',
          required: true,
          type: 'text',
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_address',
          label: 'Recipient Address',
          required: true,
          type: 'text',
          hint: 'UK address',
        ),
      ],
      purposeOfPaymentOptions: _internationalPurposes,
    ),

    'EUR': ExchangeCountryRule(
      currency: 'EUR',
      countryCode: 'EU',
      countryName: 'Europe (SEPA)',
      dialCode: '49',
      requiresBankCode: false,
      supportsBeneficiaryType: true,
      minAmount: 1,
      maxAmount: 500000,
      fields: [
        ExchangeFieldSpec(
          name: 'account_number',
          label: 'IBAN',
          required: true,
          type: 'iban',
          hint: '15-34 alphanumeric characters',
          minLength: 15,
          maxLength: 34,
        ),
        ExchangeFieldSpec(
          name: 'swift_code',
          label: 'SWIFT/BIC Code',
          required: true,
          type: 'text',
          hint: 'e.g. DEUTDEFF',
          minLength: 8,
          maxLength: 11,
        ),
        ExchangeFieldSpec(
          name: 'bank_name',
          label: 'Bank Name',
          required: true,
          type: 'text',
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_name',
          label: 'Recipient Name',
          required: true,
          type: 'text',
        ),
        ExchangeFieldSpec(
          name: 'beneficiary_address',
          label: 'Recipient Address',
          required: true,
          type: 'text',
          hint: 'European address',
        ),
      ],
      purposeOfPaymentOptions: _internationalPurposes,
    ),
  };

  static ExchangeCountryRule? forCurrency(String currency) {
    return byCurrency[currency.toUpperCase()];
  }
}
