import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/id_pay/domain/entities/id_pay_transaction_entity.dart';

/// Adapts a PayID transaction into the [UnifiedTransaction] shape the
/// dashboard transaction history renders, so the PayID flow and the
/// creator's payers list open the SAME rich receipt (and its PDF/JPG/share
/// pipeline) as the dashboard — the QR-pay precedent applied to PayID.
///
/// [viewerUserId] decides direction: the payer sees an outgoing debit to the
/// creator; the PayID creator sees an incoming credit from the payer. The
/// platform fee is recipient-borne, so fee/net rows are only added on the
/// creator's (incoming) view — the payer paid exactly the displayed amount.
UnifiedTransaction idPayTxnToUnified(
  IDPayTransactionEntity txn, {
  String? viewerUserId,
  double? newBalance,
}) {
  final viewerIsPayer = viewerUserId == null ||
      viewerUserId.isEmpty ||
      viewerUserId == txn.payerId;
  final otherName = viewerIsPayer
      ? txn.recipientName
      : (txn.payerName.isNotEmpty ? txn.payerName : txn.payerUsername);
  final otherHandle = viewerIsPayer ? '' : txn.payerUsername;

  return UnifiedTransaction(
    id: txn.id.isNotEmpty ? txn.id : txn.reference,
    serviceType: TransactionServiceType.idPay,
    title: otherName.isNotEmpty
        ? (viewerIsPayer ? 'PayID Payment to $otherName' : 'PayID Payment from $otherName')
        : 'PayID Payment',
    amount: txn.amount,
    currency: txn.currency,
    createdAt: txn.createdAt,
    status: txn.isCompleted
        ? UnifiedTransactionStatus.completed
        : UnifiedTransactionStatus.failed,
    flow: viewerIsPayer ? TransactionFlow.outgoing : TransactionFlow.incoming,
    transactionReference: txn.reference,
    counterpartyName: otherName.isNotEmpty ? otherName : null,
    counterpartyAccount: otherHandle.isNotEmpty ? '@$otherHandle' : null,
    metadata: {
      'pay_id': 'PAY-${txn.payId}',
      if (txn.payerName.isNotEmpty) 'payer_name': txn.payerName,
      if (txn.payerUsername.isNotEmpty) 'payer_username': txn.payerUsername,
      if (!viewerIsPayer && txn.fee > 0) ...{
        'platform_fee': '${txn.currency} ${txn.fee.toStringAsFixed(2)}',
        'you_receive': '${txn.currency} ${txn.creatorReceives.toStringAsFixed(2)}',
      },
      if (newBalance != null)
        'new_balance': '${txn.currency} ${newBalance.toStringAsFixed(2)}',
    },
  );
}
