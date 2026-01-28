import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';

class PaymentHistoryCard extends StatelessWidget {
  final ContributionPayment payment;
  final VoidCallback? onTap;

  const PaymentHistoryCard({
    super.key,
    required this.payment,
    this.onTap,
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
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: _getStatusColor(payment.status).withValues(alpha: 0.2),
                  child: Icon(
                    _getStatusIcon(payment.status),
                    color: _getStatusColor(payment.status),
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.userName,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        DateFormat('MMM dd, yyyy HH:mm').format(payment.paymentDate),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${payment.currency} ${payment.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(payment.status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                      ),
                      child: Text(
                        payment.status.displayName,
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(payment.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (payment.notes != null && payment.notes!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  payment.notes!,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            if (payment.transactionId != null) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.receipt,
                    size: 12.sp,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'ID: ${payment.transactionId}',
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return const Color(0xFFF59E0B);
      case PaymentStatus.processing:
        return const Color(0xFF3B82F6);
      case PaymentStatus.completed:
        return const Color(0xFF10B981);
      case PaymentStatus.failed:
        return const Color(0xFFEF4444);
      case PaymentStatus.cancelled:
        return const Color(0xFF6B7280);
      case PaymentStatus.refunded:
        return const Color(0xFF8B5CF6);
    }
  }

  IconData _getStatusIcon(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return Icons.schedule;
      case PaymentStatus.processing:
        return Icons.sync;
      case PaymentStatus.completed:
        return Icons.check_circle;
      case PaymentStatus.failed:
        return Icons.error;
      case PaymentStatus.cancelled:
        return Icons.cancel;
      case PaymentStatus.refunded:
        return Icons.undo;
    }
  }
} 