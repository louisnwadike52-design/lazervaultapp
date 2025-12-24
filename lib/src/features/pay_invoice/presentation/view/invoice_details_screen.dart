import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/tagged_invoice_entity.dart';
import 'payment_method_selection_screen.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final TaggedInvoice invoice;

  const InvoiceDetailsScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen>
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
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
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
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInvoiceHeader(),
                          SizedBox(height: 24.h),
                          _buildInvoiceDetails(),
                          SizedBox(height: 24.h),
                          _buildItemsSection(),
                          SizedBox(height: 24.h),
                          _buildAmountBreakdown(),
                          SizedBox(height: 24.h),
                          _buildPaymentStatus(),
                          if (widget.invoice.paymentStatus == PaymentStatus.pending)
                            SizedBox(height: 100.h), // Space for payment button
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.invoice.paymentStatus == PaymentStatus.pending)
                _buildPaymentSection(),
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
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
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
                  'Invoice Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Invoice #${widget.invoice.invoiceNumber}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (widget.invoice.paymentStatus) {
      case PaymentStatus.completed:
        backgroundColor = const Color(0xFF10B981);
        textColor = Colors.white;
        statusText = 'PAID';
        break;
      case PaymentStatus.pending:
        if (widget.invoice.isOverdue) {
          backgroundColor = const Color(0xFFEF4444);
          textColor = Colors.white;
          statusText = 'OVERDUE';
        } else {
          backgroundColor = const Color(0xFFF59E0B);
          textColor = Colors.white;
          statusText = 'PENDING';
        }
        break;
      case PaymentStatus.processing:
        backgroundColor = const Color(0xFF3B82F6);
        textColor = Colors.white;
        statusText = 'PROCESSING';
        break;
      case PaymentStatus.failed:
        backgroundColor = const Color(0xFFEF4444);
        textColor = Colors.white;
        statusText = 'FAILED';
        break;
      case PaymentStatus.cancelled:
        backgroundColor = const Color(0xFF6B7280);
        textColor = Colors.white;
        statusText = 'CANCELLED';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader() {
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
        borderRadius: BorderRadius.circular(16.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3B82F6),
                      const Color(0xFF8B5CF6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: widget.invoice.fromCompanyLogo != null 
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: Image.network(
                          widget.invoice.fromCompanyLogo!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
                        ),
                      )
                    : _buildFallbackAvatar(),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.invoice.fromCompanyName ?? widget.invoice.fromUserName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.invoice.fromUserEmail,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            widget.invoice.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (widget.invoice.description.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              widget.invoice.description,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    final firstLetter = (widget.invoice.fromCompanyName ?? widget.invoice.fromUserName)[0].toUpperCase();
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3B82F6),
            const Color(0xFF8B5CF6),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Center(
        child: Text(
          firstLetter,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Information',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Invoice Number', widget.invoice.invoiceNumber),
          _buildDetailRow('Issue Date', _formatDate(widget.invoice.createdAt)),
          _buildDetailRow('Due Date', _formatDate(widget.invoice.dueDate)),
          if (widget.invoice.paidAt != null)
            _buildDetailRow('Paid Date', _formatDate(widget.invoice.paidAt!)),
          _buildDetailRow('Currency', widget.invoice.currency),
          if (widget.invoice.isOverdue && widget.invoice.paymentStatus != PaymentStatus.completed)
            _buildDetailRow('Days Overdue', '${widget.invoice.daysUntilDue.abs()} days', isHighlight: true),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Items',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ...widget.invoice.items.map((item) => _buildInvoiceItem(item)),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(InvoiceItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '£${item.totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (item.description?.isNotEmpty == true) ...[
            SizedBox(height: 4.h),
            Text(
              item.description!,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                'Qty: ${item.quantity}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                'Unit Price: £${item.unitPrice.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountBreakdown() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildAmountRow('Subtotal', widget.invoice.amount),
          if ((widget.invoice.taxAmount ?? 0) > 0)
            _buildAmountRow('Tax', widget.invoice.taxAmount!),
          if ((widget.invoice.discountAmount ?? 0) > 0)
            _buildAmountRow('Discount', -widget.invoice.discountAmount!),
          SizedBox(height: 12.h),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          SizedBox(height: 12.h),
          _buildAmountRow('Total Amount', widget.invoice.totalAmount, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPaymentStatus() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Status',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildStatusIndicator(),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusText(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _getStatusDescription(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF0A0E27).withValues(alpha: 0.8),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            if (widget.invoice.isOverdue)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
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
                    Icon(
                      Icons.warning_rounded,
                      color: const Color(0xFFEF4444),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'This invoice is ${widget.invoice.daysUntilDue.abs()} days overdue',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _proceedToPayment,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Center(
                    child: Text(
                      'Pay £${widget.invoice.totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: isHighlight ? const Color(0xFFEF4444) : Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            '£${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: isTotal ? const Color(0xFF10B981) : Colors.white,
              fontSize: isTotal ? 18.sp : 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    Color color;
    IconData icon;

    switch (widget.invoice.paymentStatus) {
      case PaymentStatus.completed:
        color = const Color(0xFF10B981);
        icon = Icons.check_circle;
        break;
      case PaymentStatus.pending:
        color = widget.invoice.isOverdue ? const Color(0xFFEF4444) : const Color(0xFFF59E0B);
        icon = widget.invoice.isOverdue ? Icons.error : Icons.access_time;
        break;
      case PaymentStatus.processing:
        color = const Color(0xFF3B82F6);
        icon = Icons.sync;
        break;
      case PaymentStatus.failed:
        color = const Color(0xFFEF4444);
        icon = Icons.error;
        break;
      case PaymentStatus.cancelled:
        color = const Color(0xFF6B7280);
        icon = Icons.cancel;
        break;
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20.sp,
      ),
    );
  }

  String _getStatusText() {
    switch (widget.invoice.paymentStatus) {
      case PaymentStatus.completed:
        return 'Payment Completed';
      case PaymentStatus.pending:
        return widget.invoice.isOverdue ? 'Payment Overdue' : 'Payment Pending';
      case PaymentStatus.processing:
        return 'Payment Processing';
      case PaymentStatus.failed:
        return 'Payment Failed';
      case PaymentStatus.cancelled:
        return 'Payment Cancelled';
    }
  }

  String _getStatusDescription() {
    switch (widget.invoice.paymentStatus) {
      case PaymentStatus.completed:
        return 'This invoice has been paid successfully';
      case PaymentStatus.pending:
        return widget.invoice.isOverdue 
            ? 'Payment is overdue by ${widget.invoice.daysUntilDue.abs()} days'
            : 'Payment is due in ${widget.invoice.daysUntilDue} days';
      case PaymentStatus.processing:
        return 'Payment is being processed';
      case PaymentStatus.failed:
        return 'Payment attempt failed';
      case PaymentStatus.cancelled:
        return 'Payment was cancelled';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(date);
  }

  void _proceedToPayment() {
    HapticFeedback.lightImpact();
    
    Get.to(
      () => PaymentMethodSelectionScreen(invoice: widget.invoice),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }
} 