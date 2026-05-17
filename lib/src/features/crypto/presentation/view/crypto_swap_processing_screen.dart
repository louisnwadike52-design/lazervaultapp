// crypto_swap_processing_screen.dart
//
// Bridge UI shown after the user confirms a buy/sell/swap quote. The
// saga's createSwapQuote (or confirmSwap, in the legacy path) returns
// immediately with status=submitting; the actual Quidax POST happens on
// the Kafka consumer's pod (potentially a different pod). This screen
// keeps the user oriented while we poll for the terminal state.
//
// Polling rather than WebSocket: status transitions inside one trade
// are 1–3 events over ~30s. A 3s poll covers it without the operational
// cost of a per-microservice WebSocket server. The dashboard balance
// card already subscribes to the existing BalanceWebSocketCubit for the
// post-completion balance push, so the user's dashboard updates live
// even though this screen polls.
//
// Modeled on funds/send_funds/transfer_processing_screen.dart for the
// loading visual and the "navigate to receipt on terminal" handoff.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../models/crypto_transaction_models.dart';
import 'crypto_receipt_screen.dart';
import 'crypto_transaction_history_screen.dart';

/// CryptoSwapProcessingScreen displays a spinner + live status while the
/// async submission resolves. Polls GetSwapStatus via the cubit every
/// pollInterval and navigates to the receipt when a terminal state is
/// reached.
class CryptoSwapProcessingScreen extends StatefulWidget {
  /// Crypto transaction details — used to build the receipt payload
  /// once the swap reaches a terminal state. The status field is
  /// overwritten with the real backend status before navigating.
  final CryptoTransactionDetails details;

  /// Initial backend status returned by createSwapQuote. Usually
  /// "submitting" or "swap_pending"; the screen polls until terminal.
  final String initialStatus;

  /// Backend swap transaction id used for polling.
  final String transactionId;

  /// Quidax-side swap id when already known (empty otherwise).
  final String quidaxSwapId;

  /// Poll cadence. Bounded between 1s and 5s by the dispatcher.
  final Duration pollInterval;

  /// Safety timeout — after this, we navigate to the receipt with the
  /// last-known status (typically "verifying") so the user isn't
  /// stranded on the spinner. Background workers continue reconciling.
  final Duration overallTimeout;

  const CryptoSwapProcessingScreen({
    super.key,
    required this.details,
    required this.transactionId,
    this.initialStatus = 'submitting',
    this.quidaxSwapId = '',
    this.pollInterval = const Duration(seconds: 3),
    this.overallTimeout = const Duration(seconds: 90),
  });

  @override
  State<CryptoSwapProcessingScreen> createState() =>
      _CryptoSwapProcessingScreenState();
}

