import 'package:flutter/services.dart';

/// Sort Code Input Formatter
/// Formats UK bank sort codes as XX-XX-XX
class SortCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (text.length > 6) {
      final formatted = formatSortCode(text.substring(0, 6));
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    final formatted = formatSortCode(text);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }

  /// Formats a sort code string as XX-XX-XX
  static String formatSortCode(String text) {
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length <= 2) return digitsOnly;
    if (digitsOnly.length <= 4) {
      return '${digitsOnly.substring(0, 2)}-${digitsOnly.substring(2)}';
    }

    return '${digitsOnly.substring(0, 2)}-${digitsOnly.substring(2, 4)}-${digitsOnly.substring(4)}';
  }

  /// Validates UK sort code format (XX-XX-XX)
  static bool isValidSortCode(String sortCode) {
    final digitsOnly = sortCode.replaceAll(RegExp(r'[^0-9]'), '');
    return digitsOnly.length == 6;
  }

  /// Gets sort code without dashes (6 digits only)
  static String getDigitsOnly(String sortCode) {
    return sortCode.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
