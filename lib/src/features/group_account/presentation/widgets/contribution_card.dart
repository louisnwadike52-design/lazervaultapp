import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
                _buildTargetColumn(),
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
                
                // Payment button — only rendered when the parent
                // wires an onPayment callback. The parent uses the
                // role-permission helper to decide whether the
                // current user is allowed to contribute, so a
                // viewer never sees the button at all.
                if (!isCompleted && onPayment != null) ...[
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
                      color: const Color(0xFF10B981).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
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
      backgroundColor = const Color(0xFFEF4444).withValues(alpha: 0.2);
      textColor = const Color(0xFFEF4444);
      displayText = 'Overdue';
      icon = Icons.access_time;
    } else {
      switch (status) {
        case ContributionStatus.active:
          backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
          textColor = const Color(0xFF10B981);
          displayText = 'Active';
          icon = Icons.trending_up;
          break;
        case ContributionStatus.completed:
          backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
          textColor = const Color(0xFF10B981);
          displayText = 'Completed';
          icon = Icons.check_circle;
          break;
        case ContributionStatus.paused:
          backgroundColor = const Color(0xFFF59E0B).withValues(alpha: 0.2);
          textColor = const Color(0xFFF59E0B);
          displayText = 'Paused';
          icon = Icons.pause_circle;
          break;
        case ContributionStatus.cancelled:
          backgroundColor = const Color(0xFFEF4444).withValues(alpha: 0.2);
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
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

  // Render the contribution amount with thousands separators and at most
  // 2 decimal places. The previous K/M abbreviation collapsed
  // "30,000" → "30.0K" and "30,000,000" → "30.0M", which made it hard
  // to verify the exact amount the user entered. Now: 30000 → "30,000"
  // and 30000.5 → "30,000.50". Decimals are dropped when the value has
  // no fractional remainder so whole-pot displays stay clean.
  //
  // Input is `double` in MAJOR units (the gRPC data source's
  // _int64ToAmount already divided by 100 from minor → major).
  /// Right-side amount column. For ROSCA we explicitly label the value
  /// as "Cycle pot" and show the per-member share underneath, because
  /// ROSCA's `target_amount` IS per-member × member_count by design
  /// — labelling it "Target" makes a 10-member circle at ₦40k each
  /// look like a ₦400k goal, which reads as a 10× exaggeration even
  /// though the math is the standard ESUSU pot. For one-time
  /// contributions the original "Target" label is the right framing.
  Widget _buildTargetColumn() {
    final isRosca = contribution.type == ContributionType.rotatingSavings;
    final memberCount = contribution.members.length;
    final perMember = contribution.regularAmount;

    final label = isRosca ? 'Cycle pot' : 'Target';
    final amount =
        '${contribution.currency} ${_formatAmount(contribution.targetAmount)}';
    String? subtext;
    if (isRosca && perMember != null && perMember > 0 && memberCount > 0) {
      subtext =
          '$memberCount × ${contribution.currency} ${_formatAmount(perMember)}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey[300],
          ),
        ),
        if (subtext != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtext,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ],
    );
  }

  String _formatAmount(double amount) {
    final hasFraction = amount != amount.truncateToDouble();
    final fmt = NumberFormat.decimalPattern();
    fmt.minimumFractionDigits = hasFraction ? 2 : 0;
    fmt.maximumFractionDigits = 2;
    return fmt.format(amount);
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