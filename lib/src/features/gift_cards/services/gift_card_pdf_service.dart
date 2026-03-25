import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/gift_card_entity.dart';

class GiftCardPdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

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
      default:
        return '$code ';
    }
  }

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
    }
  }

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;
    try {
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));
      if (regularResponse.statusCode == 200 &&
          boldResponse.statusCode == 200) {
        _regularFont =
            pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (e) {
      _regularFont = null;
      _boldFont = null;
    }
  }

  static pw.TextStyle _getTextStyle({
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

  static Future<File> generateReceipt({
    required GiftCard giftCard,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final currencySymbol = _currencySymbolFor(giftCard.currency);
    final amount = giftCard.originalAmount.toStringAsFixed(2);
    final hasCrossCurrency = giftCard.isMultiCurrency;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(logo, generatedDate),
              pw.SizedBox(height: 24),

              // Amount card
              _buildAmountSection(
                giftCard: giftCard,
                currencySymbol: currencySymbol,
                amount: amount,
                hasCrossCurrency: hasCrossCurrency,
              ),
              pw.SizedBox(height: 24),

              // Purchase details
              _buildPurchaseDetails(
                giftCard: giftCard,
                currencySymbol: currencySymbol,
                amount: amount,
                hasCrossCurrency: hasCrossCurrency,
              ),
              pw.SizedBox(height: 24),

              // Redemption details
              if (giftCard.redemptionCode != null &&
                  giftCard.redemptionCode!.isNotEmpty)
                _buildRedemptionSection(giftCard: giftCard),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final ref = (giftCard.providerTransactionId ?? giftCard.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName =
        'giftcard_receipt_${ref}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(
      pw.MemoryImage? logo, String generatedDate) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null)
              pw.Image(logo, width: 120)
            else
              pw.Text(
                'LazerVault',
                style: _getTextStyle(fontSize: 28, isBold: true)
                    .copyWith(color: PdfColors.blue800),
              ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Gift Card Receipt',
              style: _getTextStyle(fontSize: 24, isBold: true)
                  .copyWith(color: PdfColors.grey800),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Generated on $generatedDate',
              style: _getTextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildAmountSection({
    required GiftCard giftCard,
    required String currencySymbol,
    required String amount,
    required bool hasCrossCurrency,
  }) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(24),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: PdfColors.blue200),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            giftCard.brandName,
            style: _getTextStyle(fontSize: 16, isBold: true),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            '$currencySymbol$amount',
            style: _getTextStyle(fontSize: 32, isBold: true)
                .copyWith(color: PdfColors.blue800),
          ),
          if (hasCrossCurrency) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              'Paid: ${_currencySymbolFor(giftCard.senderCurrency)}${giftCard.senderAmount.toStringAsFixed(2)}',
              style: _getTextStyle(fontSize: 14, color: PdfColors.grey700),
            ),
          ],
          pw.SizedBox(height: 8),
          pw.Container(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: pw.BoxDecoration(
              color: giftCard.status == 'available'
                  ? PdfColors.green50
                  : PdfColors.orange50,
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Text(
              giftCard.status[0].toUpperCase() + giftCard.status.substring(1),
              style: _getTextStyle(
                fontSize: 11,
                isBold: true,
                color: giftCard.status == 'available'
                    ? PdfColors.green800
                    : PdfColors.orange800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPurchaseDetails({
    required GiftCard giftCard,
    required String currencySymbol,
    required String amount,
    required bool hasCrossCurrency,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Purchase Details',
          style: _getTextStyle(fontSize: 16, isBold: true),
        ),
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
              _buildDetailRow('Brand', giftCard.brandName),
              _buildDetailRow('Card Value', '$currencySymbol$amount',
                  isBold: true),
              if (hasCrossCurrency)
                _buildDetailRow('Amount Paid',
                    '${_currencySymbolFor(giftCard.senderCurrency)}${giftCard.senderAmount.toStringAsFixed(2)}'),
              if (giftCard.discountPercentage > 0)
                _buildDetailRow('Discount',
                    '${giftCard.discountPercentage.toStringAsFixed(0)}%'),
              _buildDetailRow('Purchase Date',
                  _formatDate(giftCard.purchaseDate)),
              _buildDetailRow(
                  'Expiry Date', _formatDate(giftCard.expiryDate)),
              if (giftCard.countryCode != null &&
                  giftCard.countryCode!.isNotEmpty)
                _buildDetailRow('Country', giftCard.countryCode!),
              if (giftCard.providerTransactionId != null &&
                  giftCard.providerTransactionId!.isNotEmpty)
                _buildDetailRow(
                    'Transaction ID', giftCard.providerTransactionId!),
              if (giftCard.recipientName != null &&
                  giftCard.recipientName!.isNotEmpty)
                _buildDetailRow('Recipient', giftCard.recipientName!),
              if (giftCard.recipientEmail != null &&
                  giftCard.recipientEmail!.isNotEmpty)
                _buildDetailRow('Email', giftCard.recipientEmail!),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildRedemptionSection({
    required GiftCard giftCard,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Redemption Details',
          style: _getTextStyle(fontSize: 16, isBold: true),
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.green50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.green200),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (giftCard.redemptionCode != null &&
                  giftCard.redemptionCode!.isNotEmpty) ...[
                pw.Text('Redemption Code',
                    style:
                        _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(
                  giftCard.redemptionCode!,
                  style: _getTextStyle(fontSize: 14, isBold: true),
                ),
                pw.SizedBox(height: 12),
              ],
              if (giftCard.redemptionPin != null &&
                  giftCard.redemptionPin!.isNotEmpty) ...[
                pw.Text('Redemption PIN',
                    style:
                        _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(
                  giftCard.redemptionPin!,
                  style: _getTextStyle(fontSize: 14, isBold: true),
                ),
                pw.SizedBox(height: 12),
              ],
              if (giftCard.redemptionInstructions != null &&
                  giftCard.redemptionInstructions!.isNotEmpty) ...[
                pw.Text('How to Redeem',
                    style:
                        _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(
                  giftCard.redemptionInstructions!,
                  style: _getTextStyle(fontSize: 11, color: PdfColors.grey800),
                ),
              ],
            ],
          ),
        ),
        pw.SizedBox(height: 24),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
          pw.SizedBox(width: 20),
          pw.Expanded(
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.right,
              style: _getTextStyle(fontSize: 11, isBold: isBold),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'LazerVault Financial Services',
              style: _getTextStyle(fontSize: 10, color: PdfColors.grey500),
            ),
            pw.Text(
              'This is a computer-generated document',
              style: _getTextStyle(fontSize: 9, color: PdfColors.grey400),
            ),
          ],
        ),
      ],
    );
  }

  static String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return _displayDateFormat.format(date);
    } catch (e) {
      return dateStr;
    }
  }

  /// Download receipt to device storage
  static Future<String> downloadReceipt({
    required GiftCard giftCard,
  }) async {
    try {
      final file = await generateReceipt(giftCard: giftCard);

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      final ref = (giftCard.providerTransactionId ?? giftCard.id)
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName = 'giftcard_receipt_$ref.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share receipt via system share sheet
  static Future<void> shareReceipt({
    required GiftCard giftCard,
  }) async {
    try {
      final file = await generateReceipt(giftCard: giftCard);

      final currencySymbol = _currencySymbolFor(giftCard.currency);
      final amount = giftCard.originalAmount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Gift Card Receipt - ${giftCard.brandName} $currencySymbol$amount',
        subject: 'LazerVault Gift Card Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
