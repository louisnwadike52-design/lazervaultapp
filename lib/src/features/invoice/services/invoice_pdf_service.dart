import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../domain/entities/invoice_entity.dart';

class InvoicePdfService {
  /// ASCII-safe currency codes for PDF rendering
  /// Using currency codes instead of symbols for better PDF compatibility
  static String _currencySymbolFor(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return 'NGN ';
      case 'GBP':
        return 'GBP ';
      case 'EUR':
        return 'EUR ';
      case 'ZAR':
        return 'ZAR ';
      case 'CAD':
        return 'CAD ';
      case 'AUD':
        return 'AUD ';
      case 'INR':
        return 'INR ';
      case 'JPY':
        return 'JPY ';
      case 'USD':
        return 'USD ';
      default:
        return '$code ';
    }
  }

  static String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String _formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy - HH:mm').format(date);
  }

  /// Generate a professional invoice PDF
  static Future<File> generateInvoicePdf(Invoice invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(invoice),
            pw.SizedBox(height: 32),
            _buildParticipantsInfo(invoice),
            pw.SizedBox(height: 32),
            _buildInvoiceDetails(invoice),
            pw.SizedBox(height: 32),
            _buildItemsTable(invoice),
            pw.SizedBox(height: 24),
            _buildTotalSection(invoice),
            if (invoice.notes?.isNotEmpty == true) ...[
              pw.SizedBox(height: 32),
              _buildNotesSection(invoice),
            ],
            pw.SizedBox(height: 32),
            _buildFooter(),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file =
        File('${output.path}/invoice_${invoice.id.substring(0, 8)}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a professional payment receipt PDF for a paid invoice
  static Future<File> generateInvoiceReceipt(Invoice invoice) async {
    final pdf = pw.Document();
    final currency = _currencySymbolFor(invoice.currency);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with branding
              _buildReceiptHeader(invoice),
              pw.SizedBox(height: 32),

              // Payment confirmation banner
              _buildPaymentConfirmationBanner(invoice, currency),
              pw.SizedBox(height: 32),

              // Sender and recipient info side by side
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: _buildReceiptParticipantCard(
                      'From',
                      invoice.payerDetails,
                      null,
                      null,
                    ),
                  ),
                  pw.SizedBox(width: 24),
                  pw.Expanded(
                    child: _buildReceiptParticipantCard(
                      'To',
                      invoice.recipientDetails,
                      invoice.recipientDetails?.contactName,
                      invoice.recipientDetails?.email,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Payment details section
              _buildPaymentDetails(invoice, currency),
              pw.SizedBox(height: 32),

              // Transaction info section
              _buildTransactionInfo(invoice),
              pw.Spacer(),

              // Footer
              _buildReceiptFooter(invoice),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file =
        File('${output.path}/receipt_${invoice.id.substring(0, 8)}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildReceiptHeader(Invoice invoice) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Branding
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'LazerVault',
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue800,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Text(
                'PAYMENT RECEIPT',
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue800,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        // Receipt details
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Payment Receipt',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey800,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Receipt #${invoice.id.substring(0, 8).toUpperCase()}',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey600,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Generated: ${_formatDateTime(DateTime.now())}',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildPaymentConfirmationBanner(
      Invoice invoice, String currency) {
    final isPaid = invoice.status == InvoiceStatus.paid;
    final statusColor = isPaid ? PdfColors.green700 : PdfColors.orange700;
    final statusBgColor = isPaid ? PdfColors.green50 : PdfColors.orange50;

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: statusBgColor,
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: statusColor, width: 1.5),
      ),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  shape: pw.BoxShape.circle,
                ),
                child: pw.Text(
                  isPaid ? 'OK' : '...',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              pw.SizedBox(width: 12),
              pw.Text(
                isPaid ? 'Payment Successful' : 'Partially Paid',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            '$currency${NumberFormat('#,##0.00').format(isPaid ? invoice.totalAmount : invoice.paidAmount)}',
            style: pw.TextStyle(
              fontSize: 32,
              fontWeight: pw.FontWeight.bold,
              color: statusColor,
            ),
          ),
          pw.SizedBox(height: 8),
          if (invoice.paidAt != null)
            pw.Text(
              'Paid on ${_formatDateTime(invoice.paidAt!)}',
              style: pw.TextStyle(
                fontSize: 12,
                color: statusColor,
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildReceiptParticipantCard(
    String title,
    AddressDetails? details,
    String? fallbackName,
    String? fallbackEmail,
  ) {
    final info = <String>[];

    if (details != null) {
      if (details.companyName?.isNotEmpty == true) info.add(details.companyName!);
      if (details.contactName?.isNotEmpty == true) info.add(details.contactName!);
      if (details.email?.isNotEmpty == true) info.add(details.email!);
      if (details.phone?.isNotEmpty == true) info.add(details.phone!);
      if (details.addressLine1?.isNotEmpty == true) info.add(details.addressLine1!);
      if (details.city?.isNotEmpty == true && details.state?.isNotEmpty == true) {
        info.add('${details.city}, ${details.state}');
      } else if (details.city?.isNotEmpty == true) {
        info.add(details.city!);
      }
      if (details.postcode?.isNotEmpty == true) info.add(details.postcode!);
      if (details.country?.isNotEmpty == true) info.add(details.country!);
    }

    if (info.isEmpty) {
      if (fallbackName?.isNotEmpty == true) info.add(fallbackName!);
      if (fallbackEmail?.isNotEmpty == true) info.add(fallbackEmail!);
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: pw.BoxDecoration(
              color: title == 'From' ? PdfColors.green100 : PdfColors.blue100,
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: title == 'From' ? PdfColors.green700 : PdfColors.blue700,
              ),
            ),
          ),
          pw.SizedBox(height: 12),
          ...info.map((line) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  line,
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey800,
                  ),
                ),
              )),
          if (info.isEmpty)
            pw.Text(
              'Not specified',
              style: pw.TextStyle(
                fontSize: 11,
                color: PdfColors.grey500,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentDetails(Invoice invoice, String currency) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Payment Details',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey800,
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.grey300),
          ),
          child: pw.Column(
            children: [
              _buildPaymentDetailRow('Invoice Title', invoice.title),
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow(
                'Invoice Amount',
                '$currency${NumberFormat('#,##0.00').format(invoice.totalAmount)}',
              ),
              if (invoice.taxAmount != null && invoice.taxAmount! > 0) ...[
                pw.Divider(color: PdfColors.grey300, height: 16),
                _buildPaymentDetailRow(
                  'Tax',
                  '$currency${NumberFormat('#,##0.00').format(invoice.taxAmount)}',
                ),
              ],
              if (invoice.discountAmount != null &&
                  invoice.discountAmount! > 0) ...[
                pw.Divider(color: PdfColors.grey300, height: 16),
                _buildPaymentDetailRow(
                  'Discount',
                  '-$currency${NumberFormat('#,##0.00').format(invoice.discountAmount)}',
                ),
              ],
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow(
                'Amount Paid',
                '$currency${NumberFormat('#,##0.00').format(invoice.status == InvoiceStatus.paid ? invoice.totalAmount : invoice.paidAmount)}',
                isBold: true,
              ),
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow('Payment Method', 'LazerVault Wallet'),
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow('Currency', invoice.currency.toUpperCase()),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildPaymentDetailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: PdfColors.grey700,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: PdfColors.grey800,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTransactionInfo(Invoice invoice) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transaction Information',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey800,
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.grey300),
          ),
          child: pw.Column(
            children: [
              _buildPaymentDetailRow(
                  'Invoice ID', invoice.id.substring(0, 8).toUpperCase()),
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow(
                  'Invoice Date', _formatDate(invoice.createdAt)),
              if (invoice.dueDate != null) ...[
                pw.Divider(color: PdfColors.grey300, height: 16),
                _buildPaymentDetailRow(
                    'Due Date', _formatDate(invoice.dueDate!)),
              ],
              if (invoice.paidAt != null) ...[
                pw.Divider(color: PdfColors.grey300, height: 16),
                _buildPaymentDetailRow(
                    'Payment Date', _formatDateTime(invoice.paidAt!)),
              ],
              if (invoice.paymentReference != null &&
                  invoice.paymentReference!.isNotEmpty) ...[
                pw.Divider(color: PdfColors.grey300, height: 16),
                _buildPaymentDetailRow(
                    'Payment Reference', invoice.paymentReference!),
              ],
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow('Invoice Type', invoice.typeDisplayName),
              pw.Divider(color: PdfColors.grey300, height: 16),
              _buildPaymentDetailRow(
                'Status',
                invoice.status == InvoiceStatus.paid
                    ? 'Paid'
                    : invoice.status == InvoiceStatus.partiallyPaid
                        ? 'Partially Paid'
                        : invoice.status.name.toUpperCase(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildReceiptFooter(Invoice invoice) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300, height: 32),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // QR code placeholder
            pw.Container(
              width: 60,
              height: 60,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400),
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Center(
                child: pw.Text(
                  'QR',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey500,
                  ),
                ),
              ),
            ),
            pw.SizedBox(width: 16),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'LazerVault Financial Services',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'This document is a receipt for your invoice payment. For any queries, please contact our support team through the LazerVault app or email support@lazervault.com.',
                    style: const pw.TextStyle(
                      fontSize: 8,
                      color: PdfColors.grey500,
                      lineSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              '(c) ${DateTime.now().year} LazerVault',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey500,
              ),
            ),
            pw.Text(
              'Page 1 of 1',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildHeader(Invoice invoice) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'INVOICE',
              style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue800,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              invoice.title,
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            if (invoice.description.isNotEmpty) ...[
              pw.SizedBox(height: 4),
              pw.Text(
                invoice.description,
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Invoice #${invoice.id.substring(0, 8).toUpperCase()}',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Date: ${_formatDate(invoice.createdAt)}',
              style: const pw.TextStyle(
                fontSize: 14,
                color: PdfColors.grey700,
              ),
            ),
            if (invoice.dueDate != null) ...[
              pw.SizedBox(height: 4),
              pw.Text(
                'Due: ${_formatDate(invoice.dueDate!)}',
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildParticipantsInfo(Invoice invoice) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: _buildParticipantCard(
            'From',
            invoice.recipientDetails,
            'Your Business',
            null,
          ),
        ),
        pw.SizedBox(width: 24),
        pw.Expanded(
          child: _buildParticipantCard(
            'Bill To',
            invoice.payerDetails,
            invoice.toName ?? 'Client',
            invoice.toEmail,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildParticipantCard(
    String title,
    AddressDetails? details,
    String? fallbackName,
    String? fallbackEmail,
  ) {
    final info = <String>[];

    if (details != null) {
      if (details.companyName?.isNotEmpty == true) info.add(details.companyName!);
      if (details.contactName?.isNotEmpty == true) info.add(details.contactName!);
      if (details.email?.isNotEmpty == true) info.add(details.email!);
      if (details.phone?.isNotEmpty == true) info.add(details.phone!);
      if (details.addressLine1?.isNotEmpty == true) info.add(details.addressLine1!);
      if (details.city?.isNotEmpty == true) info.add(details.city!);
      if (details.state?.isNotEmpty == true) info.add(details.state!);
      if (details.postcode?.isNotEmpty == true) info.add(details.postcode!);
      if (details.country?.isNotEmpty == true) info.add(details.country!);
    } else {
      if (fallbackName?.isNotEmpty == true) info.add(fallbackName!);
      if (fallbackEmail?.isNotEmpty == true) info.add(fallbackEmail!);
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey700,
            ),
          ),
          pw.SizedBox(height: 12),
          ...info.map((line) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  line,
                  style: const pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
              )),
          if (info.isEmpty)
            pw.Text(
              'No information provided',
              style: pw.TextStyle(
                fontSize: 14,
                color: PdfColors.grey600,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildInvoiceDetails(Invoice invoice) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(child: _buildDetailItem('Type', invoice.typeDisplayName)),
          pw.Expanded(child: _buildDetailItem('Currency', invoice.currency)),
        ],
      ),
    );
  }

  static pw.Widget _buildDetailItem(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildItemsTable(Invoice invoice) {
    final currency = _currencySymbolFor(invoice.currency);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Items',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Text(
                    'Description',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Text(
                    'Qty',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Text(
                    'Rate',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Text(
                    'Amount',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
            // Items
            ...invoice.items.map((item) => pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            item.name,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          if (item.description?.isNotEmpty == true) ...[
                            pw.SizedBox(height: 2),
                            pw.Text(
                              item.description!,
                              style: const pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.grey700,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Text(
                        item.quantity.toStringAsFixed(
                          item.quantity.truncateToDouble() == item.quantity
                              ? 0
                              : 1,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Text(
                        '$currency${item.unitPrice.toStringAsFixed(2)}',
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Text(
                        '$currency${item.totalPrice.toStringAsFixed(2)}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTotalSection(Invoice invoice) {
    final currency = _currencySymbolFor(invoice.currency);

    return pw.Column(
      children: [
        if (invoice.taxAmount != null && invoice.taxAmount! > 0)
          _buildTotalRow('Tax', invoice.taxAmount!,
              currencyCode: invoice.currency),
        if (invoice.discountAmount != null && invoice.discountAmount! > 0)
          _buildTotalRow('Discount', -invoice.discountAmount!,
              currencyCode: invoice.currency),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 16),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(color: PdfColors.grey300, width: 2),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Total',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '$currency${invoice.totalAmount.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTotalRow(String label, double amount,
      {String currencyCode = 'NGN'}) {
    final currency = _currencySymbolFor(currencyCode);
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(
              fontSize: 16,
              color: PdfColors.grey700,
            ),
          ),
          pw.Text(
            amount < 0
                ? '-$currency${(-amount).toStringAsFixed(2)}'
                : '$currency${amount.toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: amount < 0 ? PdfColors.red : PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildNotesSection(Invoice invoice) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Notes',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.grey300),
          ),
          child: pw.Text(
            invoice.notes!,
            style: const pw.TextStyle(
              fontSize: 14,
              lineSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300, height: 32),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              '(c) ${DateTime.now().year} LazerVault',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey500,
              ),
            ),
            pw.Text(
              'Page 1 of 1',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future<String> downloadInvoice(Invoice invoice) async {
    try {
      final file = await generateInvoicePdf(invoice);

      // Get appropriate directory based on platform
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

      final fileName = 'invoice_${invoice.id.substring(0, 8)}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download invoice: $e');
    }
  }

  static Future<void> shareInvoice(Invoice invoice) async {
    try {
      final file = await generateInvoicePdf(invoice);
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'Invoice ${invoice.title}',
        subject: 'Invoice #${invoice.id.substring(0, 8).toUpperCase()}',
      ));
    } catch (e) {
      throw Exception('Failed to share invoice: $e');
    }
  }

  static Future<String> downloadReceipt(Invoice invoice) async {
    try {
      final file = await generateInvoiceReceipt(invoice);

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

      final fileName = 'receipt_${invoice.id.substring(0, 8)}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  static Future<void> shareReceipt(Invoice invoice) async {
    try {
      final file = await generateInvoiceReceipt(invoice);
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'Payment Receipt for ${invoice.title}',
        subject: 'Receipt #${invoice.id.substring(0, 8).toUpperCase()}',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
