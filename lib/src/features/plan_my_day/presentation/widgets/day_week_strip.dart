import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';

/// Horizontal week strip for the Day view. Shows the Mon–Sun week containing
/// [selectedDate]; each day chip is a [DragTarget] so a task dragged from a Day
/// row (via its ≡ handle) can be dropped onto another day to reschedule it.
/// Tapping a chip navigates to that day.
class DayWeekStrip extends StatelessWidget {
  final DateTime selectedDate;
  final List<Task> tasks;
  final ValueChanged<DateTime> onSelectDay;
  final void Function(Task task, DateTime day) onDropTaskOnDay;

  const DayWeekStrip({
    super.key,
    required this.selectedDate,
    required this.tasks,
    required this.onSelectDay,
    required this.onDropTaskOnDay,
  });

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);

  List<DateTime> get _week {
    // Monday as the first day of the week.
    final monday =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final base = DateTime(monday.year, monday.month, monday.day);
    return [for (int i = 0; i < 7; i++) base.add(Duration(days: i))];
  }

  int _countFor(DateTime day) => tasks
      .where((t) =>
          t.dueDate != null &&
          t.dueDate!.year == day.year &&
          t.dueDate!.month == day.month &&
          t.dueDate!.day == day.day)
      .length;

  bool _isSame(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SizedBox(
      height: 74.h,
      child: Row(
        children: [
          for (final day in _week)
            Expanded(
              child: _dayChip(
                day,
                selected: _isSame(day, selectedDate),
                isToday: _isSame(day, now),
              ),
            ),
        ],
      ),
    );
  }

  Widget _dayChip(DateTime day, {required bool selected, required bool isToday}) {
    final count = _countFor(day);
    return DragTarget<Task>(
      onWillAcceptWithDetails: (d) =>
          d.data.dueDate == null || !_isSame(d.data.dueDate!, day),
      onAcceptWithDetails: (d) {
        HapticFeedback.selectionClick();
        onDropTaskOnDay(d.data, day);
      },
      builder: (context, candidate, rejected) {
        final highlight = candidate.isNotEmpty;
        return GestureDetector(
          onTap: () => onSelectDay(day),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: selected
                  ? _purple
                  : highlight
                      ? _purple.withValues(alpha: 0.25)
                      : _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: highlight
                    ? _purple
                    : isToday
                        ? _purple.withValues(alpha: 0.6)
                        : _border,
                width: highlight ? 1.5 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('E').format(day).substring(0, 1),
                  style: GoogleFonts.inter(
                    color: selected ? Colors.white : _muted,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  '${day.day}',
                  style: GoogleFonts.inter(
                    color: selected
                        ? Colors.white
                        : isToday
                            ? _purple
                            : Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: count > 0
                        ? (selected ? Colors.white : _purple)
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
