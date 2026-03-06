/// Utility for detecting and masking transaction PINs in chat messages.
///
/// PINs are exactly 4 digits. If a user message is purely a 4-digit string
/// it is treated as a PIN and masked. Messages longer than 4 digits or
/// containing non-digit characters are shown normally.

final _pinPattern = RegExp(r'^\d{4}$');

/// Returns `true` when [text] looks like a transaction PIN (exactly 4 digits).
bool isPinText(String text) => _pinPattern.hasMatch(text.trim());

/// If [text] is a 4-digit PIN, returns `****`; otherwise returns [text] unchanged.
String maskIfPin(String text) {
  final trimmed = text.trim();
  return isPinText(trimmed) ? '****' : text;
}
