import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../models/crypto_transaction_models.dart';

/// CryptoReceiptScreen renders a crypto buy / sell / swap receipt using the
/// shared, Revolut-style [UnifiedTransactionReceipt] so it looks and behaves
/// exactly like every other receipt on the platform: dark card layout, a QR
/// code of the reference, and Download / Share that produce a real PNG image
/// (not a text blob or a stub).
///
/// The crypto-specific numbers (asset, filled amount, execution rate, fees,
/// custody) are carried in the [UnifiedTransaction.metadata] map, which the
/// unified receipt automatically renders as detail rows.
///
/// The public surface is unchanged — every call site still constructs a
/// [CryptoTransactionReceipt] and pushes `CryptoReceiptScreen(receipt: …)`.
class CryptoReceiptScreen extends StatefulWidget {
  final CryptoTransactionReceipt receipt;

  /// When true the back button returns to the previous screen (history);
  /// when false it lands the user on the dashboard (post-trade flow).
  final bool fromHistory;

  const CryptoReceiptScreen({
    super.key,
    required this.receipt,
    this.fromHistory = false,
  });

  @override
  State<CryptoReceiptScreen> createState() => _CryptoReceiptScreenState();
}

class _CryptoReceiptScreenState extends State<CryptoReceiptScreen> {
  late CryptoTransactionReceipt _receipt;
  Timer? _pollTimer;
  Timer? _stopTimer;
  bool _terminal = false;
  // Captured so dispose() can refresh without a context lookup.
  CryptoCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _receipt = widget.receipt;
    _terminal = _isTerminal(_receipt.status);
    // Live receipt: async trades land here in a pending/processing state. Poll
    // the swap status until it resolves, then flip the badge to completed/failed
    // AND refresh the wallet/holdings so both the receipt and the balance
    // reflect the finished trade — without the user leaving this screen. Skip
    // when opened from history (already terminal) or already terminal.
    if (!widget.fromHistory && !_terminal) {
      Future<void>.microtask(_pollOnce);
      _pollTimer =
          Timer.periodic(const Duration(seconds: 4), (_) => _pollOnce());
      // Slow the cadence after a bounded window rather than stopping.
      //
      // The old window STOPPED polling at 5 minutes, which is SHORTER than
      // trades actually take:
      // a real production buy took 6m08s from creation to completion (Quidax
      // confirms via webhook, and the forward-completion + delivery legs run
      // after that). The receipt gave up at 5 minutes still showing
      // "processing", and because it gave up BEFORE the terminal state
      // arrived, refreshHoldingsAfterSwap() never fired — so the balance and
      // the transaction history kept showing the stale in-flight state until
      // something else happened to refresh them. That is exactly the
      // "receipt says one thing, history says another" mismatch.
      _stopTimer = Timer(_fastPollWindow, _slowDownPolling);
    }
  }

  /// How long to poll at the responsive 4s cadence. Past this the trade is
  /// slower than typical, so we keep watching at a slower cadence rather than
  /// giving up.
  static const Duration _fastPollWindow = Duration(minutes: 2);

  /// The fast window elapsed with the trade still in flight. Don't abandon it:
  /// drop to a slow cadence so the badge still resolves on its own if the
  /// user stays, and refresh holdings/history now so the rest of the app stops
  /// showing the pre-trade view.
  void _slowDownPolling() {
    _pollTimer?.cancel();
    if (!mounted) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 20), (_) => _pollOnce());
    _refreshAfterTrade();
  }

  /// Pull the wallet/holdings and transaction history back into sync. Safe to
  /// call more than once and safe when no cubit is in scope.
  void _refreshAfterTrade() {
    // Uses the cubit captured in didChangeDependencies, not context.read, so
    // this is also callable from dispose() — where the element is already
    // defunct and a lookup would throw.
    final c = _cubit;
    // isClosed guard: when the receipt is popped as part of tearing down the
    // whole flow, the BlocProvider that owns this cubit can already have
    // closed it. Emitting on a closed cubit throws, and from dispose() that
    // surfaces as an unhandled framework error on an otherwise successful
    // trade.
    if (c == null || c.isClosed) return;
    unawaited(c.refreshHoldingsAfterSwap());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      _cubit = context.read<CryptoCubit>();
    } catch (_) {
      _cubit = null; // deep-linked receipt: no cubit in scope
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _stopTimer?.cancel();
    // Leaving a receipt whose trade is STILL in flight used to leave the
    // wallet and the transaction history holding the pre-trade view, so the
    // list the user landed back on disagreed with the receipt they had just
    // been looking at. Refresh on the way out; the cubit was captured above so
    // this is safe here.
    if (!_terminal) _refreshAfterTrade();
    super.dispose();
  }

  bool _isTerminal(CryptoTransactionStatus s) =>
      s == CryptoTransactionStatus.completed ||
      s == CryptoTransactionStatus.failed ||
      s == CryptoTransactionStatus.refunded;

  Future<void> _pollOnce() async {
    if (_terminal || !mounted) return;
    CryptoCubit cubit;
    try {
      cubit = context.read<CryptoCubit>();
    } catch (_) {
      return; // no cubit in scope (e.g. deep-linked receipt) — nothing to poll
    }
    try {
      await cubit.pollSwapStatus();
    } catch (_) {}
    if (!mounted) return;
    final st = cubit.state;
    if (st is SwapCompleted && st.transactionId == _receipt.transactionId) {
      _applyTerminal(CryptoTransactionStatus.completed);
      // Reflect the settled trade on the wallet + holdings.
      unawaited(cubit.refreshHoldingsAfterSwap());
    } else if (st is SwapFailed && st.transactionId == _receipt.transactionId) {
      _applyTerminal(CryptoTransactionStatus.failed);
      // A failed trade changes the balance too (the fiat hold is released or
      // refunded), so the rest of the app must not keep the in-flight view.
      unawaited(cubit.refreshHoldingsAfterSwap());
    }
  }

  void _applyTerminal(CryptoTransactionStatus status) {
    if (!mounted) return;
    _terminal = true;
    _pollTimer?.cancel();
    _stopTimer?.cancel();
    setState(() {
      _receipt = CryptoTransactionReceipt(
        transactionId: _receipt.transactionId,
        transactionDetails: _receipt.transactionDetails,
        timestamp: _receipt.timestamp,
        status: status,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(
      transaction: _toUnifiedTransaction(_receipt),
      fromHistory: widget.fromHistory,
      // Pull-to-refresh forces an immediate status re-check (the same poll
      // the 4s timer runs) — useful once the bounded polling window lapses.
      onRefresh: _pollOnce,
    );
  }

  /// Resolve the traded asset's real logo URL from the crypto cubit's loaded
  /// catalogue (supportedAssets ∪ cryptos), matched by backend id first then
  /// ticker. Returns '' when not resolvable (deep-linked receipt, no cubit) —
  /// the receipt hero then falls back to the asset's initials chip, never a
  /// shared Bitcoin logo.
  String _resolveAssetImage(CryptoTransactionDetails d) {
    CryptoCubit cubit;
    try {
      cubit = context.read<CryptoCubit>();
    } catch (_) {
      return '';
    }
    final st = cubit.state;
    if (st is! CryptosLoaded) return '';
    // For a swap the hero represents the asset the user RECEIVES.
    final wantId = (d.type == CryptoTransactionType.swap
            ? d.toCryptoId
            : d.cryptoId) ??
        '';
    final wantSymbol = (d.type == CryptoTransactionType.swap
            ? (d.toCrypto ?? d.cryptoSymbol)
            : d.cryptoSymbol)
        .toUpperCase();
    final pool = <Crypto>[...st.supportedAssets, ...st.cryptos];
    for (final c in pool) {
      if (c.image.isEmpty) continue;
      if (wantId.isNotEmpty && c.id == wantId) return c.image;
      if (c.symbol.toUpperCase() == wantSymbol) return c.image;
    }
    return '';
  }

  /// The asset ticker the receipt hero should show (received asset for swaps).
  String _heroAssetSymbol(CryptoTransactionDetails d) {
    if (d.type == CryptoTransactionType.swap) {
      final to = (d.toCrypto ?? '').trim();
      if (to.isNotEmpty) return to.toUpperCase();
    }
    return d.cryptoSymbol.toUpperCase();
  }

  UnifiedTransaction _toUnifiedTransaction(CryptoTransactionReceipt r) {
    final d = r.transactionDetails;
    final fiatCurrency = CurrencySymbols.currentCurrency;
    final sym = CurrencySymbols.currentSymbol;

    final title = switch (d.type) {
      CryptoTransactionType.buy => 'Buy ${d.cryptoSymbol}',
      CryptoTransactionType.sell => 'Sell ${d.cryptoSymbol}',
      CryptoTransactionType.swap =>
        'Swap ${d.fromCrypto ?? ''} → ${d.toCrypto ?? d.cryptoSymbol}',
      CryptoTransactionType.send => 'Send ${d.cryptoSymbol}',
      CryptoTransactionType.deposit => 'Deposit ${d.cryptoSymbol}',
    };

    // Money direction: a buy spends fiat (debit), a sell returns fiat
    // (credit), a crypto→crypto swap is neither. A send moves crypto out
    // (outgoing); a deposit brings crypto in (incoming).
    final flow = switch (d.type) {
      CryptoTransactionType.buy => TransactionFlow.outgoing,
      CryptoTransactionType.sell => TransactionFlow.incoming,
      CryptoTransactionType.swap => TransactionFlow.neutral,
      CryptoTransactionType.send => TransactionFlow.outgoing,
      CryptoTransactionType.deposit => TransactionFlow.incoming,
    };

    // The hero amount is the fiat total the user paid / received. Fall back
    // to the fiat subtotal when the total hasn't been populated yet.
    final heroAmount = d.totalAmount > 0 ? d.totalAmount : d.fiatAmount;

    final assetAmountLabel = switch (d.type) {
      CryptoTransactionType.buy => 'You receive',
      CryptoTransactionType.sell => 'You sell',
      CryptoTransactionType.swap => 'You receive',
      CryptoTransactionType.send => 'You send',
      CryptoTransactionType.deposit => 'You receive',
    };

    final metadata = <String, dynamic>{
      'Asset': d.cryptoName,
      if (d.type == CryptoTransactionType.swap && (d.fromCrypto ?? '').isNotEmpty)
        'From asset': d.fromCrypto!,
      if (d.type == CryptoTransactionType.swap && (d.toCrypto ?? '').isNotEmpty)
        'To asset': d.toCrypto!,
      if (d.cryptoAmount.isNotEmpty)
        assetAmountLabel: '${d.cryptoAmount} ${d.cryptoSymbol}',
      if (d.pricePerUnit > 0)
        'Rate': '1 ${d.cryptoSymbol} = $sym${_money(d.pricePerUnit)}',
      // No 'Subtotal' / 'Trading fee' split: the platform margin is carried in
      // the RATE the user was quoted and accepted, not charged on top. Showing
      // it as a separate line implied a second deduction and made the total
      // look inconsistent with the rate right above it. See
      // cryptoPlatformFeePolicy.
      //
      // Network fee stays: it is a real third-party on-chain cost the user
      // genuinely pays on a send, not our margin.
      if (d.networkFee > 0) 'Network fee': '$sym${_money(d.networkFee)}',
      if (heroAmount > 0) 'Total': '$sym${_money(heroAmount)}',
      'Payment method': d.paymentMethod,
      'Settlement': 'Instant',
      'Custody': 'Managed by licensed partner',
    };

    return UnifiedTransaction(
      id: r.transactionId,
      serviceType: TransactionServiceType.crypto,
      title: title,
      description: d.cryptoAmount.isNotEmpty
          ? '${d.cryptoAmount} ${d.cryptoSymbol}'
          : null,
      amount: heroAmount,
      currency: fiatCurrency,
      createdAt: r.timestamp,
      status: _mapStatus(r.status),
      flow: flow,
      transactionReference: r.transactionId,
      metadata: metadata,
      assetSymbol: _heroAssetSymbol(d),
      assetImageUrl: _resolveAssetImage(d),
    );
  }

  UnifiedTransactionStatus _mapStatus(CryptoTransactionStatus status) {
    switch (status) {
      case CryptoTransactionStatus.completed:
        return UnifiedTransactionStatus.completed;
      case CryptoTransactionStatus.pending:
      case CryptoTransactionStatus.verifying:
      // Awaiting exchange settlement / reconciliation — "processing" reads
      // more honestly to the user than "pending" for an in-flight trade.
        return UnifiedTransactionStatus.processing;
      case CryptoTransactionStatus.failed:
        return UnifiedTransactionStatus.failed;
      case CryptoTransactionStatus.refunded:
        return UnifiedTransactionStatus.refunded;
      case CryptoTransactionStatus.manualReview:
        return UnifiedTransactionStatus.pending;
    }
  }

  String _money(double value) => NumberFormat('#,##0.00').format(value);
}

/// Transaction receipt model — constructed by the buy/sell/swap flow and the
/// transaction-history screen, then handed to [CryptoReceiptScreen].
class CryptoTransactionReceipt {
  final String transactionId;
  final CryptoTransactionDetails transactionDetails;
  final DateTime timestamp;
  final CryptoTransactionStatus status;

  const CryptoTransactionReceipt({
    required this.transactionId,
    required this.transactionDetails,
    required this.timestamp,
    required this.status,
  });
}
