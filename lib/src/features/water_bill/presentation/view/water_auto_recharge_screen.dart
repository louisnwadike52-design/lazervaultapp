import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../domain/entities/water_auto_recharge.dart';
import '../cubit/water_auto_recharge_cubit.dart';
import '../cubit/water_auto_recharge_state.dart';

/// Water Auto-Pay management. Mirrors the data-bundles and airtime
/// rollover lists: list via `BillAutoRechargeItem`, bottom-right FAB
/// for "New Auto-Pay", pause/resume/edit/delete actions.
class WaterAutoRechargeScreen extends StatefulWidget {
  const WaterAutoRechargeScreen({super.key});

  @override
  State<WaterAutoRechargeScreen> createState() =>
      _WaterAutoRechargeScreenState();
}

class _WaterAutoRechargeScreenState extends State<WaterAutoRechargeScreen> {
  static const Color _primary = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<WaterAutoRechargeCubit>().load();
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
        title: Text('Water Auto-Pay',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<WaterAutoRechargeCubit>();
          Get.toNamed(AppRoutes.waterBillAutoRechargeCreate)?.then((res) {
            if (res == true && mounted) cubit.load();
          });
        },
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('New Auto-Pay',
            style: TextStyle(
                fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ),
      body: BlocConsumer<WaterAutoRechargeCubit, WaterAutoRechargeState>(
        listener: (context, state) {
          if (state is WaterAutoRechargeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          } else if (state is WaterAutoRechargeMutated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WaterAutoRechargesLoading ||
              state is WaterAutoRechargeInitial) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
              ),
            );
          }
          if (state is WaterAutoRechargeError) {
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
                        context.read<WaterAutoRechargeCubit>().load(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final list = state is WaterAutoRechargesLoaded
              ? state.autoRecharges
              : const <WaterAutoRecharge>[];
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () => context.read<WaterAutoRechargeCubit>().load(),
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
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
              Text('No Auto-Pay Yet',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Create one from a saved water account, or tap the + button to set up a recurring water bill payment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            ],
          ),
        ),
      );

  Widget _buildItem(WaterAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    final title = ar.beneficiary?.nickname?.isNotEmpty == true
        ? ar.beneficiary!.nickname!
        : ar.accountNumber;
    final providerName = ar.beneficiary?.providerName.isNotEmpty == true
        ? ar.beneficiary!.providerName
        : ar.providerCode;
    return BillAutoRechargeItem(
      title: providerName,
      subtitle: '$title \u00B7 ${ar.accountNumber}',
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
      leadingIcon: Icon(Icons.water_drop, color: _primary, size: 20.sp),
      onTap: () => _showDetailsDialog(ar),
      onPause: isActive
          ? () => context.read<WaterAutoRechargeCubit>().pause(ar.id)
          : null,
      onResume: !isActive
          ? () => context.read<WaterAutoRechargeCubit>().resume(ar.id)
          : null,
      onEdit: () {
        final cubit = context.read<WaterAutoRechargeCubit>();
        Get.toNamed(
          AppRoutes.waterBillAutoRechargeCreate,
          arguments: {'autoRecharge': ar},
        )?.then((res) {
          if (res == true && mounted) cubit.load();
        });
      },
      onDelete: () => _confirmDelete(ar.id),
    );
  }

  void _showDetailsDialog(WaterAutoRecharge ar) {
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
        contentPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
        title: Row(
          children: [
            Expanded(
              child: Text('Water Auto-Pay',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(ar.status.toUpperCase(),
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow('Account', ar.accountNumber),
              if (ar.beneficiary?.providerName.isNotEmpty == true)
                _detailRow('Provider', ar.beneficiary!.providerName),
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
              _detailRow('Failures', '${ar.failureCount} / ${ar.maxRetries}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Close',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
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
            child: Text(label,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  String _weekdayLabel(int dow) {
    const names = [
      '—',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    if (dow >= 1 && dow <= 7) return names[dow];
    return dow.toString();
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Auto-Pay?',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          'This will cancel the recurring water-bill payment. This cannot be undone.',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<WaterAutoRechargeCubit>().delete(id);
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
