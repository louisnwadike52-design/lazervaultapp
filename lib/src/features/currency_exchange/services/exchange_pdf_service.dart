import 'dart:io';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'dart:ui' show Rect;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../domain/entities/transaction_entity.dart';
import 'package:lazervault/src/features/support/data/support_contact_info.dart';

class ExchangePdfService {
  static Future<pw.Document> _generateReceiptPdf({
    required CurrencyTransaction transaction,
  }) async {
    // Warm the published support address before any page is built: a
    // document cannot re-render when a late answer arrives, so an
    // un-warmed cache would silently drop the address from the footer.
    // Cheap when warm, and never throws. See SupportContactInfo.
    await SupportContactInfo.refresh();
    final pdf = await ReceiptFonts.document();
    final dateFormat = DateFormat('MMMM d, yyyy HH:mm:ss');
    final isConversion = transaction.type == TransactionType.exchange;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Lazervault',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        isConversion
                            ? 'Currency Conversion Receipt'
                            : 'International Transfer Receipt',
                        style: const pw.TextStyle(
                            fontSize: 12, color: PdfColors.grey600),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        dateFormat.format(transaction.createdAt),
                        style: const pw.TextStyle(
                            fontSize: 10, color: PdfColors.grey600),
                      ),
                      pw.SizedBox(height: 2),
                      if (transaction.referenceNumber != null)
                        pw.Text(
                          'Ref: ${transaction.referenceNumber}',
                          style: const pw.TextStyle(
                              fontSize: 10, color: PdfColors.grey600),
                        ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 20),

              // Status
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: pw.BoxDecoration(
                  color: transaction.isCompleted
                      ? PdfColors.green50
                      : PdfColors.orange50,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text(
                  transaction.statusString,
                  style: pw.TextStyle(
                    color: transaction.isCompleted
                        ? PdfColors.green800
                        : PdfColors.orange800,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              // Amounts
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text('You Sent',
                            style: const pw.TextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          transaction.formattedFromAmount,
                          style: pw.TextStyle(
                              fontSize: 18, fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    pw.Text('→',
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue800)),
                    pw.Column(
                      children: [
                        pw.Text(
                          isConversion ? 'You Received' : 'They Receive',
                          style: const pw.TextStyle(
                              fontSize: 10, color: PdfColors.grey600),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          transaction.formattedToAmount,
                          style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Details
              _buildPdfRow('Exchange Rate',
                  '1 ${transaction.fromCurrency} = ${transaction.exchangeRate.toStringAsFixed(4)} ${transaction.toCurrency}'),
              if (transaction.fees > 0)
                _buildPdfRow('Service Fee', transaction.formattedFees),
              _buildPdfRow('Total Cost', transaction.formattedTotalCost),
              _buildPdfRow(
                  'Type',
                  isConversion
                      ? 'Wallet Conversion'
                      : 'International Transfer'),
              _buildPdfRow('Transaction ID', transaction.id),
              if (transaction.completedAt != null)
                _buildPdfRow('Completed At',
                    dateFormat.format(transaction.completedAt!)),

              // Recipient (international)
              if (!isConversion && transaction.recipientName.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Recipient Details',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 12),
                _buildPdfRow('Name', transaction.recipient.name),
                if (transaction.recipient.accountNumber.isNotEmpty)
                  _buildPdfRow('Account', transaction.recipient.accountNumber),
                if (transaction.recipient.bankName.isNotEmpty)
                  _buildPdfRow('Bank', transaction.recipient.bankName),
                if (transaction.recipient.swiftCode != null &&
                    transaction.recipient.swiftCode!.isNotEmpty)
                  _buildPdfRow('SWIFT/BIC', transaction.recipient.swiftCode!),
              ],

              // Footer
              pw.Spacer(),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 8),
              pw.Text(
                // Reads the operator's published address — never a literal.
                // See SupportContactInfo.
                'This receipt was generated by Lazervault. '
                    '${SupportContactInfo.sentence('For questions')}',
                style:
                    const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _buildPdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style:
                  const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value,
              style:
                  pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  /// Short, filesystem-safe id fragment for the receipt filename. `transaction.id`
  /// can be shorter than 8 chars (or empty) for some corridors, and a raw
  /// `substring(0, 8)` throws RangeError — which was aborting the whole share.
  static String _shortId(String id) {
    final trimmed = id.trim();
    if (trimmed.isEmpty) return 'receipt';
    return trimmed.length >= 8 ? trimmed.substring(0, 8) : trimmed;
  }

  static Future<String> downloadReceipt({
    required CurrencyTransaction transaction,
  }) async {
    final pdf = await _generateReceiptPdf(transaction: transaction);
    final dir = await getApplicationDocumentsDirectory();
    final fileName =
        'exchange_receipt_${_shortId(transaction.id)}_${DateFormat('yyyyMMdd').format(transaction.createdAt)}.pdf';
    final file = File('${dir.path}/$fileName');
    final bytes = await pdf.save();
    if (bytes.isEmpty) {
      throw StateError('receipt PDF generated no bytes');
    }
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  static Future<void> shareReceipt({
    required CurrencyTransaction transaction,
    // iPad requires an anchor rect for the share sheet; harmless elsewhere.
    Rect? sharePositionOrigin,
  }) async {
    final pdf = await _generateReceiptPdf(transaction: transaction);
    final dir = await getTemporaryDirectory();
    final fileName = 'exchange_receipt_${_shortId(transaction.id)}.pdf';
    final file = File('${dir.path}/$fileName');

    // WRITE, THEN PROVE IT WROTE.
    //
    // A share sheet handed a missing or empty file fails inside the platform
    // channel, and the caller sees an opaque PlatformException it cannot
    // tell apart from the user simply cancelling. Checking here means a
    // storage failure is REPORTED as a storage failure.
    final bytes = await pdf.save();
    if (bytes.isEmpty) {
      throw StateError('receipt PDF generated no bytes');
    }
    await file.writeAsBytes(bytes, flush: true);
    if (!await file.exists() || await file.length() == 0) {
      throw StateError('receipt PDF could not be written to ${file.path}');
    }

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/pdf')],
        // ASCII ONLY in the share TEXT.
        //
        // This is not the PDF — it is the message body handed to whatever the
        // customer shares into, and some targets (and some Android intent
        // resolvers) reject or mangle a bare U+2192. The document itself
        // keeps the real arrow, where Inter can draw it.
        text:
            'Exchange receipt - ${transaction.formattedFromAmount} to ${transaction.formattedToAmount}',
        sharePositionOrigin: _safeOrigin(sharePositionOrigin),
      ),
    );
  }

  /// An anchor rect the iOS share sheet will accept.
  ///
  /// iPad REQUIRES one and throws without it; it also throws on a zero-sized
  /// rect, which is exactly what `box.localToGlobal(Offset.zero) & box.size`
  /// produces when the render box has not been laid out yet. One screen
  /// passed nothing at all. Both now end up with a usable rect, and the
  /// fallback is a small square at the origin — unusual placement beats a
  /// thrown share.
  static Rect _safeOrigin(Rect? origin) {
    if (origin != null && origin.width > 0 && origin.height > 0) {
      return origin;
    }
    return const Rect.fromLTWH(0, 0, 1, 1);
  }
}
