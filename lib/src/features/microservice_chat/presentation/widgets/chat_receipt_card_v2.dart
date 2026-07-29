import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/chat_receipt_pdf_service.dart';

/// ChatReceiptCardV2 — generic in-chat receipt card.
///
/// Consumes the JSON shape emitted by `chat_services_shared/receipt_protocol.py`
/// (the `ReceiptCard` Pydantic model). One widget covers every transaction
/// type — crypto, transfer, insurance, exchange, split-bill, batch — because
/// the type-specific detail rendering happens in the native receipt screen
/// the deeplink opens.
///
/// Renders inline below the chat bubble:
///   ┌─────────────────────────────────────────┐
///   │ [icon] Summary line              [badge]│
///   │        ₦5,000.00 NGN · Fee ₦10           │
///   │        Ref: C2C-...                      │
///   │ ─────────────────────────────────────── │
///   │ [View receipt] [Share button]            │
///   └─────────────────────────────────────────┘
///
/// Status badge colour mapping:
///   completed     → green
///   pending       → amber
///   processing    → blue
///   failed        → red
///   refunded      → indigo
///   manual_review → purple
///
/// Tap "View receipt" pushes the deeplink_route via Get.toNamed — opens the
/// existing native receipt screen (CryptoReceiptScreen for crypto, the
/// transfers receipt sheet for transfers, etc.). The chat side never
/// re-implements receipt detail; chat is just a compact view + handoff.
class ChatReceiptCardV2 extends StatefulWidget {
  final Map<String, dynamic> payload;

  const ChatReceiptCardV2({super.key, required this.payload});

  @override
  State<ChatReceiptCardV2> createState() => _ChatReceiptCardV2State();
}

class _ChatReceiptCardV2State extends State<ChatReceiptCardV2> {
  bool _isSharing = false;

  String _s(String key) => widget.payload[key]?.toString() ?? '';

