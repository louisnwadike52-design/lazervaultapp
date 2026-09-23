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

  /// Live-status poll for a receipt that is still settling.
  ///
  /// A chat receipt is rendered once and then sits in the transcript forever. A
  /// transfer that was "in progress" when it was drawn stayed "in progress" on
  /// reopening the chat a day later, even though it had long since landed — the
  /// card showed the status as at render time, not the status now. Users then
  /// re-send, or contact support about money they already have.
  ///
  /// Bounded on purpose: it polls only while the status is non-terminal, stops
  /// the moment it settles, and gives up after [_maxStatusPolls]. A transcript
  /// can hold many receipts, and an unbounded timer per card would have every
  /// old conversation quietly hammering the gateway forever.
  Timer? _statusTimer;
  int _statusPolls = 0;
  bool _statusFetching = false;
  static const int _maxStatusPolls = 20;
  static const Duration _statusInterval = Duration(seconds: 6);

  @override
  void initState() {
    super.initState();
    // Show loading skeleton first, then load receipt data
    _loadReceiptData();
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  /// Start polling if — and only if — this receipt has somewhere to go.
  void _maybeStartStatusPolling(TransferReceiptData r) {
    if (r.isSuccess || r.isFailure) return; // already settled
    if (r.reference.isEmpty) return; // nothing to look up by
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(_statusInterval, (_) => _refreshStatus());
    // Check once immediately: reopening an old chat should correct a stale card
    // now, not six seconds from now.
    unawaited(_refreshStatus());
  }

  Future<void> _refreshStatus() async {
    if (_statusFetching || !mounted) return;
    final current = _loadedReceipt;
    if (current == null) return;
    if (_statusPolls >= _maxStatusPolls) {
      _statusTimer?.cancel();
      return;
    }
    _statusFetching = true;
    _statusPolls++;
    try {
      final snap = await serviceLocator<IPaymentsTransferDataSource>()
          .getTransferStatus(reference: current.reference);
      if (!mounted || snap == null || snap.status.isEmpty) return;
      if (snap.status.toLowerCase() == current.status.toLowerCase()) return;
      // Re-render silently with the new status — no toast, no jump. The user
      // sees the icon and label settle; nothing demands their attention.
      setState(() => _loadedReceipt = current.copyWith(status: snap.status));
      if (snap.isTerminal) _statusTimer?.cancel();
    } catch (_) {
      // Keep the last known status. A failed poll must never downgrade a card
      // that already reads as successful.
    } finally {
      _statusFetching = false;
    }
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

    // Start the live-status poll once, whichever branch above resolved. Hooking
    // it per-branch missed the PDF-unavailable and connection-error paths — and
    // those are exactly the cases where a receipt is most likely still settling.
    if (mounted) _maybeStartStatusPolling(widget.receipt);
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

  /// One balance line. Tabular figures so "before" and "after" line up on the
  /// decimal — the whole point of showing them together is the comparison.
  Widget _balanceRow(String label, String value, {bool muted = false}) {
    final color = muted ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: color, fontSize: 11),
        ),
        Text(
          value,
          style: TextStyle(
            color: muted ? const Color(0xFF6B7280) : Colors.white,
            fontSize: 12,
            fontWeight: muted ? FontWeight.w400 : FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptCard(TransferReceiptData r, {bool showError = false}) {
    return GestureDetector(
      onTap: () => _openFullScreenReceipt(context),
      child: Builder(builder: (context) {
      // THREE states, not two.
      //
      // This card split on isSuccess alone, so anything that was not a success —
      // including PENDING — was drawn with the failure icon and red colours. A
      // transfer that had been accepted and was simply still settling looked like it
      // had failed, directly under an agent message saying it succeeded.
      //
      // Pending is in-progress, not an error: amber, a clock, and wording that says it
      // is still on its way.
      // Single source of truth on the model, so the card and the PDF cannot disagree
      // about what a status means. It also treats an EMPTY status as in-progress rather
      // than failed — the state a transfer is in before its first status update.
      final _pending = r.isPending;
      final Color _tone = r.isSuccess
          ? const Color(0xFF10B981)
          : _pending
              ? const Color(0xFFFB923C)
              : const Color(0xFFEF4444);
      final IconData _icon = r.isSuccess
          ? Icons.check
          : _pending
              ? Icons.schedule
              : Icons.close;
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _tone.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _tone.withValues(alpha: 0.1),
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
                      color: _tone.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _icon,
                      color: _tone,
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
                              : _pending
                                  // "Bank Transfer pending" read as a failure. Say what
                                  // is happening instead of naming a raw status token.
                                  ? '${r.transferTypeDisplay} in progress'
                                  : '${r.transferTypeDisplay} ${r.status}',
                          style: TextStyle(
                            color: _tone,
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

            // Balance before → after.
            //
            // The card carried neither: new_balance was parsed and then never
            // rendered, so the only place a balance appeared was the markdown
            // table the agent used to print underneath — which is exactly the
            // duplicate this card replaces. Showing both ends makes the movement
            // checkable on the card itself.
            //
            // The "before" row is omitted when the backend could not derive it
            // exactly (it needs the fee); a figure wrong by the fee reads as
            // missing money.
            if (r.newBalanceDisplay.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  children: [
                    if (r.balanceBeforeDisplay.isNotEmpty)
                      _balanceRow(
                        'Balance before',
                        '${r.balanceBeforeDisplay} ${r.currency}',
                        muted: true,
                      ),
                    if (r.balanceBeforeDisplay.isNotEmpty)
                      const SizedBox(height: 4),
                    _balanceRow(
                      'Balance after',
                      '${r.newBalanceDisplay} ${r.currency}',
                    ),
                  ],
                ),
              ),
            ],

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
      );
      }),
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
