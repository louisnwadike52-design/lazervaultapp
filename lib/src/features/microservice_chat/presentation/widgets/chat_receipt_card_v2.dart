import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final route = _s('deeplink_route');
    if (route.isEmpty) return;
    // Transfer / batch-transfer receipts fall back to '/transaction-history'
    // because their native receipt screen needs a full Transaction object a
    // reference can't build. But the user wants the RECEIPT, not the raw history
    // list — so for that fallback open a full-screen receipt rendered from THIS
    // payload (same look as the send-funds receipt, with download/share).
    if (route == '/transaction-history') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatReceiptFullScreen(payload: widget.payload),
        ),
      );
      return;
    }
    // Get.toNamed is no-op on unknown routes; the receipt cards specify
    // routes registered in app_routes.dart for each receipt-capable
    // feature. Native screen receives the reference via path parameter.
    Get.toNamed(route);
  }

  /// Generate a real PDF receipt and hand it to the native share sheet (so it
  /// can be saved/downloaded), mirroring the send-funds receipt flow. Works for
  /// both the in-chat card and the voice-agent receipt sheet.
  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      // iPad share-sheet popover origin (crashes without one).
      final box = context.findRenderObject() as RenderBox?;
      final origin = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : null;
      await ChatReceiptPdfService.shareReceipt(
        widget.payload,
        sharePositionOrigin: origin,
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
                      '$amount $currency'
                      '${feeNum > 0 ? ' · Fee $fee $currency' : ''}',
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
