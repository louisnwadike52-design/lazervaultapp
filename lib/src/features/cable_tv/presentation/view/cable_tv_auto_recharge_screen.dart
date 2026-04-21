import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../domain/entities/cable_tv_auto_recharge.dart';
import '../cubit/cable_tv_auto_recharge_cubit.dart';
import '../cubit/cable_tv_auto_recharge_state.dart';

/// Cable TV auto-renew management. Mirrors `DataAutoRechargeScreen`.
class CableTVAutoRechargeScreen extends StatefulWidget {
  const CableTVAutoRechargeScreen({super.key});

  @override
  State<CableTVAutoRechargeScreen> createState() =>
      _CableTVAutoRechargeScreenState();
}

class _CableTVAutoRechargeScreenState
    extends State<CableTVAutoRechargeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CableTVAutoRechargeCubit>().load();
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
        title: Text('Auto-Renew',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: [
          IconButton(
            tooltip: 'New Auto-Renew',
            onPressed: () {
              final cubit = context.read<CableTVAutoRechargeCubit>();
              Get.toNamed(AppRoutes.cableTVAutoRechargeCreate)?.then((res) {
                if (res == true && mounted) cubit.load();
              });
            },
            icon:
                Icon(Icons.add, color: const Color(0xFF10B981), size: 22.sp),
          ),
        ],
      ),
      body:
          BlocConsumer<CableTVAutoRechargeCubit, CableTVAutoRechargeState>(
        listener: (context, state) {
          if (state is CableTVAutoRechargeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          } else if (state is CableTVAutoRechargeMutated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CableTVAutoRechargesLoading ||
              state is CableTVAutoRechargeInitial) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
              ),
            );
          }
          if (state is CableTVAutoRechargeError) {
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
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp)),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CableTVAutoRechargeCubit>().load(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final list = state is CableTVAutoRechargesLoaded
              ? state.autoRecharges
              : const <CableTVAutoRecharge>[];
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () =>
                context.read<CableTVAutoRechargeCubit>().load(),
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
              Text('No Auto-Renewals Yet',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Create one from a saved smart card, or tap the + button to set up a recurring subscription renewal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () {
                  final cubit = context.read<CableTVAutoRechargeCubit>();
                  Get.toNamed(
                      AppRoutes.cableTVAutoRechargeCreate)?.then((res) {
                    if (res == true && mounted) cubit.load();
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Auto-Renew'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildItem(CableTVAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    return BillAutoRechargeItem(
      title: ar.providerCode.isEmpty ? 'Unknown Provider' : ar.providerCode,
      subtitle: ar.smartCardNumber,
      planName: ar.packageName.isNotEmpty ? ar.packageName : null,
      amount: ar.amount,
      frequency: ar.frequency,
      status: ar.status,
      nextRunDate: ar.nextRunDate.isNotEmpty
          ? DateTime.tryParse(ar.nextRunDate)?.toLocal()
          : null,
      executionHour: ar.executionHour,
      executionMinute: ar.executionMinute,
      failureCount: ar.failureCount,
      leadingIcon: Icon(Icons.live_tv,
          color: const Color(0xFF4E03D0), size: 20.sp),
      onPause: isActive
          ? () => context.read<CableTVAutoRechargeCubit>().pause(ar.id)
          : null,
      onResume: !isActive
          ? () => context.read<CableTVAutoRechargeCubit>().resume(ar.id)
          : null,
      onEdit: () {
        final cubit = context.read<CableTVAutoRechargeCubit>();
        Get.toNamed(
          AppRoutes.cableTVAutoRechargeCreate,
          arguments: {'autoRecharge': ar},
        )?.then((res) {
          if (res == true && mounted) cubit.load();
        });
      },
      onDelete: () => _confirmDelete(ar.id),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Auto-Renew',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text('Are you sure you want to delete this auto-renewal?',
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
              context.read<CableTVAutoRechargeCubit>().delete(id);
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
