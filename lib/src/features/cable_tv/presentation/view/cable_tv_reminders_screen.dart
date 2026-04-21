import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_reminder_item.dart';
import '../../domain/entities/cable_tv_reminder.dart';
import '../cubit/cable_tv_reminder_cubit.dart';
import '../cubit/cable_tv_reminder_state.dart';

/// Cable TV subscription reminders. Mirrors `DataRemindersScreen`.
class CableTVRemindersScreen extends StatefulWidget {
  const CableTVRemindersScreen({super.key});

  @override
  State<CableTVRemindersScreen> createState() =>
      _CableTVRemindersScreenState();
}

class _CableTVRemindersScreenState extends State<CableTVRemindersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CableTVReminderCubit>().getReminders(includePast: true);
  }

  DateTime? _parseDate(String iso) =>
      iso.isEmpty ? null : DateTime.tryParse(iso)?.toLocal();

  bool _isDue(CableTVReminder r) {
    final d = _parseDate(r.reminderDate);
    return d != null && d.isBefore(DateTime.now()) && r.status == 'pending';
  }

  bool _isActive(CableTVReminder r) =>
      r.status == 'pending' || r.status == 'notified';

  bool _isCompleted(CableTVReminder r) =>
      r.status == 'completed' || r.status == 'cancelled';

  void _markComplete(CableTVReminder r) =>
      context.read<CableTVReminderCubit>().markReminderComplete(reminderId: r.id);

  void _delete(CableTVReminder r) {
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
                  .read<CableTVReminderCubit>()
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

  void _edit(CableTVReminder r) {
    final cubit = context.read<CableTVReminderCubit>();
    Get.toNamed(
      AppRoutes.cableTVReminderCreate,
      arguments: {'reminder': r},
    )?.then((res) {
      if (res == true && mounted) {
        cubit.getReminders(includePast: true);
      }
    });
  }

  void _payNow(CableTVReminder r) {
    Get.toNamed(AppRoutes.cableTVHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<CableTVReminderCubit>();
          Get.toNamed(AppRoutes.cableTVReminderCreate)?.then((res) {
            if (res == true && mounted) {
              cubit.getReminders(includePast: true);
            }
          });
        },
        backgroundColor: const Color(0xFF4E03D0),
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
                  BlocConsumer<CableTVReminderCubit, CableTVReminderState>(
                listener: (context, state) {
                  if (state is CableTVReminderError) {
                    Get.snackbar('Error', state.message,
                        backgroundColor:
                            Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white);
                  } else if (state is CableTVReminderDeleted ||
                      state is CableTVReminderCompleted) {
                    final msg = (state is CableTVReminderDeleted)
                        ? state.message
                        : (state as CableTVReminderCompleted).message;
                    Get.snackbar('Success', msg,
                        backgroundColor:
                            const Color(0xFF10B981).withValues(alpha: 0.9),
                        colorText: Colors.white);
                    context
                        .read<CableTVReminderCubit>()
                        .getReminders(includePast: true);
                  }
                },
                builder: (context, state) {
                  if (state is CableTVReminderLoading ||
                      state is CableTVReminderInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation(Color(0xFF4E03D0)),
                      ),
                    );
                  }
                  if (state is CableTVRemindersLoaded) {
                    if (state.reminders.isEmpty) return _buildEmpty();
                    final due = state.reminders.where(_isDue).toList();
                    final active = state.reminders
                        .where((r) => _isActive(r) && !_isDue(r))
                        .toList();
                    final completed =
                        state.reminders.where(_isCompleted).toList();
                    return RefreshIndicator(
                      color: const Color(0xFF4E03D0),
                      onRefresh: () async {
                        await context
                            .read<CableTVReminderCubit>()
                            .getReminders(includePast: true);
                      },
                      child: ListView(
                        padding: EdgeInsets.all(20.w),
                        children: [
                          if (due.isNotEmpty) ...[
                            _sectionHeader(
                                'Due', const Color(0xFFF59E0B)),
                            SizedBox(height: 12.h),
                            ...due.map((r) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _reminderCard(r, isDue: true),
                                )),
                            SizedBox(height: 24.h),
                          ],
                          if (active.isNotEmpty) ...[
                            _sectionHeader(
                                'Upcoming', const Color(0xFF4E03D0)),
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
                  Text('TV Reminders',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700)),
                  Text('Never miss a subscription renewal',
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
                'Tap "New Reminder" to schedule a notification before your cable TV subscription expires.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );

  Widget _reminderCard(CableTVReminder r, {bool isDue = false}) {
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
      payNowLabel: 'Renew Now',
      onPayNow: isDue && !_isCompleted(r) ? () => _payNow(r) : null,
      onMarkComplete: !_isCompleted(r) ? () => _markComplete(r) : null,
      onEdit: !_isCompleted(r) ? () => _edit(r) : null,
      onDelete: () => _delete(r),
    );
  }
}
