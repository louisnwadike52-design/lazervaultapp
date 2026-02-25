import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../services/wallet_transfer_pdf_service.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTransferReceiptScreen extends StatelessWidget {
  const WalletTransferReceiptScreen({super.key});

  Map<String, dynamic> get _args => Get.arguments as Map<String, dynamic>;

  String _formatCurrency(double amount, String currency) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return '$currency ${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    final sourceAccount = _args['sourceAccount'] as String? ?? '';
    final destinationAccount = _args['destinationAccount'] as String? ?? '';
    final amount = (_args['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = _args['currency'] as String? ?? 'NGN';
    final reference = _args['reference'] as String? ?? '';
    final newBalance = (_args['newBalance'] as num?)?.toDouble();

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
                    SizedBox(height: 16.h),

                    // Success icon
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: const Color(0xFF10B981),
                        size: 42.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Title
                    Text(
                      'Transfer Successful',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Amount
                    Text(
                      _formatCurrency(amount, currency),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Free transfer badge
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Free transfer',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // Details card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow('From', sourceAccount),
                          _buildDivider(),
                          _buildDetailRow('To', destinationAccount),
                          _buildDivider(),
                          _buildDetailRow(
                              'Amount', _formatCurrency(amount, currency)),
                          _buildDivider(),
                          _buildDetailRow(
                            'Fee',
                            _formatCurrency(0, currency),
                            valueColor: const Color(0xFF10B981),
                          ),
                          _buildDivider(),
                          _buildDetailRow(
                            'Total',
                            _formatCurrency(amount, currency),
                            isBold: true,
                          ),
                          if (reference.isNotEmpty) ...[
                            _buildDivider(),
                            _buildDetailRow('Reference', reference,
                                isCopyable: true, context: context),
                          ],
                          if (newBalance != null) ...[
                            _buildDivider(),
                            _buildDetailRow(
                              'Source Balance',
                              _formatCurrency(newBalance, currency),
                              valueColor: const Color(0xFF60A5FA),
                            ),
                          ],
                          _buildDivider(),
                          _buildDetailRow(
                            'Date',
                            DateFormat('MMM d, yyyy  HH:mm')
                                .format(DateTime.now()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom actions
            _buildActions(context),
          ],
        ),
      ),
    );
  }

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
                          content: Text('Copied to clipboard',
                              style: GoogleFonts.inter()),
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
                        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  if (isCopyable) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.copy_rounded,
                        color: const Color(0xFF6B7280), size: 14.sp),
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
    return Divider(color: const Color(0xFF2D2D2D), height: 16.h);
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final authState = context.read<AuthenticationCubit>().state;
                    if (authState is! AuthenticationSuccess) return;
                    final userName = '${authState.profile.user.firstName} ${authState.profile.user.lastName}'.trim();

                    // Create a PaymentsTransferResult from the args
                    final transfer = PaymentsTransferResult(
                      success: true,
                      transferId: _args['transferId'] as String?,
                      reference: _args['reference'] as String?,
                      status: 'completed',
                      amount: (_args['amount'] as num?)?.toDouble().toInt(),
                      createdAt: DateTime.now(),
                      newBalance: (_args['newBalance'] as num?)?.toDouble(),
                    );

                    // Get account names from args
                    final sourceName = _args['sourceAccount'] as String? ?? 'Source Account';
                    final destName = _args['destinationAccount'] as String? ?? 'Destination Account';

                    try {
                      await WalletTransferPdfService.shareReceipt(
                        transfer: transfer,
                        userName: userName,
                        sourceAccountName: sourceName,
                        destinationAccountName: destName,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to share receipt',
                              style: GoogleFonts.inter()),
                          backgroundColor: const Color(0xFFEF4444),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.share_rounded, size: 18.sp),
                  label: Text(
                    'Share',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, fontWeight: FontWeight.w600),
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
                      Get.offNamed(AppRoutes.walletTransfer),
                  icon: Icon(Icons.swap_horiz_rounded, size: 18.sp),
                  label: Text(
                    'Transfer More',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, fontWeight: FontWeight.w600),
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
