import '../../../../../core/theme/invoice_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/invoice_entity.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback onTap;
  final VoidCallback? onMoreTap;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.onTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 12.h),
            _buildContent(),
            SizedBox(height: 12.h),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: _getStatusColor().withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            invoice.statusDisplayName,
            style: GoogleFonts.inter(
              color: _getStatusColor(),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.borderColor,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            invoice.typeDisplayName,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        if (onMoreTap != null)
          GestureDetector(
            onTap: onMoreTap,
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Icon(
                Icons.more_vert,
                color: Colors.grey[400],
                size: 16.sp,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
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
        if (invoice.description.isNotEmpty)
          Text(
            invoice.description,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        SizedBox(height: 8.h),
        Row(
          children: [
            if (invoice.toName != null || invoice.toEmail != null) ...[
              Icon(
                Icons.person_outline,
                color: Colors.grey[500],
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  invoice.toName ?? invoice.toEmail ?? 'Unknown',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${invoice.currency} ${invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (invoice.dueDate != null) ...[
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: invoice.isOverdue ? Colors.red : Colors.grey[500],
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Due ${_formatDate(invoice.dueDate!)}',
                      style: GoogleFonts.inter(
                        color: invoice.isOverdue ? Colors.red : Colors.grey[400],
                        fontSize: 11.sp,
                        fontWeight: invoice.isOverdue ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatDate(invoice.createdAt),
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 11.sp,
              ),
            ),
            if (invoice.items.isNotEmpty) ...[
              SizedBox(height: 2.h),
              Text(
                '${invoice.items.length} item${invoice.items.length != 1 ? 's' : ''}',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (invoice.status) {
      case InvoiceStatus.draft:
        return Colors.grey;
      case InvoiceStatus.pending:
        return Colors.orange;
      case InvoiceStatus.paid:
        return Colors.green;
      case InvoiceStatus.partiallyPaid:
        return const Color(0xFFF59E0B);
      case InvoiceStatus.expired:
        return Colors.red;
      case InvoiceStatus.cancelled:
        return Colors.red.shade300;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '${difference}d ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
} 