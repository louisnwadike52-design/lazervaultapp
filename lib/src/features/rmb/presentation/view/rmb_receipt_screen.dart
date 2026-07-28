import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/generated/rmb.pb.dart';
import 'package:lazervault/src/features/rmb/cubit/rmb_cubit.dart';
import 'package:lazervault/src/features/rmb/data/rmb_grpc_client.dart';
import 'package:lazervault/src/features/rmb/presentation/rmb_ui.dart';
import 'package:lazervault/src/features/rmb/presentation/widgets/rmb_send_sheet.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// RMB receipt — reuses the shared UnifiedTransactionReceipt (the same base as
/// the Send Funds phone receipt) with RMB context. For a fresh (non-history)
/// transfer it polls until the payout reaches a terminal state.
class RmbReceiptScreen extends StatefulWidget {
  final String transferId;
  final bool fromHistory;

  const RmbReceiptScreen({
    super.key,
    required this.transferId,
    this.fromHistory = false,
  });

  @override
  State<RmbReceiptScreen> createState() => _RmbReceiptScreenState();
}

class _RmbReceiptScreenState extends State<RmbReceiptScreen> {
  final RmbGrpcClient _client = GetIt.I<RmbGrpcClient>();
  Transfer? _transfer;
  String? _error;
  Timer? _poll;
  int _attempts = 0;
  // Poll a realistic payout window (~13 min): 4×3s, then every 15s up to 50
  // attempts. Klasha payouts confirm via webhook/reconciler; if it's still
  // processing after this, the final state shows when the receipt is reopened
  // from history.
  static const _maxAttempts = 50;

