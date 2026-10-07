import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';
import 'package:lazervault/src/features/data_bundles/presentation/cubit/data_bundles_cubit.dart';
import 'package:lazervault/src/features/data_bundles/presentation/cubit/data_bundles_state.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_validity.dart';

/// Pick a data plan. Returns the chosen plan, or null if dismissed.
///
/// WHY A PLAN AND NOT AN AMOUNT
/// ----------------------------
/// A data purchase is a PLAN, not a sum of money. The reminder and auto-renew
/// screens asked for a naira amount, which cannot be bought: ₦375 is the price
/// of a specific bundle, and typing ₦500 names nothing the provider sells. The
/// flow then had to guess a plan at execution time, or fail.
///
/// So the plan is the input, and the amount is read off it. That also makes
/// the stored `variation_id` — which the purchase actually needs — a real
/// selection instead of something derived after the fact.
///
/// Prices come from the live catalogue on every open. A data plan's price
/// moves, and a remembered one is how a renewal gets refused for being a few
/// naira short.
Future<DataPlanEntity?> showDataPlanPickerSheet(
  BuildContext context, {
  required String network,
  String? selectedVariationId,
}) {
  return showModalBottomSheet<DataPlanEntity>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (_) => GetIt.I<DataBundlesCubit>()..getDataPlans(network: network),
      child: _DataPlanPickerSheet(
        network: network,
        selectedVariationId: selectedVariationId,
      ),
    ),
  );
}

class _DataPlanPickerSheet extends StatefulWidget {
  const _DataPlanPickerSheet({
    required this.network,
    this.selectedVariationId,
  });

  final String network;
  final String? selectedVariationId;

  @override
  State<_DataPlanPickerSheet> createState() => _DataPlanPickerSheetState();
}

class _DataPlanPickerSheetState extends State<_DataPlanPickerSheet> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1E1E1E);
  static const _primary = Color(0xFF4E03D0);
  static const _secondary = Color(0xFF9CA3AF);

  /// Reuses the SAME duration filter the plan screens use, so "Weekly" means
  /// the same thing here as it does when buying — a second definition is how
  /// a plan goes missing from one list and not another.
  DataPlanDuration _duration = DataPlanDuration.all;
  String _query = '';

  List<DataPlanEntity> _filter(List<DataPlanEntity> plans) {
    final q = _query.trim().toLowerCase();
    return plans.where((p) {
      if (!matchesDuration(p, _duration)) return false;
      if (q.isEmpty) return true;
      return p.name.toLowerCase().contains(q) ||
          p.price.toStringAsFixed(0).contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.82.sh,
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            width: 38.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Choose a plan',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 2.h),
                      Text(widget.network.toUpperCase(),
                          style:
                              TextStyle(color: _secondary, fontSize: 11.sp)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: _secondary, size: 20.sp),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: 'Search plans',
                hintStyle: TextStyle(color: _secondary, fontSize: 13.sp),
                prefixIcon: Icon(Icons.search, color: _secondary, size: 18.sp),
                filled: true,
                fillColor: _card,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 34.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                for (final d in DataPlanDuration.values)
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => setState(() => _duration = d),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 7.h),
                        decoration: BoxDecoration(
                          color: _duration == d ? _primary : _card,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(d.label,
                            style: TextStyle(
                                color: Colors.white, fontSize: 12.sp)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: BlocBuilder<DataBundlesCubit, DataBundlesState>(
              builder: (context, state) {
                if (state is DataBundlesLoading) {
                  return const Center(
                      child: CircularProgressIndicator(color: _primary));
                }
                if (state is DataBundlesError) {
                  return _message(
                    // Never the raw failure: a catalogue fetch can fail on a
                    // provider outage, an allow-list or a timeout, and none of
                    // those help someone choosing a bundle.
                    "Couldn't load plans right now.",
                    onRetry: () => context
                        .read<DataBundlesCubit>()
                        .getDataPlans(network: widget.network),
                  );
                }
                if (state is! DataPlansLoaded) {
                  return const SizedBox.shrink();
                }
                final plans = _filter(state.plans);
                if (plans.isEmpty) {
                  return _message(state.plans.isEmpty
                      ? 'No plans are available for ${widget.network.toUpperCase()} right now.'
                      : 'No plans match that search.');
                }
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) {
                    final p = plans[i];
                    final selected = p.variationId == widget.selectedVariationId;
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pop(p),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(12.r),
                          border: selected
                              ? Border.all(color: _primary, width: 1.4)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600)),
                                  if (p.familyChipLabel.isNotEmpty) ...[
                                    SizedBox(height: 2.h),
                                    Text(p.familyChipLabel,
                                        style: TextStyle(
                                            color: _secondary,
                                            fontSize: 10.sp)),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text('₦${p.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _message(String text, {VoidCallback? onRetry}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(color: _secondary, fontSize: 13.sp)),
            if (onRetry != null) ...[
              SizedBox(height: 12.h),
              TextButton(onPressed: onRetry, child: const Text('Try again')),
            ],
          ],
        ),
      ),
    );
  }
}
