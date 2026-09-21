import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// Adapts a completed ROSCA cycle payout into the [UnifiedTransaction] shape the
/// dashboard transaction history renders, so a member can open — and share — a
/// real receipt for the pot they received.
///
/// The cycle details sheet printed the payout's transaction id as a plain text
/// row. The single most significant money event in a savings circle, the moment
/// a member collects the pot, was a truncated id you could not tap, open, or
/// share. Every other service on the platform opens the rich receipt from its
/// history rows; ROSCA payouts were the exception.
///
/// [viewerUserId] decides direction: the cycle's receiver sees an incoming
/// credit; everyone else in the circle sees it as an outgoing payout to them.
UnifiedTransaction roscaPayoutToUnified(
  ContributionCycle cycle, {
  required String contributionTitle,
  String? viewerUserId,
}) {
  final viewerIsReceiver = viewerUserId != null &&
      viewerUserId.isNotEmpty &&
      viewerUserId == cycle.receiverUserId;
  final receiver =
      cycle.receiverName.trim().isNotEmpty ? cycle.receiverName.trim() : null;

  return UnifiedTransaction(
    id: cycle.payoutTransactionId ?? cycle.id,
    serviceType: TransactionServiceType.groupFunds,
    title: viewerIsReceiver
        ? 'Payout received · $contributionTitle'
        : (receiver != null
            ? 'Payout to $receiver · $contributionTitle'
            : 'Cycle payout · $contributionTitle'),
    description: 'Cycle ${cycle.cycleIndex}',
    // What actually moved is the pot that was raised, which is not always the
    // cycle target — a partially-funded cycle pays out what it collected.
    amount: cycle.raisedAmount,
    currency: cycle.currency,
    createdAt: cycle.endedAt ?? cycle.startedAt,
    status: UnifiedTransactionStatus.completed,
    flow:
        viewerIsReceiver ? TransactionFlow.incoming : TransactionFlow.outgoing,
    transactionReference: cycle.payoutTransactionId ?? cycle.id,
    counterpartyName: viewerIsReceiver ? contributionTitle : receiver,
    counterpartyAccount: null,
    metadata: {
      'cycle': '${cycle.cycleIndex}',
      if (receiver != null) 'recipient_name': receiver,
      // A shortfall is part of the record: it explains why the payout is less
      // than the cycle target, and hiding it would make the receipt look wrong.
      if (cycle.deficitAmount > 0)
        'shortfall':
            '${cycle.currency} ${cycle.deficitAmount.toStringAsFixed(2)}',
      if (cycle.paymentCount > 0) 'contributors': '${cycle.paymentCount}',
      'sender_name': contributionTitle,
    },
  );
}

/// Adapts a single member contribution into the [UnifiedTransaction] shape, so
/// a payment row in the cycle sheet opens the same rich receipt every other
/// service uses.
///
/// Payments were display-only: a name, a date and an amount, with no way to
/// open or share proof that you paid into the pot. In a savings circle that
/// proof is the thing members argue about, so it is exactly the record worth
/// being able to send to someone.
///
/// [viewerUserId] decides direction. Your own contribution left your wallet, so
/// it reads as outgoing; another member's payment is money that arrived in the
/// group, so from your side it is incoming to the circle rather than to you —
/// rendered as incoming because that is what it did to the pot you share.
UnifiedTransaction contributionPaymentToUnified(
  ContributionPayment payment, {
  required String contributionTitle,
  int? cycleIndex,
  String? viewerUserId,
}) {
  final viewerIsPayer = viewerUserId != null &&
      viewerUserId.isNotEmpty &&
      viewerUserId == payment.userId;
  final payer =
      payment.userName.trim().isNotEmpty ? payment.userName.trim() : null;

  // The reference is what support can look up and what a member can quote. The
  // row id is an internal handle and is only used when no reference exists, so
  // a receipt is never left untraceable — the same rule the account and
  // crowdfund receipts follow.
  final reference = (payment.transactionId ?? '').trim();

  return UnifiedTransaction(
    id: payment.id,
    serviceType: TransactionServiceType.groupFunds,
    title: viewerIsPayer
        ? 'Contribution to $contributionTitle'
        : (payer != null
            ? 'Contribution from $payer'
            : 'Contribution to $contributionTitle'),
    description: cycleIndex != null ? 'Cycle $cycleIndex' : contributionTitle,
    amount: payment.amount,
    currency: payment.currency,
    createdAt: payment.paymentDate,
    // A pending contribution must not render as a completed receipt: the whole
    // point of the document is to prove the money arrived.
    status: payment.status == PaymentStatus.completed
        ? UnifiedTransactionStatus.completed
        : UnifiedTransactionStatus.pending,
    flow: viewerIsPayer ? TransactionFlow.outgoing : TransactionFlow.incoming,
    transactionReference: reference.isNotEmpty ? reference : payment.id,
    counterpartyName: viewerIsPayer ? contributionTitle : payer,
    counterpartyAccount: null,
    metadata: {
      if (cycleIndex != null) 'cycle': '$cycleIndex',
      if (payer != null) 'sender_name': payer,
      'recipient_name': contributionTitle,
      // Notes are the member's own words about what the payment was for, and
      // they are frequently the only context distinguishing two identical
      // amounts in the same week.
      if ((payment.notes ?? '').trim().isNotEmpty)
        'note': payment.notes!.trim(),
    },
  );
}