  @override
  void initState() {
    super.initState();
    _load(initial: true);
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _load({bool initial = false}) async {
    try {
      final resp = await _client.getTransfer(widget.transferId);
      final t = resp.transfer;
      if (!mounted) return;
      setState(() => _transfer = t);
      if (!widget.fromHistory && !_isTerminal(t.status)) {
        _schedule();
      }
    } catch (e) {
      if (!mounted) return;
      if (initial && _transfer == null) {
        setState(() => _error = e.toString());
      } else if (!widget.fromHistory && _transfer != null && !_isTerminal(_transfer!.status)) {
        // Transient error mid-poll — keep polling (don't strand on a network blip).
        _schedule();
      }
    }
  }

  void _schedule() {
    _poll?.cancel();
    if (_attempts >= _maxAttempts) return;
    _poll = Timer(Duration(seconds: _attempts < 4 ? 3 : 15), () {
      _attempts++;
      _load();
    });
  }

  bool _isTerminal(RmbStatus s) =>
      s == RmbStatus.RMB_COMPLETED ||
      s == RmbStatus.RMB_FAILED ||
      s == RmbStatus.RMB_REFUNDED;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        backgroundColor: RmbUi.bg,
        appBar: AppBar(backgroundColor: RmbUi.bg, elevation: 0),
        body: Center(
          child:
              Text(_error!, style: const TextStyle(color: RmbUi.textSecondary)),
        ),
      );
    }
    if (_transfer == null) {
      return const Scaffold(
        backgroundColor: RmbUi.bg,
        body: Center(child: CircularProgressIndicator(color: RmbUi.accent)),
      );
    }
    return UnifiedTransactionReceipt(
      transaction: _toUnified(_transfer!),
      fromHistory: widget.fromHistory,
      // RMB shows Share + Repeat (no Download) per product spec.
      showDownload: false,
      repeatColor: RmbUi.accent,
      onRepeat: _transfer!.rail == RmbRail.RAIL_UNSPECIFIED
          ? null
          : () => _repeat(_transfer!),
    );
  }

  /// Re-open the send sheet prefilled from this transfer (amount editable,
  /// recipient + purpose copied). Uses a fresh cubit so it works whether the
  /// receipt was reached fresh or from history.
  void _repeat(Transfer t) {
    showRmbSendSheet(
      context,
      rail: t.rail,
      cubit: serviceLocator<RmbCubit>(),
      repeatFrom: t,
    );
  }

  /// Recipient name in the natural format (surname-first, CJK-aware) via the
  /// shared RmbUi helper so it matches the send flow / landing / history.
  String _recipientName(Transfer t) => RmbUi.recipientName(
        surname: t.receiverLastName,
        given: t.receiverFirstName,
        fallback: t.beneficiaryName,
      );

  /// Rail-specific "who got paid + how" rows built from the transfer's
  /// beneficiary snapshot. Only non-empty values are shown.
  Map<String, String> _recipientDetail(Transfer t) {
    String maskTail(String v, {int keep = 4}) {
      final s = v.trim();
      if (s.length <= keep) return s;
      return '•••• ${s.substring(s.length - keep)}';
    }

    final out = <String, String>{};
    switch (t.rail) {
      case RmbRail.ALIPAY:
        final isEmail = t.accountIdType.toUpperCase() == 'EMAIL';
        if (t.accountNumber.isNotEmpty) {
          out[isEmail ? 'Alipay email' : 'Alipay number'] = t.accountNumber;
        }
        break;
      case RmbRail.WECHAT:
        if (t.accountNumber.isNotEmpty) {
          out['WeChat number'] = t.accountNumber;
        }
        break;
      case RmbRail.UNIONPAY:
        if (t.cardHolderName.isNotEmpty) out['Card holder'] = t.cardHolderName;
        if (t.bankName.isNotEmpty) out['Bank'] = t.bankName;
        break;
      case RmbRail.BANK:
        if (t.accountName.isNotEmpty) out['Account name'] = t.accountName;
        if (t.bankName.isNotEmpty) out['Bank'] = t.bankName;
        if (t.accountNumber.isNotEmpty) {
          out['Account number'] = maskTail(t.accountNumber);
        }
        break;
      default:
        break;
    }
    return out;
  }

  UnifiedTransaction _toUnified(Transfer t) {
    final cnyMajor = t.destAmountMinor.toInt() / 100.0;
    final name = _recipientName(t);
    return UnifiedTransaction(
      id: t.id,
      serviceType: TransactionServiceType.rmb,
      title: 'RMB to ${name.isEmpty ? "China" : name}',
      amount: cnyMajor,
      currency: 'CNY',
      amountDisplayOverride: '¥${cnyMajor.toStringAsFixed(2)}',
      createdAt: t.hasCreatedAt()
          ? t.createdAt.toDateTime().toLocal()
          : DateTime.now(),
      status: _mapStatus(t.status),
      flow: TransactionFlow.outgoing,
      transactionReference: t.reference,
      counterpartyName: name,
      metadata: {
        'Recipient': name.isEmpty ? '—' : name,
        // Rail-specific recipient identifier (bank/account, wallet number…).
        ..._recipientDetail(t),
        'Payment method': RmbUi.railLabel(t.rail),
        'Recipient gets': RmbUi.cny(t.destAmountMinor.toInt()),
        'Exchange rate': '₦${t.fxRate.toStringAsFixed(2)} / ¥1',
        // A transaction fee is shown ONLY when it wasn't folded into the rate
        // (admin "separate" mode → ourFeeMinor > 0). In margin mode the fee is
        // baked into the rate and never shown; either way our margin is
        // allocated to REVENUE internally at settlement.
        if (t.ourFeeMinor.toInt() > 0)
          'Transaction fee': RmbUi.ngn(t.ourFeeMinor.toInt()),
        'You paid': RmbUi.ngn(t.totalMinor.toInt()),
        'Purpose': t.purpose.replaceAll('_', ' '),
        'Reference': t.reference,
        // NOTE: t.failureReason is intentionally NOT surfaced here — it's a
        // backend audit field (provider error codes/messages), not user copy.
      },
    );
  }

  UnifiedTransactionStatus _mapStatus(RmbStatus s) {
    switch (s) {
      case RmbStatus.RMB_COMPLETED:
        return UnifiedTransactionStatus.completed;
      case RmbStatus.RMB_FAILED:
        return UnifiedTransactionStatus.failed;
      case RmbStatus.RMB_REFUNDED:
        return UnifiedTransactionStatus.refunded;
      case RmbStatus.RMB_PENDING_COMPLIANCE:
        return UnifiedTransactionStatus.pending;
      default:
        return UnifiedTransactionStatus.processing;
    }
  }
}
