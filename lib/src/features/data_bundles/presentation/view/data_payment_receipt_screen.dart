import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../../services/data_bundles_pdf_service.dart';

class DataPaymentReceiptScreen extends StatefulWidget {
  const DataPaymentReceiptScreen({super.key});

  @override
  State<DataPaymentReceiptScreen> createState() =>
      _DataPaymentReceiptScreenState();
}

class _DataPaymentReceiptScreenState extends State<DataPaymentReceiptScreen> {
  bool _isDownloading = false;
  bool _isSharing = false;

  String _formatAmount(double amount) {
    final format = NumberFormat('#,##0.00', 'en_NG');
    return '\u20A6${format.format(amount)}';
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String _formatStatus(String status) {
    return status
        .split('_')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF10B981);
      case 'pending':
        return const Color(0xFFFB923C);
      case 'failed':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final purchase = args['purchase'] as DataPurchaseEntity;
    final networkName = args['networkName'] as String? ?? '';
    final planName = args['planName'] as String? ?? purchase.dataPlan;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
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

                    // Success icon
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF10B981)
                            .withValues(alpha: 0.15),
                        border: Border.all(
                          color: const Color(0xFF10B981)
                              .withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        purchase.isCompleted
                            ? Icons.check_circle
                            : purchase.isPending
                                ? Icons.schedule
                                : Icons.error_outline,
                        color: purchase.isCompleted
                            ? const Color(0xFF10B981)
                            : purchase.isPending
                                ? const Color(0xFFFB923C)
                                : const Color(0xFFEF4444),
                        size: 44.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      purchase.isCompleted
                          ? 'Data Purchase Successful!'
                          : purchase.isPending
                              ? 'Data Purchase Pending'
                              : 'Data Purchase Failed',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      _formatAmount(purchase.amount),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Pending banner
                    if (purchase.isPending) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB923C)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFFB923C)
                                .withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18.sp,
                              color: const Color(0xFFFB923C),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Your data purchase is being processed. The data bundle will be activated shortly.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFFB923C),
                                  fontSize: 13.sp,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

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

                          _buildReceiptRow('Network', networkName),
                          _buildDivider(),
                          _buildReceiptRow('Data Plan', planName),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Phone Number',
                            purchase.phoneNumber,
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Amount',
                            _formatAmount(purchase.amount),
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Reference',
                            purchase.reference,
                            isCopyable: true,
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Date',
                            _formatDate(purchase.createdAt),
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Status',
                            _formatStatus(purchase.status),
                            valueColor: _statusColor(purchase.status),
                          ),
                          if (purchase.newBalance > 0) ...[
                            _buildDivider(),
                            _buildReceiptRow(
                              'New Balance',
                              _formatAmount(purchase.newBalance),
                            ),
                          ],
                          if (purchase.providerReference.isNotEmpty) ...[
                            _buildDivider(),
                            _buildReceiptRow(
                              'Provider Ref',
                              purchase.providerReference,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            // Bottom actions
            _buildActions(context, purchase, networkName, planName),
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
                        'Reference copied to clipboard',
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
                    Icon(
                      Icons.copy,
                      color: const Color(0xFF9CA3AF),
                      size: 14.sp,
                    ),
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
    return const Divider(
      color: Color(0xFF2D2D2D),
      height: 1,
    );
  }

  Widget _buildActions(
    BuildContext context,
    DataPurchaseEntity purchase,
    String networkName,
    String planName,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Share Receipt
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isSharing
                  ? null
                  : () => _shareReceipt(purchase, networkName, planName),
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
                  : Icon(
                      Icons.share,
                      size: 18.sp,
                      color: Colors.white,
                    ),
              label: Text(
                'Share Receipt',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF2D2D2D),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Download PDF
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isDownloading
                  ? null
                  : () => _downloadPdf(purchase, networkName, planName),
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
                  : Icon(
                      Icons.download,
                      size: 18.sp,
                      color: Colors.white,
                    ),
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

  Future<void> _shareReceipt(
    DataPurchaseEntity purchase,
    String networkName,
    String planName,
  ) async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await DataBundlesPdfService.shareReceipt(
        purchase: purchase,
        network: networkName,
        planName: planName,
      );
    } catch (e) {
      // Fallback to text share
      final text = '''Data Bundle Purchase Receipt
---
Network: $networkName
Plan: $planName
Phone Number: ${purchase.phoneNumber}
Amount: ${_formatAmount(purchase.amount)}
Reference: ${purchase.reference}
Date: ${_formatDate(purchase.createdAt)}
Status: ${_formatStatus(purchase.status)}
---
Powered by LazerVault''';

      SharePlus.instance.share(
        ShareParams(text: text, subject: 'Data Bundle Purchase Receipt'),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadPdf(
    DataPurchaseEntity purchase,
    String networkName,
    String planName,
  ) async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await DataBundlesPdfService.downloadReceipt(
        purchase: purchase,
        network: networkName,
        planName: planName,
      );
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
