import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../../services/qr_pay_pdf_service.dart';
import '../cubit/qr_payment_cubit.dart';

class QRCodeDetailsBottomSheet extends StatefulWidget {
  final QRPaymentEntity qrCode;

  const QRCodeDetailsBottomSheet({
    super.key,
    required this.qrCode,
  });

  @override
  State<QRCodeDetailsBottomSheet> createState() =>
      _QRCodeDetailsBottomSheetState();
}

class _QRCodeDetailsBottomSheetState extends State<QRCodeDetailsBottomSheet> {
  bool _isDownloadingSummary = false;
  bool _isSharingSummary = false;

  Future<void> _downloadSummary() async {
    if (_isDownloadingSummary) return;

    setState(() => _isDownloadingSummary = true);

    try {
      await QRPayPdfService.downloadQRCodeSummary(qrCode: widget.qrCode);

      Get.snackbar(
        'Success',
        'Summary downloaded successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download summary: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingSummary = false);
    }
  }

  Future<void> _shareSummary() async {
    if (_isSharingSummary) return;

    setState(() => _isSharingSummary = true);

    try {
      await QRPayPdfService.shareQRCodeSummary(qrCode: widget.qrCode);

      Get.snackbar(
        'Success',
        'Summary shared successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to share summary: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isSharingSummary = false);
    }
  }

  void _cancelQR() {
    Navigator.pop(context);
    context.read<QRPaymentCubit>().cancelQR(qrId: widget.qrCode.id);
  }

  @override
  Widget build(BuildContext context) {
    final qr = widget.qrCode;
    final isPending = qr.status == QRPaymentStatus.pending;
    final isPaid = qr.status == QRPaymentStatus.paid;
    final isCancelled = qr.status == QRPaymentStatus.cancelled;
    final isExpired = qr.status == QRPaymentStatus.expired;

    Color statusColor;
    IconData statusIcon;
    String statusText;
    if (isPaid) {
      statusColor = const Color(0xFF10B981);
      statusIcon = Icons.check_circle;
      statusText = 'PAID';
    } else if (isCancelled) {
      statusColor = const Color(0xFFEF4444);
      statusIcon = Icons.cancel;
      statusText = 'CANCELLED';
    } else if (isExpired) {
      statusColor = const Color(0xFF6B7280);
      statusIcon = Icons.timer_off;
      statusText = 'EXPIRED';
    } else {
      statusColor = const Color(0xFFFB923C);
      statusIcon = Icons.access_time;
      statusText = 'PENDING';
    }

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
                  'QR Code Details',
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
          _buildDetailRow('Type', qr.qrType.displayName),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Amount',
            qr.amount > 0
                ? '${qr.currency} ${qr.amount.toStringAsFixed(2)}'
                : 'Any amount',
            valueColor: isPaid ? const Color(0xFF10B981) : null,
            isBold: true,
          ),
          if (qr.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', qr.description),
          ],
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'QR Code',
            qr.qrCode.length > 30
                ? '${qr.qrCode.substring(0, 30)}...'
                : qr.qrCode,
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Created',
            DateFormat('MMM dd, yyyy - hh:mm a').format(qr.createdAt),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Expires',
            DateFormat('MMM dd, yyyy - hh:mm a').format(qr.expiresAt),
          ),
          if (isPaid && qr.paidAt != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow(
              'Paid At',
              DateFormat('MMM dd, yyyy - hh:mm a').format(qr.paidAt!),
            ),
          ],
          SizedBox(height: 24.h),

          // Action Buttons Row
          Row(
            children: [
              // Download Summary Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      _isDownloadingSummary ? null : _downloadSummary,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                        color: Color(0xFF60A5FA), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isDownloadingSummary
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
              // Share Summary Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSharingSummary ? null : _shareSummary,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                        color: Color(0xFF34D399), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isSharingSummary
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

          // Cancel Button (only for pending QR codes)
          if (isPending) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _cancelQR,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side:
                      const BorderSide(color: Color(0xFFEF4444), width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: Icon(Icons.cancel_outlined,
                    size: 18.sp, color: const Color(0xFFEF4444)),
                label: Text(
                  'Cancel QR Code',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFEF4444),
                  ),
                ),
              ),
            ),
          ],
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
