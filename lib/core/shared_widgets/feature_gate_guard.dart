import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// Route-level guard for an admin-gated screen.
///
/// WHY THIS EXISTS RATHER THAN A CHECK ON EACH HUB
///
/// The hub a service is reached from is NOT the only way in. Counting the
/// `Get.toNamed` call sites for the gated bill routes alone found between 3
/// and 24 each — saved beneficiaries, repeat-purchase shortcuts, transaction
/// history, auto-recharge management, notification taps, the chat and voice
/// agents, and deep links all navigate straight to these screens without
/// passing the hub. A gate on the hub is decorative while any of those still
/// open the flow.
///
/// Wrapping the ROUTE closes every one of them at once, including paths added
/// later: a screen registered through [AppRouter] cannot be reached without
/// going through its own `page:` builder.
///
/// It renders an explanation rather than popping. A screen that opens and
/// immediately closes itself looks like a crash, and leaves the user tapping
/// the same thing again; one that opens and says why does not. Back still
/// works, so there is no dead end.
///
/// Listens to [FeatureFlags.revision], so a surface switched off reaches an
/// already-open screen within one settings poll rather than at next launch.
class FeatureGateGuard extends StatelessWidget {
  /// Gate prefix, e.g. `feature_bill_education`.
  final String gate;

  /// What the user called it, used in the headline.
  final String title;

  /// The real screen, built lazily so a gated-off service does not construct
  /// its cubits, open its streams or fire its first request.
  final WidgetBuilder builder;

  const FeatureGateGuard({
    super.key,
    required this.gate,
    required this.title,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: FeatureFlags.revision,
      builder: (context, _, __) {
        if (FeatureFlags.gateAllowed(gate)) return builder(context);
        return _Unavailable(
            title: title, message: FeatureFlags.gateMessage(gate));
      },
    );
  }
}

class _Unavailable extends StatelessWidget {
  final String title;
  final String message;

  const _Unavailable({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          // maybePop, not Get.back: this screen can be the FIRST route when it
          // is opened from a notification tap or a cold-start deep link, and
          // popping the only route leaves a black window.
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
              Icon(Icons.lock_clock_outlined,
                  size: 52.sp, color: const Color(0xFF4B5563)),
              SizedBox(height: 16.h),
              Text(
                '$title is not available at the moment',
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
