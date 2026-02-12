import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/pay_slip_entity.dart';

class PayrollPdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final _numberFormat = NumberFormat('#,##0.00');

  // Cache for loaded fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

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

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
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

  /// Format a currency amount using NGN code for PDF compatibility
  static String _formatAmount(double amount) {
    return 'NGN ${_numberFormat.format(amount)}';
  }

  /// Get display label for payment status
  static String _paymentStatusLabel(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.failed:
        return 'Failed';
    }
  }

  /// Get color for payment status
  static PdfColor _paymentStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.paid:
        return PdfColors.green700;
      case PaymentStatus.pending:
        return PdfColors.orange700;
      case PaymentStatus.failed:
        return PdfColors.red700;
    }
  }

  /// Generate a professional pay slip PDF
  static Future<File> generatePaySlipPdf(PaySlipEntity slip) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final paySlipDate = _displayDateFormat.format(slip.createdAt);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(logo, generatedDate, paySlipDate),
              pw.SizedBox(height: 24),

              // Employee Info
              _buildEmployeeInfo(slip),
              pw.SizedBox(height: 24),

              // Earnings Section
              _buildEarningsSection(slip),
              pw.SizedBox(height: 24),

              // Deductions Table
              _buildDeductionsSection(slip),
              pw.SizedBox(height: 24),

              // Employer Contributions
              _buildEmployerContributions(slip),
              pw.SizedBox(height: 24),

              // Net Pay (highlighted)
              _buildNetPaySection(slip),
              pw.SizedBox(height: 24),

              // Payment Reference & Date
              _buildPaymentDetails(slip),

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
        'payslip_${slip.id.substring(0, 8)}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download pay slip to device storage, returns file path
  static Future<String> downloadPaySlip(PaySlipEntity slip) async {
    try {
      final file = await generatePaySlipPdf(slip);

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

      final fileName = 'payslip_${slip.id.substring(0, 8)}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download pay slip: $e');
    }
  }

  /// Share pay slip via system share sheet
  static Future<void> sharePaySlip(PaySlipEntity slip) async {
    try {
      final file = await generatePaySlipPdf(slip);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Pay Slip - ${slip.employeeName} - Net Pay: ${_formatAmount(slip.netPay)}',
        subject: 'LazerVault Payroll - Pay Slip',
      ));
    } catch (e) {
      throw Exception('Failed to share pay slip: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // PDF Section Builders
  // ---------------------------------------------------------------------------

  static pw.Widget _buildHeader(
    pw.MemoryImage? logo,
    String generatedDate,
    String paySlipDate,
  ) {
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
            pw.SizedBox(height: 4),
            pw.Text(
              'Payroll',
              style: _getTextStyle(fontSize: 14, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Pay Slip',
              style: _getTextStyle(fontSize: 24, isBold: true)
                  .copyWith(color: PdfColors.grey800),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Pay Date: $paySlipDate',
              style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              'Generated on $generatedDate',
              style: _getTextStyle(fontSize: 10, color: PdfColors.grey500),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildEmployeeInfo(PaySlipEntity slip) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.blue100),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Employee',
                    style: _getTextStyle(
                        fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(slip.employeeName.toUpperCase(),
                    style: _getTextStyle(fontSize: 14, isBold: true)),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('Employee ID',
                    style: _getTextStyle(
                        fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(
                  slip.employeeId.length > 8
                      ? slip.employeeId.substring(0, 8)
                      : slip.employeeId,
                  style: _getTextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildEarningsSection(PaySlipEntity slip) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Earnings',
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
              _buildDetailRow('Gross Pay', _formatAmount(slip.grossPay),
                  isBold: true),
              if (slip.overtimeHours > 0) ...[
                _buildDetailRow(
                    'Overtime (${slip.overtimeHours.toStringAsFixed(1)} hrs)',
                    _formatAmount(slip.overtimePay)),
              ],
              if (slip.bonuses > 0)
                _buildDetailRow('Bonuses', _formatAmount(slip.bonuses)),
              if (slip.commissions > 0)
                _buildDetailRow('Commissions', _formatAmount(slip.commissions)),
              if (slip.hoursWorked > 0)
                _buildDetailRow(
                    'Hours Worked', slip.hoursWorked.toStringAsFixed(1)),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDeductionsSection(PaySlipEntity slip) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Deductions',
          style: _getTextStyle(fontSize: 16, isBold: true),
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.red50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.red100),
          ),
          child: pw.Column(
            children: [
              if (slip.incomeTax > 0)
                _buildDetailRow('PAYE (Income Tax)', _formatAmount(slip.incomeTax)),
              if (slip.pensionContribution > 0)
                _buildDetailRow('Pension Contribution',
                    _formatAmount(slip.pensionContribution)),
              if (slip.nationalInsurance > 0)
                _buildDetailRow(
                    'NHF', _formatAmount(slip.nationalInsurance)),
              if (slip.studentLoanRepayment > 0)
                _buildDetailRow('Student Loan Repayment',
                    _formatAmount(slip.studentLoanRepayment)),
              if (slip.otherDeductions > 0)
                _buildDetailRow(
                    'Other Deductions', _formatAmount(slip.otherDeductions)),
              pw.Divider(color: PdfColors.red200),
              _buildDetailRow(
                'Total Deductions',
                _formatAmount(slip.totalDeductions),
                isBold: true,
                valueColor: PdfColors.red700,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildEmployerContributions(PaySlipEntity slip) {
    if (slip.employerNIC <= 0 && slip.employerPension <= 0) {
      return pw.SizedBox.shrink();
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Employer Contributions',
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
              if (slip.employerNIC > 0)
                _buildDetailRow(
                    'Employer NIC', _formatAmount(slip.employerNIC)),
              if (slip.employerPension > 0)
                _buildDetailRow(
                    'Employer Pension', _formatAmount(slip.employerPension)),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildNetPaySection(PaySlipEntity slip) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.green50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.green200, width: 1.5),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'NET PAY',
            style: _getTextStyle(fontSize: 18, isBold: true)
                .copyWith(color: PdfColors.green800),
          ),
          pw.Text(
            _formatAmount(slip.netPay),
            style: _getTextStyle(fontSize: 22, isBold: true)
                .copyWith(color: PdfColors.green800),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentDetails(PaySlipEntity slip) {
    final statusLabel = _paymentStatusLabel(slip.paymentStatus);
    final statusColor = _paymentStatusColor(slip.paymentStatus);

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Column(
        children: [
          _buildDetailRow('Payment Reference', slip.paymentReference),
          _buildDetailRow(
              'Payment Date', _fullDateTimeFormat.format(slip.createdAt)),
          _buildDetailRow('Status', statusLabel, valueColor: statusColor),
        ],
      ),
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
            width: 160,
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
            'This document is a payroll pay slip generated through the LazerVault platform. '
            'For any queries regarding this pay slip, please contact support through the LazerVault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
