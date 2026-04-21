import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../domain/entities/data_auto_recharge.dart';
import '../cubit/data_auto_recharge_cubit.dart';
import '../cubit/data_auto_recharge_state.dart';

/// Data Rollover (auto-recharge) management. Mirrors
/// `AirtimeAutoRechargeScreen`: list with pause/resume/delete + tap-to-edit.
/// Each item is variation-locked (re-buys the same data plan), so the
/// "amount" displayed is informational; editing the variation requires
/// going through `dataBundlesRolloverCreate` for the bound contact.
class DataAutoRechargeScreen extends StatefulWidget {
  const DataAutoRechargeScreen({super.key});

  @override
  State<DataAutoRechargeScreen> createState() =>
      _DataAutoRechargeScreenState();
}

class _DataAutoRechargeScreenState extends State<DataAutoRechargeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DataAutoRechargeCubit>().load();
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
        title: Text('Data Rollover',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<DataAutoRechargeCubit>();
          Get.toNamed(AppRoutes.dataBundlesRolloverCreate)?.then((res) {
            if (res == true && mounted) cubit.load();
          });
        },
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          'New Rollover',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<DataAutoRechargeCubit, DataAutoRechargeState>(
        listener: (context, state) {
          if (state is DataAutoRechargeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          } else if (state is DataAutoRechargeMutated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DataAutoRechargesLoading ||
              state is DataAutoRechargeInitial) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
              ),
            );
          }
          if (state is DataAutoRechargeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      color: const Color(0xFFEF4444), size: 48.sp),
                  SizedBox(height: 16.h),
                  Text(state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<DataAutoRechargeCubit>().load(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final list = state is DataAutoRechargesLoaded
              ? state.autoRecharges
              : const <DataAutoRecharge>[];
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () => context.read<DataAutoRechargeCubit>().load(),
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (_, i) => _buildItem(list[i]),
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
                  'Create one from a saved data contact, or tap the + button to set up a recurring data purchase.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () {
                  final cubit = context.read<DataAutoRechargeCubit>();
                  Get.toNamed(
                      AppRoutes.dataBundlesRolloverCreate)?.then((res) {
                    if (res == true && mounted) cubit.load();
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Rollover'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildItem(DataAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    return BillAutoRechargeItem(
      title: ar.networkName.isEmpty ? 'Unknown Network' : ar.networkName,
      subtitle: ar.phoneNumber,
      planName: ar.planName.isNotEmpty ? ar.planName : null,
      amount: ar.amount,
      frequency: ar.frequency,
      status: ar.status,
      nextRunDate: ar.nextRunDate.isNotEmpty
          ? DateTime.tryParse(ar.nextRunDate)?.toLocal()
          : null,
      createdAt: ar.createdAt.isNotEmpty
          ? DateTime.tryParse(ar.createdAt)?.toLocal()
          : null,
      executionHour: ar.executionHour,
      executionMinute: ar.executionMinute,
      failureCount: ar.failureCount,
      leadingIcon: Icon(Icons.wifi,
          color: const Color(0xFF4E03D0), size: 20.sp),
      onTap: () => _showDetailsDialog(ar),
      onPause: isActive
          ? () => context.read<DataAutoRechargeCubit>().pause(ar.id)
          : null,
      onResume: !isActive
          ? () => context.read<DataAutoRechargeCubit>().resume(ar.id)
          : null,
      onEdit: () {
        final cubit = context.read<DataAutoRechargeCubit>();
        Get.toNamed(
          AppRoutes.dataBundlesRolloverCreate,
          arguments: {'autoRecharge': ar},
        )?.then((res) {
          if (res == true && mounted) cubit.load();
        });
      },
      onDelete: () => _confirmDelete(ar.id),
    );
  }

  void _showDetailsDialog(DataAutoRecharge ar) {
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
              _detailRow('Phone', ar.phoneNumber),
              _detailRow('Network', ar.networkName),
              _detailRow('Amount',
                  '\u20A6${ar.amount.toStringAsFixed(2)} ${ar.currency}'),
              _detailRow('Frequency', ar.frequency),
              if (ar.frequency.toLowerCase() == 'weekly')
                _detailRow('Day of week',
                    _weekdayLabel(ar.dayOfWeek)),
              if (ar.frequency.toLowerCase() == 'monthly')
                _detailRow('Day of month', ar.dayOfMonth.toString()),
              _detailRow('Execution time',
                  '${ar.executionHour.toString().padLeft(2, '0')}:${ar.executionMinute.toString().padLeft(2, '0')}'),
              if (next != null)
                _detailRow('Next run',
                    next.toString().split('.').first),
              if (last != null)
                _detailRow('Last run',
                    last.toString().split('.').first),
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

  void _confirmDelete(String id) {
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
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp))),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<DataAutoRechargeCubit>().delete(id);
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
