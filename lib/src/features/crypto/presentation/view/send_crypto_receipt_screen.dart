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
  final String narration;
  final bool isInternal;
  final DateTime? createdAt;

  /// Status at navigation time: [UnifiedTransactionStatus.completed] for a
  /// terminal internal send, otherwise [UnifiedTransactionStatus.processing].
  final UnifiedTransactionStatus initialStatus;
  final String initialTxid;

  /// Lookup mode: hydrate EVERYTHING from the backend by reference (or
  /// transactionId). Used when opening a receipt without an in-memory
  /// snapshot — e.g. tapping the crypto money bubble in a p2p conversation
  /// or a send row in crypto history. The server authorizes sender OR
  /// (internal) recipient.
  final bool lookup;

  const SendCryptoReceiptScreen({
    super.key,
    required this.transactionId,
    required this.reference,
    required this.amount,
    required this.symbol,
    required this.recipient,
    required this.network,
    required this.note,
    this.narration = '',
    required this.isInternal,
    required this.createdAt,
    required this.initialStatus,
    this.initialTxid = '',
  }) : lookup = false;

  /// Hydrate the receipt entirely from the backend. Pass a [reference]
  /// (CRYPTO-SEND-*) or a [transactionId]; the rest is fetched.
  const SendCryptoReceiptScreen.fromLookup({
    super.key,
    this.reference = '',
    this.transactionId = '',
  })  : lookup = true,
        amount = 0,
        symbol = '',
        recipient = '',
        network = '',
        note = '',
        narration = '',
        isInternal = false,
        createdAt = null,
        initialStatus = UnifiedTransactionStatus.processing,
        initialTxid = '';

  @override
  State<SendCryptoReceiptScreen> createState() =>
      _SendCryptoReceiptScreenState();
}

class _SendCryptoReceiptScreenState extends State<SendCryptoReceiptScreen> {
  late UnifiedTransactionStatus _status;
  late String _txid;
  String _failReason = '';
  // LazerVault crypto %-fee + total (amount+fee), crypto-denominated, from the
  // withdrawal status endpoint. Empty until the first status fetch returns.
  String _feeDecimal = '';
  String _totalDecimal = '';

  // Receipt fields — snapshot-seeded (normal path) or backend-hydrated
  // (lookup path: p2p bubble / history tap).
  late bool _loaded;
  late String _transactionId;
  late String _reference;
  double _amount = 0;
  String _symbol = '';
  String _recipient = '';
  String _network = '';
  String _note = '';
  String _narration = '';
  bool _isInternal = false;
  DateTime _createdAt = DateTime.now();
  bool _lookupFailed = false;

  Timer? _timer;
  int _attempt = 0;
  // Fast-poll budget: external withdrawals usually confirm within a couple of
  // minutes. ~24 attempts with a 3→6s backoff covers roughly 3 minutes; after
  // that the receipt drops to a SLOW 30s poll (never silently gives up) — the
  // webhook + push still deliver the terminal state if the screen is closed.
  static const _maxAttempts = 24;

