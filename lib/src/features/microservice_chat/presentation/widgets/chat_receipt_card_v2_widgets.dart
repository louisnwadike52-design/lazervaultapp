part of 'chat_receipt_card_v2.dart';

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
