import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get_it/get_it.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_reminder_item.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../../domain/entities/data_reminder.dart';
import '../cubit/data_reminder_cubit.dart';
import '../cubit/data_reminder_state.dart';

/// Data-bundle reminders. Mirrors `AirtimeRemindersScreen`: due / upcoming
/// / completed sections, mark-complete and delete actions, FAB to create
/// new reminders. The backend `DataReminderTimerWorker` (`time.AfterFunc`)
/// fires notifications at the exact `reminder_date`.
class DataRemindersScreen extends StatefulWidget {
  const DataRemindersScreen({super.key});

  @override
  State<DataRemindersScreen> createState() => _DataRemindersScreenState();
}

class _DataRemindersScreenState extends State<DataRemindersScreen> {
  /// id → beneficiary lookup for the "Contact: …" chip on each row.
  /// Loaded once on entry; non-fatal on failure (rows fall back to the
  /// raw beneficiary id / hide the chip).
  Map<String, DataBeneficiary> _contactsById = const {};

  @override
  void initState() {
    super.initState();
    context.read<DataReminderCubit>().getReminders(includePast: true);
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final ds = GetIt.I<DataBeneficiaryRemoteDataSource>();
      final list = await ds.getBeneficiaries();
      if (!mounted) return;
      setState(() => _contactsById = {for (final b in list) b.id: b});
    } catch (_) {
      // Ignore — chip just won't render for unresolved ids.
    }
  }

  /// Display string for the "Contact: …" chip on a reminder row.
  /// Prefers nickname, then phone; null when the reminder has no link.
  String? _linkedContactLabel(DataReminder r) {
    if (r.beneficiaryId.isEmpty) return null;
    final b = _contactsById[r.beneficiaryId];
    if (b == null) return null;
    if (b.nickname != null && b.nickname!.trim().isNotEmpty) {
      return b.nickname!;
    }
    return b.phoneNumber;
  }

  DateTime? _parseDate(String iso) =>
      iso.isEmpty ? null : DateTime.tryParse(iso)?.toLocal();

  bool _isDue(DataReminder r) {
    final d = _parseDate(r.reminderDate);
    return d != null && d.isBefore(DateTime.now()) && r.status == 'pending';
  }

  bool _isActive(DataReminder r) =>
      r.status == 'pending' || r.status == 'notified';

  bool _isCompleted(DataReminder r) =>
      r.status == 'completed' || r.status == 'cancelled';

  void _markComplete(DataReminder r) =>
      context.read<DataReminderCubit>().markReminderComplete(reminderId: r.id);

  void _delete(DataReminder r) {
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
              context.read<DataReminderCubit>().deleteReminder(reminderId: r.id);
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

  void _edit(DataReminder r) {
    final cubit = context.read<DataReminderCubit>();
    Get.toNamed(
      AppRoutes.dataBundlesReminderCreate,
      arguments: {'reminder': r},
    )?.then((res) {
      if (res == true && mounted) {
        cubit.getReminders(includePast: true);
      }
    });
  }

  void _payNow(DataReminder r) {
    Get.toNamed(AppRoutes.dataBundlesHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<DataReminderCubit>();
          Get.toNamed(AppRoutes.dataBundlesReminderCreate)?.then((res) {
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
              child: BlocConsumer<DataReminderCubit, DataReminderState>(
                listener: (context, state) {
                  if (state is DataReminderError) {
                    Get.snackbar('Error', state.message,
                        backgroundColor:
                            Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white);
                  } else if (state is DataReminderDeleted ||
                      state is DataReminderCompleted) {
                    final msg = (state is DataReminderDeleted)
                        ? state.message
                        : (state as DataReminderCompleted).message;
                    Get.snackbar('Success', msg,
                        backgroundColor:
                            const Color(0xFF10B981).withValues(alpha: 0.9),
                        colorText: Colors.white);
                    context
                        .read<DataReminderCubit>()
                        .getReminders(includePast: true);
                  }
                },
                builder: (context, state) {
                  if (state is DataReminderLoading ||
                      state is DataReminderInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation(Color(0xFF4E03D0)),
                      ),
                    );
                  }
                  if (state is DataRemindersLoaded) {
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
                            .read<DataReminderCubit>()
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
                  Text('Data Reminders',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700)),
                  Text('Never run out of data',
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
                'Tap "New Reminder" to schedule a data top-up nudge before your bundle expires.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );

  Widget _reminderCard(DataReminder r, {bool isDue = false}) {
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
      // Surface the linked contact so users remember which saved
      // beneficiary a reminder is wired to — without the chip they
      // had to open Edit to find out.
      linkedContactLabel: _linkedContactLabel(r),
      payNowLabel: 'Buy Data Now',
      onPayNow: isDue && !_isCompleted(r) ? () => _payNow(r) : null,
      onMarkComplete: !_isCompleted(r) ? () => _markComplete(r) : null,
      onEdit: !_isCompleted(r) ? () => _edit(r) : null,
      onDelete: () => _delete(r),
    );
  }
}
