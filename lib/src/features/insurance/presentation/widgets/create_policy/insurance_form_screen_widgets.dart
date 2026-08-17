part of 'insurance_form_screen.dart';

/// Per-country mobile-number rule used by [_validatePhoneNumber]. Local
/// digits length is exact (no range) because every supported country's
/// numbering plan is fixed length once the trunk prefix is stripped.
/// Source the user selected in the file-upload bottom sheet. We use an
/// enum (rather than a string) so the switch in `_showUploadSourceSheet`
/// is exhaustive — adding a new source means the compiler flags any
/// branch that hasn't handled it.
enum _UploadSource { camera, gallery, file }

class _PhoneRule {
  final int localDigits;
  final List<String> validStartDigits;
  const _PhoneRule({required this.localDigits, required this.validStartDigits});
}

/// Input formatter that caps phone-number input to `localDigits` digits
/// normally, but allows `localDigits + 1` when the user starts with a
/// '0' (the national trunk prefix that several countries — NG, GB, KE,
/// ZA, GH — use when writing the number locally). The cubit strips that
/// leading zero before sending the canonical E.164 form to MyCover, so
/// the user can type either `8012345678` or `08012345678` for NG and
/// both produce `+2348012345678` on the wire.
///
/// We do this in a formatter (rather than a `LengthLimitingTextInput
/// Formatter` configured to `localDigits + 1` unconditionally) so the
/// "too many digits" error is impossible to reach — a user who didn't
/// type a leading zero is hard-stopped at the correct length.
class _LeadingZeroAwareLengthFormatter extends TextInputFormatter {
  final int localDigits;

  const _LeadingZeroAwareLengthFormatter({required this.localDigits});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    // FilteringTextInputFormatter.digitsOnly runs before us, but be
    // defensive — strip anything that's not a digit just in case.
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');
    final cap = digits.startsWith('0') ? localDigits + 1 : localDigits;
    if (digits.length <= cap) {
      // If the formatter above us stripped non-digits, keep the new
      // value's selection but use the digit-only text.
      if (digits == text) return newValue;
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    }
    final clipped = digits.substring(0, cap);
    return TextEditingValue(
      text: clipped,
      selection: TextSelection.collapsed(offset: clipped.length),
    );
  }
}