  CryptoGrpcClient get _client => GetIt.I<CryptoGrpcClient>();

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
    _txid = widget.initialTxid;
    _transactionId = widget.transactionId;
    _reference = widget.reference;
    _amount = widget.amount;
    _symbol = widget.symbol;
    _recipient = widget.recipient;
    _network = widget.network;
    _note = widget.note;
    _narration = widget.narration;
    _isInternal = widget.isInternal;
    _createdAt = widget.createdAt ?? DateTime.now();
    _loaded = !widget.lookup;
    if (widget.lookup) {
      _scheduleNextPoll(const Duration(milliseconds: 50));
    } else if (_status == UnifiedTransactionStatus.processing) {
      _scheduleNextPoll(const Duration(seconds: 3));
    } else {
      // Already terminal (e.g. an instant internal sub→sub send): still do ONE
      // status fetch so the receipt can show the LazerVault fee + total. _poll
      // returns without rescheduling once the status is terminal.
      _scheduleNextPoll(const Duration(milliseconds: 100));
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

  /// Hydrate every receipt field from a status response (lookup mode; also
  /// backfills note/narration/recipient on the snapshot path when absent).
  void _hydrateFrom(dynamic resp) {
    _transactionId = resp.transactionId;
    if ((resp.reference as String).isNotEmpty) _reference = resp.reference;
    final amt = double.tryParse(resp.amountDecimal) ?? _amount;
    _amount = amt;
    if ((resp.currency as String).isNotEmpty) {
      _symbol = (resp.currency as String).toUpperCase();
    }
    _isInternal = resp.recipientType == 'internal';
    if ((resp.recipientUsername as String).isNotEmpty) {
      _recipient = resp.recipientUsername;
    } else if (_recipient.isEmpty) {
      _recipient = resp.fundUid;
    }
    if ((resp.network as String).isNotEmpty) _network = resp.network;
    if ((resp.transactionNote as String).isNotEmpty) {
      _note = resp.transactionNote;
    }
    if ((resp.narration as String).isNotEmpty) _narration = resp.narration;
    final created = DateTime.tryParse(resp.createdAt);
    if (created != null) _createdAt = created.toLocal();
    _loaded = true;
  }

  Future<void> _poll() async {
    if (!mounted) return;
    _attempt++;
    try {
      final resp = _transactionId.isNotEmpty
          ? await _client.getCryptoWithdrawalStatus(_transactionId)
          : await _client.getCryptoWithdrawalByReference(_reference);
      if (widget.lookup && mounted) {
        setState(() => _hydrateFrom(resp));
      }
      // Capture the LazerVault fee + total as soon as the status endpoint carries
      // them (independent of terminal state, so instant internal sends get it too).
      if (mounted &&
          (resp.feeDecimal != _feeDecimal ||
              resp.totalDecimal != _totalDecimal)) {
        setState(() {
          _feeDecimal = resp.feeDecimal;
          _totalDecimal = resp.totalDecimal;
        });
      }
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
      // Transient network/blip — keep the receipt intact and try again. In
      // lookup mode with nothing loaded yet, surface a retryable error state.
      if (widget.lookup && !_loaded && mounted) {
        setState(() => _lookupFailed = true);
      }
    }
    if (!mounted) return;
    if (_attempt >= _maxAttempts) {
      // Slow keep-alive: check every 30s instead of silently stopping on
      // an eternal "Processing" with no way to refresh.
      _scheduleNextPoll(const Duration(seconds: 30));
      return;
    }
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
    final sym = _symbol.toUpperCase();
    final metadata = <String, dynamic>{};
    metadata[_isInternal ? 'To (Lazervault)' : 'To address'] = _recipient;
    if (!_isInternal && _network.isNotEmpty) {
      metadata['Network'] = _network.toUpperCase();
    }
    if (_note.isNotEmpty) metadata['Note'] = _note;
    if (_narration.isNotEmpty) metadata['Narration'] = _narration;
    if (_txid.isNotEmpty) metadata['Blockchain txid'] = _txid;
    if (_status == UnifiedTransactionStatus.failed && _failReason.isNotEmpty) {
      metadata['Reason'] = _failReason;
    }
    // LazerVault crypto %-fee (when configured/charged) + the total debited,
    // both in the sent asset. Shown only when there's a real fee — a 0-fee send
    // stays clean. (The fixed FIAT send fee, when set, shows in the user's fiat
    // transaction history as its own wallet debit.)
    final feeVal = double.tryParse(_feeDecimal) ?? 0;
    if (feeVal > 0) {
      metadata['LazerVault fee'] = '${_fmtCrypto(feeVal)} $sym';
      final totalVal = double.tryParse(_totalDecimal) ?? 0;
      if (totalVal > 0) {
        metadata['Total sent'] = '${_fmtCrypto(totalVal)} $sym';
      }
    }
    metadata['Network fee'] = 'Deducted by the network';
    metadata['Custody'] = 'Managed by licensed partner';

    return UnifiedTransaction(
      id: _transactionId,
      serviceType: TransactionServiceType.crypto,
      title: 'Send $sym',
      description: '${_fmtCrypto(_amount)} $sym',
      amount: _amount,
      amountDisplayOverride: '${_fmtCrypto(_amount)} $sym',
      currency: sym,
      createdAt: _createdAt,
      status: _status,
      flow: TransactionFlow.outgoing,
      transactionReference: _reference,
      metadata: metadata,
      // Per-asset hero (logo URL isn't carried on the send flow, so the
      // receipt shows the asset's initials chip — never a shared Bitcoin icon).
      assetSymbol: sym,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
            backgroundColor: const Color(0xFF0A0A0A),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white)),
        body: Center(
          child: _lookupFailed
              ? Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.wifi_off_rounded,
                      color: Colors.white54, size: 40),
                  const SizedBox(height: 12),
                  const Text('Something went wrong. Please try again.',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      setState(() => _lookupFailed = false);
                      _scheduleNextPoll(Duration.zero);
                    },
                    child: const Text('Retry'),
                  ),
                ])
              : const CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return UnifiedTransactionReceipt(
      transaction: _toUnifiedTransaction(),
      fromHistory: widget.lookup,
      // Pull-to-refresh runs an immediate status poll (external sends can sit
      // in Processing for a while — this beats waiting for the slow poll).
      onRefresh: _poll,
    );
  }
}
