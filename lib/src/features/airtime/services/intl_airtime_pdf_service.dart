import 'dart:io';

import 'package:flutter/material.dart' show Rect;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

/// Payload for one INTERNATIONAL airtime receipt. Deliberately separate from
/// the domestic `AirtimeTransaction` shape: an intl purchase is a two-currency
/// event (sender pays X, recipient receives Y at an FX rate) plus destination
/// country/operator, and none of those belong on a domestic receipt.
class IntlAirtimeReceiptData {
  final String reference;
  final String paymentId;
  final double amountPaid;
  final String senderCurrency;
  final double deliveredAmount;
  final String deliveredCurrency;
  final double fxRateUsed;
  final String phoneNumber;
  final String operatorName;
  final String countryName;
  final bool isSuccess;
  final DateTime timestamp;

  const IntlAirtimeReceiptData({
    required this.reference,
    required this.paymentId,
    required this.amountPaid,
    required this.senderCurrency,
    required this.deliveredAmount,
    required this.deliveredCurrency,
    required this.fxRateUsed,
    required this.phoneNumber,
    required this.operatorName,
    required this.countryName,
    required this.isSuccess,
    required this.timestamp,
  });

  String get displayReference => reference.isNotEmpty ? reference : paymentId;
}

/// Generates / downloads / shares the international-airtime PDF receipt.
///
/// ASCII-ONLY by construction: the embedded Inter font is fetched at runtime
/// and silently falls back to the built-in Helvetica when offline, which
/// cannot render currency glyphs (NGN naira sign) or arrows — they rasterise
/// as blank boxes. Every amount therefore prints as an ISO code plus digits
/// ("NGN 1,500.00"), and no arrow/approximation glyph is ever emitted.
class IntlAirtimePdfService {
  static final DateFormat _displayDateFormat =
      DateFormat('MMM dd, yyyy • hh:mm a');
  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Strips anything outside printable ASCII so a provider-supplied operator
  /// or country name can never inject an unrenderable glyph into the PDF.
  static String _ascii(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^\x20-\x7E]'), '').trim();
    return cleaned;
  }

  static String _money(String currency, double amount) =>
      '${_ascii(currency).toUpperCase()} ${_moneyFormat.format(amount)}';

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;
    try {
      final regular = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final bold = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));
      if (regular.statusCode == 200 && bold.statusCode == 200) {
        _regularFont = pw.Font.ttf(regular.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(bold.bodyBytes.buffer.asByteData());
      }
    } catch (_) {
      _regularFont = null;
      _boldFont = null;
    }
  }

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final bytes = await rootBundle.load('assets/images/lazervault_logo.png');
      return pw.MemoryImage(bytes.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  static pw.TextStyle _style({
    double fontSize = 11,
    bool isBold = false,
    PdfColor? color,
  }) =>
      pw.TextStyle(
        font: isBold ? _boldFont : _regularFont,
        fontBold: _boldFont,
        fontSize: fontSize,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: color,
      );

  static pw.Widget _row(String label, String value, {bool isBold = false}) =>
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(_ascii(label),
                style: _style(color: const PdfColor.fromInt(0xFF64748B))),
            pw.SizedBox(width: 24),
            pw.Expanded(
              child: pw.Text(
                _ascii(value),
                textAlign: pw.TextAlign.right,
                style: _style(isBold: isBold),
              ),
            ),
          ],
        ),
      );

  /// Renders the receipt to a temp-file PDF.
  static Future<File> generateReceipt(IntlAirtimeReceiptData data) async {
    await _loadFonts();
    final logo = await _loadLogo();
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (logo != null)
                  pw.Image(logo, width: 120)
                else
                  pw.Text('LazerVault', style: _style(fontSize: 20, isBold: true)),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('International Airtime Receipt',
                        style: _style(fontSize: 13, isBold: true)),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Generated ${_ascii(_displayDateFormat.format(DateTime.now()))}',
                      style: _style(
                          fontSize: 9,
                          color: const PdfColor.fromInt(0xFF94A3B8)),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 24),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: data.isSuccess
                    ? const PdfColor.fromInt(0xFFDCFCE7)
                    : const PdfColor.fromInt(0xFFFEE2E2),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Center(
                child: pw.Text(
                  data.isSuccess ? 'AIRTIME DELIVERED' : 'PAYMENT FAILED',
                  style: _style(
                    fontSize: 13,
                    isBold: true,
                    color: data.isSuccess
                        ? const PdfColor.fromInt(0xFF166534)
                        : const PdfColor.fromInt(0xFF991B1B),
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(18),
              decoration: pw.BoxDecoration(
                color: const PdfColor.fromInt(0xFFF8FAFC),
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: const PdfColor.fromInt(0xFFE2E8F0)),
              ),
              child: pw.Column(
                children: [
                  pw.Text('You Paid',
                      style: _style(
                          fontSize: 10,
                          color: const PdfColor.fromInt(0xFF64748B))),
                  pw.SizedBox(height: 4),
                  pw.Text(_money(data.senderCurrency, data.amountPaid),
                      style: _style(fontSize: 22, isBold: true)),
                  if (data.deliveredAmount > 0 &&
                      data.deliveredCurrency.isNotEmpty) ...[
                    pw.SizedBox(height: 10),
                    pw.Text('Recipient Received',
                        style: _style(
                            fontSize: 10,
                            color: const PdfColor.fromInt(0xFF64748B))),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      _money(data.deliveredCurrency, data.deliveredAmount),
                      style: _style(
                          fontSize: 16,
                          isBold: true,
                          color: const PdfColor.fromInt(0xFF166534)),
                    ),
                  ],
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Transaction Details',
                style: _style(fontSize: 13, isBold: true)),
            pw.SizedBox(height: 8),
            pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
            if (data.phoneNumber.isNotEmpty)
              _row('Recipient', data.phoneNumber, isBold: true),
            if (data.operatorName.isNotEmpty) _row('Network', data.operatorName),
            if (data.countryName.isNotEmpty)
              _row('Destination', data.countryName),
            if (data.fxRateUsed > 0 && data.deliveredCurrency.isNotEmpty)
              _row(
                'Exchange Rate',
                '1 ${_ascii(data.deliveredCurrency).toUpperCase()} = '
                    '${data.fxRateUsed.toStringAsFixed(4)} '
                    '${_ascii(data.senderCurrency).toUpperCase()}',
              ),
            _row('Reference', data.displayReference),
            _row('Date', _displayDateFormat.format(data.timestamp.toLocal())),
            _row('Status', data.isSuccess ? 'Completed' : 'Failed',
                isBold: true),
            pw.Spacer(),
            pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
            pw.SizedBox(height: 6),
            pw.Center(
              child: pw.Text(
                'This is a computer-generated receipt from LazerVault.',
                style: _style(
                    fontSize: 9, color: const PdfColor.fromInt(0xFF94A3B8)),
              ),
            ),
          ],
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final safeRef =
        data.displayReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${dir.path}/intl_airtime_receipt_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Saves the PDF to a user-accessible directory and returns its path.
  static Future<String> downloadReceipt(IntlAirtimeReceiptData data) async {
    final generated = await generateReceipt(data);
    Directory? directory;
    if (Platform.isAndroid) {
      // App-specific external dir: always writable, no runtime permission.
      // Writing straight to /storage/emulated/0/Download fails on API 30+.
      directory = (await getExternalStorageDirectory()) ??
          await getApplicationDocumentsDirectory();
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getDownloadsDirectory();
    }
    if (directory == null) {
      throw Exception('Could not access a downloads directory');
    }
    final safeRef =
        data.displayReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final saved = File('${directory.path}/intl_airtime_receipt_$safeRef.pdf');
    await generated.copy(saved.path);
    return saved.path;
  }

  /// Shares the PDF through the system sheet. The accompanying text is ASCII
  /// so it survives SMS/WhatsApp transcoding intact.
  static Future<void> shareReceipt(IntlAirtimeReceiptData data) async {
    final file = await generateReceipt(data);
    final destination = data.countryName.isNotEmpty
        ? ' (${_ascii(data.countryName)})'
        : '';
    await SharePlus.instance.share(ShareParams(
      // iOS requires a non-zero popover anchor — CGRectZero throws.
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      files: [XFile(file.path)],
      text: 'International airtime receipt: '
          '${_money(data.senderCurrency, data.amountPaid)} to '
          '${_ascii(data.phoneNumber)}$destination. '
          'Ref ${_ascii(data.displayReference)}',
      subject: 'LazerVault International Airtime Receipt',
    ));
  }
}
