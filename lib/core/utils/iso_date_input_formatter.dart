import 'package:flutter/services.dart';

/// Types a date as YYYY-MM-DD, inserting the dashes for you.
///
/// WHY
/// ---
/// The FCY KYC fields require YYYY-MM-DD because that is what the provider
/// accepts, and the hint said so — but the field took free text, so the user
/// had to type the dashes themselves and a date entered any other way was
/// rejected only at submit, after the whole form was filled. On a date of
/// birth that is the most tedious possible place to find out.
///
/// WHAT IT DOES
/// ------------
/// Keeps digits, drops everything else, and re-inserts the separators at
/// fixed positions as you go: `19900115` → `1990-01-15`. Capped at eight
/// digits, so the field cannot grow past a date.
///
/// DELETING NEEDS NO SPECIAL CASE
/// ------------------------------
/// The classic failure of this kind of formatter is backspacing a separator
/// that is immediately re-inserted, so the caret appears stuck. It cannot
/// happen here: a separator is written BEFORE the digit it precedes, so the
/// text never ends in a dash, and backspacing from the end therefore always
/// removes a digit. "1990-01-1" → "1990-01" → "1990-0" → "1990" falls out of
/// re-rendering alone. A length-comparison branch for the dash case was
/// written first and then deleted — it was unreachable, and an unreachable
/// branch in an input path is a trap for whoever edits this next.
///
/// RANGES ARE NOT VALIDATED HERE
/// -----------------------------
/// A formatter runs on every keystroke, and a partially-typed date is
/// invalid almost all the time — "1" is not a year. Rejecting as you type
/// would make the field impossible to fill. Month/day sanity is left to the
/// step validator, which runs when the value is complete.
class IsoDateInputFormatter extends TextInputFormatter {
  const IsoDateInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = _digitsOf(newValue.text);
    if (digits.length > 8) digits = digits.substring(0, 8);

    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      // Separators BEFORE the 5th and 7th digit: YYYY-MM-DD.
      if (i == 4 || i == 6) buf.write('-');
      buf.write(digits[i]);
    }
    final text = buf.toString();

    return TextEditingValue(
      text: text,
      // Caret to the end. These fields are filled left to right and are ten
      // characters long; preserving a mid-string offset across inserted
      // separators costs more than it buys, and getting it wrong strands the
      // caret mid-field.
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  static String _digitsOf(String s) => s.replaceAll(RegExp(r'[^0-9]'), '');
}
