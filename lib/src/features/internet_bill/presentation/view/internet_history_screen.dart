import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

import '../../../../../core/widgets/bill_history_item.dart';
import '../widgets/internet_history_actions_sheet.dart';

/// Internet bill purchase history. Lists every bill_payment row with
/// bill_type=internet for the current user, newest first. Tapping any
/// row opens the shared `InternetHistoryActionsSheet` — the same 5-action
/// bottom sheet the recent-transactions strip on the landing uses —
/// so View Receipt / Repeat Purchase / Set Reminder / Set Rollover /
/// Save-or-Edit-Contact work identically from either entry point.
///
/// Supports optional `Get.arguments`:
///   * `accountNumber` — filter to rows where `customerNumber` matches
///   * `providerCode` — filter to rows where `providerId` matches
///     (case-insensitive). Both filters compose.
///   * `focusPaymentId` — scroll-to-highlight a specific row, used by
///     the actions-sheet "View Receipt" action.
class InternetHistoryScreen extends StatefulWidget {
  const InternetHistoryScreen({super.key});

  @override
  State<InternetHistoryScreen> createState() => _InternetHistoryScreenState();
}

class _InternetHistoryScreenState extends State<InternetHistoryScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF4E03D0);

  late Future<List<pb.BillPayment>> _future;
  String? _accountFilter;
  String? _providerFilter;
  String? _focusPaymentId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final acc = args['accountNumber'] as String?;
      if (acc != null && acc.trim().isNotEmpty) _accountFilter = acc.trim();
      final prov = args['providerCode'] as String?;
      if (prov != null && prov.trim().isNotEmpty) {
        _providerFilter = prov.trim().toUpperCase();
      }
      final focus = args['focusPaymentId'] as String?;
      if (focus != null && focus.trim().isNotEmpty) {
        _focusPaymentId = focus.trim();
      }
    }
    _future = _fetch();
  }

  Future<List<pb.BillPayment>> _fetch() async {
    // Uses the commerce-gateway gRPC client directly — InternetBillCubit
    // doesn't expose history and the RPC is already the source of truth
    // for the admin-dashboard history list, so reusing it keeps both
    // surfaces consistent. Filter client-side after fetch; the RPC
    // takes only bill_type.
    final grpcClient =
        GetIt.I<GrpcClient>(instanceName: 'commerceGrpcClient');
    final req = pb.GetBillPaymentHistoryRequest()
      ..billType = 'internet'
      ..limit = 50;
    final options = await grpcClient.callOptions;
    final resp = await grpcClient.utilityPaymentsClient
        .getBillPaymentHistory(req, options: options);
    final all = resp.payments.toList();
    if (_accountFilter == null && _providerFilter == null) return all;
    return all.where((p) {
      if (_accountFilter != null && p.customerNumber != _accountFilter) {
        return false;
      }
      if (_providerFilter != null &&
          _canonicalProviderCode(p.providerId) != _providerFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  /// VTpass `service_id` values like `smile-direct` / `ipnx1515` don't
  /// match the canonical uppercase codes we store on beneficiaries
  /// (`SMILE`, `IPNX`). Normalise on the read-side so "View Purchases"
  /// from a saved contact actually returns rows for that ISP.
  String _canonicalProviderCode(String providerId) {
    final id = providerId.toLowerCase();
    if (id.contains('smile')) return 'SMILE';
    if (id.contains('spectranet')) return 'SPECTRANET';
    if (id.contains('ipnx')) return 'IPNX';
    if (id.contains('swift')) return 'SWIFT';
    return providerId.toUpperCase();
  }

  String _fmtDate(String iso) {
    if (iso.isEmpty) return '';
    try {
      return DateFormat('MMM d, h:mm a').format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return iso;
    }
  }

  String _planName(pb.BillPayment p) {
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
    final filtered = _accountFilter != null || _providerFilter != null;
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          filtered ? 'Filtered Internet History' : 'Internet History',
          style: GoogleFonts.inter(
              color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          if (filtered)
            IconButton(
              tooltip: 'Clear filter',
              onPressed: () {
                setState(() {
                  _accountFilter = null;
                  _providerFilter = null;
                  _future = _fetch();
                });
              },
              icon: Icon(Icons.filter_alt_off,
                  color: _accent, size: 22.sp),
            ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<pb.BillPayment>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: _accent),
              );
            }
            if (snap.hasError) {
              return _buildError(snap.error.toString());
            }
            final list = snap.data ?? [];
            return RefreshIndicator(
              color: _accent,
              backgroundColor: _card,
              onRefresh: () async => setState(() => _future = _fetch()),
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
    );
  }

  Widget _buildRow(pb.BillPayment p) {
    final plan = _planName(p);
    final provider = _providerDisplay(p);
    final isFocused =
        _focusPaymentId != null && p.id == _focusPaymentId;
    final item = BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Icon(Icons.wifi, color: _accent, size: 20.sp),
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
    if (!isFocused) return item;
    // Subtle highlight ring for the "View Receipt" deep link so the
    // user can see which row the sheet is referencing.
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _accent, width: 1.5),
      ),
      child: item,
    );
  }

  Widget _buildEmpty() {
    final filtered = _accountFilter != null || _providerFilter != null;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
      children: [
        Icon(Icons.receipt_long, color: _textSecondary, size: 48.sp),
        SizedBox(height: 12.h),
        Text(
          filtered
              ? 'No purchases matched that filter'
              : 'No internet purchases yet',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        Text(
          filtered
              ? 'Try clearing the filter to see all your internet purchases.'
              : 'Your completed, pending, and refunded purchases appear here.',
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
              onPressed: () => setState(() => _future = _fetch()),
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
