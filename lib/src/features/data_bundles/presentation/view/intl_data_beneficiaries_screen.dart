import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../../domain/entities/data_auto_recharge.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../cubit/data_auto_recharge_cubit.dart';
import '../cubit/data_auto_recharge_state.dart';
import '../cubit/data_beneficiary_cubit.dart';
import '../cubit/data_beneficiary_state.dart';

/// International data contacts. Filters data_beneficiaries where
/// country_code != 'NG'. Mirrors DataBeneficiariesScreen but scoped to
/// international entries. Tap routes into the intl data purchase flow
/// with operator/country pre-filled.
class IntlDataBeneficiariesScreen extends StatefulWidget {
  const IntlDataBeneficiariesScreen({super.key});

  @override
  State<IntlDataBeneficiariesScreen> createState() =>
      _IntlDataBeneficiariesScreenState();
}

class _IntlDataBeneficiariesScreenState
    extends State<IntlDataBeneficiariesScreen> {
  static const Color _primary = Color(0xFF4E03D0);

  List<DataBeneficiary>? _beneficiaries;
  List<DataAutoRecharge> _autoRecharges = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    context.read<DataBeneficiaryCubit>().load();
    context.read<DataAutoRechargeCubit>().load();
  }

  /// Filter to only international beneficiaries.
  List<DataBeneficiary> _filterIntl(List<DataBeneficiary> all) =>
      all
          .where((b) =>
              b.countryCode.isNotEmpty &&
              b.countryCode.toUpperCase() != 'NG')
          .toList();

  DataAutoRecharge? _autoFor(DataBeneficiary b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
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
        title: Text('Intl Data Contacts',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: [
          IconButton(
            tooltip: 'Auto-Recharge',
            onPressed: () => Get.toNamed(AppRoutes.intlDataAutoRecharge),
            icon: Icon(Icons.autorenew, color: _primary, size: 22.sp),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataBeneficiaryCubit, DataBeneficiaryState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is DataBeneficiariesLoading) {
                setState(() {
                  _loading = true;
                  _error = null;
                });
              } else if (state is DataBeneficiariesLoaded) {
                setState(() {
                  _beneficiaries = _filterIntl(state.beneficiaries);
                  _loading = false;
                  _error = null;
                });
              } else if (state is DataBeneficiaryError) {
                setState(() {
                  _loading = false;
                  _error = state.message;
                });
              }
            },
          ),
          BlocListener<DataAutoRechargeCubit, DataAutoRechargeState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is DataAutoRechargesLoaded) {
                setState(() => _autoRecharges = state.autoRecharges);
              }
            },
          ),
        ],
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null && (_beneficiaries == null || _beneficiaries!.isEmpty)) {
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
              onPressed: () => context.read<DataBeneficiaryCubit>().load(),
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
          valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
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
          context.read<DataBeneficiaryCubit>().load(),
          context.read<DataAutoRechargeCubit>().load(),
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
            Icon(Icons.public, size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No international data contacts yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'After sending international data, tap "Save Contact" on the receipt to add the recipient here.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(DataBeneficiary b) {
    final ar = _autoFor(b);
    return BillBeneficiaryItem(
      displayName: b.nickname ?? b.phoneNumber,
      identifier: '${b.countryCode} ${b.phoneNumber}',
      providerName: b.networkName.isNotEmpty ? b.networkName : 'Intl',
      providerColor: _primary,
      lastPlanOrAmount:
          (b.lastPlanName != null && b.lastPlanName!.isNotEmpty)
              ? b.lastPlanName
              : null,
      usageCount: b.topupCount,
      trailing: ar != null ? _autoBadge(ar) : null,
      onTap: () => _showOptions(b),
      onLongPress: () => _confirmDelete(b),
      flat: true,
      leftAccentColor: _primary,
    );
  }

  Widget _autoBadge(DataAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    final color =
        isActive ? const Color(0xFF10B981) : const Color(0xFFFB923C);
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
          Text('Auto',
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
    );
  }

  void _showOptions(DataBeneficiary b) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
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
            SizedBox(height: 16.h),
            ListTile(
              leading: Icon(Icons.wifi, color: _primary),
              title: Text('Send Data',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.intlDataPurchase,
                  arguments: {
                    'phoneNumber': b.phoneNumber,
                    'countryCode': b.countryCode,
                    'operatorId': b.operatorId,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  Icon(Icons.autorenew, color: const Color(0xFF10B981)),
              title: Text('Set Auto-Recharge',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.intlDataAutoRechargeCreate,
                  arguments: {'beneficiary': b, 'locked': true},
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: const Color(0xFFEF4444)),
              title: Text('Delete Contact',
                  style: TextStyle(
                      color: const Color(0xFFEF4444), fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _confirmDelete(b);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(DataBeneficiary b) {
    final name = (b.nickname?.isNotEmpty == true) ? b.nickname! : b.phoneNumber;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Contact',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text('Delete $name? This cannot be undone.',
            style:
                TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancel',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp))),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<DataBeneficiaryCubit>().delete(b.id);
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
