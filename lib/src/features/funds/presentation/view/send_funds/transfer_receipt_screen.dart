import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/services/transfer_pdf_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

class TransferReceiptScreen extends StatefulWidget {
  const TransferReceiptScreen({super.key});

  @override
  State<TransferReceiptScreen> createState() => _TransferReceiptScreenState();
}

class _TransferReceiptScreenState extends State<TransferReceiptScreen> {
  late final Map<String, dynamic> transferDetails;
  bool _isDownloading = false;
  bool _isSharing = false;
  final GlobalKey _qrKey = GlobalKey();
  final Uuid _uuid = const Uuid();
  String? _qrData;

  @override
  void initState() {
    super.initState();
    transferDetails = Get.arguments as Map<String, dynamic>? ?? {};
    // Generate QR data on init
    _generateQrData();
  }

  void _generateQrData() {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final reference = transferDetails['reference'] as String? ??
        transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        _uuid.v4();
    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final timestamp = transferDetails['timestamp'] as DateTime? ??
        transferDetails['createdAt'] as DateTime? ??
        DateTime.now();

    final qrMap = {
      'type': 'transfer',
      'ref': reference,
      'amount': amount.toStringAsFixed(2),
      'currency': currency,
      'to': recipientName,
      'date': timestamp.toIso8601String(),
    };
    _qrData = jsonEncode(qrMap);
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      // Generate clean Revolut-style receipt as image
      final imageFile = await _generateReceiptImage();
      Get.snackbar(
        'Saved to Photos',
        'Receipt saved to your photos',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } catch (e) {
      Get.snackbar(
        'Save Failed',
        'Could not save receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      final imageFile = await _generateReceiptImage();
      final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
      final currency = transferDetails['currency'] as String? ?? 'NGN';
      final currencySymbol = _currencySymbol(currency);
      final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(imageFile.path)],
          text: '$currencySymbol${amount.toStringAsFixed(2)} sent to $recipientName',
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      setState(() => _isSharing = false);
    }
  }

  /// Generate a clean Revolut-style receipt image
  Future<File> _generateReceiptImage() async {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbol(currency);
    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final reference = transferDetails['reference'] as String? ??
        transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        '---';
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    final totalAmount = (transferDetails['totalAmount'] as num?)?.toDouble() ?? amount;
    final status = transferDetails['status'] as String? ?? 'completed';

    DateTime? timestamp;
    if (transferDetails['timestamp'] != null) {
      timestamp = transferDetails['timestamp'] as DateTime?;
    } else if (transferDetails['createdAt'] != null) {
      timestamp = transferDetails['createdAt'] as DateTime?;
    }
    timestamp ??= DateTime.now();

    // Create a widget to capture
    final receiptWidget = Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LazerVault',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Transfer Receipt',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8A8A8A),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                _formatStatus(status),
                style: GoogleFonts.inter(
                  color: _getStatusColor(status),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Amount - Large and prominent
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  amount.toStringAsFixed(2),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  currency.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8A8A8A),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Details
          _buildReceiptDetail('Reference', reference),
          _buildReceiptDetail('Recipient', recipientName),
          _buildReceiptDetail('Date', _formatDate(timestamp)),
          _buildReceiptDetail('Time', _formatTime(timestamp)),
          if (fee > 0) _buildReceiptDetail('Fee', '$currencySymbol${fee.toStringAsFixed(2)}'),

