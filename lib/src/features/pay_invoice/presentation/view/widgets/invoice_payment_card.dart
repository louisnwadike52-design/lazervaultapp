import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/tagged_invoice_entity.dart';

class InvoicePaymentCard extends StatelessWidget {
  final TaggedInvoice invoice;
  final VoidCallback? onTap;
  final VoidCallback? onPay;
  final bool isOverdue;

  const InvoicePaymentCard({
    super.key,
    required this.invoice,
    this.onTap,
    this.onPay,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isOverdue 
              ? const Color(0xFFEF4444) 
              : const Color(0xFF2D2D2D),
          width: isOverdue ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isOverdue 
                ? const Color(0xFFEF4444).withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 16.h),
                _buildContent(),
                SizedBox(height: 16.h),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Company/User Avatar
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
            child: Text(
              invoice.fromCompanyName?.substring(0, 1).toUpperCase() ?? 
              invoice.fromUserName.substring(0, 1).toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        
        // Invoice Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                'From ${invoice.fromCompanyName ?? invoice.fromUserName}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        
        // Status Badge
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (invoice.paymentStatus) {
      case PaymentStatus.pending:
        if (isOverdue) {
          backgroundColor = const Color(0xFFEF4444).withOpacity(0.1);
          textColor = const Color(0xFFEF4444);
          statusText = 'Overdue';
        } else {
          backgroundColor = const Color(0xFFEAB308).withOpacity(0.1);
          textColor = const Color(0xFFEAB308);
          statusText = 'Pending';
        }
        break;
      case PaymentStatus.processing:
        backgroundColor = const Color(0xFF6366F1).withOpacity(0.1);
        textColor = const Color(0xFF6366F1);
        statusText = 'Processing';
        break;
      case PaymentStatus.completed:
        backgroundColor = const Color(0xFF10B981).withOpacity(0.1);
        textColor = const Color(0xFF10B981);
        statusText = 'Paid';
        break;
      case PaymentStatus.failed:
        backgroundColor = const Color(0xFFEF4444).withOpacity(0.1);
        textColor = const Color(0xFFEF4444);
        statusText = 'Failed';
        break;
      case PaymentStatus.cancelled:
        backgroundColor = const Color(0xFF6B7280).withOpacity(0.1);
        textColor = const Color(0xFF6B7280);
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: textColor, width: 1),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                invoice.formattedAmount,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        
        // Priority indicator
        _buildPriorityIndicator(),
        
        SizedBox(width: 16.w),
        
        // Due date info
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Due Date',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              invoice.formattedDueDate,
              style: GoogleFonts.inter(
                color: isOverdue ? const Color(0xFFEF4444) : Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (invoice.dueDate != null) ...[
              SizedBox(height: 2.h),
              Text(
                invoice.urgencyText,
                style: GoogleFonts.inter(
                  color: isOverdue 
                      ? const Color(0xFFEF4444) 
                      : const Color(0xFF9CA3AF),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityIndicator() {
    Color color;
    IconData icon;

    switch (invoice.priority) {
      case InvoicePriority.low:
        color = const Color(0xFF10B981);
        icon = Icons.arrow_downward;
        break;
      case InvoicePriority.medium:
        color = const Color(0xFFEAB308);
        icon = Icons.remove;
        break;
      case InvoicePriority.high:
        color = const Color(0xFFEF4444);
        icon = Icons.arrow_upward;
        break;
      case InvoicePriority.urgent:
        color = const Color(0xFFDC2626);
        icon = Icons.priority_high;
        break;
    }

    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color, width: 1),
      ),
      child: Icon(
        icon,
        size: 12.sp,
        color: color,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        // Invoice number
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice #${invoice.invoiceNumber}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (invoice.description.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Text(
                  invoice.description,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        
        // Action buttons
        if (onPay != null && invoice.paymentStatus == PaymentStatus.pending) ...[
          Container(
            height: 36.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: ElevatedButton(
              onPressed: onPay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.payment,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Pay Now',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else if (invoice.paymentStatus == PaymentStatus.completed) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: const Color(0xFF10B981)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: const Color(0xFF10B981),
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Paid',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
} 