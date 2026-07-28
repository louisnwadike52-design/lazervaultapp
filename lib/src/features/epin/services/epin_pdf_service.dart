import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/epin_entities.dart';

/// Renders / shares a recharge-card (ePIN) order as the classic Nigerian
/// recharge-card printout: a LANDSCAPE grid of small cards (4 per row), each
/// showing the merchant (vendor) + network, denomination + index, the PIN,
/// serial, date and the dial / customer-care line — the exact format a print
/// shop hands out so the cards can be cut along the grid and sold.
///
/// Every field is populated only when its data exists; missing values are left
/// out entirely rather than printing a placeholder.
class EPinPdfService {
  static final _displayDateFormat = DateFormat('dd-MM-yy hh:mm a');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;
  static pw.MemoryImage? _logo;

  static Future<pw.MemoryImage?> _loadLogo() async {
    if (_logo != null) return _logo;
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      _logo = pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {
      _logo = null;
    }
    return _logo;
  }

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;
    try {
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));
      if (regularResponse.statusCode == 200 && boldResponse.statusCode == 200) {
        _regularFont =
            pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (_) {
      _regularFont = null;
      _boldFont = null;
    }
  }

  static pw.TextStyle _style({
    double fontSize = 7,
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

  /// Per-network branding + recharge details for the card footer.
  static _NetStyle _net(String network) {
    final n = network.toLowerCase();
    if (n.contains('mtn')) {
      return const _NetStyle('MTN', PdfColor.fromInt(0xFFFFCC00),
          PdfColor.fromInt(0xFF1A1A1A), '*311*(PIN)#', '180');
    }
    if (n.contains('airtel')) {
      return const _NetStyle('Airtel', PdfColor.fromInt(0xFFED1C24),
          PdfColors.white, '*126*(PIN)#', '111');
    }
    if (n.contains('glo')) {
      return const _NetStyle('Glo', PdfColor.fromInt(0xFF00A651),
          PdfColors.white, '*123*(PIN)#', '121');
    }
    if (n.contains('9mobile') || n.contains('etisalat') || n.contains('9 mobile')) {
      return const _NetStyle('9mobile', PdfColor.fromInt(0xFF006F45),
          PdfColors.white, '*222*(PIN)#', '200');
    }
    return _NetStyle(network, const PdfColor.fromInt(0xFF4E03D0),
        PdfColors.white, '*(PIN)#', '');
  }

  static String _indexRef(String reference, int i) {
    final tail = reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    if (tail.isEmpty) return '${i + 1}';
    final short = tail.length <= 5 ? tail : tail.substring(tail.length - 5);
    return '$short-${i + 1}';
  }

  static String _denomLabel(EPinOrder order) =>
      order.denomination > 0 ? '#${order.denomination.toStringAsFixed(0)}' : '';

  static Future<File> generateReceipt({
    required EPinOrder order,
    String vendorName = '',
  }) async {
    final pdf = await _buildDocument(order: order, vendorName: vendorName);
    final dir = await getTemporaryDirectory();
    final safeRef = order.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${dir.path}/recharge_cards_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Raw PDF bytes — used by the native print dialog (Printing.layoutPdf) so
  /// multi-card orders print across as many landscape pages as needed.
  static Future<Uint8List> receiptBytes({
    required EPinOrder order,
    String vendorName = '',
  }) async {
    final pdf = await _buildDocument(order: order, vendorName: vendorName);
    return pdf.save();
  }

  static Future<pw.Document> _buildDocument({
    required EPinOrder order,
    String vendorName = '',
  }) async {
    await _loadFonts();
    final logo = await _loadLogo();
    final pdf = pw.Document();

    final parsed = DateTime.tryParse(order.createdAt);
    final date = parsed != null ? _displayDateFormat.format(parsed.toLocal()) : '';
    final hasNetwork = order.network.trim().isNotEmpty;
    final net = _net(order.network);
    final denom = _denomLabel(order);
    final vendor = vendorName.trim();

    // Only cards that actually carry a PIN get printed.
    final cards = order.cards.where((c) => c.hasPin).toList();

    final cardWidgets = <pw.Widget>[
      for (var i = 0; i < cards.length; i++)
        _rechargeCard(
          card: cards[i],
          vendor: vendor,
          net: net,
          hasNetwork: hasNetwork,
          denom: denom,
          index: _indexRef(order.reference, i),
          date: date,
        ),
    ];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(16),
        build: (context) => [
          _header(order, vendor, date, logo),
          pw.SizedBox(height: 10),
          if (cardWidgets.isEmpty)
            pw.Text(
              'PINs are being generated. Re-open this order shortly to print the cards.',
              style: _style(fontSize: 11, color: const PdfColor.fromInt(0xFF64748B)),
            )
          else
            // Equal-width cards in an adaptive column count (fewer columns →
            // bigger cards for small orders). MultiPage paginates BETWEEN rows,
            // so any card count flows onto as many landscape pages as needed.
            ..._rows(cardWidgets),
        ],
      ),
    );

    return pdf;
  }

  /// Columns per row, chosen so cards stay big + legible for small orders and
  /// never get too tiny for large ones:
  ///   1–2 cards → they fill the row (1 or 2 across, each large)
  ///   3–9 cards → 3 across (comfortably readable)
  ///   10+ cards → 4 across (the max — beyond this cards become too small)
  static int _columnsFor(int n) {
    if (n <= 2) return n;
    if (n <= 9) return 3;
    return 4;
  }

  /// Groups cards into equal-width rows and paginates between them (pw.MultiPage
  /// splits BETWEEN rows; pw.Wrap can't). Cards are Expanded so they always fill
  /// the row width, and short final rows are padded with empty cells so every
  /// card keeps the SAME width as a full row (a lone leftover card never
  /// stretches across the page).
  static List<pw.Widget> _rows(List<pw.Widget> cards) {
    final perRow = _columnsFor(cards.length);
    final rows = <pw.Widget>[];
    for (var i = 0; i < cards.length; i += perRow) {
      final end = (i + perRow) > cards.length ? cards.length : (i + perRow);
      final slice = cards.sublist(i, end);
      rows.add(pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 8),
        // start (not stretch): MultiPage gives the row unbounded height, and
        // CrossAxisAlignment.stretch under an unbounded cross-axis makes the
        // pdf layout engine throw — which surfaced as "Could not print/share".
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            for (var j = 0; j < perRow; j++) ...[
              if (j > 0) pw.SizedBox(width: 8),
              pw.Expanded(
                child: j < slice.length ? slice[j] : pw.SizedBox(),
              ),
            ],
          ],
        ),
      ));
    }
    return rows;
  }

  /// A single recharge card cell — mirrors the print-shop layout. Fields with
  /// no data are simply omitted.
  static pw.Widget _rechargeCard({
    required EPinCard card,
    required String vendor,
    required _NetStyle net,
    required bool hasNetwork,
    required String denom,
    required String index,
    required String date,
  }) {
    final metaLine = [
      if (denom.isNotEmpty) denom,
      if (index.isNotEmpty) 'Index: $index',
    ].join(' | ');
    final serial = card.serial.trim();

    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFFCFCFC),
        border: pw.Border.all(color: const PdfColor.fromInt(0xFF9AA0A6), width: 1),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          // Vendor (merchant business name) + network badge — only when present.
          if (vendor.isNotEmpty || hasNetwork) ...[
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Expanded(
                  child: pw.Text(vendor, style: _style(fontSize: 9, isBold: true)),
                ),
                if (hasNetwork)
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                    decoration: pw.BoxDecoration(
                      color: net.color,
                      borderRadius: pw.BorderRadius.circular(3),
                    ),
                    child: pw.Text(net.label,
                        style: _style(fontSize: 7.5, isBold: true, color: net.onColor)),
                  ),
              ],
            ),
            pw.SizedBox(height: 5),
          ],
          if (metaLine.isNotEmpty) ...[
            pw.Text(metaLine,
                style: _style(fontSize: 8, color: const PdfColor.fromInt(0xFF444444))),
            pw.SizedBox(height: 5),
          ],
          pw.Text('PIN: ${card.pin}', style: _style(fontSize: 13, isBold: true)),
          if (serial.isNotEmpty) ...[
            pw.SizedBox(height: 3),
            pw.Text('S/N: $serial',
                style: _style(fontSize: 8, color: const PdfColor.fromInt(0xFF444444))),
          ],
          if (date.isNotEmpty)
            pw.Text('Date: $date',
                style: _style(fontSize: 8, color: const PdfColor.fromInt(0xFF444444))),
          pw.SizedBox(height: 6),
          pw.Divider(height: 0.5, color: const PdfColor.fromInt(0xFFD9D9D9)),
          pw.SizedBox(height: 3),
          pw.Text(
            net.care.isNotEmpty
                ? 'Dial ${net.dial} | Customer care: ${net.care}'
                : 'Dial ${net.dial}',
            style: _style(fontSize: 7, color: const PdfColor.fromInt(0xFF8A8A8A)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _header(
      EPinOrder order, String vendor, String date, pw.MemoryImage? logo) {
    final printed = order.cards.where((c) => c.hasPin).length;
    final denom = _denomLabel(order);
    final subtitle = [
      if (order.network.trim().isNotEmpty) order.network,
      if (denom.isNotEmpty) denom,
      '$printed card${printed == 1 ? '' : 's'}',
    ].join('  ·  ');
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            if (logo != null) ...[
              pw.Image(logo, height: 26),
              pw.SizedBox(width: 10),
            ],
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(vendor.isNotEmpty ? vendor : 'Recharge Cards',
                    style: _style(fontSize: 13, isBold: true)),
                pw.Text(subtitle,
                    style:
                        _style(fontSize: 8, color: const PdfColor.fromInt(0xFF64748B))),
              ],
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            if (order.reference.trim().isNotEmpty)
              pw.Text('Ref: ${order.reference}',
                  style: _style(fontSize: 8, color: const PdfColor.fromInt(0xFF64748B))),
            if (date.isNotEmpty)
              pw.Text(date,
                  style: _style(fontSize: 8, color: const PdfColor.fromInt(0xFF94A3B8))),
          ],
        ),
      ],
    );
  }

  /// Save the print-ready PDF to a writable, app-owned directory and return the
  /// path. The old direct write to `/storage/emulated/0/Download` fails under
  /// Android scoped storage (API 30+) → "Could not save the cards"; the app
  /// documents / external-files dir is always writable without a permission.
  static Future<String> downloadReceipt({
    required EPinOrder order,
    String vendorName = '',
  }) async {
    final pdf = await _buildDocument(order: order, vendorName: vendorName);
    Directory directory;
    if (Platform.isAndroid) {
      // App-specific external files dir (no permission needed, visible in
      // the device file manager under Android/data/<pkg>/files). Falls back
      // to app documents if unavailable.
      directory = (await getExternalStorageDirectory()) ??
          await getApplicationDocumentsDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final safeRef = order.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final savedFile = File('${directory.path}/recharge_cards_$safeRef.pdf');
    await savedFile.writeAsBytes(await pdf.save());
    return savedFile.path;
  }

  /// Open the native print dialog with the recharge-card sheet. Works for any
  /// number of cards (the PDF is a MultiPage landscape grid). This is what the
  /// "Print cards" button should do — actually print, not just share.
  static Future<void> printReceipt({
    required EPinOrder order,
    String vendorName = '',
  }) async {
    final bytes = await receiptBytes(order: order, vendorName: vendorName);
    final safeRef = order.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    await Printing.layoutPdf(
      name: 'recharge_cards_$safeRef',
      onLayout: (_) async => bytes,
    );
  }

  static Future<void> shareReceipt({
    required EPinOrder order,
    String vendorName = '',
  }) async {
    final file = await generateReceipt(order: order, vendorName: vendorName);
    final denom = _denomLabel(order);
    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text:
          'Recharge cards ${order.reference} — ${order.quantity}${denom.isNotEmpty ? ' x $denom' : ''}${order.network.trim().isNotEmpty ? ' (${order.network})' : ''}',
      subject: 'Lazervault Recharge Cards',
    ));
  }
}

/// Per-network branding used on each printed card.
class _NetStyle {
  const _NetStyle(this.label, this.color, this.onColor, this.dial, this.care);
  final String label;
  final PdfColor color;
  final PdfColor onColor;
  final String dial;
  final String care;
}
