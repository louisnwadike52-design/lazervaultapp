import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_receipt_router.dart';

class TransferHistoryBottomSheet extends StatefulWidget {
  const TransferHistoryBottomSheet({super.key});

  @override
  State<TransferHistoryBottomSheet> createState() =>
      _TransferHistoryBottomSheetState();
}

class _TransferHistoryBottomSheetState
    extends State<TransferHistoryBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.search();
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

  /// Check if a transaction is transfer-related
  bool _isTransfer(UnifiedTransaction tx) {
    if (tx.serviceType == TransactionServiceType.transfer) return true;
    final titleLower = tx.title.toLowerCase();
    if (titleLower.contains('transfer')) return true;
    final descLower = tx.description?.toLowerCase() ?? '';
    if (descLower.contains('transfer')) return true;
    // Check category in metadata
    final category = tx.metadata?['category']?.toString().toLowerCase() ?? '';
    if (category.contains('transfer') || category.contains('c2c')) return true;
    return false;
  }

  List<UnifiedTransaction> _filterTransactions(
      List<UnifiedTransaction> transactions) {
    // First: only keep transfer transactions
    var filtered = transactions.where(_isTransfer).toList();

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
                child: CircularProgressIndicator(
                  color: Color(0xFF4E03D0),
                  strokeWidth: 2,
                ),
              ),
            );
          }
          final tx = filtered[index];
          return _TransferHistoryItem(transaction: tx);
        },
      ),
    );
  }
}

class _TransferHistoryItem extends StatelessWidget {
  final UnifiedTransaction transaction;

  const _TransferHistoryItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final dateStr =
        DateFormat('dd MMM yyyy, HH:mm').format(transaction.createdAt);
    final isIncoming = transaction.flow == TransactionFlow.incoming;

    return InkWell(
      onTap: () => TransactionReceiptRouter.navigateToReceipt(transaction),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Transfer icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncoming ? Icons.call_received : Icons.call_made,
                color: const Color(0xFF4E03D0),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Title + date + status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: transaction.status.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          transaction.status.displayName,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: transaction.status.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isIncoming
                    ? const Color(0xFF10B981)
                    : Colors.black87,
              ),
            ),

            SizedBox(width: 6.w),

            // Repeat transfer icon
            if (transaction.flow == TransactionFlow.outgoing &&
                transaction.counterpartyName != null)
              GestureDetector(
                onTap: () {
                  Get.back(); // close sheet
                  final amountMinor = (transaction.amount * 100).toInt();
                  // Build a minimal recipient from the transaction's counterparty info
                  final recipient = RecipientModel(
                    id: '',
                    name: transaction.counterpartyName!,
                    accountNumber: transaction.counterpartyAccount ?? '',
                    bankName: 'LazerVault',
                    isFavorite: false,
                    sortCode: '',
                    type: 'internal',
                  );
                  Get.toNamed(
                    AppRoutes.initiateSendFunds,
                    arguments: <String, dynamic>{
                      'recipient': recipient,
                      'prefillAmount': amountMinor,
                      'prefillCurrency': transaction.currency,
                      'autoShowConfirm': true,
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.replay,
                    color: const Color(0xFF4E03D0),
                    size: 20.sp,
                  ),
                ),
              ),

            // Receipt icon
            GestureDetector(
              onTap: () =>
                  TransactionReceiptRouter.navigateToReceipt(transaction),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.receipt_outlined,
                  color: Colors.grey[400],
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
