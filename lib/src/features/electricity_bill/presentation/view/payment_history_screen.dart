import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../widgets/electricity_history_actions_sheet.dart';

/// Electricity bill payment history. Mirrors `InternetHistoryScreen`:
///   * Same dark layout, purple `#4E03D0` accent
///   * `BillHistoryItem` rows (the shared transaction widget)
///   * Tap any row → `ElectricityHistoryActionsSheet` bottom sheet with
///     View Receipt / Repeat Payment / Set Reminder / Save-or-Edit Meter
///
/// Supports optional `Get.arguments`:
///   * `meterNumber` — filter to rows where `meterNumber` matches
///   * `providerCode` — filter to rows where `providerCode` matches
///   * `focusPaymentId` — highlight a row with a purple ring (used by
///     the actions-sheet "View Receipt" deep link)
class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF4E03D0);

  String? _meterFilter;
  String? _providerFilter;
  String? _focusPaymentId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final m = args['meterNumber'] as String?;
      if (m != null && m.trim().isNotEmpty) _meterFilter = m.trim();
      final p = args['providerCode'] as String?;
      if (p != null && p.trim().isNotEmpty) {
        _providerFilter = p.trim().toUpperCase();
      }
      final f = args['focusPaymentId'] as String?;
      if (f != null && f.trim().isNotEmpty) _focusPaymentId = f.trim();
    }
    context.read<ElectricityBillCubit>().getPaymentHistory();
  }

  String _fmtDate(DateTime? dt) {
    if (dt == null) return '';
    try {
      return DateFormat('MMM d, h:mm a').format(dt.toLocal());
    } catch (_) {
      return dt.toString();
    }
  }

  List<BillPaymentEntity> _applyFilters(List<BillPaymentEntity> all) {
    if (_meterFilter == null && _providerFilter == null) return all;
    return all.where((p) {
      if (_meterFilter != null && p.meterNumber != _meterFilter) return false;
      if (_providerFilter != null &&
          p.providerCode.toUpperCase() != _providerFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _meterFilter != null || _providerFilter != null;
    return PopScope(
      // Intercept the Android system back gesture so it routes to the
      // electricity bill landing instead of popping to whatever pushed
      // history (deep link, dashboard, etc.). The app bar's back arrow
      // does the same via Get.offNamed below.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        Get.offNamed(AppRoutes.electricityBillHome);
      },
      child: Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          filtered ? 'Filtered Payment History' : 'Payment History',
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          // Always return to the electricity bill landing screen, regardless
          // of the entry path (deep link, history actions sheet, etc.). Using
          // offNamed replaces the current route so a back press from the
          // landing doesn't pop straight back into history.
          onPressed: () => Get.offNamed(AppRoutes.electricityBillHome),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          if (filtered)
            IconButton(
              tooltip: 'Clear filter',
              onPressed: () {
                setState(() {
                  _meterFilter = null;
                  _providerFilter = null;
                });
              },
              icon: Icon(Icons.filter_alt_off, color: _accent, size: 22.sp),
            ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ElectricityBillCubit, ElectricityBillState>( // wrapped by PopScope above
          builder: (context, state) {
            if (state is PaymentHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(color: _accent),
              );
            }
            if (state is ElectricityBillError) {
              return _buildError(state.message);
            }
            final all = state is PaymentHistoryLoaded
                ? state.payments
                : const <BillPaymentEntity>[];
            final list = _applyFilters(all);
            return RefreshIndicator(
              color: _accent,
              backgroundColor: _card,
              onRefresh: () async {
                await context.read<ElectricityBillCubit>().getPaymentHistory();
              },
              child: list.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: EdgeInsets.all(20.w),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, i) => _buildRow(list[i]),
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemCount: list.length,
                    ),
            );
          },
        ),
      ),
    ),
    );
  }

  Widget _buildRow(BillPaymentEntity p) {
    final isFocused =
        _focusPaymentId != null && p.id == _focusPaymentId;
    final item = BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Icon(Icons.electric_bolt, color: _accent, size: 20.sp),
        ),
      ),
      title: p.providerName,
      subtitle: [
        p.meterNumber,
        if (p.meterType.name.isNotEmpty) p.meterType.name,
        _fmtDate(p.createdAt),
      ].where((s) => s.isNotEmpty).join(' \u00B7 '),
      amount: p.amount,
      currencySymbol: '\u20A6',
      // `displayStatus` already applies the refund override (returns
      // "Refunded" when status=failed but refund_source is populated),
      // so the chip stays in sync with the receipt-screen hero copy
      // even if the shared widget's canonicalisation changes later.
      status: p.displayStatus,
      refundSource: p.refundSource,
      onTap: () => ElectricityHistoryActionsSheet.show(context, p),
    );
    if (!isFocused) return item;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _accent, width: 1.5),
      ),
      child: item,
    );
  }

  Widget _buildEmpty() {
    final filtered = _meterFilter != null || _providerFilter != null;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
      children: [
        Icon(Icons.receipt_long, color: _textSecondary, size: 48.sp),
        SizedBox(height: 12.h),
        Text(
          filtered
              ? 'No payments matched that filter'
              : 'No electricity payments yet',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        Text(
          filtered
              ? 'Try clearing the filter to see all your electricity payments.'
              : 'Your completed, pending, and refunded payments appear here.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildError(String msg) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                color: const Color(0xFFEF4444), size: 40.sp),
            SizedBox(height: 10.h),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () =>
                  context.read<ElectricityBillCubit>().getPaymentHistory(),
              style: ElevatedButton.styleFrom(backgroundColor: _accent),
              child: Text('Retry',
                  style: GoogleFonts.inter(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
