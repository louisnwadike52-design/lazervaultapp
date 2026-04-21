import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../domain/entities/internet_auto_recharge.dart';
import '../cubit/internet_auto_recharge_cubit.dart';
import '../cubit/internet_auto_recharge_state.dart';

/// Internet "Rollover" (auto-recharge) management. Mirrors
/// `DataAutoRechargeScreen`: list with pause/resume/delete + tap to
/// view details. Each row is package-locked (re-buys the same ISP
/// package), so the displayed amount is informational and editing the
/// package requires going through the payment confirm screen.
class InternetRolloverScreen extends StatefulWidget {
  const InternetRolloverScreen({super.key});

  @override
  State<InternetRolloverScreen> createState() =>
      _InternetRolloverScreenState();
}

class _InternetRolloverScreenState extends State<InternetRolloverScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<InternetAutoRechargeCubit>()..load(),
      child: Builder(builder: (ctx) => _buildScaffold(ctx)),
    );
  }

  Widget _buildScaffold(BuildContext context) {
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
        title: Text('Internet Rollover',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
        elevation: 2,
        icon: const Icon(Icons.autorenew),
        label: Text(
          'New Rollover',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () async {
          final created = await Get.toNamed(
            AppRoutes.internetBillRolloverCreate,
          );
          // The create screen pops with `true` on successful save.
          // Refresh the list so the new row appears without a manual
          // pull-to-refresh. No-op when user backed out.
          if (created == true && context.mounted) {
            context.read<InternetAutoRechargeCubit>().load();
          }
        },
      ),
      body:
          BlocConsumer<InternetAutoRechargeCubit, InternetAutoRechargeState>(
        listener: (context, state) {
          if (state is InternetAutoRechargeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          } else if (state is InternetAutoRechargeMutated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is InternetAutoRechargesLoading ||
              state is InternetAutoRechargeInitial) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
              ),
            );
          }
          if (state is InternetAutoRechargeError) {
            return _buildError(context, state.message);
          }
          final list = state is InternetAutoRechargesLoaded
              ? state.autoRecharges
              : const <InternetAutoRecharge>[];
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () =>
                context.read<InternetAutoRechargeCubit>().load(),
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (_, i) => _buildItem(context, list[i]),
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
              Icon(Icons.autorenew,
                  size: 64.sp, color: const Color(0xFF4B5563)),
              SizedBox(height: 16.h),
              Text('No Rollovers Yet',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Schedule a recurring internet purchase for a saved ISP contact. Tap "New Rollover" below to pick a contact and package.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF9CA3AF))),
              SizedBox(height: 24.h),
              Builder(
                builder: (ctx) => ElevatedButton.icon(
                  onPressed: () async {
                    final created = await Get.toNamed(
                      AppRoutes.internetBillRolloverCreate,
                    );
                    if (created == true && ctx.mounted) {
                      ctx.read<InternetAutoRechargeCubit>().load();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('New Rollover'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildItem(BuildContext context, InternetAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    return BillAutoRechargeItem(
      title: ar.providerName.isEmpty ? 'Unknown ISP' : ar.providerName,
      subtitle: ar.accountNumber,
      planName: ar.planName.isNotEmpty ? ar.planName : null,
      amount: ar.amount,
      frequency: ar.frequency,
      status: ar.status,
      nextRunDate: ar.nextRunDate.isNotEmpty
          ? DateTime.tryParse(ar.nextRunDate)?.toLocal()
          : null,
      executionHour: ar.executionHour,
      executionMinute: ar.executionMinute,
      failureCount: ar.failureCount,
      leadingIcon: Icon(Icons.wifi,
          color: const Color(0xFF4E03D0), size: 20.sp),
      onTap: () => _showDetailsDialog(context, ar),
      onPause: isActive
          ? () => context.read<InternetAutoRechargeCubit>().pause(ar.id)
          : null,
      onResume: !isActive
          ? () => context.read<InternetAutoRechargeCubit>().resume(ar.id)
          : null,
      onEdit: () {
        Get.snackbar(
          'Edit on confirm',
          'Package is locked — edit the schedule by pausing this rollover and setting up a new one on your next purchase.',
          backgroundColor:
              const Color(0xFF4E03D0).withValues(alpha: 0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      },
      onDelete: () => _confirmDelete(context, ar.id),
    );
  }

  void _showDetailsDialog(BuildContext context, InternetAutoRecharge ar) {
    final next = ar.nextRunDate.isNotEmpty
        ? DateTime.tryParse(ar.nextRunDate)?.toLocal()
        : null;
    final last = ar.lastRunDate != null
        ? DateTime.tryParse(ar.lastRunDate!)?.toLocal()
        : null;
    final statusColor = ar.status.toLowerCase() == 'active'
        ? const Color(0xFF10B981)
        : (ar.status.toLowerCase() == 'paused'
            ? const Color(0xFFFB923C)
            : const Color(0xFFEF4444));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
        contentPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
        title: Row(
          children: [
            Expanded(
              child: Text(
                ar.planName.isNotEmpty ? ar.planName : 'Rollover',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                ar.status.toUpperCase(),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow('Account', ar.accountNumber),
              _detailRow('Provider', ar.providerName),
              _detailRow('Amount',
                  '\u20A6${ar.amount.toStringAsFixed(2)} ${ar.currency}'),
              _detailRow('Frequency', ar.frequency),
              if (ar.frequency.toLowerCase() == 'weekly')
                _detailRow('Day of week', _weekdayLabel(ar.dayOfWeek)),
              if (ar.frequency.toLowerCase() == 'monthly')
                _detailRow('Day of month', ar.dayOfMonth.toString()),
              _detailRow('Execution time',
                  '${ar.executionHour.toString().padLeft(2, '0')}:${ar.executionMinute.toString().padLeft(2, '0')}'),
              if (next != null)
                _detailRow('Next run', next.toString().split('.').first),
              if (last != null)
                _detailRow('Last run', last.toString().split('.').first),
              _detailRow('Failures',
                  '${ar.failureCount} / ${ar.maxRetries}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Close',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _weekdayLabel(int day) {
    const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    if (day < 0 || day > 6) return day.toString();
    return labels[day];
  }

  Widget _buildError(BuildContext context, String msg) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 40.sp),
          SizedBox(height: 10.h),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13.sp),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () =>
                context.read<InternetAutoRechargeCubit>().load(),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    final cubit = context.read<InternetAutoRechargeCubit>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Rollover',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text('Are you sure you want to delete this rollover?',
            style: TextStyle(
                color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancel',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp))),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              cubit.delete(id);
            },
            child: Text('Delete',
                style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
