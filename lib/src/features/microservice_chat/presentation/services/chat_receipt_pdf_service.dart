import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

/// Generates and shares a downloadable PDF receipt from a generic
/// `ChatReceiptCardV2` payload (the JSON shape from
/// `chat_services_shared/receipt_protocol.py` → `ReceiptCard`).
///
/// This mirrors `WalletTransferPdfService` (the working send-funds receipt
/// share) so the chat AND voice agent receipt cards produce a real, shareable
/// PDF file instead of a plain-text share that "fails to download". One service
/// covers every transaction type because it renders from the generic payload
/// (summary, amount, fee, total, reference, status, timestamp + `extra`).
class ChatReceiptPdfService {
  // Cached unicode-capable fonts (Naira ₦ etc.). Loaded once per process.
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Loads the unicode-capable face this receipt needs.
  ///
  /// The comment above was aspirational: the CDN URL this used had 404'd, so
  /// the "fall back to the bundled defaults" path was the ONLY path, and the
  /// built-in default cannot draw ₦ at all — it raises. Every chat and voice
  /// receipt quoting a naira amount was one PDF render away from failing.
  static Future<void> _loadFonts() async {
    await ReceiptFonts.load();
    _regularFont = ReceiptFonts.regular;
    _boldFont = ReceiptFonts.bold;
  }

  static pw.TextStyle _style({
    double fontSize = 12,
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

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  static String _s(Map<String, dynamic> p, String key) =>
      p[key]?.toString() ?? '';

  static PdfColor _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return PdfColors.green600;
      case 'failed':
      case 'error':
        return PdfColors.red600;
      case 'pending':
      case 'processing':
        return PdfColors.orange600;
      case 'refunded':
        return PdfColors.indigo600;
      case 'manual_review':
        return PdfColors.purple600;
      default:
        return PdfColors.blue600;
    }
  }

  static String _badge(String status) {
    if (status.isEmpty) return 'PROCESSING';
    return status
        .split('_')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  /// Build the PDF bytes from a generic receipt payload.
  static Future<Uint8List> generateReceipt(Map<String, dynamic> payload) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();

    final status = _s(payload, 'status');
    final statusColor = _statusColor(status);
    final summary = _s(payload, 'summary_line');
    final amount = _s(payload, 'amount');
    final currency = _s(payload, 'currency');
    final fee = _s(payload, 'fee');
    final total = _s(payload, 'total_amount');
    final reference = _s(payload, 'reference');
    final timestamp = _s(payload, 'timestamp');
    final txType = _s(payload, 'transaction_type');
    final feeNum = double.tryParse(fee) ?? 0.0;

    // Flatten any string/num entries in `extra` into additional detail rows.
    final extraRows = <MapEntry<String, String>>[];
    final extra = payload['extra'];
    if (extra is Map) {
      extra.forEach((k, v) {
        if (v == null) return;
        if (v is Map || v is List) return;
        final label = k
            .toString()
            .split('_')
            .map((w) =>
                w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' ');
        extraRows.add(MapEntry(label, v.toString()));
      });
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (logo != null)
                    pw.Image(logo, width: 120)
                  else
                    pw.Text('Lazervault',
                        style: _style(fontSize: 28, isBold: true)
                            .copyWith(color: PdfColors.blue800)),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Transaction Receipt',
                          style: _style(fontSize: 18, isBold: true)
                              .copyWith(color: PdfColors.grey800)),
                      if (timestamp.isNotEmpty) ...[
                        pw.SizedBox(height: 4),
                        pw.Text(timestamp,
                            style: _style(
                                fontSize: 11, color: PdfColors.grey600)),
                      ],
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 24),

              // Title + status + amount
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          summary.isEmpty ? 'Receipt' : summary,
                          style: _style(fontSize: 18, isBold: true)
                              .copyWith(color: PdfColors.grey800),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: pw.BoxDecoration(
                            color: PdfColor(
                                statusColor.red, statusColor.green,
                                statusColor.blue, 0.12),
                            borderRadius: pw.BorderRadius.circular(12),
                          ),
                          child: pw.Text(
                            _badge(status),
                            style: _style(
                                fontSize: 10,
                                isBold: true,
                                color: statusColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        amount.isEmpty ? '' : '$amount $currency',
                        style: _style(fontSize: 26, isBold: true),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 28),

              // Details
              pw.Text('Transaction Details',
                  style: _style(fontSize: 14, isBold: true)),
              pw.SizedBox(height: 12),
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(color: PdfColors.grey200),
                ),
                child: pw.Column(
                  children: [
                    if (amount.isNotEmpty)
                      _detailRow('Amount', '$amount $currency'),
                    if (feeNum > 0) _detailRow('Fee', '$fee $currency'),
                    if (total.isNotEmpty) ...[
                      pw.Divider(color: PdfColors.grey300),
                      pw.SizedBox(height: 2),
                      _detailRow('Total', '$total $currency', isBold: true),
                      pw.SizedBox(height: 4),
                    ],
                    if (txType.isNotEmpty)
                      _detailRow('Type', _badge(txType)),
                    if (reference.isNotEmpty)
                      _detailRow('Reference', reference),
                    if (timestamp.isNotEmpty) _detailRow('Date', timestamp),
                    for (final e in extraRows) _detailRow(e.key, e.value),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 12),
              pw.Center(
                child: pw.Text('Generated by Lazervault',
                    style: _style(fontSize: 10, color: PdfColors.grey600)),
              ),
              pw.SizedBox(height: 4),
              pw.Center(
                child: pw.Text(
                    'This is an automatically generated receipt.',
                    style: _style(fontSize: 9, color: PdfColors.grey500)),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _detailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label,
              style: _style(fontSize: 11, color: PdfColors.grey700)),
          pw.SizedBox(width: 24),
          pw.Expanded(
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.right,
              style: _style(fontSize: 11, isBold: isBold),
            ),
          ),
        ],
      ),
    );
  }

  /// Generate the PDF and hand it to the native share sheet as a real file
  /// (so it can be saved/downloaded), mirroring the send-funds flow.
  static Future<void> shareReceipt(
    Map<String, dynamic> payload, {
    Rect? sharePositionOrigin,
  }) async {
    final pdfBytes = await generateReceipt(payload);
    final reference = _s(payload, 'reference');
    final safeRef = reference.isEmpty
        ? 'receipt'
        : reference.replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '_');
    final fileName = 'Lazervault_Receipt_$safeRef.pdf';
    // Write the PDF to a REAL file and share its PATH. XFile.fromData (in-memory
    // bytes) is unreliable — on iOS the share sheet frequently receives no
    // attachment ("share not working"), and Android saves a 0-byte file. A file
    // path is the canonical, cross-platform-reliable way to share a document.
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(pdfBytes, flush: true);
    final subject = _s(payload, 'shareable_email_subject').isNotEmpty
        ? _s(payload, 'shareable_email_subject')
        : 'Lazervault Transaction Receipt';
    final body = _s(payload, 'shareable_text');
    // ignore: deprecated_member_use
    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'application/pdf', name: fileName)],
      subject: subject,
      text: body.isEmpty ? null : body,
      // iPad requires a non-zero popover origin or the share sheet crashes; pass
      // the tapped button's rect through when available.
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}
