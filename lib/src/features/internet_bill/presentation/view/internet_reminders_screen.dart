import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_reminder_item.dart';
import '../../domain/entities/internet_reminder.dart';
import '../cubit/internet_reminder_cubit.dart';
import '../cubit/internet_reminder_state.dart';

/// Internet subscription reminders. Mirrors `DataRemindersScreen`: due /
/// upcoming / completed sections, mark-complete and delete actions, FAB
/// to create new reminders. The backend `InternetReminderTimerWorker`
/// (`time.AfterFunc`) fires notifications at the exact `reminder_date`.
class InternetRemindersScreen extends StatefulWidget {
  const InternetRemindersScreen({super.key});

  @override
  State<InternetRemindersScreen> createState() =>
      _InternetRemindersScreenState();
}

class _InternetRemindersScreenState extends State<InternetRemindersScreen> {
  static const _accent = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<InternetReminderCubit>().getReminders(includePast: true);
  }

  DateTime? _parseDate(String iso) =>
      iso.isEmpty ? null : DateTime.tryParse(iso)?.toLocal();

  bool _isDue(InternetReminder r) {
    final d = _parseDate(r.reminderDate);
    return d != null && d.isBefore(DateTime.now()) && r.status == 'pending';
  }

  bool _isActive(InternetReminder r) =>
      r.status == 'pending' || r.status == 'notified';

  bool _isCompleted(InternetReminder r) =>
      r.status == 'completed' || r.status == 'cancelled';

  void _markComplete(InternetReminder r) => context
      .read<InternetReminderCubit>()
      .markReminderComplete(reminderId: r.id);

  void _delete(InternetReminder r) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r)),
        title: Text('Delete Reminder',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700)),
        content: Text('Are you sure you want to delete this reminder?',
            style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14.sp)),
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel',
                  style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600))),
          TextButton(
            onPressed: () {
              Get.back();
              context
                  .read<InternetReminderCubit>()
                  .deleteReminder(reminderId: r.id);
            },
            child: Text('Delete',
                style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _edit(InternetReminder r) {
    final cubit = context.read<InternetReminderCubit>();
    Get.toNamed(
      AppRoutes.internetBillReminderCreate,
      arguments: {'reminder': r},
    )?.then((res) {
      if (res == true && mounted) {
        cubit.getReminders(includePast: true);
      }
    });
  }

  void _payNow(InternetReminder r) {
    // Jump to the bill landing, replacing the reminders route so the
    // back stack stays shallow (reminders screen → home, not
    // reminders → reminders → home after a round trip).
    Get.offNamed(AppRoutes.internetBillHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<InternetReminderCubit>();
          Get.toNamed(AppRoutes.internetBillReminderCreate)?.then((res) {
            if (res == true && mounted) {
              cubit.getReminders(includePast: true);
            }
          });
        },
        backgroundColor: _accent,
        icon: Icon(Icons.add, size: 22.sp),
        label: Text('New Reminder',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child:
                  BlocConsumer<InternetReminderCubit, InternetReminderState>(
                listener: (context, state) {
                  if (state is InternetReminderError) {
                    Get.snackbar('Error', state.message,
                        backgroundColor:
                            Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white);
                  } else if (state is InternetReminderDeleted ||
                      state is InternetReminderCompleted) {
                    final msg = (state is InternetReminderDeleted)
                        ? state.message
                        : (state as InternetReminderCompleted).message;
                    Get.snackbar('Success', msg,
                        backgroundColor:
                            const Color(0xFF10B981).withValues(alpha: 0.9),
                        colorText: Colors.white);
                    context
                        .read<InternetReminderCubit>()
                        .getReminders(includePast: true);
                  }
                },
                builder: (context, state) {
                  if (state is InternetReminderLoading ||
                      state is InternetReminderInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(_accent),
                      ),
                    );
                  }
                  if (state is InternetRemindersLoaded) {
                    if (state.reminders.isEmpty) return _buildEmpty();
                    final due = state.reminders.where(_isDue).toList();
                    final active = state.reminders
                        .where((r) => _isActive(r) && !_isDue(r))
                        .toList();
                    final completed =
                        state.reminders.where(_isCompleted).toList();
                    return RefreshIndicator(
                      color: _accent,
                      onRefresh: () async {
                        await context
                            .read<InternetReminderCubit>()
                            .getReminders(includePast: true);
                      },
                      child: ListView(
                        padding: EdgeInsets.all(20.w),
                        children: [
                          if (due.isNotEmpty) ...[
                            _sectionHeader('Due', const Color(0xFFF59E0B)),
                            SizedBox(height: 12.h),
                            ...due.map((r) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _reminderCard(r, isDue: true),
                                )),
                            SizedBox(height: 24.h),
                          ],
                          if (active.isNotEmpty) ...[
                            _sectionHeader('Upcoming', _accent),
                            SizedBox(height: 12.h),
                            ...active.map((r) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _reminderCard(r),
                                )),
                          ],
                          if (completed.isNotEmpty) ...[
                            if (active.isNotEmpty || due.isNotEmpty)
                              SizedBox(height: 24.h),
                            _sectionHeader('Completed', Colors.grey),
                            SizedBox(height: 12.h),
                            ...completed.map((r) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _reminderCard(r),
                                )),
                          ],
                        ],
                      ),
                    );
                  }
                  return _buildEmpty();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15)),
                ),
                child: Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Internet Reminders',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700)),
                  Text('Never miss a renewal',
                      style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 13.sp)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _sectionHeader(String t, Color c) => Row(
        children: [
          Container(
            width: 4.w,
            height: 20.h,
            decoration: BoxDecoration(
                color: c, borderRadius: BorderRadius.circular(2.r)),
          ),
          SizedBox(width: 12.w),
          Text(t,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700)),
        ],
      );

  Widget _buildEmpty() => Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1), width: 2),
                ),
                child: Icon(Icons.notifications_none,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 56.sp),
              ),
              SizedBox(height: 24.h),
              Text('No Reminders',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),
              Text(
                'Tap "New Reminder" to schedule a nudge before your internet subscription expires.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );

  Widget _reminderCard(InternetReminder r, {bool isDue = false}) {
    final date = _parseDate(r.reminderDate);

    return BillReminderItem(
      title: r.title,
      description: r.description,
      amount: r.amount,
      reminderDate: date ?? DateTime.now(),
      status: r.status,
      isRecurring: r.isRecurring,
      recurrenceType: r.recurrenceType,
      isDue: isDue,
      payNowLabel: 'Renew Internet Now',
      onPayNow: isDue && !_isCompleted(r) ? () => _payNow(r) : null,
      onMarkComplete: !_isCompleted(r) ? () => _markComplete(r) : null,
      onEdit: !_isCompleted(r) ? () => _edit(r) : null,
      onDelete: () => _delete(r),
    );
  }
}
