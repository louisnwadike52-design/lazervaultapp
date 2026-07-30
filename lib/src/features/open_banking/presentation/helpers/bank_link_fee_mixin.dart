import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
