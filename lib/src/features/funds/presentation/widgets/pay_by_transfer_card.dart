import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Pay by Transfer Card - Shows user's virtual account (NUBAN) details for deposits
/// Users can copy the account details and transfer directly from any bank app
class PayByTransferCard extends StatelessWidget {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final VoidCallback? onInfoTap;

  const PayByTransferCard({
    super.key,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    this.onInfoTap,
  });

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$label copied to clipboard',
      backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF00D09C).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF00D09C),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay by Transfer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Transfer directly to your LazerVault wallet',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Account Details
          _buildDetailRow(
            context,
            label: 'Bank Name',
            value: bankName,
            showCopy: false,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            label: 'Account Number',
            value: accountNumber,
            showCopy: true,
            onCopy: () => _copyToClipboard(context, accountNumber, 'Account number'),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            label: 'Account Name',
            value: accountName,
            showCopy: true,
            onCopy: () => _copyToClipboard(context, accountName, 'Account name'),
          ),

          SizedBox(height: 16.h),

          // Info note
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF00D09C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF00D09C).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF00D09C),
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Transfers usually arrive in 1-5 minutes',
                    style: TextStyle(
                      color: const Color(0xFF00D09C),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    bool showCopy = false,
    VoidCallback? onCopy,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: label == 'Account Number' ? 1.2 : 0,
                ),
              ),
            ],
          ),
          if (showCopy)
            GestureDetector(
              onTap: onCopy,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.copy,
                  color: const Color(0xFF6C5CE7),
                  size: 16.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
