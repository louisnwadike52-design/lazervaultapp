import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../domain/entities/internet_auto_recharge.dart';
import '../../domain/entities/internet_beneficiary.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../cubit/internet_auto_recharge_cubit.dart';
import '../cubit/internet_auto_recharge_state.dart';
import '../cubit/internet_beneficiary_cubit.dart';
import '../cubit/internet_beneficiary_state.dart';

/// Saved ISP accounts. Mirrors `DataBeneficiariesScreen` 1:1 —
/// list + add-by-repeat-purchase + tap-for-options + delete with
/// rollover warning. The options sheet exposes: View Details, View
/// Purchases, Start Purchase, Set Rollover, Edit Nickname, Delete.
/// Long-press still offers the fast delete confirmation.
class InternetSavedBeneficiariesScreen extends StatefulWidget {
  const InternetSavedBeneficiariesScreen({super.key});

  @override
  State<InternetSavedBeneficiariesScreen> createState() =>
      _InternetSavedBeneficiariesScreenState();
}

class _InternetSavedBeneficiariesScreenState
    extends State<InternetSavedBeneficiariesScreen> {
  List<InternetBeneficiary>? _beneficiaries;
  List<InternetAutoRecharge> _autoRecharges = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Routed without BlocProviders — provision both cubits here so the
    // screen can be opened cold and still load its state.
  }

  InternetAutoRecharge? _autoFor(InternetBeneficiary b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
  }

  List<InternetAutoRecharge> _autosFor(InternetBeneficiary b) =>
      _autoRecharges.where((ar) => ar.beneficiaryId == b.id).toList();

  Color _providerColor(String? code) {
    switch (code?.toUpperCase()) {
      case 'SMILE':
        return const Color(0xFF4E03D0);
      case 'SPECTRANET':
        return const Color(0xFF10B981);
      case 'IPNX':
        return const Color(0xFFFB923C);
      case 'SWIFT':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF4E03D0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBeneficiaryCubit>(
          create: (_) => GetIt.I<InternetBeneficiaryCubit>()..load(),
        ),
        BlocProvider<InternetAutoRechargeCubit>(
          create: (_) => GetIt.I<InternetAutoRechargeCubit>()..load(),
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
          title: Text('Saved ISP Accounts',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          actions: [
            Builder(
              builder: (ctx) => IconButton(
                tooltip: 'Rollover',
                onPressed: () =>
                    Get.toNamed(AppRoutes.internetBillRollover),
                icon: Icon(Icons.autorenew,
                    color: const Color(0xFF4E03D0), size: 22.sp),
              ),
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<InternetBeneficiaryCubit, InternetBeneficiaryState>(
              listener: (context, state) {
                if (!mounted) return;
                if (state is InternetBeneficiariesLoading) {
                  setState(() {
                    _loading = true;
                    _error = null;
                  });
                } else if (state is InternetBeneficiariesLoaded) {
                  setState(() {
                    _beneficiaries = state.beneficiaries;
                    _loading = false;
                    _error = null;
                  });
                } else if (state is InternetBeneficiaryError) {
                  setState(() {
                    _loading = false;
                    _error = state.message;
                  });
                }
              },
            ),
            BlocListener<InternetAutoRechargeCubit,
                InternetAutoRechargeState>(
              listener: (context, state) {
                if (!mounted) return;
                if (state is InternetAutoRechargesLoaded) {
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
              onPressed: () =>
                  context.read<InternetBeneficiaryCubit>().load(),
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
      color: const Color(0xFF4E03D0),
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () async {
        await Future.wait([
          context.read<InternetBeneficiaryCubit>().load(),
          context.read<InternetAutoRechargeCubit>().load(),
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
            Icon(Icons.wifi_tethering_off_outlined,
                size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No saved ISP accounts yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'After buying internet, tap "Save Contact" on the receipt to add the account here for one-tap repeat purchases.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(InternetBeneficiary b) {
    final autos = _autosFor(b);
    final providerForBadge =
        b.providerName.isEmpty || b.providerName.toLowerCase() == 'unknown'
            ? ''
            : b.providerName;
    return BillBeneficiaryItem(
      displayName: (b.nickname?.isNotEmpty == true) ? b.nickname! : b.accountNumber,
      identifier: b.accountNumber,
      providerName: providerForBadge,
      providerColor: _providerColor(b.providerCode),
      lastPlanOrAmount:
          (b.lastPlanName != null && b.lastPlanName!.isNotEmpty)
              ? b.lastPlanName
              : null,
      usageCount: b.topupCount,
      trailing: autos.isNotEmpty ? _autosBadge(autos) : null,
      onTap: () => _showOptions(b),
      onLongPress: () => _confirmDelete(b),
      flat: true,
      leftAccentColor: _providerColor(b.providerCode),
    );
  }

  Widget _autosBadge(List<InternetAutoRecharge> autos) {
    if (autos.length == 1) return _autoBadge(autos.first);
    final anyActive =
        autos.any((ar) => ar.status.toLowerCase() == 'active');
    final anyPaused =
        autos.any((ar) => ar.status.toLowerCase() == 'paused');
    final color = anyActive
        ? const Color(0xFF10B981)
        : (anyPaused
            ? const Color(0xFFFB923C)
            : const Color(0xFF9CA3AF));
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
          Text('Roll \u00D7${autos.length}',
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
    );
  }

  Widget _autoBadge(InternetAutoRecharge ar) {
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
          Text('Roll',
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
    );
  }

  void _showOptions(InternetBeneficiary b) {
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
              leading: const Icon(Icons.info_outline,
                  color: Color(0xFF4E03D0)),
              title: Text('View Details',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _showDetailsDialog(b, _autosFor(b));
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.history, color: Color(0xFF9CA3AF)),
              title: Text('View Purchases',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(AppRoutes.internetBillHistory,
                    arguments: {
                      'accountNumber': b.accountNumber,
                      'providerCode': b.providerCode,
                    });
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: const Icon(Icons.wifi, color: Color(0xFF4E03D0)),
              title: Text('Buy Internet',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _startRepeatPurchase(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.autorenew, color: Color(0xFF10B981)),
              title: Text('Set Rollover',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () async {
                Navigator.of(ctx).pop();
                // Dedicated create screen: beneficiary locked, user
                // picks package + cadence. Refresh the
                // auto-recharge list when the save succeeds so the
                // "Roll" badge flips on this row without a restart.
                final created = await Get.toNamed(
                  AppRoutes.internetBillRolloverCreate,
                  arguments: <String, dynamic>{
                    'beneficiary': b,
                    'locked': true,
                  },
                );
                if (created == true && mounted) {
                  context.read<InternetAutoRechargeCubit>().load();
                }
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: const Icon(Icons.edit_outlined,
                  color: Color(0xFF9CA3AF)),
              title: Text('Edit Nickname',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _editNickname(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Color(0xFFEF4444)),
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

  /// Route a saved contact into the purchase flow. When the saved row
  /// carries the last package used (`lastPackageId` + `lastAmount`), we
  /// jump straight to the confirmation screen. Otherwise we fall back
  /// to the account-input screen with the account pre-filled so the
  /// user only needs to pick a fresh package.
  void _startRepeatPurchase(InternetBeneficiary b,
      {bool preferRollover = false}) {
    final providerEntity = InternetProviderEntity(
      id: b.providerCode,
      name: b.providerName.isEmpty ? b.providerCode : b.providerName,
      serviceId: b.providerCode.toLowerCase(),
      logoUrl: '',
      isActive: true,
      commissionRate: 0,
    );
    final hasPackage = (b.lastPackageId?.isNotEmpty == true) &&
        (b.lastAmount ?? 0) > 0;
    if (hasPackage) {
      final packageEntity = InternetPackageEntity(
        id: b.lastPackageId!,
        name: (b.lastPlanName != null && b.lastPlanName!.isNotEmpty)
            ? b.lastPlanName!
            : b.lastPackageId!,
        variationCode: b.lastPackageId!,
        amount: b.lastAmount!,
        providerId: providerEntity.serviceId,
        validity: '',
      );
      final validationEntity = InternetAccountValidationEntity(
        isValid: true,
        // The Flutter entity doesn't carry the live customer_name —
        // fall back to the nickname or account number so the
        // confirmation screen's "Customer Name" row still renders.
        customerName: (b.nickname?.isNotEmpty == true)
            ? b.nickname!
            : b.accountNumber,
        accountNumber: b.accountNumber,
        status: 'repeat_purchase',
        dueAmount: 0,
      );
      Get.toNamed(
        AppRoutes.internetPaymentConfirmation,
        arguments: <String, dynamic>{
          'provider': providerEntity,
          'package': packageEntity,
          'validation': validationEntity,
          'accountNumber': b.accountNumber,
          'isRepeat': true,
          if (preferRollover) 'preferRollover': true,
        },
      );
      return;
    }
    Get.toNamed(
      AppRoutes.internetAccountInput,
      arguments: <String, dynamic>{
        'provider': providerEntity,
        'accountNumber': b.accountNumber,
        'isRepeat': true,
        if (preferRollover) 'preferRollover': true,
      },
    );
  }

  void _showDetailsDialog(
      InternetBeneficiary b, List<InternetAutoRecharge> autos) {
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
        title: Text(
          b.nickname?.isNotEmpty == true ? b.nickname! : b.accountNumber,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
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
                if (b.lastPlanName != null && b.lastPlanName!.isNotEmpty)
                  _detailRow('Last plan', b.lastPlanName!),
                if (b.lastAmount != null && b.lastAmount! > 0)
                  _detailRow('Last amount',
                      '\u20A6${b.lastAmount!.toStringAsFixed(2)}'),
                _detailRow('Times used', b.topupCount.toString()),
                if (b.lastTopupAt != null && b.lastTopupAt!.isNotEmpty)
                  _detailRow('Last used', _formatIso(b.lastTopupAt)),
                SizedBox(height: 8.h),
                if (autos.isNotEmpty) ...[
                  Divider(color: const Color(0xFF2D2D2D), height: 20.h),
                  Text(
                    'Rollovers (${autos.length})',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  for (final ar in autos) ...[
                    _rolloverCard(ar),
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

  Widget _rolloverCard(InternetAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    final color = isActive
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
                  ar.planName.isNotEmpty ? ar.planName : ar.packageId,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  ar.status.toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          _miniRow('Amount', '\u20A6${ar.amount.toStringAsFixed(2)}'),
          _miniRow('Frequency', ar.frequency),
          if (ar.frequency.toLowerCase() == 'monthly')
            _miniRow('Day of month', ar.dayOfMonth.toString()),
          _miniRow('Next run', _formatIso(ar.nextRunDate)),
          if (ar.lastRunDate != null && ar.lastRunDate!.isNotEmpty)
            _miniRow('Last run', _formatIso(ar.lastRunDate)),
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
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
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

  String _formatIso(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    return dt.toLocal().toString().split('.').first;
  }

  void _editNickname(InternetBeneficiary b) {
    final controller = TextEditingController(text: b.nickname ?? '');
    bool loading = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r)),
          title: Text('Edit Nickname',
              style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${b.providerName} · ${b.accountNumber}',
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF))),
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
                          const BorderSide(color: Color(0xFF4E03D0))),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 12.h),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Cancel',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp))),
            TextButton(
              onPressed: loading
                  ? null
                  : () async {
                      setLocal(() => loading = true);
                      try {
                        await context
                            .read<InternetBeneficiaryCubit>()
                            .update(
                              beneficiaryId: b.id,
                              nickname:
                                  controller.text.trim().isEmpty
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF4E03D0)),
                      ),
                    )
                  : Text('Save',
                      style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(InternetBeneficiary b) {
    final ar = _autoFor(b);
    final hasAuto = ar != null;
    final name =
        (b.nickname?.isNotEmpty == true) ? b.nickname! : b.accountNumber;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text(
            hasAuto ? 'Delete Contact & Rollover' : 'Delete Contact',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          hasAuto
              ? 'This contact has an active rollover. Deleting will also remove the linked schedule.\n\nDelete $name?'
              : 'Delete $name? This cannot be undone.',
          style: TextStyle(
              color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
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
              if (hasAuto) {
                context.read<InternetAutoRechargeCubit>().delete(ar.id);
              }
              context.read<InternetBeneficiaryCubit>().delete(b.id);
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
