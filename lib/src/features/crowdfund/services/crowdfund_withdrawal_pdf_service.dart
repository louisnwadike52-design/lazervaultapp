import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_withdrawal_receipt.dart';

/// Shareable receipt for a campaign withdrawal.
///
/// Renders the SAME lines the on-screen receipt shows
/// (CrowdfundWithdrawalReceipt), so the document a creator forwards to a
/// co-organiser cannot disagree with what they were shown.
///
/// Build and share are separate: [buildBytes] is pure and testable, while
/// writing to disk needs a platform binding.
class CrowdfundWithdrawalPdfService {
  static const _primaryColor = PdfColor.fromInt(0xFF4E03D0);
  static const _mutedColor = PdfColor.fromInt(0xFF6B7280);
  static const _successColor = PdfColor.fromInt(0xFF10B981);

  static Future<Uint8List> buildBytes(
      CrowdfundWithdrawalReceipt receipt) async {
    // Inter BEFORE any currency decision: the built-in PDF font has no ₦ and
    // the pdf package raises rather than substituting.
    await ReceiptFonts.load();
    final doc = pw.Document(
      theme: ReceiptFonts.embedded
          ? pw.ThemeData.withFont(
              base: ReceiptFonts.regular!,
              bold: ReceiptFonts.bold!,
            )
          : null,
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => [
          pw.Text('Lazervault',
              style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: _primaryColor)),
          pw.SizedBox(height: 4),
          pw.Text('Campaign withdrawal receipt',
              style: const pw.TextStyle(fontSize: 14)),
          pw.SizedBox(height: 16),
          pw.Text(receipt.title,
              style:
                  pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 2),
          pw.Text(
            DateFormat('d MMM yyyy, h:mm a').format(receipt.createdAt),
            style: pw.TextStyle(fontSize: 10, color: _mutedColor),
          ),
          pw.SizedBox(height: 18),
          ...receipt.lines.map(
            (l) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 5),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(l.label,
                      style: pw.TextStyle(
                          fontSize: l.emphasise ? 12 : 11,
                          color: l.emphasise ? PdfColors.black : _mutedColor)),
                  pw.Text(
                    l.value,
                    style: pw.TextStyle(
                      fontSize: l.emphasise ? 13 : 11,
                      fontWeight: l.emphasise
                          ? pw.FontWeight.bold
                          : pw.FontWeight.normal,
                      color: l.emphasise ? _successColor : PdfColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 14),
          pw.Divider(color: PdfColors.grey300),
          pw.SizedBox(height: 8),
          pw.Text(receipt.destinationNote,
              style: pw.TextStyle(fontSize: 11, color: _mutedColor)),
          pw.SizedBox(height: 4),
          pw.Text('Reference ${receipt.reference}',
              style: pw.TextStyle(fontSize: 9, color: _mutedColor)),
        ],
      ),
    );

    return doc.save();
  }

  static Future<File> generate(CrowdfundWithdrawalReceipt receipt) async {
    final bytes = await buildBytes(receipt);
    final dir = await getTemporaryDirectory();
    final stamp = DateFormat('yyyyMMdd_HHmmss').format(receipt.createdAt);
    final file = File('${dir.path}/Lazervault_Withdrawal_$stamp.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> share(CrowdfundWithdrawalReceipt receipt) async {
    final file = await generate(receipt);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Lazervault campaign withdrawal receipt',
        // iOS refuses a zero popover anchor and throws the whole share away.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      ),
    );
  }
}
