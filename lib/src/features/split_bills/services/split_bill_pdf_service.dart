import 'dart:io';
import 'dart:ui' show Rect;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../domain/entities/split_bill_entity.dart';

class SplitBillPdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy HH:mm');

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

  /// Resolves who the money was actually paid to. Prefer the explicit receiver
  /// (an LV-user or bank payee); fall back to the creator for legacy bills where
  /// the creator collects.
  static String _resolvePayee(String receiverName, String creatorName) =>
      receiverName.trim().isNotEmpty ? receiverName.trim() : creatorName;

  static Future<File> _generateReceipt({
    required String transactionReference,
    required double amount,
    required String currency,
    required String creatorName,
    required String receiverName,
    String receiverAccountMasked = '',
    required String description,
    required int paidCount,
    required int totalParticipants,
    DateTime? paidAt,
    String status = 'Paid',
  }) async {
    final pdf = pw.Document();
    final currencySymbol = _currencySymbolFor(currency);
    final formattedAmount = '$currencySymbol${amount.toStringAsFixed(2)}';
    // Use the participant's authoritative paid time when provided.
    final now = paidAt ?? DateTime.now();
    final paidTo = _resolvePayee(receiverName, creatorName);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
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
                      'Split Bill Payment Receipt',
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 24),

              // Amount
              pw.Center(
                child: pw.Text(
                  formattedAmount,
                  style: pw.TextStyle(
                    fontSize: 36,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.green50,
                    borderRadius: pw.BorderRadius.circular(12),
                  ),
                  child: pw.Text(
                    'PAID',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green800,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 32),

              // Details
              _buildRow('Paid to', paidTo),
              if (receiverAccountMasked.trim().isNotEmpty) ...[
                pw.SizedBox(height: 8),
                _buildRow('Account', receiverAccountMasked.trim()),
              ],
              pw.SizedBox(height: 8),
              _buildRow('Reference', transactionReference),
              pw.SizedBox(height: 8),
              _buildRow('Status', status),
              pw.SizedBox(height: 8),
              _buildRow('Date', _displayDateFormat.format(now)),
              pw.SizedBox(height: 8),
              _buildRow('Currency', currency),
              if (description.isNotEmpty) ...[
                pw.SizedBox(height: 8),
                _buildRow('Description', description),
              ],
              pw.SizedBox(height: 8),
              _buildRow('Progress', '$paidCount/$totalParticipants paid'),
              pw.SizedBox(height: 32),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 16),

              // Footer
              pw.Center(
                child: pw.Text(
                  'Generated by Lazervault',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef =
        transactionReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${output.path}/split_bill_receipt_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey700,
          ),
        ),
        pw.Flexible(
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// Resolves a writable directory for saving a PDF, never throwing/returning
  /// null. Prefers the platform's Downloads/Documents location but always falls
  /// back to the app's temporary directory — a saved file the user can still
  /// share beats a "couldn't download this summary right now" error.
  static Future<Directory> _resolveSaveDirectory() async {
    try {
      if (Platform.isAndroid) {
        // On Android 11+ the PUBLIC /storage/emulated/0/Download exists but is NOT
        // writable without MANAGE_EXTERNAL_STORAGE (writes throw permission-denied),
        // which read as "download not working". Use the app-scoped external files dir
        // — always writable and visible in file managers under Android/data/<pkg>/files.
        final ext = await getExternalStorageDirectory();
        if (ext != null) return ext;
      } else if (Platform.isIOS) {
        return await getApplicationDocumentsDirectory();
      } else {
        final dl = await getDownloadsDirectory();
        if (dl != null) return dl;
      }
    } catch (_) {
      // fall through to the guaranteed temp dir
    }
    return getTemporaryDirectory();
  }

  /// Writes [bytes] to [fileName] in the best available directory, falling back to
  /// the app's temp dir if the preferred location rejects the write (e.g. scoped
  /// storage). Guarantees a saved file + returned path — never throws on a write.
  static Future<String> _saveResilient(List<int> bytes, String fileName) async {
    final dir = await _resolveSaveDirectory();
    try {
      final f = File('${dir.path}/$fileName');
      await f.writeAsBytes(bytes);
      return f.path;
    } catch (_) {
      final tmp = await getTemporaryDirectory();
      final f = File('${tmp.path}/$fileName');
      await f.writeAsBytes(bytes);
      return f.path;
    }
  }

  static Future<String> downloadReceipt({
    required String transactionReference,
    required double amount,
    required String currency,
    required String creatorName,
    String receiverName = '',
    String receiverAccountMasked = '',
    required String description,
    required int paidCount,
    required int totalParticipants,
    DateTime? paidAt,
    String status = 'Paid',
  }) async {
    final file = await _generateReceipt(
      transactionReference: transactionReference,
      amount: amount,
      currency: currency,
      creatorName: creatorName,
      receiverName: receiverName,
      receiverAccountMasked: receiverAccountMasked,
      description: description,
      paidCount: paidCount,
      totalParticipants: totalParticipants,
      paidAt: paidAt,
      status: status,
    );

    final safeRef =
        transactionReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return _saveResilient(
        await file.readAsBytes(), 'split_bill_receipt_$safeRef.pdf');
  }

  static Future<void> shareReceipt({
    required String transactionReference,
    required double amount,
    required String currency,
    required String creatorName,
    String receiverName = '',
    String receiverAccountMasked = '',
    required String description,
    required int paidCount,
    required int totalParticipants,
    DateTime? paidAt,
    String status = 'Paid',
    // iPad requires an anchor rect for the share sheet or share_plus throws; harmless elsewhere.
    Rect? sharePositionOrigin,
  }) async {
    final file = await _generateReceipt(
      transactionReference: transactionReference,
      amount: amount,
      currency: currency,
      creatorName: creatorName,
      receiverName: receiverName,
      receiverAccountMasked: receiverAccountMasked,
      description: description,
      paidCount: paidCount,
      totalParticipants: totalParticipants,
      paidAt: paidAt,
      status: status,
    );

    final currencySymbol = _currencySymbolFor(currency);
    final formattedAmount = '$currencySymbol${amount.toStringAsFixed(2)}';
    final paidTo = _resolvePayee(receiverName, creatorName);

    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text: 'Split Bill Payment Receipt - $formattedAmount to $paidTo',
      subject: 'Lazervault Split Bill Payment Confirmation',
      sharePositionOrigin: sharePositionOrigin,
    ));
  }

  // ---------------------------------------------------------------------------
  // Creator-facing SHARE SUMMARY — a full overview of the split bill (receiver,
  // total, per-participant breakdown, collection progress) for the organizer to
  // download/share. Mirrors the receipt methods above.
  // ---------------------------------------------------------------------------

  static String _participantStatusLabel(SplitBillParticipantEntity p) {
    return switch (p.status) {
      SplitBillParticipantStatus.paid => 'Paid',
      SplitBillParticipantStatus.inProgress => 'In progress',
      SplitBillParticipantStatus.pending => 'Pending',
      SplitBillParticipantStatus.declined => 'Declined',
    };
  }

  static PdfColor _participantStatusColor(SplitBillParticipantEntity p) {
    return switch (p.status) {
      SplitBillParticipantStatus.paid => PdfColors.green700,
      SplitBillParticipantStatus.inProgress => PdfColors.indigo400,
      SplitBillParticipantStatus.pending => PdfColors.orange700,
      SplitBillParticipantStatus.declined => PdfColors.red700,
    };
  }

  static Future<File> _generateSummary(SplitBillEntity bill) async {
    final pdf = pw.Document();
    final currencySymbol = _currencySymbolFor(bill.currency);
    String money(double v) => '$currencySymbol${v.toStringAsFixed(2)}';
    final now = DateTime.now();
    final payee = bill.receiverDisplay;
    final title = bill.displayTitle;

    pw.Widget participantRow(SplitBillParticipantEntity p) {
      final name =
          p.displayName.isNotEmpty ? p.displayName : '@${p.username}';
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6),
        child: pw.Row(
          children: [
            pw.Expanded(
              flex: 4,
              child: pw.Text(
                name,
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
            pw.Expanded(
              flex: 2,
              child: pw.Text(
                money(p.amount),
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              flex: 2,
              child: pw.Text(
                _participantStatusLabel(p),
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  color: _participantStatusColor(p),
                ),
              ),
            ),
          ],
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // Header
          pw.Center(
            child: pw.Column(
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
                  'Split Bill Summary',
                  style: pw.TextStyle(fontSize: 14, color: PdfColors.grey600),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 24),
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Divider(color: PdfColors.grey300),
          pw.SizedBox(height: 16),

          // Overview
          _buildRow('Reference', bill.reference),
          pw.SizedBox(height: 8),
          _buildRow('Paying to', payee),
          if (bill.receiverAccountMasked.trim().isNotEmpty) ...[
            pw.SizedBox(height: 8),
            _buildRow('Account', bill.receiverAccountMasked.trim()),
          ],
          pw.SizedBox(height: 8),
          _buildRow('Organizer',
              bill.creatorName.isNotEmpty
                  ? bill.creatorName
                  : '@${bill.creatorUsername}'),
          pw.SizedBox(height: 8),
          _buildRow('Total', money(bill.totalAmount)),
          pw.SizedBox(height: 8),
          _buildRow(
            'Collected',
            '${money(bill.paidAmount)}  (${bill.paidCount}/${bill.totalParticipants} paid)',
          ),
          pw.SizedBox(height: 8),
          _buildRow('Date', _displayDateFormat.format(now)),
          pw.SizedBox(height: 24),

          // Participant breakdown
          pw.Text(
            'Participants',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Divider(color: PdfColors.grey300),
          ...bill.participants.map(participantRow),
          pw.SizedBox(height: 24),
          pw.Divider(color: PdfColors.grey300),
          pw.SizedBox(height: 16),
          pw.Center(
            child: pw.Text(
              'Generated by Lazervault',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
            ),
          ),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef = bill.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${output.path}/split_bill_summary_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static Future<String> downloadSummary(SplitBillEntity bill) async {
    final file = await _generateSummary(bill);
    final safeRef = bill.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return _saveResilient(
        await file.readAsBytes(), 'split_bill_summary_$safeRef.pdf');
  }

  static Future<void> shareSummary(SplitBillEntity bill,
      {Rect? sharePositionOrigin}) async {
    final file = await _generateSummary(bill);
    final currencySymbol = _currencySymbolFor(bill.currency);
    final formattedTotal =
        '$currencySymbol${bill.totalAmount.toStringAsFixed(2)}';

    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text:
          'Split Bill Summary - $formattedTotal · ${bill.paidCount}/${bill.totalParticipants} paid',
      subject: 'Lazervault Split Bill Summary',
      sharePositionOrigin: sharePositionOrigin,
    ));
  }
}
