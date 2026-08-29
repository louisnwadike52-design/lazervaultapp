import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/src/features/funds/presentation/send_funds_launcher.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/core/utils/transfer_bank_display.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_transaction_history_modal.dart'
    show InlineSendHandler;
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_receipt_router.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'transfer_history_bottom_sheet_widgets.dart';


/// Whether a transaction belongs to the transfer flow. Shared by the transfer
/// history bottom sheet and the inline "History" filter on the select-recipient
/// screen so both surfaces classify transfers identically.
bool isTransferTransaction(UnifiedTransaction tx) {
  if (tx.serviceType == TransactionServiceType.transfer) return true;
  final titleLower = tx.title.toLowerCase();
  if (titleLower.contains('transfer')) return true;
  final descLower = tx.description?.toLowerCase() ?? '';
  if (descLower.contains('transfer')) return true;
  final category = tx.metadata?['category']?.toString().toLowerCase() ?? '';
  if (category.contains('transfer') || category.contains('c2c')) return true;
  return false;
}

class TransferHistoryBottomSheet extends StatefulWidget {
  /// Inline-send handler from the host (Select Recipient) so Repeat opens the
  /// amount sheet OVER the existing screens instead of pushing a fresh (blank)
  /// send screen. Falls back to [SendFundsLauncher] navigation when null.
  final InlineSendHandler? onSend;

  const TransferHistoryBottomSheet({super.key, this.onSend});

  @override
  State<TransferHistoryBottomSheet> createState() =>
      _TransferHistoryBottomSheetState();
}

class _TransferHistoryBottomSheetState
    extends State<TransferHistoryBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.snappy();
  bool _isLoadingMore = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load ALL transactions and filter locally for transfers.
    // The backend has two transaction creation paths (TransferBalance + RecordTransaction)
    // with different service_name values, so backend service_name filtering misses records.
    context.read<TransactionHistoryCubit>().loadAllTransactions();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<TransactionHistoryCubit>().state;
      if (state is TransactionHistoryLoaded && state.hasMore) {
        _isLoadingMore = true;
        context.read<TransactionHistoryCubit>().loadMoreTransactions().then((_) {
          _isLoadingMore = false;
        });
      }
    }
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      if (mounted) {
        setState(() {
          _searchQuery = query.trim().toLowerCase();
        });
      }
    });
    setState(() {}); // Rebuild to show/hide clear button
  }

  List<UnifiedTransaction> _filterTransactions(
      List<UnifiedTransaction> transactions) {
    // First: only keep transfer transactions
    var filtered = transactions.where(isTransferTransaction).toList();

    // Then: apply search filter if active
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((tx) {
        if (tx.title.toLowerCase().contains(_searchQuery)) return true;
        if (tx.formattedAmount.toLowerCase().contains(_searchQuery)) return true;
        if (tx.transactionReference?.toLowerCase().contains(_searchQuery) ==
            true) {
          return true;
        }
        if (tx.counterpartyName?.toLowerCase().contains(_searchQuery) == true) {
          return true;
        }
        if (tx.description?.toLowerCase().contains(_searchQuery) == true) {
          return true;
        }
        return false;
      }).toList();
    }

    return filtered;
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
                    'Transfer History',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
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
            child: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
              builder: (context, state) {
                return switch (state) {
                  TransactionHistoryLoading() => _buildShimmer(),
                  TransactionHistoryEmpty() => _buildEmpty(),
                  TransactionHistoryError(:final message) =>
                    _buildError(message),
                  TransactionHistoryLoaded(:final transactions, :final hasMore) =>
                    _buildList(transactions, hasMore),
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
                Icons.swap_horiz,
                color: const Color(0xFF4E03D0),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No transfer history',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your transfer transactions will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
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
              onPressed: () => context
                  .read<TransactionHistoryCubit>()
                  .loadAllTransactions(),
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

  Widget _buildList(List<UnifiedTransaction> transactions, bool hasMore) {
    final filtered = _filterTransactions(transactions);

    if (filtered.isEmpty) {
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
                  Icons.search_off,
                  color: const Color(0xFF4E03D0),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                _searchQuery.isNotEmpty
                    ? 'No matching transactions'
                    : 'No transfer history',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _searchQuery.isNotEmpty
                    ? 'Try a different search term'
                    : 'Your transfer transactions will appear here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          context.read<TransactionHistoryCubit>().refreshTransactions(),
      color: const Color(0xFF4E03D0),
      backgroundColor: Colors.white,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).padding.bottom + 16.h,
        ),
        itemCount: filtered.length + (hasMore && _searchQuery.isEmpty ? 1 : 0),
        separatorBuilder: (_, __) => Divider(
          color: Colors.grey[200],
          height: 1,
        ),
        itemBuilder: (context, index) {
          if (index >= filtered.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(
                child: LazerVaultLoader.tiny(),
              ),
            );
          }
          final tx = filtered[index];
          return TransferHistoryItem(transaction: tx, onSend: widget.onSend);
        },
      ),
    );
  }
}
