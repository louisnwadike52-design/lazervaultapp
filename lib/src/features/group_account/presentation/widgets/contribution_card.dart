import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';

class ContributionCard extends StatelessWidget {
  final Contribution contribution;
  final VoidCallback? onTap;
  final VoidCallback? onPayment;

  const ContributionCard({
    super.key,
    required this.contribution,
    this.onTap,
    this.onPayment,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = contribution.progressPercentage;
    final isCompleted = contribution.isCompleted;
    final isOverdue = contribution.isOverdue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contribution.title,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        contribution.description,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.grey[400],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                _buildStatusBadge(contribution.status, isOverdue),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Progress Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      '${progressPercentage.toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isCompleted ? const Color(0xFF10B981) : Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: (progressPercentage / 100).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? const Color(0xFF10B981)
                                : isOverdue 
                                    ? const Color(0xFFEF4444)
                                    : const Color.fromARGB(255, 78, 3, 208),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Amount Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raised',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${contribution.currency} ${_formatAmount(contribution.currentAmount)}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Target',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${contribution.currency} ${_formatAmount(contribution.targetAmount)}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Footer Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deadline',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _formatDeadline(contribution.deadline),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isOverdue ? const Color(0xFFEF4444) : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Payment button
                if (!isCompleted) ...[
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: onPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payment, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'Contribute',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16.sp,
                          color: const Color(0xFF10B981),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Completed',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            
            // Payments count
            if (contribution.payments.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people,
                      size: 14.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${contribution.payments.length} payment${contribution.payments.length == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ContributionStatus status, bool isOverdue) {
    Color backgroundColor;
    Color textColor;
    String displayText;
    IconData icon;
    
    if (isOverdue) {
      backgroundColor = const Color(0xFFEF4444).withOpacity(0.2);
      textColor = const Color(0xFFEF4444);
      displayText = 'Overdue';
      icon = Icons.access_time;
    } else {
      switch (status) {
        case ContributionStatus.active:
          backgroundColor = const Color(0xFF10B981).withOpacity(0.2);
          textColor = const Color(0xFF10B981);
          displayText = 'Active';
          icon = Icons.trending_up;
          break;
        case ContributionStatus.completed:
          backgroundColor = const Color(0xFF10B981).withOpacity(0.2);
          textColor = const Color(0xFF10B981);
          displayText = 'Completed';
          icon = Icons.check_circle;
          break;
        case ContributionStatus.paused:
          backgroundColor = const Color(0xFFF59E0B).withOpacity(0.2);
          textColor = const Color(0xFFF59E0B);
          displayText = 'Paused';
          icon = Icons.pause_circle;
          break;
        case ContributionStatus.cancelled:
          backgroundColor = const Color(0xFFEF4444).withOpacity(0.2);
          textColor = const Color(0xFFEF4444);
          displayText = 'Cancelled';
          icon = Icons.cancel;
          break;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12.sp,
            color: textColor,
          ),
          SizedBox(width: 4.w),
          Text(
            displayText,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(2);
    }
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);
    
    if (difference.inDays < 0) {
      return 'Overdue by ${(-difference.inDays)} days';
    } else if (difference.inDays == 0) {
      return 'Due today';
    } else if (difference.inDays == 1) {
      return 'Due tomorrow';
    } else if (difference.inDays < 7) {
      return 'Due in ${difference.inDays} days';
    } else if (difference.inDays < 30) {
      return 'Due in ${(difference.inDays / 7).floor()} weeks';
    } else {
      return '${deadline.day}/${deadline.month}/${deadline.year}';
    }
  }
} 