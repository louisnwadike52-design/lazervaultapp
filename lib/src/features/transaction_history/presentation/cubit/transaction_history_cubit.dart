import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';

/// Cubit for managing transaction history state
class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  final TransactionHistoryRepository repository;

  // Pagination
  int _currentPage = 1;
  final int _pageSize = 20;
  String? _nextCursor;

  // Current filters and service type
  TransactionFilters? _activeFilters;
  TransactionServiceType? _serviceType;

  // Cached transactions
  List<UnifiedTransaction> _cachedTransactions = [];

  TransactionHistoryCubit({required this.repository})
      : super(const TransactionHistoryInitial());

  /// Load all transactions (for dashboard)
  Future<void> loadAllTransactions({TransactionFilters? filters}) async {
    emit(const TransactionHistoryLoading());

    try {
      final response = await repository.fetchAllTransactions(
        page: 1,
        limit: _pageSize,
        filters: filters,
      );

      _currentPage = 1;
      _nextCursor = response.nextCursor;
      _activeFilters = filters;
      _cachedTransactions = response.transactions;
      _serviceType = null;

      if (response.transactions.isEmpty) {
        emit(TransactionHistoryEmpty(activeFilters: filters));
      } else {
        final stats = await repository.getStatistics(
          startDate: filters?.startDate,
          endDate: filters?.endDate,
        );

        emit(TransactionHistoryLoaded(
          transactions: response.transactions,
          hasMore: response.hasMore,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          activeFilters: filters,
          statistics: stats,
        ));
      }
    } catch (e) {
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'LOAD_ALL_FAILED',
      ));
    }
  }

  /// Load transactions for a specific service type
  Future<void> loadServiceTransactions(
    TransactionServiceType serviceType, {
    TransactionFilters? filters,
  }) async {
    emit(TransactionHistoryLoading(
      message: 'Loading ${serviceType.displayName} transactions...',
    ));

    try {
      final response = await repository.fetchServiceTransactions(
        serviceType,
        page: 1,
        limit: _pageSize,
        filters: filters,
      );

      _currentPage = 1;
      _nextCursor = response.nextCursor;
      _activeFilters = filters;
      _cachedTransactions = response.transactions;
      _serviceType = serviceType;

      if (response.transactions.isEmpty) {
        emit(TransactionHistoryEmpty(
          message: 'No ${serviceType.displayName} transactions found',
          activeFilters: filters,
        ));
      } else {
        final stats = await repository.getStatistics(
          serviceType: serviceType,
          startDate: filters?.startDate,
          endDate: filters?.endDate,
        );

        emit(TransactionHistoryLoaded(
          transactions: response.transactions,
          hasMore: response.hasMore,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          activeFilters: filters,
          statistics: stats,
        ));
      }
    } catch (e) {
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'LOAD_SERVICE_FAILED',
      ));
    }
  }

  /// Load more transactions (pagination)
  Future<void> loadMoreTransactions() async {
    if (state is! TransactionHistoryLoaded) return;

    final currentState = state as TransactionHistoryLoaded;
    if (!currentState.hasMore) return;

    try {
      emit(const TransactionHistoryLoading(message: 'Loading more...'));

      final response = _serviceType == null
          ? await repository.fetchAllTransactions(
              page: _currentPage + 1,
              limit: _pageSize,
              cursor: _nextCursor,
              filters: _activeFilters,
            )
          : await repository.fetchServiceTransactions(
              _serviceType!,
              page: _currentPage + 1,
              limit: _pageSize,
              cursor: _nextCursor,
              filters: _activeFilters,
            );

      _currentPage = response.currentPage;
      _nextCursor = response.nextCursor;
      _cachedTransactions.addAll(response.transactions);

      emit(currentState.copyWith(
        transactions: _cachedTransactions,
        hasMore: response.hasMore,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      ));
    } catch (e) {
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'LOAD_MORE_FAILED',
      ));
    }
  }

  /// Refresh transactions
  Future<void> refreshTransactions() async {
    try {
      await repository.refreshTransactions();

      if (_serviceType == null) {
        await loadAllTransactions(filters: _activeFilters);
      } else {
        await loadServiceTransactions(_serviceType!, filters: _activeFilters);
      }
    } catch (e) {
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'REFRESH_FAILED',
      ));
    }
  }

  /// Apply filters
  Future<void> applyFilters(TransactionFilters filters) async {
    if (_serviceType == null) {
      await loadAllTransactions(filters: filters.hasFilters ? filters : null);
    } else {
      await loadServiceTransactions(_serviceType!, filters: filters);
    }
  }

  /// Clear all filters
  Future<void> clearFilters() async {
    _activeFilters = null;
    if (_serviceType == null) {
      await loadAllTransactions();
    } else {
      await loadServiceTransactions(_serviceType!);
    }
  }

  /// Search transactions
  Future<void> searchTransactions(String query) async {
    if (state is! TransactionHistoryLoaded) return;

    try {
      emit(const TransactionHistoryLoading(message: 'Searching...'));

      final results = await repository.searchTransactions(query);

      if (results.isEmpty) {
        emit(const TransactionHistoryEmpty(
          message: 'No transactions found for your search',
        ));
      } else {
        emit((state as TransactionHistoryLoaded).copyWith(
          transactions: results,
          hasMore: false,
        ));
      }
    } catch (e) {
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'SEARCH_FAILED',
      ));
    }
  }

  /// Load transaction details
  Future<void> loadTransactionDetails(String transactionId) async {
    emit(const TransactionDetailsLoading());

    try {
      final transaction = await repository.fetchTransactionById(transactionId);

      if (transaction != null) {
        emit(TransactionDetailsLoaded(transaction: transaction));
      } else {
        emit(const TransactionDetailsError(
          message: 'Transaction not found',
        ));
      }
    } catch (e) {
      emit(TransactionDetailsError(
        message: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  /// Load statistics
  Future<void> loadStatistics({TransactionServiceType? serviceType}) async {
    emit(const TransactionStatisticsLoading());

    try {
      final stats = await repository.getStatistics(
        serviceType: serviceType ?? _serviceType,
        startDate: _activeFilters?.startDate,
        endDate: _activeFilters?.endDate,
      );

      if (state is TransactionHistoryLoaded) {
        emit((state as TransactionHistoryLoaded).copyWith(statistics: stats));
      } else {
        emit(TransactionStatisticsLoaded(statistics: stats));
      }
    } catch (e) {
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'STATS_FAILED',
      ));
    }
  }

  /// Reset to initial state
  void reset() {
    _currentPage = 1;
    _nextCursor = null;
    _activeFilters = null;
    _serviceType = null;
    _cachedTransactions = [];
    emit(const TransactionHistoryInitial());
  }

  /// Get current service type
  TransactionServiceType? get currentServiceType => _serviceType;

  /// Get current filters
  TransactionFilters? get currentFilters => _activeFilters;
}
