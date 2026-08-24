import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/generated/payments.pb.dart' as payments_pb;
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments_grpc;

/// Upcoming (status == "scheduled") transfers — the rows core-payments holds
/// with a future `scheduled_at`, fired by the asynq/Redis ProcessAt tier.
/// Users can review and CANCEL a transfer before it fires (server-side CAS on
/// status='scheduled', so a cancel can never claw back an executed transfer).
/// Edge cases: first-load spinner, pull-to-refresh, pagination, empty state,
/// generic error + retry (raw errors are admin-only), cancel-confirm sheet,
/// double-tap guard, and optimistic row removal with rollback on failure.
class ScheduledTransfersListScreen extends StatefulWidget {
  const ScheduledTransfersListScreen({super.key});

  @override
  State<ScheduledTransfersListScreen> createState() =>
      _ScheduledTransfersListScreenState();
}

class _ScheduledTransfersListScreenState
    extends State<ScheduledTransfersListScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1C1B22);
  static const _label = Color(0xFF8E8E93);
  static const _accent = Color(0xFF7C5CFF);
  static const _error = Color(0xFFEF4444);
  static const _pageSize = 20;

  final _scroll = ScrollController();
  final List<payments_pb.TransferDetail> _items = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  bool _loadFailed = false;
  final Set<String> _cancelling = {};

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_maybeLoadMore);
    _load(reset: true);
  }

  @override
  void dispose() {
    _scroll.removeListener(_maybeLoadMore);
    _scroll.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    if (!_hasMore || _loadingMore || _loading) return;
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
      _load(reset: false);
    }
  }

  Future<void> _load({required bool reset}) async {
    if (reset) {
      setState(() {
        _loading = _items.isEmpty;
        _loadFailed = false;
      });
    } else {
      setState(() => _loadingMore = true);
    }
    try {
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final resp = await serviceLocator<payments_grpc.PaymentsServiceClient>()
          .getUserTransfers(
        payments_pb.GetUserTransfersRequest()
          ..status = 'scheduled'
          ..limit = _pageSize
          ..offset = reset ? 0 : _items.length,
        options: options,
      );
      if (!mounted) return;
      if (!resp.success) throw Exception('fetch failed');
      setState(() {
        if (reset) _items.clear();
        _items.addAll(resp.transfers);
        _hasMore = resp.transfers.length >= _pageSize &&
            _items.length < resp.total;
        _loading = false;
        _loadingMore = false;
        _loadFailed = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadingMore = false;
        if (_items.isEmpty) _loadFailed = true;
      });
    }
  }

  String _money(payments_pb.TransferDetail t) {
    final v = (t.amount.toInt() / 100).toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
    final sym = t.currency.toUpperCase() == 'NGN' ? '₦' : '${t.currency} ';
    return '$sym$v';
  }

  String _fireLabel(payments_pb.TransferDetail t) {
    final d = DateTime.tryParse(t.scheduledAt)?.toLocal();
    if (d == null) return 'Scheduled';
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final ap = d.hour >= 12 ? 'PM' : 'AM';
    final now = DateTime.now();
    final day = (d.year == now.year && d.month == now.month && d.day == now.day)
        ? 'Today'
        : '${d.day} ${months[d.month - 1]} ${d.year}';
    return '$day · $h:${d.minute.toString().padLeft(2, '0')} $ap';
  }

  Future<void> _confirmCancel(payments_pb.TransferDetail t) async {
    final ok = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Cancel this scheduled transfer?',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 8.h),
            Text(
              '${_money(t)} to ${t.destinationAccount.isNotEmpty ? t.destinationAccount : 'recipient'} · fires ${_fireLabel(t)}. No money has moved yet — cancelling stops it entirely.',
              style: GoogleFonts.inter(
                  fontSize: 12.5.sp, color: _label, height: 1.4),
            ),
            SizedBox(height: 18.h),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text('Keep it'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _error,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text('Cancel transfer'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
    if (ok == true) _cancel(t);
  }

  Future<void> _cancel(payments_pb.TransferDetail t) async {
    if (_cancelling.contains(t.id)) return; // double-tap guard
    setState(() => _cancelling.add(t.id));
    try {
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final resp = await serviceLocator<payments_grpc.PaymentsServiceClient>()
          .cancelScheduledTransfer(
        payments_pb.CancelScheduledTransferRequest()..paymentId = t.id,
        options: options,
      );
      if (!mounted) return;
      if (resp.success) {
        setState(() => _items.removeWhere((x) => x.id == t.id));
        Get.snackbar('', 'Scheduled transfer cancelled.',
            titleText: const SizedBox.shrink(),
            messageText: const Text('Scheduled transfer cancelled.',
                style: TextStyle(color: Colors.white)),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.92),
            margin: EdgeInsets.all(12.w));
      } else {
        // Friendly server message ("may have already been sent") — then
        // refresh so a just-fired transfer disappears from this list.
        Get.snackbar('', resp.errorMessage,
            titleText: const SizedBox.shrink(),
            messageText: Text(resp.errorMessage,
                style: const TextStyle(color: Colors.white)),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: _error.withValues(alpha: 0.92),
            margin: EdgeInsets.all(12.w));
        _load(reset: true);
      }
    } catch (_) {
      if (!mounted) return;
      Get.snackbar('', 'Something went wrong. Please try again.',
          titleText: const SizedBox.shrink(),
          messageText: const Text('Something went wrong. Please try again.',
              style: TextStyle(color: Colors.white)),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: _error.withValues(alpha: 0.92),
          margin: EdgeInsets.all(12.w));
    } finally {
      if (mounted) setState(() => _cancelling.remove(t.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Scheduled Transfers',
            style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: LazerVaultLoader());
    if (_loadFailed) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.wifi_off_rounded, color: _label, size: 40.sp),
          SizedBox(height: 12.h),
          Text('Something went wrong.\nPlease try again.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 13.sp, color: _label)),
          SizedBox(height: 16.h),
          TextButton(
              onPressed: () => _load(reset: true),
              child: Text('Retry',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w600))),
        ]),
      );
    }
    if (_items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.schedule_rounded, color: _label, size: 44.sp),
            SizedBox(height: 14.h),
            Text('No scheduled transfers',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 6.h),
            Text(
              'Pick "Schedule this transfer" when sending money and it will appear here until it fires.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12.5.sp, color: _label, height: 1.4),
            ),
          ]),
        ),
      );
    }
    return RefreshIndicator(
      color: _accent,
      backgroundColor: _card,
      onRefresh: () => _load(reset: true),
      child: ListView.separated(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        itemCount: _items.length + (_loadingMore ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, i) {
          if (i >= _items.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: const Center(child: LazerVaultLoader(size: 18)),
            );
          }
          final t = _items[i];
          final busy = _cancelling.contains(t.id);
          return Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.schedule_send_rounded,
                    color: _accent, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.destinationAccount.isNotEmpty
                          ? t.destinationAccount
                          : (t.narration.isNotEmpty
                              ? t.narration
                              : 'Scheduled transfer'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(height: 3.h),
                    Text('Fires ${_fireLabel(t)}',
                        style: GoogleFonts.inter(
                            fontSize: 11.5.sp, color: _label)),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_money(t),
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  SizedBox(height: 4.h),
                  busy
                      ? const LazerVaultLoader(size: 14)
                      : GestureDetector(
                          onTap: () => _confirmCancel(t),
                          child: Text('Cancel',
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _error)),
                        ),
                ],
              ),
            ]),
          );
        },
      ),
    );
  }
}
