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
