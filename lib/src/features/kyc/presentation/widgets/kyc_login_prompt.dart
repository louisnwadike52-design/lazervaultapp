import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';

/// THE ONCE-PER-LOGIN NUDGE TO VERIFY.
///
/// This is the soft half of the identity-verification pair. With the admin
/// setting `kyc_required_on_signup` ON, an unverified account never reaches the
/// dashboard — the post-login router sends it into verification instead. With
/// it OFF, the dashboard is theirs and this asks, once, and takes no for an
/// answer.
///
/// Both halves read the same [KycLoginGate], which is why they can never both
/// fire: [KycLoginGate.shouldPromptOnDashboard] is false whenever the hard gate
/// blocks, so there is no path to a dialog over a screen the user cannot leave.
///
/// ## Once per login, not once per launch, and not once ever
///
/// The session key is what makes "on every login" true without making it
/// unbearable. Showing it on every dashboard BUILD would fire on every tab
/// change and every return from a sub-screen. Showing it only once per install
/// would mean a user who skipped on day one is never asked again, which is the
/// opposite of what was asked for. So: once per authenticated session, reset at
/// login — come back tomorrow and it asks again.
///
/// ## What it actually says
///
/// The specific thing people need to know, which the generic "verify your
/// identity" copy never told them: the account details they can give someone to
/// pay them into DO NOT EXIST until this is done. A user who skips without
/// understanding that goes looking for their account number, finds nothing, and
/// concludes the app is broken.
class KycLoginPrompt {
  KycLoginPrompt._();

  /// Set when the prompt has been shown (or deliberately suppressed) for the
  /// current session. Cleared by [resetForNewSession] at login.
  ///
  /// Deliberately in memory rather than storage: "this session" is exactly what
  /// a field on a static is, and persisting it would turn a skip into a
  /// permanent one the next time someone forgot to clear it.
  static bool _shownThisSession = false;

  /// Call at the start of an authenticated session so the next dashboard asks
  /// again. A user who skipped yesterday is asked today; that is the point.
  static void resetForNewSession() => _shownThisSession = false;

  /// Show the prompt if this holder needs it and has not been asked this
  /// session. Returns true when a dialog was actually shown, so the caller can
  /// avoid stacking a second modal on top of it.
  ///
  /// Never throws: a prompt must not be able to break the dashboard.
  static Future<bool> maybeShow(
    BuildContext context, {
    required KycLoginGate gate,
  }) async {
    if (_shownThisSession) return false;
    if (!gate.shouldPromptOnDashboard) return false;
    if (!context.mounted) return false;

    // Marked BEFORE awaiting. Two dashboard rebuilds racing to the await would
    // otherwise both pass the check and stack two identical dialogs.
    _shownThisSession = true;

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.6),
        builder: (ctx) => _KycPromptDialog(rejected: gate.state == KycState.rejected),
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

class _KycPromptDialog extends StatelessWidget {
  const _KycPromptDialog({required this.rejected});

  /// A previous attempt came back rejected. Says so, because "complete your
  /// verification" to someone who already did invites them to repeat whatever
  /// failed, unchanged.
  final bool rejected;

  static const Color _brand = Color(0xFF4E03D0);
  static const Color _card = Color(0xFF1B1626);
  static const Color _accent = Color(0xFFFB923C);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _accent.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _accent.withValues(alpha: 0.16),
              ),
              child: Icon(
                rejected ? Icons.gpp_maybe_rounded : Icons.verified_user_outlined,
                color: _accent,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              rejected
                  ? 'Your verification needs another look'
                  : 'Finish setting up your account',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              rejected
                  ? "We couldn't verify your identity from what was submitted. "
                      'Going through it again takes a couple of minutes.'
                  : 'Verifying your identity upgrades your account and raises '
                      'your limits. It takes a couple of minutes.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 12.5.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 14.h),

            // THE PART PEOPLE ACTUALLY NEED TO KNOW.
            //
            // Without this, someone skips, later goes looking for the account
            // number to give a friend, finds none, and reasonably concludes the
            // app is broken. Naming the consequence up front is what makes
            // "Skip for now" an informed choice rather than a trap.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_balance_outlined,
                      color: _accent, size: 15.sp),
                  SizedBox(width: 9.w),
                  Expanded(
                    child: Text(
                      'Until this is done you will not have account details to '
                      'receive money into, and deposits by transfer, card or a '
                      'linked bank stay unavailable.',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.62),
                        fontSize: 11.5.sp,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'You can still send money to other Lazervault users, buy airtime '
              'and data, and pay for everyday services.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 18.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Settings, as asked — not straight into the form. The
                  // KYCSettingsTile lives on this screen alongside the rest of
                  // the account, so someone who arrives via this prompt lands
                  // somewhere they can find again on their own.
                  Get.toNamed(AppRoutes.profileSettings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _brand,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Go to Settings',
                  style: GoogleFonts.inter(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white.withValues(alpha: 0.7),
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                ),
                child: Text(
                  'Skip for now',
                  style: GoogleFonts.inter(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
