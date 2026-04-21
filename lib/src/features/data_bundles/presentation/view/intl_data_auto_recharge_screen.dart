import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../domain/entities/data_auto_recharge.dart';
import '../cubit/data_auto_recharge_cubit.dart';
import '../cubit/data_auto_recharge_state.dart';

/// International data auto-recharge management. Filters auto-recharges linked
/// to international (country_code != 'NG') beneficiaries. Mirrors
/// DataAutoRechargeScreen but scoped to international entries. The create
/// screen picks from intl data operators/bundles (Reloadly) instead of
/// VTpass variations.
class IntlDataAutoRechargeScreen extends StatefulWidget {
  const IntlDataAutoRechargeScreen({super.key});

  @override
  State<IntlDataAutoRechargeScreen> createState() =>
      _IntlDataAutoRechargeScreenState();
}

class _IntlDataAutoRechargeScreenState
    extends State<IntlDataAutoRechargeScreen> {
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _success = Color(0xFF10B981);

  @override
  void initState() {
    super.initState();
    context.read<DataAutoRechargeCubit>().load();
  }

  /// Filter to only international auto-recharges (country_code != 'NG').
  List<DataAutoRecharge> _filterIntl(List<DataAutoRecharge> all) =>
      all
          .where((ar) =>
              ar.countryCode.isNotEmpty &&
              ar.countryCode.toUpperCase() != 'NG')
          .toList();

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
        title: Text('Intl Data Auto-Recharge',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: [
          IconButton(
            tooltip: 'New Auto-Recharge',
            onPressed: () {
              final cubit = context.read<DataAutoRechargeCubit>();
              Get.toNamed(AppRoutes.intlDataAutoRechargeCreate)?.then((res) {
                if (res == true && mounted) cubit.load();
              });
            },
            icon: Icon(Icons.add, color: _success, size: 22.sp),
          ),
        ],
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
                backgroundColor: _success,
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
                valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
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
          final all = state is DataAutoRechargesLoaded
              ? state.autoRecharges
              : const <DataAutoRecharge>[];
          final list = _filterIntl(all);
          if (list.isEmpty) return _buildEmpty();
          return RefreshIndicator(
            color: _success,
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
              Text('No Intl Auto-Recharges Yet',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Create one from a saved international data contact to schedule recurring data purchases abroad.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () {
                  final cubit = context.read<DataAutoRechargeCubit>();
                  Get.toNamed(
                      AppRoutes.intlDataAutoRechargeCreate)?.then((res) {
                    if (res == true && mounted) cubit.load();
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Auto-Recharge'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _success,
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
      title: ar.networkName.isEmpty
          ? '${ar.countryCode} Data'
          : ar.networkName,
      subtitle: '${ar.countryCode} ${ar.phoneNumber}',
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
      leadingIcon: Icon(Icons.public, color: _primary, size: 20.sp),
      onPause: isActive
          ? () => context.read<DataAutoRechargeCubit>().pause(ar.id)
          : null,
      onResume: !isActive
          ? () => context.read<DataAutoRechargeCubit>().resume(ar.id)
          : null,
      onEdit: () {
        final cubit = context.read<DataAutoRechargeCubit>();
        Get.toNamed(
          AppRoutes.intlDataAutoRechargeCreate,
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
        title: Text('Delete Auto-Recharge',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
            'Are you sure you want to delete this auto-recharge?',
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
