import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/deposit.dart';

/// Format a minor-unit (kobo) amount as a naira string with thousands separators,
/// e.g. 159125 -> "₦1,591.25".
String _formatKobo(int minor) {
  final naira = minor / 100.0;
  final parts = naira.toStringAsFixed(2).split('.');
  final whole = parts[0];
  final buf = StringBuffer();
  for (int i = 0; i < whole.length; i++) {
    if (i > 0 && (whole.length - i) % 3 == 0) buf.write(',');
    buf.write(whole[i]);
  }
  return '₦$buf.${parts[1]}';
}

/// Connection-fee notice shared by EVERY Mono Connect bank-link entry point (the
/// dedicated Link Bank screen plus the inline deposit/move/withdraw/direct-debit/
/// statistics sheets) so none of them re-implements it.
///
/// Linking uses Mono Connect, which carries a provider charge. Because we're on a
/// Mono subscription plan we do NOT surface a per-link naira amount (it isn't a
/// clean per-user pass-through); instead we show a generic notice that a
/// connection fee applies and let the user acknowledge before linking. The actual
/// charge — admin-tunable, default 0, split at settlement into the Mono cost
/// (MONO_COST) and LazerVault margin (REVENUE) — is applied server-side on a
/// genuinely new link, balance-checked, and unlinked on failure.

/// Show the connection-fee notice. Returns true if the user chose to continue.
Future<bool> showBankConnectionFeeNotice(BuildContext context) async {
  final res = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(Icons.account_balance_rounded,
              color: const Color(0xFF3B82F6), size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            'Connection fee',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      content: Text(
        'A transaction fee applies when you connect a bank account. Do you want to continue?',
        style: GoogleFonts.inter(
          color: const Color(0xFF9CA3AF),
          fontSize: 13.sp,
          height: 1.4,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            'Not now',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(
            'Continue',
            style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6),
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
  return res == true;
}

/// Consolidated fee-disclosure sheet for the deposit-link flow. Shows the ACTUAL
/// amounts, broken into the one-time bank-connection fee (only for a first-time
/// link) and the per-deposit fee for the chosen rail (Direct Debit vs one-time),
/// then the total and the net the user will receive. Returns true if the user
/// agrees. Callers should ONLY show this when [quote.isFree] is false — a
/// zero-fee quote needs no consent sheet.
Future<bool> showDepositFeeAgreementSheet(
  BuildContext context,
  DepositFeeQuote quote,
) async {
  const cardBg = Color(0xFF1F1F1F);
  const divider = Color(0xFF2D2D2D);
  const textSecondary = Color(0xFF9CA3AF);
  const primary = Color(0xFF3B82F6);

  Widget feeRow(String label, String sub, int minor) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  if (sub.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(sub,
                        style: GoogleFonts.inter(
                            color: textSecondary, fontSize: 11.sp)),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(_formatKobo(minor),
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      );

  final railLabel =
      quote.rail == 'direct_debit' ? 'Direct Debit' : 'One-time payment';

  final res = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: cardBg,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: divider, borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.receipt_long_rounded, color: primary, size: 20.sp),
              SizedBox(width: 8.w),
              Text('Review fees',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 4.h),
          Text('Here\'s what applies before we continue.',
              style:
                  GoogleFonts.inter(color: textSecondary, fontSize: 12.sp)),
          SizedBox(height: 12.h),
          // Connection fee — only for a first-time link.
          if (!quote.connectFee.isFree)
            feeRow('Bank connection', 'One-time, charged from your wallet',
                quote.connectFee.total),
          // Per-deposit fee for the chosen rail.
          if (!quote.depositFee.isFree)
            feeRow('Deposit fee', '$railLabel · deducted from this deposit',
                quote.depositFee.total),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(color: divider, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total fees',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700)),
              Text(_formatKobo(quote.grandTotal),
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          if (quote.netAmount > 0) ...[
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('You\'ll receive',
                    style:
                        GoogleFonts.inter(color: textSecondary, fontSize: 12.sp)),
                Text(_formatKobo(quote.netAmount),
                    style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: const BorderSide(color: divider),
                    ),
                  ),
                  child: Text('Not now',
                      style: GoogleFonts.inter(
                          color: textSecondary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  style: TextButton.styleFrom(
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text('Agree & continue',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  return res == true;
}

/// Notice-gated link usable from ANY widget (stateful or stateless): show the
/// connection-fee notice, and on confirm run [doLink] with a fresh transaction id
/// (for idempotency) and a null verification token — no exact fee or txPIN is
/// shown; the notice is the consent. Each caller keeps its own link params
/// (auto-mandate, set-as-default) inside [doLink].
Future<void> linkBankWithConnectionNotice({
  required BuildContext context,
  required Future<void> Function(String? verificationToken, String? transactionId) doLink,
}) async {
  final proceed = await showBankConnectionFeeNotice(context);
  if (!proceed || !context.mounted) return;
  final txnId = 'link-${DateTime.now().millisecondsSinceEpoch}';
  await doLink(null, txnId);
}

/// Convenience mixin for State classes — delegates to [linkBankWithConnectionNotice].
mixin BankLinkFeeMixin<T extends StatefulWidget> on State<T> {
  Future<void> linkBankWithFee({
    required BuildContext context,
    required Future<void> Function(String? verificationToken, String? transactionId) doLink,
  }) =>
      linkBankWithConnectionNotice(context: context, doLink: doLink);
}
