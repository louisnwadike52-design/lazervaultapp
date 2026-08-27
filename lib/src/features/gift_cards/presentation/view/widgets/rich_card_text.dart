import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

final RegExp _htmlTag = RegExp(r'<[a-zA-Z!/][^>]*>');
final RegExp _mdSyntax = RegExp(r'[*_`#>]+|\[([^\]]*)\]\([^)]*\)');

/// Any entity at all — named, numeric (`&#233;`), or hex (`&#xE9;`).
///
/// The optional `#` is deliberate. Catalogue feeds carry malformed references
/// that drop it — real values seen in the live catalogue include
/// `A&233;ropostale` for "Aéropostale" and `original&10;designs` for a line
/// break. Reading `&233;` as the numeric reference it was plainly meant to be
/// is what turns those into readable words instead of leaking punctuation into
/// a brand name.
final RegExp _htmlEntity = RegExp(r'&#?(x?[0-9a-fA-F]+|[a-zA-Z]+);');

/// The named entities worth spelling out. Anything not here is LEFT ALONE
/// rather than guessed at — the previous version mapped every unrecognised
/// entity to an apostrophe, which silently corrupted text it did not
/// understand.
const Map<String, String> _namedEntities = {
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
  'nbsp': ' ',
  'ndash': '–',
  'mdash': '—',
  'hellip': '…',
  'rsquo': '’',
  'lsquo': '‘',
  'ldquo': '“',
  'rdquo': '”',
  'trade': '™',
  'reg': '®',
  'copy': '©',
  'deg': '°',
  'eacute': 'é',
  'egrave': 'è',
  'uuml': 'ü',
  'ouml': 'ö',
  'auml': 'ä',
  'ccedil': 'ç',
  'ntilde': 'ñ',
};

/// Decodes HTML entities to the characters they stand for.
///
/// Returns the original text for anything it cannot resolve, because showing
/// `&weird;` is a smaller failure than replacing it with the wrong character.
String decodeHtmlEntities(String input) {
  if (!input.contains('&')) return input;
  return input.replaceAllMapped(_htmlEntity, (m) {
    final body = m.group(1)!;
    final whole = m.group(0)!;

    // Numeric: &#233; / &#xE9; / the malformed &233; described above.
    final isHex = body.startsWith('x') || body.startsWith('X');
    final digits = isHex ? body.substring(1) : body;
    final looksNumeric = isHex
        ? RegExp(r'^[0-9a-fA-F]+$').hasMatch(digits)
        : RegExp(r'^[0-9]+$').hasMatch(digits);
    if (looksNumeric) {
      final code = int.tryParse(digits, radix: isHex ? 16 : 10);
      // Reject anything outside valid Unicode, and control characters other
      // than tab/newline/carriage-return — a stray code point would render as
      // a tofu box, which is worse than leaving the reference visible.
      if (code == null || code <= 0 || code > 0x10FFFF) return whole;
      if (code < 0x20 && code != 0x09 && code != 0x0A && code != 0x0D) {
        return ' ';
      }
      return String.fromCharCode(code);
    }

    return _namedEntities[body.toLowerCase()] ?? whole;
  });
}

/// A gift-card description/notes value may arrive as HTML (Prestmit sends
/// `<span>…</span>`), markdown, or plain text. [RichCardText] renders it properly
/// instead of dumping raw markup: HTML tags → HtmlWidget; otherwise MarkdownBody
/// (which also renders plain text). Use for full description blocks.
class RichCardText extends StatelessWidget {
  const RichCardText(this.text, {super.key, this.textStyle});

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final t = text.trim();
    if (t.isEmpty) return const SizedBox.shrink();
    if (_htmlTag.hasMatch(t)) {
      // HtmlWidget resolves well-formed entities itself, but not the
      // malformed `&233;` form the catalogue actually sends, so pre-decode.
      // Decoding is idempotent for anything already correct.
      return HtmlWidget(decodeHtmlEntities(t), textStyle: textStyle);
    }
    return MarkdownBody(
      data: decodeHtmlEntities(t),
      styleSheet: MarkdownStyleSheet(
        p: textStyle,
        pPadding: EdgeInsets.zero,
      ),
    );
  }
}

/// Flattens HTML/markdown to plain text for the COMPACT one-line places (grid
/// tiles, search rows) where a full renderer would break the fixed layout — so a
/// `<span>Foo</span>` shows as "Foo", not the raw tag. Keeps the existing
/// maxLines/ellipsis Text widget intact.
String plainFromRichText(String input) {
  var s = decodeHtmlEntities(input.replaceAll(_htmlTag, ''));
  // Strip the most common markdown emphasis/heading/link syntax, keeping link text.
  s = s.replaceAllMapped(_mdSyntax, (m) => m.groupCount >= 1 && m.group(1) != null ? m.group(1)! : '');
  return s.replaceAll(RegExp(r'\s+'), ' ').trim();
}
