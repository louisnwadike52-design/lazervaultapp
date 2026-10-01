import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_family_filter.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_validity.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_volume.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../cubit/data_bundles_cubit.dart';
import '../cubit/data_bundles_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class DataPlanSelectionScreen extends StatefulWidget {
  const DataPlanSelectionScreen({super.key});

  @override
  State<DataPlanSelectionScreen> createState() =>
      _DataPlanSelectionScreenState();
}

class _DataPlanSelectionScreenState extends State<DataPlanSelectionScreen> {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');

  // Active duration filter pill (All / Daily / Weekly / Monthly), parsed from
  // each plan's name.
  DataPlanDuration _durationFilter = DataPlanDuration.all;

  /// Active plan-FAMILY filter — the provider's own family id, '' for All.
  ///
  /// A second, orthogonal axis to the duration pills above. The provider lists
  /// nine families and MTN spans seven of them, and the same volume costs
  /// materially different amounts across them (1GB/30d: ₦880 cglite, ₦500 sme,
  /// ₦490 awoof). One flat list — all this screen could show until now — put
  /// three rows reading "1GB" at three prices side by side with nothing to
  /// distinguish them.
  String _familyFilter = '';

  /// Active data-VOLUME range, null for "any size".
  ///
  /// A third axis alongside duration and family, because the catalogue has 87
  /// distinct volumes across 254 plans and "about 2GB" is how people actually
  /// shop. Ranges rather than exact sizes — 87 chips is not a filter.
  DataVolumeBucket? _volumeFilter;

  @override
  void initState() {
    super.initState();
    final network = _argNetwork();
    if (network.isNotEmpty) {
      context.read<DataBundlesCubit>().getDataPlans(network: network);
    }
  }

  /// Defensive readers — every entry into this screen goes through
  /// `Get.arguments`, but not every caller populates every key (the
  /// saved-contacts bottomsheet omitted `networkColor` for months
  /// and crashed the page on open). Default to safe empties/primary
  /// accent so a missing arg never takes the screen down.
  Map<String, dynamic> get _args {
    final raw = Get.arguments;
    return raw is Map<String, dynamic> ? raw : const {};
  }

  String _argNetwork() {
    final v = _args['network'];
    return v is String ? v : '';
  }

  String _argNetworkName() {
    final v = _args['networkName'];
    return v is String ? v : '';
  }

  /// Network brand colour fallback mirrors the home screen grid so a
  /// contact saved without a colour still renders with the carrier's
  /// canonical accent instead of a cold grey.
  int _argNetworkColor() {
    final v = _args['networkColor'];
    if (v is int) return v;
    switch (_argNetwork().toUpperCase()) {
      case 'MTN-DATA':
        return const Color(0xFFFBBF24).toARGB32();
      case 'AIRTEL-DATA':
        return const Color(0xFFEF4444).toARGB32();
      case 'GLO-DATA':
      case 'ETISALAT-DATA':
        return const Color(0xFF10B981).toARGB32();
      default:
        return const Color(0xFF4E03D0).toARGB32();
    }
  }

