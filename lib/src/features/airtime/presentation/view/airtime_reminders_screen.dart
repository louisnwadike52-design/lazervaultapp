import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_reminder_item.dart';
import '../cubit/airtime_reminder_cubit.dart';
import '../cubit/airtime_reminder_state.dart';
import '../cubit/airtime_state.dart' show AirtimeReminder;
import '../widgets/airtime_shimmer.dart';

/// Airtime payment reminders — parity with the electricity reminders screen.
///
/// Relies on a real scheduler in the backend (`AirtimeReminderTimerWorker`
/// uses `time.AfterFunc` to fire at the exact `reminder_date`), so the list
/// here just renders state; it does not drive the firing.
class AirtimeRemindersScreen extends StatefulWidget {
  const AirtimeRemindersScreen({super.key});

  @override
  State<AirtimeRemindersScreen> createState() => _AirtimeRemindersScreenState();
}

class _AirtimeRemindersScreenState extends State<AirtimeRemindersScreen> {
  /// Cached list from the most recent successful load — so post-create/
  /// complete/delete refetches don't flash a full-screen shimmer.
  List<AirtimeReminder>? _cachedList;

  @override
  void initState() {
    super.initState();
    context.read<AirtimeReminderCubit>().getReminders(includePast: true);
  }

  DateTime? _parseDate(String iso) {
    if (iso.isEmpty) return null;
    return DateTime.tryParse(iso)?.toLocal();
  }

  bool _isDue(AirtimeReminder r) {
    final d = _parseDate(r.reminderDate);
    return d != null &&
        d.isBefore(DateTime.now()) &&
        r.status == 'pending';
  }

  bool _isActive(AirtimeReminder r) =>
      r.status == 'pending' || r.status == 'notified';

  bool _isCompleted(AirtimeReminder r) =>
      r.status == 'completed' || r.status == 'cancelled';

  void _markComplete(AirtimeReminder r) {
    context.read<AirtimeReminderCubit>().markReminderComplete(reminderId: r.id);
  }

  void _delete(AirtimeReminder r) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Delete Reminder',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this reminder?',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              context
                  .read<AirtimeReminderCubit>()
                  .deleteReminder(reminderId: r.id);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _edit(AirtimeReminder r) {
    final cubit = context.read<AirtimeReminderCubit>();
    Get.toNamed(
      AppRoutes.airtimeCreateReminder,
      arguments: {'reminder': r},
    )?.then((res) {
      if (res == true && mounted) {
        cubit.getReminders(includePast: true);
      }
    });
  }

  void _payNow(AirtimeReminder r) {
    // Send the user into the normal airtime purchase flow.
    Get.toNamed(AppRoutes.airtimePurchase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<AirtimeReminderCubit>();
          Get.toNamed(AppRoutes.airtimeCreateReminder)?.then((result) {
            if (result == true && mounted) {
              cubit.getReminders(includePast: true);
            }
          });
        },
        backgroundColor: const Color(0xFF10B981),
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
              child: BlocConsumer<AirtimeReminderCubit, AirtimeReminderState>(
                listener: (context, state) {
                  if (state is AirtimeReminderError) {
                    Get.snackbar(
                      'Error',
                      state.message,
                      backgroundColor:
                          Colors.red.withValues(alpha: 0.9),
                      colorText: Colors.white,
                    );
                  } else if (state is AirtimeReminderDeleted) {
                    Get.snackbar(
                      'Success',
                      state.message,
                      backgroundColor:
                          const Color(0xFF10B981).withValues(alpha: 0.9),
                      colorText: Colors.white,
                    );
                    context
                        .read<AirtimeReminderCubit>()
                        .getReminders(includePast: true);
                  } else if (state is AirtimeReminderCompleted) {
                    Get.snackbar(
                      'Success',
                      state.message,
                      backgroundColor:
                          const Color(0xFF10B981).withValues(alpha: 0.9),
                      colorText: Colors.white,
                    );
                    context
                        .read<AirtimeReminderCubit>()
                        .getReminders(includePast: true);
                  }
                },
                builder: (context, state) {
                  if (state is AirtimeRemindersLoaded) {
                    _cachedList = state.reminders;
                  }
                  final list = _cachedList;
                  if (list == null) {
                    return AirtimeAutoRechargeShimmer(itemCount: 4);
                  }
                  if (list.isEmpty) return _buildEmpty();
                  {
                    final active = list
                        .where((r) => _isActive(r) && !_isDue(r))
                        .toList();
                    final due = list.where((r) => _isDue(r)).toList();
                    final completed = list.where(_isCompleted).toList();

                    return RefreshIndicator(
                      color: const Color(0xFF10B981),
                      onRefresh: () async {
                        await context
                            .read<AirtimeReminderCubit>()
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
                            _sectionHeader(
                                'Upcoming', const Color(0xFF10B981)),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
                  color: Colors.white.withValues(alpha: 0.15),
                ),
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
                  'Airtime Reminders',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Never miss a top-up',
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
  }

  Widget _sectionHeader(String title, Color color) => Row(
        children: [
          Container(
            width: 4.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );

  Widget _buildEmpty() {
    return Center(
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
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 2,
                ),
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
              'Tap "New Reminder" to schedule a top-up nudge. Reminders notify you across every channel — push, email, SMS — so you never miss one.',
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
  }

  Widget _reminderCard(AirtimeReminder r, {bool isDue = false}) {
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
      payNowLabel: 'Top up now',
      onPayNow: isDue && !_isCompleted(r) ? () => _payNow(r) : null,
      onMarkComplete: !_isCompleted(r) ? () => _markComplete(r) : null,
      onEdit: !_isCompleted(r) ? () => _edit(r) : null,
      onDelete: () => _delete(r),
    );
  }
}
