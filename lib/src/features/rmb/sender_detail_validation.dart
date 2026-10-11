/// Sender/recipient detail validation for cross-border payouts.
///
/// Why this exists: on 2026-10-10 two live CNY Alipay payouts were rejected by
/// the provider with `failureReason: "Tazapay payout details are missing."`
/// AFTER it had debited our merchant wallet $62.09 and taken a $5.61 fee on
/// each. The stored compliance profile behind them read
///
///   {"city":"City","state":"State","postcode":"","street_address":""}
///
/// The city and state were the text-field labels, typed in to get past a
/// required check; the street address was blank because the field was declared
/// optional. Every value was non-empty-or-optional by our rules and missing by
/// the provider's.
///
/// Mirrors `placeholderFor` in the backend's
/// `internal/provider/payout_details.go`. Both sides must agree, or the app
/// lets through something the server then refuses (or worse, doesn't).
library;

/// Values that look filled in but carry no information.
const _junkValues = <String>{
  'n/a',
  'na',
  'none',
  'null',
  'nil',
  '-',
  '--',
  'unknown',
  'not applicable',
  'string',
  'test',
  'xxx',
  'xxxx',
};

String _strip(String v) => v.replaceAll(RegExp(r'[\s_\-.,]'), '');

/// Whether [value] fails to answer a field labelled [label] — empty, a known
/// junk token, or the label echoed back ("City" in the city box).
bool isPlaceholderValue(String value, String label) {
  final t = value.trim().toLowerCase();
  if (t.isEmpty) return true;
  if (_junkValues.contains(t)) return true;
  return _strip(t) == _strip(label.trim().toLowerCase());
}

/// The inline error for a required field, or null when it is acceptable.
///
/// Distinguishes "you left this empty" from "you typed the field name", because
/// showing `Required` to someone who did type something reads as a broken form.
String? senderFieldError(String value, String label) {
  if (value.trim().isEmpty) return 'Required';
  if (isPlaceholderValue(value, label)) {
    return 'Enter your actual ${label.toLowerCase()}';
  }
  return null;
}

/// Sender government-ID format, mirroring `ValidateSenderID` in the backend's
/// `internal/service/rmb_sender_id.go`.
///
/// There was no check at all before: the field only had to be non-empty, which
/// is how "888989898989" was stored as a PASSPORT and sent to a payment
/// provider as that person's passport number.
///
/// Deliberately tolerant — a false rejection blocks a real person from sending
/// money, which is worse than letting an unusual-but-genuine number through
/// for the provider to judge. The server re-checks regardless; this exists so
/// the user sees the problem on the field rather than after tapping Save.
final _ninRe = RegExp(r'^\d{11}$');
final _ngPassportRe = RegExp(r'^[A-Za-z]\d{8}$');
final _anyPassportRe = RegExp(r'^[A-Za-z0-9]{6,12}$');
final _driverLicRe = RegExp(r'^[A-Za-z0-9]{8,20}$');
final _idSeparators = RegExp(r'[\s\-]+');

String normalizeSenderId(String v) =>
    v.trim().replaceAll(_idSeparators, '').toUpperCase();

/// Fewer than three distinct characters, from eight characters up. This is the
/// rule that actually catches junk: without it the document-type dropdown is
/// an escape hatch, because a 12-digit mash satisfies the generic passport
/// pattern perfectly well.
bool looksLikeKeyboardMash(String v) {
  if (v.length < 8) return false;
  return v.split('').toSet().length < 3;
}

/// Returns an error to show on the ID field, or null when acceptable.
String? senderIdError(String number, String idType, String nationality) {
  final v = normalizeSenderId(number);
  if (v.isEmpty) return 'Enter your ID number.';
  final t = idType.trim().toUpperCase();
  final nat = nationality.trim().toUpperCase();

  if (looksLikeKeyboardMash(v)) {
    return "That ID number doesn't look right. Check it, or contact support "
        'if it is correct.';
  }
  switch (t) {
    case 'ID_CARD':
    case 'NIN':
    case 'NATIONAL_ID':
      if (nat.isEmpty || nat == 'NG') {
        if (!_ninRe.hasMatch(v)) return 'A Nigerian National ID (NIN) is 11 digits.';
      } else if (v.length < 5 || v.length > 20) {
        return "That national ID number doesn't look right.";
      }
    case 'PASSPORT':
      if (nat.isEmpty || nat == 'NG') {
        if (!_ngPassportRe.hasMatch(v)) {
          return 'A Nigerian passport number is one letter followed by eight '
              'digits, like A01234567.';
        }
      } else if (!_anyPassportRe.hasMatch(v)) {
        return "That passport number doesn't look right.";
      }
    case 'DRIVER_LICENSE':
    case 'DRIVERS_LICENSE':
    case 'DRIVER_LICENCE':
      if (!_driverLicRe.hasMatch(v)) {
        return "That driver's licence number doesn't look right.";
      }
    default:
      if (v.length < 5 || v.length > 20) {
        return "That ID number doesn't look right.";
      }
  }
  return null;
}
