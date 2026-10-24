library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';
import '../../domain/rotation_extension.dart';

/// THE CIRCLE HAS RUN OUT OF CALENDAR, AND ONLY ITS CREATOR CAN FIX THAT.
///
/// A rotating circle's end date bounds the whole rotation. Eight of nine live
/// circles had one already in the past (prod, 2026-10-19) — daily circles
/// with a handful of agreed cycles whose deadline sat on the FIRST cycle's
/// date — so they expired before the rotation they promised could run.
///
/// The server refuses to start another cycle in that state, because a cycle
/// that opens past its due date marks every member as in arrears the same
/// instant and the pot becomes unpayable. So the creator is asked for a new
/// end date before the cycle starts, not told something failed.
///
/// The picker opens on a date that WORKS — remaining turns × the circle's own
/// period — and will not accept one that is too short, because accepting it
/// would land the creator back here.
class ExtendRotationSheet extends StatefulWidget {
  const ExtendRotationSheet({
    super.key,
    required this.contribution,
    this.serverExplanation,
  });

  final Contribution contribution;

  /// The server's own sentence, shown verbatim when it is a human one. It
  /// names why the circle cannot continue, which is more specific than
  /// anything this sheet could infer.
  final String? serverExplanation;

  /// Returns the chosen date, or null if the creator backed out.
  static Future<DateTime?> show(
    BuildContext context, {
    required Contribution contribution,
    String? serverExplanation,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // Deliberately dismissible: this is a decision about other people's
      // turns, and trapping someone in a sheet is not how to get a considered
      // answer. Backing out simply leaves the cycle unstarted.
      builder: (_) => ExtendRotationSheet(
        contribution: contribution,
        serverExplanation: serverExplanation,
      ),
    );
  }

  @override
  State<ExtendRotationSheet> createState() => _ExtendRotationSheetState();
}

class _ExtendRotationSheetState extends State<ExtendRotationSheet> {
  late DateTime _earliest;
  late DateTime _picked;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _earliest = suggestedRotationDeadline(widget.contribution, now);
    _picked = _earliest;
  }

  String get _periodWord {
    switch (widget.contribution.frequency) {
      case ContributionFrequency.daily:
        return 'day';
      case ContributionFrequency.weekly:
        return 'week';
      case ContributionFrequency.biWeekly:
        return 'fortnight';
      case ContributionFrequency.quarterly:
        return 'quarter';
      case ContributionFrequency.yearly:
        return 'year';
      case ContributionFrequency.monthly:
      default:
        return 'month';
    }
  }

  Future<void> _pick() async {
    final chosen = await showDatePicker(
      context: context,
      initialDate: _picked,
      // Never offer a date that cannot work: the server would refuse it and
      // the creator would be sent round the same loop.
      firstDate: _earliest,
      lastDate: _earliest.add(const Duration(days: 365 * 3)),
      helpText: 'New end date',
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF8B5CF6),
            surface: Color(0xFF1F1F1F),
          ),
        ),
        child: child!,
      ),
    );
    if (chosen != null && mounted) setState(() => _picked = chosen);
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('EEE, d MMM yyyy');
    final remaining = rotationRemainingLabel(widget.contribution);

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.event_repeat,
                    color: const Color(0xFFF59E0B), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Give this circle more time',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              widget.serverExplanation?.trim().isNotEmpty == true
                  ? widget.serverExplanation!
                  : 'This circle still owes $remaining, but its end date does '
                      'not leave room for them.',
              style: GoogleFonts.inter(
                  color: Colors.grey[400], fontSize: 13.sp, height: 1.45),
            ),
            SizedBox(height: 6.h),
            Text(
              'Nobody owes an extra turn. The cycles everyone already agreed '
              'to just get the time they need to run.',
              style: GoogleFonts.inter(
                  color: Colors.grey[500], fontSize: 12.sp, height: 1.45),
            ),
            SizedBox(height: 18.h),
            InkWell(
              onTap: _pick,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(12.r),
                  border:
                      Border.all(color: const Color(0xFF3A3A3A), width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 16.sp, color: Colors.grey[500]),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New end date',
                              style: GoogleFonts.inter(
                                  color: Colors.grey[500], fontSize: 11.sp)),
                          SizedBox(height: 2.h),
                          Text(fmt.format(_picked),
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Icon(Icons.edit_calendar_outlined,
                        size: 18.sp, color: const Color(0xFF8B5CF6)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'One $_periodWord per remaining cycle is the least that works.',
              style:
                  GoogleFonts.inter(color: Colors.grey[600], fontSize: 11.sp),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(_picked),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('Extend and start the cycle',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w700)),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Not now',
                    style: GoogleFonts.inter(
                        color: Colors.grey[500], fontSize: 13.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
