import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/crypto_pay/domain/crypto_quote_preview.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_coverage_dialog.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// WHAT WILL BE SOLD, AT WHAT RATE, AND WHAT FINISHES THE JOB.
///
/// Shown on Continue, before the PIN pad, for every service that takes crypto.
/// It answers the three questions a customer has at that moment and could not
/// previously answer at all:
///
///   * what rate am I converting at?
///   * how much of my coin does that cost?
///   * will any of my naira be used, and how much?
///
/// ## Why it is shown even when the coin covers it
///
/// The earlier dialog appeared only when the coin was SHORT, so a customer
/// paying entirely from crypto — the ordinary case — went from Continue
/// straight to the PIN pad having never seen a rate. Selling an asset without
/// being shown its price is not something a customer should have to accept,
/// and it is not what any exchange does.
///
/// ## Why the figures carry a caveat
///
/// They are derived from a price snapshot. The binding rate comes from the
/// exchange when the conversion runs and WILL differ, in both directions.
/// Stating that beside the numbers is the standard for this product; burying
/// it, or omitting it and charging something else, is how a correct payment
/// still feels like a bait and switch.
Future<CoverageChoice> showCryptoConversionSheet(
  BuildContext context, {
  required CryptoQuotePreview preview,
  required CryptoCoverage coverage,
}) async {
  final short = coverage == CryptoCoverage.insufficient;
  // The wallet alone is enough. Said BEFORE the PIN, because under the
  // `shortfall` fund mode the server refuses this after it — which is how a
  // customer came to see "Transfer Failed" on a transfer that had neither
  // failed nor charged them.
  final walletCovers = coverage == CryptoCoverage.walletAlreadyCovers;
  final result = await showAppBottomSheet<CoverageChoice>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // A DELIBERATE DECISION, so it does not close by accident. Tapping outside
    // would read as "no" on a screen whose whole purpose is an explicit yes,
    // and the customer has already pressed Continue once.
    isDismissible: false,
    enableDrag: false,
    builder: (ctx) => _ConversionSheet(
        preview: preview, short: short, walletCovers: walletCovers),
  );
  // A sheet closed by the system back gesture is a cancellation, never a yes.
  return result ?? CoverageChoice.cancel;
}

const _brand = Color.fromARGB(255, 78, 3, 208);
const _ink = Color(0xFF111827);
const _muted = Color(0xFF6B7280);
const _faint = Color(0xFF9CA3AF);
const _danger = Color(0xFFD92D20);

String _naira(int minor) {
  final major = (minor / 100).toStringAsFixed(2);
  return '₦${major.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+\.)'),
    (m) => '${m[1]},',
  )}';
}

class _ConversionSheet extends StatelessWidget {
  const _ConversionSheet({
    required this.preview,
    required this.short,
    this.walletCovers = false,
  });

  final CryptoQuotePreview preview;
  final bool short;

  /// The wallet alone already covers the payment. Not a failure and not a
  /// blocker — an informed choice, because converting is optional here.
  final bool walletCovers;

