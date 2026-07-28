import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// SendCryptoReceiptScreen renders a crypto **send** (withdrawal) receipt using
/// the shared, Revolut-style [UnifiedTransactionReceipt] — same dark card, QR
/// of the reference, and Download / Share that produce a real PNG — so it looks
/// and behaves exactly like the buy / sell / swap receipts.
///
/// A send is crypto-denominated (e.g. "5.000000 USDT" leaving the wallet), not
/// fiat, so the hero amount is passed via [UnifiedTransaction.amountDisplayOverride].
///
/// External sends land asynchronously (Quidax returns `Processing`, the terminal
/// `Done` / `Rejected` arrives later via webhook). This screen **polls**
/// `GetCryptoWithdrawalStatus` with a gentle backoff until it reaches a terminal
/// state or the poll budget is exhausted, updating the status header and the
/// on-chain txid live. Internal (Lazervault-to-Lazervault) sends are terminal
/// on submit, so no polling happens.
class SendCryptoReceiptScreen extends StatefulWidget {
  final String transactionId;
  final String reference;

  /// Crypto amount sent (major units, e.g. 5.0 USDT).
  final double amount;
  final String symbol; // e.g. USDT
  final String recipient; // destination address or Lazervault user id
  final String network; // e.g. trc20 ('' for internal)
  final String note;
  final bool isInternal;
  final DateTime createdAt;

  /// Status at navigation time: [UnifiedTransactionStatus.completed] for a
  /// terminal internal send, otherwise [UnifiedTransactionStatus.processing].
  final UnifiedTransactionStatus initialStatus;
  final String initialTxid;

  const SendCryptoReceiptScreen({
    super.key,
    required this.transactionId,
    required this.reference,
    required this.amount,
    required this.symbol,
    required this.recipient,
    required this.network,
    required this.note,
    required this.isInternal,
    required this.createdAt,
    required this.initialStatus,
    this.initialTxid = '',
  });

  @override
  State<SendCryptoReceiptScreen> createState() =>
      _SendCryptoReceiptScreenState();
}

class _SendCryptoReceiptScreenState extends State<SendCryptoReceiptScreen> {
  late UnifiedTransactionStatus _status;
  late String _txid;
  String _failReason = '';

  Timer? _timer;
  int _attempt = 0;
  // Poll budget: external withdrawals usually confirm within a couple of
  // minutes. ~24 attempts with a 3→8s backoff covers roughly 3 minutes; after
  // that we stop and leave the receipt in "Processing" — the webhook + a push
  // notification still deliver the terminal state, and re-opening from history
  // shows the final status.
  static const _maxAttempts = 24;

  CryptoGrpcClient get _client => GetIt.I<CryptoGrpcClient>();

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
    _txid = widget.initialTxid;
    if (_status == UnifiedTransactionStatus.processing) {
      _scheduleNextPoll(const Duration(seconds: 3));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleNextPoll(Duration delay) {
    _timer?.cancel();
    _timer = Timer(delay, _poll);
  }

  Future<void> _poll() async {
    if (!mounted) return;
    _attempt++;
    try {
      final resp = await _client.getCryptoWithdrawalStatus(widget.transactionId);
      final norm = _normalize(resp.status);
      if (norm == 'done') {
        if (!mounted) return;
        setState(() {
          _status = UnifiedTransactionStatus.completed;
          if (resp.txid.isNotEmpty) _txid = resp.txid;
        });
        return; // terminal — stop polling
      }
      if (norm == 'rejected') {
        if (!mounted) return;
        setState(() {
          _status = UnifiedTransactionStatus.failed;
          _failReason = resp.failReason;
        });
        return; // terminal — stop polling
      }
      // Surface an on-chain txid as soon as it appears, even while pending.
      if (resp.txid.isNotEmpty && resp.txid != _txid && mounted) {
        setState(() => _txid = resp.txid);
      }
    } catch (_) {
      // Transient network/blip — keep the receipt intact and try again.
    }
    if (!mounted || _attempt >= _maxAttempts) return;
    // Gentle backoff: 3s for the first few checks, then 6s.
    _scheduleNextPoll(Duration(seconds: _attempt < 4 ? 3 : 6));
  }

  static String _normalize(String raw) {
    final r = raw.toLowerCase().trim();
    if (r == 'done' || r == 'completed' || r == 'accepted') return 'done';
    if (r == 'rejected' || r == 'failed' || r == 'cancelled' || r == 'cancel') {
      return 'rejected';
    }
    return r;
  }

  /// Trim a crypto amount to a clean, full-precision string (no trailing zeros).
  static String _fmtCrypto(double v) {
    var s = v.toStringAsFixed(8);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
      s = s.replaceAll(RegExp(r'\.$'), '');
    }
    return s.isEmpty ? '0' : s;
  }

  UnifiedTransaction _toUnifiedTransaction() {
    final sym = widget.symbol.toUpperCase();
    final metadata = <String, dynamic>{};
    metadata[widget.isInternal ? 'To (Lazervault)' : 'To address'] =
        widget.recipient;
    if (!widget.isInternal && widget.network.isNotEmpty) {
      metadata['Network'] = widget.network.toUpperCase();
    }
    if (widget.note.isNotEmpty) metadata['Note'] = widget.note;
    if (_txid.isNotEmpty) metadata['Blockchain txid'] = _txid;
    if (_status == UnifiedTransactionStatus.failed && _failReason.isNotEmpty) {
      metadata['Reason'] = _failReason;
    }
    metadata['Network fee'] = 'Deducted by the network';
    metadata['Custody'] = 'Managed by licensed partner';

    return UnifiedTransaction(
      id: widget.transactionId,
      serviceType: TransactionServiceType.crypto,
      title: 'Send $sym',
      description: '${_fmtCrypto(widget.amount)} $sym',
      amount: widget.amount,
      amountDisplayOverride: '${_fmtCrypto(widget.amount)} $sym',
      currency: sym,
      createdAt: widget.createdAt,
      status: _status,
      flow: TransactionFlow.outgoing,
      transactionReference: widget.reference,
      metadata: metadata,
      // Per-asset hero (logo URL isn't carried on the send flow, so the
      // receipt shows the asset's initials chip — never a shared Bitcoin icon).
      assetSymbol: sym,
    );
  }

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(
      transaction: _toUnifiedTransaction(),
      fromHistory: false,
    );
  }
}
