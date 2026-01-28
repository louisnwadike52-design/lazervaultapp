import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../domain/entities/invoice_entity.dart';

class InvoicePdfService {
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
    final file = File('${output.path}/invoice_${invoice.id.substring(0, 8)}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
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
            invoice.payerDetails,
            'Your Business',
            null,
          ),
        ),
        pw.SizedBox(width: 24),
        pw.Expanded(
          child: _buildParticipantCard(
            'To',
            invoice.recipientDetails,
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
          pw.Expanded(child: _buildDetailItem('Status', invoice.statusDisplayName)),
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
                      item.quantity.truncateToDouble() == item.quantity ? 0 : 1,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Text(
                    '\$${item.unitPrice.toStringAsFixed(2)}',
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
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
    return pw.Column(
      children: [
        if (invoice.taxAmount != null && invoice.taxAmount! > 0)
          _buildTotalRow('Tax', invoice.taxAmount!),
        if (invoice.discountAmount != null && invoice.discountAmount! > 0)
          _buildTotalRow('Discount', -invoice.discountAmount!),
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
                '\$${invoice.totalAmount.toStringAsFixed(2)}',
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

  static pw.Widget _buildTotalRow(String label, double amount) {
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
            amount < 0 ? '-\$${(-amount).toStringAsFixed(2)}' : '\$${amount.toStringAsFixed(2)}',
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
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 32),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.grey300),
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          'Generated by LazerVault',
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey600,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static Future<void> downloadInvoice(Invoice invoice) async {
    try {
      final file = await generateInvoicePdf(invoice);
      await Printing.sharePdf(
        bytes: await file.readAsBytes(),
        filename: 'invoice_${invoice.id.substring(0, 8)}.pdf',
      );
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
} 