import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_bonus_entities.dart';

/// Accrued referral bonus, and the one action that can be taken on it.
///
/// The bonus used to be transferred into the wallet at the moment a referral
/// completed, so the referral screen had nothing to show and nothing to do —
/// the money appeared in the wallet with a narration and that was the whole
/// experience. It now accrues here and the user withdraws it deliberately.
class ReferralBonusCard extends StatelessWidget {
  const ReferralBonusCard({
    super.key,
    required this.balance,
    required this.onWithdraw,
  });

  final ReferralBonusBalanceEntity balance;
  final VoidCallback onWithdraw;

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

    final blocked = balance.blockedReason;
    final canWithdraw = balance.canWithdraw;

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
            _money(balance.availableMinor),
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Available to withdraw',
            style: TextStyle(fontSize: 11.sp, color: const Color(0xFF6B7280)),
          ),

          // In-flight money has to be visible, or a retrying transfer looks
          // like a balance that quietly shrank.
          if (balance.pendingWithdrawalMinor > 0) ...[
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
                    '${_money(balance.pendingWithdrawalMinor)} is being sent to your wallet',
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
          Row(
            children: [
              _stat('Earned', _money(balance.lifetimeAccruedMinor)),
              SizedBox(width: 16.w),
              _stat('Withdrawn', _money(balance.lifetimeWithdrawnMinor)),
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
                              'no longer counted, and anything you already '
                              'earned is still yours to withdraw.',
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

          if (balance.availableMinor > 0) ...[
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: canWithdraw ? onWithdraw : null,
                icon: Icon(Icons.account_balance_wallet_rounded, size: 16.sp),
                label: Text(
                  canWithdraw
                      ? 'Withdraw to personal wallet'
                      : (blocked ?? 'Unavailable'),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  disabledBackgroundColor: const Color(0xFF2D2D2D),
                  disabledForegroundColor: const Color(0xFF6B7280),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
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
