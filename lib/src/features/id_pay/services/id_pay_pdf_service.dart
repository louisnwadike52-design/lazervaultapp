import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import '../domain/entities/id_pay_entity.dart';
import '../domain/entities/id_pay_transaction_entity.dart';
import 'package:lazervault/core/config/receipt_footer.dart';

class IDPayPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  static String _currencySymbolFor(String code) => receiptCurrencySymbol(code);

  /// Money on a receipt, grouped.
  ///
  /// `toStringAsFixed(2)` renders ₦120,000 as "120000.00". On a screen that is
  /// merely untidy; on a PDF someone forwards to whoever paid them, it is a
  /// number the reader has to count digits to trust — and this document exists
  /// precisely to be trusted.
  ///
  /// The `0` before the decimal point matters as much as the separator:
  /// '#,###.00' drops the leading digit entirely, so a ₦0.50 fee prints as
  /// ".50".
  static final _money = NumberFormat('#,##0.00');

  static String _amount(double v) => _money.format(v);

  static String _currencyNameFor(String code) {
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

  /// Generate a payment receipt PDF for a paid IDPay
  static Future<File> generatePaymentReceipt({
    required IDPayTransactionEntity transaction,
    required IDPayEntity idPay,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = _amount(transaction.amount);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            transaction.payerName.isNotEmpty
                                ? transaction.payerName.toUpperCase()
                                : 'Lazervault user',
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (transaction.payerUsername.isNotEmpty)
                          pw.Text('@${transaction.payerUsername}',
                              style: _getTextStyle(
                                  fontSize: 11, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: transactionDate,
                      status: transaction.isCompleted
                          ? 'Completed'
                          : transaction.status,
                      type: 'PayID Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference: idPay.description.isNotEmpty
                    ? idPay.description
                    : 'PayID payment',
                idPayReference: transaction.reference,
                transactionId: transaction.id,
                payId: idPay.displayPayId,
              ),
              pw.SizedBox(height: 32),
              _buildRecipientDetails(
                recipientName: transaction.recipientName.isNotEmpty
                    ? transaction.recipientName
                    : idPay.creatorName,
                recipientUsername: idPay.creatorUsername,
              ),
              pw.Spacer(),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef =
        transaction.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName = 'idpay_receipt_$safeRef.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate an invoice PDF for a created IDPay (before payment)
  static Future<File> generateCreationInvoice({
    required IDPayEntity idPay,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final createdDate = _dateFormat.format(idPay.createdAt);
    final currencySymbol = _currencySymbolFor(idPay.currency);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(logo, generatedDate, isInvoice: true),
              pw.SizedBox(height: 24),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            idPay.creatorName.isNotEmpty
                                ? idPay.creatorName.toUpperCase()
                                : 'Lazervault user',
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (idPay.creatorUsername.isNotEmpty)
                          pw.Text('@${idPay.creatorUsername}',
                              style: _getTextStyle(
                                  fontSize: 11, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: createdDate,
                      status: idPay.status.displayName,
                      type: 'PayID Invoice',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              _buildInvoiceDetails(
                idPay: idPay,
                currencySymbol: currencySymbol,
              ),
              pw.Spacer(),
              _buildFooter(transactionType: 'PayID payment request'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'idpay_invoice_${idPay.payId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(pw.MemoryImage? logo, String generatedDate,
      {required bool isInvoice}) {
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
                'Lazervault',
                style: _getTextStyle(fontSize: 28, isBold: true)
                    .copyWith(color: PdfColors.blue800),
              ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              isInvoice ? 'PayID Invoice' : 'Transfer Confirmation',
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

  static pw.Widget _buildSummaryTable({
    required String createdDate,
    String? completedDate,
    required String status,
    required String type,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Value Date', completedDate ?? createdDate),
        _buildSummaryRow('Operation Date', createdDate),
        _buildSummaryRow('Date available', completedDate ?? createdDate),
        _buildSummaryRow('Status', status),
        _buildSummaryRow('Type', type),
      ],
    );
  }

  static pw.Widget _buildSummaryRow(String label, String value) {
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
          pw.Text(label,
              style: _getTextStyle(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value, style: _getTextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  static pw.Widget _buildTransferDetails({
    required String currencySymbol,
    required String amount,
    required String reference,
    required String idPayReference,
    required String transactionId,
    required String payId,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Transfer details',
            style: _getTextStyle(fontSize: 16, isBold: true)),
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
              _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true),
              _buildDetailRow('PayID', payId),
              _buildDetailRow('Reference', idPayReference),
              _buildDetailRow('Description', reference),
              _buildDetailRow('Transaction Id', transactionId),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildInvoiceDetails({
    required IDPayEntity idPay,
    required String currencySymbol,
  }) {
    final amountDisplay =
        idPay.isFixed ? '$currencySymbol${_amount(idPay.amount)}' : 'Flexible';

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Invoice Details',
            style: _getTextStyle(fontSize: 16, isBold: true)),
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
              _buildDetailRow('PayID', idPay.displayPayId, isBold: true),
              _buildDetailRow('Amount', amountDisplay, isBold: true),
              if (idPay.isFlexible && idPay.minAmount > 0)
                _buildDetailRow(
                    'Min Amount', '$currencySymbol${_amount(idPay.minAmount)}'),
              if (idPay.isFlexible && idPay.maxAmount > 0)
                _buildDetailRow(
                    'Max Amount', '$currencySymbol${_amount(idPay.maxAmount)}'),
              _buildDetailRow('Currency', _currencyNameFor(idPay.currency)),
              _buildDetailRow('Type', idPay.type.displayName),
              _buildDetailRow('Amount Mode', idPay.amountMode.displayName),
              if (idPay.description.isNotEmpty)
                _buildDetailRow('Description', idPay.description),
              _buildDetailRow(
                  'Created', _fullDateTimeFormat.format(idPay.createdAt)),
              _buildDetailRow(
                  'Expires', _fullDateTimeFormat.format(idPay.expiresAt)),
              _buildDetailRow('Status', idPay.status.displayName),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(label,
                style: _getTextStyle(fontSize: 11, isBold: true)
                    .copyWith(color: PdfColors.grey700)),
          ),
          pw.Expanded(
            child: pw.Text(value,
                style: _getTextStyle(fontSize: 11, isBold: isBold),
                textAlign: pw.TextAlign.right),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRecipientDetails({
    required String recipientName,
    required String recipientUsername,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Beneficiary Details',
            style: _getTextStyle(fontSize: 16, isBold: true)),
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
              _buildDetailRow('Name',
                  recipientName.isNotEmpty ? recipientName : 'Lazervault User'),
              if (recipientUsername.isNotEmpty)
                _buildDetailRow('Username', '@$recipientUsername'),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter({String transactionType = 'PayID transfer'}) {
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
                pw.Text('Need help?',
                    style: _getTextStyle(fontSize: 10, isBold: true)),
                pw.SizedBox(height: 4),
                pw.Text(ReceiptFooter.support,
                    style:
                        _getTextStyle(fontSize: 9, color: PdfColors.grey600)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(ReceiptFooter.copyright(),
                    style:
                        _getTextStyle(fontSize: 9, color: PdfColors.grey600)),
                pw.SizedBox(height: 2),
                pw.Text('Page 1 of 1',
                    style:
                        _getTextStyle(fontSize: 9, color: PdfColors.grey500)),
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
            ReceiptFooter.disclaimer('a $transactionType'),
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  // ─── Public API methods ───

  /// Download payment receipt to device storage
  static Future<String> downloadReceipt({
    required IDPayTransactionEntity transaction,
    required IDPayEntity idPay,
  }) async {
    try {
      final file =
          await generatePaymentReceipt(transaction: transaction, idPay: idPay);
      final safeRef =
          transaction.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'idpay_receipt_$safeRef.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share payment receipt via system share sheet
  static Future<void> shareReceipt({
    required IDPayTransactionEntity transaction,
    required IDPayEntity idPay,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file =
          await generatePaymentReceipt(transaction: transaction, idPay: idPay);

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = _amount(transaction.amount);

      await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
        files: [XFile(file.path)],
        text:
            'PayID Transfer Receipt - $currencySymbol$amount to ${transaction.recipientName}',
        subject: 'Lazervault PayID Transfer Confirmation',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Money for the share MESSAGE, which is plain text in somebody's chat app
  /// rather than PDF content.
  ///
  /// `receiptCurrencySymbol` deliberately degrades to "NGN " until the PDF
  /// font is embedded, because the glyph does not exist in the document
  /// before then. The share text has no such constraint — and the fallback
  /// path calls this precisely when PDF generation FAILED — so the gated
  /// helper made one request read "₦2,500.00" and the next "NGN 2,500.00"
  /// depending only on whether an invoice happened to be built first.
  static String _shareAmount(double v, String code) {
    final upper = code.toUpperCase();
    final symbol = CurrencySymbols.symbols[upper];
    // An unmapped currency must not borrow the dollar sign: CurrencySymbols
    // defaults to '$', which would price a CNY request in USD.
    return symbol == null ? '$upper ${_amount(v)}' : '$symbol${_amount(v)}';
  }

  /// The message that travels with a shared PayID.
  ///
  /// The old Share button sent the code and the description and nothing else,
  /// so whoever received it could not see what they were being asked for, how
  /// much, or by when — they had to open the app to find out. A payment
  /// request is only useful if it is legible in the message itself.
  static String shareMessageFor(IDPayEntity idPay) {
    final lines = <String>[];

    final who = idPay.creatorName.trim();
    lines.add(who.isNotEmpty
        ? '$who is requesting a payment via Lazervault.'
        : 'Payment request via Lazervault.');
    lines.add('');

    if (idPay.description.trim().isNotEmpty) {
      lines.add('For: ${idPay.description.trim()}');
    }
    // A flexible PayID genuinely has no amount — say so rather than printing
    // a zero, which reads as "nothing to pay".
    lines.add(idPay.isFixed
        ? 'Amount: ${_shareAmount(idPay.amount, idPay.currency)}'
        : 'Amount: you choose');
    lines.add('PayID: ${idPay.displayPayId}');

    final expiry = _shareExpiryLine(idPay);
    if (expiry.isNotEmpty) lines.add(expiry);

    lines.add('');
    lines.add('Pay it in the Lazervault app: enter the PayID above.');
    return lines.join('\n');
  }

  /// "Expires: …" for the share message, or "" when it never expires.
  static String _shareExpiryLine(IDPayEntity idPay) {
    // `expiresAt` is non-nullable and carries a far-future placeholder when
    // the PayID never expires, so the flag is the only honest check — a date
    // comparison would print "Expires in 36500 day(s)".
    if (idPay.neverExpires) return '';
    final left = idPay.expiresAt.difference(DateTime.now());
    if (left.isNegative) return 'Expired';
    if (left.inHours >= 24) return 'Expires in ${left.inDays} day(s)';
    if (left.inMinutes >= 60) return 'Expires in ${left.inHours} hour(s)';
    return 'Expires in ${left.inMinutes} minute(s)';
  }

  /// Download creation invoice to device storage
  static Future<String> downloadInvoice({
    required IDPayEntity idPay,
  }) async {
    try {
      final file = await generateCreationInvoice(idPay: idPay);
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'idpay_invoice_${idPay.payId}.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download invoice: $e');
    }
  }

  /// Build a share-sheet anchor from the tapped widget's global bounds.
  ///
  /// Capture it BEFORE any navigation: the render box dies on pop and the rect
  /// then comes back null.
  static Rect? shareOriginFromContext(BuildContext context) {
    final obj = context.findRenderObject();
    if (obj is RenderBox && obj.hasSize) {
      return obj.localToGlobal(Offset.zero) & obj.size;
    }
    return null;
  }

  /// A non-zero anchor, always.
  ///
  /// share_plus on iOS REQUIRES one: a zero rect throws
  /// `PlatformException(sharePositionOrigin: argument must be set …)` and the
  /// sheet never opens — which is exactly how the PayID Share button failed.
  static Rect _resolveShareOrigin(Rect? origin) {
    if (origin != null && origin.width > 0 && origin.height > 0) {
      return origin;
    }
    return const Rect.fromLTWH(0, 0, 1, 1);
  }

  /// Share creation invoice via system share sheet
  static Future<void> shareInvoice({
    required IDPayEntity idPay,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file = await generateCreationInvoice(idPay: idPay);

      await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
        files: [XFile(file.path)],
        text: shareMessageFor(idPay),
        subject: 'Lazervault PayID Invoice',
      ));
    } catch (e) {
      throw Exception('Failed to share invoice: $e');
    }
  }
}
