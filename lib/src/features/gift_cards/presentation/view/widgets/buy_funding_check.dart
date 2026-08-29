import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../account_cards_summary/domain/entities/account_summary_entity.dart';

/// Why a gift card purchase cannot proceed from the amounts screen.
///
/// The buy saga holds EXACTLY the retail price it showed the user
/// (giftcard_buy_part2.go: "HOLD = exactly the retail we showed the user.
/// No buffer"), so the amount rendered on this screen is the amount that
/// will leave the wallet. That makes a client-side comparison exact rather
/// than an estimate, and lets the screen refuse before the transaction-PIN
/// sheet instead of failing after the user has typed their PIN.
enum GiftCardFundingStatus {
  /// Funded, or not knowable here — either way the CTA stays enabled and
  /// the backend remains the authority.
  ok,

  /// Available balance is provably below the charge.
  insufficient,

  /// The account exists but cannot spend (frozen / closed).
  unusable,
}

/// The outcome of the pre-PIN funding check.
class GiftCardFundingCheck {
  final GiftCardFundingStatus status;

  /// How much more the user needs, in [currency]. Zero unless [isInsufficient].
  final double shortfall;
  final double available;
  final String currency;
  final String? message;

  const GiftCardFundingCheck._({
    required this.status,
    this.shortfall = 0,
    this.available = 0,
    this.currency = '',
    this.message,
  });

  static const ok = GiftCardFundingCheck._(status: GiftCardFundingStatus.ok);

  bool get isInsufficient => status == GiftCardFundingStatus.insufficient;
  bool get isUnusable => status == GiftCardFundingStatus.unusable;
  bool get blocks => status != GiftCardFundingStatus.ok;

  /// Evaluates whether [chargeAmount] in [chargeCurrency] can be funded by
  /// [account].
  ///
  /// Deliberately fails OPEN. A null account, an unpriced card, or a charge
  /// quoted in a currency the account is not denominated in all return [ok]:
  /// with no like-for-like comparison there is no honest way to tell the user
  /// they are short, and blocking on a guess would strand a funded customer.
  /// Only a provable shortfall stops the flow.
  static GiftCardFundingCheck evaluate({
    required double? chargeAmount,
    required String chargeCurrency,
    required AccountSummaryEntity? account,
  }) {
    if (account == null) return ok;
    if (chargeAmount == null || chargeAmount <= 0) return ok;

    final charge = chargeCurrency.trim().toUpperCase();
    final wallet = account.currency.trim().toUpperCase();
    if (charge.isEmpty || wallet.isEmpty || charge != wallet) return ok;

    // Mirrors the accounts-service block: it rejects holds on frozen/suspended
    // accounts, so refusing here shows the same answer before the PIN rather
    // than after it.
    if (account.isFrozen) {
      return GiftCardFundingCheck._(
        status: GiftCardFundingStatus.unusable,
        currency: wallet,
        available: account.availableBalance,
        message: 'This account is ${account.status.toLowerCase()} and cannot '
            'be used to pay. Switch accounts on the dashboard to continue.',
      );
    }

    if (account.availableBalance < chargeAmount) {
      return GiftCardFundingCheck._(
        status: GiftCardFundingStatus.insufficient,
        shortfall: chargeAmount - account.availableBalance,
        available: account.availableBalance,
        currency: wallet,
      );
    }

    return ok;
  }
}

/// Inline notice shown on the amounts screen when the selected card cannot be
/// funded. Sits with the price summary rather than appearing as a dialog, so
/// the user can pick a cheaper denomination without dismissing anything.
class GiftCardFundingNotice extends StatelessWidget {
  final GiftCardFundingCheck check;

  const GiftCardFundingNotice({super.key, required this.check});

  String _money(double v) => v
      .toStringAsFixed(2)
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');

  @override
  Widget build(BuildContext context) {
    if (!check.blocks) return const SizedBox.shrink();

    final isShort = check.isInsufficient;
    final accent =
        isShort ? const Color(0xFFF59E0B) : const Color(0xFFEF4444);
    final title =
        isShort ? 'Not enough in your account' : 'Account unavailable';
    final body = isShort
        ? 'You need ${check.currency} ${_money(check.shortfall)} more. '
            'Available balance is ${check.currency} ${_money(check.available)}. '
            'Choose a smaller amount, or add funds from your dashboard and '
            'come back to finish this purchase.'
        : (check.message ?? 'This account cannot be used to pay.');

    return Container(
      key: const Key('giftcard_funding_notice'),
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accent.withValues(alpha: 0.32)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isShort
                ? Icons.account_balance_wallet_outlined
                : Icons.lock_outline,
            color: accent,
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    height: 1.5,
                    color: const Color(0xFFB6B9C6),
                  ),
                ),
                // No top-up CTA here by design. It navigated AWAY from a
                // half-completed purchase — the brand, denomination and
                // recipient the user had just entered — and deposits do not
                // land instantly, so they returned to an empty form with
                // nothing to show for it. The notice states the shortfall and
                // points at the dashboard; the purchase stays put.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