class _CryptoSwapProcessingScreenState extends State<CryptoSwapProcessingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _spinController;
  Timer? _pollTimer;
  Timer? _timeoutTimer;
  String _currentStatus = 'submitting';
  String _executionPrice = '';
  String _receivedAmount = '';
  bool _terminalReached = false;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _currentStatus = widget.initialStatus;
    _seedTimers();
  }

  void _seedTimers() {
    // First poll fires immediately so the user sees fresh status if the
    // backend has already advanced past the initial state.
    Future<void>.microtask(_pollOnce);
    _pollTimer = Timer.periodic(widget.pollInterval, (_) => _pollOnce());
    _timeoutTimer = Timer(widget.overallTimeout, _handleTimeout);
  }

  /// Tap the cubit's pollSwapStatus to refresh the saga's terminal flag.
  /// The cubit holds a SwapPending → SwapCompleted/Failed/Refunded state
  /// machine; reading state in the BlocListener handles navigation.
  Future<void> _pollOnce() async {
    if (_terminalReached || !mounted) return;
    final cubit = context.read<CryptoCubit>();
    try {
      await cubit.pollSwapStatus();
    } catch (_) {
      // Polling errors are non-fatal — next tick retries. A persistent
      // failure is caught by _handleTimeout below.
    }
  }

  void _handleTimeout() {
    if (_terminalReached || !mounted) return;
    _terminalReached = true;
    _pollTimer?.cancel();
    // Navigate to receipt with verifying status so the user has a
    // landing place. Background workers continue reconciling and a
    // refresh on the receipt screen will pick up the real terminal.
    _navigateToReceipt(CryptoTransactionStatus.verifying);
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pollTimer?.cancel();
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _navigateToReceipt(CryptoTransactionStatus status) {
    if (!mounted) return;
    _pollTimer?.cancel();
    _timeoutTimer?.cancel();
    final updatedDetails = _augmentDetailsForReceipt();
    final receipt = CryptoTransactionReceipt(
      transactionId: widget.transactionId,
      transactionDetails: updatedDetails,
      timestamp: DateTime.now(),
      status: status,
    );
    Get.offNamed('/crypto/receipt', arguments: receipt);
    // Fallback navigation if /crypto/receipt isn't registered.
    Get.off(() => CryptoReceiptScreen(receipt: receipt));
  }

  /// Refresh the details with the real Quidax fill amount and execution
  /// price when the cubit observed them. Pre-fill prevents the receipt
  /// from showing 0 for a few ms while it loads fresh data.
  CryptoTransactionDetails _augmentDetailsForReceipt() {
    final d = widget.details;
    return CryptoTransactionDetails(
      type: d.type,
      cryptoName: d.cryptoName,
      cryptoSymbol: d.cryptoSymbol,
      cryptoAmount: _receivedAmount.isNotEmpty ? _receivedAmount : d.cryptoAmount,
      pricePerUnit: _executionPrice.isNotEmpty
          ? (double.tryParse(_executionPrice) ?? d.pricePerUnit)
          : d.pricePerUnit,
      fiatAmount: d.fiatAmount,
      networkFee: d.networkFee,
      tradingFee: d.tradingFee,
      totalAmount: d.totalAmount,
      paymentMethod: d.paymentMethod,
      fromCrypto: d.fromCrypto,
      toCrypto: d.toCrypto,
      cryptoId: d.cryptoId,
      fromCryptoId: d.fromCryptoId,
      toCryptoId: d.toCryptoId,
      cryptoQuantity: d.cryptoQuantity,
    );
  }

  void _onCubitState(BuildContext context, CryptoState state) {
    if (_terminalReached) return;

    if (state is SwapCompleted && state.transactionId == widget.transactionId) {
      _terminalReached = true;
      _executionPrice = state.executionPrice;
      _receivedAmount = state.receivedAmount;
      _navigateToReceipt(CryptoTransactionStatus.completed);
    } else if (state is SwapPending && state.transactionId == widget.transactionId) {
      // Still pending; surface the swap_pending headline to the user.
      // We keep polling — the cubit will emit SwapCompleted on the next
      // tick once the webhook lands or the supervisor reconciles.
      setState(() => _currentStatus = 'swap_pending');
    } else if (state is SwapFailed && state.transactionId == widget.transactionId) {
      _terminalReached = true;
      // Distinguish refunded vs hard-failed when the cubit surfaces the
      // reason. Reason strings from the saga: 'quidax_rejected',
      // 'quote_expired', 'sell_settlement_exhausted', etc.
      final reason = state.reason.toLowerCase();
      CryptoTransactionStatus mapped;
      if (reason.contains('refund') || reason.contains('settlement_exhausted')) {
        mapped = CryptoTransactionStatus.refunded;
      } else if (reason.contains('manual') || reason.contains('unknown')) {
        mapped = CryptoTransactionStatus.manualReview;
      } else {
        mapped = CryptoTransactionStatus.failed;
      }
      _navigateToReceipt(mapped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<CryptoCubit, CryptoState>(
        listener: _onCubitState,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              children: [
                // Cancel control: takes the user to the history page so
                // they're not trapped on the spinner. The trade itself
                // keeps running — backend doesn't care if the UI is open.
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => const CryptoTransactionHistoryScreen());
                    },
                    child: Text(
                      'View in History',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                _buildSpinner(),
                SizedBox(height: 32.h),
                Text(
                  _headlineForStatus(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  _subtitleForStatus(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const Spacer(),
                _buildSafetyNote(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpinner() {
    return AnimatedBuilder(
      animation: _spinController,
      builder: (context, _) {
        return Transform.rotate(
          angle: _spinController.value * 6.28318,
          child: Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF8B7CF6).withValues(alpha: 0.9),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: Center(
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0A0A0A),
                ),
                child: Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _headlineForStatus() {
    switch (_currentStatus) {
      case 'submitting':
        return 'Submitting to exchange…';
      case 'swap_pending':
        return 'Order placed, waiting for fill…';
      case 'submission_unknown':
        return 'Verifying with the exchange…';
      default:
        return 'Processing…';
    }
  }

  String _subtitleForStatus() {
    switch (_currentStatus) {
      case 'submitting':
        return 'Your order is queued. We\'ll show the result the moment Quidax confirms.';
      case 'swap_pending':
        return 'The exchange has accepted the order. Settlement usually completes in under a minute.';
      case 'submission_unknown':
        return 'We didn\'t get a clear response from the exchange. Reconciling — your funds are safe.';
      default:
        return 'This usually takes a few seconds.';
    }
  }

  Widget _buildSafetyNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: const Color(0xFF8B7CF6), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your hold and trade are safe. Closing this screen won\'t cancel the order — you can track it from Transaction History at any time.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
