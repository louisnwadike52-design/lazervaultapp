import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/contactless_payment/domain/entities/contactless_payment_entity.dart';

/// Adapts a contactless payment session into the [UnifiedTransaction] shape the
/// dashboard transaction history renders, so tapping a row in Payment History
/// opens the SAME rich receipt (and its PDF/JPG/share pipeline) as every other
/// service. Mirrors `qrTxnToUnified`.
///
/// The history rows already drew a chevron, but the card had no tap handler at
/// all — the affordance promised a receipt that was never wired.
///
/// [viewerUserId] decides direction: the receiver (who raised the request) sees
/// an incoming credit from the payer; the payer sees an outgoing debit.
UnifiedTransaction contactlessSessionToUnified(
  PaymentSessionEntity session, {
  String? viewerUserId,
}) {
  final viewerIsReceiver = viewerUserId == null ||
      viewerUserId.isEmpty ||
      viewerUserId == session.receiverId;

  final payerName = (session.payerName ?? '').trim();
  final receiverName = session.receiverName.trim().isNotEmpty
      ? session.receiverName.trim()
      : session.receiverUsername.trim();

  // Who the VIEWER is looking at across the counter.
  final otherName = viewerIsReceiver ? payerName : receiverName;

  return UnifiedTransaction(
    id: session.id,
    serviceType: TransactionServiceType.contactlessPay,
    title: otherName.isNotEmpty
        ? (viewerIsReceiver ? 'Tap to Pay from $otherName' : 'Tap to Pay to $otherName')
        : 'Tap to Pay',
    description: (session.description ?? '').trim().isNotEmpty
        ? session.description!.trim()
        : null,
    amount: session.amount,
    currency: session.currency,
    // A session's money moves when it COMPLETES; fall back to when it was
    // raised so an unpaid session still sorts and renders sensibly.
    createdAt: session.completedAt ?? session.createdAt,
    status: _statusFor(session.status),
    flow: viewerIsReceiver ? TransactionFlow.incoming : TransactionFlow.outgoing,
    transactionReference: session.id,
    counterpartyName: otherName.isNotEmpty ? otherName : null,
    // Deliberately null, same reasoning as the QR mapper: this feeds the PDF's
    // beneficiary block and a session carries no counterparty account number.
    counterpartyAccount: null,
    metadata: {
      if (session.receiverUsername.trim().isNotEmpty)
        'username': '@${session.receiverUsername.trim()}',
      if ((session.category ?? '').trim().isNotEmpty)
        'category': session.category!.trim(),
      // Only meaningful while a session is still open; a completed one shows
      // its completion time as the transaction date instead.
      if (!_isTerminal(session.status))
        'expires_at': session.expiresAt.toIso8601String(),
      // PDF payload — generateUnifiedTransferReceipt resolves From/To off these
      // snake_case chains. Hidden from the visible row list.
      if (payerName.isNotEmpty) 'sender_name': payerName,
      if (receiverName.isNotEmpty) 'recipient_name': receiverName,
    },
  );
}

UnifiedTransactionStatus _statusFor(PaymentSessionStatus s) {
  switch (s) {
    case PaymentSessionStatus.completed:
      return UnifiedTransactionStatus.completed;
    case PaymentSessionStatus.pending:
    case PaymentSessionStatus.read:
    case PaymentSessionStatus.processing:
      // Still in flight — the receipt shows a live/pending treatment rather
      // than claiming success or failure.
      return UnifiedTransactionStatus.pending;
    case PaymentSessionStatus.cancelled:
    case PaymentSessionStatus.expired:
      return UnifiedTransactionStatus.failed;
  }
}

bool _isTerminal(PaymentSessionStatus s) =>
    s == PaymentSessionStatus.completed ||
    s == PaymentSessionStatus.cancelled ||
    s == PaymentSessionStatus.expired;
