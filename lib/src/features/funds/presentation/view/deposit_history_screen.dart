import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/funds/presentation/view/deposit_receipt_screen.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/payment_receipt_shared.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;

/// Paginated list of the user's deposits (banking-service `GetUserDeposits`,
/// JWT-scoped). Mirrors WithdrawalHistoryScreen: first-load spinner,
/// pull-to-refresh, infinite scroll, empty state, generic error + retry (raw
/// errors stay in the admin dashboard), and taps open the LIVE deposit
/// receipt which returns HERE on back.
class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({super.key});

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1C1B22);
  static const _label = Color(0xFF8E8E93);
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);
  static const _accent = Color(0xFF7C5CFF);
  static const _pageSize = 20;

  final _scroll = ScrollController();
  final List<banking_pb.Deposit> _items = [];

  /// Rows RECEIVED from the server, filtered or not.
  ///
  /// The list is filtered to the active locale's currency, so `_items.length`
  /// is no longer the server offset — paging on it would re-request rows
  /// already seen and silently skip others. This counts what the server has
  /// actually handed over.
  int _fetched = 0;
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  bool _loadFailed = false; // generic error state — never raw errors

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

  /// The active locale's currency code, upper-cased. Empty when it cannot be
  /// resolved — in which case the list is left UNFILTERED rather than guessing
  /// a currency and hiding the user's deposits behind a wrong assumption.
  String _activeCurrency() {
    try {
      return serviceLocator<LocaleManager>().currentCurrency.toUpperCase();
    } catch (_) {
      return '';
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
      final resp = await serviceLocator<banking_grpc.BankingServiceClient>()
          .getUserDeposits(
        // user_id left empty — the backend resolves the caller from the JWT.
        banking_pb.GetUserDepositsRequest()
          ..limit = _pageSize
          // Offset counts SERVER rows, not displayed ones — see [_fetched].
          ..offset = reset ? 0 : _fetched,
        options: options,
      );
      if (!mounted) return;
      if (!resp.success) throw Exception('fetch failed');
      setState(() {
        if (reset) {
          _items.clear();
          _fetched = 0;
        }
        _fetched += resp.deposits.length;
        // Show only the ACTIVE locale's currency. A single list mixing ₦, $
        // and £ rows invites reading one currency's figures as another's, and
        // the running totals above it are single-currency anyway.
        final active = _activeCurrency();
        _items.addAll(resp.deposits.where((d) =>
            active.isEmpty || d.currency.toUpperCase() == active));
        // Keep paging while the SERVER still has rows: a page can be entirely
        // filtered out, and stopping on an empty page would hide older
        // matching deposits behind it.
        _hasMore = resp.deposits.length >= _pageSize && _fetched < resp.total;
        _loading = false;
        _loadingMore = false;
        _loadFailed = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadingMore = false;
        if (_items.isEmpty) {
          _loadFailed = true;
        } else {
          Get.snackbar('', 'Something went wrong — pull to retry.',
              titleText: const SizedBox.shrink(),
              messageText: const Text('Something went wrong — pull to retry.',
                  style: TextStyle(color: Colors.white)),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: _error.withValues(alpha: 0.92),
              margin: EdgeInsets.all(12.w));
        }
      });
    }
  }

  bool _isDone(String s) =>
      s == 'successful' || s == 'completed' || s == 'success';
  bool _isFailed(String s) => s == 'failed' || s == 'cancelled';

  Color _statusColor(String s) =>
      _isDone(s) ? _success : _isFailed(s) ? _error : _accent;
  String _statusLabel(String s, [String failureCode = '']) {
    if (_isDone(s)) return 'Completed';
    if (_isFailed(s)) {
      // An abandoned checkout is the USER not finishing the bank
      // authorization — "Failed" read as a platform fault and caused panic.
      return _isAbandonedCode(failureCode) ? 'Not completed' : 'Failed';
    }
    return 'Processing';
  }

  bool _isAbandonedCode(String code) =>
      code == 'CHECKOUT_ABANDONED' ||
      code == 'DIRECTPAY_ABANDONED' ||
      code == 'DIRECTPAY_CANCELLED';

  String _money(int kobo, String currency) {
    final v = (kobo / 100).toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
    final sym = currency.toUpperCase() == 'NGN' ? '₦' : '$currency ';
    return '$sym$v';
  }

  /// The source label for a row: linked bank when present, else the payment
  /// method (card / bank transfer / mobile money) in friendly casing.
  String _sourceLabel(banking_pb.Deposit d) {
    if (d.sourceBankName.isNotEmpty) {
      return BanksData.displayName(d.sourceBankName, null);
    }
    switch (d.paymentType) {
      case 'card':
        return 'Card deposit';
      case 'bank_transfer':
        return 'Bank transfer';
      case 'mobilemoneyghana':
      case 'mpesa':
        return 'Mobile money';
      default:
        return 'Deposit';
    }
  }

  String _dateLabel(banking_pb.Deposit d) {
    if (!d.hasCreatedAt()) return '';
    final t = d.createdAt.toDateTime().toLocal();
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final ap = t.hour >= 12 ? 'PM' : 'AM';
    return '${t.day} ${months[t.month - 1]} ${t.year} · $h:${t.minute.toString().padLeft(2, '0')} $ap';
  }

  void _openReceipt(banking_pb.Deposit d) {
    Get.to(() => DepositReceiptScreen(
          amount: d.amount.toInt() / 100,
          fee: d.fee.toInt() / 100,
          discount: d.feeDiscount.toInt() / 100,
          bankName: _sourceLabel(d),
          accountNumber: d.sourceAccountNumber.isNotEmpty
              ? d.sourceAccountNumber
              : '—',
          reference: d.reference,
          status: d.status,
          failureCode: d.failureCode,
          depositId: d.id,
          fromHistory: true,
          // Destination stated only from what the DEPOSIT itself carries. The
          // record has destination_account_id but no human name for it, and a
          // raw UUID on a receipt is worse than no row; the account summaries
          // can't be consulted either (the cubit is a factory, so resolving one
          // here yields an empty instance). The currency is the one fact about
          // the destination this row genuinely knows.
          toAccountLabel: d.currency.isNotEmpty
              ? 'Your ${d.currency.toUpperCase()} wallet'
              : '',
        ))?.then((_) {
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
        title: Text('Deposit History',
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
    if (_loadFailed) return _buildErrorState();
    if (_items.isEmpty) return _buildEmptyState();
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
          return _buildRow(_items[i]);
        },
      ),
    );
  }

  Widget _buildRow(banking_pb.Deposit d) {
    final color = _statusColor(d.status);
    final src = _sourceLabel(d);
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () => _openReceipt(d),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            d.sourceBankName.isNotEmpty
                ? BankLogo(bankName: src, size: 40, borderRadius: 12)
                : Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                        d.paymentType == 'card'
                            ? Icons.credit_card_rounded
                            : Icons.south_west_rounded,
                        color: _accent,
                        size: 20.sp),
                  ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(src,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  SizedBox(height: 3.h),
                  Text(
                    [
                      if (d.sourceAccountNumber.isNotEmpty)
                        d.sourceAccountNumber,
                      _dateLabel(d),
                    ].where((s) => s.isNotEmpty).join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 11.5.sp, color: _label),
                  ),
                  if (_isFailed(d.status)) ...[
                    SizedBox(height: 3.h),
                    Text(
                      // Friendly copy only — raw provider errors are admin-only.
                      friendlyMoneyError(d.failureCode, null),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: _error.withValues(alpha: 0.85)),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('+${_money(d.amount.toInt(), d.currency)}',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            _isDone(d.status) ? _success : Colors.white)),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: color.withValues(alpha: 0.45)),
                  ),
                  child: Text(_statusLabel(d.status, d.failureCode),
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
                border:
                    Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child:
                  Icon(Icons.south_west_rounded, color: _label, size: 32.sp),
            ),
            SizedBox(height: 16.h),
            Text('No deposits yet',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 6.h),
            Text(
              'Fund your wallet from a linked bank, card or transfer and every deposit will show up here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12.5.sp, color: _label, height: 1.4),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                padding:
                    EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text('Make a deposit',
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
            Text('Something went wrong.\nPlease try again.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 13.sp, color: _label, height: 1.4)),
            SizedBox(height: 18.h),
            TextButton(
              onPressed: () => _load(reset: true),
              style: TextButton.styleFrom(
                backgroundColor: _card,
                padding:
                    EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),
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
