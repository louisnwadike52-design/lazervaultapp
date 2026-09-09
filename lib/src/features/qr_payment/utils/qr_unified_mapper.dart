import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_transaction_entity.dart';

/// Adapts a QR transaction into the [UnifiedTransaction] shape the dashboard
/// transaction history renders, so the QR flow and QR history pages open the
/// SAME rich receipt (and its PDF/JPG/share pipeline) as the dashboard.
///
/// [viewerUserId] decides direction: the payer sees an outgoing debit to the
/// recipient; the QR owner sees an incoming credit from the payer.
UnifiedTransaction qrTxnToUnified(
  QRTransactionEntity txn, {
  String? viewerUserId,
  double? newBalance,
}) {
  final viewerIsPayer = viewerUserId == null ||
      viewerUserId.isEmpty ||
      viewerUserId == txn.payerId;
  final otherName = viewerIsPayer
      ? (txn.recipientName.isNotEmpty ? txn.recipientName : txn.recipientUsername)
      : (txn.payerName.isNotEmpty ? txn.payerName : txn.payerUsername);
  final otherHandle =
      viewerIsPayer ? txn.recipientUsername : txn.payerUsername;

  return UnifiedTransaction(
    id: txn.id.isNotEmpty ? txn.id : txn.referenceNumber,
    serviceType: TransactionServiceType.qrPayment,
    title: otherName.isNotEmpty
        ? (viewerIsPayer ? 'QR Payment to $otherName' : 'QR Payment from $otherName')
        : 'QR Payment',
    description: txn.description.isNotEmpty ? txn.description : null,
    amount: txn.amount,
    currency: txn.currency,
    createdAt: txn.createdAt,
    status: txn.status == QRTransactionStatus.completed
        ? UnifiedTransactionStatus.completed
        : UnifiedTransactionStatus.failed,
    flow: viewerIsPayer ? TransactionFlow.outgoing : TransactionFlow.incoming,
    transactionReference: txn.referenceNumber,
    counterpartyName: otherName.isNotEmpty ? otherName : null,
    counterpartyAccount: otherHandle.isNotEmpty ? '@$otherHandle' : null,
    metadata: {
      if (txn.qrId.isNotEmpty) 'qr_id': txn.qrId,
      if (txn.payerName.isNotEmpty) 'payer_name': txn.payerName,
      if (txn.payerUsername.isNotEmpty) 'payer_username': txn.payerUsername,
      // PDF payload (generateUnifiedTransferReceipt resolves From/To off
      // these snake_case chains — without them the sender line printed
      // blank on the Revolut-style receipt).
      if (txn.payerName.isNotEmpty) 'sender_name': txn.payerName,
      if (txn.recipientName.isNotEmpty) 'recipient_name': txn.recipientName,
      if (newBalance != null)
        'new_balance': '${txn.currency} ${newBalance.toStringAsFixed(2)}',
    },
  );
}
