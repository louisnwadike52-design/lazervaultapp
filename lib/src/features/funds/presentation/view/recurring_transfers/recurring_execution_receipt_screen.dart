import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// Receipt for ONE execution of a recurring payment.
///
/// Built on [UnifiedTransactionReceipt] rather than as a new screen, which is
/// the whole point: that widget already owns the Revolut-style layout, the
/// share and download actions, and the PDF generator with the embedded fonts
/// (so ₦, em-dashes and accents render instead of tofu boxes). A bespoke
/// receipt here would be a second thing to keep in step with every one of
/// those, and the PDF would be the half that silently regressed.
///
/// The payload is assembled from the execution plus its PARENT transfer,
/// because an execution row is deliberately thin — amount, fee, reference,
/// status, timestamps — and the payee, currency and note live on the schedule.
class RecurringExecutionReceiptScreen extends StatelessWidget {
  const RecurringExecutionReceiptScreen({
    super.key,
    required this.transfer,
    required this.execution,
    this.executionNumber,
  });

  final RecurringTransferEntity transfer;
  final RecurringTransferExecutionEntity execution;

  /// 1-based position in the history, newest-last. Shown as "Payment 3 of 7"
  /// so a user with a long history can tell two identical-looking receipts
  /// apart. Null when the caller does not know the ordering.
  final int? executionNumber;

  static void open({
    required RecurringTransferEntity transfer,
    required RecurringTransferExecutionEntity execution,
    int? executionNumber,
    int? totalExecutions,
  }) {
    Get.to(
      () => RecurringExecutionReceiptScreen(
        transfer: transfer,
        execution: execution,
        executionNumber: executionNumber,
      ),
      transition: Transition.rightToLeft,
    );
  }

  /// Maps an execution's status to the receipt vocabulary.
  ///
  /// The server writes only "success" or "failed" here, but a failed execution
  /// RELEASED its hold — the money came back — so it is `refunded`, not
  /// `failed`. Showing "Failed" on a receipt whose funds were returned is the
  /// exact ambiguity the refunded state was introduced to remove.
  UnifiedTransactionStatus get _status {
    switch (execution.status.toLowerCase()) {
      case 'success':
      case 'successful':
      case 'completed':
        return UnifiedTransactionStatus.completed;
      case 'failed':
        return UnifiedTransactionStatus.refunded;
      case 'pending':
      case 'processing':
        return UnifiedTransactionStatus.processing;
      default:
        // An unrecognised status must not be asserted as completed: a receipt
        // is what the user shows a merchant.
        return UnifiedTransactionStatus.processing;
    }
  }

  UnifiedTransaction get _transaction {
    final metadata = <String, dynamic>{
      // What this payment WAS, so the receipt stands alone when shared.
      'recurring_schedule': transfer.scheduleDescription,
      'frequency': transfer.frequency.label,
      if (executionNumber != null)
        'payment_number': transfer.totalExecutions > 0
            ? '$executionNumber of ${transfer.totalExecutions}'
            : '$executionNumber',
      // When it was DUE versus when it RAN. A worker that catches up after a
      // restart executes minutes or hours late, and a receipt that shows only
      // one of the two timestamps cannot answer "why is this dated today when
      // I set it for yesterday?".
      'scheduled_for': DateFormat('d MMM yyyy, HH:mm')
          .format(execution.scheduledFor.toLocal()),
      if (transfer.recipientBankName.isNotEmpty)
        'recipient_bank_name': transfer.recipientBankName,
      // Rendered as a humanized money row by the receipt (outgoing only — the
      // fee is the sender's cost).
      if (execution.fee > 0) 'fee_minor': (execution.fee * 100).round(),
      if (execution.failureReason.isNotEmpty)
        'reason': execution.failureReason,
      // Lets the receipt rebuild a payee for "Redo".
      'recipient_name': transfer.recipientName,
      'recipient_account': transfer.recipientAccountNumber,
    };

    return UnifiedTransaction(
      // The EXECUTION's id, not the schedule's: two executions of one
      // recurring payment are different receipts and must not collide in any
      // cache keyed by this.
      id: execution.id,
      serviceType: TransactionServiceType.transfer,
      title: 'Recurring payment',
      description: transfer.description.isNotEmpty
          ? transfer.description
          : 'Recurring payment to ${transfer.recipientName}',
      amount: execution.amount,
      currency: execution.currency.isNotEmpty
          ? execution.currency
          : transfer.currency,
      createdAt: execution.executedAt.toLocal(),
      status: _status,
      // A recurring payment is always money leaving this user's account.
      flow: TransactionFlow.outgoing,
      transactionReference:
          execution.reference.isNotEmpty ? execution.reference : null,
      metadata: metadata,
      counterpartyName: transfer.recipientName,
      counterpartyAccount: transfer.recipientAccountNumber,
      // Balances are deliberately absent. recurring_transfer_executions does
      // not record them, and the only way to state a balance here would be to
      // guess from the schedule's amount — on a document people treat as proof
      // of what their account held, a guess is worse than an omitted row.
      // `hasBalances` already makes the receipt skip the section cleanly.
    );
  }

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(
      transaction: _transaction,
      // Not from the history list: this is reached from the recurring payment's
      // own detail screen, and `fromHistory` changes the back behaviour.
      fromHistory: false,
    );
  }
}
