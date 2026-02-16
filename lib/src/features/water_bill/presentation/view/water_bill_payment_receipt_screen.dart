import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../../services/water_bill_pdf_service.dart';

class WaterBillPaymentReceiptScreen extends StatefulWidget {
  const WaterBillPaymentReceiptScreen({super.key});

  @override
  State<WaterBillPaymentReceiptScreen> createState() =>
      _WaterBillPaymentReceiptScreenState();
}

class _WaterBillPaymentReceiptScreenState
    extends State<WaterBillPaymentReceiptScreen> {
  bool _isDownloading = false;
  bool _isSharing = false;

  String _formatAmount(double amount) {
    final format = NumberFormat('#,##0.00', 'en_NG');
    return '\u20A6${format.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
  }

  String _formatStatus(WaterPaymentStatus status) {
    return status.name[0].toUpperCase() + status.name.substring(1);
  }

  Color _statusColor(WaterPaymentStatus status) {
    switch (status) {
      case WaterPaymentStatus.completed:
        return const Color(0xFF10B981);
      case WaterPaymentStatus.pending:
      case WaterPaymentStatus.processing:
        return const Color(0xFFFB923C);
      case WaterPaymentStatus.failed:
        return const Color(0xFFEF4444);
      case WaterPaymentStatus.refunded:
        return const Color(0xFF9CA3AF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final payment = args['payment'] as WaterPaymentEntity;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'Payment Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Status icon
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _statusColor(payment.status)
                            .withValues(alpha: 0.15),
                        border: Border.all(
                          color: _statusColor(payment.status)
                              .withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        payment.isCompleted
                            ? Icons.check_circle
                            : payment.isPending || payment.isProcessing
                                ? Icons.schedule
                                : Icons.error_outline,
                        color: _statusColor(payment.status),
                        size: 44.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      payment.isCompleted
                          ? 'Payment Successful!'
                          : payment.isPending || payment.isProcessing
                              ? 'Payment Processing'
                              : 'Payment Failed',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      _formatAmount(payment.amount),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Receipt card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFF2D2D2D),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction Details',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          _buildReceiptRow('Provider', payment.providerName),
                          _buildDivider(),
                          _buildReceiptRow(
                              'Customer Number', payment.customerNumber),
                          _buildDivider(),
                          _buildReceiptRow(
                              'Customer Name', payment.customerName),
                          _buildDivider(),
                          _buildReceiptRow(
                              'Amount', _formatAmount(payment.amount)),
                          _buildDivider(),
                          if (payment.receiptNumber != null &&
                              payment.receiptNumber!.isNotEmpty) ...[
                            _buildReceiptRow(
                              'Receipt Number',
                              payment.receiptNumber!,
                              isCopyable: true,
                            ),
                            _buildDivider(),
                          ],
                          if (payment.transactionReference != null &&
                              payment.transactionReference!.isNotEmpty) ...[
                            _buildReceiptRow(
                              'Reference',
                              payment.transactionReference!,
                              isCopyable: true,
                            ),
                            _buildDivider(),
                          ],
                          _buildReceiptRow(
                              'Date', _formatDate(payment.createdAt)),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Status',
                            _formatStatus(payment.status),
                            valueColor: _statusColor(payment.status),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            _buildActions(context, payment),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    Color? valueColor,
    bool isCopyable = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: GestureDetector(
              onTap: isCopyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      Get.snackbar(
                        'Copied',
                        'Copied to clipboard',
                        backgroundColor:
                            const Color(0xFF3B82F6).withValues(alpha: 0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                        margin: EdgeInsets.all(16.w),
                        borderRadius: 12,
                      );
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: GoogleFonts.inter(
                        color: valueColor ?? Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isCopyable) ...[
                    SizedBox(width: 6.w),
                    Icon(Icons.copy, color: const Color(0xFF9CA3AF),
                        size: 14.sp),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Color(0xFF2D2D2D), height: 1);
  }

  Widget _buildActions(BuildContext context, WaterPaymentEntity payment) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isSharing ? null : () => _shareReceipt(payment),
              icon: _isSharing
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.share, size: 18.sp, color: Colors.white),
              label: Text(
                'Share Receipt',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2D2D2D), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed:
                  _isDownloading ? null : () => _downloadPdf(payment),
              icon: _isDownloading
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.download, size: 18.sp, color: Colors.white),
              label: Text(
                'Download PDF',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareReceipt(WaterPaymentEntity payment) async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await WaterBillPdfService.shareReceipt(payment: payment);
    } catch (e) {
      final text = '''Water Bill Payment Receipt
---
Provider: ${payment.providerName}
Customer: ${payment.customerName}
Customer Number: ${payment.customerNumber}
Amount: ${_formatAmount(payment.amount)}
Reference: ${payment.transactionReference ?? ''}
Date: ${_formatDate(payment.createdAt)}
Status: ${_formatStatus(payment.status)}
---
Powered by LazerVault''';
      SharePlus.instance
          .share(ShareParams(text: text, subject: 'Water Bill Receipt'));
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadPdf(WaterPaymentEntity payment) async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await WaterBillPdfService.downloadReceipt(payment: payment);
      Get.snackbar(
        'Download Complete',
        'Receipt saved: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12,
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt.',
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12,
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }
}
