import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_reminder_item.dart';
import '../../../../../core/widgets/reminder_pause_resume_mixin.dart';
import '../../domain/entities/water_reminder.dart';
import '../cubit/water_reminder_cubit.dart';
import '../cubit/water_reminder_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Water bill reminders list screen.
///
/// Reuses the shared [BillReminderItem] widget (same as cable TV, data,
/// electricity) so the UI and actions (Mark Complete / Edit / Delete /
/// Pay Now) are visually identical across bill types. Groups rows by
/// Due / Upcoming / Completed.
class WaterRemindersScreen extends StatefulWidget {
  const WaterRemindersScreen({super.key});

  @override
  State<WaterRemindersScreen> createState() => _WaterRemindersScreenState();
}

class _WaterRemindersScreenState extends State<WaterRemindersScreen>
    with ReminderPauseResumeMixin<WaterRemindersScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _accentOrange = Color(0xFFFB923C);

  /// Last successfully loaded list — mirrors `DataRemindersScreen`'s
  /// `_cachedList` pattern so a mutation (delete / mark complete) or a
  /// transient `WaterReminderError` doesn't flash the "No Reminders"
  /// empty state over a populated list. Loader shows only when nothing
  /// has ever loaded (`null`).
  List<WaterReminder>? _cachedList;

  @override
  void initState() {
    super.initState();
    context.read<WaterReminderCubit>().getReminders(includePast: true);
  }

  DateTime? _parseDate(String iso) =>
      iso.isEmpty ? null : DateTime.tryParse(iso)?.toLocal();

  bool _isDue(WaterReminder r) {
    final d = _parseDate(r.reminderDate);
    return d != null && d.isBefore(DateTime.now()) && r.status == 'pending';
  }

  bool _isActive(WaterReminder r) =>
      r.status == 'pending' ||
      r.status == 'notified' ||
      r.status == 'paused';

  bool _isCompleted(WaterReminder r) =>
      r.status == 'completed' || r.status == 'cancelled';

  void _markComplete(WaterReminder r) =>
      context.read<WaterReminderCubit>().markReminderComplete(reminderId: r.id);

  void _delete(WaterReminder r) {
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
                    fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              context
                  .read<WaterReminderCubit>()
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

  void _edit(WaterReminder r) {
    final cubit = context.read<WaterReminderCubit>();
    Get.toNamed(
      AppRoutes.waterBillRemindersCreate,
      arguments: {'reminder': r},
    )?.then((res) {
      if (res == true && mounted) {
        cubit.getReminders(includePast: true);
      }
    });
  }

  void _payNow(WaterReminder _) {
    // Route back to the water bill landing so the user can pick a provider
    // and repeat the payment. A future iteration could deep-link into the
    // customer-input screen with the reminder's account pre-filled.
    Get.toNamed(AppRoutes.waterBillHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<WaterReminderCubit>();
          Get.toNamed(AppRoutes.waterBillRemindersCreate)?.then((res) {
            if (res == true && mounted) cubit.getReminders(includePast: true);
          });
        },
        backgroundColor: _primary,
        icon: Icon(Icons.add, size: 22.sp),
        label: Text(
          'New Reminder',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocConsumer<WaterReminderCubit, WaterReminderState>(
                listener: (context, state) {
                  if (state is WaterReminderError) {
                    Get.snackbar('Error', state.message,
                        backgroundColor: Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white);
                  } else if (state is WaterReminderDeleted ||
                      state is WaterReminderCompleted) {
                    context
                        .read<WaterReminderCubit>()
                        .getReminders(includePast: true);
                  }
                },
                builder: (context, state) {
                  if (state is WaterRemindersLoaded) {
                    _cachedList = state.reminders;
                  }
                  final list = _cachedList;
                  if (list == null) {
                    return const Center(
                      child: LazerVaultLoader.tiny(),
                    );
                  }
                  if (list.isEmpty) return _buildEmpty();
                  final due = list.where(_isDue).toList();
                  final active = list
                      .where((r) => _isActive(r) && !_isDue(r))
                      .toList();
                  final completed = list.where(_isCompleted).toList();
                  return RefreshIndicator(
                      color: _primary,
                      backgroundColor: const Color(0xFF1F1F1F),
                      onRefresh: () => context
                          .read<WaterReminderCubit>()
                          .getReminders(includePast: true),
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 100.h),
                        children: [
                          if (due.isNotEmpty) ...[
                            _sectionHeader('Due', _accentOrange),
                            SizedBox(height: 12.h),
                            ...due.map((r) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _reminderCard(r, isDue: true),
                                )),
                            SizedBox(height: 24.h),
                          ],
                          if (active.isNotEmpty) ...[
                            _sectionHeader('Upcoming', _primary),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Padding(
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
                  Text(
                    'Water Reminders',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Never miss a water bill',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13.sp,
                    ),
                  ),
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
          Text(
            t,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
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
                    color: Colors.white.withValues(alpha: 0.3), size: 56.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                'No Reminders',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Tap "New Reminder" to schedule a notification before your water bill is due.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _reminderCard(WaterReminder r, {bool isDue = false}) {
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
      payNowLabel: 'Pay Now',
      onPayNow: isDue && !_isCompleted(r) ? () => _payNow(r) : null,
      onMarkComplete: !_isCompleted(r) ? () => _markComplete(r) : null,
      onEdit: !_isCompleted(r) ? () => _edit(r) : null,
      onPause: r.status == 'pending'
          ? () => runReminderStatusChange(
                billType: 'water',
                reminderId: r.id,
                pause: true,
                onSuccessReload: () => context
                    .read<WaterReminderCubit>()
                    .getReminders(includePast: true),
              )
          : null,
      onResume: r.status == 'paused'
          ? () => runReminderStatusChange(
                billType: 'water',
                reminderId: r.id,
                pause: false,
                onSuccessReload: () => context
                    .read<WaterReminderCubit>()
                    .getReminders(includePast: true),
              )
          : null,
      isProcessing: busyReminderId == r.id,
      onDelete: () => _delete(r),
    );
  }
}
