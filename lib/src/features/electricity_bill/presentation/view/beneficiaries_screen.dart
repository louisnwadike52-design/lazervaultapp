import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_create_sheet.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';
import '../widgets/rename_meter_sheet.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  List<ElectricityProviderEntity> _providers = [];
  List<AutoRechargeEntity> _autoRecharges = const [];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['providers'] is List<ElectricityProviderEntity>) {
      _providers = args['providers'] as List<ElectricityProviderEntity>;
    }
    context.read<BeneficiaryCubit>().getBeneficiaries();
    _loadAutoRecharges();
  }

  /// Load active auto-recharges so each saved-meter row can surface a
  /// "Rollover" badge when a schedule is linked — same pattern the
  /// internet saved-contacts screen uses. Preserves the last-known-good
  /// list on failure so a transient network blip doesn't wipe every
  /// badge on every row; genuine-empty states only show after a
  /// successful fetch returns zero rows.
  Future<void> _loadAutoRecharges() async {
    final repo = GetIt.I<ElectricityBillRepository>();
    final result = await repo.getAutoRecharges();
    if (!mounted) return;
    result.fold(
      (_) {},
      (list) {
        if (mounted) {
          setState(() => _autoRecharges = list);
        }
      },
    );
  }

  /// Replace-or-append an auto-recharge in the local cache so the
  /// trailing "Roll" badge on the affected beneficiary row updates
  /// immediately, without a `getAutoRecharges()` refetch. Callers capture
  /// the created/updated entity from the repo call inside the sheet's
  /// `onSubmit` and hand it here; the setState triggers only a rebuild
  /// of the beneficiary list items, not the whole page.
  void _upsertAutoRecharge(AutoRechargeEntity ar) {
    if (!mounted) return;
    final idx = _autoRecharges.indexWhere((x) => x.id == ar.id);
    final next = List<AutoRechargeEntity>.of(_autoRecharges);
    if (idx >= 0) {
      next[idx] = ar;
    } else {
      next.add(ar);
    }
    setState(() => _autoRecharges = next);
  }

  /// Opens the shared [BillAutoRechargeCreateSheet] in edit mode — same
  /// UI used by airtime/internet/data so the UX is identical across
  /// utilities; only the backend payload (electricity repo, frequency
  /// enum conversion) changes.
  Future<void> _openEditAutoRechargeSheet(
    BillBeneficiaryEntity b,
    AutoRechargeEntity auto,
  ) async {
    final repo = GetIt.I<ElectricityBillRepository>();
    final localNextRun = auto.nextRunDate.toLocal();
    AutoRechargeEntity? saved;
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${b.providerName} \u00B7 ${b.meterNumber}',
      title: 'Manage Auto-Recharge',
      ctaLabel: 'Save Changes',
      successMessage: 'Auto-recharge updated',
      initialAmount: auto.amount,
      initialFrequency: auto.frequency.name,
      initialDayOfWeek: auto.dayOfWeek,
      initialDayOfMonth: auto.dayOfMonth,
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
          autoRechargeId: auto.id,
          amount: amount,
          frequency: RechargeFrequencyExtension.fromString(frequency),
          dayOfWeek: frequency == 'weekly' ? dayOfWeek : null,
          dayOfMonth: frequency == 'monthly' ? dayOfMonth : null,
          executionHour: executionHour,
          executionMinute: executionMinute,
        );
        result.fold(
          (failure) => throw Exception(failure.message),
          (updated) => saved = updated,
        );
      },
    );
    if (!mounted) return;
    if (saved != null) {
      _upsertAutoRecharge(saved!);
    }
  }

  AutoRechargeEntity? _autoFor(BillBeneficiaryEntity b) {
    for (final ar in _autoRecharges) {
      if (ar.beneficiaryId == b.id) return ar;
    }
    return null;
  }

  void _proceedToPayment(BillBeneficiaryEntity beneficiary) {
    // Find matching provider from the list passed by home screen
    final matchingProvider = _providers
        .where((p) => p.providerCode == beneficiary.providerCode)
        .firstOrNull;

    if (matchingProvider == null) {
      // Fallback: return to home screen for validation
      if (mounted) {
        Get.back(result: beneficiary);
      }
      return;
    }

    // Construct MeterValidationResult from saved beneficiary data
    final validationResult = MeterValidationResult(
      customerName: beneficiary.customerName,
      customerAddress: beneficiary.customerAddress,
      meterNumber: beneficiary.meterNumber,
      meterType: beneficiary.meterType,
      isValid: true,
    );

    // Navigate directly to confirmation screen
    if (!mounted) return;
    Get.toNamed(
      AppRoutes.electricityBillConfirmation,
      arguments: {
        'provider': matchingProvider,
        'validationResult': validationResult,
        'providerCode': beneficiary.providerCode,
        'meterNumber': beneficiary.meterNumber,
        'meterType': beneficiary.meterType,
        'phoneNumber': beneficiary.phoneNumber ?? '',
        'beneficiary': beneficiary,
      },
    );
  }

  void _deleteBeneficiary(BillBeneficiaryEntity beneficiary) {
    if (!mounted) return;
    // If an auto-recharge is linked to this meter, tell the user it'll
    // be removed too — the backend cascades the delete server-side, so
    // hiding that in the UI would surprise them when their scheduled
    // top-ups silently stop.
    final auto = _autoFor(beneficiary);
    final hasAuto = auto != null;
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Delete Meter',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete ${beneficiary.displayName}?',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (hasAuto) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFB923C).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.autorenew,
                        color: const Color(0xFFFB923C), size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'The active auto-recharge linked to this meter '
                        'will also be deleted.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
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
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _confirmDeleteBeneficiary(beneficiary, linkedAuto: auto);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF5350),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fire the actual delete against the repo and patch the list in place
  /// on success — no full-page loading spinner, no refetch. Tolerates a
  /// linked auto-recharge: the backend cascades the auto-recharge delete
  /// server-side, so on success we just drop it from local state to keep
  /// the "Roll" badge from pointing at a dead beneficiary.
  Future<void> _confirmDeleteBeneficiary(
    BillBeneficiaryEntity beneficiary, {
    AutoRechargeEntity? linkedAuto,
  }) async {
    final repo = GetIt.I<ElectricityBillRepository>();
    final result = await repo.deleteBeneficiary(beneficiaryId: beneficiary.id);
    if (!mounted) return;
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      (_) {
        context
            .read<BeneficiaryCubit>()
            .applyBeneficiaryDelete(beneficiary.id);
        if (linkedAuto != null) {
          setState(() {
            _autoRecharges = _autoRecharges
                .where((ar) => ar.id != linkedAuto.id)
                .toList(growable: false);
          });
        }
        Get.snackbar(
          'Deleted',
          'Meter removed from your beneficiaries',
          backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
    );
  }

  Future<void> _setAsDefault(BillBeneficiaryEntity beneficiary) async {
    // Go through the repo directly so we can patch the list in place
    // (clearing `isDefault` on the previous default + setting it on the
    // tapped row) rather than emitting `BeneficiaryUpdating` which would
    // strand the UI in a loading state.
    final repo = GetIt.I<ElectricityBillRepository>();
    final result = await repo.updateBeneficiary(
      beneficiaryId: beneficiary.id,
      isDefault: true,
    );
    if (!mounted) return;
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      (updated) {
        context.read<BeneficiaryCubit>().applySetDefault(updated);
        Get.snackbar(
          'Default meter',
          '${updated.displayName} is now your default',
          backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocConsumer<BeneficiaryCubit, BeneficiaryState>(
                  listener: (context, state) {
                    // The per-mutation flows (rename, delete, set-default)
                    // now go through the repo directly and patch the
                    // cubit's loaded list in place, so BeneficiaryUpdated/
                    // BeneficiaryDeleted are no longer reached from this
                    // screen. Only surface generic errors here; a stray
                    // Updated/Deleted from an unexpected path would have
                    // already mutated the list — no toast needed.
                    if (state is BeneficiaryError) {
                      Get.snackbar(
                        'Error',
                        state.message,
                        backgroundColor: Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                    }
                  },
                  builder: (context, state) {
                    // Show a skeleton list during initial load (and any
                    // subsequent forced refresh) instead of the empty
                    // state — the empty copy only makes sense once we
                    // know the user really has zero saved meters.
                    if (state is BeneficiaryLoading ||
                        state is BeneficiaryInitial) {
                      return _buildLoadingSkeleton();
                    }

                    if (state is BeneficiariesLoaded) {
                      if (state.beneficiaries.isEmpty) {
                        return _buildEmptyState();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<BeneficiaryCubit>().getBeneficiaries();
                          await _loadAutoRecharges();
                        },
                        color: const Color(0xFF4E03D0),
                        // BillBeneficiaryItem's internal margin was removed
                        // (shared-widget cleanup). Explicit separator keeps
                        // spacing consistent across the whole utility set.
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
                          itemCount: state.beneficiaries.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final beneficiary = state.beneficiaries[index];
                            return _buildBeneficiaryCard(beneficiary);
                          },
                        ),
                      );
                    }

                    // Error / unknown → fall back to loading skeleton
                    // rather than the "no beneficiaries yet" empty state,
                    // which would be misleading when the fetch actually
                    // failed. The error listener shows a snackbar.
                    return _buildLoadingSkeleton();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.electricityBillAddBeneficiary);
          if (result is BillBeneficiaryEntity) {
            // User chose "Proceed to Payment" from add beneficiary
            _proceedToPayment(result);
            return;
          }
          // Refresh list in case a new beneficiary was added
          if (!context.mounted) return;
          context.read<BeneficiaryCubit>().getBeneficiaries();
        },
        backgroundColor: const Color(0xFF4E03D0),
        icon: Icon(Icons.add, size: 24.sp),
        label: Text(
          'Add Beneficiary',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Meters',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Quick access to your meters',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Shortcut to the auto-recharge list — saved meters and
          // auto-recharges are adjacent concepts in the user's mental
          // model, so jumping between them should be one tap rather
          // than a drill-down-and-back trip through a meter's sheet.
          GestureDetector(
            onTap: () async {
              await Get.toNamed(AppRoutes.electricityBillAutoRecharge);
              if (!mounted) return;
              _loadAutoRecharges();
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.autorenew,
                color: const Color(0xFF10B981),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Skeleton shimmer list shown while beneficiaries are loading. Mirrors
  /// the real card layout (leading icon, two text rows, trailing chip)
  /// so the transition to the loaded list doesn't feel like a relayout.
  /// Dark-theme palette matches the other shimmer surfaces in the app.
  Widget _buildLoadingSkeleton() {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, _) {
        return Shimmer.fromColors(
          baseColor: const Color(0xFF1F1F1F),
          highlightColor: const Color(0xFF3D3D3D),
          period: const Duration(milliseconds: 1200),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 90.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 52.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.bookmark_border,
                color: Colors.white.withValues(alpha: 0.3),
                size: 56.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Beneficiaries Yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Save frequently used meter numbers\nfor quick and easy payments',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showBeneficiaryDetailsSheet(BillBeneficiaryEntity beneficiary) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            // Beneficiary icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                beneficiary.isPrepaid ? Icons.bolt : Icons.receipt_long,
                color: const Color(0xFF4E03D0),
                size: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              beneficiary.displayName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (beneficiary.nickname.isNotEmpty &&
                beneficiary.nickname != beneficiary.customerName)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  beneficiary.customerName,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            SizedBox(height: 20.h),
            // Details card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Meter Number', beneficiary.meterNumber, Icons.numbers),
                  SizedBox(height: 12.h),
                  _buildDetailRow('Provider', beneficiary.providerName, Icons.business),
                  SizedBox(height: 12.h),
                  _buildDetailRow('Meter Type', beneficiary.meterType.displayName, Icons.label),
                  if (beneficiary.customerAddress != null &&
                      beneficiary.customerAddress!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildDetailRow('Address', beneficiary.customerAddress!, Icons.location_on_outlined),
                  ],
                  if (beneficiary.phoneNumber != null &&
                      beneficiary.phoneNumber!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildDetailRow('Phone', beneficiary.phoneNumber!, Icons.phone_outlined),
                  ],
                  SizedBox(height: 12.h),
                  _buildDetailRow('Added', dateFormat.format(beneficiary.createdAt), Icons.calendar_today),
                  if (beneficiary.hasBeenUsed) ...[
                    SizedBox(height: 12.h),
                    _buildDetailRow('Last Used', dateFormat.format(beneficiary.lastUsedAt!), Icons.access_time),
                  ],
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Proceed to Payment button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                  _proceedToPayment(beneficiary);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, color: Colors.white, size: 22.sp),
                      SizedBox(width: 10.w),
                      Text(
                        'Proceed to Payment',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.5),
          size: 18.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Mirrors the internet saved-contacts card 1:1 — shared
  /// `BillBeneficiaryItem` (no border, consistent spacing handled by the
  /// `ListView.separated` above), trailing auto-recharge badge when a
  /// schedule is linked, and tap opens a bottom-sheet with the same
  /// action set internet exposes.
  Widget _buildBeneficiaryCard(BillBeneficiaryEntity beneficiary) {
    final auto = _autoFor(beneficiary);
    return BillBeneficiaryItem(
      displayName: beneficiary.displayName,
      identifier: beneficiary.meterNumber,
      providerName: beneficiary.providerName,
      providerColor: const Color(0xFF4E03D0),
      leadingIcon: Icon(
        beneficiary.isPrepaid ? Icons.bolt : Icons.receipt_long,
        color: Colors.white,
        size: 22.sp,
      ),
      trailing: _buildTrailing(beneficiary, auto),
      onTap: () => _showOptions(beneficiary, auto),
      onLongPress: () => _deleteBeneficiary(beneficiary),
      flat: true,
      leftAccentColor: const Color(0xFF4E03D0),
    );
  }

  /// Trailing widget — shows the Default chip (if this is the user's
  /// default meter) and a "Roll" badge (if a linked auto-recharge row
  /// exists). Matches internet's `_autoBadge` pattern.
  Widget _buildTrailing(
      BillBeneficiaryEntity beneficiary, AutoRechargeEntity? auto) {
    final isActive = auto?.status == AutoRechargeStatus.active;
    final isPaused = auto?.status == AutoRechargeStatus.paused;
    final rollColor = isActive
        ? const Color(0xFF10B981)
        : (isPaused
            ? const Color(0xFFFB923C)
            : const Color(0xFF9CA3AF));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (beneficiary.isDefault)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'Default',
              style: GoogleFonts.inter(
                color: const Color(0xFF4E03D0),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (auto != null) ...[
          if (beneficiary.isDefault) SizedBox(width: 6.w),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openEditAutoRechargeSheet(beneficiary, auto),
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: rollColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: rollColor.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.autorenew, size: 12.sp, color: rollColor),
                SizedBox(width: 4.w),
                Text(
                  'Roll',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: rollColor,
                  ),
                ),
              ],
            ),
          ),
          ),
        ],
      ],
    );
  }

  /// Bottom-sheet shown when the user taps a saved meter row. Mirrors
  /// the internet `_showOptions` sheet: View Details / View Purchases /
  /// Pay Now / Set Auto-Recharge / Edit Nickname / Delete. Replaces the
  /// previous behaviour where tap opened the details dialog directly.
  void _showOptions(
      BillBeneficiaryEntity b, AutoRechargeEntity? auto) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
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
            ListTile(
              leading: const Icon(Icons.info_outline,
                  color: Color(0xFF4E03D0)),
              title: Text('View Details',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _showBeneficiaryDetailsSheet(b);
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
                Get.toNamed(
                  AppRoutes.electricityBillHistory,
                  arguments: {
                    'meterNumber': b.meterNumber,
                    'providerCode': b.providerCode,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.bolt, color: Color(0xFF4E03D0)),
              title: Text('Pay Now',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _proceedToPayment(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.autorenew, color: Color(0xFF10B981)),
              title: Text(
                auto == null ? 'Set Auto-Recharge' : 'Manage Auto-Recharge',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              onTap: () async {
                Navigator.of(ctx).pop();
                if (auto != null) {
                  await Get.toNamed(
                    AppRoutes.electricityBillAutoRecharge,
                    arguments: {'beneficiary': b, 'autoRecharge': auto},
                  );
                  if (!mounted) return;
                  // The manage page can change or delete the schedule; we
                  // don't know which without polling, so refetch once.
                  // This is a per-screen background call that rebuilds
                  // only the trailing "Roll" badges — not the list.
                  _loadAutoRecharges();
                  return;
                }
                // The beneficiary is already chosen (this whole sheet is
                // scoped to it), so the shared auto-recharge sheet opens
                // without any picker UI — no "Add new beneficiary" link,
                // nothing disabled, just amount + cadence + time.
                // Uses the repo directly (rather than the cubit) so the
                // sheet's try/catch surfaces failures via snackbar — the
                // cubit swallows errors into AutoRechargeError state.
                final repo = GetIt.I<ElectricityBillRepository>();
                AutoRechargeEntity? created;
                await BillAutoRechargeCreateSheet.show(
                  context,
                  subtitle: '${b.providerName} \u00B7 ${b.meterNumber}',
                  onSubmit: ({
                    required double amount,
                    required String frequency,
                    required int dayOfWeek,
                    required int dayOfMonth,
                    required int executionHour,
                    required int executionMinute,
                  }) async {
                    final result = await repo.createAutoRecharge(
                      beneficiaryId: b.id,
                      amount: amount,
                      currency: 'NGN',
                      frequency:
                          RechargeFrequencyExtension.fromString(frequency),
                      dayOfWeek: frequency == 'weekly' ? dayOfWeek : null,
                      dayOfMonth: frequency == 'monthly' ? dayOfMonth : null,
                      executionHour: executionHour,
                      executionMinute: executionMinute,
                    );
                    result.fold(
                      (failure) => throw Exception(failure.message),
                      (ar) => created = ar,
                    );
                  },
                );
                if (!mounted) return;
                if (created != null) {
                  _upsertAutoRecharge(created!);
                }
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.edit_note, color: Color(0xFF4E03D0)),
              title: Text('Rename',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text(
                b.displayName,
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              onTap: () async {
                Navigator.of(ctx).pop();
                if (!mounted) return;
                final updated = await RenameMeterSheet.show(
                  context,
                  beneficiary: b,
                );
                if (updated != null && mounted) {
                  // Patch just the renamed row in place — no
                  // `getBeneficiaries()` round-trip, no Loading state, no
                  // full-screen spinner; the ListView rebuilds with the
                  // same items and only the affected card's nickname
                  // changes.
                  context
                      .read<BeneficiaryCubit>()
                      .applyBeneficiaryUpdate(updated);
                }
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            if (!b.isDefault) ...[
              ListTile(
                leading: const Icon(Icons.star_outline,
                    color: Color(0xFFFB923C)),
                title: Text('Set as Default',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _setAsDefault(b);
                },
              ),
              const Divider(color: Color(0xFF2D2D2D), height: 1),
            ],
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Color(0xFFEF4444)),
              title: Text('Delete Meter',
                  style: TextStyle(
                      color: const Color(0xFFEF4444), fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _deleteBeneficiary(b);
              },
            ),
          ],
        ),
      ),
    );
  }
}
