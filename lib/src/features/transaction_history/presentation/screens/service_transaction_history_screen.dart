import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_states.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/dashboard_transaction_history_screen.dart'
    show TransactionDetailsSheet;

/// Service-Specific Transaction History Screen
/// Shows transactions only for a specific service type
class ServiceTransactionHistoryScreen extends StatefulWidget {
  final TransactionServiceType serviceType;

  const ServiceTransactionHistoryScreen({
    super.key,
    required this.serviceType,
  });

  @override
  State<ServiceTransactionHistoryScreen> createState() =>
      _ServiceTransactionHistoryScreenState();
}

class _ServiceTransactionHistoryScreenState
    extends State<ServiceTransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<UnifiedTransactionStatus> _selectedStatuses = [];
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializeData() {
    context
        .read<TransactionHistoryCubit>()
        .loadServiceTransactions(widget.serviceType);
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

  void _applyFilters() {
    final filters = TransactionFilters(
      statuses: _selectedStatuses.isNotEmpty ? _selectedStatuses : null,
      searchQuery: _searchController.text.isNotEmpty
          ? _searchController.text
          : null,
    );
    context
        .read<TransactionHistoryCubit>()
        .loadServiceTransactions(widget.serviceType, filters: filters);
  }

  void _clearFilters() {
    setState(() {
      _selectedStatuses.clear();
      _searchController.clear();
    });
    context
        .read<TransactionHistoryCubit>()
        .loadServiceTransactions(widget.serviceType);
  }

  void _onTransactionTap(UnifiedTransaction transaction) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TransactionDetailsSheet(transaction: transaction),
    );
  }

  Map<DateTime, List<UnifiedTransaction>> _groupTransactionsByDate(
      List<UnifiedTransaction> transactions) {
    final grouped = <DateTime, List<UnifiedTransaction>>{};

    for (var transaction in transactions) {
      final date = DateTime(
        transaction.createdAt.year,
        transaction.createdAt.month,
        transaction.createdAt.day,
      );

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }

    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.serviceType.color.withValues(alpha: 0.15),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              if (_showFilters) _buildFiltersSection(),
              Expanded(
                child: BlocBuilder<TransactionHistoryCubit,
                    TransactionHistoryState>(
                  builder: (context, state) {
                    if (state is TransactionHistoryLoading) {
                      return const TransactionInitialLoading();
                    } else if (state is TransactionHistoryLoaded) {
                      return _buildTransactionsList(state.transactions);
                    } else if (state is TransactionHistoryEmpty) {
                      return TransactionEmptyState(
                        message: state.message,
                        icon: widget.serviceType.icon,
                        action: state.activeFilters != null
                            ? ElevatedButton(
                                onPressed: _clearFilters,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white
                                      .withValues(alpha: 0.1),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 14.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Clear Filters',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : null,
                      );
                    } else if (state is TransactionHistoryError) {
                      return TransactionErrorState(
                        message: state.message,
                        onRetry: () => context
                            .read<TransactionHistoryCubit>()
                            .loadServiceTransactions(widget.serviceType),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),

          SizedBox(width: 16.w),

          // Service Icon
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.serviceType.color.withValues(alpha: 0.3),
                  widget.serviceType.color.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: widget.serviceType.color.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              widget.serviceType.icon,
              color: widget.serviceType.color,
              size: 22.sp,
            ),
          ),

          SizedBox(width: 12.w),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.serviceType.displayName,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
                  builder: (context, state) {
                    String subtitle = 'Loading...';
                    if (state is TransactionHistoryLoaded) {
                      subtitle = '${state.transactions.length} transactions';
                      if (state.statistics != null) {
                        final stats = state.statistics!;
                        subtitle +=
                            ' • ${stats.netBalance >= 0 ? '+' : ''}${stats.netBalance.toStringAsFixed(2)}';
                      }
                    } else if (state is TransactionHistoryEmpty) {
                      subtitle = '0 transactions';
                    }
                    return Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Filter toggle button
          GestureDetector(
            onTap: () {
              setState(() => _showFilters = !_showFilters);
            },
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _showFilters
                    ? widget.serviceType.color.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: _showFilters
                    ? Border.all(
                        color: widget.serviceType.color.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Icon(
                _showFilters ? Icons.filter_list_off : Icons.filter_list,
                color: _showFilters
                    ? widget.serviceType.color
                    : Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _applyFilters(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search ${widget.serviceType.displayName}...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      _applyFilters();
                    },
                    child: Icon(
                      Icons.clear_rounded,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 20.sp,
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Status filters
          Text(
            'Filter by Status',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 8.h),

          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: UnifiedTransactionStatus.values.length,
              itemBuilder: (context, index) {
                final status = UnifiedTransactionStatus.values[index];
                final isSelected = _selectedStatuses.contains(status);

                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    label: Text(
                      status.displayName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedStatuses.add(status);
                        } else {
                          _selectedStatuses.remove(status);
                        }
                      });
                      _applyFilters();
                    },
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    selectedColor: status.color.withValues(alpha: 0.3),
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? status.color
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                );
              },
            ),
          ),

          // Apply button
          if (_selectedStatuses.isNotEmpty ||
              _searchController.text.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.serviceType.color.withValues(alpha: 0.2),
                      foregroundColor: widget.serviceType.color,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      side: BorderSide(
                        color: widget.serviceType.color.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: _clearFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    foregroundColor: Colors.white.withValues(alpha: 0.7),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<UnifiedTransaction> transactions) {
    if (transactions.isEmpty) {
      return TransactionEmptyState(
        message: 'No ${widget.serviceType.displayName} transactions found',
        icon: widget.serviceType.icon,
      );
    }

    final grouped = _groupTransactionsByDate(transactions);

    return RefreshIndicator(
      onRefresh: () => context
          .read<TransactionHistoryCubit>()
          .refreshTransactions(),
      backgroundColor: const Color(0xFF1F1F1F),
      color: widget.serviceType.color,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: grouped.length + 1, // +1 for loading indicator at bottom
        itemBuilder: (context, index) {
          if (index >= grouped.length) {
            // Show loading indicator at bottom
            final state = context.read<TransactionHistoryCubit>().state;
            if (state is TransactionHistoryLoaded && state.hasMore) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(widget.serviceType.color),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }

          final date = grouped.keys.elementAt(index);
          final dateTransactions = grouped[date]!;

          return TransactionGroup(
            date: date,
            transactions: dateTransactions,
            transactionBuilder: (transaction) => TransactionCard(
              transaction: transaction,
              onTap: () => _onTransactionTap(transaction),
              showServiceIcon: false, // Don't show service icon since all are same service
            ),
          );
        },
      ),
    );
  }
}
