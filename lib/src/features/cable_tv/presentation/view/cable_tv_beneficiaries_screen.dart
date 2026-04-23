import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../../domain/entities/cable_tv_auto_recharge.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../cubit/cable_tv_auto_recharge_cubit.dart';
import '../cubit/cable_tv_auto_recharge_state.dart';
import '../cubit/cable_tv_beneficiary_cubit.dart';
import '../cubit/cable_tv_beneficiary_state.dart';

/// Saved smart cards for cable TV. Mirrors `DataBeneficiariesScreen`.
class CableTVBeneficiariesScreen extends StatefulWidget {
  const CableTVBeneficiariesScreen({super.key});

  @override
  State<CableTVBeneficiariesScreen> createState() =>
      _CableTVBeneficiariesScreenState();
}

class _CableTVBeneficiariesScreenState
    extends State<CableTVBeneficiariesScreen> {
  List<CableTVBeneficiary>? _beneficiaries;
  List<CableTVAutoRecharge> _autoRecharges = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    context.read<CableTVBeneficiaryCubit>().load();
    context.read<CableTVAutoRechargeCubit>().load();
  }

  CableTVAutoRecharge? _autoFor(CableTVBeneficiary b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
  }

  Color _providerColor(String? code) {
    final lower = (code ?? '').toLowerCase();
    if (lower.contains('dstv')) return const Color(0xFF4E03D0);
    if (lower.contains('gotv')) return const Color(0xFF10B981);
    if (lower.contains('startimes')) return const Color(0xFFFB923C);
    if (lower.contains('showmax')) return const Color(0xFFEF4444);
    return const Color(0xFF4E03D0);
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
        title: Text('Saved Smart Cards',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: [
          IconButton(
            tooltip: 'Auto-Renew',
            onPressed: () => Get.toNamed(AppRoutes.cableTVAutoRecharge),
            icon: Icon(Icons.autorenew,
                color: const Color(0xFF4E03D0), size: 22.sp),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CableTVBeneficiaryCubit, CableTVBeneficiaryState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is CableTVBeneficiariesLoading) {
                setState(() {
                  _loading = true;
                  _error = null;
                });
              } else if (state is CableTVBeneficiariesLoaded) {
                setState(() {
                  _beneficiaries = state.beneficiaries;
                  _loading = false;
                  _error = null;
                });
              } else if (state is CableTVBeneficiaryError) {
                setState(() {
                  _loading = false;
                  _error = state.message;
                });
              }
            },
          ),
          BlocListener<CableTVAutoRechargeCubit, CableTVAutoRechargeState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is CableTVAutoRechargesLoaded) {
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
              onPressed: () => context.read<CableTVBeneficiaryCubit>().load(),
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
          context.read<CableTVBeneficiaryCubit>().load(),
          context.read<CableTVAutoRechargeCubit>().load(),
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
            Icon(Icons.credit_card_outlined,
                size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No saved smart cards yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'After paying a cable TV subscription, tap "Save Smart Card" on the receipt to add it here for one-tap renewals.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(CableTVBeneficiary b) {
    final ar = _autoFor(b);
    return BillBeneficiaryItem(
      displayName: b.nickname ?? b.smartCardNumber,
      identifier: b.smartCardNumber,
      providerName: b.providerName,
      providerColor: _providerColor(b.providerCode),
      lastPlanOrAmount:
          (b.lastPackageName != null && b.lastPackageName!.isNotEmpty)
              ? b.lastPackageName
              : null,
      usageCount: b.topupCount,
      trailing: ar != null ? _autoBadge(ar) : null,
      onTap: () => _showOptions(b),
      onLongPress: () => _confirmDelete(b),
      flat: true,
      leftAccentColor: _providerColor(b.providerCode),
    );
  }

  Widget _autoBadge(CableTVAutoRecharge ar) {
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

  /// Details bottom sheet for a saved smart card. Surfaces every field
  /// the user might want to audit before renewing — nickname, card
  /// number, provider, customer name, current package, last paid
  /// amount, last topup time, and topup count. Purely informational;
  /// actions (renew / edit / delete) live on the primary options sheet.
  void _showDetailsSheet(CableTVBeneficiary b) {
    final displayName =
        (b.nickname?.isNotEmpty == true) ? b.nickname! : b.smartCardNumber;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B5563),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: _providerColor(b.providerCode)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.live_tv,
                        color: _providerColor(b.providerCode), size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(displayName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            )),
                        SizedBox(height: 2.h),
                        Text(b.providerName,
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(color: const Color(0xFF2D2D2D), height: 1),
              SizedBox(height: 12.h),
              _detailRow('Smart card', b.smartCardNumber),
              if (b.nickname != null && b.nickname!.isNotEmpty)
                _detailRow('Nickname', b.nickname!),
              if (b.customerName != null && b.customerName!.isNotEmpty)
                _detailRow('Customer', b.customerName!),
              if (b.currentPackage != null && b.currentPackage!.isNotEmpty)
                _detailRow('Current package', b.currentPackage!),
              if (b.lastPackageName != null && b.lastPackageName!.isNotEmpty)
                _detailRow('Last paid for', b.lastPackageName!),
              if (b.lastAmount != null && b.lastAmount! > 0)
                _detailRow(
                  'Last amount',
                  '₦${b.lastAmount!.toStringAsFixed(2)}',
                ),
              _detailRow('Times renewed', b.topupCount.toString()),
              if (b.lastTopupAt != null && b.lastTopupAt!.isNotEmpty)
                _detailRow('Last renewed', _formatIso(b.lastTopupAt)),
              _detailRow('Added on', _formatIso(b.createdAt)),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(sheetCtx).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
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
    if (iso == null || iso.isEmpty) return 'Never';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    return dt.toLocal().toString().split('.').first;
  }

  void _showOptions(CableTVBeneficiary b) {
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
              leading: Icon(Icons.info_outline,
                  color: const Color(0xFF4E03D0)),
              title: Text('View Details',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _showDetailsSheet(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.history, color: const Color(0xFF4E03D0)),
              title: Text('View Purchases',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text(
                b.smartCardNumber,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 12.sp),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.cableTVHistory,
                  arguments: {
                    'smartCardNumber': b.smartCardNumber,
                    'nickname': b.nickname ?? b.smartCardNumber,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.live_tv, color: const Color(0xFF4E03D0)),
              title: Text('Renew Subscription',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                // Build a proper CableTVProviderEntity — the input screen
                // used to cast `args['provider']` as non-nullable which
                // crashed when we only had a code+name. The entity reader
                // tolerates a fallback now, and we send one anyway so the
                // downstream package-selection / confirmation screens
                // (which still hard-cast `provider`) don't trip on their
                // own.
                final provider = CableTVProviderEntity(
                  id: b.providerCode,
                  name: b.providerName.isNotEmpty
                      ? b.providerName
                      : b.providerCode,
                  serviceId: b.providerCode.toLowerCase(),
                  logoUrl: '',
                  isActive: true,
                  commissionRate: 0,
                );
                Get.toNamed(
                  AppRoutes.cableTVSmartCardInput,
                  arguments: {
                    'provider': provider,
                    'smartCardNumber': b.smartCardNumber,
                    'providerCode': b.providerCode,
                    'providerName': b.providerName,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            Builder(builder: (_) {
              // If this smart card already has an auto-renew schedule,
              // the tile flips into "update" mode — taps route to the
              // same screen but in edit mode so the existing cadence /
              // package / amount come back prefilled and the CTA reads
              // "Update Auto-Renew".
              final existing = _autoFor(b);
              final isExisting = existing != null;
              return ListTile(
                leading: Icon(Icons.autorenew,
                    color: isExisting
                        ? const Color(0xFFFB923C)
                        : const Color(0xFF10B981)),
                title: Text(
                  isExisting ? 'Update Auto-Renew' : 'Set Auto-Renew',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
                subtitle: isExisting
                    ? Text(
                        '${existing.frequency.toUpperCase()} '
                        '${existing.packageName.isNotEmpty ? existing.packageName : existing.variationCode}',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      )
                    : null,
                onTap: () {
                  Navigator.of(ctx).pop();
                  Get.toNamed(
                    AppRoutes.cableTVAutoRechargeCreate,
                    arguments: {
                      'beneficiary': b,
                      if (existing != null) 'autoRecharge': existing,
                      'locked': true,
                    },
                  );
                },
              );
            }),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.edit_outlined,
                  color: const Color(0xFF9CA3AF)),
              title: Text('Edit Nickname',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _editNickname(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: const Color(0xFFEF4444)),
              title: Text('Delete Smart Card',
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

  void _editNickname(CableTVBeneficiary b) {
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
              Text(b.smartCardNumber,
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
                          const BorderSide(color: Color(0xFF4E03D0))),
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
                        await context
                            .read<CableTVBeneficiaryCubit>()
                            .update(
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
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
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

  void _confirmDelete(CableTVBeneficiary b) {
    final ar = _autoFor(b);
    final hasAuto = ar != null;
    final name =
        (b.nickname?.isNotEmpty == true) ? b.nickname! : b.smartCardNumber;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text(
            hasAuto
                ? 'Delete Smart Card & Auto-Renew'
                : 'Delete Smart Card',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          hasAuto
              ? 'This smart card has an active auto-renew. Deleting will also remove the linked schedule.\n\nDelete $name?'
              : 'Delete $name? This cannot be undone.',
          style:
              TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancel',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp))),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (hasAuto) {
                context.read<CableTVAutoRechargeCubit>().delete(ar.id);
              }
              context.read<CableTVBeneficiaryCubit>().delete(b.id);
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
