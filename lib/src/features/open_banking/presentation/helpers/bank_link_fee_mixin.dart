import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

import '../../domain/entities/deposit.dart';
import 'bank_link_kyc_gate.dart';

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
///
/// This is the UNIVERSAL chokepoint every bank-link flow passes through before
/// linking (deposit, withdrawal, financial-analytics/statistics, LazerBeam,
/// autosave, the Link Bank screen). So the virtual-account gate runs HERE, FIRST,
/// exactly like the deposit flow: the single check is "does a NGN account number
/// exist?" — if not, the blocking "Setting up your account" modal mints it (BVN
/// KYC path) or routes to verification, and the fee notice is only shown once the
/// account is ready. This guarantees every reference to linking a bank gets the
/// VA modal first, regardless of which entry point called us.

/// Runs [task] behind a small blocking progress dialog so a CTA never looks
/// dead while an API call is in flight. Always dismisses the dialog, even if
/// [task] throws, and rethrows so callers keep their error handling.
///
/// Deliberately barrier-dismissible=false: the work continues regardless, and
/// letting the user tap through would leave them on a stale screen wondering
/// whether their tap registered.
Future<T> runWithLinkProgress<T>(
  BuildContext context,
  String message,
  Future<T> Function() task,
) async {
  if (!context.mounted) return task();
  final navigator = Navigator.of(context, rootNavigator: true);
  var dialogShown = false;
  unawaited(showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (_) {
      dialogShown = true;
      return PopScope(
        canPop: false,
        child: Center(
          // MATERIAL IS REQUIRED. showDialog does not insert one — only the
          // stock Dialog/AlertDialog widgets do — and a Text with no Material
          // ancestor renders in Flutter's fallback debug style: yellow, double
          // underlined. That is what shipped, and it read as a broken overlay
          // rather than a loader. Transparency keeps the pill's own colour.
          child: Material(
            type: MaterialType.transparency,
            child: ConstrainedBox(
              // Without a bound the pill grows with the string until it is
              // clipped by the screen. Cap it so a longer message wraps to a
              // second line instead of running off the edge.
              constraints: BoxConstraints(maxWidth: 0.72.sw),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LazerVaultLoader(size: 20),
                    SizedBox(width: 14.w),
                    Flexible(
                      child: Text(
                        message,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.5.sp,
                          height: 1.3,
                          // Spelled out rather than inherited: this sits in a
                          // bare overlay, so anything left to the ambient
                          // theme is what regressed here in the first place.
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  ));
  try {
    return await task();
  } finally {
    // Let the dialog's first frame land before popping it, otherwise a fast
    // task can try to dismiss a route that hasn't been pushed yet.
    if (!dialogShown) await Future<void>.delayed(const Duration(milliseconds: 16));
    if (navigator.canPop()) navigator.pop();
  }
}

Future<bool> showBankConnectionFeeNotice(BuildContext context) async {
  // The virtual-account gate below does a SECURE-STORAGE read plus a full
  // account-summaries round-trip before anything is painted. Every one of the
  // seven link entry points therefore had a silent tap → network → dialog gap
  // (worst on deposit, which stacks a fee-quote call on top and whose button
  // structurally can't spin). One barrier here covers all of them: the user
  // always sees that something is happening. Fixing it at the chokepoint
  // rather than in seven call sites keeps the behaviour identical everywhere.
  final gateOk = await runWithLinkProgress(
    context,
    'Checking your account…',
    () => ensureVirtualAccountForLink(context),
  );
  if (!gateOk) return false;
  if (!context.mounted) return false;
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
          // Connection fee — only for a first-time link. Rows show the
          // UNDISCOUNTED amount (total + discount) so together with the green
          // discount row they sum exactly to "Total fees" below.
          if (quote.connectFee.total + quote.connectFee.discount > 0)
            feeRow('Bank connection', 'One-time, charged from your wallet',
                quote.connectFee.total + quote.connectFee.discount),
          // Per-deposit fee for the chosen rail.
          if (quote.depositFee.total + quote.depositFee.discount > 0)
            feeRow('Deposit fee', '$railLabel · deducted from this deposit',
                quote.depositFee.total + quote.depositFee.discount),
          // Platform-funded discount already subtracted from the totals above —
          // shown as its own green "you save" row when a promo is running.
          if (quote.discountTotal > 0)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount applied',
                      style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600)),
                  Text('−${_formatKobo(quote.discountTotal)}',
                      style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
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
  // The virtual-account gate + fee notice both live inside
  // showBankConnectionFeeNotice now (the universal chokepoint), so callers get
  // the VA "Setting up your account" modal first, then the fee notice.
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
