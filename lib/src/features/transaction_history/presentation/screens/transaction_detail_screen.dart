import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// Full-screen transaction detail — unified receipt view.
/// Fetches fresh transaction data from API while showing the passed-in
/// transaction as an immediate placeholder.
class TransactionDetailScreen extends StatelessWidget {
  final UnifiedTransaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<TransactionHistoryCubit>()
        ..loadTransactionDetails(transaction.id),
      child: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
        builder: (context, state) {
          // Use fresh data when available, otherwise show the passed-in transaction
          final tx = state is TransactionDetailsLoaded
              ? state.transaction
              : transaction;
          return UnifiedTransactionReceipt(
            transaction: tx,
            fromHistory: true,
          );
        },
      ),
    );
  }
}
