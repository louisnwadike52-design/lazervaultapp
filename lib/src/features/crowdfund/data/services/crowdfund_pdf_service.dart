import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crowdfund_entities.dart';

class CrowdfundPdfService {
  /// Generate a PDF receipt for a crowdfund donation
  Future<File> generateDonationReceipt(
    CrowdfundReceipt receipt,
    CrowdfundDonation donation,
    Crowdfund crowdfund,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(40),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                pw.SizedBox(height: 40),

                // Receipt title
                pw.Center(
                  child: pw.Text(
                    'DONATION RECEIPT',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.purple900,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    'Receipt #${receipt.receiptNumber}',
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                ),
                pw.SizedBox(height: 40),

                // Divider
                pw.Divider(thickness: 2, color: PdfColors.purple900),
                pw.SizedBox(height: 20),

                // Receipt details
                _buildReceiptSection(
                  'Donation Information',
                  [
                    ['Donation ID:', donation.id],
                    ['Date & Time:', DateFormat('MMMM dd, yyyy • hh:mm a').format(donation.donationDate)],
                    ['Amount:', '${donation.currency} ${donation.amount.toStringAsFixed(2)}'],
                    ['Payment Method:', donation.paymentMethod],
                    if (donation.transactionId != null)
                      ['Transaction ID:', donation.transactionId!],
                    ['Status:', _getStatusText(donation.status)],
                  ],
                ),

                pw.SizedBox(height: 24),

                // Crowdfund details
                _buildReceiptSection(
                  'Campaign Details',
                  [
                    ['Campaign:', crowdfund.title],
                    ['Category:', crowdfund.category],
                    ['Campaign Code:', crowdfund.crowdfundCode],
                    ['Creator:', '${crowdfund.creator.firstName} ${crowdfund.creator.lastName}${crowdfund.creator.verified ? ' (Verified)' : ''}'],
                  ],
                ),

                pw.SizedBox(height: 24),

                // Donor details
                if (!donation.isAnonymous)
                  _buildReceiptSection(
                    'Donor Information',
                    [
                      ['Name:', receipt.donorName],
                      ['Donor ID:', donation.donorUserId.toString()],
                    ],
                  ),

                if (donation.message != null && donation.message!.isNotEmpty) ...[
                  pw.SizedBox(height: 24),
                  pw.Text(
                    'Message',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.purple900,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                    ),
                    child: pw.Text(
                      donation.message!,
                      style: const pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.grey800,
                      ),
                    ),
                  ),
                ],

                pw.Spacer(),

                // Footer
                pw.Divider(thickness: 1, color: PdfColors.grey400),
                pw.SizedBox(height: 12),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Generated: ${DateFormat('MMM dd, yyyy • hh:mm a').format(receipt.generatedAt)}',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.Text(
                      'LazerVault Crowdfunding',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.purple900,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    'Thank you for your generous support!',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save to temporary directory
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/receipt_${receipt.receiptNumber}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  /// Share a donation receipt PDF
  Future<void> shareReceipt(
    CrowdfundReceipt receipt,
    CrowdfundDonation donation,
    Crowdfund crowdfund,
  ) async {
    try {
      final file = await generateDonationReceipt(receipt, donation, crowdfund);

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Crowdfund Donation Receipt - ${receipt.receiptNumber}',
        text: 'Thank you for your donation to ${crowdfund.title}!',
      );
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Download receipt to device storage
  Future<String> downloadReceipt(
    CrowdfundReceipt receipt,
    CrowdfundDonation donation,
    Crowdfund crowdfund,
  ) async {
    try {
      final file = await generateDonationReceipt(receipt, donation, crowdfund);

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

      final fileName = 'LazerVault_Receipt_${receipt.receiptNumber}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  // Helper methods

  pw.Widget _buildHeader() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'LazerVault',
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.purple900,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Crowdfunding Platform',
              style: const pw.TextStyle(
                fontSize: 12,
                color: PdfColors.grey600,
              ),
            ),
          ],
        ),
        pw.Container(
          width: 60,
          height: 60,
          decoration: pw.BoxDecoration(
            color: PdfColors.purple900,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Center(
            child: pw.Text(
              'LV',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildReceiptSection(String title, List<List<String>> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.purple900,
          ),
        ),
        pw.SizedBox(height: 12),
        ...items.map((item) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 140,
                child: pw.Text(
                  item[0],
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey700,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  item[1],
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  String _getStatusText(DonationStatus status) {
    switch (status) {
      case DonationStatus.pending:
        return 'Pending';
      case DonationStatus.processing:
        return 'Processing';
      case DonationStatus.completed:
        return 'Completed';
      case DonationStatus.failed:
        return 'Failed';
      case DonationStatus.refunded:
        return 'Refunded';
    }
  }
}
