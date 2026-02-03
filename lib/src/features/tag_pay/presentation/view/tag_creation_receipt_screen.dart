import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../services/tag_pay_pdf_service.dart';
import '../../../../../core/types/app_routes.dart';

class TagCreationReceiptScreen extends StatefulWidget {
  const TagCreationReceiptScreen({super.key});

  @override
  State<TagCreationReceiptScreen> createState() => _TagCreationReceiptScreenState();
}

class _TagCreationReceiptScreenState extends State<TagCreationReceiptScreen> {
  bool _isSharing = false;

  Future<void> _shareInvoice(UserTagEntity tag) async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      await TagPayPdfService.shareInvoice(
        tag: tag,
        isOutgoing: true, // Tags we created are outgoing
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to share invoice: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final UserTagEntity tag = args['tag'];
    final List<UserTagEntity> tags = args['tags'] as List<UserTagEntity>? ?? [tag];
    final String recipientName = args['recipientName'];
    final String recipientTag = args['recipientTag'];
    final double amount = args['amount'];
    final String currency = args['currency'];
    final String description = args['description'] ?? '';
    final bool isBatch = tags.length > 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        title: Text(
          isBatch ? 'Tags Created' : 'Tag Created',
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
                    SizedBox(height: 20.h),
                    _buildSuccessIcon(),
                    SizedBox(height: 24.h),
                    Text(
                      isBatch ? 'Tags Sent Successfully!' : 'Tag Sent Successfully!',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      isBatch
                          ? '${tags.length} tags have been sent'
                          : 'Your tag has been sent to $recipientName',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),
                    _buildAmountCard(currency, amount, isBatch ? tags.length : 1),
                    SizedBox(height: 24.h),
                    if (isBatch)
                      _buildBatchTagDetails(tags, currency)
                    else
                      _buildTagDetails(tag, recipientName, recipientTag, description),
                  ],
                ),
              ),
            ),
            _buildActions(context, tag, tags, isBatch),
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

  Widget _buildAmountCard(String currency, double amount, int count) {
    final total = amount * count;
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
            count > 1 ? 'Total Amount' : 'Tag Amount',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${UserTagEntity.currencySymbol(currency)}${total.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (count > 1) ...[
            SizedBox(height: 4.h),
            Text(
              '$count users x ${UserTagEntity.currencySymbol(currency)}${amount.toStringAsFixed(2)} each',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBatchTagDetails(List<UserTagEntity> tags, String currency) {
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
            'Tagged Users',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          ...tags.map((t) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Center(
                        child: Text(
                          t.taggedUserName.isNotEmpty ? t.taggedUserName[0].toUpperCase() : '?',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF3B82F6),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.taggedUserName.isNotEmpty ? t.taggedUserName : 'LazerVault User',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (t.taggedUserTagPay.isNotEmpty)
                            Text(
                              '@${t.taggedUserTagPay}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      t.formattedAmount,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTagDetails(UserTagEntity tag, String recipientName, String recipientTag, String description) {
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
            'Tag Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Tagged User', recipientName.isNotEmpty ? recipientName : 'LazerVault User'),
          SizedBox(height: 12.h),
          _buildDetailRow('Tag', recipientTag.isNotEmpty ? '@$recipientTag' : '-'),
          SizedBox(height: 12.h),
          _buildDetailRow('Status', 'Pending Payment'),
          if (description.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Description', description),
          ],
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Created',
            _formatDate(tag.createdAt),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Time',
            _formatTime(tag.createdAt),
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

  Widget _buildActions(BuildContext context, UserTagEntity tag, List<UserTagEntity> tags, bool isBatch) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Share Invoice Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSharing ? null : () => _shareInvoice(isBatch ? tags.first : tag),
                  icon: _isSharing
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF3B82F6),
                          ),
                        )
                      : Icon(Icons.share, size: 18.sp),
                  label: Text(
                    'Share Invoice',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3B82F6),
                    side: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // View My Tags Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.tagPay);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'View My Tags',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
