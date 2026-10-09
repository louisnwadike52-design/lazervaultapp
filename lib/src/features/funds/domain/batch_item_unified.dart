import 'package:lazervault/core/types/unified_transaction.dart';

/// One projection of a batch recipient onto the receipt model, shared by
/// every surface that can produce that recipient's receipt.
///
/// Reported: "Details in batch transfer receipt from [the batch] flow should
/// be the same as the sendfunds receipt and share — and the same as when the
/// user accesses the receipt from batch transfer history, general history or
/// any other history source."
///
/// They were not the same, in three different ways for the same payment:
///
///   * the item receipt SCREEN hand-built its own header, its own
///     Download/Share pair and its own eight-row Details card;
///   * the batch receipt screen and the batch detail screen each had an
///     inline per-recipient download/share that called
///     BatchTransferPdfService with a loose `Map<String, dynamic>`;
///   * transaction history rendered the same payment through
///     UnifiedTransactionReceipt.
///
/// Three layouts and two PDF generators for one transfer, disagreeing about
/// which fields exist, how money is formatted and what a status is called.
/// This is the single projection they all go through now, so "the same
/// receipt wherever you opened it from" holds by construction rather than by
/// keeping three screens in step.

/// A batch item's status in the receipt's vocabulary.
///
/// `failed` becomes REFUNDED, not FAILED: a failed item released its hold, so
/// the money came back. Telling someone their transfer failed on a document
/// they may show a merchant, when the funds are already in their account, is
/// the ambiguity the refunded state exists to remove — the same call the
/// recurring-execution receipt makes.
UnifiedTransactionStatus batchItemStatus(String raw) {
  switch (raw.toLowerCase().trim()) {
    case 'success':
    case 'successful':
    case 'completed':
      return UnifiedTransactionStatus.completed;
    case 'failed':
    case 'reversed':
      return UnifiedTransactionStatus.refunded;
    case 'pending':
    case 'processing':
    case 'queued':
    case 'submitted':
      return UnifiedTransactionStatus.processing;
    default:
      // An unrecognised status must never be asserted as completed: a receipt
      // is what the user shows a merchant.
      return UnifiedTransactionStatus.processing;
  }
}

UnifiedTransaction batchItemUnified({
  required String itemId,
  required String status,
  required double amount,
  required String currency,
  double fee = 0,
  String reference = '',
  String recipientName = '',
  String recipientAccount = '',
  String bankName = '',
  String bankCode = '',
  String transferType = '',
  String narration = '',
  String failureReason = '',
  String providerName = '',
  String providerRef = '',
  String providerStatus = '',
  String paymentReference = '',
  String batchId = '',
  String sourceAccountName = '',
  String sourceAccountNumber = '',
  DateTime? at,
}) {
  final metadata = <String, dynamic>{
    // Bank name AND code. The shared resolver reads both key lists and the
    // code is what BankLogo matches on, so passing only the name loses the
    // logo the item screen used to draw by hand.
    if (bankName.isNotEmpty) 'recipient_bank_name': bankName,
    if (bankCode.isNotEmpty) 'recipient_bank_code': bankCode,
    // Money in MINOR units, under the *_minor convention the receipt
    // humanizes; a bare 'fee' would print as a raw number.
    if (fee > 0) 'fee_minor': (fee * 100).round(),
    if (failureReason.isNotEmpty) 'reason': failureReason,
    if (narration.isNotEmpty) 'narration': narration,
    if (transferType.isNotEmpty) 'transfer_type': transferType,
    if (providerName.isNotEmpty) 'provider': providerName,
    if (providerStatus.isNotEmpty) 'provider_status': providerStatus,
    if (providerRef.isNotEmpty) 'provider_ref': providerRef,
    if (paymentReference.isNotEmpty) 'payment_reference': paymentReference,
    // What makes this a BATCH receipt rather than a lone transfer — the one
    // thing the unified layout cannot infer, and what someone reconciling a
    // payout run needs on the shared document.
    if (batchId.isNotEmpty) 'batch_id': batchId,
    if (sourceAccountName.isNotEmpty) 'source_account_name': sourceAccountName,
    if (sourceAccountNumber.isNotEmpty) 'source_account': sourceAccountNumber,
    // Lets the receipt rebuild a payee for "Redo".
    if (recipientName.isNotEmpty) 'recipient_name': recipientName,
    if (recipientAccount.isNotEmpty) 'recipient_account': recipientAccount,
  };

  final recipient = recipientName.isNotEmpty ? recipientName : recipientAccount;

  return UnifiedTransaction(
    // The ITEM's id, not the batch's: two recipients in one batch are two
    // receipts and must not collide in any cache keyed by this.
    id: itemId,
    serviceType: TransactionServiceType.transfer,
    title: 'Batch transfer',
    description: narration.isNotEmpty
        ? narration
        : (recipient.isEmpty ? null : 'Transfer to $recipient'),
    amount: amount,
    currency: currency,
    createdAt: (at ?? DateTime.now()).toLocal(),
    status: batchItemStatus(status),
    // A batch item is always money leaving this user's account.
    flow: TransactionFlow.outgoing,
    transactionReference: reference.isEmpty ? null : reference,
    metadata: metadata,
    counterpartyName: recipientName.isEmpty ? null : recipientName,
    counterpartyAccount: recipientAccount.isEmpty ? null : recipientAccount,
    // Balances are deliberately absent: batch items do not record them, and a
    // guess on a document people treat as proof of what their account held is
    // worse than an omitted row.
  );
}

/// The same projection from the loose `Map<String, dynamic>` the batch receipt
/// and batch detail screens already build for their inline per-recipient
/// actions, so those produce the identical document without first being
/// refactored onto a typed entity.
UnifiedTransaction batchItemUnifiedFromMap(
  Map<String, dynamic> transfer, {
  String batchId = '',
  String currency = 'NGN',
  String sourceAccountName = '',
  String sourceAccountNumber = '',
  DateTime? at,
}) {
  String s(String key) => (transfer[key] ?? '').toString().trim();
  double d(String key) {
    final v = transfer[key];
    if (v is num) return v.toDouble();
    return double.tryParse(v?.toString() ?? '') ?? 0;
  }

  return batchItemUnified(
    // These maps carry no item id. The reference is the stable per-recipient
    // identifier on them; falling back to the account keeps two recipients in
    // one batch from sharing a cache key when a reference is missing.
    itemId: s('itemId').isNotEmpty
        ? s('itemId')
        : (s('reference').isNotEmpty
            ? s('reference')
            : '$batchId:${s('recipientAccount')}'),
    status: s('status'),
    amount: d('amount'),
    currency: s('currency').isNotEmpty ? s('currency') : currency,
    fee: d('fee'),
    reference: s('reference'),
    recipientName: s('recipientName'),
    recipientAccount: s('recipientAccount'),
    bankName: s('bankName'),
    bankCode: s('bankCode'),
    narration: s('narration'),
    failureReason: s('failureReason'),
    batchId: batchId,
    sourceAccountName: sourceAccountName,
    sourceAccountNumber: sourceAccountNumber,
    at: at,
  );
}
