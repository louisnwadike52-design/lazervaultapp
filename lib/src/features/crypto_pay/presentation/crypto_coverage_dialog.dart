import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';

/// WHAT THE CHOSEN COIN ACTUALLY COVERS, SAID BEFORE THE CUSTOMER COMMITS.
///
/// Selling crypto is irreversible — the sub→master transfer at confirm is the
/// point of no return — so "your coin was not enough" is the worst possible
/// thing to learn afterwards. The server refuses that case correctly, but a
/// refusal arriving after the PIN is a dead end the customer cannot act on
/// from where they are standing.
///
/// This asks the question while it is still cheap, and the two answers are
/// deliberately different shapes:
///
///   * PART-COVERED, wallet can finish it — not a problem, a fact. The
///     customer is told the split and asked to confirm it, with a way to pick
///     a bigger coin if they would rather not touch their naira.
///   * NEITHER COVERS IT — there is nothing to confirm, so there is no
///     "continue". The only honest options are a different coin or going back.
///
/// INDICATIVE, AND IT SAYS SO. These figures are a ticker snapshot taken when
/// the picker loaded; the binding numbers come from the exchange at quote
/// time. The copy avoids promising an exact split for that reason, and the
/// server re-checks everything regardless — this is guidance, never a gate.
enum CryptoCoverage {
  /// The coin is worth at least the payment. Nothing to ask.
  covers,

  /// The coin covers part and the wallet can find the rest.
  partial,

  /// The two together fall short.
  insufficient,

  /// The coin could not be priced, so no claim can be made either way.
  unknown,

  /// THE PAYMENT IS TOO SMALL TO CONVERT FOR.
  ///
  /// A sell has a floor, and below it there is nothing to decide: the coin's
  /// value, the wallet balance and the split are all irrelevant because no
  /// conversion can happen at all. The server already refuses this with
  /// `below_minimum` — but only once the customer has chosen a coin, read a
  /// split and entered their PIN, and a refusal earned that way reads as a
  /// failed payment rather than a rule.
  ///
  /// Reported from a ₦223 transfer: the sheet offered Confirm on 0.1549 USDT
  /// and the exchange would have refused it. Measured on prod the same week,
  /// a ₦1,000 attempt failed at the venue with "The minimum swap amount is
  /// 1253.19... NGN" — no money moved, but the customer had already
  /// committed.
  belowMinimum,

  /// THE WALLET ALONE ALREADY COVERS THE PAYMENT.
  ///
  /// Not a problem, and emphatically not a failure — but the customer must be
  /// told BEFORE their PIN, because what happens next depends on a server
  /// setting they cannot see:
  ///
  ///   * `shortfall` converts only what the wallet is missing, so there is
  ///     nothing to convert and the server REFUSES after the PIN. A real
  ///     customer hit exactly that: "Transfer Failed — your wallet already
  ///     covers this payment", on a transfer that had not failed and had not
  ///     charged them.
  ///   * `crypto_first` sells the coin anyway, which is what the button says
  ///     — but spending crypto when the wallet could have paid is a decision
  ///     worth making knowingly.
  ///
  /// Either way the honest move is the same: say so, and let them choose.
  /// That is why this is surfaced as a CHOICE rather than branched on the
  /// mode — the client does not need to know the policy to ask the question,
  /// and a copy of the policy here would be one more thing to drift.
  walletAlreadyCovers,
}

