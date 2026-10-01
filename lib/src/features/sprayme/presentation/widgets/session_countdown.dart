import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/session_clock.dart';

/// The session clock, on screen.
///
/// TWO SURFACES, ON PURPOSE:
///   · [SessionCountdownChip] is always there once a session has a clock. A
///     deadline nobody can see until it is nearly up is an ambush.
///   · [SessionExpiringBanner] appears only at the server's warning marks, is
///     dismissible, and carries the action.
///
/// Both tick locally off a single [DateTime] rather than polling. The server
/// is the authority on when a session ends; this only renders the gap, and a
/// second of drift either way is invisible.

/// A quiet countdown that gets louder as the time goes.
class SessionCountdownChip extends StatefulWidget {
  final DateTime expiresAt;
  final SessionClockPolicy policy;

  /// Opens the extend sheet. Null for a viewer — only the host pays.
  final VoidCallback? onTap;

  const SessionCountdownChip({
    super.key,
    required this.expiresAt,
    required this.policy,
    this.onTap,
  });

  @override
  State<SessionCountdownChip> createState() => _SessionCountdownChipState();
}

class _SessionCountdownChipState extends State<SessionCountdownChip> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // One second. The display only shows seconds under ten minutes, but the
    // urgency colour has to change the moment a mark is crossed, and a
    // coarser tick would let the chip sit calm-green a minute into a warning.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final left = widget.expiresAt.difference(DateTime.now());
    final remaining = left.isNegative ? Duration.zero : left;
    final urgency = urgencyFor(remaining, widget.policy);

    final (bg, fg) = switch (urgency) {
      SessionClockUrgency.critical => (
          const Color(0xFFEF4444),
          Colors.white,
        ),
      SessionClockUrgency.warning => (
          const Color(0xFFFB923C).withValues(alpha: 0.9),
          Colors.white,
        ),
      SessionClockUrgency.calm => (
          Colors.black.withValues(alpha: 0.4),
          Colors.white70,
        ),
    };

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                urgency == SessionClockUrgency.calm
                    ? Icons.schedule
                    : Icons.timer_outlined,
                size: 11.sp,
                color: fg),
            SizedBox(width: 4.w),
            Text(
              remaining == Duration.zero
                  ? 'Ending'
                  : formatCountdown(remaining),
              style: TextStyle(
                  color: fg, fontSize: 11.sp, fontWeight: FontWeight.w700),
            ),
            // The chip is only an affordance when there is something to do
            // about it, so the chevron appears for the host alone.
            if (widget.onTap != null && urgency != SessionClockUrgency.calm) ...[
              SizedBox(width: 3.w),
              Icon(Icons.add_circle_outline, size: 11.sp, color: fg),
            ],
          ],
        ),
      ),
    );
  }
}

/// The warning the server raised, with the way out attached.
///
/// Dismissible, and dismissal is per-mark rather than permanent: closing the
/// fifteen-minute notice must not also silence the one at five.
class SessionExpiringBanner extends StatelessWidget {
  final int minutesLeft;
  final bool isHost;

  /// Opens the extend sheet.
  final VoidCallback onExtend;
  final VoidCallback onDismiss;

  const SessionExpiringBanner({
    super.key,
    required this.minutesLeft,
    required this.isHost,
    required this.onExtend,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final critical = minutesLeft <= 1;
    final accent =
        critical ? const Color(0xFFEF4444) : const Color(0xFFFB923C);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 10.w, 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accent),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.timer_outlined, color: accent, size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      minutesLeft <= 1
                          ? 'This session ends in under a minute'
                          : 'This session ends in $minutesLeft minutes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      // A viewer can do nothing about this, so telling them
                      // to "add time" would be an instruction they cannot
                      // follow. They get the fact and nothing else.
                      isHost
                          ? 'Add more time to keep everyone in the room.'
                          : 'The host can add more time.',
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 11.5.sp),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onDismiss,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(Icons.close,
                      size: 16.sp, color: const Color(0xFF9CA3AF)),
                ),
              ),
            ],
          ),
          if (isHost) ...[
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 42.h,
              child: ElevatedButton.icon(
                onPressed: onExtend,
                icon: Icon(Icons.more_time_rounded, size: 18.sp),
                label: Text('Add more time',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
