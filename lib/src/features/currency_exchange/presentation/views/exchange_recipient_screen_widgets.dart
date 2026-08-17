part of 'exchange_recipient_screen.dart';

// ---------------------------------------------------------------------------
// Currency → Country config (derived, no picker)
// ---------------------------------------------------------------------------

enum _FieldType { african, uk, us, eu, generic }

// Receiver classification — wire value maps to
// ReceiverDetails.beneficiary_type ("individual"|"business") which the
// exchange-service plumbs into the Flutterwave meta payload. Used for UK
// CoP alignment + forward-compatibility with the Flutterwave v4 API's
// recipient.type.
enum _BeneficiaryKind {
  individual,
  business;

  String get wireValue => this == _BeneficiaryKind.individual ? 'individual' : 'business';
  String get label => this == _BeneficiaryKind.individual ? 'Individual' : 'Business';
}

class _CurrencyCountryConfig {
  final String countryCode;
  final String countryName;
  final String flag;
  final _FieldType fieldType;
  final bool supportsAutoVerify;

  const _CurrencyCountryConfig({
    required this.countryCode,
    required this.countryName,
    required this.flag,
    required this.fieldType,
    this.supportsAutoVerify = false,
  });

  static _CurrencyCountryConfig fromCurrency(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return const _CurrencyCountryConfig(
          countryCode: 'NG',
          countryName: 'Nigeria',
          flag: '\u{1F1F3}\u{1F1EC}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'GHS':
        return const _CurrencyCountryConfig(
          countryCode: 'GH',
          countryName: 'Ghana',
          flag: '\u{1F1EC}\u{1F1ED}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'KES':
        return const _CurrencyCountryConfig(
          countryCode: 'KE',
          countryName: 'Kenya',
          flag: '\u{1F1F0}\u{1F1EA}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'ZAR':
        return const _CurrencyCountryConfig(
          countryCode: 'ZA',
          countryName: 'South Africa',
          flag: '\u{1F1FF}\u{1F1E6}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'PHP':
        // Klasha corridor — generic bank fields (bank name + account number).
        return const _CurrencyCountryConfig(
          countryCode: 'PH',
          countryName: 'Philippines',
          flag: '\u{1F1F5}\u{1F1ED}',
          fieldType: _FieldType.generic,
        );
      case 'CAD':
        return const _CurrencyCountryConfig(
          countryCode: 'CA',
          countryName: 'Canada',
          flag: '\u{1F1E8}\u{1F1E6}',
          fieldType: _FieldType.generic,
        );
      case 'GBP':
        return const _CurrencyCountryConfig(
          countryCode: 'GB',
          countryName: 'United Kingdom',
          flag: '\u{1F1EC}\u{1F1E7}',
          fieldType: _FieldType.uk,
        );
      case 'USD':
        return const _CurrencyCountryConfig(
          countryCode: 'US',
          countryName: 'United States',
          flag: '\u{1F1FA}\u{1F1F8}',
          fieldType: _FieldType.us,
        );
      case 'EUR':
        return const _CurrencyCountryConfig(
          countryCode: 'EU',
          countryName: 'Europe',
          flag: '\u{1F1EA}\u{1F1FA}',
          fieldType: _FieldType.eu,
        );
      default:
        // Safe substring: use full currency if shorter than 2 chars
        final code = currency.length >= 2
            ? currency.substring(0, 2).toUpperCase()
            : currency.toUpperCase();
        return _CurrencyCountryConfig(
          countryCode: code,
          countryName: currency,
          flag: '\u{1F3F3}\u{FE0F}',
          fieldType: _FieldType.generic,
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Sort code formatter: XX-XX-XX
// ---------------------------------------------------------------------------

class _SortCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 6) {
      return oldValue;
    }
    // Count how many raw digits are before the cursor in the new input
    final cursorPos =
        newValue.selection.baseOffset.clamp(0, newValue.text.length);
    int digitsBefore = newValue.text
        .substring(0, cursorPos)
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length;

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) buffer.write('-');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();

    // Map digitsBefore back to a position in the formatted string
    int newCursorPos = 0;
    int digitCount = 0;
    for (int i = 0; i < formatted.length && digitCount < digitsBefore; i++) {
      newCursorPos = i + 1;
      if (formatted[i] != '-') digitCount++;
    }
    newCursorPos = newCursorPos.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
}

// ---------------------------------------------------------------------------
// IBAN formatter: groups of 4 separated by spaces
// ---------------------------------------------------------------------------

class _IbanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleaned =
        newValue.text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();
    if (cleaned.length > 34) {
      return oldValue;
    }
    // Count how many alphanumeric chars are before the cursor
    final cursorPos =
        newValue.selection.baseOffset.clamp(0, newValue.text.length);
    int charsBefore = newValue.text
        .substring(0, cursorPos)
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
        .length;

    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    final formatted = buffer.toString();

    // Map charsBefore back to a position in the formatted string
    int newCursorPos = 0;
    int charCount = 0;
    for (int i = 0; i < formatted.length && charCount < charsBefore; i++) {
      newCursorPos = i + 1;
      if (formatted[i] != ' ') charCount++;
    }
    newCursorPos = newCursorPos.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
}
