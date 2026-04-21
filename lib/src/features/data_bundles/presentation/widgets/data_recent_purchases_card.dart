import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../cubit/data_bundles_cubit.dart';
import '../cubit/data_bundles_state.dart';
import 'data_history_actions_sheet.dart';

/// Filters the unified data history to what a given tab should surface.
enum DataPurchaseScope { all, buy, intl }

/// Thin landing-page wrapper that reuses the SAME [BillHistoryItem]
/// widget the full data-bundles history screen uses. Just pulls from
/// [DataBundlesCubit], filters by [scope], slices the top three, and
/// stacks them with spacing. No separate strip widget — the landing
/// and the history list render identical rows.
class DataRecentPurchasesCard extends StatefulWidget {
  final Color accent;
  final DataPurchaseScope scope;

  const DataRecentPurchasesCard({
    super.key,
    this.accent = const Color(0xFF4E03D0),
    this.scope = DataPurchaseScope.all,
  });

  @override
  State<DataRecentPurchasesCard> createState() =>
      _DataRecentPurchasesCardState();
}

class _DataRecentPurchasesCardState extends State<DataRecentPurchasesCard> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DataBundlesCubit>();
    if (cubit.state is DataBundlesInitial) {
      cubit.loadDataPurchaseHistory();
    }
  }

  bool _match(DataPurchaseEntity p) {
    switch (widget.scope) {
      case DataPurchaseScope.buy:
        return !p.isInternational;
      case DataPurchaseScope.intl:
        return p.isInternational;
      case DataPurchaseScope.all:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBundlesCubit, DataBundlesState>(
      buildWhen: (prev, curr) =>
          curr is DataPurchaseHistoryLoading ||
          curr is DataPurchaseHistoryLoaded ||
          curr is DataPurchaseHistoryError,
      builder: (context, state) {
        final rows = state is DataPurchaseHistoryLoaded
            ? state.purchases.where(_match).take(3).toList()
            : const <DataPurchaseEntity>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            SizedBox(height: 12.h),
            if (state is DataPurchaseHistoryLoading)
              _loading()
            else if (state is DataPurchaseHistoryError)
              _error(context, state.message)
            else if (rows.isEmpty)
              _empty()
            else
              Column(
                children: [
                  for (var i = 0; i < rows.length; i++) ...[
                    _row(context, rows[i]),
                    if (i != rows.length - 1) SizedBox(height: 10.h),
                  ],
                ],
              ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // The row builder matches [DataBundlesHistoryScreen._buildRow] so every
  // data row — on the landing or the full list — uses identical visuals.
  // The only extra bit here is `date: _relativeTime(...)` for the human
  // "1h ago" line the product requested on the landing strip.
  // ===========================================================================
  Widget _row(BuildContext context, DataPurchaseEntity p) {
    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: widget.accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.wifi, color: widget.accent, size: 20.sp),
      ),
      title: p.phoneNumber.isEmpty
          ? (p.isInternational ? 'International Data' : 'Data Bundle')
          : p.phoneNumber,
      subtitle: p.reference,
      date: _relativeTime(p.createdAt),
      amount: p.amount,
      // Collapses webhook/verification internals into "Processing" and
      // promotes failed-but-refunded rows to "Refunded" — same category
      // the receipt hero uses, so the landing strip agrees with the
      // full history list and the receipt screen for any given row.
      status: p.displayStatus,
      refundSource: p.refundSource.isEmpty ? null : p.refundSource,
      onTap: () => DataHistoryActionsSheet.show(context, p),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Purchases',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.dataBundlesHistory),
          child: Text(
            'View All',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: widget.accent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _loading() {
    return Column(
      children: List.generate(3, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i == 2 ? 0 : 10.h),
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
          ),
        );
      }),
    );
  }

  Widget _empty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 28.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history,
                size: 44.sp, color: Colors.white.withValues(alpha: 0.28)),
            SizedBox(height: 12.h),
            Text(
              'No data purchases yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Your data bundle purchases will appear here',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _error(BuildContext context, String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: () =>
                context.read<DataBundlesCubit>().loadDataPurchaseHistory(),
            child: Text(
              'Tap to retry',
              style: GoogleFonts.inter(
                color: widget.accent,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "1h ago" / "2d ago" helper — kept local to the landing-strip row so
/// the full history view (which shows the absolute ISO date) is
/// unaffected.
String _relativeTime(String iso) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return iso;
  final diff = DateTime.now().difference(dt);
  if (diff.isNegative || diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return DateFormat('MMM dd').format(dt);
}
