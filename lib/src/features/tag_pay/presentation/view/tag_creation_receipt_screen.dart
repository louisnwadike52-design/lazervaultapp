import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../services/tag_pay_pdf_service.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class TagCreationReceiptScreen extends StatefulWidget {
  const TagCreationReceiptScreen({super.key});

  @override
  State<TagCreationReceiptScreen> createState() =>
      _TagCreationReceiptScreenState();
}

class _TagCreationReceiptScreenState extends State<TagCreationReceiptScreen> {
  /// Grouped for READING — a batch total is the amount most likely to run into
  /// six digits, and "₦1500000.00" makes the user count them.
  static final _amountFormat = NumberFormat('#,##0.00');

  bool _isSharing = false;

  /// Share the invoice for EVERY tag just created.
  ///
  /// Batch creation makes one invoice per tagged user, each naming that user.
  /// This used to share `tags.first` for the whole batch, so a screen reading
  /// "5 users x ₦2,000" handed out recipient #1's invoice and the other four
  /// recipients never got theirs.
  Future<void> _shareInvoices(List<UserTagEntity> tags) async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      await TagPayPdfService.shareInvoices(
        tags: tags,
        isOutgoing: true, // Tags we created are outgoing
        // share_plus on iPad REQUIRES a non-zero anchor rect or the native
        // sheet throws; anchor it to this screen like the sibling calls in
        // tag_details_bottom_sheet.dart do.
        sharePositionOrigin: TagPayPdfService.shareOriginFromContext(context),
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

  /// The tag's REAL status. This row used to print a hardcoded
  /// "Pending Payment", so a tag that had already been paid or cancelled by
  /// the time the receipt was reopened still claimed it was awaiting payment.
  String _statusLabel(UserTagEntity tag) {
    switch (tag.status) {
      case TagStatus.pending:
        return 'Pending Payment';
      case TagStatus.paying:
        return 'Payment Processing';
      case TagStatus.paid:
        return 'Paid';
      case TagStatus.cancelled:
        return 'Cancelled';
      case TagStatus.declined:
        return 'Declined';
      case TagStatus.expired:
        return 'Expired';
      case TagStatus.unknown:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final UserTagEntity tag = args['tag'];
    final List<UserTagEntity> tags =
        args['tags'] as List<UserTagEntity>? ?? [tag];
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
          onPressed: () => Get.offAllNamed(AppRoutes.tagPay),
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
                      isBatch
                          ? 'Tags Sent Successfully!'
                          : 'Tag Sent Successfully!',
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
                    _buildAmountCard(
                        currency, amount, isBatch ? tags.length : 1),
                    SizedBox(height: 24.h),
                    if (isBatch)
                      _buildBatchTagDetails(tags, currency)
                    else
                      _buildTagDetails(
                          tag, recipientName, recipientTag, description),
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
            '${UserTagEntity.currencySymbol(currency)}${_amountFormat.format(total)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (count > 1) ...[
            SizedBox(height: 4.h),
            Text(
              '$count users x ${UserTagEntity.currencySymbol(currency)}${_amountFormat.format(amount)} each',
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
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Center(
                        child: Text(
                          t.taggedUserName.isNotEmpty
                              ? t.taggedUserName[0].toUpperCase()
                              : '?',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4E03D0),
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
                            t.taggedUserName.isNotEmpty
                                ? t.taggedUserName
                                : 'Lazervault User',
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
                                color: const Color(0xFF4E03D0),
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

  Widget _buildTagDetails(UserTagEntity tag, String recipientName,
      String recipientTag, String description) {
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
          _buildDetailRow('Tagged User',
              recipientName.isNotEmpty ? recipientName : 'Lazervault User'),
          SizedBox(height: 12.h),
          _buildDetailRow(
              'Tag', recipientTag.isNotEmpty ? '@$recipientTag' : '-'),
          SizedBox(height: 12.h),
          _buildDetailRow('Status', _statusLabel(tag)),
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

  Widget _buildActions(BuildContext context, UserTagEntity tag,
      List<UserTagEntity> tags, bool isBatch) {
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
                  onPressed: _isSharing
                      ? null
                      : () => _shareInvoices(isBatch ? tags : [tag]),
                  icon: _isSharing
                      ? LazerVaultLoader(size: 18)
                      : Icon(Icons.share, size: 18.sp),
                  label: Text(
                    isBatch ? 'Share Invoices' : 'Share Invoice',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4E03D0),
                    side:
                        const BorderSide(color: Color(0xFF4E03D0), width: 1.5),
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
                    // Land on Created — the tag they just raised is an OUTGOING
                    // one, so Received would open on a list that doesn't contain it.
                    Get.offAllNamed(AppRoutes.tagPay,
                        arguments: {'tab': 'created'});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
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
