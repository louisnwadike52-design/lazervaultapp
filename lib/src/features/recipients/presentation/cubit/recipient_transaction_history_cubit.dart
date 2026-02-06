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
      // Fetch ALL transactions (not just transfers) since payments could be categorized differently
      final response = await repository.fetchAllTransactions(
        page: 1,
        limit: 100,
      );

      final nameLower = recipientName.toLowerCase().trim();
      final nameWords = nameLower.split(' ').where((w) => w.isNotEmpty).toList();

      // For outgoing transfers/payments, match by recipient name
      final filtered = response.transactions.where((tx) {
        // Only include outgoing transactions (money sent to this recipient)
        if (tx.flow != TransactionFlow.outgoing) return false;

        // Match by title containing recipient name (most reliable)
        if (tx.title.toLowerCase().contains(nameLower)) {
          return true;
        }

        // Match by any word of recipient name in title (handles name variations)
        if (nameWords.isNotEmpty) {
          for (final word in nameWords) {
            if (word.length > 2 && tx.title.toLowerCase().contains(word)) {
              return true;
            }
          }
        }

        // Match by counterparty name
        if (tx.counterpartyName?.toLowerCase().contains(nameLower) == true) {
          return true;
        }

        // Match by counterparty name containing any word of recipient name
        if (tx.counterpartyName != null && nameWords.isNotEmpty) {
          for (final word in nameWords) {
            if (word.length > 2 && tx.counterpartyName!.toLowerCase().contains(word)) {
              return true;
            }
          }
        }

        // Match by description containing recipient name
        final desc = tx.description?.toLowerCase() ?? '';
        if (desc.contains(nameLower)) {
          return true;
        }

        // Match by metadata - check all metadata values for recipient name
        final meta = tx.metadata;
        if (meta != null) {
          for (final value in meta.values) {
            if (value?.toString().toLowerCase().contains(nameLower) == true) {
              return true;
            }
          }
        }

        // Match transfers by checking title keywords
        if (tx.title.toLowerCase().contains('transfer') ||
            tx.title.toLowerCase().contains('sent')) {
          // Check if account number matches
          if (recipientAccountNumber.isNotEmpty) {
            final accountDigits = recipientAccountNumber.replaceAll(RegExp(r'[^\d]'), '');
            final txDesc = (tx.description ?? '').toLowerCase();
            final txMeta = tx.metadata.toString().toLowerCase();
            if (txDesc.contains(accountDigits) || txMeta.contains(accountDigits)) {
              return true;
            }
          }
        }

        return false;
      }).toList();

      // Sort by date, newest first
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      if (filtered.isEmpty) {
        emit(const RecipientTransactionHistoryEmpty());
      } else {
        emit(RecipientTransactionHistoryLoaded(transactions: filtered));
      }
    } catch (e) {
      emit(RecipientTransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> refresh() async {
    if (_recipientAccountNumber != null && _recipientName != null) {
      await loadRecipientTransactions(_recipientAccountNumber!, _recipientName!);
    }
  }
}
