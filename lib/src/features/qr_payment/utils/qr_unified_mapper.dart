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
  // The viewer's ACTUAL account used, formatted "Personal (0123456789)".
  // Shown as the "Account" row instead of the counterparty @handle (which now
  // gets its own Username row). Only known on the payer's just-paid receipt;
  // null in history views, where the Account row is simply omitted.
  String? sourceAccountLabel,
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
    // Deliberately null: counterpartyAccount feeds the PDF's recipient/
    // beneficiary block, and QR carries no counterparty account number. The
    // counterparty @handle is shown on its own Username row, and the viewer's
    // OWN account is a dedicated 'account' metadata row (below) — so nothing
    // mislabels the payer's account as the recipient's.
    counterpartyAccount: null,
    metadata: {
      if (txn.qrId.isNotEmpty) 'qr_id': txn.qrId,
      // ONE handle row (with the @). The name is already shown once via
      // counterpartyName, so this avoids the payer/name/username duplication.
      if (otherHandle.isNotEmpty) 'username': '@$otherHandle',
      // The viewer's ACTUAL account ("Personal (0123456789)") → renders as the
      // "Account" row. Only known on the payer's just-paid receipt.
      if (sourceAccountLabel != null && sourceAccountLabel.trim().isNotEmpty)
        'account': sourceAccountLabel.trim(),
      // PDF payload (generateUnifiedTransferReceipt resolves From/To off these
      // snake_case chains). Hidden from the widget list (baseHiddenKeys) so they
      // don't re-print as rows — they exist only for the PDF From/To lines.
      if (txn.payerName.isNotEmpty) 'sender_name': txn.payerName,
      if (txn.recipientName.isNotEmpty) 'recipient_name': txn.recipientName,
      if (newBalance != null)
        'new_balance': '${txn.currency} ${newBalance.toStringAsFixed(2)}',
    },
  );
}