  /// Currency symbol for the amount display (₦500, not "500 NGN"). Falls back to
  /// the code + space for currencies without a common single-glyph symbol.
  String _symbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'GHS':
        return '₵';
      case 'ZAR':
        return 'R';
      case 'KES':
        return 'KSh ';
      case 'CAD':
        return 'C\$';
      default:
        return currency.isEmpty ? '' : '$currency ';
    }
  }

  Color get _statusColor {
    switch (_s('status')) {
      case 'completed':
        return const Color(0xFF10B981);
      case 'pending':
        return const Color(0xFFFB923C);
      case 'processing':
        return const Color(0xFF3B82F6);
      case 'failed':
        return const Color(0xFFEF4444);
      case 'refunded':
        return const Color(0xFF6366F1);
      case 'manual_review':
        return const Color(0xFFA855F7);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  IconData get _typeIcon {
    switch (_s('transaction_type')) {
      case 'transfer':
      case 'transfer_intl':
      case 'batch_transfer':
        return Icons.send_rounded;
      case 'crypto_buy':
      case 'crypto_sell':
      case 'crypto_swap':
        return Icons.currency_bitcoin;
      case 'crypto_send':
        return Icons.outbox;
      case 'insurance_buy':
      case 'insurance_claim':
        return Icons.shield_outlined;
      case 'exchange_convert':
        return Icons.swap_horiz_rounded;
      case 'exchange_international':
        return Icons.public_rounded;
      case 'split_bill_pay':
        return Icons.group;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  String _formatBadge(String status) {
    if (status.isEmpty) return 'UNKNOWN';
    return status
        .split('_')
        .map((p) => p.isEmpty ? p : '${p[0].toUpperCase()}${p.substring(1)}')
        .join(' ')
        .toUpperCase();
  }

  void _openDeeplink() {
    // Open the ONE canonical, Revolut-style receipt every service already uses
    // (UnifiedTransactionReceipt — Lazervault logo top-right, barcode, working
    // share + download, real transaction status), built from THIS card's
    // payload. `fromHistory: true` makes its close button pop back to the chat
    // (proper back navigation), instead of resetting to the dashboard.
    Get.to(
      () => UnifiedTransactionReceipt(
        transaction: _toUnifiedTransaction(),
        fromHistory: true,
      ),
    );
  }

  /// Build a [UnifiedTransaction] from the chat receipt payload so the shared
  /// receipt screen (used by transfers, crypto, RMB, betting, business…) can
  /// render it identically. Missing/foreign fields degrade gracefully.
  UnifiedTransaction _toUnifiedTransaction() {
    final rawExtra = widget.payload['extra'];
    final extra = rawExtra is Map
        ? rawExtra.map((k, v) => MapEntry(k.toString(), v))
        : <String, dynamic>{};
    String ex(String k) => extra[k]?.toString() ?? '';

    final amount = double.tryParse(_s('amount').replaceAll(',', '')) ?? 0.0;
    DateTime created;
    try {
      created = DateTime.parse(_s('timestamp')).toLocal();
    } catch (_) {
      created = DateTime.now();
    }

    final recipient = ex('recipient_name');
    final serviceType =
        TransactionServiceType.fromString(_serviceSlug(_s('transaction_type')));

    return UnifiedTransaction(
      id: _s('reference'),
      serviceType: serviceType,
      title: recipient.isNotEmpty ? recipient : serviceType.displayName,
      description: _s('summary_line').isNotEmpty ? _s('summary_line') : null,
      amount: amount,
      currency: _s('currency'),
      createdAt: created,
      status: UnifiedTransactionStatus.fromString(_s('status')),
      flow: _flowFor(_s('transaction_type')),
      transactionReference: _s('reference'),
      counterpartyName: recipient.isNotEmpty ? recipient : null,
      counterpartyAccount:
          ex('recipient_account').isNotEmpty ? ex('recipient_account') : null,
      metadata: <String, dynamic>{
        // Pre-format money rows WITH the currency symbol — the receipt renders
        // metadata values verbatim, so raw '10'/'510' would show as bare numbers
        // (the reported "Total says 500 without a symbol"). ₦10 / ₦510 instead.
        if (_s('fee').isNotEmpty && (double.tryParse(_s('fee')) ?? 0) > 0)
          'fee': '${_symbol(_s('currency'))}${_s('fee')}',
        if (_s('total_amount').isNotEmpty)
          'total_amount': '${_symbol(_s('currency'))}${_s('total_amount')}',
        'status': _s('status'),
        ...extra,
      },
    );
  }

  /// Map the payload's snake_case `transaction_type` to a [TransactionServiceType]
  /// enum name (camelCase). Unknown types fall back to `unknown` via fromString.
  String _serviceSlug(String type) {
    switch (type) {
      case 'transfer':
      case 'transfer_intl':
        return 'transfer';
      case 'batch_transfer':
        return 'batchTransfer';
      case 'crypto_buy':
      case 'crypto_sell':
      case 'crypto_swap':
      case 'crypto_send':
        return 'crypto';
      case 'insurance_buy':
      case 'insurance_claim':
        return 'insurance';
      case 'exchange_convert':
      case 'exchange_international':
        return 'exchange';
      case 'split_bill_pay':
        return 'splitBill';
      case 'tag_pay':
        return 'tagPay';
      case 'qr_pay':
        return 'qrPayment';
      case 'id_pay':
        return 'idPay';
      case 'giftcard_buy':
      case 'giftcard_sell':
        return 'giftCard';
      default:
        // airtime/data/electricity/water/etc. already share the enum name.
        return type;
    }
  }

  /// Money the user RECEIVES reads as incoming; everything else is an outgoing
  /// payment they initiated (direction only affects the +/- sign + colour).
  TransactionFlow _flowFor(String type) {
    switch (type) {
      case 'crypto_sell':
      case 'exchange_convert':
        return TransactionFlow.incoming;
      default:
        return TransactionFlow.outgoing;
    }
  }

  /// Generate a real PDF receipt and hand it to the native share sheet (so it
  /// can be saved/downloaded), mirroring the send-funds receipt flow. Works for
  /// both the in-chat card and the voice-agent receipt sheet.
  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      // Share the SAME Revolut-style PDF the send-funds / UnifiedTransactionReceipt
      // uses (Lazervault branding, barcode, both currencies) — built from this
      // card's payload — so the voice/chat receipt share matches the app receipt.
      await TagPayPdfService.shareUnifiedTransferReceipt(
        transaction: _toUnifiedTransaction(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not share receipt. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = _s('summary_line');
    final amount = _s('amount');
    final currency = _s('currency');
    final fee = _s('fee');
    final ref = _s('reference');
    final status = _s('status');
    final statusColor = _statusColor;
    final feeNum = double.tryParse(fee) ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_typeIcon, color: statusColor, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.isEmpty ? _formatBadge(status) : summary,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_symbol(currency)}$amount'
                      '${feeNum > 0 ? ' · Fee ${_symbol(currency)}$fee' : ''}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11,
                      ),
                    ),
                    if (ref.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Ref: $ref',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _formatBadge(status),
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _s('deeplink_route').isEmpty ? null : _openDeeplink,
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: Text(
                    'View receipt',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: statusColor,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    backgroundColor: statusColor.withValues(alpha: 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextButton.icon(
                  onPressed: _isSharing ? null : _share,
                  icon: _isSharing
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                      : const Icon(Icons.share_outlined, size: 14),
                  label: Text(
                    _isSharing ? 'Sharing…' : 'Share',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white.withValues(alpha: 0.8),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    backgroundColor: Colors.white.withValues(alpha: 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Full-screen receipt rendered straight from a ReceiptCard payload — the
/// "similar to send-funds receipt" target for transfer/batch receipts (whose
/// native per-type screen needs a full Transaction object a reference can't
/// build). Shows the same data as the inline card, full-screen, with a real
/// Download/Share (PDF).
class ChatReceiptFullScreen extends StatefulWidget {
  final Map<String, dynamic> payload;
  const ChatReceiptFullScreen({super.key, required this.payload});

  @override
  State<ChatReceiptFullScreen> createState() => _ChatReceiptFullScreenState();
}

class _ChatReceiptFullScreenState extends State<ChatReceiptFullScreen> {
  bool _isSharing = false;

  String _s(String key) => widget.payload[key]?.toString() ?? '';

  Color get _statusColor {
    switch (_s('status').toLowerCase()) {
      case 'completed':
      case 'success':
        return const Color(0xFF10B981);
      case 'failed':
      case 'error':
        return const Color(0xFFEF4444);
      case 'pending':
      case 'processing':
        return const Color(0xFFFB923C);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  String _badge(String s) => s.isEmpty
      ? 'Processing'
      : s
          .split('_')
          .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
          .join(' ');

  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      final box = context.findRenderObject() as RenderBox?;
      final origin =
          box != null ? box.localToGlobal(Offset.zero) & box.size : null;
      await ChatReceiptPdfService.shareReceipt(
        widget.payload,
        sharePositionOrigin: origin,
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not share receipt. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Widget _row(String label, String value, {bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 13)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                  )),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final amount = _s('amount');
    final currency = _s('currency');
    final fee = _s('fee');
    final total = _s('total_amount');
    final feeNum = double.tryParse(fee) ?? 0.0;
    final extra = widget.payload['extra'];
    final extraRows = <MapEntry<String, String>>[];
    if (extra is Map) {
      extra.forEach((k, v) {
        if (v == null || v is Map || v is List) return;
        final label = k
            .toString()
            .split('_')
            .map((w) =>
                w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' ');
        extraRows.add(MapEntry(label, v.toString()));
      });
    }
    final color = _statusColor;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Text('Receipt',
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: color.withValues(alpha: 0.35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(_badge(_s('status')),
                            style: GoogleFonts.inter(
                                color: color,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(height: 16),
                      Text('$amount $currency',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800)),
                      if (_s('summary_line').isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(_s('summary_line'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 13)),
                      ],
                      const SizedBox(height: 20),
                      const Divider(color: Color(0xFF2D2D2D)),
                      if (amount.isNotEmpty) _row('Amount', '$amount $currency'),
                      if (feeNum > 0) _row('Fee', '$fee $currency'),
                      if (total.isNotEmpty)
                        _row('Total', '$total $currency', bold: true),
                      if (_s('transaction_type').isNotEmpty)
                        _row('Type', _badge(_s('transaction_type'))),
                      if (_s('reference').isNotEmpty)
                        _row('Reference', _s('reference')),
                      if (_s('timestamp').isNotEmpty)
                        _row('Date', _s('timestamp')),
                      for (final e in extraRows) _row(e.key, e.value),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSharing ? null : _share,
                  icon: _isSharing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white)),
                        )
                      : const Icon(Icons.share_outlined, size: 18),
                  label: Text(_isSharing ? 'Sharing…' : 'Download / Share',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Convenience: render a list of ReceiptCard payloads (batch transfers can
/// produce N per-recipient cards). The Python protocol attaches them as a
/// list under metadata.receipt_card.
class ChatReceiptCardV2List extends StatelessWidget {
  final List<dynamic> payloads;

  const ChatReceiptCardV2List({super.key, required this.payloads});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final p in payloads)
          if (p is Map)
            ChatReceiptCardV2(payload: Map<String, dynamic>.from(p)),
      ],
    );
  }
}
