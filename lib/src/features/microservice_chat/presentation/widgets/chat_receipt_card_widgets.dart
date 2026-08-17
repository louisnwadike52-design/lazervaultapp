part of 'chat_receipt_card.dart';

/// Loading skeleton shown while receipt data is being fetched or loaded.
class ChatReceiptLoadingCard extends StatelessWidget {
  const ChatReceiptLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header skeleton
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: LazerVaultLoader.tiny(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 60,
                      height: 11,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D3D),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Amount skeleton
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D3D),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          // Info text
          Row(
            children: [
              const Icon(
                Icons.receipt_long,
                color: Color(0xFF9CA3AF),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Loading receipt...',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Compact receipt card shown inline in the chat bubble (Revolut-style).
/// Shows a loading skeleton initially, then lazily loads the receipt data.
class ChatReceiptCard extends StatefulWidget {
  final TransferReceiptData receipt;

  const ChatReceiptCard({super.key, required this.receipt});

  @override
  State<ChatReceiptCard> createState() => _ChatReceiptCardState();
}

class _ChatReceiptCardState extends State<ChatReceiptCard> {
  bool _isLoading = true;
  TransferReceiptData? _loadedReceipt;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Show loading skeleton first, then load receipt data
    _loadReceiptData();
  }

  Future<void> _loadReceiptData() async {
    // Simulate a brief delay to show the loading skeleton
    // In production, this would fetch the receipt URL or validate it
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    // If receiptUrl is provided, validate it by checking if it's accessible
    if (widget.receipt.receiptUrl != null && widget.receipt.receiptUrl!.isNotEmpty) {
      try {
        final response = await http.head(
          Uri.parse(widget.receipt.receiptUrl!),
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () => http.Response('Timeout', 408),
        );

        if (mounted) {
          if (response.statusCode == 200) {
            // Receipt URL is valid
            setState(() {
              _isLoading = false;
              _loadedReceipt = widget.receipt;
            });
          } else {
            // URL not accessible, still show receipt but without PDF preview
            setState(() {
              _isLoading = false;
              _loadedReceipt = widget.receipt;
              _errorMessage = 'PDF unavailable';
            });
          }
        }
      } catch (e) {
        // Network error, still show the receipt
        if (mounted) {
          setState(() {
            _isLoading = false;
            _loadedReceipt = widget.receipt;
            _errorMessage = 'Connection error';
          });
        }
      }
    } else {
      // No receipt URL provided, just show the receipt data
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadedReceipt = widget.receipt;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading skeleton while data is being fetched
    if (_isLoading) {
      return const ChatReceiptLoadingCard();
    }

    // Show error state if loading failed
    if (_errorMessage != null) {
      return _buildReceiptCard(_loadedReceipt!, showError: true);
    }

    // Show the actual receipt card
    return _buildReceiptCard(_loadedReceipt!);
  }

  Widget _buildReceiptCard(TransferReceiptData r, {bool showError = false}) {
    return GestureDetector(
      onTap: () => _openFullScreenReceipt(context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: r.isSuccess
                ? const Color(0xFF10B981).withValues(alpha: 0.3)
                : const Color(0xFFEF4444).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: r.isSuccess
                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                    : const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: r.isSuccess
                          ? const Color(0xFF10B981).withValues(alpha: 0.2)
                          : const Color(0xFFEF4444).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      r.isSuccess ? Icons.check : Icons.close,
                      color: r.isSuccess
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r.isSuccess
                              ? '${r.transferTypeDisplay} Successful'
                              : '${r.transferTypeDisplay} ${r.status}',
                          style: TextStyle(
                            color: r.isSuccess
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          r.transferTypeDisplay,
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.receipt_long,
                    color: Color(0xFF9CA3AF),
                    size: 20,
                  ),
                ],
              ),
            ),

            // Amount
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${r.currencySymbol} ${r.amountDisplay}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            // Recipient
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward, color: Color(0xFF9CA3AF), size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      r.recipientName,
                      style: const TextStyle(
                        color: Color(0xFFD1D5DB),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Reference + timestamp
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      r.reference,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('HH:mm').format(r.timestamp.toLocal()),
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Tap to view / Loading indicator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF2D2D3D)),
                ),
              ),
              child: showError
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFF59E0B),
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Tap to view receipt',
                          style: TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Tap to view receipt',
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFullScreenReceipt(BuildContext context) {
    // Reuse the ONE canonical receipt every service already uses
    // (UnifiedTransactionReceipt — Lazervault logo top-right, barcode/QR, working
    // Share + Download at the BOTTOM only), built from this card's payload —
    // instead of the bespoke FullScreenReceiptView (which duplicated Share/
    // Download in the app bar and whose URL-based share/download often failed).
    // fromHistory:true makes its close button pop back to the chat/voice sheet.
    final r = _loadedReceipt ?? widget.receipt;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UnifiedTransactionReceipt(
          transaction: r.toUnifiedTransaction(),
          fromHistory: true,
        ),
      ),
    );
  }
}
