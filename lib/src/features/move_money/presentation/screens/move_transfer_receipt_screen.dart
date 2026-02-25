import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/move_transfer.dart';
import '../widgets/move_status_badge.dart';
import '../../services/move_transfer_pdf_service.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Receipt screen displayed after a Move Money transfer is initiated.
///
/// Shows status icon (green check / red X / blue clock), transfer details,
/// fee breakdown, and action buttons. If the transfer requires DirectPay
/// authorization, a "Complete Authorization" button is shown.
class MoveTransferReceiptScreen extends StatelessWidget {
  const MoveTransferReceiptScreen({super.key});

  MoveTransfer get _transfer => Get.arguments as MoveTransfer;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _formatNaira(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return 'NGN ${formatter.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy  HH:mm:ss').format(date);
  }

  Color _statusColor(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return const Color(0xFF10B981);
      case MoveTransferStatus.failed:
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _statusIcon(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return Icons.check_circle_rounded;
      case MoveTransferStatus.failed:
        return Icons.cancel_rounded;
      default:
        return Icons.schedule_rounded;
    }
  }

  String _statusTitle(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return 'Transfer Successful';
      case MoveTransferStatus.failed:
        return 'Transfer Failed';
      default:
        return 'Transfer Processing';
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final transfer = _transfer;
    final color = _statusColor(transfer.status);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          icon: const Icon(Icons.close, color: Colors.white),
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
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Status icon
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _statusIcon(transfer.status),
                        color: color,
                        size: 42.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Status title
                    Text(
                      _statusTitle(transfer.status),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Amount
                    Text(
                      _formatNaira(transfer.amountNaira),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Status badge
                    MoveStatusBadge(status: transfer.status),

                    // Failure info
                    if (transfer.status == MoveTransferStatus.failed &&
                        transfer.failureReason != null) ...[
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              transfer.failureReason!,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFEF4444),
                                fontSize: 13.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (transfer.failureStage != null) ...[
                              SizedBox(height: 4.h),
                              Text(
                                'Failed at: ${transfer.failureStage}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFEF4444)
                                      .withValues(alpha: 0.7),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),

                    // Details card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(14.r),
                        border:
                            Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Reference',
                            transfer.reference,
                            isCopyable: true,
                            context: context,
                          ),
                          _buildDivider(),
                          _buildDetailRow(
                            'From',
                            '${transfer.sourceBankName}\n${transfer.sourceAccountName}\n${transfer.sourceAccountNumber}',
                          ),
                          _buildDivider(),
                          _buildDetailRow(
                            'To',
                            '${transfer.destinationBankName}\n${transfer.destinationAccountName}\n${transfer.destinationAccountNumber}',
                          ),
                          _buildDivider(),
                          _buildDetailRow(
                            'Amount',
                            _formatNaira(transfer.amountNaira),
                          ),
                          if (transfer.totalFee > 0) ...[
                            _buildDivider(),
                            _buildDetailRow(
                              'Debit Fee',
                              _formatNaira(transfer.debitFee / 100.0),
                            ),
                            _buildDetailRow(
                              'Transfer Fee',
                              _formatNaira(transfer.transferFee / 100.0),
                            ),
                            if (transfer.stampDuty > 0)
                              _buildDetailRow(
                                'Stamp Duty',
                                _formatNaira(transfer.stampDuty / 100.0),
                              ),
                            if (transfer.serviceFee > 0)
                              _buildDetailRow(
                                'Service Fee',
                                _formatNaira(
                                    transfer.serviceFee / 100.0),
                              ),
                            _buildDetailRow(
                              'Total Fees',
                              _formatNaira(transfer.totalFeeNaira),
                              isBold: true,
                            ),
                            _buildDivider(),
                            _buildDetailRow(
                              'Total Debit',
                              _formatNaira(transfer.totalDebitNaira),
                              isBold: true,
                              valueColor: const Color(0xFF60A5FA),
                            ),
                          ],
                          if (transfer.narration != null &&
                              transfer.narration!.isNotEmpty) ...[
                            _buildDivider(),
                            _buildDetailRow(
                              'Narration',
                              transfer.narration!,
                            ),
                          ],
                          _buildDivider(),
                          _buildDetailRow(
                            'Date',
                            _formatDate(transfer.createdAt),
                          ),
                          if (transfer.completedAt != null) ...[
                            _buildDetailRow(
                              'Completed',
                              _formatDate(transfer.completedAt!),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom actions
            _buildActions(context, transfer),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Detail row
  // ---------------------------------------------------------------------------

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    bool isCopyable = false,
    Color? valueColor,
    BuildContext? context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              onTap: isCopyable && context != null
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Copied to clipboard',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: const Color(0xFF10B981),
                          duration: const Duration(seconds: 1),
                        ),
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
                        fontWeight:
                            isBold ? FontWeight.w700 : FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  if (isCopyable) ...[
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.copy_rounded,
                      color: const Color(0xFF6B7280),
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
    return Divider(
      color: const Color(0xFF2D2D2D),
      height: 16.h,
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom actions
  // ---------------------------------------------------------------------------

  Widget _buildActions(BuildContext context, MoveTransfer transfer) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // DirectPay authorization button
          if (transfer.needsAuthorization &&
              transfer.paymentUrl != null) ...[
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final uri = Uri.parse(transfer.paymentUrl!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                icon: Icon(Icons.open_in_new, size: 18.sp),
                label: Text(
                  'Complete Authorization',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFB923C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],

          // Share + Move More
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final authState = context.read<AuthenticationCubit>().state;
                    if (authState is! AuthenticationSuccess) return;
                    final userName = '${authState.profile.user.firstName} ${authState.profile.user.lastName}'.trim();

                    try {
                      await MoveTransferPdfService.shareReceipt(
                        transfer: _transfer,
                        userName: userName,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to share receipt',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: const Color(0xFFEF4444),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.share_rounded, size: 18.sp),
                  label: Text(
                    'Share',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
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
                  onPressed: () =>
                      Get.offNamed('/move-money/transfer'),
                  icon: Icon(Icons.swap_horiz_rounded, size: 18.sp),
                  label: Text(
                    'Move More',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Back to Dashboard
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Back to Dashboard',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
