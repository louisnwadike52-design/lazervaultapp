part of 'sell_gift_card_screen.dart';

/// Formats card number in groups of 4 with dashes (XXXX-XXXX-XXXX-XXXX)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('-', '');

    // Limit to 16 characters (typical gift card length)
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    // Add dashes after every 4 characters
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
