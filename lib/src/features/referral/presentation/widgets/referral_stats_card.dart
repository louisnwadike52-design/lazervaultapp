import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferralStatsCard extends StatelessWidget {
  final int totalReferrals;
  final int totalRewardsEarned;
  final int pendingRewards;
  final String currency;

  const ReferralStatsCard({
    super.key,
    required this.totalReferrals,
    required this.totalRewardsEarned,
    required this.pendingRewards,
    required this.currency,
  });

  /// Delegates to the shared resolver.
  ///
  /// This was a local switch whose DEFAULT was a dollar sign, so any currency
  /// string it did not match EXACTLY — a lowercase code, a display name like
  /// 'Nigerian Naira', an empty value — rendered a naira amount as DOLLARS.
  /// CurrencyUtils normalises first and falls back to the CODE, so an
  /// unrecognised currency is labelled, never mislabelled as another one.
  String _getCurrencySymbol() => CurrencyUtils.getSymbol(currency);

  String _formatAmount(int amount) {
    final value = amount / 100;
    if (value >= 1000) {
      return '${_getCurrencySymbol()}${(value / 1000).toStringAsFixed(1)}k';
    }
    return '${_getCurrencySymbol()}${value.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Your Stats',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  value: totalReferrals.toString(),
                  label: 'Referrals',
                  icon: Icons.people_rounded,
                  color: const Color(0xFF10B981),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  value: _formatAmount(totalRewardsEarned),
                  label: 'Earned',
                  icon: Icons.account_balance_wallet_rounded,
                  color: const Color(0xFF4E03D0),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  value: _formatAmount(pendingRewards),
                  label: 'Pending',
                  icon: Icons.schedule_rounded,
                  color: const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
