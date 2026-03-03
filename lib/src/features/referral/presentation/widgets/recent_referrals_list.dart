import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/referral_transaction_entity.dart';

class RecentReferralsList extends StatelessWidget {
  final List<ReferralTransactionEntity> referrals;
  final String currency;

  const RecentReferralsList({
    super.key,
    required this.referrals,
    required this.currency,
  });

  String _getCurrencySymbol() {
    switch (currency.toUpperCase()) {
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'NGN':
        return '₦';
      case 'CAD':
        return 'C\$';
      default:
        return '\$';
    }
  }

  String _formatAmount(int amount) {
    return '${_getCurrencySymbol()}${(amount / 100).toStringAsFixed(0)}';
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 30) {
      return DateFormat('MMM d, y').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  Color _getStatusColor(ReferralStatus status) {
    switch (status) {
      case ReferralStatus.completed:
        return const Color(0xFF10B981);
      case ReferralStatus.pending:
        return const Color(0xFFF59E0B);
      case ReferralStatus.failed:
        return const Color(0xFFEF4444);
      case ReferralStatus.cancelled:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getStatusIcon(ReferralStatus status) {
    switch (status) {
      case ReferralStatus.completed:
        return Icons.check_circle_rounded;
      case ReferralStatus.pending:
        return Icons.schedule_rounded;
      case ReferralStatus.failed:
        return Icons.error_rounded;
      case ReferralStatus.cancelled:
        return Icons.cancel_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (referrals.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: 48.sp,
              color: const Color(0xFF2D2D2D),
            ),
            SizedBox(height: 12.h),
            Text(
              'No referrals yet',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Share your code to get started!',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...referrals.map((referral) => _buildReferralItem(referral)),
        ],
      ),
    );
  }

  Widget _buildReferralItem(ReferralTransactionEntity referral) {
    final statusColor = _getStatusColor(referral.status);
    final statusIcon = _getStatusIcon(referral.status);
    final displayName = referral.refereeDisplayName;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Status icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusIcon,
              size: 18.sp,
              color: statusColor,
            ),
          ),
          SizedBox(width: 12.w),
          // Referral info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _getTimeAgo(referral.createdAt),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          // Reward amount
          if (referral.status == ReferralStatus.completed)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '+${_formatAmount(referral.referrerRewardAmount)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
