import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/tag_pay_entity.dart';
import '../../domain/entities/user_tag_entity.dart' show UserTagEntity;
import '../../../../../core/types/app_routes.dart';
import '../../services/tag_pay_pdf_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class TagPaymentReceiptScreen extends StatefulWidget {
  const TagPaymentReceiptScreen({super.key});

  @override
  State<TagPaymentReceiptScreen> createState() =>
      _TagPaymentReceiptScreenState();
}

class _TagPaymentReceiptScreenState extends State<TagPaymentReceiptScreen> {
  /// Money is grouped for READING — "₦1500000.00" makes the customer count
  /// digits to know what they paid.
  static final _amountFormat = NumberFormat('#,##0.00');

  late final TagPayTransactionEntity transaction;
  late final UserTagEntity tag;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    transaction = args['transaction'];
    tag = args['tag'];
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      final path = await TagPayPdfService.downloadReceipt(
        transaction: transaction,
        tag: tag,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${path.split('/').last}',
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
      await TagPayPdfService.shareReceipt(
        transaction: transaction,
        tag: tag,
        // share_plus on iPad REQUIRES a non-zero anchor rect or the native
        // sheet throws; anchor it to this screen like the sibling calls in
        // tag_details_bottom_sheet.dart do.
        sharePositionOrigin: TagPayPdfService.shareOriginFromContext(context),
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
          'Payment Receipt',
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
                    _buildOutcomeIcon(),
                    SizedBox(height: 24.h),
                    Text(
                      _outcomeTitle,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _outcomeSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _buildAmountCard(transaction),
                    SizedBox(height: 24.h),
                    _buildTransactionDetails(transaction, tag),
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

  // ── Outcome header ────────────────────────────────────────────────────
  //
  // Whether a payment succeeded is a property of the TRANSACTION, not of
  // having reached this screen. The header used to hardcode a green check and
  // "Payment Successful!" while the details section below printed
  // "Status: Pending/Processing/Failed" off the SAME object — so a failed or
  // still-processing payment was presented to the payer as money delivered.
  // Everything in the header now derives from `transaction.status`.

  Color get _outcomeColor {
    switch (transaction.status) {
      case TagPayTransactionStatus.completed:
        return const Color(0xFF10B981);
      case TagPayTransactionStatus.pending:
      case TagPayTransactionStatus.processing:
        return const Color(0xFFF59E0B);
      case TagPayTransactionStatus.failed:
      case TagPayTransactionStatus.cancelled:
        return const Color(0xFFEF4444);
      case TagPayTransactionStatus.refunded:
        return const Color(0xFF3B82F6);
    }
  }

  IconData get _outcomeIcon {
    switch (transaction.status) {
      case TagPayTransactionStatus.completed:
        return Icons.check_circle;
      case TagPayTransactionStatus.pending:
      case TagPayTransactionStatus.processing:
        return Icons.schedule;
      case TagPayTransactionStatus.failed:
        return Icons.error;
      case TagPayTransactionStatus.cancelled:
        return Icons.cancel;
      case TagPayTransactionStatus.refunded:
        return Icons.replay_circle_filled;
    }
  }

  String get _outcomeTitle {
    switch (transaction.status) {
      case TagPayTransactionStatus.completed:
        return 'Payment Successful!';
      case TagPayTransactionStatus.pending:
        return 'Payment Pending';
      case TagPayTransactionStatus.processing:
        return 'Payment Processing';
      case TagPayTransactionStatus.failed:
        return 'Payment Failed';
      case TagPayTransactionStatus.cancelled:
        return 'Payment Cancelled';
      case TagPayTransactionStatus.refunded:
        return 'Payment Refunded';
    }
  }

  String get _outcomeSubtitle {
    switch (transaction.status) {
      case TagPayTransactionStatus.completed:
        return 'Your payment has been processed';
      case TagPayTransactionStatus.pending:
      case TagPayTransactionStatus.processing:
        return 'We\'re still settling this payment. This receipt updates once it completes.';
      case TagPayTransactionStatus.failed:
        return 'This payment did not go through';
      case TagPayTransactionStatus.cancelled:
        return 'This payment was cancelled';
      case TagPayTransactionStatus.refunded:
        return 'This payment was returned to your account';
    }
  }

  Widget _buildOutcomeIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        color: _outcomeColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _outcomeIcon,
        color: _outcomeColor,
        size: 60.sp,
      ),
    );
  }

  Widget _buildAmountCard(TagPayTransactionEntity transaction) {
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
            // "Amount Paid" is itself a success claim — only say it once the
            // money has actually moved.
            transaction.status == TagPayTransactionStatus.completed
                ? 'Amount Paid'
                : 'Amount',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${UserTagEntity.currencySymbol(transaction.currency)}${_amountFormat.format(transaction.amount)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(
      TagPayTransactionEntity transaction, UserTagEntity tag) {
    // Use fallbacks if transaction receiver info is empty
    final recipientName = transaction.receiverName.isNotEmpty
        ? transaction.receiverName
        : (tag.taggerName.isNotEmpty ? tag.taggerName : 'Lazervault User');
    final recipientTag = transaction.receiverTagPay.isNotEmpty
        ? transaction.receiverTagPay
        : tag.taggerTagPay;

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
          if (recipientTag.isNotEmpty) ...[
            _buildDetailRow('Tag', '@$recipientTag'),
            SizedBox(height: 12.h),
          ],
          _buildDetailRow('Reference', transaction.referenceNumber),
          if (transaction.description != null &&
              transaction.description!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Description', transaction.description!),
          ],
          SizedBox(height: 12.h),
          _buildDetailRow('Status', transaction.statusDisplay),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Date',
            _formatDate(transaction.createdAt),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Time',
            _formatTime(transaction.createdAt),
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
                  ? LazerVaultLoader(size: 18)
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
                side: const BorderSide(color: Color(0xFF4E03D0)),
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
                  ? LazerVaultLoader(size: 18)
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
                side: const BorderSide(color: Color(0xFF4E03D0)),
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
