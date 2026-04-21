import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_create_sheet.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../../../../../core/widgets/bill_details_sheet.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../widgets/airtime_shimmer.dart';

/// Screen to manage saved airtime beneficiaries.
///
/// Renders from local copies of beneficiaries + auto-recharges that are
/// updated from any matching cubit state via BlocListener. This avoids the
/// previous bug where creating an auto-recharge would emit an
/// `AirtimeAutoRechargesLoaded` state, the builder would fall through to
/// the empty-state widget, and the page would flash "no saved contacts"
/// even though contacts did exist.
class AirtimeBeneficiariesScreen extends StatefulWidget {
  const AirtimeBeneficiariesScreen({super.key});

  @override
  State<AirtimeBeneficiariesScreen> createState() => _AirtimeBeneficiariesScreenState();
}

class _AirtimeBeneficiariesScreenState extends State<AirtimeBeneficiariesScreen> {
  List<AirtimeBeneficiary>? _beneficiaries;
  List<AirtimeAutoRecharge> _autoRecharges = const [];
  bool _beneficiariesLoading = true;
  String? _beneficiariesError;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AirtimeCubit>();
    cubit.loadBeneficiaries();
    // Pre-load auto-recharges so badges render immediately alongside the
    // beneficiary list. The cubit fires independent states for each, which
    // the BlocListener below collates into local state.
    cubit.loadAutoRecharges();
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
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
        title: Text(
          'Saved Contacts',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            tooltip: 'Auto-Recharges',
            onPressed: () => Get.toNamed(AppRoutes.airtimeAutoRecharge),
            icon: Icon(Icons.autorenew, color: const Color(0xFF4E03D0), size: 22.sp),
          ),
        ],
      ),
      body: BlocListener<AirtimeCubit, AirtimeState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is AirtimeBeneficiariesLoading) {
            setState(() {
              _beneficiariesLoading = true;
              _beneficiariesError = null;
            });
          } else if (state is AirtimeBeneficiariesLoaded) {
            setState(() {
              _beneficiaries = state.beneficiaries;
              _beneficiariesLoading = false;
              _beneficiariesError = null;
            });
          } else if (state is AirtimeBeneficiariesError) {
            setState(() {
              _beneficiariesLoading = false;
              _beneficiariesError = state.message;
            });
          } else if (state is AirtimeAutoRechargesLoaded) {
            setState(() => _autoRecharges = state.autoRecharges);
          } else if (state is AirtimeAutoRechargesError) {
            // Show auto-recharge error with retry option
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () => context.read<AirtimeCubit>().loadAutoRecharges(),
                  ),
                  duration: const Duration(seconds: 6),
                ),
              );
          } else if (state is AirtimeError) {
            // Generic errors from unrelated operations — surface as snackbar
            // but do NOT wipe the beneficiary list.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_beneficiariesError != null && (_beneficiaries == null || _beneficiaries!.isEmpty)) {
      return _buildErrorState(_beneficiariesError!);
    }
    if (_beneficiariesLoading && _beneficiaries == null) {
      return AirtimeBeneficiaryShimmer(itemCount: 5);
    }
    final beneficiaries = _beneficiaries ?? const [];
    if (beneficiaries.isEmpty) return _buildEmptyState();
    return RefreshIndicator(
      color: const Color(0xFF4E03D0),
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () async {
        final cubit = context.read<AirtimeCubit>();
        await Future.wait([
          cubit.loadBeneficiaries(),
          cubit.loadAutoRecharges(),
        ]);
      },
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: beneficiaries.length,
        itemBuilder: (context, index) => _buildBeneficiaryItem(beneficiaries[index]),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFFEF4444)),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<AirtimeCubit>().loadBeneficiaries(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_outlined, size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No saved contacts yet',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'When you buy airtime, tap "Save as contact" on the receipt to add numbers here for quick top-ups later.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  AirtimeAutoRecharge? _autoRechargeFor(AirtimeBeneficiary b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
  }

  Widget _buildBeneficiaryItem(AirtimeBeneficiary beneficiary) {
    final autoRecharge = _autoRechargeFor(beneficiary);
    return BillBeneficiaryItem(
      displayName: beneficiary.nickname ?? beneficiary.phoneNumber,
      identifier: beneficiary.phoneNumber,
      providerName: beneficiary.networkName,
      providerColor: _getNetworkColor(beneficiary.networkCode),
      usageCount: beneficiary.topupCount,
      trailing: autoRecharge != null
          ? _buildAutoRechargeBadge(beneficiary, autoRecharge)
          : null,
      onTap: () => _showOptions(beneficiary),
      onLongPress: () => _showDeleteConfirmation(beneficiary),
      flat: true,
      leftAccentColor: _getNetworkColor(beneficiary.networkCode),
    );
  }

  /// Pill-shaped badge shown on beneficiaries with an active auto-recharge.
  /// Tapping it opens a details dialog with a link to the full auto-recharge
  /// management screen. Tapping is isolated from the parent InkWell via a
  /// nested Material+InkWell so it doesn't trigger the options sheet.
  Widget _buildAutoRechargeBadge(AirtimeBeneficiary b, AirtimeAutoRecharge ar) {
    final isActive = ar.status.toLowerCase() == 'active';
    final color = isActive ? const Color(0xFF10B981) : const Color(0xFFFB923C);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () => _showAutoRechargeDialog(b, ar),
        child: Container(
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
              Text(
                'Auto',
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAutoRechargeDialog(AirtimeBeneficiary b, AirtimeAutoRecharge ar) {
    final currencySymbol = ar.currency == 'NGN' ? '\u20A6' : ar.currency;
    final frequencyLabel = ar.frequency[0].toUpperCase() + ar.frequency.substring(1);
    String scheduleLine;
    if (ar.frequency.toLowerCase() == 'weekly') {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final dayIdx = ar.dayOfWeek.clamp(0, 6);
      scheduleLine = 'Every ${days[dayIdx]}';
    } else if (ar.frequency.toLowerCase() == 'monthly') {
      scheduleLine = 'Day ${ar.dayOfMonth} of each month';
    } else {
      scheduleLine = frequencyLabel;
    }

    String? nextRunLabel;
    if (ar.nextRunDate.isNotEmpty) {
      try {
        final next = DateTime.parse(ar.nextRunDate).toLocal();
        nextRunLabel = DateFormat('EEE, dd MMM yyyy \u2022 HH:mm').format(next);
      } catch (_) {
        nextRunLabel = ar.nextRunDate;
      }
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.autorenew, color: const Color(0xFF10B981), size: 22.sp),
            SizedBox(width: 8.w),
            Text('Auto-Recharge', style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dialogRow('Contact', b.nickname ?? b.phoneNumber),
            _dialogRow('Phone', b.phoneNumber),
            _dialogRow('Amount', '$currencySymbol${ar.amount.toStringAsFixed(0)}'),
            _dialogRow('Schedule', scheduleLine),
            if (nextRunLabel != null) _dialogRow('Next run', nextRunLabel),
            _dialogRow('Status', ar.status),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFF4E03D0).withValues(alpha: 0.2)),
              ),
              child: Text(
                'Manage pauses, edits, retries and history on the Auto-Recharge screen.',
                style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Close', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Get.toNamed(AppRoutes.airtimeAutoRecharge);
            },
            child: Text(
              'View All',
              style: TextStyle(
                color: const Color(0xFF4E03D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dialogRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF6B7280)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13.sp, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(AirtimeBeneficiary beneficiary) {
    final hasAutoRecharge = _autoRechargeFor(beneficiary) != null;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
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
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            // Mirrors the electricity saved-meter sheet's "View Details"
            // entry: a read-only sheet of all the contact metadata.
            _buildOption(
              icon: Icons.info_outline,
              label: 'View Details',
              labelColor: const Color(0xFF4E03D0),
              onTap: () {
                Navigator.of(ctx).pop();
                _showBeneficiaryDetailsSheet(beneficiary);
              },
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            // Mirrors electricity "View Purchases" — opens the airtime
            // history screen pre-filtered to this contact's phone number.
            // The history screen reads `args['phoneNumber']` and seeds
            // its filter query with it, so the user lands on a filtered
            // list with the chip showing "1 active filter".
            _buildOption(
              icon: Icons.history,
              label: 'View Purchases',
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.airtimeHistory,
                  arguments: {
                    'phoneNumber': beneficiary.phoneNumber,
                    'scope': 'buy',
                  },
                );
              },
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            _buildOption(
              icon: Icons.phone_android,
              label: 'Buy Airtime',
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.airtimeRecipientInput,
                  arguments: {
                    'phoneNumber': beneficiary.phoneNumber,
                    'networkCode': beneficiary.networkCode,
                    'networkName': beneficiary.networkName,
                  },
                );
              },
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            _buildOption(
              icon: Icons.autorenew,
              label: hasAutoRecharge ? 'Manage Auto-Recharge' : 'Set Auto-Recharge',
              labelColor: const Color(0xFF4E03D0),
              onTap: () async {
                Navigator.of(ctx).pop();
                if (hasAutoRecharge) {
                  Get.toNamed(AppRoutes.airtimeAutoRecharge);
                } else {
                  final airtimeCubit = context.read<AirtimeCubit>();
                  await BillAutoRechargeCreateSheet.show(
                    context,
                    subtitle:
                        '${beneficiary.nickname ?? beneficiary.phoneNumber} \u00B7 ${beneficiary.networkName}',
                    // NG MNO ceilings are uniformly N10,000 per top-up;
                    // surface as the auto-recharge cap so the user can't
                    // schedule a value the network would reject.
                    minAmount: 50,
                    maxAmount: 10000,
                    onSubmit: ({
                      required double amount,
                      required String frequency,
                      required int dayOfWeek,
                      required int dayOfMonth,
                      required int executionHour,
                      required int executionMinute,
                    }) async {
                      await airtimeCubit.createAutoRecharge(
                        beneficiaryId: beneficiary.id,
                        amount: amount,
                        currency: 'NGN',
                        frequency: frequency,
                        dayOfWeek: dayOfWeek,
                        dayOfMonth: dayOfMonth,
                        executionHour: executionHour,
                        executionMinute: executionMinute,
                      );
                    },
                  );
                  // Refresh beneficiaries AND auto-recharges so the badge
                  // appears without the user having to pull-to-refresh.
                  if (!mounted) return;
                  airtimeCubit.loadBeneficiaries();
                  airtimeCubit.loadAutoRecharges();
                }
              },
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            _buildOption(
              icon: Icons.edit_outlined,
              label: 'Edit Nickname',
              // Surface the current nickname (or fall back to the phone
              // number) so the user knows what they'd be editing without
              // opening the dialog first.
              subtitle: (beneficiary.nickname?.isNotEmpty ?? false)
                  ? beneficiary.nickname
                  : beneficiary.phoneNumber,
              onTap: () {
                Navigator.of(ctx).pop();
                _showEditNicknameDialog(beneficiary);
              },
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            _buildOption(
              icon: Icons.delete_outline,
              label: 'Delete Contact',
              labelColor: const Color(0xFFEF4444),
              onTap: () {
                Navigator.of(ctx).pop();
                _showDeleteConfirmation(beneficiary);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    Color? labelColor,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: labelColor ?? const Color(0xFF9CA3AF)),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15.sp,
          color: labelColor ?? Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: (subtitle == null || subtitle.isEmpty)
          ? null
          : Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      onTap: onTap,
    );
  }

  /// Read-only sheet showing all the metadata we have for this saved
  /// contact. Delegates to the shared [BillDetailsSheet] so the layout
  /// matches every other airtime details surface (auto-recharge, etc.).
  void _showBeneficiaryDetailsSheet(AirtimeBeneficiary b) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final accent = _getNetworkColor(b.networkCode);
    final currencySymbol = b.countryCode == 'NG' ? '₦' : '';

    DateTime? parseIso(String? iso) {
      if (iso == null || iso.isEmpty) return null;
      try {
        return DateTime.parse(iso);
      } catch (_) {
        return null;
      }
    }

    final createdAt = parseIso(b.createdAt);
    final lastTopupAt = parseIso(b.lastTopupAt);

    BillDetailsSheet.show(
      context,
      title: b.nickname?.isNotEmpty == true ? b.nickname! : b.phoneNumber,
      subtitle:
          (b.nickname?.isNotEmpty == true) ? b.phoneNumber : null,
      headerIcon: Icons.phone_android,
      headerColor: accent,
      rows: [
        BillDetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: b.phoneNumber),
        BillDetailRow(
            icon: Icons.signal_cellular_4_bar,
            label: 'Network',
            value: b.networkName),
        BillDetailRow(
            icon: Icons.public, label: 'Country', value: b.countryCode),
        BillDetailRow(
          icon: Icons.repeat,
          label: 'Top-ups',
          value: '${b.topupCount} purchase${b.topupCount == 1 ? '' : 's'}',
        ),
        if (b.lastAmount != null)
          BillDetailRow(
            icon: Icons.payments_outlined,
            label: 'Last amount',
            value: '$currencySymbol${b.lastAmount!.toStringAsFixed(0)}',
          ),
        if (lastTopupAt != null)
          BillDetailRow(
            icon: Icons.access_time,
            label: 'Last top-up',
            value: dateFormat.format(lastTopupAt.toLocal()),
          ),
        if (createdAt != null)
          BillDetailRow(
            icon: Icons.calendar_today,
            label: 'Added',
            value: dateFormat.format(createdAt.toLocal()),
          ),
      ],
      primaryAction: BillDetailAction(
        icon: Icons.phone_android,
        label: 'Buy Airtime',
        onTap: () {
          Get.back(); // close the sheet
          Get.toNamed(
            AppRoutes.airtimeRecipientInput,
            arguments: {
              'phoneNumber': b.phoneNumber,
              'networkCode': b.networkCode,
              'networkName': b.networkName,
            },
          );
        },
      ),
    );
  }


  void _showEditNicknameDialog(AirtimeBeneficiary beneficiary) {
    final nicknameController = TextEditingController(text: beneficiary.nickname ?? '');
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text('Edit Nickname', style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                beneficiary.phoneNumber,
                style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: nicknameController,
                autofocus: true,
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Enter nickname',
                  hintStyle: TextStyle(color: const Color(0xFF4B5563), fontSize: 15.sp),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF4E03D0)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancel', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setDialogState(() => isLoading = true);
                      try {
                        await context.read<AirtimeCubit>().updateBeneficiary(
                          beneficiaryId: beneficiary.id,
                          nickname: nicknameController.text.trim().isEmpty
                              ? null
                              : nicknameController.text.trim(),
                        );
                        if (ctx.mounted) Navigator.of(ctx).pop();
                      } catch (e) {
                        setDialogState(() => isLoading = false);
                      }
                    },
              child: isLoading
                  ? SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
                      ),
                    )
                  : Text(
                      'Save',
                      style: TextStyle(
                        color: const Color(0xFF4E03D0),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(AirtimeBeneficiary beneficiary) {
    // Mirror the electricity beneficiaries delete flow — warn if there's an
    // attached auto-recharge, and make clear it will also be removed.
    final linkedAutoRecharge = _autoRechargeFor(beneficiary);
    final hasAutoRecharge = linkedAutoRecharge != null;

    final displayName = beneficiary.nickname?.isNotEmpty == true
        ? beneficiary.nickname!
        : beneficiary.phoneNumber;
    final message = hasAutoRecharge
        ? 'This contact has an active auto-recharge. Deleting will also remove the linked auto-recharge.\n\nAre you sure you want to delete $displayName?'
        : 'Are you sure you want to delete $displayName? This action cannot be undone.';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          hasAutoRecharge ? 'Delete Contact & Auto-Recharge' : 'Delete Contact',
          style: TextStyle(color: Colors.white, fontSize: 17.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
            if (hasAutoRecharge) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber,
                        color: const Color(0xFFFB923C), size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Linked auto-recharge will be permanently deleted',
                        style: TextStyle(
                          color: const Color(0xFFFB923C),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel',
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              final cubit = context.read<AirtimeCubit>();
              // Delete the linked auto-recharge FIRST so the backend doesn't
              // leave an orphan scheduled job pointing at a deleted beneficiary.
              if (linkedAutoRecharge != null) {
                cubit.deleteAutoRecharge(linkedAutoRecharge.id);
              }
              cubit.deleteBeneficiary(beneficiary.id);
            },
            child: Text(
              hasAutoRecharge ? 'Delete All' : 'Delete',
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getNetworkColor(String? networkCode) {
    switch (networkCode?.toUpperCase()) {
      case 'MTN':
        return const Color(0xFFFFCB05);
      case 'AIRTEL':
        return const Color(0xFFED1C24);
      case 'GLO':
        return const Color(0xFF006634);
      case '9MOBILE':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF4E03D0);
    }
  }
}
