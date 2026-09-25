import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// Shown in place of the Send Abroad form while international payout is off.
///
/// WHY A STATE AND NOT A HIDDEN TAB
/// --------------------------------
/// Hiding the tab entirely would be the easier change, and worse: a user who has
/// sent money abroad before, or who has been told the feature exists, goes
/// looking for it and finds nothing — which reads as the app being broken rather
/// than the service being off. A tab that opens and explains itself answers the
/// question in one tap and stops the support message.
///
/// The alternative — leaving the flow open — is worse still. It collects a
/// recipient, an amount and a transaction PIN and fails at the provider, so the
/// user has committed to a transfer that was never going to complete, and the
/// failure arrives at the point they most expect success.
///
/// COPY IS CHOSEN BY AN ADMIN, NOT GUESSED HERE
/// --------------------------------------------
/// The honest reason changes as the integration lands, so it is a setting
/// (`intl_payout_unavailable_scope`) rather than a constant. A corridor live in
/// some countries is not the same as one live for nobody, and telling somebody
/// "not available for your account" while it is off for everyone sends them to
/// support about an account that is perfectly fine.
///
/// Every variant avoids implying the user did something wrong or that their
/// money is at risk, and none of them promise a date we cannot keep.
class InternationalPayoutUnavailable extends StatelessWidget {
  const InternationalPayoutUnavailable({super.key});

  /// (title, body) for the admin-selected scope.
  static (String, String) copyFor(String scope) {
    switch (scope) {
      case 'account':
        return (
          'Not available on your account yet',
          'Sending money abroad is not switched on for this account at the '
              'moment. Everything else works as normal, and your balance is '
              'unaffected. We will let you know as soon as it is available.',
        );
      case 'country':
        return (
          'Not available in your country yet',
          'Sending money abroad is not supported from your country at the '
              'moment. Everything else works as normal, and your balance is '
              'unaffected. We are working on opening more countries.',
        );
      default:
        return (
          'Not available at the moment',
          'Sending money abroad is temporarily unavailable. Everything else '
              'works as normal, and your balance is unaffected. Please try '
              'again later.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (title, body) = copyFor(FeatureFlags.intlPayoutScope);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: const Color(0xFF161221),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFF2A2340), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              // Muted, not red. This is a service that is off, not an error the
              // user caused or needs to act on.
              color: const Color(0xFF4E03D0).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.public_off_rounded,
              size: 28.sp,
              color: const Color(0xFFA78BFA),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            body,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFFB6B9C6),
              fontSize: 13.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 20.h),
          // Points back at the half of the screen that DOES work, so the tab is
          // not a dead end.
          Text(
            'You can still convert between your own currencies from the '
            'Convert tab.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF8A8FA3),
              fontSize: 12.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
