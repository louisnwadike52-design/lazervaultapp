library;

import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

/// What the interest chip on a PiggyVault plan should say.
///
/// The chip read "still accruing" on plans that had finished. Its caption was
/// chosen from `hasPaidOutInterest` alone, so the moment any ROI was withdrawn
/// it claimed the plan was still earning — including on a plan that had been
/// fully withdrawn or cancelled, where nothing is accruing at all.
///
/// The amount was wrong in the same breath. `accruedInterest` is only the
/// UNPAID interest still riding on the plan, which on a withdrawn plan is
/// zero, so a finished plan showed "+₦0 still accruing" to somebody who had
/// just banked real interest from it. Two false statements about their money
/// in one chip.
///
/// The rule: a plan whose term is RUNNING reports what is still riding on it,
/// because that is the part that will keep growing. A plan whose term has
/// stopped reports LIFETIME interest, because that is a final figure and the
/// only honest answer to "what did this plan earn me?".
///
/// `LockStatus.isEarning` is the right question and already exists — note it
/// excludes `matured`, which has stopped earning even though the money is
/// still in the plan, and `pendingApproval`, which has not started.
class LockInterestChip {
  const LockInterestChip({
    required this.amount,
    required this.caption,
    required this.statLabel,
  });

  /// Pre-formatted, currency-aware amount for the chip.
  final String amount;

  /// The words under/beside it.
  final String caption;

  /// Short form for a dense stat tile, where there is no room for a sentence
  /// but the same distinction still has to hold: a finished plan's figure is
  /// a lifetime total, a running plan's is what is still riding on it.
  final String statLabel;

  static LockInterestChip of(LockFund lock) {
    if (lock.status.awaitingDecision) {
      // Reserved but not started: it earns nothing yet, and saying "earned"
      // of a plan still awaiting a human invites the user to expect ROI.
      return LockInterestChip(
        amount: lock.formattedInterest,
        caption: 'not earning yet',
        statLabel: 'Interest',
      );
    }

    if (!lock.status.isEarning) {
      // Terminal or matured: the term has stopped, so this is the whole
      // story and it is not going to change.
      return LockInterestChip(
        amount: lock.formattedLifetimeInterest,
        caption: 'total interest earned',
        statLabel: 'Total Interest',
      );
    }

    // Running. Some ROI may already have been banked, in which case the chip
    // is only the remainder — which has to be said, or a user who just
    // withdrew interest reads the smaller number as the plan losing it.
    return LockInterestChip(
      amount: lock.formattedInterest,
      caption: lock.hasPaidOutInterest ? 'still accruing' : 'interest earned',
      statLabel: 'Interest Earned',
    );
  }
}
