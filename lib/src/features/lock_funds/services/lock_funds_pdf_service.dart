import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/lock_fund_entity.dart';

class LockFundsPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  // Cache for loaded fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Get currency symbol - using ASCII-safe alternatives for PDF compatibility
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
      case 'CAD':
        return 'CAD ';
      case 'AUD':
        return 'AUD ';
      case 'INR':
        return 'INR ';
      case 'JPY':
        return 'JPY ';
      default:
        return '$code ';
    }
  }

  /// Get display currency name
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

  /// Load fonts that support unicode characters
  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;

    try {
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));

      if (regularResponse.statusCode == 200 && boldResponse.statusCode == 200) {
        _regularFont = pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (e) {
      _regularFont = null;
      _boldFont = null;
    }
  }

  /// Get text style with proper font
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

  /// Generate a professional withdrawal receipt PDF
  static Future<File> generateWithdrawalReceipt({
    required LockFund lockFund,
    required double amountReturned,
    required double penaltyAmount,
    required double interestEarned,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final withdrawalDate = _dateFormat.format(DateTime.now());
    final currencySymbol = _currencySymbolFor(lockFund.currency);

    final isEarlyWithdrawal = penaltyAmount > 0;
    final reference = lockFund.transactionId ?? 'LF-${lockFund.id.length > 8 ? lockFund.id.substring(0, 8) : lockFund.id}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(logo, generatedDate, isEarlyWithdrawal: isEarlyWithdrawal),
              pw.SizedBox(height: 24),

              // Lock Info and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildLockInfo(lockFund),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      lockedDate: _dateFormat.format(lockFund.lockedAt),
                      maturityDate: _dateFormat.format(lockFund.unlockAt),
                      withdrawalDate: withdrawalDate,
                      status: isEarlyWithdrawal ? 'Early Withdrawal' : 'Matured Withdrawal',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Withdrawal Details
              _buildWithdrawalDetails(
                lockFund: lockFund,
                currencySymbol: currencySymbol,
                amountReturned: amountReturned,
                penaltyAmount: penaltyAmount,
                interestEarned: interestEarned,
              ),
              pw.SizedBox(height: 32),

              // Transaction Reference
              _buildReferenceSection(
                reference: reference,
                lockId: lockFund.id,
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
    final fileName = 'lock_withdrawal_${reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a lock creation confirmation PDF
  static Future<File> generateLockConfirmation({
    required LockFund lockFund,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final currencySymbol = _currencySymbolFor(lockFund.currency);

    final reference = lockFund.transactionId ?? 'LF-${lockFund.id.length > 8 ? lockFund.id.substring(0, 8) : lockFund.id}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(logo, generatedDate, isLockCreation: true),
              pw.SizedBox(height: 24),

              // Lock Info and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildLockInfo(lockFund),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildLockSummaryTable(
                      lockedDate: _dateFormat.format(lockFund.lockedAt),
                      maturityDate: _dateFormat.format(lockFund.unlockAt),
                      duration: lockFund.durationText,
                      interestRate: lockFund.formattedInterestRate,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Lock Details
              _buildLockDetails(
                lockFund: lockFund,
                currencySymbol: currencySymbol,
              ),
              pw.SizedBox(height: 32),

              // Terms
              _buildLockTerms(lockFund),
              pw.SizedBox(height: 32),

              // Transaction Reference
              _buildReferenceSection(
                reference: reference,
                lockId: lockFund.id,
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
    final fileName = 'lock_confirmation_${reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(
    pw.MemoryImage? logo,
    String generatedDate, {
    bool isEarlyWithdrawal = false,
    bool isLockCreation = false,
  }) {
    String title;
    if (isLockCreation) {
      title = 'Lock Confirmation';
    } else if (isEarlyWithdrawal) {
      title = 'Early Withdrawal Receipt';
    } else {
      title = 'Withdrawal Receipt';
    }

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
              title,
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

  static pw.Widget _buildLockInfo(LockFund lockFund) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('LOCK DETAILS',
            style: _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.SizedBox(height: 4),
        pw.Text(
          lockFund.displayName.toUpperCase(),
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          lockFund.lockType.displayName,
          style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          lockFund.lockType.subtitle,
          style: _getTextStyle(fontSize: 11, color: PdfColors.grey600),
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String lockedDate,
    required String maturityDate,
    required String withdrawalDate,
    required String status,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Locked Date', lockedDate),
        _buildSummaryRow('Maturity Date', maturityDate),
        _buildSummaryRow('Withdrawal Date', withdrawalDate),
        _buildSummaryRow('Status', status),
      ],
    );
  }

  static pw.Widget _buildLockSummaryTable({
    required String lockedDate,
    required String maturityDate,
    required String duration,
    required String interestRate,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Locked Date', lockedDate),
        _buildSummaryRow('Maturity Date', maturityDate),
        _buildSummaryRow('Duration', duration),
        _buildSummaryRow('Interest Rate', interestRate),
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
          pw.Text(
            label,
            style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
          pw.Text(
            value,
            style: _getTextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildWithdrawalDetails({
    required LockFund lockFund,
    required String currencySymbol,
    required double amountReturned,
    required double penaltyAmount,
    required double interestEarned,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Withdrawal Breakdown',
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
              _buildDetailRow(
                'Principal Amount',
                '$currencySymbol${lockFund.amount.toStringAsFixed(2)}',
              ),
              _buildDetailRow(
                'Interest Earned',
                '+$currencySymbol${interestEarned.toStringAsFixed(2)}',
                valueColor: PdfColors.green700,
              ),
              if (penaltyAmount > 0)
                _buildDetailRow(
                  'Early Withdrawal Penalty (${lockFund.earlyUnlockPenaltyPercent.toStringAsFixed(0)}%)',
                  '-$currencySymbol${penaltyAmount.toStringAsFixed(2)}',
                  valueColor: PdfColors.red700,
                ),
              pw.Divider(color: PdfColors.grey300),
              _buildDetailRow(
                'Total Amount Received',
                '$currencySymbol${amountReturned.toStringAsFixed(2)}',
                isBold: true,
                valueColor: PdfColors.blue800,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildLockDetails({
    required LockFund lockFund,
    required String currencySymbol,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Lock Details',
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
              _buildDetailRow(
                'Principal Amount',
                '$currencySymbol${lockFund.amount.toStringAsFixed(2)}',
                isBold: true,
              ),
              _buildDetailRow(
                'Currency',
                _currencyNameFor(lockFund.currency),
              ),
              _buildDetailRow(
                'Interest Rate',
                lockFund.formattedInterestRate,
              ),
              _buildDetailRow(
                'Lock Duration',
                lockFund.durationText,
              ),
              _buildDetailRow(
                'Expected Interest',
                '+$currencySymbol${lockFund.accruedInterest.toStringAsFixed(2)}',
                valueColor: PdfColors.green700,
              ),
              pw.Divider(color: PdfColors.grey300),
              _buildDetailRow(
                'Expected Total at Maturity',
                '$currencySymbol${lockFund.totalValue.toStringAsFixed(2)}',
                isBold: true,
                valueColor: PdfColors.blue800,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildLockTerms(LockFund lockFund) {
    final terms = <String>[];

    if (lockFund.lockType.allowsEarlyWithdrawal) {
      if (lockFund.earlyUnlockPenaltyPercent > 0) {
        terms.add(
            'Early withdrawal incurs a ${lockFund.earlyUnlockPenaltyPercent.toStringAsFixed(0)}% penalty on principal.');
      } else {
        terms.add('Withdraw anytime without penalties.');
      }
    } else {
      terms.add('Early withdrawal is not permitted for this lock type.');
    }

    terms.add('Interest is calculated daily and credited at maturity.');

    if (lockFund.autoRenew) {
      terms.add('Auto-renewal is enabled. Lock will automatically renew at maturity.');
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Terms & Conditions',
          style: _getTextStyle(fontSize: 16, isBold: true),
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.blue100),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: terms
                .map((term) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('- ',
                              style: _getTextStyle(fontSize: 10, color: PdfColors.grey700)),
                          pw.Expanded(
                            child: pw.Text(
                              term,
                              style: _getTextStyle(fontSize: 10, color: PdfColors.grey700),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildReferenceSection({
    required String reference,
    required String lockId,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transaction Reference',
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
              _buildDetailRow('Reference', reference),
              _buildDetailRow('Lock ID', lockId),
              _buildDetailRow('Timestamp', _fullDateTimeFormat.format(DateTime.now())),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    PdfColor? valueColor,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 180,
            child: pw.Text(
              label,
              style: _getTextStyle(fontSize: 11, isBold: true)
                  .copyWith(color: PdfColors.grey700),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: _getTextStyle(fontSize: 11, isBold: isBold)
                  .copyWith(color: valueColor),
              textAlign: pw.TextAlign.right,
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
        pw.SizedBox(height: 12),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Need help?',
                  style: _getTextStyle(fontSize: 10, isBold: true),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Get help directly in-app',
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  '(C) ${DateTime.now().year} LazerVault Technologies Ltd',
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Page 1 of 1',
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey500),
                ),
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
            'LazerVault Technologies Ltd is a financial technology company. '
            'This document is a confirmation of a Lock Fund transaction processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Download the withdrawal receipt to device storage
  static Future<String> downloadWithdrawalReceipt({
    required LockFund lockFund,
    required double amountReturned,
    required double penaltyAmount,
    required double interestEarned,
  }) async {
    try {
      final file = await generateWithdrawalReceipt(
        lockFund: lockFund,
        amountReturned: amountReturned,
        penaltyAmount: penaltyAmount,
        interestEarned: interestEarned,
      );

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

      final reference = lockFund.transactionId ?? 'LF-${lockFund.id.length > 8 ? lockFund.id.substring(0, 8) : lockFund.id}';
      final fileName = 'lock_withdrawal_${reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the withdrawal receipt via system share sheet
  static Future<void> shareWithdrawalReceipt({
    required LockFund lockFund,
    required double amountReturned,
    required double penaltyAmount,
    required double interestEarned,
  }) async {
    try {
      final file = await generateWithdrawalReceipt(
        lockFund: lockFund,
        amountReturned: amountReturned,
        penaltyAmount: penaltyAmount,
        interestEarned: interestEarned,
      );

      final currencySymbol = _currencySymbolFor(lockFund.currency);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'Lock Fund Withdrawal Receipt - $currencySymbol${amountReturned.toStringAsFixed(2)} from ${lockFund.displayName}',
        subject: 'LazerVault Lock Fund Withdrawal Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Download the lock confirmation to device storage
  static Future<String> downloadLockConfirmation({
    required LockFund lockFund,
  }) async {
    try {
      final file = await generateLockConfirmation(lockFund: lockFund);

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

      final reference = lockFund.transactionId ?? 'LF-${lockFund.id.length > 8 ? lockFund.id.substring(0, 8) : lockFund.id}';
      final fileName = 'lock_confirmation_${reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download confirmation: $e');
    }
  }

  /// Share the lock confirmation via system share sheet
  static Future<void> shareLockConfirmation({
    required LockFund lockFund,
  }) async {
    try {
      final file = await generateLockConfirmation(lockFund: lockFund);

      final currencySymbol = _currencySymbolFor(lockFund.currency);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'Lock Fund Confirmation - $currencySymbol${lockFund.amount.toStringAsFixed(2)} locked in ${lockFund.displayName}',
        subject: 'LazerVault Lock Fund Confirmation',
      ));
    } catch (e) {
      throw Exception('Failed to share confirmation: $e');
    }
  }
}
