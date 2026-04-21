import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import 'internet_history_actions_sheet.dart';

/// Top-of-landing strip showing the 3 most recent internet purchases.
/// Mirrors `DataBundlesHomeScreen._buildHistoryStripPlaceholder`:
///   * Self-fetches via `GetBillPaymentHistory(bill_type=internet, limit=3)`
///   * "View All" links to the full history screen
///   * Tapping a row opens `InternetHistoryActionsSheet` with
///     View Receipt / Repeat Purchase / Set Reminder / Set Rollover /
///     Save (or Edit) Contact — same five actions data exposes, same
///     saved-contact detection.
class InternetRecentTransactionsCard extends StatefulWidget {
  const InternetRecentTransactionsCard({super.key});

  @override
  State<InternetRecentTransactionsCard> createState() =>
      _InternetRecentTransactionsCardState();
}

class _InternetRecentTransactionsCardState
    extends State<InternetRecentTransactionsCard> {
  static const _primary = Color(0xFF4E03D0);
  static const _textSecondary = Color(0xFF9CA3AF);

  late Future<List<pb.BillPayment>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  Future<List<pb.BillPayment>> _fetch() async {
    final grpcClient =
        GetIt.I<GrpcClient>(instanceName: 'commerceGrpcClient');
    final req = pb.GetBillPaymentHistoryRequest()
      ..billType = 'internet'
      ..limit = 3;
    final options = await grpcClient.callOptions;
    final resp = await grpcClient.utilityPaymentsClient
        .getBillPaymentHistory(req, options: options);
    return resp.payments.toList();
  }

  /// Lets the parent screen refresh this widget on pull-to-refresh
  /// without remounting — external callers access via a GlobalKey.
  Future<void> refresh() async {
    setState(() => _future = _fetch());
    await _future;
  }

  String _fmtDate(String iso) {
    if (iso.isEmpty) return '';
    try {
      return DateFormat('MMM d, h:mm a').format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return iso;
    }
  }

  String _planLabel(pb.BillPayment p) {
    if (p.metadata.isEmpty) return '';
    try {
      final m = jsonDecode(p.metadata) as Map<String, dynamic>;
      return (m['plan_name'] ?? m['package_id'] ?? '').toString();
    } catch (_) {
      return '';
    }
  }

  String _providerDisplay(pb.BillPayment p) {
    if (p.providerId.isEmpty) return 'Internet';
    final id = p.providerId.toLowerCase();
    if (id.contains('smile')) return 'Smile';
    if (id.contains('spectranet')) return 'Spectranet';
    if (id.contains('ipnx')) return 'IPNX';
    if (id.contains('swift')) return 'Swift';
    return p.providerId.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // No outer shared-background container — each BillHistoryItem renders
    // its own card. Matches the airtime + data-bundles + electricity
    // recent-strip pattern so all utilities look consistent.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.internetBillHistory),
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  color: _primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        FutureBuilder<List<pb.BillPayment>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: _primary,
                    strokeWidth: 2,
                  ),
                ),
              );
            }
            if (snap.hasError) {
              return _errorLine();
            }
            final list = snap.data ?? [];
            if (list.isEmpty) return _emptyLine();
            return Column(
              children: [
                for (var i = 0; i < list.length; i++) ...[
                  _buildRow(list[i]),
                  if (i != list.length - 1) SizedBox(height: 10.h),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRow(pb.BillPayment p) {
    final plan = _planLabel(p);
    final provider = _providerDisplay(p);
    return BillHistoryItem(
      compact: true,
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Icon(Icons.wifi, color: _primary, size: 16.sp),
        ),
      ),
      title: provider,
      subtitle: [
        if (plan.isNotEmpty) plan,
        p.customerNumber,
        _fmtDate(p.createdAt),
      ].where((s) => s.isNotEmpty).join(' \u00B7 '),
      amount: p.amount,
      currencySymbol: '\u20A6',
      status: p.status,
      onTap: () => InternetHistoryActionsSheet.show(context, p),
    );
  }

  Widget _emptyLine() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          Icon(Icons.receipt_long, color: _textSecondary, size: 30.sp),
          SizedBox(height: 8.h),
          Text(
            'No internet purchases yet',
            style: GoogleFonts.inter(color: _textSecondary, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _errorLine() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Couldn\'t load recent purchases',
              style: GoogleFonts.inter(
                  color: _textSecondary, fontSize: 12.sp),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _future = _fetch()),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: _primary,
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
