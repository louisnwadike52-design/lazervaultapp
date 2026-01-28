import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_filters.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_states.dart';

/// Dashboard Transaction History Screen - Shows all transactions from all services
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

  // Filter state
  List<TransactionServiceType> _selectedServices = [];
  List<UnifiedTransactionStatus> _selectedStatuses = [];
  DateTime? _startDate;
  DateTime? _endDate;

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
    context.read<TransactionHistoryCubit>().loadAllTransactions();
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
      serviceTypes: _selectedServices.isNotEmpty ? _selectedServices : null,
      statuses: _selectedStatuses.isNotEmpty ? _selectedStatuses : null,
      startDate: _startDate,
      endDate: _endDate,
    );
    context.read<TransactionHistoryCubit>().applyFilters(filters);
  }

  void _clearAllFilters() {
    setState(() {
      _selectedServices.clear();
      _selectedStatuses.clear();
      _startDate = null;
      _endDate = null;
    });
    context.read<TransactionHistoryCubit>().clearFilters();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF581CD9),
              onPrimary: Colors.white,
              surface: const Color(0xFF1F1F1F),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _applyFilters();
    }
  }

  void _onTransactionTap(UnifiedTransaction transaction) {
    _showTransactionDetails(transaction);
  }

  void _showTransactionDetails(UnifiedTransaction transaction) {
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
      grouped.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)),
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
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildFiltersSection(),
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
                        action: state.activeFilters != null
                            ? ElevatedButton(
                                onPressed: _clearAllFilters,
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

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction History',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
                  builder: (context, state) {
                    String subtitle = 'All transactions';
                    if (state is TransactionHistoryLoaded &&
                        state.statistics != null) {
                      final stats = state.statistics!;
                      subtitle = '${stats.totalTransactions} transactions';
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

          // Filter button
          GestureDetector(
            onTap: () => _showFilterBottomSheet(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    final hasFilters = _selectedServices.isNotEmpty ||
        _selectedStatuses.isNotEmpty ||
        _startDate != null ||
        _endDate != null;

    return Column(
      children: [
        // Search bar
        TransactionSearchBar(
          controller: _searchController,
          onChanged: (query) {
            if (query.isNotEmpty) {
              context
                  .read<TransactionHistoryCubit>()
                  .searchTransactions(query);
            } else {
              _applyFilters();
            }
          },
          onClear: () {
            _searchController.clear();
            _applyFilters();
          },
        ),

        // Filter chips row
        SizedBox(
          height: 50.h,
          child: Row(
            children: [
              DateRangeFilterButton(
                startDate: _startDate,
                endDate: _endDate,
                onTap: _selectDateRange,
              ),
              ClearFiltersButton(
                isActive: hasFilters,
                onClear: _clearAllFilters,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsList(List<UnifiedTransaction> transactions) {
    if (transactions.isEmpty) {
      return const TransactionEmptyState();
    }

    final grouped = _groupTransactionsByDate(transactions);

    return RefreshIndicator(
      onRefresh: () =>
          context.read<TransactionHistoryCubit>().refreshTransactions(),
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color(0xFF581CD9),
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
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF581CD9)),
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
            ),
          );
        },
      ),
    );
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF2C3E50),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            // Title
            Text(
              'Filter Transactions',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 24.h),

            // Service type filter
            Text(
              'Service Type',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 12.h),
            ServiceFilterChips(
              availableServices: TransactionServiceType.values
                  .where((t) => t != TransactionServiceType.unknown)
                  .toList(),
              selectedServices: _selectedServices,
              onSelectionChanged: (services) {
                setState(() => _selectedServices = services);
              },
            ),

            SizedBox(height: 20.h),

            // Status filter
            Text(
              'Status',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 12.h),
            StatusFilterChips(
              selectedStatuses: _selectedStatuses,
              onSelectionChanged: (statuses) {
                setState(() => _selectedStatuses = statuses);
              },
            ),

            SizedBox(height: 24.h),

            // Apply button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  _applyFilters();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF581CD9),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

/// Transaction details bottom sheet
class TransactionDetailsSheet extends StatelessWidget {
  final UnifiedTransaction transaction;

  const TransactionDetailsSheet({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            transaction.serviceColor.withValues(alpha: 0.2),
            const Color(0xFF1F1F1F),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Icon & Title
                    Row(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                transaction.serviceColor.withValues(alpha: 0.3),
                                transaction.serviceColor.withValues(alpha: 0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: transaction.serviceColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            transaction.serviceIcon,
                            color: transaction.serviceColor,
                            size: 28.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.serviceType.displayName,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                transaction.title,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Amount Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            transaction.formattedAmount,
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w700,
                              color: transaction.flow.color,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: transaction.status.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: transaction.status.color.withValues(alpha: 0.3),
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              transaction.status.displayName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: transaction.status.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Transaction Details
                    Text(
                      'Transaction Details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _buildDetailRow('Transaction ID', transaction.id),
                    _buildDetailRow(
                      'Date & Time',
                      DateFormat('MMM dd, yyyy • hh:mm a').format(transaction.createdAt),
                    ),
                    if (transaction.description != null)
                      _buildDetailRow('Description', transaction.description!),
                    if (transaction.transactionReference != null)
                      _buildDetailRow('Reference', transaction.transactionReference!),
                    _buildDetailRow('Currency', transaction.currency),
                    _buildDetailRow('Type', transaction.flow.name.toUpperCase()),
                    _buildDetailRow('Service', transaction.serviceType.displayName),

                    // Metadata
                    if (transaction.metadata != null &&
                        transaction.metadata!.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ...transaction.metadata!.entries.map((entry) {
                        return _buildDetailRow(
                          _formatMetadataKey(entry.key),
                          entry.value?.toString() ?? 'N/A',
                        );
                      }),
                    ],

                    SizedBox(height: 32.h),

                    // Close button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatMetadataKey(String key) {
    // Convert camelCase to Title Case
    final result = key.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => ' ${match.group(0)}',
    );
    return result[0].toUpperCase() + result.substring(1);
  }
}
