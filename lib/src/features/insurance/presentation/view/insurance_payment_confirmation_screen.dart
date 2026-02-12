import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/insurance_payment_entity.dart';

class InsurancePaymentConfirmationScreen extends StatefulWidget {
  final InsurancePayment payment;
  final String receiptUrl;

  const InsurancePaymentConfirmationScreen({
    super.key,
    required this.payment,
    required this.receiptUrl,
  });

  @override
  State<InsurancePaymentConfirmationScreen> createState() => _InsurancePaymentConfirmationScreenState();
}

class _InsurancePaymentConfirmationScreenState extends State<InsurancePaymentConfirmationScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          _buildSuccessIcon(),
                          SizedBox(height: 32.h),
                          _buildReceiptCard(),
                          SizedBox(height: 24.h),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Receipt',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Transaction completed successfully',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 50.sp,
      ),
    );
  }

  Widget _buildReceiptCard() {
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
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiptHeader(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildTransactionDetails(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildPaymentMethod(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 20.h),
          _buildReceiptFooter(),
        ],
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.receipt_long,
                color: const Color(0xFF6366F1),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'PAYMENT RECEIPT',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'Policy #${widget.payment.policyNumber}',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6366F1),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Text(
            'PAID',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF10B981),
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction Details',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Transaction ID', widget.payment.transactionId ?? 'N/A'),
        _buildDetailRow('Amount', '\$${widget.payment.amount.toStringAsFixed(2)}'),
        _buildDetailRow('Date', '${widget.payment.paymentDate.day}/${widget.payment.paymentDate.month}/${widget.payment.paymentDate.year}'),
        _buildDetailRow('Status', 'Completed'),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  widget.payment.paymentMethod.icon,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF6366F1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.payment.paymentMethod.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Premium payment processed',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: label == 'Amount' ? FontWeight.bold : FontWeight.w600,
              color: label == 'Amount' ? const Color(0xFF10B981) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptFooter() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        children: [
          Text(
            'Thank you for your payment!',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6366F1),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'This receipt serves as proof of payment for your insurance premium. Your policy is now up to date.',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (widget.receiptUrl.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _viewReceipt,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'View Receipt',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _emailReceipt,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: const Color(0xFF6366F1),
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Email Receipt',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6366F1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
        ],
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _shareReceipt,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: const Color(0xFF6366F1),
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Share',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _copyDetails,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.copy_outlined,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Copy Details',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.w),
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Back to Insurance',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _viewReceipt() {
    if (widget.receiptUrl.isNotEmpty) {
      launchUrl(
        Uri.parse(widget.receiptUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _emailReceipt() {
    final subject = Uri.encodeComponent('Insurance Payment Receipt - ${widget.payment.policyNumber}');
    final body = Uri.encodeComponent('Your insurance payment receipt: ${widget.receiptUrl}');
    launchUrl(
      Uri.parse('mailto:?subject=$subject&body=$body'),
      mode: LaunchMode.externalApplication,
    );
  }

  void _shareReceipt() {
    final text = '''
Insurance Payment Receipt

Policy: ${widget.payment.policyNumber}
Amount: \$${widget.payment.amount.toStringAsFixed(2)}
Transaction ID: ${widget.payment.transactionId ?? 'N/A'}
Payment Method: ${widget.payment.paymentMethod.displayName}
Date: ${widget.payment.paymentDate.day}/${widget.payment.paymentDate.month}/${widget.payment.paymentDate.year}
Status: Completed

Thank you for your payment!
''';
    SharePlus.instance.share(ShareParams(text: text));
  }

  void _copyDetails() {
    final details = '''
Transaction ID: ${widget.payment.transactionId ?? 'N/A'}
Amount: \$${widget.payment.amount.toStringAsFixed(2)}
Policy: ${widget.payment.policyNumber}
Date: ${widget.payment.paymentDate.day}/${widget.payment.paymentDate.month}/${widget.payment.paymentDate.year}
''';
    
    Clipboard.setData(ClipboardData(text: details));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Details copied to clipboard',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
} 