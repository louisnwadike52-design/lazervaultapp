import 'dart:io';

import 'package:flutter/material.dart' show Rect;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

/// Payload for one INTERNATIONAL data receipt.
///
/// Kept separate from the domestic purchase shape for the same reason the
/// international airtime receipt is: a cross-border purchase is a two-currency
/// event (the sender pays X, the recipient's line receives a bundle worth Y at
/// an FX rate) plus a destination country and operator. None of that belongs on
/// a domestic receipt, and a domestic receipt cannot render it — which is why
/// international rows previously produced a naira receipt with a "Nigerian
/// Naira" line for a bundle bought in another currency.
class IntlDataReceiptData {
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
  final String bundleDescription;
  final bool isSuccess;
  final DateTime timestamp;

  const IntlDataReceiptData({
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
    required this.bundleDescription,
    required this.isSuccess,
    required this.timestamp,
  });

  String get displayReference => reference.isNotEmpty ? reference : paymentId;
}

/// Generates / downloads / shares the international-data PDF receipt.
///
/// ASCII-ONLY by construction. The embedded font is fetched at runtime and
/// falls back to the built-in Helvetica when that fails; that fallback
/// latin1-encodes every string and THROWS on any code unit above 255. Provider
/// data reaches this receipt verbatim — operator and country names, bundle
/// descriptions — so every value is sanitised and amounts print as an ISO code
/// plus digits ("GHS 25.00") rather than a currency glyph.
class IntlDataPdfService {
  static final DateFormat _displayDateFormat =
      DateFormat('MMM dd, yyyy - hh:mm a');
  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Strips anything outside printable ASCII so a provider-supplied name can
  /// never inject an unrenderable glyph.
  static String _ascii(String input) =>
      input.replaceAll(RegExp(r'[^\x20-\x7E]'), '').trim();

  static String _money(String currency, double amount) =>
      '${_ascii(currency).toUpperCase()} ${_moneyFormat.format(amount)}';

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;
    try {
      final regular = await rootBundle.load('assets/fonts/Inter-Regular.ttf');
      final bold = await rootBundle.load('assets/fonts/Inter-Bold.ttf');
      _regularFont = pw.Font.ttf(regular);
      _boldFont = pw.Font.ttf(bold);
    } catch (_) {
      // Fall back to the built-in faces. Every string is ASCII-sanitised, so
      // the fallback renders correctly rather than throwing.
      _regularFont = null;
      _boldFont = null;
    }
  }

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final bytes = await rootBundle.load('assets/images/logo.png');
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
  static Future<File> generateReceipt(IntlDataReceiptData data) async {
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
                  pw.Text('LazerVault',
                      style: _style(fontSize: 20, isBold: true)),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('International Data Receipt',
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
                    ? const PdfColor.fromInt(0xFFECFDF5)
                    : const PdfColor.fromInt(0xFFFEF2F2),
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Text(
                data.isSuccess ? 'Purchase successful' : 'Purchase failed',
                style: _style(
                  fontSize: 12,
                  isBold: true,
                  color: data.isSuccess
                      ? const PdfColor.fromInt(0xFF047857)
                      : const PdfColor.fromInt(0xFFB91C1C),
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            _row('Reference', data.displayReference),
            _row('Date', _displayDateFormat.format(data.timestamp)),
            pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
            _row('Recipient', data.phoneNumber),
            if (data.countryName.isNotEmpty) _row('Country', data.countryName),
            if (data.operatorName.isNotEmpty)
              _row('Operator', data.operatorName),
            if (data.bundleDescription.isNotEmpty)
              _row('Bundle', data.bundleDescription),
            pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
            _row('You paid', _money(data.senderCurrency, data.amountPaid),
                isBold: true),
            if (data.deliveredAmount > 0 && data.deliveredCurrency.isNotEmpty)
              _row('Value delivered',
                  _money(data.deliveredCurrency, data.deliveredAmount)),
            if (data.fxRateUsed > 0)
              _row('Exchange rate',
                  '1 ${_ascii(data.senderCurrency).toUpperCase()} = ${_moneyFormat.format(data.fxRateUsed)} ${_ascii(data.deliveredCurrency).toUpperCase()}'),
            pw.Spacer(),
            pw.Text(
              'Lazervault Technologies Ltd is a financial technology company. '
              'This document confirms an international data purchase processed '
              'through the Lazervault platform. For any queries, please contact '
              'support through the Lazervault app.',
              style: _style(
                  fontSize: 8, color: const PdfColor.fromInt(0xFF94A3B8)),
              textAlign: pw.TextAlign.justify,
            ),
          ],
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final safeRef =
        data.displayReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${dir.path}/intl_data_receipt_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Saves the receipt where the platform allows and opens it.
  static Future<String> downloadReceipt(IntlDataReceiptData data) async {
    final generated = await generateReceipt(data);
    final safeRef =
        data.displayReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return ReceiptDownload.saveAndOpen(
      source: generated,
      fileName: 'intl_data_receipt_$safeRef.pdf',
    );
  }

  /// Shares the PDF through the system sheet. The accompanying text is ASCII
  /// so it survives SMS/WhatsApp transcoding intact.
  static Future<void> shareReceipt(IntlDataReceiptData data) async {
    final file = await generateReceipt(data);
    final summary = StringBuffer('LazerVault international data receipt\n')
      ..writeln('Reference: ${_ascii(data.displayReference)}')
      ..writeln('Recipient: ${_ascii(data.phoneNumber)}')
      ..writeln('Paid: ${_money(data.senderCurrency, data.amountPaid)}');
    if (data.bundleDescription.isNotEmpty) {
      summary.writeln('Bundle: ${_ascii(data.bundleDescription)}');
    }

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: summary.toString(),
        subject: 'LazerVault international data receipt',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      ),
    );
  }
}
