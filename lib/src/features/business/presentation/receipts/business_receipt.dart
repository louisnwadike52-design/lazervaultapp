import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// Shared, DRY entry point for every business-flow receipt (payroll, sale,
/// expense, tax, purchase order). Reuses the platform's Revolut-style
/// [UnifiedTransactionReceipt], which already provides Download (PNG to
/// .../Lazervault/Receipts/) + Share (OS sheet). Call [showBusinessReceipt] on
/// success of a business operation instead of a bare snackbar/`Get.back`.
class BusinessReceiptScreen extends StatelessWidget {
  final UnifiedTransaction transaction;

  const BusinessReceiptScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(transaction: transaction);
  }
}

/// Builds a [UnifiedTransaction] for a business operation. Currency defaults to
/// the active locale's currency. [amountMajor] is in major units (e.g. naira).
UnifiedTransaction buildBusinessReceipt({
  required TransactionServiceType type,
  required String title,
  required double amountMajor,
  String? currency,
  TransactionFlow flow = TransactionFlow.neutral,
  UnifiedTransactionStatus status = UnifiedTransactionStatus.completed,
  String? reference,
  String? counterpartyName,
  String? description,
  Map<String, dynamic>? metadata,
  DateTime? createdAt,
}) {
  final resolvedCurrency =
      (currency != null && currency.isNotEmpty && currency != 'USD')
          ? currency
          : GetIt.I<LocaleManager>().currentCurrency;
  final now = createdAt ?? DateTime.now();
  final id = (reference != null && reference.isNotEmpty)
      ? reference
      : 'BIZ-${now.microsecondsSinceEpoch}';
  return UnifiedTransaction(
    id: id,
    serviceType: type,
    title: title,
    description: description,
    amount: amountMajor,
    currency: resolvedCurrency,
    createdAt: now,
    status: status,
    flow: flow,
    transactionReference: reference,
    counterpartyName: counterpartyName,
    metadata: metadata,
  );
}

/// Navigates to the shareable/downloadable receipt for a business operation.
Future<void> showBusinessReceipt(
  BuildContext context,
  UnifiedTransaction transaction,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BusinessReceiptScreen(transaction: transaction),
    ),
  );
}