  @override
  Widget build(BuildContext context) {
    final networkName = _argNetworkName();
    final network = _argNetwork();
    final networkColorValue = _argNetworkColor();
    final networkColor = Color(networkColorValue);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Select Data Plan',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              // Network info card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: networkColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.cell_tower,
                        color: networkColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            networkName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Choose a data plan below',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Text(
                'Available Plans',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              // Duration filter pills (parsed from each plan's name).
              SizedBox(
                height: 36.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final d in DataPlanDuration.values)
                      _buildDurationPill(d, Color(networkColorValue)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              // Plan-FAMILY chips, built from what the provider actually
              // returned rather than a hardcoded list — a family it starts
              // selling appears the first time it ships instead of staying
              // invisible until the app is updated. Absent entirely for a
              // provider that publishes no families, since a filter with one
              // option is a control that cannot do anything.
              BlocBuilder<DataBundlesCubit, DataBundlesState>(
                builder: (context, state) {
                  if (state is! DataPlansLoaded) return const SizedBox.shrink();
                  final families = dataPlanFamilies(state.plans);
                  if (families.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: SizedBox(
                      height: 34.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (final f in families)
                            _buildFamilyPill(f, Color(networkColorValue)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Data-VOLUME chips, built from the plans actually returned so a
              // range with nothing in it never becomes a chip that leads to an
              // empty list. Absent when fewer than two ranges are populated,
              // since one option cannot narrow anything.
              BlocBuilder<DataBundlesCubit, DataBundlesState>(
                builder: (context, state) {
                  if (state is! DataPlansLoaded) return const SizedBox.shrink();
                  final chips = dataVolumeChips(state.plans);
                  if (chips.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: SizedBox(
                      height: 34.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildVolumePill(
                              null, 'Any size', null, Color(networkColorValue)),
                          for (final b in chips)
                            _buildVolumePill(
                                b, b.label, b.count, Color(networkColorValue)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Plans grid
              Expanded(
                child: BlocBuilder<DataBundlesCubit, DataBundlesState>(
                  builder: (context, state) {
                    if (state is DataBundlesLoading) {
                      return const Center(
                        child: LazerVaultLoader.small(),
                      );
                    }

                    if (state is DataBundlesError) {
                      return _buildErrorState(state.message, network);
                    }

                    if (state is DataPlansLoaded) {
                      if (state.plans.isEmpty) {
                        return _buildEmptyState();
                      }
                      // Cheapest first WITHIN the selection. The reason the
                      // families are worth showing at all is that one of them is
                      // cheaper for the same volume, so the cheap end has to be
                      // the end a customer sees.
                      final plans = sortedByPrice(state.plans
                          .where((p) => matchesDuration(p, _durationFilter))
                          .where((p) => matchesFamily(p, _familyFilter))
                          .where((p) => matchesVolume(p, _volumeFilter))
                          .toList());
                      if (plans.isEmpty) {
                        // Names BOTH active filters. "No daily plans" when the
                        // user had also narrowed to SME reads as if the network
                        // sells no daily data, and they clear the wrong one.
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Text(
                              _emptyFilterMessage(state.plans),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14.sp),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        itemCount: plans.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          return _buildPlanCard(
                            plans[index],
                            network,
                            networkName,
                            networkColorValue,
                          );
                        },
                      );
                    }

                    // Initial state (entered without a network arg, so
                    // initState never fetched) or a foreign state left on
                    // this shared cubit — never render a dead blank grid.
                    return _buildErrorState(
                        'Unable to load data plans', network);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Names every active filter when a combination has no plans.
  ///
  /// "No daily plans" while the user had ALSO narrowed to SME reads as if the
  /// network sells no daily data at all, so they clear the duration and are
  /// puzzled when the list stays empty.
  String _emptyFilterMessage(List<DataPlanEntity> all) {
    final parts = <String>[];
    if (_durationFilter != DataPlanDuration.all) {
      parts.add(_durationFilter.label.toLowerCase());
    }
    if (_familyFilter.isNotEmpty) {
      final label = all
          .firstWhere((p) => p.planFamily == _familyFilter,
              orElse: () => all.first)
          .familyChipLabel;
      parts.add(label);
    }
    if (_volumeFilter != null) {
      parts.add(_volumeFilter!.label);
    }
    if (parts.isEmpty) return 'No plans available';
    return 'No ${parts.join(' + ')} plans. Try another filter.';
  }

  Widget _buildVolumePill(
      DataVolumeBucket? b, String label, int? count, Color accent) {
    final selected = b?.label == _volumeFilter?.label;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () => setState(() => _volumeFilter = b),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.22)
                : const Color(0xFF161616),
            borderRadius: BorderRadius.circular(18.r),
            border:
                Border.all(color: selected ? accent : const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Text(label,
                  style: GoogleFonts.inter(
                      color: selected ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500)),
              if (count != null) ...[
                SizedBox(width: 5.w),
                Text('$count',
                    style: GoogleFonts.inter(
                        color: selected
                            ? Colors.white.withValues(alpha: 0.7)
                            : const Color(0xFF6B7280),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyPill(DataPlanFamily f, Color accent) {
    final selected = f.id == _familyFilter;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () => setState(() => _familyFilter = f.id),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.22)
                : const Color(0xFF161616),
            borderRadius: BorderRadius.circular(18.r),
            border:
                Border.all(color: selected ? accent : const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Text(f.label,
                  style: GoogleFonts.inter(
                      color: selected ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500)),
              SizedBox(width: 5.w),
              // The count is what tells a customer a family is worth opening.
              Text('${f.count}',
                  style: GoogleFonts.inter(
                      color: selected
                          ? Colors.white.withValues(alpha: 0.7)
                          : const Color(0xFF6B7280),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationPill(DataPlanDuration d, Color accent) {
    final selected = d == _durationFilter;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () => setState(() => _durationFilter = d),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: selected ? accent : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(20.r),
            border:
                Border.all(color: selected ? accent : const Color(0xFF2D2D2D)),
          ),
          child: Text(d.label,
              style: GoogleFonts.inter(
                  color: selected ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    DataPlanEntity plan,
    String network,
    String networkName,
    int networkColorValue,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.dataBundlesRecipientInput,
          arguments: {
            'plan': plan,
            'network': network,
            'networkName': networkName,
            'networkColor': networkColorValue,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Plan name
            Text(
              plan.name,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Availability badge
            if (plan.availability.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  plan.availability,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            // Price
            Text(
              '\u20A6${_currencyFormat.format(plan.price)}',
              style: GoogleFonts.inter(
                color: const Color(0xFF10B981),
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, String network) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () =>
                context.read<DataBundlesCubit>().getDataPlans(network: network),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            color: const Color(0xFF9CA3AF),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No data plans available for this network',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
