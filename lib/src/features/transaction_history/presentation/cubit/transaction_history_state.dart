import 'package:equatable/equatable.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Base state for transaction history
abstract class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class TransactionHistoryInitial extends TransactionHistoryState {
  const TransactionHistoryInitial();
}

/// Loading state
class TransactionHistoryLoading extends TransactionHistoryState {
  final String? message;

  const TransactionHistoryLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Loaded state
class TransactionHistoryLoaded extends TransactionHistoryState {
  final List<UnifiedTransaction> transactions;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final TransactionFilters? activeFilters;
  final TransactionStatistics? statistics;

  const TransactionHistoryLoaded({
    required this.transactions,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    this.activeFilters,
    this.statistics,
  });

  TransactionHistoryLoaded copyWith({
    List<UnifiedTransaction>? transactions,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
    TransactionFilters? activeFilters,
    TransactionStatistics? statistics,
    bool clearFilters = false,
  }) {
    return TransactionHistoryLoaded(
      transactions: transactions ?? this.transactions,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      activeFilters: clearFilters ? null : (activeFilters ?? this.activeFilters),
      statistics: statistics ?? this.statistics,
    );
  }

  @override
  List<Object?> get props => [
        transactions,
        hasMore,
        currentPage,
        totalPages,
        activeFilters,
        statistics,
      ];
}

/// Error state
class TransactionHistoryError extends TransactionHistoryState {
  final String message;
  final String? errorCode;

  const TransactionHistoryError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

/// Empty state
class TransactionHistoryEmpty extends TransactionHistoryState {
  final String? message;
  final TransactionFilters? activeFilters;

  const TransactionHistoryEmpty({
    this.message = 'No transactions found',
    this.activeFilters,
  });

  @override
  List<Object?> get props => [message, activeFilters];
}

/// Transaction details state
class TransactionDetailsLoading extends TransactionHistoryState {
  const TransactionDetailsLoading();
}

class TransactionDetailsLoaded extends TransactionHistoryState {
  final UnifiedTransaction transaction;

  const TransactionDetailsLoaded({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class TransactionDetailsError extends TransactionHistoryState {
  final String message;

  const TransactionDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Statistics state
class TransactionStatisticsLoading extends TransactionHistoryState {
  const TransactionStatisticsLoading();
}

class TransactionStatisticsLoaded extends TransactionHistoryState {
  final TransactionStatistics statistics;

  const TransactionStatisticsLoaded({required this.statistics});

  @override
  List<Object?> get props => [statistics];
}
