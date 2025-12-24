import '../../../../../../core/theme/invoice_theme_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/invoice_theme_colors.dart';
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
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isOverdue
              ? InvoiceThemeColors.errorRed
              : InvoiceThemeColors.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isOverdue
                ? InvoiceThemeColors.errorRed.withOpacity(0.15)
                : Colors.black.withOpacity(0.1),
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
                InvoiceThemeColors.primaryPurple,
                InvoiceThemeColors.primaryPurple.withOpacity(0.7),
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
                  color: InvoiceThemeColors.textWhite,
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
                  color: InvoiceThemeColors.textGray400,
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
          backgroundColor = InvoiceThemeColors.errorRed.withOpacity(0.2);
          textColor = InvoiceThemeColors.errorRed;
          statusText = 'Overdue';
        } else {
          backgroundColor = InvoiceThemeColors.warningOrange.withOpacity(0.2);
          textColor = InvoiceThemeColors.warningOrange;
          statusText = 'Pending';
        }
        break;
      case PaymentStatus.processing:
        backgroundColor = InvoiceThemeColors.infoBlue.withOpacity(0.2);
        textColor = InvoiceThemeColors.infoBlue;
        statusText = 'Processing';
        break;
      case PaymentStatus.completed:
        backgroundColor = InvoiceThemeColors.successGreen.withOpacity(0.2);
        textColor = InvoiceThemeColors.successGreen;
        statusText = 'Paid';
        break;
      case PaymentStatus.failed:
        backgroundColor = InvoiceThemeColors.errorRed.withOpacity(0.2);
        textColor = InvoiceThemeColors.errorRed;
        statusText = 'Failed';
        break;
      case PaymentStatus.cancelled:
        backgroundColor = InvoiceThemeColors.textGray500.withOpacity(0.2);
        textColor = InvoiceThemeColors.textGray400;
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
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
                  color: InvoiceThemeColors.textGray500,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                invoice.formattedAmount,
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurple,
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
                color: InvoiceThemeColors.textGray500,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              invoice.formattedDueDate,
              style: GoogleFonts.inter(
                color: isOverdue ? InvoiceThemeColors.errorRed : InvoiceThemeColors.textWhite,
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
                      ? InvoiceThemeColors.errorRed
                      : InvoiceThemeColors.textGray400,
                  fontSize: 11.sp,
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
        color = InvoiceThemeColors.successGreen;
        icon = Icons.arrow_downward;
        break;
      case InvoicePriority.medium:
        color = InvoiceThemeColors.warningOrange;
        icon = Icons.remove;
        break;
      case InvoicePriority.high:
        color = InvoiceThemeColors.errorRed;
        icon = Icons.arrow_upward;
        break;
      case InvoicePriority.urgent:
        color = InvoiceThemeColors.errorRed;
        icon = Icons.priority_high;
        break;
    }

    return Container(
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(
        icon,
        size: 14.sp,
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
                  color: InvoiceThemeColors.textGray400,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (invoice.description.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  invoice.description,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray500,
                    fontSize: 11.sp,
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
            height: 38.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  InvoiceThemeColors.primaryPurple,
                  InvoiceThemeColors.primaryPurple.withOpacity(0.8),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(19.r),
              boxShadow: [
                BoxShadow(
                  color: InvoiceThemeColors.primaryPurple.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onPay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.r),
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
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else if (invoice.paymentStatus == PaymentStatus.completed) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(19.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: InvoiceThemeColors.successGreen,
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Paid',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.successGreen,
                    fontSize: 13.sp,
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
