import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_create_sheet.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../cubit/auto_recharge_cubit.dart';
import '../cubit/auto_recharge_state.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';

/// Electricity Auto-Recharge management. Mirrors `DataAutoRechargeScreen`
/// visually: solid dark background, standard AppBar, shared
/// `BillAutoRechargeItem` cards, and a details dialog on tap. Electricity
/// retains the "Pay Now" action (absent in data) — it lives inside the
/// details dialog so the list stays visually identical to data.
class AutoRechargeListScreen extends StatefulWidget {
  const AutoRechargeListScreen({super.key});

  @override
  State<AutoRechargeListScreen> createState() => _AutoRechargeListScreenState();
}

class _AutoRechargeListScreenState extends State<AutoRechargeListScreen> {
  /// Cached list from the most recent successful load. Used so refetches
  /// after pause/resume/delete/create don't flash a full-screen loader.
  List<AutoRechargeEntity>? _cachedList;
  AutoRechargeEntity? _pendingPayAutoRecharge;
  /// Re-entry guard on the FAB — blocks a second tap while the meter-
  /// picker fetch / picker sheet / create sheet chain is already in
  /// flight (otherwise rapid taps stack two pickers on top of each
  /// other and we'd try to open the create sheet twice).
  bool _creating = false;

  @override
  void initState() {
    super.initState();
    context.read<AutoRechargeCubit>().getAutoRecharges();
  }

  @override
  void dispose() {
    // Clear pending payment reference to avoid stale state
    _pendingPayAutoRecharge = null;
    super.dispose();
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
        title: Text(
          'Auto-Recharge',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startCreateFlow,
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          'New Auto-Recharge',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ElectricityBillCubit, ElectricityBillState>(
            listener: _onElectricityState,
          ),
          BlocListener<AutoRechargeCubit, AutoRechargeState>(
            listener: _onAutoRechargeState,
          ),
        ],
        child: BlocBuilder<AutoRechargeCubit, AutoRechargeState>(
          builder: (context, state) {
            if (state is AutoRechargesLoaded) {
              _cachedList = state.autoRecharges;
            }
            final list = _cachedList;
            if (list == null) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
                ),
              );
            }
            if (list.isEmpty) return _buildEmpty();

