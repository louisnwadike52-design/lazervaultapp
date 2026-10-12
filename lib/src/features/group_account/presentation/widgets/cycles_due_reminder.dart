import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/group_entities.dart';

/// "You have cycles to pay" — shown once a day when the member opens Group
/// Funds while behind on something.
///
/// WHY A MODAL AT ALL
/// ------------------
/// An esusu only works if everyone pays. A member who forgets does not just
/// inconvenience themselves: the member whose turn it is collects a pot the
/// others filled and they did not, which is the exact failure the
/// arrangement exists to prevent. Push notifications are easy to dismiss and
/// easy to miss; the moment someone opens Group Funds they are already
/// thinking about it, and that is the cheapest moment to ask.
///
/// WHY ONCE A DAY
/// --------------
/// A modal on every open is an obstacle, and an obstacle gets dismissed
/// without reading. Once per calendar day is often enough to be a reminder
/// and rare enough to still be read. The list is reachable any time from the
/// group itself, so nothing is hidden by not showing it.
class CyclesDueReminder {
  const CyclesDueReminder._();

  /// Last date (yyyy-MM-dd) the reminder was shown. Per-device, because that
  /// is where "I already saw this today" is true.
  static const String _lastShownKey = 'group_funds_cycles_due_last_shown';

  /// Whether the reminder may show today.
  ///
  /// Fails OPEN: a preferences read that throws returns true, so a storage
  /// problem shows the reminder one extra time rather than silencing a
  /// payment prompt indefinitely. Showing it twice is a nuisance; never
  /// showing it costs someone their turn.
  static Future<bool> shouldShowToday() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_lastShownKey) != _today();
    } catch (_) {
      return true;
    }
  }

  static Future<void> markShownToday() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastShownKey, _today());
    } catch (_) {
      // Non-fatal: the reminder simply shows again on the next open.
    }
  }

  static String _today() => DateFormat('yyyy-MM-dd').format(DateTime.now());
}

/// Shows the reminder. Returns the contribution the member chose to pay, or
/// null if they dismissed it.
Future<Contribution?> showCyclesDueReminder(
  BuildContext context,
  List<Contribution> overdue,
) async {
  if (overdue.isEmpty) return null;
  return showModalBottomSheet<Contribution>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _CyclesDueSheet(overdue: overdue),
  );
}

class _CyclesDueSheet extends StatelessWidget {
  final List<Contribution> overdue;
  const _CyclesDueSheet({required this.overdue});

  @override
  Widget build(BuildContext context) {
    final esusu = overdue.where((c) => c.isRotatingSavings).length;

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      margin: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.schedule_rounded,
                    color: const Color(0xFFF59E0B), size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  overdue.length == 1
                      ? 'You have a payment due'
                      : 'You have ${overdue.length} payments due',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            esusu > 0
                // Says the consequence, not just the fact. "You owe money" is
                // a nag; "the person whose turn it is collects what the rest
                // of you paid in" is a reason.
                ? 'In an esusu the pot is paid out on schedule whether or not '
                    'everyone has paid. Settling up keeps the member whose '
                    'turn it is from being short — and keeps your own turn.'
                : 'These goals have passed their date and are still short.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.5.sp,
              height: 1.45,
            ),
          ),
          SizedBox(height: 14.h),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: overdue.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, i) => _OverdueRow(
                contribution: overdue[i],
                onTap: () => Navigator.of(context).pop(overdue[i]),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Later',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverdueRow extends StatelessWidget {
  final Contribution contribution;
  final VoidCallback onTap;
  const _OverdueRow({required this.contribution, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // What this member owes for one cycle. For an esusu that is the fixed
    // share; for a one-time goal there is no per-person figure, so the row
    // shows what the goal is still short instead of inventing one.
    final share = contribution.regularAmount;
    final remaining =
        (contribution.targetAmount - contribution.amountRaised).clamp(0, double.infinity);
    final money = NumberFormat.currency(
      symbol: '${contribution.currency} ',
      decimalDigits: 0,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contribution.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    contribution.isRotatingSavings && share != null && share > 0
                        ? '${money.format(share)} per cycle'
                        : '${money.format(remaining)} still needed',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.5.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Pay',
              style: GoogleFonts.inter(
                color: const Color(0xFF9F7AEA),
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(Icons.chevron_right,
                color: const Color(0xFF9F7AEA), size: 18.sp),
          ],
        ),
      ),
    );
  }
}
