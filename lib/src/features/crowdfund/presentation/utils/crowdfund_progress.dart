library;

import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';

/// WHAT A CAMPAIGN RAISED IS NOT WHAT IS LEFT IN ITS POT.
///
/// `currentAmount` is the live, withdrawable balance: the contribution saga
/// adds to it, a withdrawal subtracts from it, a refund subtracts from it.
/// The campaign card drew its progress bar straight from that, so the moment
/// a creator took their money out the card reported the campaign had raised
/// nothing.
///
/// Measured on prod 2026-10-19 — "Building":
///
///   contributions (completed)  500.00
///   withdrawals  (completed)   500.00
///   crowdfunds.current_amount    0.00   <- what the bar was drawing
///   status                   completed
///
/// and the card read "NGN 0 / 500 · 0.0%" under a green Completed badge: a
/// campaign that met its target in full, presented as one that raised
/// nothing.
///
/// ## Why this needs no new field
///
/// `completed` is not a label someone types. The deadline worker sets it
/// only when `CurrentAmount >= TargetAmount` at the deadline, and `expired`
/// otherwise — so the status itself is the evidence that the target was
/// reached. A completed campaign raised AT LEAST its target, whatever is
/// left in the pot now.
///
/// For every other status the floor is `currentAmount + totalRefunded`:
/// money refunded to donors was unarguably raised first. That is still a
/// FLOOR, not the exact figure — a partial withdrawal on a cancelled or
/// still-active campaign is invisible from here, because nothing on the wire
/// records what has been withdrawn.
///
/// Making it exact needs `total_withdrawn` on the campaign row and in the
/// proto. That is a schema plus public-contract change, so it is called out
/// rather than taken: until then this never OVERSTATES what was raised, and
/// it no longer understates a completed campaign to zero.
class CrowdfundProgress {
  const CrowdfundProgress({
    required this.raised,
    required this.target,
    required this.percent,
    required this.isFinished,
    required this.wasFullyFunded,
  });

  /// Lower bound on what this campaign took in, in major units.
  final double raised;
  final double target;

  /// 0–100+, matching [raised] against [target].
  final double percent;

  /// No longer taking money.
  final bool isFinished;

  /// Reached its target before it closed.
  final bool wasFullyFunded;

  /// Fraction for a progress indicator, clamped to the bar's range.
  double get fraction => target <= 0 ? 0 : (raised / target).clamp(0.0, 1.0);

  static CrowdfundProgress of(Crowdfund c) {
    final target = c.targetAmount;
    // Refunded money was raised before it went back.
    var raised = c.currentAmount + c.totalRefunded;

    final finished = c.status == CrowdfundStatus.completed ||
        c.status == CrowdfundStatus.cancelled ||
        c.status == CrowdfundStatus.expired;

    // COMPLETED IS EVIDENCE. The worker only awards it when the pot met the
    // target at the deadline, so the campaign raised at least that much
    // however much has since been withdrawn.
    final fullyFunded = c.status == CrowdfundStatus.completed;
    if (fullyFunded && target > 0 && raised < target) {
      raised = target;
    }

    final pct = target > 0 ? (raised / target) * 100 : 0.0;
    return CrowdfundProgress(
      raised: raised,
      target: target,
      // Trust a server percentage that is HIGHER than ours — it may have
      // seen an overfunded peak we cannot reconstruct — but never a lower
      // one, which is the bug being fixed.
      percent: pct > c.progressPercentage ? pct : c.progressPercentage,
      isFinished: finished,
      wasFullyFunded: fullyFunded,
    );
  }
}