/// Decides what to say, given what the picker last saw.
///
/// PURE, so every branch is testable without a widget. `coinValueMinor` of
/// null means unpriceable — which must read as [CryptoCoverage.unknown] and
/// let the payment through, because the server makes the real decision and
/// refusing here would decline a payment that would have worked.
CryptoCoverage assessCoverage({
  required int amountMinor,
  required int? coinValueMinor,
  required int? walletMinor,
  int minFiatMinor = 0,
}) {
  if (amountMinor <= 0) return CryptoCoverage.unknown;
  // FIRST, because it settles the question on its own. Below the floor there
  // is no conversion to describe, so a split, a rate or a coverage verdict
  // would all be answering a question that cannot arise.
  //
  // Compared against the PAYMENT TOTAL, matching the server's own check
  // (`requiredMinor < cfg.MinFiatMinor`) rather than against the shortfall —
  // a client that refused on a different rule than the server would decline
  // payments the server would have taken.
  if (minFiatMinor > 0 && amountMinor < minFiatMinor) {
    return CryptoCoverage.belowMinimum;
  }
  if (coinValueMinor == null || coinValueMinor <= 0) {
    return CryptoCoverage.unknown;
  }
  // CHECKED BEFORE the coin's own coverage, deliberately. When the wallet
  // alone is enough, that is the fact the customer needs first — it is the
  // one that decides whether converting is necessary at all, and under
  // `shortfall` it is the one the server will refuse on.
  //
  // A wallet we could not read (null) is NOT a wallet that covers it: the
  // benefit of the doubt goes to the payment proceeding, exactly as below.
  if (walletMinor != null && walletMinor >= amountMinor) {
    return CryptoCoverage.walletAlreadyCovers;
  }
  if (coinValueMinor >= amountMinor) return CryptoCoverage.covers;
  final remainder = amountMinor - coinValueMinor;
  // A wallet we could not read is NOT a wallet with nothing in it. Treating
  // an unknown balance as zero would refuse a payment that may be perfectly
  // fundable, so the benefit of the doubt goes to the customer and the server
  // settles it.
  if (walletMinor == null || walletMinor >= remainder) {
    return CryptoCoverage.partial;
  }
  return CryptoCoverage.insufficient;
}

/// What the customer chose to do about it.
enum CoverageChoice {
  /// Go ahead on the stated split.
  proceed,

  /// Open the coin picker again.
  pickAnother,

  /// Back out and change the amount.
  cancel,
}

String _naira(int minor) {
  final major = (minor / 100).toStringAsFixed(2);
  return '₦${major.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+\.)'),
    (m) => '${m[1]},',
  )}';
}

/// Shows the right dialog for [coverage], or returns [CoverageChoice.proceed]
/// immediately when there is nothing worth asking.
Future<CoverageChoice> showCryptoCoverageDialog(
  BuildContext context, {
  required CryptoCoverage coverage,
  required PaySource source,
  required int amountMinor,
  required int? walletMinor,
}) async {
  // Nothing to say: the coin covers it, or we cannot claim otherwise.
  if (coverage == CryptoCoverage.covers || coverage == CryptoCoverage.unknown) {
    return CoverageChoice.proceed;
  }

  const brand = Color.fromARGB(255, 78, 3, 208);
  final coin = source.label;
  final coinValue = source.assetFiatValueMinor ?? 0;
  final remainder = amountMinor - coinValue;
  final short = coverage == CryptoCoverage.insufficient;

  final result = await showDialog<CoverageChoice>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  short
                      ? Icons.error_outline_rounded
                      : Icons.info_outline_rounded,
                  size: 20.sp,
                  color: short ? const Color(0xFFD92D20) : brand,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    short ? '$coin is not enough' : '$coin covers part of this',
                    style: GoogleFonts.inter(
                        fontSize: 16.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              short
                  ? 'Your $coin is worth about ${_naira(coinValue)} and your '
                      'wallet cannot cover the remaining ${_naira(remainder)}. '
                      'Pick a coin with more in it, or go back and change the '
                      'amount.'
                  : 'Your $coin is worth about ${_naira(coinValue)} of this '
                      '${_naira(amountMinor)} payment. The remaining '
                      '${_naira(remainder)} will come from your wallet when '
                      'the payment runs.',
              style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  height: 1.45,
                  color: const Color(0xFF4B5563)),
            ),
            SizedBox(height: 8.h),
            // SAYS THAT THE FIGURES MOVE. The price is a snapshot and the
            // exchange sets the real one; promising an exact split and then
            // charging a different one is how a correct payment still feels
            // like a bait and switch.
            Text(
              'Crypto prices move, so the exact amounts are settled when the '
              'payment runs.',
              style: GoogleFonts.inter(
                  fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(ctx).pop(CoverageChoice.pickAnother),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: brand.withValues(alpha: 0.4)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Use another coin',
                        style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: brand)),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: short
                      // NO "CONTINUE" WHEN IT CANNOT WORK. Offering it would
                      // be offering a button whose only outcome is a refusal.
                      ? TextButton(
                          onPressed: () =>
                              Navigator.of(ctx).pop(CoverageChoice.cancel),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text('Go back',
                              style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6B7280))),
                        )
                      : ElevatedButton(
                          onPressed: () =>
                              Navigator.of(ctx).pop(CoverageChoice.proceed),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: brand,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                          child: Text('Continue',
                              style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  // A DISMISSED DIALOG IS NOT CONSENT. Tapping outside must not start a
  // conversion the customer never agreed to.
  return result ?? CoverageChoice.cancel;
}
