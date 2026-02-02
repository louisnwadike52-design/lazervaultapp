import 'package:flutter/material.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// Full-screen transaction detail — unified receipt view
class TransactionDetailScreen extends StatelessWidget {
  final UnifiedTransaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(
      transaction: transaction,
      fromHistory: true,
    );
  }
}
