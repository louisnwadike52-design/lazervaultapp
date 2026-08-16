import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/reminder_management_screen.dart';

/// Compact "Upcoming reminders" card for the Plan My Day → Day view. Shows the
/// next few active reminders and taps through to the full Reminders screen.
///
/// It hosts its OWN scoped PlanMyDayCubit (like the utility chips) so its
/// ReminderListLoaded state never leaks into the landing page's Day/Board views.
class UpcomingRemindersCard extends StatelessWidget {
  const UpcomingRemindersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PlanMyDayCubit>()..loadReminders(enabledOnly: true),
      child: const _UpcomingRemindersView(),
    );
  }
}

class _UpcomingRemindersView extends StatelessWidget {
  const _UpcomingRemindersView();

  static const _surface = Color(0xFF1F1F1F);
  static const _accent = Color(0xFF4E03D0);

  DateTime _target(Reminder r) => r.eventTime ?? r.remindAt;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      buildWhen: (_, s) => s is ReminderListLoaded,
      builder: (context, state) {
        if (state is! ReminderListLoaded) return const SizedBox.shrink();
        final now = DateTime.now();
        final upcoming = state.reminders.where((r) => r.isActive && _target(r).isAfter(now)).toList()
          ..sort((a, b) => _target(a).compareTo(_target(b)));
        if (upcoming.isEmpty) return const SizedBox.shrink();
        final show = upcoming.take(3).toList();

        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.notifications_active_outlined, size: 18.sp, color: _accent),
                  SizedBox(width: 8.w),
                  Text('Upcoming reminders',
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(context, ReminderManagementScreen.route()),
                    child: Text('See all',
                        style: GoogleFonts.inter(color: _accent, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ...show.map((r) => _row(context, r)),
            ],
          ),
        );
      },
    );
  }

  Widget _row(BuildContext context, Reminder r) {
    final t = _target(r);
    final when = r.allDay
        ? DateFormat('EEE, d MMM').format(t)
        : DateFormat('EEE, d MMM · h:mm a').format(t);
    return InkWell(
      onTap: () => Navigator.push(context, ReminderManagementScreen.route()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Row(
          children: [
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(color: r.getColor(), shape: BoxShape.circle),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(r.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
            ),
            SizedBox(width: 8.w),
            Text(when, style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 11.sp)),
          ],
        ),
      ),
    );
  }
}
