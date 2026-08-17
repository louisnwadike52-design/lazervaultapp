part of 'recipient_transaction_history_modal.dart';

/// Inline-send handler passed by a host that already owns the send flow (e.g.
/// the Select Recipient screen, whose route provides TransferCubit/RecipientCubit).
/// Lets "Repeat" / "Send money" run the amount sheet OVER the existing screens
/// instead of pushing a fresh (blank) send screen. When null, the modal falls
/// back to [SendFundsLauncher] navigation.
typedef InlineSendHandler = void Function(
  RecipientModel recipient, {
  int? amountMinor,
  String? currency,
});

class RecipientTransactionHistoryModal extends StatefulWidget {
  final RecipientModel recipient;
  final InlineSendHandler? onSend;

  const RecipientTransactionHistoryModal({
    super.key,
    required this.recipient,
    this.onSend,
  });

  @override
  State<RecipientTransactionHistoryModal> createState() =>
      _RecipientTransactionHistoryModalState();
}

class _RecipientTransactionHistoryModalState
    extends State<RecipientTransactionHistoryModal> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.typing(); // 300ms for local search
  List<RecurringTransferEntity> _activeRecurringTransfers = [];

  @override
  void initState() {
    super.initState();
    context.read<RecipientTransactionHistoryCubit>().loadRecipientTransactions(
          widget.recipient.accountNumber,
          widget.recipient.name,
        );
    _loadRecurringInfo();
  }

  void _loadRecurringInfo() {
    try {
      final cubit = GetIt.I<RecurringTransferCubit>();
      cubit.loadByRecipient(widget.recipient.accountNumber);
      cubit.stream.firstWhere(
        (s) => s is RecurringTransferListLoaded || s is RecurringTransferError,
      ).then((state) {
        if (state is RecurringTransferListLoaded && mounted) {
          final active = state.transfers.where((t) => t.isActive).toList();
          if (active.isNotEmpty) {
            setState(() => _activeRecurringTransfers = active);
          }
        }
      }).catchError((_) {});
    } catch (_) {
      // RecurringTransferCubit not registered — silently skip
    }
  }

  /// Check if a transaction matches any active recurring transfer
  RecurringTransferEntity? _matchingRecurring(UnifiedTransaction tx) {
    if (_activeRecurringTransfers.isEmpty) return null;
    if (tx.flow != TransactionFlow.outgoing) return null;
    for (final rt in _activeRecurringTransfers) {
      if ((rt.amount - tx.amount).abs() < 0.01 &&
          rt.currency == tx.currency) {
        return rt;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      if (mounted) {
        context.read<RecipientTransactionHistoryCubit>().filterBySearch(query);
      }
    });
    setState(() {}); // Rebuild to show/hide clear button
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Transactions with ${widget.recipient.name}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[600], size: 22.sp),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Search by name, amount, reference...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey[600],
                            size: 18.sp,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Content
          Flexible(
            child: BlocBuilder<RecipientTransactionHistoryCubit,
                RecipientTransactionHistoryState>(
              builder: (context, state) {
                return switch (state) {
                  RecipientTransactionHistoryLoading() => _buildShimmer(),
                  RecipientTransactionHistoryEmpty() => _buildEmpty(),
                  RecipientTransactionHistoryError(:final message) =>
                    _buildError(message),
                  RecipientTransactionHistoryLoaded(:final transactions) =>
                    _buildList(transactions),
                  _ => _buildShimmer(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 80.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    final isSearching = _searchController.text.isNotEmpty;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching ? Icons.search_off : Icons.send_rounded,
                color: const Color(0xFF4E03D0),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              isSearching
                  ? 'No matching transactions'
                  : 'Send money to ${widget.recipient.name}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isSearching
                  ? 'Try a different search term'
                  : 'Tap below to send money to this recipient',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            if (!isSearching) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () {
                  final cb = widget.onSend;
                  Get.back(); // close the history modal
                  if (cb != null) {
                    // Host owns the send flow → run it OVER the existing screens
                    // instead of pushing a fresh (blank) send screen.
                    cb(widget.recipient);
                  } else {
                    // Generic send (no prefill) — honor the user's transfer-style
                    // choice (classic short vs standard long).
                    SendFundsLauncher.open(
                        recipient: widget.recipient, autoContinue: true);
                  }
                },
                icon: Icon(Icons.send, size: 18.sp),
                label: Text(
                  'Send Money',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () =>
                  context.read<RecipientTransactionHistoryCubit>().refresh(),
              child: Text(
                'Retry',
                style: TextStyle(
                  color: const Color(0xFF4E03D0),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<UnifiedTransaction> transactions) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<RecipientTransactionHistoryCubit>().refresh(),
      color: const Color(0xFF4E03D0),
      backgroundColor: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).padding.bottom + 16.h,
        ),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => Divider(
          color: Colors.grey[200],
          height: 1,
        ),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return _TransactionItem(
            transaction: tx,
            recipient: widget.recipient,
            matchingRecurring: _matchingRecurring(tx),
            onSend: widget.onSend,
          );
        },
      ),
    );
  }
}
