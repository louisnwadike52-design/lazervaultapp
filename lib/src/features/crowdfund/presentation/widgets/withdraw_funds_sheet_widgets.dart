part of 'withdraw_funds_sheet.dart';

/// Same comma formatter shape as donation_payment_screen — keeps the
/// caret pinned right and clamps decimals to 2 places.
class _ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text;
    if (raw.isEmpty) return newValue;
    final parts = raw.replaceAll(',', '').split('.');
    final intPart = parts[0];
    String? fracPart = parts.length > 1 ? parts.sublist(1).join('') : null;
    if (fracPart != null && fracPart.length > 2) {
      fracPart = fracPart.substring(0, 2);
    }
    if (intPart.isEmpty && (fracPart == null || fracPart.isEmpty)) {
      return TextEditingValue(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    final trimmed = intPart.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final buf = StringBuffer();
    for (var i = 0; i < trimmed.length; i++) {
      if (i > 0 && (trimmed.length - i) % 3 == 0) buf.write(',');
      buf.write(trimmed[i]);
    }
    final formatted = fracPart != null
        ? '$buf.$fracPart'
        : (raw.endsWith('.') ? '$buf.' : buf.toString());
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
