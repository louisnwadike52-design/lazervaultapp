import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// A way out of a RESUMED signup, for someone who is not that person.
///
/// A device that quit partway through signing up reopens straight back into
/// that half-finished signup. Until now there was no exit: the only screen
/// offered was "Create a passcode" for an account the current holder may have
/// no interest in, with a back button that returns to another step of the same
/// flow. A second person sharing the handset, or the same person who changed
/// their mind, had nowhere to go.
///
/// ## Shown ONLY on a resume
///
/// It is gated on [SignupStateService.wasResumedThisLaunch], set by main.dart
/// at the single point where a resume route is chosen. Deliberately NOT gated
/// on `has_incomplete_signup`, which is also true while somebody is partway
/// through signing up for the FIRST time — it is written as each step
/// completes. Using that flag would put an "abandon this" exit in front of
/// people mid-signup, which is the opposite of what anyone wants there.
///
/// ## What it actually does
///
/// Clears the local draft only. The half-finished account still exists
/// server-side and its owner can return to it by signing up with the same
/// number; this device simply stops resuming into it. Confirmed first, because
/// the person tapping it may be the owner who merely pressed the wrong thing.
class SignupSwitchAccountCta extends StatelessWidget {
  const SignupSwitchAccountCta({super.key, this.bottomPadding = 24});

  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    if (!SignupStateService.wasResumedThisLaunch) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding.h, top: 8.h),
      child: Center(
        child: TextButton(
          onPressed: () => _confirm(context),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.white.withValues(alpha: 0.72),
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
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave this signup?'),
        content: Text(
          'You are partway through creating an account on this device. Leaving '
          'takes you to sign-in so a different account can be used.\n\n'
          'Nothing is deleted — whoever started this signup can pick it up '
          'again with the same phone number.',
          style: TextStyle(fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep going'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    if (leave != true) return;

    await SignupStateService(serviceLocator<FlutterSecureStorage>())
        .abandonForAccountSwitch();
    // offAllNamed: the signup steps behind this one must not stay on the stack,
    // or the back gesture walks straight back into the flow just abandoned.
    Get.offAllNamed(AppRoutes.phonePasscodeLogin);
  }
}
