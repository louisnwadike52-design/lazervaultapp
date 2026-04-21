import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_reminder_item.dart';
import '../../domain/entities/education_reminder.dart';
import '../cubit/education_reminder_cubit.dart';
import '../cubit/education_reminder_state.dart';

/// Education exam-date reminders. Reuses the shared BillReminderItem so
/// the row matches airtime / data / cable / internet reminder screens.
class EducationRemindersScreen extends StatefulWidget {
  const EducationRemindersScreen({super.key});

  @override
  State<EducationRemindersScreen> createState() =>
      _EducationRemindersScreenState();
}

class _EducationRemindersScreenState extends State<EducationRemindersScreen> {
  static const Color _accent = Color(0xFFFB923C);

  @override
  void initState() {
    super.initState();
    context.read<EducationReminderCubit>().getReminders(includePast: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20.sp),
        ),
        title: Text('Education Reminders',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<EducationReminderCubit>();
          Get.toNamed(AppRoutes.educationRemindersCreate)?.then((res) {
            if (res == true && mounted) {
              cubit.getReminders(includePast: true);
            }
          });
        },
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('New Reminder',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ),
      body: BlocConsumer<EducationReminderCubit, EducationReminderState>(
        listener: (context, state) {
          if (state is EducationReminderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          } else if (state is EducationReminderDeleted ||
              state is EducationReminderCompleted) {
            context
                .read<EducationReminderCubit>()
                .getReminders(includePast: true);
          }
        },
        builder: (context, state) {
          if (state is EducationReminderLoading ||
              state is EducationReminderInitial) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(_accent),
              ),
            );
          }
          if (state is EducationReminderError) {
            return Center(
              child: Text(state.message,
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            );
          }
          final list = state is EducationRemindersLoaded
              ? state.reminders
              : const <EducationReminder>[];
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: _accent,
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () => context
                .read<EducationReminderCubit>()
                .getReminders(includePast: true),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (_, i) => _buildItem(list[i]),
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmpty() => Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications_none,
                  size: 64.sp, color: const Color(0xFF4B5563)),
              SizedBox(height: 16.h),
              Text('No Reminders Yet',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Tap + to set a reminder for your next exam registration or PIN purchase.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            ],
          ),
        ),
      );

  Widget _buildItem(EducationReminder r) {
    final dt = DateTime.tryParse(r.reminderDate)?.toLocal();
    final isDone = r.status.toLowerCase() == 'completed' ||
        r.status.toLowerCase() == 'done';
    final isPastDue =
        dt != null && !isDone && dt.isBefore(DateTime.now());
    return BillReminderItem(
      title: r.title,
      description:
          r.description?.isNotEmpty == true ? r.description : null,
      amount: r.amount,
      reminderDate: dt ?? DateTime.now(),
      status: r.status,
      isRecurring: r.isRecurring,
      recurrenceType: r.recurrenceType,
      isDue: isPastDue,
      leadingIcon: Icon(
        Icons.school_outlined,
        color: _accent,
        size: 22.sp,
      ),
      onMarkComplete: isDone
          ? null
          : () => context
              .read<EducationReminderCubit>()
              .markReminderComplete(reminderId: r.id),
      onDelete: () => context
          .read<EducationReminderCubit>()
          .deleteReminder(reminderId: r.id),
    );
  }
}
