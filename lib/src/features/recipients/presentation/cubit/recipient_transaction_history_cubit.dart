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
      final response = await repository.fetchServiceTransactions(
        TransactionServiceType.transfer,
        page: 1,
        limit: 100,
      );

      final accountLower = recipientAccountNumber.toLowerCase();
      final nameLower = recipientName.toLowerCase();

      final filtered = response.transactions.where((tx) {
        // Match by counterparty account
        if (tx.counterpartyAccount?.toLowerCase() == accountLower) return true;
        // Match by counterparty name
        if (tx.counterpartyName?.toLowerCase() == nameLower) return true;
        // Match by description containing account number or name
        final desc = tx.description?.toLowerCase() ?? '';
        if (desc.contains(accountLower)) return true;
        if (accountLower.isNotEmpty && desc.contains(accountLower)) return true;
        // Match by metadata
        final meta = tx.metadata;
        if (meta != null) {
          final metaRecipient = (meta['recipient_name'] as String?)?.toLowerCase();
          final metaAccount = (meta['recipient_account'] as String?)?.toLowerCase();
          if (metaRecipient == nameLower) return true;
          if (metaAccount == accountLower) return true;
        }
        return false;
      }).toList();

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
