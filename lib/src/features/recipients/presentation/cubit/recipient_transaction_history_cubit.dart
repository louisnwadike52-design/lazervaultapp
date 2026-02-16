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

      // Filter to outgoing transactions matching this recipient
      final filtered = response.transactions.where((tx) {
        // Only include outgoing transactions (money sent to this recipient)
        if (tx.flow != TransactionFlow.outgoing) return false;

        // 1. Direct account number match (most reliable)
        if (recipientAccountNumber.isNotEmpty &&
            tx.counterpartyAccount != null &&
            tx.counterpartyAccount!.isNotEmpty &&
            tx.counterpartyAccount == recipientAccountNumber) {
          return true;
        }

        // 2. Account number in description or metadata
        if (recipientAccountNumber.isNotEmpty) {
          final accountDigits = recipientAccountNumber.replaceAll(RegExp(r'[^\d]'), '');
          if (accountDigits.length >= 6) {
            final desc = tx.description ?? '';
            if (desc.contains(accountDigits)) return true;
            final meta = tx.metadata;
            if (meta != null) {
              for (final value in meta.values) {
                if (value?.toString().contains(accountDigits) == true) {
                  return true;
                }
              }
            }
          }
        }

        // 3. Counterparty name exact match
        if (tx.counterpartyName != null &&
            tx.counterpartyName!.toLowerCase().trim() == nameLower) {
          return true;
        }

        // 4. Title contains recipient full name (e.g. "Transfer to Grace")
        if (tx.title.toLowerCase().contains(nameLower)) {
          return true;
        }

        // 5. Counterparty name contains recipient name or vice versa
        if (tx.counterpartyName != null) {
          final cpLower = tx.counterpartyName!.toLowerCase().trim();
          if (cpLower.contains(nameLower) || nameLower.contains(cpLower)) {
            return true;
          }
        }

        // 6. Match by any significant word of recipient name in counterparty or title
        if (nameWords.isNotEmpty) {
          for (final word in nameWords) {
            if (word.length > 2) {
              if (tx.counterpartyName?.toLowerCase().contains(word) == true) {
                return true;
              }
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
