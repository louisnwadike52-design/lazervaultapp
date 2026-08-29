import '../presentation/view/widgets/rich_card_text.dart' show decodeHtmlEntities;

/// Preparing provider prose for a receipt.
///
/// Gift-card text arrives as HTML from the provider — Prestmit sends card
/// descriptions and redemption instructions as fragments, with entities that
/// are frequently malformed ("&10;" for a newline rather than "&#10;"). The
/// catalogue decodes this at render time, but the receipt never did, so a
/// downloaded PDF printed the raw markup back at the customer.
///
/// Entity decoding is NOT duplicated here — [decodeHtmlEntities] is the single
/// implementation, shared with the catalogue, so the two surfaces can never
/// disagree about what a card says.
///
/// What is different here is the whitespace. plainFromRichText collapses every
/// run of whitespace into one space, which is right for a one-line grid tile
/// and wrong for a receipt: redemption instructions are a numbered list, and
/// flattening them into a paragraph is how a customer loses their place halfway
/// through redeeming a card. So block-level markup becomes a line break instead
/// of vanishing.

/// A RUN of block-level tags, which together end one line of prose.
///
/// Matching the run rather than each tag is what keeps a list readable. Tags
/// come in pairs, so an item boundary is "</li><li>" — two tags, one break.
/// Replacing them individually put a blank line between every step of a
/// redemption instruction list, which is exactly the formatting a customer
/// following the steps does not need.
///
/// Real paragraph breaks are not lost by this: they survive as actual newlines
/// in the text (Prestmit sends them as the entity "&10;&10;"), which is decoded
/// before this runs and collapsed no further than a single blank line.
final RegExp _blockTagRun = RegExp(
  r'(?:\s*</?(?:br|p|div|li|ul|ol|tr|h[1-6])\b[^>]*>\s*)+',
  caseSensitive: false,
);

/// Any remaining inline tag (<b>, <span>, …), which contributes no line break.
final RegExp _inlineTag = RegExp(r'<[^>]+>');

/// Spaces and tabs, but NOT newlines — so line structure survives the collapse.
final RegExp _horizontalSpace = RegExp(r'[ \t ]+');

/// Three or more newlines: real paragraph breaks are kept, run-on gaps are not.
final RegExp _blankLineRun = RegExp(r'\n{3,}');

/// receiptProse renders multi-line provider prose (redemption instructions,
/// card terms) as plain text with its line structure intact.
String receiptProse(String raw) {
  if (raw.trim().isEmpty) return '';
  var s = decodeHtmlEntities(raw);
  s = s.replaceAll(_blockTagRun, '\n');
  s = s.replaceAll(_inlineTag, '');
  // Decode first, THEN collapse: "&10;" only becomes a newline above, and a
  // collapse done before decoding would leave it as literal text.
  s = s.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  s = s
      .split('\n')
      .map((line) => line.replaceAll(_horizontalSpace, ' ').trim())
      .join('\n');
  return s.replaceAll(_blankLineRun, '\n\n').trim();
}

/// receiptLine renders a single-line value (brand name, recipient name) — the
/// same decoding, with every line break flattened because it has to fit one row.
String receiptLine(String raw) {
  final s = receiptProse(raw).replaceAll('\n', ' ');
  return s.replaceAll(_horizontalSpace, ' ').trim();
}

/// Characters a customer's text realistically carries that have no glyph in a
/// PDF's built-in Helvetica, mapped to something that does.
///
/// The typographic forms are the ones that actually appear: providers write
/// curly apostrophes and en-dashes in their instructions, and the naira sign is
/// ours.
const Map<String, String> _asciiSubstitutes = {
  '‘': "'", '’': "'", '‚': "'", '‛': "'",
  '“': '"', '”': '"', '„': '"',
  '–': '-', '—': '-', '−': '-', '‐': '-', '‑': '-',
  '…': '...',
  ' ': ' ', ' ': ' ', ' ': ' ', '​': '',
  '•': '-', '·': '-', '●': '-', '▪': '-',
  '₦': 'NGN', // naira
  '₹': 'INR', '€': 'EUR', '£': 'GBP', '¥': 'JPY',
  '™': '(TM)', '®': '(R)', '©': '(C)',
  '×': 'x', '→': '->', '✓': 'v', '✔': 'v',
};

/// pdfSafe guarantees a string can be drawn even when no TrueType font was
/// embedded.
///
/// The PDF package draws with a built-in Helvetica when no font is supplied,
/// and Helvetica cannot draw a character outside its own encoding — it does not
/// substitute, it raises. One curly apostrophe in a provider's redemption
/// instructions is therefore enough to fail the whole receipt, and the customer
/// sees "Share failed" with no way to get their card details out.
///
/// Applied ONLY when the embedded font is missing. With Inter loaded the text
/// goes through untouched, so a normal receipt keeps its real typography and
/// this is purely the safety net under it.
String pdfSafe(String s) {
  if (s.isEmpty) return s;
  final out = StringBuffer();
  for (final rune in s.runes) {
    final ch = String.fromCharCode(rune);
    final sub = _asciiSubstitutes[ch];
    if (sub != null) {
      out.write(sub);
      continue;
    }
    // Latin-1 is the safe floor for the built-in fonts; anything above it is
    // dropped rather than guessed at, and dropping beats raising.
    if (rune == 0x0A || (rune >= 0x20 && rune <= 0xFF)) {
      out.write(ch);
    }
  }
  return out.toString();
}
