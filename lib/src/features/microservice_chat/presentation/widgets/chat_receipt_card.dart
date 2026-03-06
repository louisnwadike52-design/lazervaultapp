import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

/// Structured receipt data from a successful transfer.
class TransferReceiptData {
  final String receiptId;
  final String type;
  final String transferType;
  final String status;
  final int amount;
  final String amountDisplay;
  final String currency;
  final String reference;
  final String recipientName;
  final String recipientBank;
  final String recipientAccount;
  final String senderAccountId;
  final int newBalance;
  final String newBalanceDisplay;
  final int fee;
  final String feeDisplay;
  final DateTime timestamp;

  const TransferReceiptData({
    required this.receiptId,
    required this.type,
    required this.transferType,
    required this.status,
    required this.amount,
    required this.amountDisplay,
    required this.currency,
    required this.reference,
    required this.recipientName,
    this.recipientBank = '',
    this.recipientAccount = '',
    this.senderAccountId = '',
    this.newBalance = 0,
    this.newBalanceDisplay = '',
    this.fee = 0,
    this.feeDisplay = '0.00',
    required this.timestamp,
  });

  factory TransferReceiptData.fromJson(Map<String, dynamic> json) {
    return TransferReceiptData(
      receiptId: json['receipt_id'] as String? ?? '',
      type: json['type'] as String? ?? 'transfer',
      transferType: json['transfer_type'] as String? ?? 'internal',
      status: json['status'] as String? ?? 'unknown',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      amountDisplay: json['amount_display'] as String? ?? '0.00',
      currency: json['currency'] as String? ?? 'NGN',
      reference: json['reference'] as String? ?? '',
      recipientName: json['recipient_name'] as String? ?? '',
      recipientBank: json['recipient_bank'] as String? ?? '',
      recipientAccount: json['recipient_account'] as String? ?? '',
      senderAccountId: json['sender_account_id'] as String? ?? '',
      newBalance: (json['new_balance'] as num?)?.toInt() ?? 0,
      newBalanceDisplay: json['new_balance_display'] as String? ?? '',
      fee: (json['fee'] as num?)?.toInt() ?? 0,
      feeDisplay: json['fee_display'] as String? ?? '0.00',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String get currencySymbol {
    switch (currency) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return currency;
    }
  }

  String get transferTypeDisplay {
    switch (transferType) {
      case 'internal':
        return 'LazerVault Transfer';
      case 'domestic':
        return 'Bank Transfer';
      case 'international':
        return 'International Transfer';
      case 'phone':
        return 'Phone Transfer';
      default:
        return 'Transfer';
    }
  }

  bool get isSuccess =>
      status.toLowerCase() == 'completed' || status.toLowerCase() == 'success';
}

/// Compact receipt card shown inline in the chat bubble (Revolut-style).
class ChatReceiptCard extends StatelessWidget {
  final TransferReceiptData receipt;

  const ChatReceiptCard({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullScreenReceipt(context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: receipt.isSuccess
                ? const Color(0xFF10B981).withValues(alpha: 0.3)
                : const Color(0xFFEF4444).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: receipt.isSuccess
                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                    : const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: receipt.isSuccess
                          ? const Color(0xFF10B981).withValues(alpha: 0.2)
                          : const Color(0xFFEF4444).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      receipt.isSuccess ? Icons.check : Icons.close,
                      color: receipt.isSuccess
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          receipt.isSuccess
                              ? 'Transfer Successful'
                              : 'Transfer ${receipt.status}',
                          style: TextStyle(
                            color: receipt.isSuccess
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          receipt.transferTypeDisplay,
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.receipt_long,
                    color: Color(0xFF9CA3AF),
                    size: 20,
                  ),
                ],
              ),
            ),

