import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/core/utils/receipt_raster.dart';
import '../domain/entities/tag_pay_entity.dart';
import '../domain/entities/user_tag_entity.dart';
import 'package:lazervault/src/features/widgets/receipt_metadata_humanizer.dart';

part 'tag_pay_pdf_helpers.dart';
part 'tag_pay_pdf_builders.dart';

/// Which party a transfer receipt is generated FOR. Drives whether the fee is
/// shown: the SENDER paid amount + fee, so their copy itemises the fee; the
/// RECIPIENT received only the amount (the fee never touches them), so their
/// copy shows just the amount + transaction details — never the sender's fee.
enum ReceiptCopyType {
  sender,
  recipient;

  bool get isRecipient => this == ReceiptCopyType.recipient;

  /// Caption stamped on the PDF so a printed/shared copy is unambiguous.
  String get label => switch (this) {
        ReceiptCopyType.sender => "Sender's Copy",
        ReceiptCopyType.recipient => "Recipient's Copy",
      };
}

/// Output format the user picks for a shareable/downloadable receipt. PNG/JPG
/// are rasterised from the SAME PDF layout so all three formats look identical.
enum ReceiptFileFormat {
  pdf,
  png,
  jpg;

  String get ext => name; // pdf | png | jpg
  String get label => switch (this) {
        ReceiptFileFormat.pdf => 'PDF document',
        ReceiptFileFormat.png => 'PNG image',
        ReceiptFileFormat.jpg => 'JPG image',
      };
  String get mime => switch (this) {
        ReceiptFileFormat.pdf => 'application/pdf',
        ReceiptFileFormat.png => 'image/png',
        ReceiptFileFormat.jpg => 'image/jpeg',
      };
}

class TagPayPdfService {
  /// Generate a professional invoice PDF for a tag (before payment)
  static Future<File> generateTagInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final createdDate = _dateFormat.format(tag.createdAt);
    final currencySymbol = _currencySymbolFor(tag.currency);
    final amount = _amountFormat.format(tag.amount);

    // For outgoing tags: you are the tagger (sender), recipient is taggedUser
    // For incoming tags: tagger sent it to you (taggedUser)
    // Names/tags/description are USER-SUPPLIED, so they go through _pdfSafe
    // before they reach the document.
    final senderName = _pdfSafeText(tag.taggerName);
    final senderTag = _pdfSafeText(tag.taggerTagPay);
    final recipientName = _pdfSafeText(tag.taggedUserName);
    final recipientTag = _pdfSafeText(tag.taggedUserTagPay);
    final description = _pdfSafeText(tag.description);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildInvoiceHeader(logo, generatedDate, isInvoice: true),
              pw.SizedBox(height: 24),

