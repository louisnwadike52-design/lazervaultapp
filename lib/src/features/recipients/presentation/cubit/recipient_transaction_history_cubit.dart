import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';

// Sealed states
sealed class RecipientTransactionHistoryState {
  const RecipientTransactionHistoryState();
}

class RecipientTransactionHistoryInitial extends RecipientTransactionHistoryState {
  const RecipientTransactionHistoryInitial();
}

class RecipientTransactionHistoryLoading extends RecipientTransactionHistoryState {
  const RecipientTransactionHistoryLoading();
}

class RecipientTransactionHistoryLoaded extends RecipientTransactionHistoryState {
  final List<UnifiedTransaction> transactions;
  const RecipientTransactionHistoryLoaded({required this.transactions});
}

class RecipientTransactionHistoryEmpty extends RecipientTransactionHistoryState {
  const RecipientTransactionHistoryEmpty();
}

class RecipientTransactionHistoryError extends RecipientTransactionHistoryState {
  final String message;
  const RecipientTransactionHistoryError({required this.message});
}

class RecipientTransactionHistoryCubit extends Cubit<RecipientTransactionHistoryState> {
  final TransactionHistoryRepository repository;

  String? _recipientAccountNumber;
  String? _recipientName;

  /// All transactions matching this recipient (before search filtering)
  List<UnifiedTransaction> _allRecipientTransactions = [];

  RecipientTransactionHistoryCubit({required this.repository})
      : super(const RecipientTransactionHistoryInitial());

  Future<void> loadRecipientTransactions(
    String recipientAccountNumber,
    String recipientName,
  ) async {
    if (state is RecipientTransactionHistoryLoading) return;

    _recipientAccountNumber = recipientAccountNumber;
    _recipientName = recipientName;

    emit(const RecipientTransactionHistoryLoading());

    try {
      developer.log(
        '[RecipientTxHistory] Loading transactions for: '
        'name="$recipientName", account="$recipientAccountNumber"',
      );

      // Use backend counterparty_account filter — the backend filters
      // transactions WHERE counterparty_account = recipientAccountNumber.
      // This catches both incoming and outgoing transfers with this person.
      final response = await repository.fetchAllTransactions(
        page: 1,
        limit: 200,
        filters: TransactionFilters(
          counterpartyAccount: recipientAccountNumber,
        ),
      );

      var transactions = response.transactions;

      developer.log(
        '[RecipientTxHistory] Backend returned ${transactions.length} '
        'transactions for counterparty "$recipientAccountNumber"',
      );

      // Deduplicate by reference (backend creates duplicate records from
      // TransferBalance + RecordTransaction paths). Keep the richer record.
      transactions = _deduplicateByReference(transactions);

      // Sort by date, newest first
      transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      _allRecipientTransactions = transactions;

      if (transactions.isEmpty) {
        emit(const RecipientTransactionHistoryEmpty());
      } else {
        emit(RecipientTransactionHistoryLoaded(transactions: transactions));
      }
    } catch (e) {
      developer.log('[RecipientTxHistory] Error: $e');
      emit(RecipientTransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  /// Deduplicate transactions that share the same reference.
  /// Keeps the record with more populated fields (counterpartyName, etc).
  List<UnifiedTransaction> _deduplicateByReference(List<UnifiedTransaction> txs) {
    final byRef = <String, UnifiedTransaction>{};
    for (final tx in txs) {
      final ref = tx.transactionReference ?? tx.id;
      // Strip -CR suffix to group sender/receiver records by base reference
      final baseRef = ref.endsWith('-CR') ? ref.substring(0, ref.length - 3) : ref;
      final key = '${baseRef}_${tx.flow.name}';
      final existing = byRef[key];
      if (existing == null) {
        byRef[key] = tx;
      } else {
        // Prefer the record with counterparty info populated
        final existingScore = (existing.counterpartyName != null ? 1 : 0) +
            (existing.counterpartyAccount != null ? 1 : 0);
        final newScore = (tx.counterpartyName != null ? 1 : 0) +
            (tx.counterpartyAccount != null ? 1 : 0);
        if (newScore > existingScore) {
          byRef[key] = tx;
        }
      }
    }
    return byRef.values.toList();
  }

  /// Filter loaded transactions by search query (local, no network call)
  void filterBySearch(String query) {
    final searchQuery = query.trim().toLowerCase();

    if (_allRecipientTransactions.isEmpty) return;

    if (searchQuery.isEmpty) {
      emit(RecipientTransactionHistoryLoaded(
        transactions: _allRecipientTransactions,
      ));
      return;
    }

    final filtered = _allRecipientTransactions.where((tx) {
      if (tx.title.toLowerCase().contains(searchQuery)) return true;
      if (tx.formattedAmount.toLowerCase().contains(searchQuery)) return true;
      if (tx.transactionReference?.toLowerCase().contains(searchQuery) == true) {
        return true;
      }
      if (tx.counterpartyName?.toLowerCase().contains(searchQuery) == true) {
        return true;
      }
      if (tx.description?.toLowerCase().contains(searchQuery) == true) {
        return true;
      }
      if (tx.currency.toLowerCase().contains(searchQuery)) return true;
      return false;
    }).toList();

    if (filtered.isEmpty) {
      emit(const RecipientTransactionHistoryEmpty());
    } else {
      emit(RecipientTransactionHistoryLoaded(transactions: filtered));
    }
  }

  Future<void> refresh() async {
    if (_recipientAccountNumber != null && _recipientName != null) {
      await loadRecipientTransactions(_recipientAccountNumber!, _recipientName!);
    }
  }
}
