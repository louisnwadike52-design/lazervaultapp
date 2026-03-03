import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_receipt_router.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_filters.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_states.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/export_bottom_sheet.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_export_helper.dart';

/// Revolut-style dashboard transaction history screen
class DashboardTransactionHistoryScreen extends StatefulWidget {
  const DashboardTransactionHistoryScreen({super.key});

  @override
  State<DashboardTransactionHistoryScreen> createState() =>
      _DashboardTransactionHistoryScreenState();
}

class _DashboardTransactionHistoryScreenState
    extends State<DashboardTransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _searchDebouncer = Debouncer.search();

  TransactionFilters? _activeFilters;

  @override
  void initState() {
    super.initState();
    context.read<TransactionHistoryCubit>().loadAllTransactions();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = context.read<TransactionHistoryCubit>();
      if (cubit.state is TransactionHistoryLoaded) {
        final state = cubit.state as TransactionHistoryLoaded;
        if (state.hasMore) {
          cubit.loadMoreTransactions();
        }
      }
    }
  }

  void _showFilterSheet() {
    FilterBottomSheet.show(
      context,
      initialFilters: _activeFilters,
      onApply: (filters) {
        setState(() => _activeFilters = filters.hasFilters ? filters : null);
        // Merge with current search query
        final merged = _searchController.text.isNotEmpty
            ? filters.copyWith(searchQuery: _searchController.text)
            : filters;
        context.read<TransactionHistoryCubit>().applyFilters(merged);
      },
    );
  }

  void _clearAllFilters() {
    setState(() => _activeFilters = null);
    _searchController.clear();
    context.read<TransactionHistoryCubit>().clearFilters();
  }

  void _removeFilter(TransactionFilters updatedFilters) {
    setState(() => _activeFilters = updatedFilters.hasFilters ? updatedFilters : null);
    // Merge with current search query
    final merged = _searchController.text.isNotEmpty
        ? updatedFilters.copyWith(searchQuery: _searchController.text)
        : updatedFilters;
    if (merged.hasFilters) {
      context.read<TransactionHistoryCubit>().applyFilters(merged);
    } else {
      context.read<TransactionHistoryCubit>().clearFilters();
    }
  }

  void _onTransactionTap(UnifiedTransaction transaction) {
    _showTransactionDetailDialog(transaction);
  }

  void _showTransactionDetailDialog(UnifiedTransaction tx) {
    final isIncoming = tx.flow == TransactionFlow.incoming;
    final dateStr = DateFormat('EEEE, dd MMM yyyy \'at\' HH:mm').format(tx.createdAt);
    final symbol = tx.currency == 'NGN'
        ? '\u20A6'
        : tx.currency == 'USD'
            ? '\$'
            : tx.currency;
    final amtStr = '${isIncoming ? '+' : ''}$symbol${tx.amount.toStringAsFixed(2)}';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Service icon
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: tx.serviceColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                tx.serviceIcon,
                color: tx.serviceColor,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                tx.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            if (tx.description != null) ...[
              SizedBox(height: 4.h),
              Text(
                tx.description!,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            SizedBox(height: 8.h),

            // Amount
            Text(
              amtStr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isIncoming ? const Color(0xFF34C759) : Colors.white,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 6.h),

            // Date
            Text(
              dateStr,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 6.h),

            // Status chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: tx.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                tx.status.displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: tx.status.color,
                  fontFamily: 'Inter',
                ),
              ),
            ),

            // Reference
            if (tx.transactionReference != null) ...[
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ref: ',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF8E8E93),
                      fontFamily: 'Inter',
                    ),
                  ),
                  Flexible(
                    child: Text(
                      tx.transactionReference!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],

            // Counterparty
            if (tx.counterpartyName != null) ...[
              SizedBox(height: 8.h),
              Text(
                '${isIncoming ? 'From' : 'To'}: ${tx.counterpartyName}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            SizedBox(height: 20.h),

            // Action buttons
            Row(
              children: [
                // Repeat transaction
                if (tx.serviceType == TransactionServiceType.transfer && !isIncoming)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        // Navigate to send funds with prefilled data
                        Get.toNamed(
                          '/initiate-send-funds',
                          arguments: <String, dynamic>{
                            'prefillAmount': (tx.amount * 100).toInt(),
                            'prefillCurrency': tx.currency,
                            'autoShowConfirm': true,
                            if (tx.counterpartyName != null)
                              'recipientName': tx.counterpartyName,
                            if (tx.counterpartyAccount != null)
                              'recipientAccount': tx.counterpartyAccount,
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF581CD9),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.replay, color: Colors.white, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Repeat',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (tx.serviceType == TransactionServiceType.transfer && !isIncoming)
                  SizedBox(width: 12.w),
                // View receipt
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      TransactionReceiptRouter.navigateToReceipt(tx);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_outlined, color: Colors.white, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Receipt',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
          ],
        ),
      ),
    );
  }

  Map<DateTime, List<UnifiedTransaction>> _groupByDate(
      List<UnifiedTransaction> transactions) {
    final grouped = <DateTime, List<UnifiedTransaction>>{};
    for (var tx in transactions) {
      final date = DateTime(tx.createdAt.year, tx.createdAt.month, tx.createdAt.day);
      (grouped[date] ??= []).add(tx);
    }
    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            TransactionSearchBar(
              controller: _searchController,
              onChanged: (query) {
                _searchDebouncer.run(() {
                  if (!mounted) return;
                  final merged = (_activeFilters ?? const TransactionFilters())
                      .copyWith(searchQuery: query.isNotEmpty ? query : null);
                  if (merged.hasFilters) {
                    context.read<TransactionHistoryCubit>().applyFilters(merged);
                  } else {
                    context.read<TransactionHistoryCubit>().clearFilters();
                  }
                });
              },
              onClear: () {
                _searchController.clear();
                if (_activeFilters != null && _activeFilters!.hasFilters) {
                  // Keep other filters, just clear search
                  context.read<TransactionHistoryCubit>().applyFilters(_activeFilters!);
                } else {
                  context.read<TransactionHistoryCubit>().clearFilters();
                }
              },
            ),
            SizedBox(height: 4.h),
            TransactionFilterBar(
              activeFilters: _activeFilters,
              onOpenFilters: _showFilterSheet,
              onClearAll: _clearAllFilters,
              onRemoveFilter: _removeFilter,
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
                builder: (context, state) {
                  if (state is TransactionHistoryLoading) {
                    return const TransactionInitialLoading();
                  } else if (state is TransactionHistoryLoaded) {
                    return _buildList(state.transactions, state.hasMore);
                  } else if (state is TransactionHistoryEmpty) {
                    return TransactionEmptyState(
                      message: state.message,
                      action: (_activeFilters != null || _searchController.text.isNotEmpty)
                          ? _buildClearFiltersButton()
                          : null,
                    );
                  } else if (state is TransactionHistoryError) {
                    return TransactionErrorState(
                      message: state.message,
                      onRetry: () => context
                          .read<TransactionHistoryCubit>()
                          .loadAllTransactions(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExportSheet() {
    ExportBottomSheet.show(
      context,
      onExport: (startDate, endDate, format) async {
        final cubit = context.read<TransactionHistoryCubit>();
        final transactions = await cubit.fetchTransactionsForExport(
          startDate: startDate,
          endDate: endDate,
        );

        if (transactions.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No transactions found for the selected period',
                    style: TextStyle(fontSize: 13.sp)),
                backgroundColor: const Color(0xFFF59E0B),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return;
        }

        await TransactionExportHelper.exportAndShare(
          transactions: transactions,
          format: format,
          startDate: startDate,
          endDate: endDate,
        );
      },
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 12.w, 4.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              'Transactions',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ),
          IconButton(
            onPressed: _showExportSheet,
            icon: Icon(
              Icons.file_download_outlined,
              color: Colors.white,
              size: 22.sp,
            ),
            tooltip: 'Export',
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<UnifiedTransaction> transactions, bool hasMore) {
    if (transactions.isEmpty) {
      return const TransactionEmptyState();
    }

    final grouped = _groupByDate(transactions);

    return RefreshIndicator(
      onRefresh: () => context.read<TransactionHistoryCubit>().refreshTransactions(),
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color(0xFF581CD9),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: grouped.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= grouped.length) {
            return Padding(
              padding: EdgeInsets.all(20.w),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF581CD9)),
                ),
              ),
            );
          }

          final date = grouped.keys.elementAt(index);
          final dateTxns = grouped[date]!;

          return TransactionGroup(
            date: date,
            transactions: dateTxns,
            transactionBuilder: (tx) => TransactionCard(
              transaction: tx,
              onTap: () => _onTransactionTap(tx),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClearFiltersButton() {
    return GestureDetector(
      onTap: _clearAllFilters,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'Clear Filters',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