              // From/To and Summary
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
                        pw.Text(senderName.toUpperCase(),
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (senderTag.isNotEmpty)
                          pw.Text('@$senderTag',
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
                      status: _tagStatusLabel(tag),
                      type: 'Tagpay Invoice',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Invoice Details
              _buildInvoiceDetails(
                tag: tag,
                currencySymbol: currencySymbol,
                amount: amount,
                description: description,
              ),
              pw.SizedBox(height: 32),

              // Recipient Details
              _buildRecipientDetails(
                recipientName: recipientName,
                recipientTag: recipientTag,
                title: 'Bill To',
              ),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'tagpay_invoice_${tag.id.substring(0, 8)}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a professional receipt PDF for a paid tag
  static Future<File> generateTagPayReceipt({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? senderAccountNumber,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final completedDate = transaction.completedAt != null
        ? _dateFormat.format(transaction.completedAt!)
        : transactionDate;
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = _amountFormat.format(transaction.amount);

    // USER-SUPPLIED text (names, tags, narration) is sanitised before it
    // reaches the document — same rule the transfer/crypto generators follow.
    final beneficiaryName = _pdfSafeText(transaction.receiverName.isNotEmpty
        ? transaction.receiverName
        : tag.taggerName);
    final beneficiaryTag = _pdfSafeText(transaction.receiverTagPay.isNotEmpty
        ? transaction.receiverTagPay
        : tag.taggerTagPay);
    final reference = _pdfSafeText(transaction.description ?? tag.description);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildSenderInfo(
                      transaction: transaction,
                      tag: tag,
                      accountNumber: senderAccountNumber,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: completedDate,
                      status: transaction.statusDisplay,
                      type: 'Tagpay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference: reference,
                tagPayReference: transaction.referenceNumber,
                transactionId: transaction.id,
              ),
              pw.SizedBox(height: 32),

              // Both parties — a paid receipt records who paid whom.
              _buildRecipientDetails(
                recipientName: beneficiaryName,
                recipientTag: beneficiaryTag,
                title: 'Transaction Parties',
                senderName: _pdfSafeText(transaction.senderName.isNotEmpty
                    ? transaction.senderName
                    : tag.taggedUserName),
                senderTag: _pdfSafeText(transaction.senderTagPay.isNotEmpty
                    ? transaction.senderTagPay
                    : tag.taggedUserTagPay),
              ),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'tagpay_receipt_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download the invoice to device storage.
  ///
  /// Goes through [ReceiptDownload], the app's single answer to where a saved
  /// document lands. The previous direct write to /storage/emulated/0/Download
  /// fails on Android 11+: scoped storage reports that path as existing and
  /// then refuses the write, so `exists()` passed, the fallback never ran, and
  /// the copy threw — "Failed to download invoice" on every current device.
  static Future<String> downloadInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'tagpay_invoice_${tag.id.substring(0, 8)}.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download invoice: $e');
    }
  }

  // ── iOS share-sheet anchor ────────────────────────────────────────────
  //
  // share_plus on iOS REQUIRES a non-zero `sharePositionOrigin` (the rect the
  // share popover anchors to). An unset/zero rect throws
  // PlatformException("sharePositionOrigin: argument must be set, {{0,0},{0,0}}
  // must be non-zero …") — the "Failed to share invoice/receipt" the user hit.
  // Callers pass the tapped widget's global rect via [shareOriginFromContext];
  // when unavailable we fall back to a small valid rect so the sheet still opens.
  static Rect _resolveShareOrigin(Rect? origin) {
    if (origin != null && origin.width > 0 && origin.height > 0) {
      return origin;
    }
    return const Rect.fromLTWH(0, 0, 1, 1);
  }

  /// Build a share-sheet anchor rect from a widget's [context] (its global
  /// bounds). Returns null when the render box isn't ready; the share methods
  /// then fall back to a safe default.
  static Rect? shareOriginFromContext(BuildContext context) {
    final obj = context.findRenderObject();
    if (obj is RenderBox && obj.hasSize) {
      return obj.localToGlobal(Offset.zero) & obj.size;
    }
    return null;
  }

  /// Share the invoice via system share sheet
  static Future<void> shareInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
      final currencySymbol = _currencySymbolFor(tag.currency);
      final amount = _amountFormat.format(tag.amount);
      final recipientName = isOutgoing ? tag.taggedUserName : tag.taggerName;
      final recipientTag = isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Tagpay Invoice - $currencySymbol$amount ${isOutgoing ? "to" : "from"} ${recipientName.isNotEmpty ? recipientName : "@$recipientTag"}',
        subject: 'Lazervault Tagpay Invoice',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share invoice: $e');
    }
  }

  /// Share the invoices for a BATCH of tags — one PDF per recipient, all
  /// attached to a single share sheet.
  ///
  /// Batch creation produces N DISTINCT invoices (one per tagged user, each
  /// naming that user). The receipt screen used to share `tags.first` for the
  /// whole batch, so a screen reading "5 users x ₦2,000" handed out recipient
  /// #1's invoice five times and the other four never got theirs.
  static Future<void> shareInvoices({
    required List<UserTagEntity> tags,
    required bool isOutgoing,
    Rect? sharePositionOrigin,
  }) async {
    if (tags.isEmpty) return;
    if (tags.length == 1) {
      return shareInvoice(
        tag: tags.first,
        isOutgoing: isOutgoing,
        sharePositionOrigin: sharePositionOrigin,
      );
    }
    try {
      final files = <XFile>[];
      var total = 0.0;
      for (final tag in tags) {
        final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
        files.add(XFile(file.path));
        total += tag.amount;
      }
      final currencySymbol = _currencySymbolFor(tags.first.currency);

      await SharePlus.instance.share(ShareParams(
        files: files,
        text:
            'Tagpay Invoices - ${tags.length} recipients, $currencySymbol${_amountFormat.format(total)} total',
        subject: 'Lazervault Tagpay Invoices',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share invoices: $e');
    }
  }

  /// Download the receipt to device storage
  static Future<String> downloadReceipt({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? senderAccountNumber,
  }) async {
    try {
      final file = await generateTagPayReceipt(
        transaction: transaction,
        tag: tag,
        senderAccountNumber: senderAccountNumber,
      );
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName:
            'tagpay_receipt_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? senderAccountNumber,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file = await generateTagPayReceipt(
        transaction: transaction,
        tag: tag,
        senderAccountNumber: senderAccountNumber,
      );

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = _amountFormat.format(transaction.amount);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Tagpay Transfer Receipt - $currencySymbol$amount to @${transaction.receiverTagPay}',
        subject: 'Lazervault Tagpay Transfer Confirmation',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Generate a receipt PDF from tag data only (for paid tags without transaction entity)
  /// This creates a simplified receipt using available tag information
  static Future<File> generatePaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    if (!tag.isPaid) {
      throw Exception('Cannot generate receipt for unpaid tag');
    }

    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final paidDate = tag.paidAt != null
        ? _dateFormat.format(tag.paidAt!)
        : _dateFormat.format(tag.createdAt);
    final currencySymbol = _currencySymbolFor(tag.currency);
    final amount = _amountFormat.format(tag.amount);

    // Direction of money is a property of the TRANSACTION, not of who is
    // looking at it. On a paid tag the tagged user always pays and the tagger
    // is always paid. These four lines used to swap on `isOutgoing` (which
    // means "I created this tag", i.e. I am the PAYEE) — so the person who
    // received the money got a receipt naming themselves as the sender, and
    // the two parties held contradictory documents under one reference.
    // All four are USER-SUPPLIED and are sanitised for the PDF font.
    final senderName = _pdfSafeText(tag.taggedUserName);
    final senderTag = _pdfSafeText(tag.taggedUserTagPay);
    final recipientName = _pdfSafeText(tag.taggerName);
    final recipientTag = _pdfSafeText(tag.taggerTagPay);
    final description = _pdfSafeText(tag.description);

    // Generate reference from tag ID
    final reference =
        'TPTAG-${tag.id.length > 8 ? tag.id.substring(0, 8) : tag.id}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          senderName.toUpperCase(),
                          style: _getTextStyle(fontSize: 14, isBold: true),
                        ),
                        pw.SizedBox(height: 4),
                        if (senderTag.isNotEmpty)
                          pw.Text(
                            '@$senderTag',
                            style: _getTextStyle(
                                fontSize: 12, color: PdfColors.grey700),
                          ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: paidDate,
                      completedDate: paidDate,
                      status: _formatTransferStatus(tag.status.name),
                      type: 'Tagpay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference:
                    description.isNotEmpty ? description : 'Tagpay payment',
                tagPayReference: reference,
                transactionId: tag.id,
              ),
              pw.SizedBox(height: 32),

              // Beneficiary Details
              _buildRecipientDetails(
                recipientName: recipientName,
                recipientTag: recipientTag,
                title: 'Beneficiary Details',
              ),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName = 'tagpay_receipt_$reference.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download receipt for a paid tag (without transaction entity)
  static Future<String> downloadPaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file =
          await generatePaidTagReceipt(tag: tag, isOutgoing: isOutgoing);
      final reference =
          'TPTAG-${tag.id.length > 8 ? tag.id.substring(0, 8) : tag.id}';
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'tagpay_receipt_$reference.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share receipt for a paid tag (without transaction entity)
  static Future<void> sharePaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file =
          await generatePaidTagReceipt(tag: tag, isOutgoing: isOutgoing);

      final currencySymbol = _currencySymbolFor(tag.currency);
      final amount = _amountFormat.format(tag.amount);
      // The tagger (isOutgoing) was PAID by the tagged user; the tagged user
      // paid the tagger. Preposition and handle have to move together.
      final counterpartyTag =
          isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;
      final direction = isOutgoing ? 'from' : 'to';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Tagpay Receipt - $currencySymbol$amount $direction @$counterpartyTag',
        subject: 'Lazervault Tagpay Receipt',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  // ─── Fund Transfer Receipt (same visual style as TagPay) ───

  /// Generate a transfer receipt PDF from map-based transfer details
  static Future<File> generateFundTransferReceipt({
    required Map<String, dynamic> transferDetails,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbolFor(currency);
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    // Recipient copy hides the fee (it's the sender's cost); sender copy itemises
    // fee + total paid (amount + fee).
    final showFee = !copyType.isRecipient;

    final recipientName =
        _pdfSafe(transferDetails['recipientName'] as String?) ?? '';
    final recipientAccount =
        _pdfSafe(transferDetails['recipientAccountMasked'] as String?);
    final recipientBank =
        _pdfSafe(transferDetails['recipientBankName'] as String?);
    final sourceAccountName =
        _pdfSafe(transferDetails['sourceAccountName'] as String?);
    final sourceAccountInfo =
        _pdfSafe(transferDetails['sourceAccountInfo'] as String?);
    final reference = transferDetails['reference'] as String? ?? '';
    final narration = _pdfSafe(transferDetails['narration'] as String?);
    final status = transferDetails['status'] as String? ?? 'completed';
    final transferType =
        transferDetails['transferType'] as String? ?? 'Fund Transfer';
    final transferId = transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        '';

    DateTime? timestamp;
    if (transferDetails['timestamp'] != null) {
      timestamp = transferDetails['timestamp'] as DateTime?;
    } else if (transferDetails['createdAt'] != null) {
      timestamp = transferDetails['createdAt'] as DateTime?;
    }
    timestamp ??= DateTime.now();
    final transactionDate = _dateFormat.format(timestamp);

    final formattedStatus = _formatTransferStatus(status);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 8),
              // Which party this copy is for (Sender's / Recipient's Copy).
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text(
                  copyType.label.toUpperCase(),
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey700),
                ),
              ),
              pw.SizedBox(height: 16),

              // Sender and Summary
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
                        pw.Text((sourceAccountName ?? '').toUpperCase(),
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (sourceAccountInfo != null &&
                            sourceAccountInfo.isNotEmpty)
                          pw.Text(sourceAccountInfo,
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
                      status: formattedStatus,
                      type: transferType,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details — SENDER copy: amount + fee + total paid.
              // RECIPIENT copy: amount received only (no fee).
              _buildFundTransferDetails(
                currencySymbol: currencySymbol,
                amount: _amountFormat.format(amount),
                fee: _amountFormat.format(fee),
                showFee: showFee,
                totalPaid: showFee ? _amountFormat.format(amount + fee) : null,
                description: narration ?? '',
                transferReference: _cleanTransferRef(
                    reference.isNotEmpty ? reference : transferId),
              ),
              pw.SizedBox(height: 24),

              // Beneficiary Details
              _buildRecipientDetails(
                recipientName: recipientName,
                recipientTag: recipientAccount ?? '',
                title: 'Beneficiary Details',
              ),
              if (recipientBank != null && recipientBank.isNotEmpty)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 0, top: 4),
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 16),
                    child: _buildDetailRow('Bank', recipientBank),
                  ),
                ),

              // Scannable QR of the transfer reference (same id as the
              // on-screen receipt) so the PDF carries the barcode too.
              pw.SizedBox(height: 24),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: reference.isNotEmpty ? reference : transferId,
                      width: 90,
                      height: 90,
                      drawText: false,
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      reference.isNotEmpty ? reference : transferId,
                      style:
                          _getTextStyle(fontSize: 9, color: PdfColors.grey600),
                    ),
                  ],
                ),
              ),

              pw.Spacer(),
              _buildFooter(transactionType: 'fund transfer'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef = reference.isNotEmpty
        ? reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
        : transferId.isNotEmpty
            ? transferId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
            : 'transfer';
    final fileName = 'transfer_receipt_$safeRef.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a transfer receipt PDF from UnifiedTransaction (for transaction history)
  static Future<File> generateUnifiedTransferReceipt({
    required UnifiedTransaction transaction,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final metadata = transaction.metadata ?? {};

    // A receipt opened from TRANSACTION HISTORY carries none of the keys this
    // used to read: the history mapper writes snake_case (`recipient_name`,
    // `sender_name`, `bank_name`) and puts the direction-resolved counterparty
    // on the ENTITY, while the realtime send-funds flow writes
    // 'Beneficiary Name'/'From'. Every lookup therefore ran off the end of its
    // chain — FROM printed blank and the beneficiary fell through to
    // `transaction.title`, i.e. the SCREEN HEADING ("Tag Payment Received")
    // was printed as the person paid. The entity's counterparty is the last
    // real source; the title is only a placeholder of last resort.
    final recipientName = _firstNonEmpty([
          metadata['Recipient'],
          metadata['Beneficiary Name'],
          metadata['recipientName'],
          metadata['recipient_name'],
          transaction.counterpartyName,
        ]) ??
        transaction.title;
    final sourceAccountName = _firstNonEmpty([
      metadata['Source Account'],
      metadata['From'],
      metadata['sender_name'],
      metadata['senderAccount'],
    ]);
    final sourceAccountInfo = _firstNonEmpty([
      metadata['senderAccount'],
      metadata['sender_account'],
    ]);

    return generateTransferReceiptFile(
      copyType: copyType,
      format: format,
      transferDetails: {
        'amount': transaction.amount,
        'currency': transaction.currency,
        'recipientName': recipientName,
        'recipientAccountMasked': _firstNonEmpty([
          metadata['Recipient Account'],
          metadata['Beneficiary Account'],
          metadata['recipientAccount'],
          metadata['recipient_account'],
          transaction.counterpartyAccount,
        ]),
        'recipientBankName': _firstNonEmpty([
          metadata['recipientBank'],
          metadata['Beneficiary Bank'],
          metadata['bank_name'],
        ]),
        'sourceAccountName': sourceAccountName,
        // Don't print the same string twice when both slots resolved from the
        // one key that was available.
        'sourceAccountInfo':
            sourceAccountInfo == sourceAccountName ? null : sourceAccountInfo,
        'reference': transaction.transactionReference ?? transaction.id,
        'narration': transaction.description,
        'status': transaction.status.displayName,
        'transferType': metadata['Transfer Type']?.toString() ??
            metadata['transferType']?.toString() ??
            'Fund Transfer',
        'transactionId': transaction.id,
        'fee': double.tryParse(
            _firstNonEmpty([metadata['Fee'], metadata['fee']])
                    ?.replaceAll(RegExp(r'[^0-9.]'), '') ??
                '0'),
        'timestamp': transaction.createdAt,
      },
    );
  }

  /// Produce a transfer-receipt FILE in the requested [format] for [copyType].
  /// PDF returns the vector document; PNG/JPG rasterise page 1 of that same PDF
  /// so all three formats are visually identical.
  static Future<File> generateTransferReceiptFile({
    required Map<String, dynamic> transferDetails,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final pdfFile = await generateFundTransferReceipt(
        transferDetails: transferDetails, copyType: copyType);
    if (format == ReceiptFileFormat.pdf) return pdfFile;

    final reference = (transferDetails['reference'] as String?) ?? '';
    final transferId = transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        '';
    final rawRef = reference.isNotEmpty
        ? reference
        : (transferId.isNotEmpty ? transferId : 'transfer');
    final safeRef = rawRef.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final suffix = copyType.isRecipient ? 'recipient' : 'sender';
    return _rasterizeReceipt(
      pdfFile: pdfFile,
      format: format,
      baseName: 'transfer_receipt_${safeRef}_$suffix',
    );
  }

  /// Download transfer receipt from map details
  static Future<String> downloadTransferReceipt({
    required Map<String, dynamic> transferDetails,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateTransferReceiptFile(
          transferDetails: transferDetails, copyType: copyType, format: format);

      final reference = transferDetails['reference'] as String? ?? '';
      final transferId = transferDetails['transferId']?.toString() ??
          transferDetails['transactionId']?.toString() ??
          '';
      final safeRef = reference.isNotEmpty
          ? reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          : transferId.isNotEmpty
              ? transferId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
              : 'transfer';
      final copySuffix = copyType.isRecipient ? '_recipient' : '_sender';
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'transfer_receipt_$safeRef$copySuffix.${format.ext}',
      );
    } catch (e) {
      throw Exception('Failed to download transfer receipt: $e');
    }
  }

  /// Share transfer receipt from map details
  static Future<void> shareTransferReceipt({
    required Map<String, dynamic> transferDetails,
    Rect? sharePositionOrigin,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateTransferReceiptFile(
          transferDetails: transferDetails, copyType: copyType, format: format);

      final currency = transferDetails['currency'] as String? ?? 'NGN';
      final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
      final currencySymbol = _currencySymbolFor(currency);
      final recipientName = transferDetails['recipientName'] as String? ?? '';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Lazervault Transfer Receipt (${copyType.label}) - $currencySymbol${_amountFormat.format(amount)} to $recipientName',
        subject: 'Lazervault Transfer Receipt',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share transfer receipt: $e');
    }
  }

  /// Download transfer receipt from UnifiedTransaction (for transaction history)
  static Future<String> downloadUnifiedTransferReceipt({
    required UnifiedTransaction transaction,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateUnifiedTransferReceipt(
          transaction: transaction, copyType: copyType, format: format);
      final safeRef = (transaction.transactionReference ?? transaction.id)
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'transfer_receipt_$safeRef.${format.ext}',
      );
    } catch (e) {
      throw Exception('Failed to download transfer receipt: $e');
    }
  }

  /// Share transfer receipt from UnifiedTransaction (for transaction history)
  static Future<void> shareUnifiedTransferReceipt({
    required UnifiedTransaction transaction,
    Rect? sharePositionOrigin,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateUnifiedTransferReceipt(
          transaction: transaction, copyType: copyType, format: format);

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = _amountFormat.format(transaction.amount);

      // An invoice payment is not a transfer: name it correctly and reference
      // the invoice number instead of "to <title>" (which produced the absurd
      // "to Invoice Payment").
      final String text;
      final String subject;
      if (transaction.serviceType == TransactionServiceType.invoice) {
        final invoiceNo = transaction.metadata?['Invoice No.']?.toString() ??
            transaction.metadata?['Invoice ID']?.toString();
        subject = 'Lazervault Invoice Receipt';
        text = invoiceNo != null && invoiceNo.isNotEmpty
            ? 'Lazervault Invoice Receipt - $currencySymbol$amount for Invoice #$invoiceNo'
            : 'Lazervault Invoice Receipt - $currencySymbol$amount';
      } else {
        // Same metadata-spelling problem as the PDF body: a history-opened
        // receipt has no 'Recipient' key, so this fell back to the screen
        // TITLE and shared "…to Tag Payment Received". Try every spelling and
        // the entity's counterparty; with no counterparty at all, name no one
        // rather than naming the heading.
        final recipient = _firstNonEmpty([
          transaction.metadata?['Recipient'],
          transaction.metadata?['Beneficiary Name'],
          transaction.metadata?['recipientName'],
          transaction.metadata?['recipient_name'],
          transaction.counterpartyName,
        ]);
        subject = 'Lazervault Transfer Receipt';
        text = recipient != null
            ? 'Lazervault Transfer Receipt - $currencySymbol$amount to $recipient'
            : 'Lazervault Transfer Receipt - $currencySymbol$amount';
      }

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: text,
        subject: subject,
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share transfer receipt: $e');
    }
  }

  // ==========================================================================
  // CRYPTO receipt PDF (buy / sell / swap / send / deposit)
  // ==========================================================================
  /// Revolut-style PDF for a crypto transaction. Reuses the shared transfer
  /// builders (header / summary table / detail rows / QR / footer) but renders
  /// the crypto-specific rows by iterating the UnifiedTransaction metadata
  /// (Asset, Rate, Trading fee, Network fee, Total, To address, Network,
  /// Blockchain txid, Note, Custody, From address …). Recipient + sender
  /// addresses ride in that metadata, so one generator covers every crypto flow.
  static Future<File> generateCryptoReceipt({
    required UnifiedTransaction transaction,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    final metadata = transaction.metadata ?? const {};
    final reference = transaction.transactionReference ?? transaction.id;
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final formattedStatus =
        _formatTransferStatus(transaction.status.displayName);

    // Crypto sends carry a display override ("5 USDT"); buy/sell/swap are fiat.
    final heroAmount = (transaction.amountDisplayOverride != null &&
            transaction.amountDisplayOverride!.trim().isNotEmpty)
        ? transaction.amountDisplayOverride!.trim()
        : '${_currencySymbolFor(transaction.currency)}${_amountFormat.format(transaction.amount)}';

    // Sender: an explicit 'From address' (send flow) or the LazerVault identity.
    final fromLabel = _pdfSafe(metadata['From address']?.toString() ??
            metadata['From']?.toString()) ??
        'LazerVault Wallet';

    // Every metadata entry becomes a label/value row, in insertion order.
    // Minor-unit plumbing (kobo / crypto minor scales) is humanized to naira
    // or dropped — a customer receipt never shows raw ledger units.
    final detailRows = <pw.Widget>[];
    metadata.forEach((k, v) {
      final val = _pdfSafe(v?.toString());
      if (val == null || val.isEmpty) return;
      final human = humanizeReceiptMetadataEntry(k, val);
      if (human == null) return;
      detailRows.add(pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 3),
        child: _buildDetailRow(_pdfSafe(human.label) ?? human.label,
            _pdfSafe(human.value) ?? human.value),
      ));
    });

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(fromLabel.toUpperCase(),
                            style: _getTextStyle(fontSize: 13, isBold: true)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: transactionDate,
                      status: formattedStatus,
                      type: transaction.title,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 24),
              // Hero amount card
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(transaction.title,
                        style: _getTextStyle(
                            fontSize: 11, color: PdfColors.grey600)),
                    pw.SizedBox(height: 4),
                    pw.Text(heroAmount,
                        style: _getTextStyle(fontSize: 22, isBold: true)),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              // Detail rows from metadata (Asset / Rate / fees / addresses / …)
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 16),
                child: pw.Column(children: detailRows),
              ),
              pw.SizedBox(height: 24),
              // Scannable QR of the reference (same id as the on-screen receipt)
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: reference,
                      width: 90,
                      height: 90,
                      drawText: false,
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(reference,
                        style: _getTextStyle(
                            fontSize: 9, color: PdfColors.grey600)),
                  ],
                ),
              ),
              pw.Spacer(),
              _buildFooter(transactionType: 'crypto transaction'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef = reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${output.path}/crypto_receipt_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download the crypto PDF receipt to the device Downloads/Documents dir.
  static Future<String> downloadCryptoReceipt({
    required UnifiedTransaction transaction,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final file = await generateCryptoReceiptFile(
        transaction: transaction, format: format);
    final safeRef = (transaction.transactionReference ?? transaction.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return ReceiptDownload.saveAndOpen(
      source: file,
      fileName: 'crypto_receipt_$safeRef.pdf',
    );
  }

  /// Share the crypto PDF receipt via the system share sheet.
  /// Produce the crypto receipt in the requested format (PNG/JPG rasterise the
  /// same PDF layout).
  static Future<File> generateCryptoReceiptFile({
    required UnifiedTransaction transaction,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final pdfFile = await generateCryptoReceipt(transaction: transaction);
    if (format == ReceiptFileFormat.pdf) return pdfFile;
    final safeRef = (transaction.transactionReference ?? transaction.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return _rasterizeReceipt(
      pdfFile: pdfFile,
      format: format,
      baseName: 'crypto_receipt_$safeRef',
    );
  }

  static Future<void> shareCryptoReceipt({
    required UnifiedTransaction transaction,
    Rect? sharePositionOrigin,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final file = await generateCryptoReceiptFile(
        transaction: transaction, format: format);
    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text:
          'LazerVault Crypto Receipt - ${transaction.title} (${transaction.transactionReference ?? transaction.id})',
      subject: 'LazerVault Crypto Receipt',
      sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
    ));
  }
}
