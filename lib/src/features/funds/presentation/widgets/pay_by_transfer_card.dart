import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Shows the user's virtual-account details so they can fund their wallet by
/// transferring from their own bank app. Inbound transfers to the NUBAN are
/// credited automatically by the banking-service virtual-account webhook.
class PayByTransferCard extends StatefulWidget {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String? accountId;
  final String? userId;
  final String currency;
  final String countryCode;
  final VoidCallback? onInfoTap;

  const PayByTransferCard({
    super.key,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    this.accountId,
    this.userId,
    this.currency = 'NGN',
    this.countryCode = 'NG',
    this.onInfoTap,
  });

  @override
  State<PayByTransferCard> createState() => _PayByTransferCardState();
}

class _PayByTransferCardState extends State<PayByTransferCard> {
  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$label copied to clipboard',
      backgroundColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
    );
  }

  /// Build a clean, multi-line block of all the account details. Empty fields
  /// are omitted entirely so the clipboard never carries a "null"/blank line.
  String _buildDetailsBlock() {
    final lines = <String>[
      if (widget.bankName.trim().isNotEmpty) 'Bank: ${widget.bankName.trim()}',
      if (widget.accountNumber.trim().isNotEmpty)
        'Account Number: ${widget.accountNumber.trim()}',
      if (widget.accountName.trim().isNotEmpty)
        'Account Name: ${widget.accountName.trim()}',
    ];
    return lines.join('\n');
  }

  /// Copy ALL the account details (bank, number, name) as one formatted string.
  void _copyAllDetails(BuildContext context) {
    final block = _buildDetailsBlock();
    if (block.isEmpty) return;
    _copyToClipboard(context, block, 'Bank details');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
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
                  color: const Color(0xFF00D09C).withValues(alpha: 0.2),
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
                      'Transfer directly to your Lazervault wallet',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Copy ALL details (bank + account number + name) in one tap.
              IconButton(
                onPressed: () => _copyAllDetails(context),
                tooltip: 'Copy all details',
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
                icon: Icon(
                  Icons.copy_rounded,
                  color: const Color(0xFF00D09C),
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Account Details
          _buildDetailRow(
            context,
            label: 'Bank Name',
            value: widget.bankName,
            showCopy: false,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            label: 'Account Number',
            value: widget.accountNumber,
            showCopy: true,
            onCopy: () => _copyToClipboard(context, widget.accountNumber, 'Account number'),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            label: 'Account Name',
            value: widget.accountName,
            showCopy: true,
            onCopy: () => _copyToClipboard(context, widget.accountName, 'Account name'),
          ),

          SizedBox(height: 16.h),

          // Info note
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF00D09C).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF00D09C).withValues(alpha: 0.3),
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
        color: Colors.white.withValues(alpha: 0.05),
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
                  color: Colors.white.withValues(alpha: 0.5),
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
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.copy,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  size: 16.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
