// PART OF tag_pay_pdf_service.dart (safe decomposition 2026-09-07):
// private members moved VERBATIM out of the TagPayPdfService class as
// library-private top-level declarations. Unqualified call sites inside the
// class resolve identically (class scope falls through to library scope), so
// this is a pure relocation — no behavior change.
part of 'tag_pay_pdf_service.dart';

pw.Widget _buildInvoiceHeader(pw.MemoryImage? logo, String generatedDate,
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
            isInvoice ? 'Tag Invoice' : 'Transfer Confirmation',
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

pw.Widget _buildSenderInfo({
  required TagPayTransactionEntity transaction,
  required UserTagEntity tag,
  String? accountNumber,
}) {
  // User-supplied names/handles are sanitised for the PDF font here rather
  // than at the call site, so every caller of this block gets it.
  final senderName = _pdfSafeText(transaction.senderName.isNotEmpty
      ? transaction.senderName
      : tag.taggedUserName);
  final senderTag = _pdfSafeText(transaction.senderTagPay.isNotEmpty
      ? transaction.senderTagPay
      : tag.taggedUserTagPay);

  return pw.Column(
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
          style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
      if (accountNumber != null && accountNumber.isNotEmpty) ...[
        pw.SizedBox(height: 16),
        pw.Row(
          children: [
            pw.Text(
              'Account Number',
              style: _getTextStyle(fontSize: 11, isBold: true),
            ),
            pw.SizedBox(width: 12),
            pw.Text(
              accountNumber,
              style: _getTextStyle(fontSize: 11),
            ),
          ],
        ),
      ],
    ],
  );
}

pw.Widget _buildSummaryTable({
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

pw.Widget _buildInvoiceDetails({
  required UserTagEntity tag,
  required String currencySymbol,
  required String amount,
  required String description,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Invoice Details',
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
            _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true),
            _buildDetailRow('Currency', _currencyNameFor(tag.currency)),
            if (description.isNotEmpty)
              _buildDetailRow('Description', description),
            _buildDetailRow('Tag ID', tag.id),
            _buildDetailRow(
                'Created', _fullDateTimeFormat.format(tag.createdAt)),
            if (tag.paidAt != null)
              _buildDetailRow('Paid', _fullDateTimeFormat.format(tag.paidAt!)),
          ],
        ),
      ),
    ],
  );
}

/// Fund-transfer details card: amount + fee SEPARATE, ONE "Transfer Reference"
/// (no Tagpay reference, no duplicate Transaction Id). Distinct from the TagPay
/// card below so each service owns its own fields.
pw.Widget _buildFundTransferDetails({
  required String currencySymbol,
  required String amount,
  required String fee,
  required String description,
  required String transferReference,
  // SENDER copy itemises Fee + Total Paid (amount + fee). RECIPIENT copy hides
  // the fee entirely — the recipient received exactly `amount`; the fee is the
  // sender's cost and must never appear on the beneficiary's copy.
  bool showFee = true,
  String? totalPaid,
  /// Service-specific rows appended after the standard ones — e.g. WHICH gift
  /// card a payout was for. Without this the PDF could only render the fixed
  /// transfer fields, so details resolved for the on-screen receipt never
  /// reached the document people actually save and forward.
  List<MapEntry<String, String>> extraRows = const [],
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Transfer details',
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
            _buildDetailRow(showFee ? 'Amount' : 'Amount Received',
                '$currencySymbol$amount',
                isBold: true),
            if (showFee) ...[
              _buildDetailRow('Fee', '$currencySymbol$fee'),
              if (totalPaid != null && totalPaid.isNotEmpty)
                _buildDetailRow('Total Paid', '$currencySymbol$totalPaid',
                    isBold: true),
            ],
            if (description.isNotEmpty)
              _buildDetailRow('Description', description),
            _buildDetailRow('Transfer Reference', transferReference),
            for (final r in extraRows)
              if (r.value.trim().isNotEmpty) _buildDetailRow(r.key, r.value),
          ],
        ),
      ),
    ],
  );
}

/// Tagpay details card. Keeps its OWN "Tagpay Reference" field (no PascalCase).
pw.Widget _buildTransferDetails({
  required String currencySymbol,
  required String amount,
  required String reference,
  required String tagPayReference,
  required String transactionId,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Transfer details',
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
            _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true),
            _buildDetailRow('Reference', reference),
            _buildDetailRow('Tagpay Reference', tagPayReference),
            _buildDetailRow('Transaction Id', transactionId),
          ],
        ),
      ),
    ],
  );
}

pw.Widget _buildRecipientDetails({
  required String recipientName,
  required String recipientTag,
  required String title,
  // Both parties, when the caller knows them. A receipt that names only one
  // side does not record who paid whom — and for a TagPay, where the TAGGED
  // user pays the TAGGER, a reader holding the document cannot tell which
  // side they were on. Optional so callers that genuinely have one party
  // (a tag not yet paid) still render.
  String senderName = '',
  String senderTag = '',
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
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
            if (senderName.isNotEmpty) ...[
              _buildDetailRow('From', senderName),
              if (senderTag.isNotEmpty)
                _isTagHandle(senderTag)
                    ? _buildDetailRow('From tag', '@$senderTag')
                    : _buildDetailRow('From account', senderTag),
            ],
            _buildDetailRow(
              senderName.isNotEmpty ? 'Recipient' : 'Name',
              recipientName,
            ),
            if (recipientTag.isNotEmpty)
              // Handles get the "@" and the "Tag" label; bank account numbers
              // are printed bare under "Account". See [_isTagHandle].
              _isTagHandle(recipientTag)
                  ? _buildDetailRow(
                      senderName.isNotEmpty ? 'Recipient tag' : 'Tag',
                      '@$recipientTag')
                  : _buildDetailRow(
                      senderName.isNotEmpty ? 'Recipient account' : 'Account',
                      recipientTag),
          ],
        ),
      ),
    ],
  );
}
