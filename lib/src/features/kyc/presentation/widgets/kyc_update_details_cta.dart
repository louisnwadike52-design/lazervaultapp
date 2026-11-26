import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/kyc/presentation/views/kyc_update_details_screen.dart';

/// "Details wrong? Update your information" — always on the verification
/// screen, not only after a failure.
///
/// ## Why it cannot wait for an error
///
/// The refusal that needs it is the one we are LEAST able to classify. Mono
/// returns `data_verification_failed` with no field and no reason, so a name
/// mismatch is indistinguishable from any other check failing — the error
/// dialog cannot know to offer "update your name", and sometimes no dialog
/// appears at all: the customer closes the widget themselves, or the app is
/// killed mid-session and resumes on a screen that just says "Verify Your
/// Identity" again.
///
/// In every one of those the customer is looking at a screen with one button
/// that does the thing which already failed. Keeping the correction visible
/// the whole time is what stops that being a dead end.
///
/// Styled as a quiet text action, deliberately matching [KycGateExitCta]'s
/// "Sign in as someone else": both are escapes from a gate, neither should
/// compete with Continue.
class KycUpdateDetailsCta extends StatelessWidget {
  /// Called with true when the customer actually changed something, so the
  /// caller can re-run verification instead of making them find Continue.
  final Future<void> Function(bool changed)? onReturned;

  const KycUpdateDetailsCta({super.key, this.onReturned});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: Center(
        child: TextButton(
          onPressed: () async {
            final changed = await Get.to(() => const KycUpdateDetailsScreen());
            await onReturned?.call(changed == true);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              // Its own ground: these sit on the light page / purple curve,
              // where white-at-65% text had no contrast at all.
              color: const Color(0xFF14131A).withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(999),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white.withValues(alpha: 0.86),
                ),
                children: [
                  const TextSpan(text: 'Details not matching?  '),
                  TextSpan(
                    text: 'Update your information',
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
      ),
    );
  }
}
