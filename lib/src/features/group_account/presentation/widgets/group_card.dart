import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';

class GroupCard extends StatelessWidget {
  final GroupAccount group;
  final VoidCallback? onTap;

  const GroupCard({
    super.key,
    required this.group,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final memberCount = group.members.length;
    final contributionCount = group.contributions.length;
    final totalTargetAmount = group.contributions.fold<double>(
      0, (sum, contribution) => sum + contribution.targetAmount,
    );
    final totalCurrentAmount = group.contributions.fold<double>(
      0, (sum, contribution) => sum + contribution.currentAmount,
    );
    final progressPercentage = totalTargetAmount > 0 
        ? (totalCurrentAmount / totalTargetAmount) * 100 
        : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group Avatar
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 78, 3, 208),
                        const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      group.name.isNotEmpty ? group.name[0].toUpperCase() : 'G',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                
                // Group Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        group.description,
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
                
                // Visibility + Status Badges
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(group.status).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        group.status.displayName,
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(group.status),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          group.visibility == GroupVisibility.public
                              ? Icons.public
                              : Icons.lock,
                          size: 12.sp,
                          color: group.visibility == GroupVisibility.public
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF9CA3AF),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          group.visibility.displayName,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: group.visibility == GroupVisibility.public
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 20.h),
            
            // Stats Row
            Row(
              children: [
                _buildStatChip(
                  icon: Icons.people,
                  label: '$memberCount Members',
                  color: const Color(0xFF3B82F6),
                ),
                SizedBox(width: 12.w),
                _buildStatChip(
                  icon: Icons.account_balance_wallet,
                  label: '$contributionCount Contributions',
                  color: const Color(0xFF10B981),
                ),
              ],
            ),
            
            if (contributionCount > 0) ...[
              SizedBox(height: 16.h),
              
              // Progress Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Progress',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text(
                    '${progressPercentage.toStringAsFixed(1)}%',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              
              // Progress Bar
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: progressPercentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 78, 3, 208),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              
              // Amount Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${totalCurrentAmount.toStringAsFixed(2)} raised',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text(
                    'of \$${totalTargetAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: 16.h),
            
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Updated ${_formatDate(group.updatedAt)}',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey[500],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
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
            icon,
            size: 12.sp,
            color: color,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(GroupAccountStatus status) {
    switch (status) {
      case GroupAccountStatus.active:
        return Colors.green;
      case GroupAccountStatus.suspended:
        return Colors.red;
      case GroupAccountStatus.deleted:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
} 