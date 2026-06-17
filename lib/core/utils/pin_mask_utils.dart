/// Utility for detecting and masking transaction PINs in chat messages.
///
/// PINs are 4-6 digit numeric strings. If a user message is purely digits
/// in that range it is treated as a PIN and masked. Messages with non-digit
/// characters are shown normally.

final _pinPattern = RegExp(r'^\d{4,6}$');

/// Returns `true` when [text] looks like a transaction PIN (4-6 digits).
bool isPinText(String text) => _pinPattern.hasMatch(text.trim());

/// If [text] is a 4-6 digit PIN, returns masked text; otherwise returns [text] unchanged.
String maskIfPin(String text) {
  final trimmed = text.trim();
  return isPinText(trimmed) ? 'Secured data ***' : text;
}
