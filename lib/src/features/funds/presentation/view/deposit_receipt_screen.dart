import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/banking/services/banking_websocket_service.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/payment_receipt_shared.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;

/// Deposit receipt — the deposit twin of the withdrawal receipt: status
/// icon/title, amount, details card, reference QR, share, and LIVE status
/// (websocket push from /ws/banking + a 5s poll backstop + pull-to-refresh).
/// The deposit settles asynchronously (bank authorization → webhook →
/// reconciler), so "Processing" here means "on its way", and the screen keeps
/// itself current until the status is terminal. Errors shown to the user are
/// always the friendly form — raw provider errors live in the admin dashboard.
class DepositReceiptScreen extends StatefulWidget {
  final double amount;
  final double fee; // charged aggregate (already net of any discount)
  final double discount; // platform-funded discount applied (0 = none)
  final String bankName; // source bank / payment method label
  final String accountNumber; // masked
  final String reference;
  final String currencySymbol;
  final String status; // pending|processing|successful|failed|cancelled
  final String failureCode;
  final String? depositId; // enables live polling when present
  final bool fromHistory;

  /// Where the money LANDED — the wallet that was credited, e.g.
  /// "Personal · NGN" or a masked account number.
  ///
  /// Optional and never inferred. A deposit receipt should name both ends, but
  /// the destination is only shown when the caller genuinely knows it: reading
  /// it off "whatever account happens to be active" would print the wrong
  /// wallet on a receipt for a deposit into a different one. Callers that don't
  /// have it pass nothing and the row is simply absent — an omitted fact beats
  /// a confident wrong one on a financial document.
  final String toAccountLabel;

  const DepositReceiptScreen({
    super.key,
    required this.amount,
    required this.fee,
    this.discount = 0,
    required this.bankName,
    required this.accountNumber,
    required this.reference,
    this.currencySymbol = '₦',
    this.status = 'processing',
    this.failureCode = '',
    this.depositId,
    this.fromHistory = false,
    this.toAccountLabel = '',
  });

  /// True while any deposit receipt is on screen. The dashboard's WebSocket
  /// "Funds Received" banner checks this so the deposit text never pops as a
  /// snackbar over the receipt that already shows the same information.
  static bool isShowing = false;

  @override
  State<DepositReceiptScreen> createState() => _DepositReceiptScreenState();
}

