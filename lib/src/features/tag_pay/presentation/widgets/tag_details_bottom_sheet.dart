import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../services/tag_pay_pdf_service.dart';
import '../../../../../core/types/app_routes.dart';

class TagDetailsBottomSheet extends StatefulWidget {
  final UserTagEntity tag;
  final bool isOutgoing; // true for sent tags, false for received tags

  const TagDetailsBottomSheet({
    super.key,
    required this.tag,
    required this.isOutgoing,
  });

  @override
  State<TagDetailsBottomSheet> createState() => _TagDetailsBottomSheetState();
}

class _TagDetailsBottomSheetState extends State<TagDetailsBottomSheet> {
  bool _isDownloadingInvoice = false;
  bool _isDownloadingReceipt = false;

  Future<void> _downloadInvoice() async {
    if (_isDownloadingInvoice) return;

    setState(() => _isDownloadingInvoice = true);

    try {
      await TagPayPdfService.shareInvoice(
        tag: widget.tag,
        isOutgoing: widget.isOutgoing,
      );

      Get.snackbar(
        'Success',
        'Invoice generated successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate invoice: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingInvoice = false);
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloadingReceipt) return;

    // Only allow receipt download for paid tags
    if (!widget.tag.isPaid) {
      Get.snackbar(
        'Info',
        'Receipt is only available after payment is completed.',
        backgroundColor: const Color(0xFF3B82F6),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() => _isDownloadingReceipt = true);

    try {
      // Use the new method to generate receipt from tag data
      await TagPayPdfService.sharePaidTagReceipt(
        tag: widget.tag,
        isOutgoing: widget.isOutgoing,
      );

      Get.snackbar(
        'Success',
        'Receipt generated successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate receipt: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingReceipt = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPending = widget.tag.status == TagStatus.pending;
    final isPaid = widget.tag.status == TagStatus.paid;
    final isCancelled = widget.tag.status == TagStatus.cancelled;

    // Get display names with fallbacks
    final otherName = widget.isOutgoing ? widget.tag.taggedUserName : widget.tag.taggerName;
    final otherTag = widget.isOutgoing ? widget.tag.taggedUserTagPay : widget.tag.taggerTagPay;
    final displayName = otherName.isNotEmpty ? otherName : 'LazerVault User';
    final displayTag = otherTag.isNotEmpty ? '@$otherTag' : '';

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
                  'Tag Details',
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
            widget.isOutgoing ? 'To' : 'From',
            displayName,
          ),
          SizedBox(height: 16.h),
          if (displayTag.isNotEmpty) ...[
            _buildDetailRow('Tag', displayTag),
            SizedBox(height: 16.h),
          ],
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Amount',
            widget.tag.formattedAmount,
            valueColor: isPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
            isBold: true,
          ),
          if (widget.tag.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', widget.tag.description),
          ],
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Created At',
            DateFormat('MMM dd, yyyy - hh:mm a').format(widget.tag.createdAt),
          ),
          if (isPaid && widget.tag.paidAt != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow(
              'Paid At',
              DateFormat('MMM dd, yyyy - hh:mm a').format(widget.tag.paidAt!),
            ),
          ],
          SizedBox(height: 24.h),

          // Pay Now Button (for incoming pending tags)
          if (!widget.isOutgoing && isPending) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed(
                    AppRoutes.tagPaymentConfirmation,
                    arguments: widget.tag,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.payment, size: 20.sp, color: Colors.white),
                label: Text(
                  'Pay Now',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],

          // Download Buttons Row - Invoice and Receipt side by side
          Row(
            children: [
              // Download Invoice Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isDownloadingInvoice ? null : _downloadInvoice,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF60A5FA), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isDownloadingInvoice
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF60A5FA),
                          ),
                        )
                      : Icon(Icons.description_outlined, size: 18.sp, color: const Color(0xFF60A5FA)),
                  label: Text(
                    'Invoice',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Download Receipt Button (only enabled for paid tags)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isPaid && !_isDownloadingReceipt ? _downloadReceipt : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: isPaid ? const Color(0xFF34D399) : const Color(0xFF6B7280),
                      width: 1.5,
                    ),
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
                            color: Color(0xFF34D399),
                          ),
                        )
                      : Icon(
                          Icons.receipt_long_outlined,
                          size: 18.sp,
                          color: isPaid ? const Color(0xFF34D399) : const Color(0xFF6B7280),
                        ),
                  label: Text(
                    'Receipt',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (!isPaid) ...[
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'Receipt available after payment',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
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
