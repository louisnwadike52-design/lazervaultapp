import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/core/utils/receipt_download.dart';

import '../../domain/entities/escrow_deal_entity.dart';

/// PDF generation for the Escrow feature — receipts (funded / released /
/// refunded) and the formal escrow agreement document. Mirrors the structure
/// and font/asset handling of `TagPayPdfService`.
///
/// Currency symbols are ASCII-safe (currency code) for PDF font compatibility.
class EscrowPdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  // Cached fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  // ── Kind metadata ─────────────────────────────────────────────────────
  static String _kindTitle(String kind) {
    switch (kind) {
      case 'funded':
        return 'Escrow Funded';
      case 'released':
        return 'Funds Released';
      case 'refunded':
        return 'Escrow Refunded';
      default:
        return 'Escrow Receipt';
    }
  }

  static String _kindSubtitle(String kind) {
    switch (kind) {
      case 'funded':
        return 'Funds secured in escrow';
      case 'released':
        return 'Funds released to seller';
      case 'refunded':
        return 'Refunded to buyer';
      default:
        return 'Escrow transaction';
    }
  }

  /// The headline amount shown for each receipt kind.
  static double _kindAmount(EscrowDealEntity deal, String kind) {
    switch (kind) {
      case 'released':
        return deal.sellerNet;
      case 'funded':
      case 'refunded':
        return deal.buyerTotal;
      default:
        return deal.amount;
    }
  }

  static String _currencySymbolFor(String code) {
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
      default:
        return '$code ';
    }
  }

  static String _money(double v, String currency) =>
      '${_currencySymbolFor(currency)}${NumberFormat('#,##0.00').format(v)}';

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
    }
  }

  static Future<void> _loadFonts() async {
    await ReceiptFonts.load();
    _regularFont = ReceiptFonts.regular;
    _boldFont = ReceiptFonts.bold;
  }

  static pw.TextStyle _ts({
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

  static String _safeRef(String reference) =>
      reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');

  // ── Receipt ───────────────────────────────────────────────────────────

  /// Generate a receipt PDF for the given deal + kind and return its temp path.
  static Future<String> generateReceipt(
      EscrowDealEntity deal, String kind) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final headlineAmount = _money(_kindAmount(deal, kind), deal.currency);

    final dealDate = deal.createdAt != null
        ? _fullDateTimeFormat.format(deal.createdAt!)
        : generatedDate;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header(logo, _kindTitle(kind), generatedDate),
              pw.SizedBox(height: 20),

              // Headline amount + subtitle
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(_kindSubtitle(kind),
                        style: _ts(fontSize: 12, color: PdfColors.grey600)),
                    pw.SizedBox(height: 6),
                    pw.Text(headlineAmount,
                        style: _ts(fontSize: 26, isBold: true)),
                    pw.SizedBox(height: 4),
                    pw.Text(deal.title.isNotEmpty ? deal.title : 'Escrow deal',
                        style: _ts(fontSize: 12, color: PdfColors.grey700)),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),

              // Parties + summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('BUYER',
                            style: _ts(fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            deal.buyerName.isNotEmpty
                                ? deal.buyerName.toUpperCase()
                                : 'LAZERVAULT USER',
                            style: _ts(fontSize: 13, isBold: true)),
                        pw.SizedBox(height: 12),
                        pw.Text('SELLER',
                            style: _ts(fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            deal.sellerName.isNotEmpty
                                ? deal.sellerName.toUpperCase()
                                : 'LAZERVAULT USER',
                            style: _ts(fontSize: 13, isBold: true)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        _summaryRow('Date', dealDate),
                        _summaryRow('Status', _statusLabel(deal.status)),
                        _summaryRow('Type', _kindTitle(kind)),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 28),

              // Amount breakdown
              _detailsBlock('Amount Breakdown', [
                _detailRow('Item amount', _money(deal.amount, deal.currency)),
                _detailRow('Platform fee',
                    '${_money(deal.fee, deal.currency)} (${_feePayerLabel(deal.feePayer)})'),
                _detailRow('Buyer total', _money(deal.buyerTotal, deal.currency),
                    isBold: true),
                _detailRow('Seller net', _money(deal.sellerNet, deal.currency),
                    isBold: true),
                _detailRow('Reference', deal.reference),
                _detailRow('Deal ID', deal.id),
              ]),

              pw.SizedBox(height: 24),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: deal.reference,
                      width: 90,
                      height: 90,
                      drawText: false,
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(deal.reference,
                        style: _ts(fontSize: 9, color: PdfColors.grey600)),
                  ],
                ),
              ),

              pw.Spacer(),
              _footer(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName = 'escrow_receipt_${kind}_${_safeRef(deal.reference)}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  /// Download a receipt PDF to device storage; returns the saved path.
  static Future<String> downloadReceipt(
      EscrowDealEntity deal, String kind) async {
    final tempPath = await generateReceipt(deal, kind);
    return _copyToDownloads(
        tempPath, 'escrow_receipt_${kind}_${_safeRef(deal.reference)}.pdf');
  }

  /// Share a receipt PDF via the system share sheet.
  static Future<void> shareReceipt(
    EscrowDealEntity deal,
    String kind, {
    Rect? sharePositionOrigin,
  }) async {
    final tempPath = await generateReceipt(deal, kind);
    await SharePlus.instance.share(ShareParams(
      files: [XFile(tempPath)],
      text: 'LazerVault Escrow Receipt - ${deal.reference}',
      subject: 'LazerVault ${_kindTitle(kind)}',
      sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
    ));
  }

  // ── Agreement ─────────────────────────────────────────────────────────

  /// Generate the formal escrow agreement PDF and return its temp path.
  static Future<String> generateAgreement(EscrowDealEntity deal) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header(logo, 'Escrow Agreement', generatedDate),
              pw.SizedBox(height: 8),
              pw.Text('Reference: ${deal.reference}',
                  style: _ts(fontSize: 11, color: PdfColors.grey700)),
              pw.Text('Status: ${_statusLabel(deal.status)}',
                  style: _ts(fontSize: 11, color: PdfColors.grey700)),
              pw.SizedBox(height: 24),

              // Parties
              _detailsBlock('Parties', [
                _detailRow('Buyer / Payer',
                    deal.buyerName.isNotEmpty ? deal.buyerName : 'Lazervault User'),
                _detailRow(
                    'Seller / Payee',
                    deal.sellerName.isNotEmpty
                        ? deal.sellerName
                        : 'Lazervault User'),
              ]),
              pw.SizedBox(height: 20),

              // Deal
              _detailsBlock('Deal', [
                _detailRow('Title', deal.title.isNotEmpty ? deal.title : '-'),
                if (deal.description.isNotEmpty)
                  _detailRow('Description', deal.description),
                _detailRow(
                    'Created',
                    deal.createdAt != null
                        ? _fullDateTimeFormat.format(deal.createdAt!)
                        : '-'),
                if (deal.deadlineAt != null)
                  _detailRow(
                      'Deadline', _fullDateTimeFormat.format(deal.deadlineAt!)),
              ]),
              pw.SizedBox(height: 20),

              // Amount breakdown
              _detailsBlock('Amount Breakdown', [
                _detailRow('Item amount', _money(deal.amount, deal.currency)),
                _detailRow('Platform fee',
                    '${_money(deal.fee, deal.currency)} (${_feePayerLabel(deal.feePayer)})'),
                _detailRow('Buyer pays (total)',
                    _money(deal.buyerTotal, deal.currency),
                    isBold: true),
                _detailRow('Seller receives (net)',
                    _money(deal.sellerNet, deal.currency),
                    isBold: true),
              ]),
              pw.SizedBox(height: 20),

              // Legal note
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  'Funds are held by LazerVault in escrow and released to the '
                  'seller upon buyer confirmation; disputes are arbitrated by '
                  'LazerVault.',
                  style: _ts(fontSize: 9, color: PdfColors.grey700),
                  textAlign: pw.TextAlign.justify,
                ),
              ),

              pw.Spacer(),
              _footer(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName = 'escrow_agreement_${_safeRef(deal.reference)}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  /// Download the agreement PDF to device storage; returns the saved path.
  static Future<String> downloadAgreement(EscrowDealEntity deal) async {
    final tempPath = await generateAgreement(deal);
    return _copyToDownloads(
        tempPath, 'escrow_agreement_${_safeRef(deal.reference)}.pdf');
  }

  /// Share the agreement PDF via the system share sheet.
  static Future<void> shareAgreement(
    EscrowDealEntity deal, {
    Rect? sharePositionOrigin,
  }) async {
    final tempPath = await generateAgreement(deal);
    await SharePlus.instance.share(ShareParams(
      files: [XFile(tempPath)],
      text: 'LazerVault Escrow Agreement - ${deal.reference}',
      subject: 'LazerVault Escrow Agreement',
      sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
    ));
  }

  // ── Shared PDF widgets ────────────────────────────────────────────────

  static pw.Widget _header(
      pw.MemoryImage? logo, String title, String generatedDate) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (logo != null)
          pw.Image(logo, width: 120)
        else
          pw.Text('Lazervault',
              style: _ts(fontSize: 28, isBold: true)
                  .copyWith(color: PdfColors.blue800)),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(title,
                style: _ts(fontSize: 22, isBold: true)
                    .copyWith(color: PdfColors.grey800)),
            pw.SizedBox(height: 4),
            pw.Text('Generated on $generatedDate',
                style: _ts(fontSize: 11, color: PdfColors.grey600)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _summaryRow(String label, String value) {
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
          pw.Text(label, style: _ts(fontSize: 11, color: PdfColors.grey700)),
          pw.Flexible(
            child: pw.Text(value,
                style: _ts(fontSize: 11), textAlign: pw.TextAlign.right),
          ),
        ],
      ),
    );
  }

  static pw.Widget _detailsBlock(String title, List<pw.Widget> rows) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: _ts(fontSize: 16, isBold: true)),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.grey200),
          ),
          child: pw.Column(children: rows),
        ),
      ],
    );
  }

  static pw.Widget _detailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 140,
            child: pw.Text(label,
                style: _ts(fontSize: 11, isBold: true)
                    .copyWith(color: PdfColors.grey700)),
          ),
          pw.Expanded(
            child: pw.Text(value,
                style: _ts(fontSize: 11, isBold: isBold),
                textAlign: pw.TextAlign.right),
          ),
        ],
      ),
    );
  }

  static pw.Widget _footer() {
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
                pw.Text('Need help?', style: _ts(fontSize: 10, isBold: true)),
                pw.SizedBox(height: 4),
                pw.Text('Get help directly in-app',
                    style: _ts(fontSize: 9, color: PdfColors.grey600)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('(C) ${DateTime.now().year} LazerVault Technologies Ltd',
                    style: _ts(fontSize: 9, color: PdfColors.grey600)),
                pw.SizedBox(height: 2),
                pw.Text('Page 1 of 1',
                    style: _ts(fontSize: 9, color: PdfColors.grey500)),
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
            'LazerVault Technologies Ltd is a financial technology company. '
            'Funds in escrow are held by LazerVault and released to the seller '
            'upon buyer confirmation; disputes are arbitrated by LazerVault. '
            'For any queries regarding this transaction, please contact support '
            'through the LazerVault app.',
            style: _ts(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────

  static String _statusLabel(String status) {
    switch (status) {
      case 'FUNDED':
      case 'IN_PROGRESS':
        return 'In escrow';
      case 'DELIVERED':
        return 'Delivered';
      case 'RELEASED':
      case 'RESOLVED_RELEASED':
        return 'Released';
      case 'CANCELLED':
      case 'REFUNDED':
      case 'RESOLVED_REFUNDED':
        return 'Refunded';
      case 'DISPUTED':
        return 'Disputed';
      case 'EXPIRED':
        return 'Expired';
      default:
        return status;
    }
  }

  static String _feePayerLabel(String feePayer) {
    switch (feePayer.toUpperCase()) {
      case 'BUYER':
        return 'paid by buyer';
      case 'SELLER':
        return 'paid by seller';
      case 'SPLIT':
        return 'split';
      default:
        return feePayer.isEmpty ? 'paid by buyer' : feePayer.toLowerCase();
    }
  }

  /// Saves a generated PDF where the user can get at it.
  ///
  /// One helper behind BOTH the receipt and the agreement downloads, so the
  /// hardcoded /storage/emulated/0/Download here broke both: Android scoped
  /// storage (API 30+) reports that path as existing — so the exists() guard
  /// passed and the fallback never ran — and then refuses the write.
  static Future<String> _copyToDownloads(
      String tempPath, String fileName) async {
    return ReceiptDownload.saveAndOpen(
      source: File(tempPath),
      fileName: fileName,
    );
  }

  // share_plus on iOS requires a non-zero sharePositionOrigin.
  static Rect _resolveShareOrigin(Rect? origin) {
    if (origin != null && origin.width > 0 && origin.height > 0) {
      return origin;
    }
    return const Rect.fromLTWH(0, 0, 1, 1);
  }

  /// Build a share-sheet anchor rect from a widget's [context].
  static Rect? shareOriginFromContext(BuildContext context) {
    final obj = context.findRenderObject();
    if (obj is RenderBox && obj.hasSize) {
      return obj.localToGlobal(Offset.zero) & obj.size;
    }
    return null;
  }
}