class _DepositReceiptScreenState extends State<DepositReceiptScreen> {
  late String status = widget.status;
  late String failureCode = widget.failureCode;
  Timer? _pollTimer;
  StreamSubscription<BankingStatusEvent>? _wsSub;
  final ScreenshotController _shot = ScreenshotController();

  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _label = Color(0xFF9CA3AF);
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);
  static const _accent = Color(0xFF7C5CFF);

  bool get _completed =>
      status == 'successful' || status == 'completed' || status == 'success';
  bool get _failed => status == 'failed' || status == 'cancelled';
  bool get _terminal => _completed || _failed;

  @override
  void initState() {
    super.initState();
    DepositReceiptScreen.isShowing = true;
    if (!_terminal && (widget.depositId ?? '').isNotEmpty) {
      _pollTimer =
          Timer.periodic(const Duration(seconds: 5), (_) => _refreshStatus());
    }
    // Live push: banking-service publishes deposit.status_update to
    // /ws/banking keyed by this reference; polling stays the backstop.
    if (!_terminal && widget.reference.isNotEmpty) {
      try {
        _wsSub = serviceLocator<BankingWebSocketService>()
            .filterByReference(widget.reference)
            .listen((_) => _refreshStatus());
      } catch (_) {/* WS unavailable — polling covers */}
    }
  }

  @override
  void dispose() {
    DepositReceiptScreen.isShowing = false;
    _pollTimer?.cancel();
    _wsSub?.cancel();
    super.dispose();
  }

  void _exit() {
    if (widget.fromHistory) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  Future<void> _refreshStatus() async {
    final id = widget.depositId;
    if (id == null || id.isEmpty || _terminal) return;
    try {
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final resp = await serviceLocator<banking_grpc.BankingServiceClient>()
          .getDepositStatus(
              banking_pb.GetDepositStatusRequest()..depositId = id,
              options: options);
      final fresh = resp.deposit.status;
      if (mounted && fresh.isNotEmpty && fresh != status) {
        setState(() {
          status = fresh;
          failureCode = resp.deposit.failureCode;
        });
      }
      if (_terminal) _pollTimer?.cancel();
    } catch (_) {
      // Transient — keep the last known status; never show raw errors here.
    }
  }

  Color get _statusColor =>
      _completed ? _success : _failed ? _error : _accent;
  IconData get _statusIcon => _completed
      ? Icons.check_rounded
      : _failed
          ? Icons.close_rounded
          : Icons.south_west_rounded;
  String get _statusTitle => _completed
      ? 'Deposit received'
      : _failed
          ? (_abandoned ? 'Deposit not completed' : 'Deposit failed')
          : 'Deposit on its way';
  bool get _abandoned =>
      failureCode == 'CHECKOUT_ABANDONED' ||
      failureCode == 'DIRECTPAY_ABANDONED' ||
      failureCode == 'DIRECTPAY_CANCELLED';
  String get _statusLabel => _completed
      ? 'Completed'
      : _failed
          ? (_abandoned ? 'Not completed' : 'Failed')
          : 'Processing';

  /// Share the receipt in the Revolut-style PDF layout (or a raster of it) —
  /// same generator as transfer receipts, with the on-screen screenshot kept
  /// as a fallback if PDF generation ever fails.
  Future<void> _shareStyledReceipt() async {
    final fmt = await pickReceiptFormat(context);
    if (fmt == null || !mounted) return;
    final text =
        'Lazervault deposit receipt · ${_money(widget.amount)} from ${widget.bankName} · ref ${widget.reference}';
    try {
      await shareBankingReceiptAs(
        format: fmt,
        shareText: text,
        details: {
          'amount': widget.amount,
          'fee': widget.fee,
          'currency': currencyCodeForSymbol(widget.currencySymbol),
          // Deposit direction: money flows FROM the source bank/method INTO
          // the user's Lazervault wallet.
          'sourceAccountName': widget.bankName,
          'sourceAccountInfo': widget.accountNumber,
          'recipientName': 'Lazervault wallet',
          'reference': widget.reference,
          'status': status,
          'transferType': 'Deposit',
          'timestamp': DateTime.now(),
        },
      );
    } catch (_) {
      await shareReceiptCapture(_shot, fileTag: 'deposit', shareText: text);
    }
  }

  /// A field is only printable when it carries a REAL value.
  ///
  /// Absence reaches this screen in several disguises depending on the caller —
  /// empty, an em-dash or hyphen placeholder from history, or a provider
  /// placeholder like "Unknown"/"Anonymous customer". Each of those printed
  /// verbatim reads to the customer as a fact about their money, so they are
  /// all treated as "we don't know" and the row is dropped.
  static bool _isKnown(String? raw) {
    final v = (raw ?? '').trim();
    if (v.isEmpty || v == '—' || v == '-' || v == 'N/A') return false;
    const placeholders = {
      'unknown', 'unknown sender', 'anonymous', 'anonymous customer',
      'null', 'nil', 'undefined',
    };
    return !placeholders.contains(v.toLowerCase());
  }

  String _money(double v) =>
      '${widget.currencySymbol}${v.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exit();
      },
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: _exit,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
          // No title — the outcome heading in the body already says what this
          // screen is, and the brand mark on the right is the identity the
          // slot is for. Same shape as the send-funds and TagPay receipts.
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 14.w),
              child: const Center(child: ReceiptBrandMark()),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: _accent,
                  backgroundColor: _card,
                  onRefresh: _refreshStatus,
                  child: Screenshot(
                    controller: _shot,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: _statusColor.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(_statusIcon,
                                color: _statusColor, size: 42.sp),
                          ),
                          SizedBox(height: 16.h),
                          Text(_statusTitle,
                              style: GoogleFonts.inter(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          SizedBox(height: 8.h),
                          Text('+${_money(widget.amount)}',
                              style: GoogleFonts.inter(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w800,
                                  color: _completed ? _success : Colors.white)),
                          SizedBox(height: 10.h),
                          _statusBadge(),
                          if (_failed) ...[
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                friendlyMoneyError(failureCode, null),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 12.5.sp,
                                    color: _error.withValues(alpha: 0.9),
                                    height: 1.35),
                              ),
                            ),
                          ],
                          SizedBox(height: 22.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: _card,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                // FROM / TO are shown only when actually known.
                                // A receipt naming the wrong counterparty is
                                // worse than one naming none, so nothing here
                                // is inferred or filled with a placeholder.
                                if (_isKnown(widget.bankName))
                                  _row('From', widget.bankName.trim()),
                                // Hide the account row when there's no real
                                // number (history passes '—' as the absent
                                // marker) — a dash-only row is just noise.
                                if (_isKnown(widget.accountNumber))
                                  _row('From account', widget.accountNumber),
                                if (_isKnown(widget.toAccountLabel))
                                  _row('To', widget.toAccountLabel.trim()),
                                if (widget.fee > 0)
                                  _row('Fee', _money(widget.fee)),
                                if (widget.discount > 0)
                                  _row('Discount', '-${_money(widget.discount)}',
                                      valueColor: _success),
                                _row('Reference', widget.reference,
                                    copyable: true),
                                _divider_(),
                                _row('Status', _statusLabel,
                                    valueColor: _statusColor),
                              ],
                            ),
                          ),
                          SizedBox(height: 22.h),
                          if (widget.reference.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: QrImageView(
                                data: widget.reference,
                                size: 96.w,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          SizedBox(height: 12.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _statusColor.withValues(alpha: 0.4)),
      ),
      child: Text(_statusLabel,
          style: GoogleFonts.inter(
              color: _statusColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700)),
    );
  }

  Widget _row(String label, String value,
      {Color? valueColor, bool copyable = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96.w,
            child: Text(label,
                style: GoogleFonts.inter(fontSize: 13.sp, color: _label)),
          ),
          Expanded(
            child: GestureDetector(
              onTap: copyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Copied', style: GoogleFonts.inter()),
                          backgroundColor: _success,
                          duration: const Duration(seconds: 1)));
                    }
                  : null,
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: valueColor ?? Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider_() =>
      Divider(color: _divider, height: 18.h, thickness: 1);

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _shareStyledReceipt,
              icon: Icon(Icons.ios_share_rounded, size: 18.sp),
              label: Text('Share',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: _divider),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _exit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text('Done',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
