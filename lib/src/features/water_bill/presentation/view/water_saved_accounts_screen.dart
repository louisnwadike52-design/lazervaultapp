import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../domain/entities/water_auto_recharge.dart';
import '../../domain/entities/water_beneficiary.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../cubit/water_auto_recharge_cubit.dart';
import '../cubit/water_auto_recharge_state.dart';
import '../cubit/water_beneficiary_cubit.dart';
import '../cubit/water_beneficiary_state.dart';

/// Saved water accounts. Mirrors the internet / data-bundles saved-contacts
/// UX: list + tap-for-options + delete-with-rollover warning. Options:
/// View Details, View Purchases, Pay Bill, Set/Edit Auto-Pay, Edit
/// Nickname, Delete.
class WaterSavedAccountsScreen extends StatefulWidget {
  const WaterSavedAccountsScreen({super.key});

  @override
  State<WaterSavedAccountsScreen> createState() =>
      _WaterSavedAccountsScreenState();
}

class _WaterSavedAccountsScreenState extends State<WaterSavedAccountsScreen> {
  List<WaterBeneficiary>? _beneficiaries;
  List<WaterAutoRecharge> _autoRecharges = const [];
  bool _loading = true;
  String? _error;

  static const Color _primary = Color(0xFF4E03D0);

  WaterAutoRecharge? _autoFor(WaterBeneficiary b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
  }

  List<WaterAutoRecharge> _autosFor(WaterBeneficiary b) =>
      _autoRecharges.where((ar) => ar.beneficiaryId == b.id).toList();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WaterBeneficiaryCubit>(
          create: (_) => GetIt.I<WaterBeneficiaryCubit>()..load(),
        ),
        BlocProvider<WaterAutoRechargeCubit>(
          create: (_) => GetIt.I<WaterAutoRechargeCubit>()..load(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
          ),
          title: Text('Saved Water Accounts',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          actions: [
            IconButton(
              tooltip: 'Reminders',
              onPressed: () => Get.toNamed(AppRoutes.waterBillReminders),
              icon: Icon(Icons.notifications_outlined,
                  color: const Color(0xFFFB923C), size: 22.sp),
            ),
            IconButton(
              tooltip: 'Auto-Pay',
              onPressed: () => Get.toNamed(AppRoutes.waterBillAutoRecharge),
              icon: Icon(Icons.autorenew, color: _primary, size: 22.sp),
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<WaterBeneficiaryCubit, WaterBeneficiaryState>(
              listener: (context, state) {
                if (!mounted) return;
                if (state is WaterBeneficiariesLoading) {
                  setState(() {
                    _loading = true;
                    _error = null;
                  });
                } else if (state is WaterBeneficiariesLoaded) {
                  setState(() {
                    _beneficiaries = state.beneficiaries;
                    _loading = false;
                    _error = null;
                  });
                } else if (state is WaterBeneficiaryError) {
                  setState(() {
                    _loading = false;
                    _error = state.message;
                  });
                }
              },
            ),
            BlocListener<WaterAutoRechargeCubit, WaterAutoRechargeState>(
              listener: (context, state) {
                if (!mounted) return;
                if (state is WaterAutoRechargesLoaded) {
                  setState(() => _autoRecharges = state.autoRecharges);
                }
              },
            ),
          ],
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null &&
        (_beneficiaries == null || _beneficiaries!.isEmpty)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 16.h),
            Text(_error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.read<WaterBeneficiaryCubit>().load(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (_loading && _beneficiaries == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(_primary),
        ),
      );
    }
    final list = _beneficiaries ?? const [];
    if (list.isEmpty) return _buildEmpty();
    return RefreshIndicator(
      color: _primary,
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () async {
        await Future.wait([
          context.read<WaterBeneficiaryCubit>().load(),
          context.read<WaterAutoRechargeCubit>().load(),
        ]);
      },
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (_, i) => _buildItem(list[i]),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined,
                size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No saved water accounts yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'After paying your water bill, tap "Save Contact" on the receipt to add the account here for one-tap repeat purchases.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(WaterBeneficiary b) {
    final autos = _autosFor(b);
    return BillBeneficiaryItem(
      displayName:
          (b.nickname?.isNotEmpty == true) ? b.nickname! : b.accountNumber,
      identifier: b.accountNumber,
      providerName: b.providerName,
      providerColor: _primary,
      lastPlanOrAmount: (b.lastAmount != null && b.lastAmount! > 0)
          ? '\u20A6${b.lastAmount!.toStringAsFixed(0)}'
          : null,
      usageCount: b.topupCount,
      trailing: autos.isNotEmpty
          ? GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _openAutoRechargeEditor(b, autos),
              child: _autosBadge(autos),
            )
          : null,
      onTap: () => _showOptions(b),
      onLongPress: () => _confirmDelete(b),
      flat: true,
      leftAccentColor: _primary,
    );
  }

  Widget _autosBadge(List<WaterAutoRecharge> autos) {
    if (autos.length == 1) return _autoBadge(autos.first);
    final anyActive = autos.any((ar) => ar.status.toLowerCase() == 'active');
    final anyPaused = autos.any((ar) => ar.status.toLowerCase() == 'paused');
    final color = anyActive
        ? const Color(0xFF10B981)
        : (anyPaused
            ? const Color(0xFFFB923C)
            : const Color(0xFF9CA3AF));
    return _pill(color, 'Auto \u00D7${autos.length}');
  }

  Widget _autoBadge(WaterAutoRecharge ar) {
    final color = ar.status.toLowerCase() == 'active'
        ? const Color(0xFF10B981)
        : const Color(0xFFFB923C);
    return _pill(color, 'Auto');
  }

  Widget _pill(Color color, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.autorenew, size: 12.sp, color: color),
          SizedBox(width: 4.w),
          Text(label,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
    );
  }

