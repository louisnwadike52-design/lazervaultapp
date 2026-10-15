import 'package:flutter/services.dart';
import 'package:lazervault/src/features/id_pay/domain/pay_id_code.dart';

export 'package:lazervault/src/features/id_pay/domain/pay_id_code.dart'
    show stripPayIdPrefix;

/// Strips the prefix as it is typed or pasted, and upper-cases.
///
/// Upper-casing here rather than relying on [TextCapitalization]: that is a
/// keyboard hint, and a paste never goes through the keyboard. A lowercase
/// code reaching the lookup is the same failed search as a doubled prefix.
class PayIdInputFormatter extends TextInputFormatter {
  const PayIdInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleaned = stripPayIdPrefix(newValue.text).toUpperCase();
    if (cleaned == newValue.text) return newValue;
    // Keep the caret where the user expects it: the characters removed all
    // came from the FRONT, so the offset moves back by exactly that many —
    // clamped, because a selection can sit beyond the shortened text.
    final removed = newValue.text.length - cleaned.length;
    final offset =
        (newValue.selection.baseOffset - removed).clamp(0, cleaned.length);
    return TextEditingValue(
      text: cleaned,
      selection: TextSelection.collapsed(offset: offset),
      composing: TextRange.empty,
    );
  }
}
