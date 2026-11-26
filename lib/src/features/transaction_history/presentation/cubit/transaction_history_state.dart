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

  /// A NEXT PAGE IS IN FLIGHT — and this list is still the truth.
  ///
  /// Appending used to emit [TransactionHistoryLoading], which every screen
  /// renders as a full-page skeleton. That tore the ListView down mid-scroll:
  /// the rows vanished, the offset reset to the top, and — because the scroll
  /// listeners only fire while the state is Loaded — nothing could ask for
  /// page three. Pagination looked broken because it WAS: one page was all
  /// anybody could ever reach.
  ///
  /// So "loading" and "loading MORE" are different states. This one keeps the
  /// rows, the offset and the listener alive, and screens show it as a footer
  /// spinner under the last row.
  final bool isLoadingMore;

  const TransactionHistoryLoaded({
    required this.transactions,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    this.activeFilters,
    this.statistics,
    this.isLoadingMore = false,
  });

  TransactionHistoryLoaded copyWith({
    List<UnifiedTransaction>? transactions,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
    TransactionFilters? activeFilters,
    TransactionStatistics? statistics,
    bool clearFilters = false,
    bool? isLoadingMore,
  }) {
    return TransactionHistoryLoaded(
      transactions: transactions ?? this.transactions,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      activeFilters:
          clearFilters ? null : (activeFilters ?? this.activeFilters),
      statistics: statistics ?? this.statistics,
      // NOT carried forward by default. Every existing copyWith call site is
      // a page that has ARRIVED, so the spinner has to clear itself unless
      // the caller is explicitly starting another fetch.
      isLoadingMore: isLoadingMore ?? false,
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
        isLoadingMore,
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