  void _openAutoRechargeEditor(
      WaterBeneficiary b, List<WaterAutoRecharge> autos) async {
    if (autos.isEmpty) {
      Get.toNamed(
        AppRoutes.waterBillAutoRechargeCreate,
        arguments: {'beneficiary': b, 'locked': true},
      )?.then((_) {
        if (mounted) context.read<WaterAutoRechargeCubit>().load();
      });
      return;
    }
    if (autos.length == 1) {
      _navigateEditAutoRecharge(b, autos.first);
      return;
    }
    final picked = await showModalBottomSheet<WaterAutoRecharge>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                    color: const Color(0xFF4B5563),
                    borderRadius: BorderRadius.circular(2.r)),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('Edit which auto-pay?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 8.h),
              for (final ar in autos)
                ListTile(
                  leading: Icon(Icons.autorenew,
                      color: ar.status.toLowerCase() == 'active'
                          ? const Color(0xFF10B981)
                          : const Color(0xFFFB923C)),
                  title: Text(
                      '\u20A6${ar.amount.toStringAsFixed(0)} \u00B7 ${ar.frequency}',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                  subtitle: Text(ar.status.toUpperCase(),
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                  trailing: Icon(Icons.chevron_right,
                      color: const Color(0xFF6B7280), size: 20.sp),
                  onTap: () => Navigator.of(ctx).pop(ar),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) _navigateEditAutoRecharge(b, picked);
  }

  void _navigateEditAutoRecharge(WaterBeneficiary b, WaterAutoRecharge ar) {
    Get.toNamed(
      AppRoutes.waterBillAutoRechargeCreate,
      arguments: {'autoRecharge': ar, 'beneficiary': b},
    )?.then((_) {
      if (mounted) context.read<WaterAutoRechargeCubit>().load();
    });
  }

  void _showOptions(WaterBeneficiary b) {
    // Shared item-options sheet — same visual as data / cable TV
    // saved-contacts sheets. Single source: BillHistoryActionsSheet.
    final autos = _autosFor(b);
    final hasAuto = autos.isNotEmpty;
    BillHistoryActionsSheet.show(
      context,
      title: b.nickname?.isNotEmpty == true ? b.nickname! : b.accountNumber,
      subtitle: '${b.providerName} · ${b.accountNumber}',
      actions: [
        BillHistoryAction(
          icon: Icons.info_outline,
          color: _primary,
          label: 'View Details',
          onTap: () {
            Get.back();
            _showDetailsDialog(b, _autosFor(b));
          },
        ),
        BillHistoryAction(
          icon: Icons.history,
          color: const Color(0xFF9CA3AF),
          label: 'View Payments',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.waterBillHistory,
              arguments: {
                'accountNumber': b.accountNumber,
                'providerCode': b.providerCode,
              },
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.water_drop,
          color: _primary,
          label: 'Pay Bill',
          onTap: () {
            Get.back();
            _startRepeatPurchase(b);
          },
        ),
        BillHistoryAction(
          icon: Icons.autorenew,
          color: const Color(0xFF10B981),
          label: hasAuto ? 'Edit Auto-Pay' : 'Set Auto-Pay',
          subtitle: hasAuto
              ? (autos.length == 1
                  ? 'Active schedule for this account'
                  : '${autos.length} schedules · tap to pick one')
              : null,
          onTap: () {
            Get.back();
            _openAutoRechargeEditor(b, autos);
          },
        ),
        BillHistoryAction(
          icon: Icons.notifications_outlined,
          color: const Color(0xFFFB923C),
          label: 'Set Reminder',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.waterBillRemindersCreate,
              arguments: {'beneficiary': b},
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.edit_outlined,
          color: const Color(0xFF9CA3AF),
          label: 'Edit Nickname',
          onTap: () {
            Get.back();
            _editNickname(b);
          },
        ),
        BillHistoryAction(
          icon: Icons.delete_outline,
          color: const Color(0xFFEF4444),
          label: 'Delete Account',
          onTap: () {
            Get.back();
            _confirmDelete(b);
          },
        ),
      ],
    );
  }

  /// Route a saved water account back into the payment flow. Builds a
  /// synthetic `WaterProviderEntity` from the beneficiary's cached
  /// providerCode + providerName so we can reuse the existing
  /// customer-input screen.
  void _startRepeatPurchase(WaterBeneficiary b) {
    final provider = WaterProviderEntity(
      providerCode: b.providerCode,
      providerName: b.providerName,
      isActive: true,
    );
    Get.toNamed(
      AppRoutes.waterBillCustomerInput,
      arguments: <String, dynamic>{
        'provider': provider,
        if (b.lastAmount != null && b.lastAmount! > 0)
          'preselectedAmount': b.lastAmount,
        'preselectedAccountNumber': b.accountNumber,
      },
    );
  }

  void _showDetailsDialog(
      WaterBeneficiary b, List<WaterAutoRecharge> autos) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
        contentPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
        title: Text(
          b.nickname?.isNotEmpty == true ? b.nickname! : b.accountNumber,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('Account', b.accountNumber),
                _detailRow('Provider', b.providerName),
                if (b.nickname?.isNotEmpty == true)
                  _detailRow('Nickname', b.nickname!),
                if (b.customerName?.isNotEmpty == true)
                  _detailRow('Customer', b.customerName!),
                if (b.lastAmount != null && b.lastAmount! > 0)
                  _detailRow('Last amount',
                      '\u20A6${b.lastAmount!.toStringAsFixed(2)}'),
                _detailRow('Times used', b.topupCount.toString()),
                if (b.lastTopupAt != null && b.lastTopupAt!.isNotEmpty)
                  _detailRow('Last used', _formatIso(b.lastTopupAt)),
                if (autos.isNotEmpty) ...[
                  Divider(color: const Color(0xFF2D2D2D), height: 20.h),
                  Text('Auto-Pay (${autos.length})',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 8.h),
                  for (final ar in autos) ...[
                    _autoInlineCard(ar),
                    SizedBox(height: 8.h),
                  ],
                ],
              ],
            ),
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

  Widget _autoInlineCard(WaterAutoRecharge ar) {
    final color = ar.status.toLowerCase() == 'active'
        ? const Color(0xFF10B981)
        : (ar.status.toLowerCase() == 'paused'
            ? const Color(0xFFFB923C)
            : const Color(0xFFEF4444));
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '\u20A6${ar.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(ar.status.toUpperCase(),
                    style: TextStyle(
                        color: color,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          _miniRow('Frequency', ar.frequency),
          _miniRow('Next run', _formatIso(ar.nextRunDate)),
          if (ar.failureCount > 0)
            _miniRow('Failures', ar.failureCount.toString()),
        ],
      ),
    );
  }

  Widget _miniRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          SizedBox(
            width: 90.w,
            child: Text(label,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(color: Colors.white, fontSize: 12.sp)),
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

  String _formatIso(String? iso) {
    if (iso == null || iso.isEmpty) return '\u2014';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    return dt.toLocal().toString().split('.').first;
  }

  void _editNickname(WaterBeneficiary b) {
    final controller = TextEditingController(text: b.nickname ?? '');
    bool loading = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text('Edit Nickname',
              style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${b.providerName} \u00B7 ${b.accountNumber}',
                  style: TextStyle(
                      fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 16.h),
              TextField(
                controller: controller,
                autofocus: true,
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Enter nickname',
                  hintStyle: TextStyle(
                      color: const Color(0xFF4B5563), fontSize: 15.sp),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xFF2D2D2D))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xFF2D2D2D))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: _primary)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Cancel',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 14.sp))),
            TextButton(
              onPressed: loading
                  ? null
                  : () async {
                      setLocal(() => loading = true);
                      try {
                        await context.read<WaterBeneficiaryCubit>().update(
                              beneficiaryId: b.id,
                              nickname: controller.text.trim().isEmpty
                                  ? null
                                  : controller.text.trim(),
                            );
                        if (ctx.mounted) Navigator.of(ctx).pop();
                      } catch (_) {
                        setLocal(() => loading = false);
                      }
                    },
              child: loading
                  ? SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(_primary),
                      ),
                    )
                  : Text('Save',
                      style: TextStyle(
                          color: _primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(WaterBeneficiary b) {
    final ar = _autoFor(b);
    final hasAuto = ar != null;
    final name =
        (b.nickname?.isNotEmpty == true) ? b.nickname! : b.accountNumber;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(hasAuto ? 'Delete Account & Auto-Pay' : 'Delete Account',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          hasAuto
              ? 'This account has an active auto-pay. Deleting will also remove the linked schedule.\n\nDelete $name?'
              : 'Delete $name? This cannot be undone.',
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
              if (hasAuto) {
                context.read<WaterAutoRechargeCubit>().delete(ar.id);
              }
              context.read<WaterBeneficiaryCubit>().delete(b.id);
            },
            child: Text(hasAuto ? 'Delete All' : 'Delete',
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
