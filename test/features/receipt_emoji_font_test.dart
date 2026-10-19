import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// EMOJI DREW AS A HOLLOW BOX IN EVERY SHARED RECEIPT.
///
/// Seen on a Tagpay transfer receipt whose reference was "Apple 🍎": the
/// apple rendered as tofu in the shared PDF. Inter — the face every receipt
/// embeds — covers ₦, em dashes, curly apostrophes and accented names, which
/// are the characters that used to RAISE, but it has no emoji at all.
///
/// The fix is a monochrome emoji fallback on the shared theme, so it reaches
/// every generator at once (all of them route through ReceiptFonts; the
/// unfonted-document sweep is clean).
///
/// Monochrome is not a preference. Apple Color Emoji is a .ttc colour font
/// the pdf package cannot embed, and the colour Noto build is CBDT/sbix
/// bitmap, which it also cannot draw. An outline font is the only kind that
/// embeds at all.
///
/// This guard is asset + source level: the failure is "the glyph is not in
/// the document", which no return value exposes.

void main() {
  final root = Directory.current.path;

  test('the monochrome emoji face is bundled and is a real TrueType file', () {
    final f = File('$root/assets/fonts/NotoEmoji-Regular.ttf');
    expect(f.existsSync(), isTrue,
        reason: 'assets/fonts/NotoEmoji-Regular.ttf is missing — every '
            'receipt is back to drawing emoji as a box');

    // A truncated or LFS-pointer file would "exist" and fail at runtime.
    final bytes = f.readAsBytesSync();
    expect(bytes.length, greaterThan(100000),
        reason: 'the emoji font is suspiciously small — truncated download?');

    // TrueType magic: 0x00010000, or "true"/"ttcf".
    final magic = bytes.sublist(0, 4);
    final isTtf = magic[0] == 0x00 &&
        magic[1] == 0x01 &&
        magic[2] == 0x00 &&
        magic[3] == 0x00;
    final tag = String.fromCharCodes(magic);
    expect(isTtf || tag == 'true' || tag == 'ttcf', isTrue,
        reason: 'not a TrueType file (magic: $magic)');
    expect(tag, isNot('ttcf'),
        reason: 'a .ttc collection cannot be embedded by the pdf package — '
            'that is exactly why Apple Color Emoji could not be used');
  });

  test('the shared theme actually consults the fallback', () {
    final src =
        File('$root/lib/core/utils/receipt_fonts.dart').readAsStringSync();
    expect(src, contains('NotoEmoji-Regular.ttf'),
        reason: 'the loader no longer loads the emoji face');
    expect(src, contains('fontFallback'),
        reason: 'ThemeData.withFont no longer passes fontFallback, so the '
            'emoji face is loaded and never consulted');
  });

  test('a missing emoji face must not cost the receipt its real typeface', () {
    // The emoji load is deliberately in its own try: Inter is what stops
    // exports RAISING on ₦ and em dashes, and losing it to a missing
    // decorative font would turn a cosmetic gap into "Share failed".
    final src =
        File('$root/lib/core/utils/receipt_fonts.dart').readAsStringSync();
    final emojiAt = src.indexOf("NotoEmoji-Regular.ttf");
    final interAt = src.indexOf("Inter-Regular.ttf");
    expect(interAt, lessThan(emojiAt),
        reason: 'Inter must load before the emoji fallback');
    final between = src.substring(interAt, emojiAt);
    expect(between, contains('try {'),
        reason: 'the emoji load is not independently guarded — a missing '
            'emoji asset would take the whole typeface down with it');
  });

  test('every PDF generator goes through the shared theme', () {
    // Proven by sweep rather than assumed: a generator that builds a bare
    // pw.Document() gets neither Inter nor the emoji fallback.
    final offenders = <String>[];
    for (final e in Directory('$root/lib').listSync(recursive: true)) {
      if (e is! File || !e.path.endsWith('.dart')) continue;
      if (e.path.contains('/generated/')) continue;
      final src = e.readAsStringSync();
      if (!src.contains('pw.Document(')) continue;
      if (src.contains('ThemeData.withFont') || src.contains('ReceiptFonts')) {
        continue;
      }
      offenders.add(e.path.replaceFirst(root, ''));
    }
    expect(offenders, isEmpty,
        reason: 'these build an unfonted PDF, so they draw in built-in '
            'Helvetica and will box or RAISE: $offenders');
  });
}
