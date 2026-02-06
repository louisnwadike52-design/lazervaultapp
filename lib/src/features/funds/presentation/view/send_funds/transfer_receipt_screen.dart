import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/services/transfer_pdf_service.dart';

class TransferReceiptScreen extends StatefulWidget {
  const TransferReceiptScreen({super.key});

  @override
  State<TransferReceiptScreen> createState() => _TransferReceiptScreenState();
}

class _TransferReceiptScreenState extends State<TransferReceiptScreen> {
  late final Map<String, dynamic> transferDetails;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    transferDetails = Get.arguments as Map<String, dynamic>? ?? {};
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      // For PDF download, we need to use the TransferPdfService
      // First, convert transferDetails to a format compatible with the service
      final filePath = await TransferPdfService.downloadReceiptFromMap(
        transferDetails: transferDetails,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${filePath.split('/').last}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt. Please try again.',
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
      await TransferPdfService.shareReceiptFromMap(
        transferDetails: transferDetails,
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
            size: 24.sp,
          ),
        ),
        title: Text(
          'Transfer Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
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
                    SizedBox(height: 8.h),
                    _buildSuccessIcon(),
                    SizedBox(height: 24.h),
                    Text(
                      isScheduled ? 'Transfer Scheduled!' : 'Transfer Successful!',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      isScheduled
                          ? 'Your transfer has been scheduled'
                          : 'Your transfer has been processed',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _buildAmountCard(amount, currency, transferType),
                    SizedBox(height: 24.h),
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

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        color: const Color(0xFF10B981),
        size: 60.sp,
      ),
    );
  }

  Widget _buildAmountCard(double amount, String currency, String transferType) {
    final currencySymbol = _currencySymbol(currency);
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    final totalAmount = (transferDetails['totalAmount'] as num?)?.toDouble() ?? amount;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
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
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '$currencySymbol${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (fee > 0) ...[
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fee',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  '$currencySymbol${fee.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  '$currencySymbol${totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
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
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
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
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Recipient', recipientName),
          SizedBox(height: 12.h),
          if (recipientBank != null && recipientBank.isNotEmpty) ...[
            _buildDetailRow('Bank', recipientBank),
            SizedBox(height: 12.h),
          ],
          if (recipientAccount != null && recipientAccount.isNotEmpty) ...[
            _buildDetailRow('Account', recipientAccount),
            SizedBox(height: 12.h),
          ],
          if (sourceAccountInfo != null && sourceAccountInfo.isNotEmpty) ...[
            if (sourceAccountName != null && sourceAccountName.isNotEmpty)
              _buildDetailRow('From', '$sourceAccountName ($sourceAccountInfo)')
            else
              _buildDetailRow('From', sourceAccountInfo),
            SizedBox(height: 12.h),
          ],
          if (reference.isNotEmpty) ...[
            _buildDetailRow('Reference', reference),
            SizedBox(height: 12.h),
          ],
          if (narration != null && narration.isNotEmpty) ...[
            _buildDetailRow('Description', narration),
            SizedBox(height: 12.h),
          ],
          if (transferType != null && transferType.isNotEmpty) ...[
            _buildDetailRow('Transfer Type', transferType),
            SizedBox(height: 12.h),
          ],
          if (network != null && network.isNotEmpty) ...[
            _buildDetailRow('Network', network),
            SizedBox(height: 12.h),
          ],
          _buildDetailRow('Status', _formatStatus(status)),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Date',
            _formatDate(timestamp),
          ),
          SizedBox(height: 12.h),
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
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
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
        return 'Successful';
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
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      case 'ZAR':
        return 'R';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '\$';
    }
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isSharing ? null : _shareReceipt,
              icon: _isSharing
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.share, size: 18.sp),
              label: Text(
                _isSharing ? 'Sharing...' : 'Share',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isDownloading ? null : _downloadReceipt,
              icon: _isDownloading
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.download, size: 18.sp),
              label: Text(
                _isDownloading ? 'Saving...' : 'Download',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