            // Amount
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${receipt.currencySymbol} ${receipt.amountDisplay}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            // Recipient
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward, color: Color(0xFF9CA3AF), size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      receipt.recipientName,
                      style: const TextStyle(
                        color: Color(0xFFD1D5DB),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Reference + timestamp
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    receipt.reference,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm').format(receipt.timestamp.toLocal()),
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Tap to view
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF2D2D3D)),
                ),
              ),
              child: const Center(
                child: Text(
                  'Tap to view receipt',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFullScreenReceipt(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenReceiptView(receipt: receipt),
      ),
    );
  }
}

/// Full-screen receipt view with download functionality.
class FullScreenReceiptView extends StatefulWidget {
  final TransferReceiptData receipt;

  const FullScreenReceiptView({super.key, required this.receipt});

  @override
  State<FullScreenReceiptView> createState() => _FullScreenReceiptViewState();
}

class _FullScreenReceiptViewState extends State<FullScreenReceiptView> {
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.receipt;
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: const Text(
          'Receipt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _isDownloading ? null : _downloadReceipt,
            icon: _isDownloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.download, color: Colors.white),
            tooltip: 'Download PDF',
          ),
          IconButton(
            onPressed: _isSharing ? null : _shareReceipt,
            icon: _isSharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.share, color: Colors.white),
            tooltip: 'Share',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Main receipt card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Status header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: r.isSuccess
                              ? [
                                  const Color(0xFF10B981).withValues(alpha: 0.15),
                                  const Color(0xFF059669).withValues(alpha: 0.05),
                                ]
                              : [
                                  const Color(0xFFEF4444).withValues(alpha: 0.15),
                                  const Color(0xFFDC2626).withValues(alpha: 0.05),
                                ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: r.isSuccess
                                  ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                  : const Color(0xFFEF4444).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              r.isSuccess ? Icons.check_rounded : Icons.close_rounded,
                              color: r.isSuccess
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            r.isSuccess ? 'Transfer Successful' : 'Transfer ${r.status}',
                            style: TextStyle(
                              color: r.isSuccess
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r.transferTypeDisplay,
                            style: const TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amount section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            '${r.currencySymbol} ${r.amountDisplay}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1,
                            ),
                          ),
                          if (r.fee > 0) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Fee: ${r.currencySymbol} ${r.feeDisplay}',
                              style: const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 13,
                              ),
                            ),
                          ] else ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'FREE',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: Color(0xFF2D2D2D), height: 1),
                    ),

                    // Details section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildDetailRow('To', r.recipientName),
                          if (r.recipientBank.isNotEmpty)
                            _buildDetailRow('Bank', r.recipientBank),
                          if (r.recipientAccount.isNotEmpty)
                            _buildDetailRow('Account', _maskAccount(r.recipientAccount)),
                          _buildDetailRow('Reference', r.reference),
                          _buildDetailRow('Date', dateFormat.format(r.timestamp.toLocal())),
                          _buildDetailRow('Time', timeFormat.format(r.timestamp.toLocal())),
                          _buildDetailRow('Status', r.status.toUpperCase(),
                              valueColor: r.isSuccess
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444)),
                          if (r.newBalance > 0)
                            _buildDetailRow(
                              'New Balance',
                              '${r.currencySymbol} ${r.newBalanceDisplay}',
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bottom actions
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.download,
                      label: 'Download',
                      onTap: _isDownloading ? null : _downloadReceipt,
                      isLoading: _isDownloading,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.share,
                      label: 'Share',
                      onTap: _isSharing ? null : _shareReceipt,
                      isLoading: _isSharing,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF3B82F6),
                ),
              )
            else
              Icon(icon, color: const Color(0xFF3B82F6), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccount(String account) {
    if (account.length <= 4) return account;
    return '****${account.substring(account.length - 4)}';
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final pdfBytes = await _generateReceiptPdf();
      final directory = await getTemporaryDirectory();
      final fileName =
          'transfer_receipt_${widget.receipt.reference.replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '_')}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(pdfBytes);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Receipt saved: $fileName'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not download receipt. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      final pdfBytes = await _generateReceiptPdf();
      final directory = await getTemporaryDirectory();
      final fileName = 'LazerVault_Receipt_${widget.receipt.reference.replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '_')}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(pdfBytes);
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'LazerVault Transfer Receipt - ${widget.receipt.reference}',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not share receipt. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  // ---- PDF Generation ----

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

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
    } catch (_) {}
  }

  static pw.TextStyle _ts({
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

  Future<List<int>> _generateReceiptPdf() async {
    await _loadFonts();
    final r = widget.receipt;
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final statusColor = r.isSuccess ? PdfColors.green600 : PdfColors.red600;

    pw.MemoryImage? logo;
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      logo = pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {}

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (logo != null)
                    pw.Image(logo, width: 120)
                  else
                    pw.Text('LazerVault',
                        style: _ts(fontSize: 28, isBold: true)
                            .copyWith(color: PdfColors.blue800)),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Transfer Receipt',
                          style: _ts(fontSize: 18, isBold: true)
                              .copyWith(color: PdfColors.grey800)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Generated ${dateFormat.format(DateTime.now())}',
                        style: _ts(fontSize: 10, color: PdfColors.grey600),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 24),

              // Status + Amount
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(r.transferTypeDisplay,
                            style: _ts(fontSize: 20, isBold: true)
                                .copyWith(color: PdfColors.grey800)),
                        pw.SizedBox(height: 4),
                        pw.Text(r.isSuccess ? 'Completed' : r.status,
                            style: _ts(fontSize: 14, isBold: true, color: statusColor)),
                        if (r.fee == 0) ...[
                          pw.SizedBox(height: 8),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.green50,
                              borderRadius: pw.BorderRadius.circular(10),
                              border: pw.Border.all(color: PdfColors.green200),
                            ),
                            child: pw.Text('FREE TRANSFER',
                                style: _ts(
                                    fontSize: 9,
                                    isBold: true,
                                    color: PdfColors.green700)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('${r.currency} ${r.amountDisplay}',
                            style: _ts(fontSize: 28, isBold: true)),
                        if (r.newBalance > 0) ...[
                          pw.SizedBox(height: 4),
                          pw.Text(
                              'New Balance: ${r.currency} ${r.newBalanceDisplay}',
                              style: _ts(fontSize: 11, color: PdfColors.grey600)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Details
              pw.Text('Transaction Details',
                  style: _ts(fontSize: 16, isBold: true)),
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
                    _pdfRow('Recipient', r.recipientName),
                    if (r.recipientBank.isNotEmpty)
                      _pdfRow('Bank', r.recipientBank),
                    if (r.recipientAccount.isNotEmpty)
                      _pdfRow('Account', r.recipientAccount),
                    _pdfRow('Amount', '${r.currency} ${r.amountDisplay}'),
                    _pdfRow('Fee', r.fee > 0
                        ? '${r.currency} ${r.feeDisplay}'
                        : '${r.currency} 0.00'),
                    pw.Divider(color: PdfColors.grey300),
                    _pdfRow('Total', '${r.currency} ${r.amountDisplay}',
                        isBold: true),
                    pw.SizedBox(height: 8),
                    _pdfRow('Reference', r.reference),
                    _pdfRow('Date', dateFormat.format(r.timestamp.toLocal())),
                    _pdfRow('Status', r.isSuccess ? 'Completed' : r.status),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 12),
              pw.Center(
                child: pw.Text('Generated by LazerVault',
                    style: _ts(fontSize: 10, color: PdfColors.grey600)),
              ),
              pw.SizedBox(height: 4),
              pw.Center(
                child: pw.Text(
                    'This is an automatically generated receipt.',
                    style: _ts(fontSize: 9, color: PdfColors.grey500)),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _pdfRow(String label, String value, {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: _ts(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value, style: _ts(fontSize: 11, isBold: isBold)),
        ],
      ),
    );
  }
}
