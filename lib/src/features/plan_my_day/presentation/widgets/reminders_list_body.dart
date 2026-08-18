import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/create_reminder_bottom_sheet.dart';

/// Embeddable reminders list — the shared body used by BOTH the standalone
/// [ReminderManagementScreen] and the Plan My Day "Reminders" tab. Expects a
/// [PlanMyDayCubit] provided above it (each host scopes its OWN so a
/// ReminderListLoaded state never clobbers the board/day view's state).
///
/// Reminders fire on the standard admin schedule — an all-day event nudges 3
/// days / 1 day before and on the day; a timed event nudges an hour before —
/// delivered via push / email / SMS per the user's notification profile.
class RemindersListBody extends StatelessWidget {
  const RemindersListBody({super.key});

  static const _surface = Color(0xFF1F1F1F);
  static const _accent = Color(0xFF4E03D0);

  /// Opens the create/edit reminder sheet, re-providing the caller's cubit so
  /// the list refreshes on save. Public so a host FAB can invoke it.
  static void openCreateSheet(BuildContext context, {Reminder? existing}) {
    final cubit = context.read<PlanMyDayCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: CreateReminderBottomSheet(existing: existing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanMyDayCubit, PlanMyDayState>(
      listenWhen: (_, s) => s is ReminderDeleted || s is PlanMyDayError,
      listener: (context, state) {
        if (state is ReminderDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reminder deleted')),
          );
        } else if (state is PlanMyDayError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red[700]),
          );
        }
      },
      buildWhen: (_, s) => s is ReminderListLoaded || s is PlanMyDayLoading,
      builder: (context, state) {
        if (state is PlanMyDayLoading) {
          return const Center(child: LazerVaultLoader.small());
        }
        final reminders = state is ReminderListLoaded ? state.reminders : const <Reminder>[];
        if (reminders.isEmpty) return _emptyState(context);

        final now = DateTime.now();
        final upcoming = reminders.where((r) => _target(r).isAfter(now)).toList()
          ..sort((a, b) => _target(a).compareTo(_target(b)));
        final past = reminders.where((r) => !_target(r).isAfter(now)).toList()
          ..sort((a, b) => _target(b).compareTo(_target(a)));

        return RefreshIndicator(
          color: _accent,
          onRefresh: () => context.read<PlanMyDayCubit>().loadReminders(),
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
            children: [
              if (upcoming.isNotEmpty) ...[
                _sectionHeader('Upcoming'),
                ...upcoming.map((r) => _reminderTile(context, r)),
              ],
              if (past.isNotEmpty) ...[
                SizedBox(height: 16.h),
                _sectionHeader('Past'),
                ...past.map((r) => _reminderTile(context, r)),
              ],
            ],
          ),
        );
      },
    );
  }

  DateTime _target(Reminder r) => r.eventTime ?? r.remindAt;

  Widget _sectionHeader(String t) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(t.toUpperCase(),
            style: GoogleFonts.inter(
                color: Colors.grey[500], fontSize: 12.sp, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
      );

  Widget _reminderTile(BuildContext context, Reminder r) {
    final target = _target(r);
    return Dismissible(
      key: ValueKey(r.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(12.r)),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => context.read<PlanMyDayCubit>().deleteReminder(r.id),
      child: GestureDetector(
        onTap: () => openCreateSheet(context, existing: r),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: r.getColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(_categoryIcon(r.category), color: r.getColor(), size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 3.h),
                    Text(_subtitle(r, target),
                        style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 12.sp)),
                  ],
                ),
              ),
              Switch(
                value: r.isActive,
                activeColor: _accent,
                onChanged: (v) => context
                    .read<PlanMyDayCubit>()
                    .updateReminder(r.id, r.copyWith(isActive: v)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle(Reminder r, DateTime target) {
    final fmt = r.allDay
        ? DateFormat('EEE, d MMM yyyy').format(target)
        : DateFormat('EEE, d MMM · h:mm a').format(target);
    final repeat = r.reminderType == 'recurring' ? ' · ${r.repeatPattern ?? 'repeats'}' : '';
    return '$fmt$repeat';
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'birthday':
        return Icons.cake_outlined;
      case 'bill':
        return Icons.receipt_long_outlined;
      case 'event':
        return Icons.event_outlined;
      case 'task':
        return Icons.task_alt;
      default:
        return Icons.notifications_active_outlined;
    }
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 56.sp, color: Colors.grey[700]),
          SizedBox(height: 12.h),
          Text('No reminders yet',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "Set a reminder for a birthday, bill or event — we'll nudge you 3 days, a day, and an hour before.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13.sp),
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton.icon(
            onPressed: () => openCreateSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _accent,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text('Create reminder',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _surface,
        title: Text('Delete reminder?', style: GoogleFonts.inter(color: Colors.white)),
        content: Text('This cancels its scheduled notifications.',
            style: GoogleFonts.inter(color: Colors.grey[400])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete', style: TextStyle(color: Colors.red[400])),
          ),
        ],
      ),
    );
    return ok ?? false;
  }
}