          const SizedBox(height: 8),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFFE5E5E5),
          ),
          const SizedBox(height: 16),

          // Footer
          Text(
            'Powered by LazerVault',
            style: GoogleFonts.inter(
              color: const Color(0xFFBDBDBD),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );

    // Render to image
    final renderRepaintBoundary = RenderRepaintBoundary();

    // Wait for the widget to be built
    await Future.delayed(const Duration(milliseconds: 100));

    final image = await renderRepaintBoundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Failed to capture receipt image');
    }

    final pngBytes = byteData.buffer.asUint8List();

    // Save to gallery (Photos on iOS, Downloads on Android)
    final directory = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();

    final fileName = 'receipt_${reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(pngBytes);

    return file;
  }

  Widget _buildReceiptDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF8A8A8A),
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1A1A),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
      case 'successful':
        return const Color(0xFF10B981);
      case 'pending':
      case 'processing':
        return const Color(0xFFFB923C);
      case 'failed':
        return const Color(0xFFEF4444);
      case 'scheduled':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF8A8A8A);
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final transferType = transferDetails['transferType'] as String? ?? 'Transfer';
    final isScheduled = transferDetails['scheduledAt'] != null;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Transfer Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h),

                    // QR Code - Prominent display
                    _buildQrCodeCard(),

                    SizedBox(height: 20.h),

                    // Status icon with reduced text
                    _buildSuccessIcon(),
                    SizedBox(height: 16.h),

                    Text(
                      isScheduled ? 'Transfer Scheduled' : 'Transfer Successful',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      isScheduled
                          ? 'Your transfer has been scheduled'
                          : 'Your transfer has been processed',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Amount card - tighter spacing
                    _buildAmountCard(amount, currency, transferType),
                    SizedBox(height: 16.h),

                    // Transaction details - more compact
                    _buildTransactionDetails(),
                  ],
                ),
              ),
            ),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCodeCard() {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbol(currency);

    return Container(
      width: 180.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Scan to verify',
            style: GoogleFonts.inter(
              color: const Color(0xFF8A8A8A),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          if (_qrData != null)
            RepaintBoundary(
              key: _qrKey,
              child: QrImageView(
                data: _qrData!,
                version: QrVersions.auto,
                size: 140.sp,
                backgroundColor: Colors.white,
                dataModuleStyle: QrDataModuleStyle(
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            )
          else
            SizedBox(
              width: 140.sp,
              height: 140.sp,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                amount.toStringAsFixed(2),
                style: GoogleFonts.inter(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                currency.toUpperCase(),
                style: GoogleFonts.inter(
                  color: const Color(0xFF8A8A8A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        color: const Color(0xFF10B981),
        size: 40.sp,
      ),
    );
  }

  Widget _buildAmountCard(double amount, String currency, String transferType) {
    final currencySymbol = _currencySymbol(currency);
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    final totalAmount = (transferDetails['totalAmount'] as num?)?.toDouble() ?? amount;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            transferDetails['scheduledAt'] != null ? 'Amount to Send' : 'Amount Sent',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '$currencySymbol${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (fee > 0) ...[
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fee',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  '$currencySymbol${fee.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  '$currencySymbol${totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTransactionDetails() {
    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final recipientBank = transferDetails['recipientBankName'] as String?;
    final recipientAccount = transferDetails['recipientAccountMasked'] as String?;
    final reference = transferDetails['reference'] as String? ?? '';
    final narration = transferDetails['narration'] as String?;
    final status = transferDetails['status'] as String? ?? 'completed';
    final transferType = transferDetails['transferType'] as String?;
    final network = transferDetails['network'] as String?;
    final scheduledAt = transferDetails['scheduledAt'];
    final sourceAccountInfo = transferDetails['sourceAccountInfo'] as String?;
    final sourceAccountName = transferDetails['sourceAccountName'] as String?;

    DateTime? timestamp;
    if (transferDetails['timestamp'] != null) {
      timestamp = transferDetails['timestamp'] as DateTime?;
    } else if (transferDetails['createdAt'] != null) {
      timestamp = transferDetails['createdAt'] as DateTime?;
    } else if (scheduledAt != null) {
      timestamp = scheduledAt is DateTime ? scheduledAt : DateTime.tryParse(scheduledAt.toString());
    }
    timestamp ??= DateTime.now();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow('Recipient', recipientName),
          SizedBox(height: 8.h),
          if (recipientBank != null && recipientBank.isNotEmpty) ...[
            _buildDetailRow('Bank', recipientBank),
            SizedBox(height: 8.h),
          ],
          if (recipientAccount != null && recipientAccount.isNotEmpty) ...[
            _buildDetailRow('Account', recipientAccount),
            SizedBox(height: 8.h),
          ],
          if (sourceAccountInfo != null && sourceAccountInfo.isNotEmpty) ...[
            if (sourceAccountName != null && sourceAccountName.isNotEmpty)
              _buildDetailRow('From', '$sourceAccountName ($sourceAccountInfo)')
            else
              _buildDetailRow('From', sourceAccountInfo),
            SizedBox(height: 8.h),
          ],
          if (reference.isNotEmpty) ...[
            _buildDetailRow('Reference', reference),
            SizedBox(height: 8.h),
          ],
          if (narration != null && narration.isNotEmpty) ...[
            _buildDetailRow('Description', narration),
            SizedBox(height: 8.h),
          ],
          if (transferType != null && transferType.isNotEmpty) ...[
            _buildDetailRow('Type', transferType),
            SizedBox(height: 8.h),
          ],
          if (network != null && network.isNotEmpty) ...[
            _buildDetailRow('Network', network),
            SizedBox(height: 8.h),
          ],
          _buildDetailRow('Status', _formatStatus(status)),
          SizedBox(height: 8.h),
          _buildDetailRow(
            'Date',
            _formatDate(timestamp),
          ),
          SizedBox(height: 8.h),
          _buildDetailRow(
            'Time',
            _formatTime(timestamp),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'Completed';
      case 'pending':
      case 'processing':
        return 'Pending';
      case 'failed':
        return 'Failed';
      case 'scheduled':
        return 'Scheduled';
      default:
        return status;
    }
  }

  String _currencySymbol(String currency) {
    // Return ASCII-safe currency codes for receipts
    switch (currency.toUpperCase()) {
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
      case 'KES':
        return 'KES ';
      case 'GHS':
        return 'GHS ';
      case 'EGP':
        return 'EGP ';
      default:
        return '$currency '; // Fallback to code + space
    }
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isSharing ? null : _shareReceipt,
              icon: _isSharing
                  ? SizedBox(
                      width: 16.sp,
                      height: 16.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.share, size: 16.sp),
              label: Text(
                _isSharing ? 'Sharing...' : 'Share',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isDownloading ? null : _downloadReceipt,
              icon: _isDownloading
                  ? SizedBox(
                      width: 16.sp,
                      height: 16.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.save_alt, size: 16.sp),
              label: Text(
                _isDownloading ? 'Saving...' : 'Save',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
