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

      // Primary query — backend filters WHERE counterparty_account =
      // recipientAccountNumber. Works for internal C2C (where the LazerVault
      // virtual account is stored as the counterparty) but can miss EXTERNAL
      // transfers where the backend may write the destination bank account
      // into a different field, or write the account+name into
      // description/reference instead. We follow up with a name-based
      // search and merge the two result sets so the user sees transactions
      // with this recipient regardless of which path the backend took.
      final byAccountResp = await repository.fetchAllTransactions(
        page: 1,
        limit: 200,
        filters: TransactionFilters(
          counterpartyAccount: recipientAccountNumber,
        ),
      );

      var transactions = List<UnifiedTransaction>.from(byAccountResp.transactions);

      developer.log(
        '[RecipientTxHistory] By counterparty_account: ${transactions.length}',
      );

      // Fallback / supplemental query: search by recipient name. External
      // transfers usually store the beneficiary name on the transaction; the
      // backend `searchQuery` filter scans description + reference + name.
      // We always run this in addition to the account filter (not just when
      // the first is empty) because a recipient could have BOTH internal and
      // external transactions and we want both sets.
      if (recipientName.trim().isNotEmpty) {
        try {
          final byNameResp = await repository.fetchAllTransactions(
            page: 1,
            limit: 200,
            filters: TransactionFilters(searchQuery: recipientName.trim()),
          );
          developer.log(
            '[RecipientTxHistory] By searchQuery name: '
            '${byNameResp.transactions.length}',
          );
          // Tighten the name search to transactions that actually touch this
          // recipient (description/counterpartyName contains the recipient
          // name OR exact account match). Avoids surfacing unrelated rows
          // that happened to contain the name as a substring (e.g., common
          // first names appearing in narrations).
          final lowerName = recipientName.trim().toLowerCase();
          final lowerAccount = recipientAccountNumber.trim().toLowerCase();
          for (final tx in byNameResp.transactions) {
            final touchesAccount = (tx.counterpartyAccount ?? '')
                .toLowerCase()
                .contains(lowerAccount) && lowerAccount.isNotEmpty;
            final touchesName = (tx.counterpartyName ?? '')
                    .toLowerCase()
                    .contains(lowerName) ||
                (tx.description ?? '').toLowerCase().contains(lowerName);
            if (touchesAccount || touchesName) {
              transactions.add(tx);
            }
          }
        } catch (e) {
          developer.log('[RecipientTxHistory] Name-search fallback failed: $e');
          // Swallow — primary set still surfaces if it had results.
        }
      }

      // Deduplicate by reference (backend creates duplicate records from
      // TransferBalance + RecordTransaction paths AND we may now have the
      // same record from both queries).
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
