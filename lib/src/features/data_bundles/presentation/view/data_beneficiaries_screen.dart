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

/// Saved data contacts. Mirrors `AirtimeBeneficiariesScreen` — list + add
/// + delete + tap-to-purchase. Tap routes the user back into the data
/// purchase flow with `network` / `phoneNumber` pre-filled. Long-press
/// (or the options sheet) deletes.
class DataBeneficiariesScreen extends StatefulWidget {
  const DataBeneficiariesScreen({super.key});

  @override
  State<DataBeneficiariesScreen> createState() =>
      _DataBeneficiariesScreenState();
}

class _DataBeneficiariesScreenState extends State<DataBeneficiariesScreen> {
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

  DataAutoRecharge? _autoFor(DataBeneficiary b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
  }

  /// A single beneficiary can have multiple rollovers — one per plan
  /// variation (mtn-10mb, mtn-500mb, etc.). Return the full list.
  List<DataAutoRecharge> _autosFor(DataBeneficiary b) {
    return _autoRecharges.where((ar) => ar.beneficiaryId == b.id).toList();
  }

  String _displayNetworkName(DataBeneficiary b) {
    if (b.networkName.isNotEmpty &&
        b.networkName.toLowerCase() != 'unknown') {
      return b.networkName;
    }
    final code = b.networkCode.toUpperCase().replaceAll('-DATA', '');
    if (code == 'ETISALAT') return '9mobile';
    if (code.isNotEmpty) return code;
    return 'Network';
  }

