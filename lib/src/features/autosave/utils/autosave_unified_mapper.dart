import 'package:lazervault/core/types/unified_transaction.dart';

import '../domain/entities/autosave_rule_entity.dart';
import 'autosave_trigger_labels.dart';

/// Adapts an AutoSave transaction into the [UnifiedTransaction] the dashboard
/// transaction history renders, so a save opens the SAME rich receipt (and
/// its PDF/JPG/share pipeline) wherever you tap it.
///
/// Before this, the in-feature history showed a bespoke read-only sheet with
/// raw account UUIDs while the GLOBAL history rendered the same event through
/// the rich receipt — two different faces for one transaction. QR/PayID
/// precedent.
UnifiedTransaction autoSaveTxnToUnified(
  AutoSaveTransactionEntity txn, {
  String? ruleName,
  String? sourceLabel,
  String? destinationLabel,
}) {
  final triggerName = AutoSaveTriggerLabels.nameOf(txn.triggerType);
  final title = ruleName != null && ruleName.isNotEmpty
      ? 'AutoSave · $ruleName'
      : 'AutoSave · $triggerName';

  // A bank pull that banking has accepted but not yet settled is NOT money in
  // hand — show it as processing rather than completed.
  final status = !txn.success
      ? UnifiedTransactionStatus.failed
      : (txn.isAwaitingSettlement
          ? UnifiedTransactionStatus.processing
          : UnifiedTransactionStatus.completed);

  return UnifiedTransaction(
    id: txn.id,
    serviceType: TransactionServiceType.autosave,
    title: title,
    description: AutoSaveTriggerLabels.descriptionOf(txn.triggerType),
    // The NET saved is the headline — it's what actually reached savings.
    amount: txn.amount,
    currency: txn.currency,
    createdAt: txn.createdAt,
    status: status,
    // Money leaves the source and lands in savings; from the saver's seat
    // this is an internal move, shown as outgoing from the funding account.
    flow: TransactionFlow.outgoing,
    transactionReference: txn.id,
    counterpartyName: destinationLabel ?? 'Savings',
    counterpartyAccount: sourceLabel,
    metadata: {
      'trigger': triggerName,
      if (txn.triggerReason.isNotEmpty) 'trigger_reason': txn.triggerReason,
      if (txn.fee > 0) ...{
        'platform_fee': '${txn.currency} ${txn.fee.toStringAsFixed(2)}',
        'amount_moved':
            '${txn.currency} ${txn.grossOrAmount.toStringAsFixed(2)}',
        'you_saved': '${txn.currency} ${txn.amount.toStringAsFixed(2)}',
      },
      if (txn.isAwaitingSettlement)
        'settlement': 'Awaiting your bank — this completes once the debit '
            'settles.',
      if (!txn.success && (txn.errorMessage ?? '').isNotEmpty)
        'failure_reason': txn.errorMessage!,
    },
  );
}
