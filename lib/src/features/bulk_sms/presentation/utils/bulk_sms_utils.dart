/// Pure helpers for the Bulk SMS UI: GSM segment counting, unit estimation,
/// Nigerian phone normalization/validation, and `{{variable}}` extraction.
/// Kept dependency-free so screens and the recipients sheet share ONE source.
class BulkSmsUtils {
  const BulkSmsUtils._();

  /// GSM-7 single-segment length; concatenated messages use 153 chars/segment.
  static const int gsmSingle = 160;
  static const int gsmConcat = 153;

  /// Unicode single-segment length; concatenated uses 67 chars/segment.
  static const int unicodeSingle = 70;
  static const int unicodeConcat = 67;

  /// True when [text] contains any character outside the basic GSM-7 set,
  /// forcing the shorter Unicode segmentation.
  static bool isUnicode(String text) {
    return text.runes.any((r) => r > 0x7F);
  }

  /// Number of SMS segments [text] will occupy.
  static int segmentCount(String text) {
    if (text.isEmpty) return 0;
    final len = text.length;
    if (isUnicode(text)) {
      return len <= unicodeSingle ? 1 : (len / unicodeConcat).ceil();
    }
    return len <= gsmSingle ? 1 : (len / gsmConcat).ceil();
  }

  /// Estimated credits (units) needed = segments × recipients. One credit is
  /// one segment delivered to one recipient.
  static int estimatedUnits({required String message, required int recipientCount}) {
    if (recipientCount <= 0) return 0;
    final segs = segmentCount(message);
    return segs * recipientCount;
  }

  static final RegExp _variablePattern = RegExp(r'\{\{\s*([a-zA-Z0-9_]+)\s*\}\}');

  /// The distinct `{{variable}}` keys referenced in [template], in first-seen
  /// order.
  static List<String> variablesIn(String template) {
    final seen = <String>{};
    final out = <String>[];
    for (final m in _variablePattern.allMatches(template)) {
      final key = m.group(1);
      if (key != null && seen.add(key)) out.add(key);
    }
    return out;
  }

  /// Normalize a raw Nigerian number to `+234XXXXXXXXXX` E.164, or return null
  /// when it can't be made into a valid NG mobile number.
  static String? normalizeNg(String raw) {
    var s = raw.trim().replaceAll(RegExp(r'[\s\-()]'), '');
    if (s.isEmpty) return null;
    // Strip a leading 00 international prefix.
    if (s.startsWith('00')) s = '+${s.substring(2)}';
    if (s.startsWith('+')) {
      if (s.startsWith('+234')) {
        final rest = s.substring(4);
        return _validNgSubscriber(rest) ? '+234$rest' : null;
      }
      // Some other country code — accept as-is if it looks like a phone number.
      final digits = s.substring(1);
      return digits.length >= 8 && RegExp(r'^\d+$').hasMatch(digits) ? s : null;
    }
    // Local formats: 0803... (11 digits) or 803... (10 digits) or 234803...
    if (s.startsWith('234')) {
      final rest = s.substring(3);
      return _validNgSubscriber(rest) ? '+234$rest' : null;
    }
    if (s.startsWith('0')) {
      final rest = s.substring(1);
      return _validNgSubscriber(rest) ? '+234$rest' : null;
    }
    // Bare 10-digit subscriber number.
    return _validNgSubscriber(s) ? '+234$s' : null;
  }

  /// A valid NG mobile subscriber number is 10 digits starting 7/8/9.
  static bool _validNgSubscriber(String rest) {
    return rest.length == 10 && RegExp(r'^[789]').hasMatch(rest);
  }

  /// Split a pasted blob on comma / newline / whitespace / semicolon.
  static List<String> splitRaw(String blob) {
    return blob
        .split(RegExp(r'[\s,;]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  /// Parse a pasted blob into deduped, validated E.164 numbers plus the count
  /// of entries that couldn't be parsed.
  static ({List<String> valid, int invalidCount}) parseNumbers(String blob) {
    final seen = <String>{};
    final valid = <String>[];
    var invalid = 0;
    for (final token in splitRaw(blob)) {
      final norm = normalizeNg(token);
      if (norm == null) {
        invalid++;
        continue;
      }
      if (seen.add(norm)) valid.add(norm);
    }
    return (valid: valid, invalidCount: invalid);
  }

  /// A short, display-friendly form of an E.164 NG number.
  static String pretty(String e164) {
    if (e164.startsWith('+234') && e164.length == 14) {
      final r = e164.substring(4);
      return '+234 ${r.substring(0, 3)} ${r.substring(3, 6)} ${r.substring(6)}';
    }
    return e164;
  }
}
