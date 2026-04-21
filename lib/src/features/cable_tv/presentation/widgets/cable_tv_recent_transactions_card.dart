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
import '../../domain/entities/cable_tv_payment_entity.dart';
import 'cable_tv_history_actions_sheet.dart';

/// Top-of-landing strip: 3 most recent cable TV purchases.
/// Mirrors `InternetRecentTransactionsCard` / `DataRecentPurchasesCard`:
///   * Self-fetches via `GetBillPaymentHistory(bill_type=cable_tv, limit=3)`
///   * "View All" routes to the full cable TV history screen
///   * Row tap opens `CableTVHistoryActionsSheet` — the same five-action
///     bottom sheet the full history screen uses, so View Receipt /
///     Repeat Purchase / Set Reminder / Set Auto-Renew /
///     Save (or Edit) Contact work identically from both entry points.
class CableTVRecentTransactionsCard extends StatefulWidget {
  const CableTVRecentTransactionsCard({super.key});

  @override
  State<CableTVRecentTransactionsCard> createState() =>
      _CableTVRecentTransactionsCardState();
}

class _CableTVRecentTransactionsCardState
    extends State<CableTVRecentTransactionsCard> {
  static const _primary = Color(0xFF3B82F6);
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
      ..billType = 'cable_tv'
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

  String _packageLabel(pb.BillPayment p) {
    if (p.metadata.isEmpty) return '';
    try {
      final m = jsonDecode(p.metadata) as Map<String, dynamic>;
      return (m['package_name'] ??
              m['plan_name'] ??
              m['variation_name'] ??
              m['variation_code'] ??
              '')
          .toString();
    } catch (_) {
      return '';
    }
  }

  String _providerDisplay(pb.BillPayment p) {
    if (p.providerId.isEmpty) return 'Cable TV';
    final id = p.providerId.toLowerCase();
    if (id.contains('dstv')) return 'DStv';
    if (id.contains('gotv')) return 'GOtv';
    if (id.contains('startimes')) return 'StarTimes';
    if (id.contains('showmax')) return 'Showmax';
    return p.providerId.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () => Get.toNamed(AppRoutes.cableTVHistory),
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
    final pkg = _packageLabel(p);
    final provider = _providerDisplay(p);
    return BillHistoryItem(
      compact: true,
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Icon(Icons.live_tv, color: _primary, size: 16.sp),
        ),
      ),
      title: provider,
      subtitle: [
        if (pkg.isNotEmpty) pkg,
        p.customerNumber,
        _fmtDate(p.createdAt),
      ].where((s) => s.isNotEmpty).join(' · '),
      amount: p.amount,
      currencySymbol: '₦',
      status: p.status,
      onTap: () => CableTVHistoryActionsSheet.show(context, _entityFor(p)),
    );
  }

  /// Hydrate a lightweight `CableTVPaymentEntity` from the gRPC history
  /// row. The actions sheet accepts the entity type so we bridge here
  /// rather than dragging pb types into that file's public API.
  CableTVPaymentEntity _entityFor(pb.BillPayment p) {
    String customerName = '';
    if (p.metadata.isNotEmpty) {
      try {
        final m = jsonDecode(p.metadata) as Map<String, dynamic>;
        customerName = (m['customer_name'] ?? '').toString();
      } catch (_) {}
    }
    return CableTVPaymentEntity(
      id: p.id,
      userId: p.userId,
      accountId: p.accountId,
      billType: p.billType,
      providerId: p.providerId,
      reference: p.reference,
      amount: p.amount,
      status: p.status,
      customerNumber: p.customerNumber,
      metadata: p.metadata,
      createdAt: p.createdAt,
      newBalance: 0,
      renewalDate: '',
      customerName: customerName,
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
            'No cable TV purchases yet',
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
