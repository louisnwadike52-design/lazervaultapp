import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/funds/presentation/widgets/payment_receipt_shared.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdrawal_receipt_screen.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;

/// Paginated list of the user's linked-bank withdrawals (banking-service
/// `GetUserWithdrawals` — JWT-scoped, domestic payouts only). Tapping a row
/// opens the LIVE withdrawal receipt (which keeps polling a non-terminal
/// payout to its final status). Handles: first-load spinner, pull-to-refresh,
/// infinite scroll, empty state, error + retry, and back-navigation from the
/// receipt returning HERE (not the dashboard).
class WithdrawalHistoryScreen extends StatefulWidget {
  const WithdrawalHistoryScreen({super.key});

  @override
  State<WithdrawalHistoryScreen> createState() =>
      _WithdrawalHistoryScreenState();
}

class _WithdrawalHistoryScreenState extends State<WithdrawalHistoryScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1C1B22);
  static const _label = Color(0xFF8E8E93);
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);
  static const _processing = Color(0xFFF97316);
  static const _pageSize = 20;

  final _scroll = ScrollController();
  final List<banking_pb.Withdrawal> _items = [];
  bool _loading = true; // first page in flight
  bool _loadingMore = false; // subsequent page in flight
  bool _hasMore = true;
  String? _loadError; // non-null => full-screen error state (first page only)

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
    if (_scroll.position.pixels >
        _scroll.position.maxScrollExtent - 300) {
      _load(reset: false);
    }
  }

  Future<void> _load({required bool reset}) async {
    if (reset) {
      setState(() {
        _loading = _items.isEmpty; // pull-to-refresh keeps rows visible
        _loadError = null;
      });
    } else {
      setState(() => _loadingMore = true);
    }
    try {
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final resp = await serviceLocator<banking_grpc.BankingServiceClient>()
          .getUserWithdrawals(
        // user_id deliberately left empty — the backend is JWT-first and
        // resolves the caller; sending nothing keeps this unforgeable.
        banking_pb.GetUserWithdrawalsRequest()
          ..limit = _pageSize
          ..offset = reset ? 0 : _items.length,
        options: options,
      );
      if (!mounted) return;
      if (!resp.success) {
        throw Exception(resp.errorMessage.isNotEmpty
            ? resp.errorMessage
            : 'Could not load withdrawals');
      }
      setState(() {
        if (reset) _items.clear();
        _items.addAll(resp.withdrawals);
        _hasMore = resp.withdrawals.length >= _pageSize &&
            _items.length < resp.total;
        _loading = false;
        _loadingMore = false;
        _loadError = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadingMore = false;
        // Only the FIRST page failure blanks the screen; a failed
        // load-more keeps what's shown and surfaces a snackbar.
        if (_items.isEmpty) {
          _loadError =
              'Something went wrong. Please try again.';
        } else {
          Get.snackbar('', 'Couldn\'t load more withdrawals — pull to retry.',
              titleText: const SizedBox.shrink(),
              messageText: const Text('Couldn\'t load more withdrawals — pull to retry.',
                  style: TextStyle(color: Colors.white)),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: _error.withValues(alpha: 0.92),
              margin: EdgeInsets.all(12.w));
        }
      });
    }
  }

  // ── Status presentation ────────────────────────────────────────────────
  bool _isDone(String s) => s == 'completed' || s == 'successful';
  bool _isFailed(String s) => s == 'failed';

  Color _statusColor(String s) =>
      _isDone(s) ? _success : _isFailed(s) ? _error : _processing;

  String _statusLabel(String s) =>
      _isDone(s) ? 'Completed' : _isFailed(s) ? 'Failed' : 'Processing';

  String _money(int kobo, String currency) {
    final v = (kobo / 100).toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
    final sym = currency.toUpperCase() == 'NGN' ? '₦' : '$currency ';
    return '$sym$v';
  }

  String _maskedAccount(String acct) =>
      acct.length >= 4 ? '****${acct.substring(acct.length - 4)}' : acct;

  String _dateLabel(banking_pb.Withdrawal w) {
    if (!w.hasCreatedAt()) return '';
    final d = w.createdAt.toDateTime().toLocal();
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final ap = d.hour >= 12 ? 'PM' : 'AM';
    return '${d.day} ${months[d.month - 1]} ${d.year} · $h:${d.minute.toString().padLeft(2, '0')} $ap';
  }

  void _openReceipt(banking_pb.Withdrawal w) {
    final bank = w.destinationBankName.isNotEmpty
        ? BanksData.displayName(w.destinationBankName, w.destinationBankCode)
        : 'Bank';
    Get.to(() => WithdrawalReceiptScreen(
          amount: w.amount.toInt() / 100,
          fee: w.fee.toInt() / 100,
          totalDebited: w.totalAmount.toInt() > 0
              ? w.totalAmount.toInt() / 100
              : (w.amount.toInt() + w.fee.toInt()) / 100,
          bankName: bank,
          accountNumber: _maskedAccount(w.destinationAccount),
          reference: w.reference,
          status: w.status,
          withdrawalId: w.id,
          // Back returns HERE (history), never force-routes to the dashboard.
          fromHistory: true,
        ))?.then((_) {
      // The payout may have settled while the receipt was open (it polls) —
      // refresh so the row's status chip is current when the user returns.
      if (mounted) _load(reset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Withdrawal History',
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
    if (_loading) {
      return const Center(child: LazerVaultLoader());
    }
    if (_loadError != null) {
      return _buildErrorState();
    }
    if (_items.isEmpty) {
      return _buildEmptyState();
    }
    return RefreshIndicator(
      color: _processing,
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
          return _buildRow(_items[i]);
        },
      ),
    );
  }

  Widget _buildRow(banking_pb.Withdrawal w) {
    final status = w.status;
    final color = _statusColor(status);
    final bank = w.destinationBankName.isNotEmpty
        ? BanksData.displayName(w.destinationBankName, w.destinationBankCode)
        : 'Bank transfer';
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () => _openReceipt(w),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            BankLogo(
              bankName: bank,
              bankCode: w.destinationBankCode,
              size: 40,
              borderRadius: 12,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bank,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  SizedBox(height: 3.h),
                  Text(
                    '${_maskedAccount(w.destinationAccount)} · ${_dateLabel(w)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 11.5.sp, color: _label),
                  ),
                  if (_isFailed(status)) ...[
                    SizedBox(height: 3.h),
                    Text(
                        // Friendly copy only — raw failure_reason is admin-only.
                        friendlyMoneyError(w.failureCode, w.failureReason),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            color: _error.withValues(alpha: 0.85))),
                  ],
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('-${_money(w.amount.toInt(), w.currency)}',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: color.withValues(alpha: 0.45)),
                  ),
                  child: Text(_statusLabel(status),
                      style: GoogleFonts.inter(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w700,
                          color: color)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Icon(Icons.account_balance_outlined,
                  color: _label, size: 32.sp),
            ),
            SizedBox(height: 16.h),
            Text('No withdrawals yet',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 6.h),
            Text(
              'When you withdraw to a linked bank, every payout — processing, completed or failed — shows up here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 12.5.sp, color: _label, height: 1.4),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text('Make a withdrawal',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded, color: _label, size: 40.sp),
            SizedBox(height: 14.h),
            Text(_loadError!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 13.sp, color: _label, height: 1.4)),
            SizedBox(height: 18.h),
            TextButton(
              onPressed: () => _load(reset: true),
              style: TextButton.styleFrom(
                backgroundColor: _card,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.14))),
              ),
              child: Text('Retry',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
