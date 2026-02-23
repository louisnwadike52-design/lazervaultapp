import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../widgets/exchange_transaction_tile.dart';

class ExchangeHistoryScreen extends StatefulWidget {
  const ExchangeHistoryScreen({super.key});

  @override
  State<ExchangeHistoryScreen> createState() => _ExchangeHistoryScreenState();
}

class _ExchangeHistoryScreenState extends State<ExchangeHistoryScreen> {
  ExchangeHistoryFilter _selectedFilter = ExchangeHistoryFilter.all;

  @override
  void initState() {
    super.initState();
    context.read<ExchangeCubit>().loadHistory();
  }

  void _onFilterChanged(ExchangeHistoryFilter filter) {
    setState(() => _selectedFilter = filter);
    context.read<ExchangeCubit>().loadHistory(filter: filter);
  }

  Future<void> _refresh() async {
    await context.read<ExchangeCubit>().loadHistory(filter: _selectedFilter);
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
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: ExchangeHistoryFilter.values.map((filter) {
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(_filterLabel(filter)),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 13,
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
                    onSelected: (_) => _onFilterChanged(filter),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(color: Color(0xFF2D2D2D), height: 1),
          // Transaction list
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
                  if (state.transactions.isEmpty) {
                    return _buildEmptyState();
                  }
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: state.transactions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final tx = state.transactions[index];
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

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 120),
        const Icon(Icons.swap_horiz, color: Color(0xFF2D2D2D), size: 56),
        const SizedBox(height: 16),
        Text(
          _selectedFilter == ExchangeHistoryFilter.all
              ? 'No exchanges yet'
              : 'No ${_filterLabel(_selectedFilter).toLowerCase()} exchanges',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your exchange history will appear here',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
        ),
      ],
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

  String _filterLabel(ExchangeHistoryFilter filter) {
    switch (filter) {
      case ExchangeHistoryFilter.all:
        return 'All';
      case ExchangeHistoryFilter.conversions:
        return 'Conversions';
      case ExchangeHistoryFilter.international:
        return 'International';
      case ExchangeHistoryFilter.pending:
        return 'Pending';
      case ExchangeHistoryFilter.completed:
        return 'Completed';
      case ExchangeHistoryFilter.failed:
        return 'Failed';
    }
  }
}
