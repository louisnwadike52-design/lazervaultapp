import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/dismiss_keyboard.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

/// THE WAY OUT OF A GATE THAT CANNOT OTHERWISE BE LEFT.
///
/// Identity verification is compulsory below Tier 2 — the screen offers no skip
/// until a BVN is inserted, which is correct and deliberate. But when that
/// screen is also the NAVIGATION ROOT, reached by an `offAllNamed` from signup
/// or from the post-login router, the combination leaves no exit at all:
///
///   * no skip, because the holder is below Tier 2;
///   * a back arrow that pops an empty stack;
///   * and, until this existed, no sign-out anywhere on the screen.
///
/// Anyone who cannot complete verification on that device — no BVN to hand, a
/// shared handset, the wrong person entirely, a provider outage — was stuck
/// there with the app unusable and no way to reach even the login screen. The
/// gate was doing its job; the absence of an exit was not part of the job.
///
/// It became much more reachable when `kyc_required_on_signup` started routing
/// EVERY unverified login into verification rather than only a fresh signup,
/// which is what prompted writing this.
///
/// ## Not a bypass
///
/// Signing out does not advance verification, clear the requirement, or reach
/// the dashboard. It ends the session and returns to login, so a different
/// person can use their own account — the same escape
/// `SignupSwitchAccountCta` gives a resumed signup, for the same reason.
///
/// ## Shown only when genuinely trapped
///
/// Gated by the caller on "this screen is the root AND there is no skip". With
/// a skip available, or a stack to pop back to, there is already a way out and
/// a sign-out button would just be an invitation to lose your session.
class KycGateExitCta extends StatelessWidget {
  const KycGateExitCta({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
      child: Center(
        child: TextButton(
          onPressed: () => _confirm(context),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.white.withValues(alpha: 0.65),
              ),
              children: [
                const TextSpan(text: 'Not you?  '),
                TextSpan(
                  text: 'Sign in as someone else',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    // Captured before the await: the dialog's own context dies with it, and the
    // cubit must not be read across the gap.
    final authCubit = context.read<AuthenticationCubit>();

    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign out?'),
        content: Text(
          'Verifying your identity is required before you can use this '
          'account. Signing out takes you back to the login screen so a '
          'different account can be used.\n\n'
          'Nothing is lost — you can sign back in and finish verifying '
          'whenever you are ready.',
          style: TextStyle(fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep verifying'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (leave != true) return;

    authCubit.logout();
    // The route that owns any focused field is about to be disposed, and a
    // sheet or dialog would be left floating above the new stack. Both have to
    // go before the teardown rather than be left to a widget that is about to
    // stop existing — same reason the drawer and the inactivity watcher do it.
    dismissTransientOverlays();
    // loginEntry, not a hardcoded screen: logout keeps the cached identity, so
    // this is a RETURNING user and the mode-aware entry sends them to their own
    // account's flow (email login vs the passcode lock).
    Get.offAllNamed(AppRoutes.loginEntry);
  }
}
