import 'dart:async';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/funds_transfer/services/transfer_websocket_service.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:flutter/material.dart';
import 'chat_receipt_extras.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_details_sheet.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/chat_receipt_pdf_service.dart';
part 'chat_receipt_card_v2_widgets.dart';

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

  /// Status as of NOW, when it has moved on from what the agent sent.
  ///
  /// V2 rendered `payload['status']` forever. V1 — the card this one replaced
  /// — already knew better and polled, so the newer, preferred card was the
  /// weaker one: an external transfer that settles a minute after the agent
  /// answers kept reading "Pending" in chat and in voice. A user who sees that
  /// re-sends, or asks support about money the recipient already has.
  ///
  /// Two sources, in order of preference:
  ///   1. The live socket (/ws/transfer). Instant, and now that the gateway
  ///      carries `reference` it can be matched to this exact card.
  ///   2. A bounded poll, identical in shape to V1's, for when the socket is
  ///      unavailable. Stops on a terminal status and gives up after
  ///      [_maxStatusPolls] — a transcript can hold many receipts, and an
  ///      unbounded timer per card would have old conversations quietly
  ///      hammering the gateway forever.
  String? _liveStatus;
  StreamSubscription<TransferStatusEvent>? _wsSub;
  Timer? _statusTimer;
  int _statusPolls = 0;
  bool _statusFetching = false;
  static const int _maxStatusPolls = 20;
  static const Duration _statusInterval = Duration(seconds: 6);

  /// Reads a payload field. `status` is special-cased so every existing render
  /// site picks up the live value without each one having to know about it.
  String _s(String key) {
    if (key == 'status' && _liveStatus != null) return _liveStatus!;
    return widget.payload[key]?.toString() ?? '';
  }

  static bool _isTerminalStatus(String s) {
    switch (s.toLowerCase()) {
      case 'completed':
      case 'success':
      case 'successful':
      case 'paid':
      case 'settled':
      case 'failed':
      case 'declined':
      case 'rejected':
      case 'reversed':
      case 'refunded':
      case 'cancelled':
      case 'canceled':
        return true;
      default:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _startLiveStatus();
  }

  @override
  void dispose() {
    _wsSub?.cancel();
    _statusTimer?.cancel();
    super.dispose();
  }

  /// Only for a receipt that has somewhere to go: unsettled, and with a
  /// reference to look itself up by.
  void _startLiveStatus() {
    final ref = _s('reference');
    if (ref.isEmpty) return;
    if (_isTerminalStatus(_s('status'))) return;
    // Transfers are the only kind this feed reports on.
    final type = _s('transaction_type').toLowerCase();
    if (type.isNotEmpty && !type.contains('transfer')) return;

    unawaited(_subscribeSocket(ref));

    _statusTimer = Timer.periodic(_statusInterval, (_) => _refreshStatus());
    // Check once immediately: reopening an old chat should correct a stale
    // card now, not six seconds from now.
    unawaited(_refreshStatus());
  }

  Future<void> _subscribeSocket(String ref) async {
    try {
      final ws = serviceLocator<TransferWebSocketService>();
      _wsSub = ws.transferUpdates.listen((e) {
        if (!mounted) return;
        if (e.reference.isEmpty || e.reference != ref) return;
        _applyStatus(e.status);
        if (e.isTerminal) {
          _statusTimer?.cancel();
          _wsSub?.cancel();
        }
      });
      final storage = serviceLocator<SecureStorageService>();
      final userId = await storage.getCurrentUserId() ?? await storage.getUserId();
      final token = await storage.getAccessToken();
      if (userId != null && token != null && userId.isNotEmpty && token.isNotEmpty) {
        // Idempotent: the shared service early-returns when already connected.
        await ws.connect(userId: userId, accessToken: token);
      }
    } catch (_) {
      // The socket is an optimisation. The poll below is the guarantee.
    }
  }

  void _applyStatus(String next) {
    if (!mounted || next.isEmpty) return;
    if (next.toLowerCase() == _s('status').toLowerCase()) return;
    // Re-render silently — the badge settles, nothing demands attention.
    setState(() => _liveStatus = next);
  }

  Future<void> _refreshStatus() async {
    if (_statusFetching || !mounted) return;
    if (_statusPolls >= _maxStatusPolls) {
      _statusTimer?.cancel();
      return;
    }
    final ref = _s('reference');
    if (ref.isEmpty) return;
    _statusFetching = true;
    _statusPolls++;
    try {
      final snap = await serviceLocator<IPaymentsTransferDataSource>()
          .getTransferStatus(reference: ref);
      if (!mounted || snap == null || snap.status.isEmpty) return;
      _applyStatus(snap.status);
      if (snap.isTerminal) _statusTimer?.cancel();
    } catch (_) {
      // Keep the last known status. A failed poll must never downgrade a card
      // that already reads as successful.
    } finally {
      _statusFetching = false;
    }
  }

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

  /// Opens the SAME transaction details sheet the history screen uses —
  /// amount, parties, reference, timestamps, and the Repeat / Receipt
  /// actions. It was private to DashboardTransactionHistoryScreen, so a user
  /// who sent money by talking to the assistant had no way to reach it; they
  /// could only jump out to the full receipt screen or back to a list.
  ///
  /// Built from this card's own payload, so it works identically in general
  /// chat, per-service chat and voice, with no extra round trip.
  void _openDetailsSheet() {
    TransactionDetailsSheet.show(context, _toUnifiedTransaction());
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
        // Hidden keys stripped: this metadata is rendered as rows too, so
        // spreading extra wholesale put the same UUIDs and kobo duplicates on the
        // inline card that the full-screen one was showing.
        ...Map<String, dynamic>.fromEntries(
          extra.entries.where(
            (e) => !kChatReceiptHiddenExtras.contains(e.key),
          ),
        ),
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
    // Recipient identity for the header avatar (transfers). Lives in `extra`;
    // empty for non-transfer receipts or external/bank recipients → icon box.
    final extra = widget.payload['extra'];
    final recipientImage =
        (extra is Map ? extra['recipient_image_url']?.toString() : null) ?? '';
    final recipientName = (extra is Map
            ? (extra['recipient_display_name'] ?? extra['recipient_name'])
                ?.toString()
            : null) ??
        '';
    final hasRecipientIdentity =
        recipientImage.isNotEmpty || recipientName.isNotEmpty;

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
              // Recipient avatar (internal transfers) — matches the PIN pad the
              // user just confirmed on; otherwise the transaction-type icon box.
              if (hasRecipientIdentity)
                UserAvatar(
                  size: 36,
                  imageUrl: recipientImage.isEmpty ? null : recipientImage,
                  firstName: recipientName.split(' ').first,
                  lastName: recipientName.split(' ').length > 1
                      ? recipientName.split(' ').sublist(1).join(' ')
                      : null,
                )
              else
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  onPressed: _openDetailsSheet,
                  icon: const Icon(Icons.info_outline, size: 14),
                  label: Text(
                    'Details',
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
                  onPressed:
                      _s('deeplink_route').isEmpty ? null : _openDeeplink,
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
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
