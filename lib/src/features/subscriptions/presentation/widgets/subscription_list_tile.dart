import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';

/// List tile for a single subscription item.
class SubscriptionListTile extends StatelessWidget {
  final ActiveSubscriptionEntity subscription;
  final VoidCallback? onTap;

  const SubscriptionListTile({
    super.key,
    required this.subscription,
    this.onTap,
  });

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    final symbol = subscription.currency.isNotEmpty
        ? CurrencySymbols.getSymbol(subscription.currency)
        : CurrencySymbols.currentSymbol;
    return '$symbol${formatter.format(amount)}';
  }

  String get _daysText {
    if (!subscription.hasExpiry) return 'No expiry';
    if (subscription.isExpired || subscription.daysRemaining <= 0) {
      return 'Expired';
    }
    if (subscription.daysRemaining == 1) return '1 day left';
    return '${subscription.daysRemaining} days left';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Type icon
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: subscription.statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                subscription.typeIcon,
                color: subscription.statusColor,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Plan name & provider
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subscription.planName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subscription.providerName,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Amount + status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatAmount(subscription.amount),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: subscription.statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    _daysText,
                    style: TextStyle(
                      color: subscription.statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
