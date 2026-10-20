import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/config/locale_gating.dart';

/// Route-level guard for a screen that only works on a Naira account.
///
/// WHY A ROUTE GUARD AND NOT A CHECK ON THE GRID
///
/// Budgets, Budget AI and Goals are each reachable from more than the
/// analytics grid: the notification resolvers land on budgetList and
/// financialGoals directly, and the budget list and budget detail screens both
/// carry their own "AI insights" button. Dimming the four tiles on one screen
/// would leave every one of those open, so a user outside Nigeria could still
/// be dropped into a budgeting screen with nothing behind it by tapping a
/// push notification.
///
/// Wrapping the ROUTE closes them all at once, including doors added later.
/// Same reasoning as [FeatureGateGuard]; the difference is only what decides
/// it — the active account's currency rather than an admin switch.
///
/// WHY THESE SCREENS CANNOT WORK OUTSIDE NGN
///
/// Budgets and goals are measured against categorised spending, and
/// categorisation is fed by open banking, which is a Nigeria-only rail. On a
/// foreign-currency account there are no linked banks, so a budget has no
/// actual spending to track and an AI insight has nothing to read. The screens
/// render, and every figure on them is zero.
///
/// It renders an explanation rather than popping: a screen that opens and
/// instantly closes looks like a crash and leaves the user tapping the same
/// thing again. Back still works, so there is no dead end.
///
/// Listens to [FeatureFlags.revision] because the restriction itself is
/// admin-tunable (`locale_gating_enabled`), so switching it off reaches an
/// already-open screen within one settings poll rather than at next launch.
class LocaleGateGuard extends StatelessWidget {
  /// What the user called it, used in the headline and the explanation.
  final String title;

  /// The real screen, built lazily so a restricted account does not construct
  /// its cubits, open its streams or fire its first request.
  final WidgetBuilder builder;

  const LocaleGateGuard({
    super.key,
    required this.title,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: FeatureFlags.revision,
      builder: (context, _, __) {
        if (!LocaleGating.restricted) return builder(context);
        return _LocaleUnavailable(
          title: title,
          message: LocaleGating.reasonFor(title),
        );
      },
    );
  }
}

class _LocaleUnavailable extends StatelessWidget {
  final String title;
  final String message;

  const _LocaleUnavailable({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          // maybePop, not Get.back: this can be the FIRST route when opened
          // from a notification tap or a cold-start deep link, and popping the
          // only route leaves a black window.
          onPressed: () => Navigator.of(context).canPop()
              ? Get.back()
              : Get.offAllNamed('/dashboard'),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.public_off_rounded,
                  size: 52.sp, color: const Color(0xFF4B5563)),
              SizedBox(height: 16.h),
              Text(
                '$title works on your Naira account',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.5.sp,
                  color: const Color(0xFF9CA3AF),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