  @override
  Widget build(BuildContext context) {
    final coin = preview.label;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  short
                      ? Icons.error_outline_rounded
                      : walletCovers
                          ? Icons.account_balance_wallet_outlined
                          : Icons.swap_horiz_rounded,
                  size: 20.sp,
                  // Not danger red: nothing is wrong. A red sheet here reads
                  // as a failure, which is the exact misreading this fixes.
                  color: short ? _danger : _brand,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    short
                        ? '$coin is not enough'
                        : walletCovers
                            ? 'Your wallet already covers this'
                            : 'Paying with $coin',
                    style: GoogleFonts.inter(
                      fontSize: 16.5.sp,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // THE RATE, FIRST. It is the number the customer came here for.
            if (preview.unitPriceMinor != null)
              _Row(
                label: 'Rate',
                value: '1 $coin ≈ ${_naira(preview.unitPriceMinor!.round())}',
              ),
            if (preview.sellQuantity != null && !short)
              _Row(
                label: 'You sell',
                value: '≈ ${preview.sellQuantity} $coin',
              ),

            Divider(height: 20.h, color: const Color(0xFFF3F4F6)),

            // THE SPLIT. Both legs are named when both are used, so "primary"
            // and "secondary" on the receipt afterwards are not a surprise.
            _Row(
              label: preview.isSplit ? 'From $coin' : 'Paying',
              value: _naira(preview.fromCryptoMinor),
              strong: !preview.isSplit,
            ),
            if (preview.isSplit)
              _Row(
                label: 'From your wallet',
                value: _naira(preview.fromWalletMinor),
              ),
            if (preview.isSplit) SizedBox(height: 2.h),
            _Row(
              label: 'Total',
              value: _naira(preview.amountMinor),
              strong: true,
            ),

            SizedBox(height: 12.h),
            if (walletCovers)
              Text(
                'Your wallet has enough for this payment on its own, so you '
                'do not have to sell any $coin. Continue to pay with $coin '
                'anyway, or go back to pay from your wallet.',
                style: GoogleFonts.inter(
                    fontSize: 12.5.sp, height: 1.45, color: _muted),
              )
            else if (short)
              Text(
                'Your $coin is worth about ${_naira(preview.coinValueMinor)} '
                'and your wallet cannot cover the remaining '
                '${_naira(preview.amountMinor - preview.fromCryptoMinor)}. '
                'Pick a coin with more in it, or go back and change the '
                'amount.',
                style: GoogleFonts.inter(
                    fontSize: 12.5.sp, height: 1.45, color: _muted),
              )
            else if (preview.isSplit)
              Text(
                'Your $coin does not cover all of this, so the remaining '
                '${_naira(preview.fromWalletMinor)} comes from your wallet '
                'when the payment runs.',
                style: GoogleFonts.inter(
                    fontSize: 12.5.sp, height: 1.45, color: _muted),
              ),

            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, size: 13.sp, color: _faint),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    // THE CAVEAT, BESIDE THE NUMBERS. Crypto prices move
                    // between this screen and the conversion; the exchange
                    // sets the binding rate. Said plainly rather than in
                    // small print nobody reads.
                    preview.stale
                        ? 'We could not refresh the price just now, so this '
                            'rate may be out of date. The final amounts are '
                            'set by the exchange when the payment runs.'
                        : 'This rate is indicative. Crypto prices move, so '
                            'the final amount of $coin sold is set by the '
                            'exchange when the payment runs.',
                    style: GoogleFonts.inter(
                        fontSize: 11.sp, height: 1.4, color: _faint),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(CoverageChoice.pickAnother),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      side: const BorderSide(color: Color(0xFFD1D5DB)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Change coin',
                        style: GoogleFonts.inter(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w600,
                            color: _ink)),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  // NO "CONTINUE" WHEN THERE IS NOTHING TO CONTINUE TO.
                  //
                  // When neither the coin nor the wallet covers it, the
                  // payment cannot run. Offering a confirm button would be a
                  // refusal with extra steps — and a tap that spends a PIN
                  // attempt to learn what this sheet already said.
                  child: short
                      ? OutlinedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(CoverageChoice.cancel),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 13.h),
                            side: const BorderSide(color: Color(0xFFD1D5DB)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                          child: Text('Go back',
                              style: GoogleFonts.inter(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _ink)),
                        )
                      : ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(CoverageChoice.proceed),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _brand,
                            padding: EdgeInsets.symmetric(vertical: 13.h),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                          child: Text('Confirm',
                              style: GoogleFonts.inter(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(CoverageChoice.cancel),
                child: Text('Cancel',
                    style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w500,
                        color: _muted)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.strong = false});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.inter(fontSize: 12.5.sp, color: _muted)),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                fontSize: strong ? 14.sp : 13.sp,
                fontWeight: strong ? FontWeight.w700 : FontWeight.w600,
                color: _ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
