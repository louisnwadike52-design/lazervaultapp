part of 'donation_payment_screen.dart';

/// Reformats input as the user types so digits show grouped:
/// `1234567` → `1,234,567`. Caret position is reanchored from the
/// right so the user's typing index stays where they expect.
class _ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text;
    if (raw.isEmpty) return newValue;
    // Split on the (optional) decimal point and reformat the integer
    // half. Keep at most one decimal point and at most 2 fractional
    // digits — anything past that gets clipped.
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
    // Reject all-zero leading runs ("000" → "0")
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
