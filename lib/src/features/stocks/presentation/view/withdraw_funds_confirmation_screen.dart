import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

/// Confirmation screen showing withdrawal receipt
class WithdrawFundsConfirmationScreen extends StatefulWidget {
  final double amount;
  final String paymentMethod;

  const WithdrawFundsConfirmationScreen({
    super.key,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  State<WithdrawFundsConfirmationScreen> createState() => _WithdrawFundsConfirmationScreenState();
}

class _WithdrawFundsConfirmationScreenState extends State<WithdrawFundsConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final String _transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _copyTransactionId() {
    Clipboard.setData(ClipboardData(text: _transactionId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Transaction ID copied to clipboard',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareReceipt() {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
    final now = DateTime.now();

    final receiptText = '''
💰 Withdrawal Receipt

Transaction ID: $_transactionId
Status: Completed

━━━━━━━━━━━━━━━━━━━━━━
Amount: \$${widget.amount.toStringAsFixed(2)}
Payment Method: ${widget.paymentMethod}
Date: ${dateFormat.format(now)}
━━━━━━━━━━━━━━━━━━━━━━

💼 LazerVault Portfolio
🚀 Generated with Claude Code
''';

    SharePlus.instance.share(ShareParams(
      text: receiptText,
      subject: 'Withdrawal Receipt - $_transactionId',
    )).then((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Receipt shared successfully',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _returnToPortfolio() {
    Get.until((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Success icon
                  _buildSuccessIcon(),

                  SizedBox(height: 32.h),

                  // Success message
                  Text(
                    'Withdrawal Successful!',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    'Your funds are being processed',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32.h),

                  // Receipt card
                  _buildReceiptCard(),

                  SizedBox(height: 24.h),

                  // Action buttons
                  _buildActionButtons(),

                  SizedBox(height: 24.h),

                  // Return button
                  _buildReturnButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha: 0.3),
            Colors.red.shade700.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Icon(
        Icons.check_circle,
        size: 60.sp,
        color: Colors.red,
      ),
    );
  }

  Widget _buildReceiptCard() {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction ID',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _transactionId,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Completed',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Amount
          Center(
            child: Column(
              children: [
                Text(
                  'Withdrawal Amount',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$${widget.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Transaction details
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailRow('Payment Method', widget.paymentMethod),
          SizedBox(height: 12.h),
          _buildDetailRow('Date & Time', dateFormat.format(DateTime.now())),
          SizedBox(height: 12.h),
          _buildDetailRow('Status', 'Processing'),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Confirmation message
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.red, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Funds will be available in your account within the specified processing time.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.red[200],
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey[400],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.1),
      height: 1,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _copyTransactionId,
            icon: Icon(Icons.copy, size: 18.sp),
            label: const Text('Copy ID'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
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
            onPressed: _shareReceipt,
            icon: Icon(Icons.share, size: 18.sp),
            label: const Text('Share'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReturnButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _returnToPortfolio,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53E3E),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'View Portfolio',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
