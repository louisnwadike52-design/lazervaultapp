import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_bonus_entities.dart';

/// What the user has earned from referrals, and where it went.
///
/// There is no action here on purpose. A bonus is deposited into the personal
/// wallet automatically when the referred person passes KYC, and the user gets
/// a push when it lands — so this card reports, and the only thing it ever has
/// to explain is the short window before the money arrives.
class ReferralBonusCard extends StatelessWidget {
  const ReferralBonusCard({super.key, required this.balance});

  final ReferralBonusBalanceEntity balance;

  String get _symbol => CurrencyUtils.getSymbol(balance.currency);

  String _money(int minor) =>
      '$_symbol${ReferralBonusBalanceEntity.majorOf(minor).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    // Nothing earned and nothing to say. A card reading "0.00" with a dead
    // button is worse than no card: it implies something went wrong.
    if (!balance.hasAnything && balance.programmeActive) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.savings_rounded,
                  size: 15.sp, color: const Color(0xFF10B981)),
              SizedBox(width: 6.w),
              Text(
                'Referral bonus',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _money(balance.lifetimeAccruedMinor),
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Earned from referrals',
            style: TextStyle(fontSize: 11.sp, color: const Color(0xFF6B7280)),
          ),

          // The only gap worth explaining: earned, not yet in the wallet.
          // Usually under a minute. If the user has no personal wallet in this
          // currency it stays here until they open one, and saying so is the
          // difference between "pending" and "nobody knows".
          if (balance.awaitingDeposit) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(
                  height: 11.sp,
                  width: 11.sp,
                  child: const CircularProgressIndicator(
                    strokeWidth: 1.6,
                    color: Color(0xFFF59E0B),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '${_money(balance.pendingWithdrawalMinor)} is on its way to your personal wallet',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 12.h),
          // Expanded on both: the labels and values are variable width
          // ("Personal wallet" is wider than an amount) and a fixed Row
          // overflowed by 30px at phone width, which clips the destination —
          // the one thing this row exists to say.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _stat(
                    'Paid to wallet', _money(balance.lifetimeWithdrawnMinor)),
              ),
              SizedBox(width: 12.w),
              Expanded(child: _stat('Paid into', 'Personal wallet')),
            ],
          ),

          // THE PROGRAMME HAS ENDED, BUT THE MONEY HAS NOT.
          //
          // Said plainly, and above the button rather than instead of it: a
          // balance accrued under the programme stays withdrawable, and a user
          // who reads "the programme has ended" next to a disabled button will
          // reasonably believe their earnings were taken.
          if (!balance.programmeActive) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 13.sp, color: const Color(0xFF9CA3AF)),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      balance.programmeNotice.isNotEmpty
                          ? balance.programmeNotice
                          : 'The referral programme has ended. New referrals are '
                              'no longer counted. Anything you already earned '
                              'is still yours and is still paid into your '
                              'personal wallet.',
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        height: 1.35,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 10.sp, color: const Color(0xFF6B7280))),
        SizedBox(height: 2.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFD1D5DB),
          ),
        ),
      ],
    );
  }
}
