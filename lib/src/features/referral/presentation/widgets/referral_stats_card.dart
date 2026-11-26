import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/referral/domain/referral_programme_copy.dart';

class ReferralStatsCard extends StatelessWidget {
  final int totalReferrals;
  final int totalRewardsEarned;
  final int pendingRewards;
  final String currency;

  /// What this screen is allowed to say about earning. Resolved once by the
  /// dashboard from the programme state, so every card on the page agrees.
  final ReferralProgrammeCopy copy;

  const ReferralStatsCard({
    super.key,
    required this.totalReferrals,
    required this.totalRewardsEarned,
    required this.pendingRewards,
    required this.currency,
    required this.copy,
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
                  label: 'Paid out',
                  icon: Icons.account_balance_wallet_rounded,
                  color: const Color(0xFF4E03D0),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  value: _formatAmount(pendingRewards),
                  label: 'On KYC',
                  icon: Icons.schedule_rounded,
                  color: const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // WHAT THESE NUMBERS MEAN.
          //
          // "Earned" and "Pending" read as though both are money owed and one
          // is still being processed by us. Neither was true: the first is
          // already in the wallet, and the second is waiting on somebody
          // else's KYC, not on us. A referrer with six unverified signups and
          // NGN 1,200 under "Pending" reasonably concluded the payout was
          // stuck — it was never due.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 13.sp, color: const Color(0xFF6B7280)),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    // NOT COMPILED TEXT. Both sentences promised money, and
                    // the programme has two states in which no money is
                    // coming — rewards paused, or closed to new referrals.
                    // ReferralProgrammeCopy resolves which, and every word
                    // of it is editable from the console.
                    copy.earns
                        ? (pendingRewards > 0 ? copy.pendingBody : copy.body)
                        : copy.body,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
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