            return RefreshIndicator(
              color: const Color(0xFF10B981),
              backgroundColor: const Color(0xFF1F1F1F),
              onRefresh: () async =>
                  context.read<AutoRechargeCubit>().getAutoRecharges(),
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (_, i) => _buildItem(list[i]),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // List item
  // ---------------------------------------------------------------------------

  Widget _buildItem(AutoRechargeEntity ar) {
    final localNextRun = ar.nextRunDate.toLocal();
    return BillAutoRechargeItem(
      title: ar.customerName.isEmpty ? ar.providerName : ar.customerName,
      subtitle: ar.meterNumber,
      planName:
          ar.providerName.isEmpty ? null : '${ar.providerName} \u00B7 ${ar.meterType.name}',
      amount: ar.amount,
      frequency: ar.frequency.name,
      status: ar.status.name,
      nextRunDate: localNextRun,
      createdAt: ar.createdAt.toLocal(),
      executionHour: localNextRun.hour,
      executionMinute: localNextRun.minute,
      failureCount: ar.failureCount,
      leadingIcon: Icon(Icons.bolt,
          color: const Color(0xFF4E03D0), size: 20.sp),
      onTap: () => _showDetailsDialog(ar),
      onPause: ar.isActive
          ? () => context
              .read<AutoRechargeCubit>()
              .pauseAutoRecharge(autoRechargeId: ar.id)
          : null,
      onResume: ar.isPaused
          ? () => context
              .read<AutoRechargeCubit>()
              .resumeAutoRecharge(autoRechargeId: ar.id)
          : null,
      onEdit: () => _editAutoRecharge(ar),
      onDelete: () => _confirmDelete(ar),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty state (mirrors data auto-recharge)
  // ---------------------------------------------------------------------------

  Widget _buildEmpty() => Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.autorenew,
                  size: 64.sp, color: const Color(0xFF4B5563)),
              SizedBox(height: 16.h),
              Text(
                'No Auto-Recharges Yet',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Set up a recurring payment from a saved meter, or tap the + button to get started.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: _startCreateFlow,
                icon: const Icon(Icons.add),
                label: const Text('Create Auto-Recharge'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  // ---------------------------------------------------------------------------
  // Details dialog (holds "Pay Now" for active electricity rows — the action
  // that doesn't exist on data/airtime, kept off the card to match their UI).
  // ---------------------------------------------------------------------------

  void _showDetailsDialog(AutoRechargeEntity ar) {
    final next = ar.nextRunDate.toLocal();
    final last = ar.lastRunDate?.toLocal();
    final statusColor = ar.isActive
        ? const Color(0xFF10B981)
        : ar.isPaused
            ? const Color(0xFFFB923C)
            : const Color(0xFFEF4444);

    // `showDialog` runs its builder in a fresh Navigator-route context that
    // sits OUTSIDE this screen's BlocProvider tree. Without re-exposing the
    // cubit, the BlocBuilder below throws
    // "Could not find the correct Provider<ElectricityBillCubit> above...".
    // Grabbing the cubit here (still inside the screen tree) and handing it
    // to BlocProvider.value inside the dialog gives the dialog its own
    // access without re-instantiating the cubit.
    final cubit = context.read<ElectricityBillCubit>();
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
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
                ar.customerName.isNotEmpty ? ar.customerName : 'Auto-Recharge',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                ar.status.displayName.toUpperCase(),
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
              _detailRow('Provider', ar.providerName),
              _detailRow('Meter', ar.meterNumber),
              _detailRow('Type', ar.meterType.name),
              _detailRow(
                'Amount',
                '\u20A6${ar.amount.toStringAsFixed(2)} ${ar.currency}',
              ),
              _detailRow('Frequency', ar.frequencyDescription),
              _detailRow(
                'Execution time',
                '${next.hour.toString().padLeft(2, '0')}:${next.minute.toString().padLeft(2, '0')}',
              ),
              _detailRow('Next run', DateFormat('MMM dd, yyyy HH:mm').format(next)),
              if (last != null)
                _detailRow('Last run', DateFormat('MMM dd, yyyy HH:mm').format(last)),
              _detailRow('Failures', '${ar.failureCount} / ${ar.maxRetries}'),
              if (ar.isActive) ...[
                SizedBox(height: 16.h),
                BlocBuilder<ElectricityBillCubit, ElectricityBillState>(
                  builder: (context, state) {
                    final isValidating = state is MeterValidating &&
                        _pendingPayAutoRecharge?.id == ar.id;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isValidating
                            ? null
                            : () {
                                Navigator.of(ctx).pop();
                                _payNow(ar);
                              },
                        icon: isValidating
                            ? SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.payment),
                        label: Text(isValidating ? 'Validating\u2026' : 'Pay Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4E03D0),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    );
                  },
                ),
              ],
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

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// FAB handler — picks a saved meter inline then opens the shared
  /// auto-recharge create sheet so the user never has to leave this
  /// screen. Mirrors data's single-step "new rollover" flow rather than
  /// bouncing the user through the saved-meters list first.
  Future<void> _startCreateFlow() async {
    if (_creating) return;
    _creating = true;
    try {
      await _doStartCreateFlow();
    } finally {
      if (mounted) _creating = false;
    }
  }

  Future<void> _doStartCreateFlow() async {
    final repo = GetIt.I<ElectricityBillRepository>();
    final cubit = context.read<AutoRechargeCubit>();
    final result = await repo.getBeneficiaries();
    final beneficiaries = result.fold<List<BillBeneficiaryEntity>>(
      (_) => const [],
      (list) => list,
    );
    if (!mounted) return;
    if (beneficiaries.isEmpty) {
      // Can't create an auto-recharge without a saved meter — route to
      // the add-beneficiary screen so the user can save one first.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Save a meter first, then set up an auto-recharge.'),
          backgroundColor: const Color(0xFFFB923C),
          action: SnackBarAction(
            label: 'Add Meter',
            textColor: Colors.white,
            onPressed: () =>
                Get.toNamed(AppRoutes.electricityBillAddBeneficiary),
          ),
        ),
      );
      return;
    }
    final picked = await _pickBeneficiary(beneficiaries);
    if (picked == null || !mounted) return;
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${picked.providerName} \u00B7 ${picked.meterNumber}',
      onSubmit: ({
        required double amount,
        required String frequency,
        required int dayOfWeek,
        required int dayOfMonth,
        required int executionHour,
        required int executionMinute,
      }) async {
        final res = await repo.createAutoRecharge(
          beneficiaryId: picked.id,
          amount: amount,
          currency: 'NGN',
          frequency: RechargeFrequencyExtension.fromString(frequency),
          dayOfWeek: frequency == 'weekly' ? dayOfWeek : null,
          dayOfMonth: frequency == 'monthly' ? dayOfMonth : null,
          executionHour: executionHour,
          executionMinute: executionMinute,
        );
        res.fold(
          (failure) => throw Exception(failure.message),
          (_) {},
        );
      },
    );
    if (!mounted) return;
    cubit.getAutoRecharges();
  }

  /// Inline bottom-sheet picker — lists the user's saved meters so the
  /// auto-recharge create flow can continue without leaving the screen.
  Future<BillBeneficiaryEntity?> _pickBeneficiary(
    List<BillBeneficiaryEntity> beneficiaries,
  ) {
    return showModalBottomSheet<BillBeneficiaryEntity>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
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
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Pick a saved meter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              ...beneficiaries.map((b) => ListTile(
                    leading: Icon(
                      b.isPrepaid ? Icons.bolt : Icons.receipt_long,
                      color: const Color(0xFF4E03D0),
                    ),
                    title: Text(
                      b.displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${b.providerName} \u00B7 ${b.meterNumber}',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    onTap: () => Navigator.of(ctx).pop(b),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editAutoRecharge(AutoRechargeEntity ar) async {
    final repo = GetIt.I<ElectricityBillRepository>();
    final cubit = context.read<AutoRechargeCubit>();
    final localNextRun = ar.nextRunDate.toLocal();
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${ar.providerName} \u00B7 ${ar.meterNumber}',
      title: 'Manage Auto-Recharge',
      ctaLabel: 'Save Changes',
      successMessage: 'Auto-recharge updated',
      initialAmount: ar.amount,
      initialFrequency: ar.frequency.name,
      initialDayOfWeek: ar.dayOfWeek,
      initialDayOfMonth: ar.dayOfMonth,
      initialExecutionHour: localNextRun.hour,
      initialExecutionMinute: localNextRun.minute,
      onSubmit: ({
        required double amount,
        required String frequency,
        required int dayOfWeek,
        required int dayOfMonth,
        required int executionHour,
        required int executionMinute,
      }) async {
        final result = await repo.updateAutoRecharge(
          autoRechargeId: ar.id,
          amount: amount,
          frequency: RechargeFrequencyExtension.fromString(frequency),
          dayOfWeek: frequency == 'weekly' ? dayOfWeek : null,
          dayOfMonth: frequency == 'monthly' ? dayOfMonth : null,
          executionHour: executionHour,
          executionMinute: executionMinute,
        );
        result.fold(
          (failure) => throw Exception(failure.message),
          (_) {},
        );
      },
    );
    cubit.getAutoRecharges();
  }

  void _payNow(AutoRechargeEntity ar) {
    _pendingPayAutoRecharge = ar;
    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: ar.providerCode,
          meterNumber: ar.meterNumber,
          meterType: ar.meterType,
        );
  }

  void _confirmDelete(AutoRechargeEntity ar) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text('Delete Auto-Recharge',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          'Are you sure you want to delete this auto-recharge for ${ar.customerName}?',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context
                  .read<AutoRechargeCubit>()
                  .deleteAutoRecharge(autoRechargeId: ar.id);
            },
            child: Text(
              'Delete',
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

  // ---------------------------------------------------------------------------
  // State listeners
  // ---------------------------------------------------------------------------

  void _onElectricityState(BuildContext context, ElectricityBillState state) {
    if (state is MeterValidated && _pendingPayAutoRecharge != null) {
      final ar = _pendingPayAutoRecharge!;
      _pendingPayAutoRecharge = null;
      if (!mounted) return;
      Get.toNamed(
        AppRoutes.electricityBillConfirmation,
        arguments: {
          'providerCode': ar.providerCode,
          'providerName': ar.providerName,
          'meterNumber': ar.meterNumber,
          'meterType': ar.meterType,
          'customerName': state.validationResult.customerName,
          'customerAddress': state.validationResult.customerAddress,
          'validationResult': state.validationResult,
          'amount': ar.amount,
        },
      );
    } else if (state is MeterValidationFailed ||
        state is ElectricityBillError) {
      _pendingPayAutoRecharge = null;
      if (!mounted) return;
      final message = state is MeterValidationFailed
          ? state.message
          : (state as ElectricityBillError).message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  void _onAutoRechargeState(BuildContext context, AutoRechargeState state) {
    if (state is AutoRechargeError) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }
    String? success;
    if (state is AutoRechargeDeleted) success = state.message;
    if (state is AutoRechargePaused) success = state.message;
    if (state is AutoRechargeResumed) success = state.message;
    if (state is AutoRechargeUpdated) success = state.message;
    if (success != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
      context.read<AutoRechargeCubit>().getAutoRecharges();
    }
  }
}
