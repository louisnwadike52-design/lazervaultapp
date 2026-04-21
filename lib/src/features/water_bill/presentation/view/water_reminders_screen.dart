import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/water_reminder.dart';
import '../cubit/water_reminder_cubit.dart';
import '../cubit/water_reminder_state.dart';

/// Water bill reminders. Simple list with mark-complete + delete actions
/// and a bottom-right FAB to create a new reminder.
class WaterRemindersScreen extends StatefulWidget {
  const WaterRemindersScreen({super.key});

  @override
  State<WaterRemindersScreen> createState() => _WaterRemindersScreenState();
}

class _WaterRemindersScreenState extends State<WaterRemindersScreen> {
  static const Color _accent = Color(0xFFFB923C);

  @override
  void initState() {
    super.initState();
    context.read<WaterReminderCubit>().getReminders(includePast: true);
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
        title: Text('Water Reminders',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<WaterReminderCubit>();
          Get.toNamed(AppRoutes.waterBillRemindersCreate)?.then((res) {
            if (res == true && mounted) {
              cubit.getReminders(includePast: true);
            }
          });
        },
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('New Reminder',
            style: TextStyle(
                fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ),
      body: BlocConsumer<WaterReminderCubit, WaterReminderState>(
        listener: (context, state) {
          if (state is WaterReminderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          } else if (state is WaterReminderDeleted ||
              state is WaterReminderCompleted) {
            context
                .read<WaterReminderCubit>()
                .getReminders(includePast: true);
          }
        },
        builder: (context, state) {
          if (state is WaterReminderLoading ||
              state is WaterReminderInitial) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(_accent),
              ),
            );
          }
          if (state is WaterReminderError) {
            return Center(
              child: Text(state.message,
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            );
          }
          final list = state is WaterRemindersLoaded
              ? state.reminders
              : const <WaterReminder>[];
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: _accent,
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () => context
                .read<WaterReminderCubit>()
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
                  'Tap + to set a reminder for your next water bill so you never miss a due date.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            ],
          ),
        ),
      );

  Widget _buildItem(WaterReminder r) {
    final dt = DateTime.tryParse(r.reminderDate)?.toLocal();
    final dateLabel = dt != null
        ? DateFormat('MMM dd, yyyy \u00B7 hh:mm a').format(dt)
        : r.reminderDate;
    final isDone = r.status.toLowerCase() == 'completed' ||
        r.status.toLowerCase() == 'done';
    final statusColor = isDone
        ? const Color(0xFF10B981)
        : (r.status.toLowerCase() == 'pending'
            ? _accent
            : const Color(0xFF9CA3AF));
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          left: BorderSide(color: _accent, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  r.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      decoration: isDone ? TextDecoration.lineThrough : null),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(r.status.toUpperCase(),
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 13.sp, color: const Color(0xFF9CA3AF)),
              SizedBox(width: 6.w),
              Text(dateLabel,
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
            ],
          ),
          if (r.description?.isNotEmpty == true) ...[
            SizedBox(height: 6.h),
            Text(r.description!,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          ],
          if (r.amount != null && r.amount! > 0) ...[
            SizedBox(height: 6.h),
            Text('Amount: \u20A6${r.amount!.toStringAsFixed(2)}',
                style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
          ],
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isDone)
                _iconAction(Icons.check_circle_outline,
                    const Color(0xFF10B981), 'Mark done', () {
                  context
                      .read<WaterReminderCubit>()
                      .markReminderComplete(reminderId: r.id);
                }),
              SizedBox(width: 8.w),
              _iconAction(Icons.delete_outline, const Color(0xFFEF4444),
                  'Delete', () {
                context
                    .read<WaterReminderCubit>()
                    .deleteReminder(reminderId: r.id);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconAction(
      IconData icon, Color color, String tooltip, VoidCallback onTap) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: color, size: 16.sp),
        ),
      ),
    );
  }
}
