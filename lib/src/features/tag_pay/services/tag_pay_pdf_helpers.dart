// PART OF tag_pay_pdf_service.dart (safe decomposition 2026-09-07):
// private members moved VERBATIM out of the TagPayPdfService class as
// library-private top-level declarations. Unqualified call sites inside the
// class resolve identically (class scope falls through to library scope), so
// this is a pure relocation — no behavior change.
part of 'tag_pay_pdf_service.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');

final _displayDateFormat = DateFormat('MMM dd, yyyy');

final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

/// Money is grouped for READING. `toStringAsFixed(2)` alone rendered
/// "₦1500000.00" — a figure a customer has to count digits on to trust.
/// Display only: every amount used for arithmetic stays a double.
final _amountFormat = NumberFormat('#,##0.00');

// Cache for loaded fonts
pw.Font? _regularFont;

pw.Font? _boldFont;

/// Currency symbol for the PDF. With Inter embedded we render the REAL
/// symbol (₦, £, €, ₹…) so the document matches the on-screen receipt, which
/// has always shown ₦; the blanket ASCII codes here were a leftover from the
/// CDN-only font era and printed "NGN 1500.00" against an on-screen
/// "₦1,500.00" for the same transaction. Without an embedded TrueType font
/// the built-in PDF font cannot draw those glyphs and the pdf package RAISES
/// rather than substituting, so the ASCII code remains the fallback.
String _currencySymbolFor(String code) {
  if (ReceiptFonts.embedded) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'ZAR':
        return 'R';
      case 'CAD':
        return r'CA$';
      case 'AUD':
        return r'A$';
      case 'INR':
        return '₹';
      case 'JPY':
        return '¥';
      case 'USD':
        return r'$';
      default:
        return '$code ';
    }
  }
  switch (code.toUpperCase()) {
    case 'NGN':
      return 'NGN ';
    case 'GBP':
      return 'GBP ';
    case 'EUR':
      return 'EUR ';
    case 'USD':
      return 'USD ';
    case 'ZAR':
      return 'ZAR ';
    case 'CAD':
      return 'CAD ';
    case 'AUD':
      return 'AUD ';
    case 'INR':
      return 'INR ';
    case 'JPY':
      return 'JPY ';
    default:
      return '$code ';
  }
}

/// Get display currency name
String _currencyNameFor(String code) {
  switch (code.toUpperCase()) {
    case 'NGN':
      return 'Nigerian Naira';
    case 'GBP':
      return 'British Pound';
    case 'EUR':
      return 'Euro';
    case 'USD':
      return 'US Dollar';
    case 'ZAR':
      return 'South African Rand';
    default:
      return code;
  }
}

Future<pw.MemoryImage?> _loadLogo() async {
  try {
    final data = await rootBundle.load('assets/images/logo.png');
    return pw.MemoryImage(data.buffer.asUint8List());
  } catch (e) {
    return null;
  }
}

/// Load fonts that support unicode characters (₦, —, etc). BUNDLED Inter is
/// the primary source — receipts must render correctly offline and instantly.
/// The old CDN-only fetch was version-pinned and started 404ing when Google
/// rotated the URL, silently degrading every receipt to Helvetica (no ₦
/// glyph) after an unbounded network wait that made Share look frozen.
/// This file's loader was the one that got it right, so it became the shared
/// [ReceiptFonts] — bundled asset first, bounded CDN fetch as a last resort.
Future<void> _loadFonts() async {
  await ReceiptFonts.load();
  _regularFont = ReceiptFonts.regular;
  _boldFont = ReceiptFonts.bold;
}

/// Get text style with proper font
pw.TextStyle _getTextStyle({
  double fontSize = 12,
  bool isBold = false,
  PdfColor? color,
}) {
  return pw.TextStyle(
    font: isBold ? _boldFont : _regularFont,
    fontBold: _boldFont,
    fontSize: fontSize,
    fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
    color: color,
  );
}

/// Sanitise a string for the PDF font. The masked-account bullet `•`
/// (U+2022) is above Latin-1 and is missing from the built-in Helvetica the
/// PDF falls back to when the remote Inter subset can't be fetched — it renders
/// as a tofu box (▨). Swap it for the Latin-1 middle dot `·` (U+00B7), which is
/// covered by every font path and keeps the "•••• 1234" masked look.
String? _pdfSafe(String? s) => s == null ? null : _pdfSafeText(s);

/// Non-nullable form of [_pdfSafe]. The tag entities expose plain (never
/// null) Strings for names/tags/descriptions, and those went into the tag
/// generators completely unsanitised while the transfer/crypto generators
/// sanitised everything — same font, same failure mode, only tag receipts
/// were exposed to it.
String _pdfSafeText(String s) => s.replaceAll('•', '·');

/// First non-empty value in [candidates], trimmed, or null.
///
/// Receipt metadata has three producers with three key spellings: the
/// realtime send-funds flow writes `Beneficiary Name`/`From`, the
/// transaction-history mapper writes snake_case (`recipient_name`,
/// `sender_name`, `bank_name`), and older map-based callers write camelCase.
/// A lookup that knows only one spelling silently finds nothing.
String? _firstNonEmpty(List<Object?> candidates) {
  for (final candidate in candidates) {
    final value = candidate?.toString().trim();
    if (value != null && value.isNotEmpty) return value;
  }
  return null;
}

/// True when the value is a TagPay HANDLE rather than an account number.
///
/// [_buildRecipientDetails] takes one "tag" slot that carries a handle for
/// tag flows and a (possibly masked) BANK ACCOUNT NUMBER for fund transfers.
/// Prefixing it unconditionally printed "Tag: @0123456789" on every bank
/// transfer receipt, so the shape of the value decides: masked accounts
/// arrive as "···· 1234" / "****1234", i.e. digits and masking punctuation
/// only — anything containing a letter is a real handle.
bool _isTagHandle(String value) =>
    !RegExp(r'^[\d\s·•*.\-]+$').hasMatch(value.trim());

