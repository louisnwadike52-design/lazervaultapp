import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ticketing_theme.dart';

/// THE EVENTS CATALOGUE'S CHROME — the full-page message and the filter chip.
///
/// Split out of `events_screen.dart` when that file crossed the 500-line
/// ceiling the root guide sets. The division is by RESPONSIBILITY and not by
/// line count: everything left in the screen is about what to load and which
/// filters are on, while these two are purely how a state is drawn and depend
/// on nothing the screen holds privately. The screen's own comment on why an
/// active chip must be COLOURED rather than merely worded travels with the
/// chip, because that is the thing it is about.

class EventsMessage extends StatelessWidget {
  const EventsMessage({
    super.key,
    required this.icon,
    required this.text,
    this.onRetry,
    this.retryLabel,
  });
  final IconData icon;
  final String text;
  final VoidCallback? onRetry;

  /// What the action says. "Try again" is right for a failed load and wrong
  /// for an empty filtered list — there was nothing to retry, the query
  /// simply matched nothing, and the useful action is to widen it.
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.w, color: TicketingTheme.textMuted),
            SizedBox(height: 12.h),
            Text(text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 14.sp, color: TicketingTheme.textSecondary)),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onRetry,
                child: Text(retryLabel ?? 'Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// One filter chip: what is selected, and a hint that it opens something.
///
/// ACTIVE STATE IS COLOURED, not just worded. "Any category" and "Comedy" are
/// both plausible labels on an untouched screen, so the only reliable signal
/// that a filter is ON is that the chip looks different — otherwise an empty
/// result reads as "there are no events" rather than "none in Comedy".
class EventsFilterChip extends StatelessWidget {
  const EventsFilterChip({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: active
              ? TicketingTheme.ticket.withValues(alpha: 0.14)
              : TicketingTheme.card,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: active ? TicketingTheme.ticket : TicketingTheme.border,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 15.sp,
                color: active
                    ? TicketingTheme.ticket
                    : TicketingTheme.textSecondary),
            SizedBox(width: 7.w),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12.5.sp,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  color: active ? Colors.white : TicketingTheme.textSecondary,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 18.sp,
                color: active
                    ? TicketingTheme.ticket
                    : TicketingTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
