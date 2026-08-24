/// OCR repair for REAL-WORLD payment surfaces — chalk on walls, handwritten
/// shop signs, weathered paint (the "MONIE POINT 5086618744 on a kiosk wall"
/// case). ML Kit's Latin model reads these, but with two systematic defects
/// that made the strict `\d{10}` NUBAN/phone regexes blind to them:
///
///  1. Broken digit runs — shaky spacing renders "5086618744" as
///     "508 661 8744" / "50866-18744", which `(?<!\d)\d{10}(?!\d)` can never
///     match.
///  2. Look-alike glyph confusions — handwritten digits come back as letters
///     (O→0, I/l→1, S→5, B→8, Z→2), so a frame reads "5O866I8744" one moment
///     and "50866 18744" the next. Beyond failing the regex, the flicker also
///     defeats the live scanner's N-consecutive-identical-frames stability
///     gate, so auto-capture never fires at all.
///
/// [augmentDigitRuns] repairs both WITHOUT touching normal words: confusables
/// are only mapped inside tokens that are already digit-heavy, and coalesced
/// runs are APPENDED to the original text (never substituted), so every
/// existing pattern — emails, @usernames, bank names — still sees the raw OCR.
library;

/// Look-alike glyphs OCR substitutes for handwritten digits. Conservative set:
/// only shapes that are near-unambiguous inside an otherwise-numeric token.
const Map<String, String> _confusables = {
  'O': '0', 'o': '0', 'D': '0', 'Q': '0',
  'I': '1', 'l': '1', '|': '1', 'i': '1',
  'S': '5', 's': '5',
  'B': '8',
  'Z': '2', 'z': '2',
  // Handwriting extensions (all gated to digit-heavy tokens, so words are
  // never touched): open-loop 6s read as G, descender 9s as g/q.
  'G': '6',
  'g': '9', 'q': '9',
};

final RegExp _tokenSplit = RegExp(r'\s+');

/// Sequences of digits broken by spaces / dashes / dots / commas (max 2
/// separator chars between digit groups, so unrelated numbers on the sign
/// don't fuse). Commas matter for slanted handwriting: a tilted "1" or a
/// stroke tail frequently OCRs as "," mid-run.
final RegExp _brokenRun =
    RegExp(r"(?<![\d])\d(?:[\s\-.,·']{0,2}\d){8,13}(?![\d])");

/// Returns [raw] with (a) digit-heavy tokens repaired for confusable glyphs
/// and (b) every plausible account/phone digit-run re-appended as one
/// contiguous token — ready for the existing NUBAN/phone regexes.
String augmentDigitRuns(String raw) {
  if (raw.trim().isEmpty) return raw;

  // Pass 1 — per-token confusable repair. A token qualifies only when digits
  // (+ confusables) dominate it, so "Bola" or "SUPER" is never mangled while
  // "5O866I8744" becomes "5086618744".
  final repaired = raw.split(_tokenSplit).map((token) {
    if (token.length < 4) return token;
    var digits = 0, confusable = 0;
    for (final ch in token.split('')) {
      if (RegExp(r'\d').hasMatch(ch)) {
        digits++;
      } else if (_confusables.containsKey(ch)) {
        confusable++;
      }
    }
    // Needs real digits present and a strongly numeric shape.
    if (digits < 3 || (digits + confusable) / token.length < 0.7) return token;
    final b = StringBuffer();
    for (final ch in token.split('')) {
      b.write(_confusables[ch] ?? ch);
    }
    return b.toString();
  }).join(' ');

  // Pass 2 — coalesce broken digit runs into contiguous tokens and APPEND
  // them. 10 digits = NUBAN; 11 (leading 0) or 13-14 (+234…) = NG phone;
  // anything else is discarded rather than guessed.
  final appended = <String>{};
  for (final m in _brokenRun.allMatches(repaired)) {
    final run = m.group(0)!.replaceAll(RegExp(r'[^\d]'), '');
    if (run.length >= 10 && run.length <= 14) appended.add(run);
  }

  if (appended.isEmpty) return repaired;
  return '$repaired ${appended.join(' ')}';
}