pw.Widget _buildSummaryRow(String label, String value) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 4),
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
      ),
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
        pw.Text(
          value,
          style: _getTextStyle(fontSize: 11),
        ),
      ],
    ),
  );
}

/// Clean a transfer reference for display: drop a redundant "_transfer" /
/// "-transfer" suffix. The id already carries a "TRF" prefix, so leaving the
/// suffix would say "transfer" twice (e.g. "TRF-abc_transfer").
String _cleanTransferRef(String ref) {
  var r = ref.trim();
  for (final suffix in const ['_transfer', '-transfer', ' transfer']) {
    if (r.toLowerCase().endsWith(suffix)) {
      r = r.substring(0, r.length - suffix.length).trim();
      break;
    }
  }
  return r;
}

pw.Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 6),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 130,
          child: pw.Text(
            label,
            style: _getTextStyle(fontSize: 11, isBold: true)
                .copyWith(color: PdfColors.grey700),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: _getTextStyle(fontSize: 11, isBold: isBold),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildFooter({String transactionType = 'Tagpay transfer'}) {
  return pw.Column(
    children: [
      pw.Divider(color: PdfColors.grey300),
      pw.SizedBox(height: 12),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Need help?',
                style: _getTextStyle(fontSize: 10, isBold: true),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Get help directly in-app',
                style: _getTextStyle(fontSize: 9, color: PdfColors.grey600),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                '(C) ${DateTime.now().year} Lazervault Technologies Ltd',
                style: _getTextStyle(fontSize: 9, color: PdfColors.grey600),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                'Page 1 of 1',
                style: _getTextStyle(fontSize: 9, color: PdfColors.grey500),
              ),
            ],
          ),
        ],
      ),
      pw.SizedBox(height: 8),
      pw.Container(
        padding: const pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          color: PdfColors.grey100,
          borderRadius: pw.BorderRadius.circular(4),
        ),
        child: pw.Text(
          'Lazervault Technologies Ltd is a financial technology company. '
          'This document is a confirmation of a $transactionType processed through the Lazervault platform. '
          'For any queries regarding this transaction, please contact support through the Lazervault app.',
          style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
          textAlign: pw.TextAlign.justify,
        ),
      ),
    ],
  );
}

/// Title-cased form of the entity's single status source.
///
/// Was `tag.isPaid ? 'Paid' : (tag.isCancelled ? 'Cancelled' : 'Pending')`,
/// which printed "Pending" on the invoice of a tag that had in fact been
/// declined, expired, or was mid-transfer — a PDF the customer could keep as
/// evidence of a debt that no longer existed.
String _tagStatusLabel(UserTagEntity tag) {
  final label = tag.statusLabel;
  return label[0] + label.substring(1).toLowerCase();
}

/// Rasterise page 1 of a generated receipt PDF to a PNG/JPG file. Reuses the
/// exact PDF layout, so the image is a pixel-faithful copy of the document.
Future<File> _rasterizeReceipt({
  required File pdfFile,
  required ReceiptFileFormat format,
  required String baseName,
}) async {
  final pdfBytes = await pdfFile.readAsBytes();
  // 200 dpi = crisp on-screen + printable without a huge file.
  final raster = await Printing.raster(pdfBytes, pages: [0], dpi: 200).first;

  // Decode the raster ONCE, correctly, for both image formats.
  //
  // Two things were wrong here and both produced visibly broken files:
  //
  // 1. `raster.pixels.buffer` throws away the view's offset. A Uint8List is a
  //    WINDOW onto a ByteBuffer, and .buffer hands back the whole underlying
  //    buffer ignoring offsetInBytes/lengthInBytes. Whenever that window did
  //    not start at byte 0 the image decoded from the wrong origin, which is
  //    why the exported picture came out skewed/garbled.
  //
  // 2. The old comment claimed the background was "already white". It is not:
  //    a rasterised PDF page carries an ALPHA channel, and the receipt card
  //    sits on transparent pixels. JPG has no alpha, so encoding dropped it
  //    and those pixels rendered BLACK; PNG kept them transparent, which
  //    viewers show as black or a checkerboard. Both formats are now
  //    composited onto opaque white first, so what is saved is what is seen.
  // Copy into a fresh list so the ByteBuffer handed to the decoder starts at
  // byte 0. Taking .buffer off a view would re-introduce the very offset this
  // is correcting, since .buffer always returns the whole underlying buffer.
  final rgba = Uint8List.fromList(raster.pixels);
  final decoded = img.Image.fromBytes(
    width: raster.width,
    height: raster.height,
    bytes: rgba.buffer,
    numChannels: 4,
    order: img.ChannelOrder.rgba,
  );
  final flattened = img.Image(width: raster.width, height: raster.height)
    ..clear(img.ColorRgb8(255, 255, 255));
  img.compositeImage(flattened, decoded);

  final Uint8List bytes = format == ReceiptFileFormat.jpg
      ? img.encodeJpg(flattened, quality: 92)
      : img.encodePng(flattened);
  final out = await getTemporaryDirectory();
  final file = File('${out.path}/$baseName.${format.ext}');
  await file.writeAsBytes(bytes);
  return file;
}

String _formatTransferStatus(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
    case 'success':
      return 'Completed';
    case 'pending':
    case 'processing':
      return 'Pending';
    case 'failed':
      return 'Failed';
    case 'scheduled':
      return 'Scheduled';
    default:
      return status;
  }
}
