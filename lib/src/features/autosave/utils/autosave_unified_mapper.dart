import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
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
/// [userName] is the saver — the PDF prints it as the FROM heading, exactly
/// where a transfer receipt prints the sender. Without it the document showed
/// an empty FROM box.
///
/// [sourceLabel] / [destinationLabel] are the human account names, and
/// [sourceDetail] / [destinationAccount] the line beneath each (a masked
/// number, or for a bank-funded rule the bank the Direct Debit pulled from).
/// These used to be absent or hardcoded, so the receipt said "Savings" with no
/// account either side and could not tell you WHICH account a save came from.
UnifiedTransaction autoSaveTxnToUnified(
  AutoSaveTransactionEntity txn, {
  String? ruleName,
  String? userName,
  String? sourceLabel,
  String? sourceDetail,
  String? destinationLabel,
  String? destinationAccount,
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
    // The DESTINATION account. This slot feeds the beneficiary's account line,
    // and it used to be handed the SOURCE — so the receipt named the account
    // the money left as the one it arrived in.
    counterpartyAccount: destinationAccount,
    metadata: {
      'trigger': triggerName,
      // ── Keys the unified transfer PDF reads to fill its party blocks ──
      // The saver, printed as the FROM heading where a transfer prints its
      // sender. A save is still money leaving a named person's account.
      if ((userName ?? '').isNotEmpty) 'Source Account': userName!,
      // The line under FROM: which account funded this save. For a bank-funded
      // rule that is the BANK the Direct Debit pulled from, which the receipt
      // could not show at all before.
      if ((sourceDetail ?? sourceLabel ?? '').isNotEmpty)
        'sender_account': (sourceDetail ?? sourceLabel)!,
      if ((destinationLabel ?? '').isNotEmpty)
        'recipient_name': destinationLabel!,
      if ((destinationAccount ?? '').isNotEmpty)
        'recipient_account': destinationAccount!,
      // Stops the Type row reading "Fund Transfer" — a generic default that
      // told the reader nothing about which of the five triggers fired.
      'Transfer Type': 'AutoSave · $triggerName',
      if (txn.triggerReason.isNotEmpty) 'trigger_reason': txn.triggerReason,
      // Gross and fee, but NOT the net: the headline amount above is already
      // the net saved, so a "you saved" row would repeat it and read like a
      // second, different number.
      //
      // Unlike the platform_fee_*_kobo keys the receipt deliberately hides
      // (those are a breakdown of OUR margin on someone else's charge), this
      // fee is taken out of the user's own save — they moved one amount and a
      // smaller one landed, so they are owed both numbers.
      if (txn.fee > 0) ...{
        // Formatted through the shared currency helper so these rows carry ₦
        // like the rest of the app — and, since the metadata is rendered
        // verbatim into the PDF, so the exported document does too.
        'amount_moved': currency_formatter.CurrencySymbols
            .formatAmountWithCurrency(txn.grossOrAmount, txn.currency),
        'platform_fee': currency_formatter.CurrencySymbols
            .formatAmountWithCurrency(txn.fee, txn.currency),
      },
      if (txn.isAwaitingSettlement)
        'settlement': 'Awaiting your bank — this completes once the debit '
            'settles.',
      if (!txn.success && (txn.errorMessage ?? '').isNotEmpty)
        'failure_reason': txn.errorMessage!,
    },
  );
}
