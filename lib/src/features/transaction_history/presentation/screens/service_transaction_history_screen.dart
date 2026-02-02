import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_filters.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_states.dart';

/// Revolut-style service-specific transaction history
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
  UnifiedTransactionStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    context.read<TransactionHistoryCubit>().loadServiceTransactions(widget.serviceType);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
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

  void _onStatusChanged(UnifiedTransactionStatus? status) {
    setState(() => _selectedStatus = status);

    if (status == null) {
      context.read<TransactionHistoryCubit>().loadServiceTransactions(widget.serviceType);
    } else {
      final filters = TransactionFilters(statuses: [status]);
      context
          .read<TransactionHistoryCubit>()
          .loadServiceTransactions(widget.serviceType, filters: filters);
    }
  }

  void _onTransactionTap(UnifiedTransaction transaction) {
    Get.to(
      () => TransactionDetailScreen(transaction: transaction),
      transition: Transition.rightToLeft,
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
            SizedBox(height: 8.h),
            StatusFilterRow(
              selectedStatus: _selectedStatus,
              onChanged: _onStatusChanged,
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
                      icon: widget.serviceType.icon,
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
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 20.w, 4.h),
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
          SizedBox(width: 8.w),
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: widget.serviceType.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.serviceType.icon,
              color: widget.serviceType.color,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            widget.serviceType.displayName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<UnifiedTransaction> transactions, bool hasMore) {
    if (transactions.isEmpty) {
      return TransactionEmptyState(
        message: 'No ${widget.serviceType.displayName} transactions',
        icon: widget.serviceType.icon,
      );
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
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(widget.serviceType.color),
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
              showServiceIcon: false,
              onTap: () => _onTransactionTap(tx),
            ),
          );
        },
      ),
    );
  }
}
