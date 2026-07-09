import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
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
      // Stop polling after a bounded window; background reconcilers still
      // settle it and a history refresh will show the terminal state.
      _stopTimer = Timer(const Duration(minutes: 5), () => _pollTimer?.cancel());
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _stopTimer?.cancel();
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
    );
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
    };

    // Money direction: a buy spends fiat (debit), a sell returns fiat
    // (credit), a crypto→crypto swap is neither.
    final flow = switch (d.type) {
      CryptoTransactionType.buy => TransactionFlow.outgoing,
      CryptoTransactionType.sell => TransactionFlow.incoming,
      CryptoTransactionType.swap => TransactionFlow.neutral,
    };

    // The hero amount is the fiat total the user paid / received. Fall back
    // to the fiat subtotal when the total hasn't been populated yet.
    final heroAmount = d.totalAmount > 0 ? d.totalAmount : d.fiatAmount;

    final assetAmountLabel = switch (d.type) {
      CryptoTransactionType.buy => 'You receive',
      CryptoTransactionType.sell => 'You sell',
      CryptoTransactionType.swap => 'You receive',
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
      if (d.fiatAmount > 0) 'Subtotal': '$sym${_money(d.fiatAmount)}',
      if (d.tradingFee > 0) 'Trading fee': '$sym${_money(d.tradingFee)}',
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
