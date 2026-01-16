import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/scan_entities.dart';

/// Receipt screen displayed after successful bank details payment
///
/// Shows:
/// - Success animation
/// - Amount sent
/// - Transaction details
/// - Share and download options
class BankDetailsReceiptScreen extends StatefulWidget {
  final PaymentReceipt receipt;

  const BankDetailsReceiptScreen({
    Key? key,
    required this.receipt,
  }) : super(key: key);

  @override
  State<BankDetailsReceiptScreen> createState() =>
      _BankDetailsReceiptScreenState();
}

class _BankDetailsReceiptScreenState extends State<BankDetailsReceiptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _successAnimationController;
  bool _animationPlayed = false;

  @override
  void initState() {
    super.initState();
    _successAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Play success animation once
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && !_animationPlayed) {
        _successAnimationController.forward();
        _animationPlayed = true;

        // Add haptic feedback for success
        HapticFeedback.mediumImpact();
      }
    });
  }

  @override
  void dispose() {
    _successAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // Success Animation
            _buildSuccessAnimation(),

            SizedBox(height: 16.h),

            // Success Message
            _buildSuccessMessage(),

            if (widget.receipt.isExternal) _buildExternalTransferNote(),

            SizedBox(height: 32.h),

            // Amount Card
            _buildAmountCard(),

            SizedBox(height: 24.h),

            // Details Card
            _buildDetailsCard(),

            SizedBox(height: 24.h),

            // Action Buttons
            _buildActionButtons(),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: const Color(0xFF111827),
          size: 24.r,
        ),
        onPressed: () => _handleClose(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.download_outlined,
            color: const Color(0xFF111827),
            size: 24.r,
          ),
          onPressed: () => _downloadReceipt(),
          tooltip: 'Download receipt',
        ),
      ],
    );
  }

  Widget _buildSuccessAnimation() {
    return Lottie.asset(
      'assets/animations/success_check.json',
      width: 120.w,
      height: 120.h,
      repeat: false,
      controller: _successAnimationController,
      onLoaded: (composition) {
        _successAnimationController.duration = composition.duration;
      },
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Text(
          widget.receipt.isExternal
              ? 'Transfer Initiated'
              : 'Transfer Successful',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF111827),
          ),
        ),
        if (widget.receipt.status.toLowerCase() == 'completed')
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16.r,
                  color: const Color(0xFF10B981),
                ),
                SizedBox(width: 4.w),
                Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildExternalTransferNote() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Text(
        'You\'ll be notified when the transfer is completed',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    final currencyFormatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(widget.receipt.currency),
      decimalDigits: 2,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withOpacity(0.3),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Amount Sent',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            currencyFormatter.format(widget.receipt.amount),
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.receipt.currency,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111827),
                ),
              ),
              if (widget.receipt.isExternal)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'External',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          _buildDetailRow('Recipient', widget.receipt.recipientName),
          _buildDetailRow(
            'Account Number',
            widget.receipt.maskedAccountNumber,
            showCopy: false,
          ),
          _buildDetailRow('Bank', widget.receipt.bankName),
          _buildDetailRow(
            'Reference',
            widget.receipt.reference,
            showCopy: true,
          ),
          _buildDetailRow('Date', widget.receipt.formattedDate),
          _buildDetailRow('Time', widget.receipt.formattedTime),
          _buildDetailRow(
            'Status',
            widget.receipt.statusDisplayText,
            isStatus: true,
          ),

          if (widget.receipt.description != null &&
              widget.receipt.description!.isNotEmpty)
            _buildDetailRow('Description', widget.receipt.description!),

          if (widget.receipt.transferReference != null)
            _buildDetailRow(
              'Transfer Reference',
              widget.receipt.transferReference!,
              showCopy: true,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isStatus = false,
    bool showCopy = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isStatus)
                  _buildStatusBadge(value)
                else
                  Flexible(
                    child: Text(
                      value,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ),
                if (showCopy && !isStatus)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: GestureDetector(
                      onTap: () => _copyToClipboard(value),
                      child: Icon(
                        Icons.copy_outlined,
                        size: 16.r,
                        color: const Color(0xFF6B7280),
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

  Widget _buildStatusBadge(String status) {
    final statusLower = status.toLowerCase();
    Color color;
    IconData icon;

    if (statusLower == 'completed') {
      color = const Color(0xFF10B981);
      icon = Icons.check_circle;
    } else if (statusLower == 'processing' || statusLower == 'pending') {
      color = const Color(0xFFF59E0B);
      icon = Icons.schedule;
    } else if (statusLower == 'failed') {
      color = const Color(0xFFEF4444);
      icon = Icons.error;
    } else {
      color = const Color(0xFF6B7280);
      icon = Icons.info;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: color),
          SizedBox(width: 4.w),
          Text(
            status,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          // Share Receipt Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: () => _shareReceipt(),
              icon: Icon(Icons.share_outlined, size: 20.r),
              label: Text(
                'Share Receipt',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4E03D0),
                side: const BorderSide(color: Color(0xFF4E03D0), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Done Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () => _handleClose(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareReceipt() {
    final receipt = widget.receipt;
    final currencyFormatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(receipt.currency),
      decimalDigits: 2,
    );

    final shareText = '''
LazerVault - Payment Receipt

Amount: ${currencyFormatter.format(receipt.amount)}
Recipient: ${receipt.recipientName}
Account: ${receipt.maskedAccountNumber}
Bank: ${receipt.bankName}
Reference: ${receipt.reference}
Date: ${receipt.formattedDate} at ${receipt.formattedTime}
Status: ${receipt.statusDisplayText}

${receipt.description != null && receipt.description!.isNotEmpty ? 'Description: ${receipt.description}\n' : ''}
Powered by LazerVault
    ''';

    Share.share(
      shareText,
      subject: 'LazerVault Payment Receipt',
    );
  }

  void _downloadReceipt() {
    // TODO: Implement PDF generation and download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            const Expanded(
              child: Text('Receipt download feature coming soon'),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4E03D0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            const Expanded(
              child: Text('Copied to clipboard'),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleClose(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      default:
        return currency;
    }
  }
}
