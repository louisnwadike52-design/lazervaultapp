import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/reminder_cubit.dart';
import '../cubit/reminder_state.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReminderCubit>().getReminders();
  }

  void _markAsComplete(PaymentReminderEntity reminder) {
    context.read<ReminderCubit>().markReminderComplete(reminderId: reminder.id);
  }

  void _payNowReminder(PaymentReminderEntity reminder) {
    if (reminder.hasBeneficiary) {
      // Navigate to electricity bill home where the beneficiary flow will handle it
      Get.toNamed(
        AppRoutes.electricityBillHome,
        arguments: {'fromReminder': true, 'beneficiaryId': reminder.beneficiaryId},
      );
    } else {
      // No beneficiary linked, go to electricity bill home to start fresh
      Get.toNamed(AppRoutes.electricityBillHome);
    }
  }

  void _deleteReminder(PaymentReminderEntity reminder) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
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
            fontWeight: FontWeight.w400,
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
              context.read<ReminderCubit>().deleteReminder(reminderId: reminder.id);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF5350),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocConsumer<ReminderCubit, ReminderState>(
                  listener: (context, state) {
                    if (state is ReminderError) {
                      Get.snackbar(
                        'Error',
                        state.message,
                        backgroundColor: Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                    }

                    if (state is ReminderDeleted) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<ReminderCubit>().getReminders();
                    }

                    if (state is ReminderCompleted) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<ReminderCubit>().getReminders();
                    }
                  },
                  builder: (context, state) {
                    if (state is ReminderLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
                      );
                    }

                    if (state is RemindersLoaded) {
                      if (state.reminders.isEmpty) {
                        return _buildEmptyState();
                      }

                      // Separate upcoming and past reminders
                      final active = state.reminders
                          .where((r) => r.isActive && !r.isDue)
                          .toList();
                      final due = state.reminders
                          .where((r) => r.isActive && r.isDue)
                          .toList();
                      final completed = state.reminders
                          .where((r) => r.isCompleted)
                          .toList();

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<ReminderCubit>().getReminders();
                        },
                        color: const Color(0xFF4E03D0),
                        child: ListView(
                          padding: EdgeInsets.all(20.w),
                          children: [
                            if (due.isNotEmpty) ...[
                              _buildSectionHeader('Due Reminders', Colors.orange),
                              SizedBox(height: 12.h),
                              ...due.map((r) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: _buildReminderCard(r, isDue: true),
                                  )),
                              SizedBox(height: 24.h),
                            ],
                            if (active.isNotEmpty) ...[
                              _buildSectionHeader('Upcoming Reminders', const Color(0xFF4E03D0)),
                              SizedBox(height: 12.h),
                              ...active.map((r) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: _buildReminderCard(r),
                                  )),
                            ],
                            if (completed.isNotEmpty) ...[
                              if (active.isNotEmpty || due.isNotEmpty) SizedBox(height: 24.h),
                              _buildSectionHeader('Completed', Colors.grey),
                              SizedBox(height: 12.h),
                              ...completed.map((r) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: _buildReminderCard(r),
                                  )),
                            ],
                          ],
                        ),
                      );
                    }

                    return _buildEmptyState();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.electricityBillCreateReminder);
        },
        backgroundColor: const Color(0xFF4E03D0),
        icon: Icon(Icons.add, size: 24.sp),
        label: Text(
          'New Reminder',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
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
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Reminders',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Never miss a payment',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
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
  }

  Widget _buildEmptyState() {
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
              child: Icon(
                Icons.notifications_none,
                color: Colors.white.withValues(alpha: 0.3),
                size: 56.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Reminders',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Set up reminders to never miss\nyour electricity bill payments',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(PaymentReminderEntity reminder, {bool isDue = false}) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDue
              ? const Color(0xFFFFA726)
              : reminder.isCompleted
                  ? Colors.grey.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
          width: isDue ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: _getStatusColor(reminder.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  reminder.isCompleted
                      ? Icons.check_circle
                      : isDue
                          ? Icons.notification_important
                          : Icons.notifications_active,
                  color: _getStatusColor(reminder.status),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        decoration: reminder.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      reminder.description,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(reminder.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  reminder.status.displayName,
                  style: GoogleFonts.inter(
                    color: _getStatusColor(reminder.status),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  Icons.calendar_today,
                  dateFormat.format(reminder.reminderDate),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildInfoChip(
                  Icons.access_time,
                  timeFormat.format(reminder.reminderDate),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  Icons.repeat,
                  reminder.recurrenceDescription,
                ),
              ),
              if (reminder.hasAmount) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildInfoChip(
                    Icons.attach_money,
                    '₦${reminder.amount!.toStringAsFixed(0)}',
                  ),
                ),
              ],
            ],
          ),
          if (isDue && !reminder.isCompleted) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA726).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: const Color(0xFFFFA726),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'This reminder is due!',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFFA726),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => _payNowReminder(reminder),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF4E03D0), const Color(0xFF6B21E0)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text('Pay Now',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              if (!reminder.isCompleted)
                Expanded(
                  child: GestureDetector(
                    onTap: () => _markAsComplete(reminder),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: const Color(0xFF4CAF50),
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Mark Complete',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF4CAF50),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (!reminder.isCompleted) SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => _deleteReminder(reminder),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF5350).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFEF5350),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: const Color(0xFFEF5350),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.6),
            size: 14.sp,
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(ReminderStatus status) {
    switch (status) {
      case ReminderStatus.active:
        return const Color(0xFF4E03D0);
      case ReminderStatus.completed:
        return const Color(0xFF4CAF50);
      case ReminderStatus.cancelled:
        return const Color(0xFF9E9E9E);
    }
  }
}
