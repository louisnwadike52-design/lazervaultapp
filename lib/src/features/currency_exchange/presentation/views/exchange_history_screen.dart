import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/transaction_entity.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../widgets/exchange_transaction_tile.dart';

class ExchangeHistoryScreen extends StatefulWidget {
  const ExchangeHistoryScreen({super.key});

  @override
  State<ExchangeHistoryScreen> createState() => _ExchangeHistoryScreenState();
}

class _ExchangeHistoryScreenState extends State<ExchangeHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  _StatusFilter _statusFilter = _StatusFilter.all;

  @override
  void initState() {
    super.initState();
    // Determine initial tab from arguments
    final args = Get.arguments;
    final initialIndex =
        (args is Map<String, dynamic> && args['tab'] == 'international') ? 1 : 0;

    _tabController = TabController(length: 2, vsync: this, initialIndex: initialIndex);
    _tabController.addListener(_onTabChanged);
    context.read<ExchangeCubit>().loadHistory();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    // Reset status filter when switching tabs
    setState(() => _statusFilter = _StatusFilter.all);
  }

  void _onStatusFilterChanged(_StatusFilter filter) {
    setState(() => _statusFilter = filter);
  }

  Future<void> _refresh() async {
    await context.read<ExchangeCubit>().loadHistory();
  }

  /// Filter transactions by tab type and status.
  List<CurrencyTransaction> _filterTransactions(
    List<CurrencyTransaction> all,
    bool isConversionsTab,
  ) {
    // First filter by type (tab)
    final byType = all.where((tx) {
      if (isConversionsTab) {
        return tx.type == TransactionType.exchange;
      } else {
        return tx.type == TransactionType.send;
      }
    }).toList();

    // Then filter by status
    switch (_statusFilter) {
      case _StatusFilter.all:
        return byType;
      case _StatusFilter.pending:
        return byType.where((t) => t.isPending || t.isProcessing).toList();
      case _StatusFilter.completed:
        return byType.where((t) => t.isCompleted).toList();
      case _StatusFilter.failed:
        return byType.where((t) => t.isFailed).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Exchange History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF3B82F6),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          tabs: const [
            Tab(text: 'Conversions'),
            Tab(text: 'International'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: _StatusFilter.values.map((filter) {
                final isSelected = filter == _statusFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(_statusLabel(filter)),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    backgroundColor: const Color(0xFF1F1F1F),
                    selectedColor: const Color(0xFF3B82F6),
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                      ),
                    ),
                    onSelected: (_) => _onStatusFilterChanged(filter),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(color: Color(0xFF2D2D2D), height: 1),

          // Tab content
          Expanded(
            child: BlocBuilder<ExchangeCubit, ExchangeState>(
              builder: (context, state) {
                if (state is ExchangeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                  );
                }

                if (state is ExchangeError) {
                  return _buildErrorState(state.message);
                }

                if (state is ExchangeHistoryLoaded) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTransactionList(
                        _filterTransactions(state.transactions, true),
                        isConversions: true,
                      ),
                      _buildTransactionList(
                        _filterTransactions(state.transactions, false),
                        isConversions: false,
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(
    List<CurrencyTransaction> transactions, {
    required bool isConversions,
  }) {
    if (transactions.isEmpty) {
      return _buildEmptyState(isConversions: isConversions);
    }
    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ExchangeTransactionTile(
            transaction: tx,
            onTap: () => Get.toNamed(
              AppRoutes.exchangeDetail,
              arguments: tx,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState({required bool isConversions}) {
    final typeLabel = isConversions ? 'conversion' : 'international';
    final statusLabel = _statusFilter == _StatusFilter.all
        ? ''
        : ' ${_statusLabel(_statusFilter).toLowerCase()}';

    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 120),
          Icon(
            isConversions ? Icons.swap_horiz : Icons.send,
            color: const Color(0xFF2D2D2D),
            size: 56,
          ),
          const SizedBox(height: 16),
          Text(
            'No$statusLabel $typeLabel transactions',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isConversions
                ? 'Your wallet conversion history will appear here'
                : 'Your international transfer history will appear here',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _refresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(_StatusFilter filter) {
    switch (filter) {
      case _StatusFilter.all:
        return 'All';
      case _StatusFilter.pending:
        return 'Pending';
      case _StatusFilter.completed:
        return 'Completed';
      case _StatusFilter.failed:
        return 'Failed';
    }
  }
}

/// Status-only filter (type filtering is done by tabs).
enum _StatusFilter {
  all,
  pending,
  completed,
  failed,
}
