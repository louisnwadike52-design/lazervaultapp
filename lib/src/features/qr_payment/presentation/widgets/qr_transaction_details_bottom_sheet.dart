import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/qr_transaction_entity.dart';
import '../../services/qr_pay_pdf_service.dart';

class QRTransactionDetailsBottomSheet extends StatefulWidget {
  final QRTransactionEntity transaction;

  const QRTransactionDetailsBottomSheet({
    super.key,
    required this.transaction,
  });

  @override
  State<QRTransactionDetailsBottomSheet> createState() =>
      _QRTransactionDetailsBottomSheetState();
}

class _QRTransactionDetailsBottomSheetState
    extends State<QRTransactionDetailsBottomSheet> {
  bool _isDownloadingReceipt = false;
  bool _isSharingReceipt = false;

  Future<void> _downloadReceipt() async {
    if (_isDownloadingReceipt) return;

    setState(() => _isDownloadingReceipt = true);

    try {
      await QRPayPdfService.downloadReceipt(transaction: widget.transaction);

      Get.snackbar(
        'Success',
        'Receipt downloaded successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download receipt: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingReceipt = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharingReceipt) return;

    setState(() => _isSharingReceipt = true);

    try {
      await QRPayPdfService.shareReceipt(transaction: widget.transaction);

      Get.snackbar(
        'Success',
        'Receipt shared successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to share receipt: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isSharingReceipt = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final txn = widget.transaction;
    final isCompleted = txn.status == QRTransactionStatus.completed;

    final statusColor =
        isCompleted ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final statusIcon = isCompleted ? Icons.check_circle : Icons.cancel;
    final statusText = isCompleted ? 'COMPLETED' : 'FAILED';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Payment Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  statusText,
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Details
          _buildDetailRow(
            'Payer',
            '${txn.payerName} (@${txn.payerUsername})',
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Recipient',
            '${txn.recipientName} (@${txn.recipientUsername})',
          ),
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Amount',
            '${txn.currency} ${txn.amount.toStringAsFixed(2)}',
            valueColor: const Color(0xFF10B981),
            isBold: true,
          ),
          if (txn.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', txn.description),
          ],
          SizedBox(height: 16.h),
          _buildDetailRow('Reference', txn.referenceNumber),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Date',
            DateFormat('MMM dd, yyyy - hh:mm a').format(txn.createdAt),
          ),
          SizedBox(height: 24.h),

          // Action Buttons Row
          Row(
            children: [
              // Download Receipt Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      _isDownloadingReceipt ? null : _downloadReceipt,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                        color: Color(0xFF60A5FA), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isDownloadingReceipt
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF60A5FA),
                          ),
                        )
                      : Icon(Icons.download_outlined,
                          size: 18.sp, color: const Color(0xFF60A5FA)),
                  label: Text(
                    'Download',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Share Receipt Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSharingReceipt ? null : _shareReceipt,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                        color: Color(0xFF34D399), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isSharingReceipt
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF34D399),
                          ),
                        )
                      : Icon(Icons.share_outlined,
                          size: 18.sp, color: const Color(0xFF34D399)),
                  label: Text(
                    'Share',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
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
              color: valueColor ?? Colors.white,
              fontSize: isBold ? 18.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
