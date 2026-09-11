import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'beam_style.dart';

/// What happened when the user came back from the bank authorization.
///
/// These are the states a NIBSS-activated Direct Debit can actually land in.
/// They were all a SNACKBAR before, which is the wrong container twice over:
/// it disappears while the user is still deciding, and it cannot carry the
/// question that matters — "did you already send the transfer?" The answer
/// changes what we do, and only the user knows it.
enum MandateOutcome {
  /// The sheet closed with no authorization. The user may have sent the NGN 50
  /// and simply not pressed "I've sent the money", or may not have sent it at
  /// all. We cannot tell, and the two need different help.
  unconfirmed,

  /// Authorization was granted; the bank is confirming. Nothing to do.
  confirming,

  /// The Mono link aged out (~30 min). A fresh one is being issued.
  linkExpired,

  /// Fully set up.
  active,
}

/// Persistent, actionable outcome sheet for Direct Debit setup.
///
/// Returns the user's choice: `true` when they say the transfer is already
/// sent (caller should poll and keep the mandate alive), `false` when they
/// want to resume the authorization now, and `null` when they dismiss.
Future<bool?> showMandateOutcomeSheet({
  required BuildContext context,
  required MandateOutcome outcome,
  required String bankName,
  VoidCallback? onResume,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    // A money step the user may have already paid for must not be dismissed by
    // a stray tap on the scrim — they would lose the one screen telling them
    // it is still in progress.
    isDismissible: outcome != MandateOutcome.unconfirmed,
    enableDrag: outcome != MandateOutcome.unconfirmed,
    builder: (ctx) => _MandateOutcomeSheet(
      outcome: outcome,
      bankName: bankName,
      onResume: onResume,
    ),
  );
}

class _MandateOutcomeSheet extends StatelessWidget {
  const _MandateOutcomeSheet({
    required this.outcome,
    required this.bankName,
    this.onResume,
  });

  final MandateOutcome outcome;
  final String bankName;
  final VoidCallback? onResume;

  ({IconData icon, Color tint, String title, String body}) get _copy {
    switch (outcome) {
      case MandateOutcome.unconfirmed:
        return (
          icon: Icons.account_balance_outlined,
          tint: const Color(0xFFF59E0B),
          title: 'Did you send the transfer?',
          // Names the exact amount and destination so the user can match it
          // against what they actually did, rather than guessing at what we
          // mean by "authorization".
          body: 'To finish Direct Debit, $bankName asks for a one-off ₦50 '
              'transfer from your own banking app.\n\nIf you already sent '
              'it, we will confirm it automatically — do NOT send it again.',
        );
      case MandateOutcome.confirming:
        return (
          icon: Icons.hourglass_top_rounded,
          tint: const Color(0xFF3B82F6),
          title: 'Confirming with $bankName',
          body: 'We received your authorization. $bankName is confirming it — '
              'this can take up to 30 minutes and completes on its own.\n\n'
              'You can keep using deposits with one-time approval in the '
              'meantime.',
        );
      case MandateOutcome.linkExpired:
        return (
          icon: Icons.refresh_rounded,
          tint: const Color(0xFF8B7CF6),
          title: 'That link expired',
          body: 'Bank authorization links stay valid for about 30 minutes. '
              'We have started a fresh one for you — nothing was charged.',
        );
      case MandateOutcome.active:
        return (
          icon: Icons.check_circle_outline_rounded,
          tint: const Color(0xFF10B981),
          title: 'Direct Debit is on',
          body: 'Future deposits from $bankName skip the bank login. You can '
              'switch back to one-time approval any time.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _copy;
    final isUnconfirmed = outcome == MandateOutcome.unconfirmed;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BeamStyle.card(radius: 24),
        margin: EdgeInsets.all(12.w),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        // Scrollable and height-capped. The body copy varies per state and
        // grows with the bank name, and on a short viewport the fixed column
        // overflowed — a yellow-black stripe across a money screen. Capping at
        // 85% leaves the scrim visible so the sheet still reads as a sheet.
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: BeamStyle.hairline,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: c.tint.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(c.icon, color: c.tint, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      c.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Text(
                c.body,
                style: GoogleFonts.inter(
                  color: BeamStyle.muted,
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
              if (isUnconfirmed) ...[
                // Primary is "already sent" on purpose: the user who paid is the
                // one at risk of paying twice, so their path must be the easiest
                // one to hit.
                _primary(
                  context,
                  label: 'Yes, I already sent it',
                  onTap: () => Navigator.of(context).pop(true),
                ),
                SizedBox(height: 10.h),
                _secondary(
                  context,
                  label: 'Not yet — take me back',
                  onTap: () {
                    Navigator.of(context).pop(false);
                    onResume?.call();
                  },
                ),
              ] else if (outcome == MandateOutcome.linkExpired) ...[
                _primary(
                  context,
                  label: 'Continue',
                  onTap: () => Navigator.of(context).pop(true),
                ),
              ] else ...[
                _primary(
                  context,
                  label: 'Got it',
                  onTap: () => Navigator.of(context).pop(true),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _primary(BuildContext context,
      {required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: BeamStyle.purple,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          label,
          style:
              GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _secondary(BuildContext context,
      {required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: const BorderSide(color: BeamStyle.hairline),
          ),
        ),
        child: Text(
          label,
          style:
              GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