  Color _networkColor(String? code) {
    switch (code?.toUpperCase()) {
      case 'MTN':
      case 'MTN-DATA':
        return const Color(0xFFFFCB05);
      case 'AIRTEL':
      case 'AIRTEL-DATA':
        return const Color(0xFFED1C24);
      case 'GLO':
      case 'GLO-DATA':
        return const Color(0xFF006634);
      case '9MOBILE':
      case 'ETISALAT-DATA':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF4E03D0);
    }
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
        title: Text('Saved Data Contacts',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: [
          IconButton(
            tooltip: 'Rollover',
            onPressed: () => Get.toNamed(AppRoutes.dataBundlesRollover),
            icon: Icon(Icons.autorenew,
                color: const Color(0xFF4E03D0), size: 22.sp),
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
                  _beneficiaries = state.beneficiaries;
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
      color: const Color(0xFF4E03D0),
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
            Icon(Icons.person_add_outlined,
                size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No saved data contacts yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'After buying data, tap "Save Contact" on the receipt to add the recipient here for one-tap repeat purchases.',
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
    final autos = _autosFor(b);
    final networkDisplay = _displayNetworkName(b);
    // Hide provider badge when it would show "Unknown" or similar fallback.
    final providerForBadge =
        networkDisplay.toLowerCase() == 'unknown' || networkDisplay == 'Network'
            ? ''
            : networkDisplay;
    final created = _formatShortDate(b.createdAt);
    return BillBeneficiaryItem(
      displayName: b.nickname ?? b.phoneNumber,
      identifier: b.phoneNumber,
      providerName: providerForBadge,
      providerColor: _networkColor(b.networkCode),
      lastPlanOrAmount:
          (b.lastPlanName != null && b.lastPlanName!.isNotEmpty)
              ? b.lastPlanName
              : null,
      usageCount: b.topupCount,
      savedOn: created.isEmpty ? null : 'Saved $created',
      trailing: autos.isNotEmpty
          ? GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _openRolloverEditor(b, autos),
              child: _autosBadge(autos),
            )
          : null,
      onTap: () => _showOptions(b),
      onLongPress: () => _confirmDelete(b),
      flat: true,
      leftAccentColor: _networkColor(b.networkCode),
    );
  }

  /// Drill into the rollover edit flow for a saved contact.
  ///   - Zero rollovers → fall through to create flow (beneficiary locked)
  ///   - One rollover   → jump straight to edit
  ///   - Many rollovers → picker bottom sheet so the user chooses which
  ///                      plan variation's schedule to edit
  ///
  /// Both edit paths pass `autoRecharge` (which carries `beneficiary`
  /// server-side via Preload) AND `beneficiary` so the edit screen can
  /// render the contact name immediately without waiting on the cubit.
  void _openRolloverEditor(
      DataBeneficiary b, List<DataAutoRecharge> autos) async {
    if (autos.isEmpty) {
      Get.toNamed(
        AppRoutes.dataBundlesRolloverCreate,
        arguments: {'beneficiary': b, 'locked': true},
      )?.then((_) {
        if (mounted) context.read<DataAutoRechargeCubit>().load();
      });
      return;
    }
    if (autos.length == 1) {
      _navigateEditRollover(b, autos.first);
      return;
    }
    final picked = await showModalBottomSheet<DataAutoRecharge>(
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
                child: Text(
                  'Edit which rollover?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8.h),
              for (final ar in autos)
                ListTile(
                  leading: Icon(Icons.autorenew,
                      color: ar.status.toLowerCase() == 'active'
                          ? const Color(0xFF10B981)
                          : const Color(0xFFFB923C)),
                  title: Text(
                    ar.planName.isNotEmpty ? ar.planName : ar.variationId,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '\u20A6${ar.amount.toStringAsFixed(0)} \u00B7 ${ar.frequency}',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: const Color(0xFF6B7280), size: 20.sp),
                  onTap: () => Navigator.of(ctx).pop(ar),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) _navigateEditRollover(b, picked);
  }

  void _navigateEditRollover(DataBeneficiary b, DataAutoRecharge ar) {
    // Reload the rollover list on return so edits/deletes from the
    // create screen are reflected on the badge immediately.
    Get.toNamed(
      AppRoutes.dataBundlesRolloverCreate,
      arguments: {'autoRecharge': ar, 'beneficiary': b},
    )?.then((_) {
      if (mounted) context.read<DataAutoRechargeCubit>().load();
    });
  }

  /// Trailing chip showing rollover state. Single rollover → the status of
  /// that row. Multiple rollovers → count + the best state (any active
  /// beats any paused, which beats everything else).
  Widget _autosBadge(List<DataAutoRecharge> autos) {
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

  void _showDetailsDialog(DataBeneficiary b, List<DataAutoRecharge> autos) {
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
          b.nickname?.isNotEmpty == true ? b.nickname! : b.phoneNumber,
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
                _detailRow('Phone', b.phoneNumber),
                _detailRow('Network', _displayNetworkName(b)),
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
                if (b.createdAt.isNotEmpty)
                  _detailRow('Saved on', _formatIso(b.createdAt)),
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

  /// Inline card rendering one rollover inside the details dialog.
  Widget _rolloverCard(DataAutoRecharge ar) {
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
                  ar.planName.isNotEmpty ? ar.planName : ar.variationId,
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

  /// Short "MMM d, yyyy" format for the saved-on footer line on each
  /// contact row. Kept separate from [_formatIso] because the row only
  /// needs the day — a full timestamp would crowd the card.
  String _formatShortDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return '';
    final local = dt.toLocal();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final m = months[local.month - 1];
    return '$m ${local.day}, ${local.year}';
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
          Text('Roll',
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
              leading: Icon(Icons.info_outline,
                  color: const Color(0xFF4E03D0)),
              title: Text('View Details',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _showDetailsDialog(b, _autosFor(b));
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.history, color: const Color(0xFF9CA3AF)),
              title: Text('View Purchases',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.dataBundlesHistory,
                  arguments: {
                    'phoneNumber': b.phoneNumber,
                    'networkCode': b.networkCode,
                    'networkName': _displayNetworkName(b),
                    'nickname': b.nickname,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.wifi, color: const Color(0xFF4E03D0)),
              title: Text('Buy Data',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                // DataPlanSelectionScreen and everything downstream
                // cast `networkColor` as int — without it, the screen
                // crashed on open with a `null is not a subtype of int`
                // on the first frame. Also substitute the raw
                // networkName with our display-safe resolver so legacy
                // rows that stored "unknown" surface as "9mobile"/MTN/
                // etc. The plan-selection screen also needs a non-null
                // phoneNumber and network code to feed the confirm
                // flow, so default both to empty strings when missing.
                Get.toNamed(
                  AppRoutes.dataBundlesPlanSelection,
                  arguments: {
                    'network': b.networkCode,
                    'networkName': _displayNetworkName(b),
                    'networkColor':
                        _networkColor(b.networkCode).toARGB32(),
                    'phoneNumber': b.phoneNumber,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            Builder(builder: (_) {
              final autos = _autosFor(b);
              final hasRollover = autos.isNotEmpty;
              return ListTile(
                leading:
                    Icon(Icons.autorenew, color: const Color(0xFF10B981)),
                title: Text(
                    hasRollover ? 'Edit Rollover' : 'Set Rollover',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                subtitle: hasRollover
                    ? Text(
                        autos.length == 1
                            ? 'Active schedule for this contact'
                            : '${autos.length} schedules · tap to pick one',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp),
                      )
                    : null,
                onTap: () {
                  Navigator.of(ctx).pop();
                  _openRolloverEditor(b, autos);
                },
              );
            }),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: Icon(Icons.edit_outlined,
                  color: const Color(0xFF9CA3AF)),
              title: Text('Edit Nickname',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              // Right-aligned badge shows the current nickname at a
              // glance — mirrors the electricity saved-meter pattern so
              // the user sees what they're editing without opening the
              // dialog first. Hidden when the contact has no nickname
              // set (would show a stray empty pill otherwise).
              trailing: (b.nickname != null && b.nickname!.trim().isNotEmpty)
                  ? ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 140.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFF4E03D0)
                                .withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          b.nickname!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: const Color(0xFF4E03D0),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : null,
              onTap: () {
                Navigator.of(ctx).pop();
                _editNickname(b);
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

  void _editNickname(DataBeneficiary b) {
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
              Text(b.phoneNumber,
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
                        await context.read<DataBeneficiaryCubit>().update(
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

  void _confirmDelete(DataBeneficiary b) {
    final ar = _autoFor(b);
    final hasAuto = ar != null;
    final name = (b.nickname?.isNotEmpty == true) ? b.nickname! : b.phoneNumber;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text(hasAuto ? 'Delete Contact & Rollover' : 'Delete Contact',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          hasAuto
              ? 'This contact has an active rollover. Deleting will also remove the linked schedule.\n\nDelete $name?'
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
                context.read<DataAutoRechargeCubit>().delete(ar.id);
              }
              context.read<DataBeneficiaryCubit>().delete(b.id);
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
