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
    flow: viewerIsReceiver ? TransactionFlow.incoming : TransactionFlow.outgoing,
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
