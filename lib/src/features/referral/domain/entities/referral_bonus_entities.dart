import 'package:equatable/equatable.dart';

/// A referral bonus ACCRUES and is then withdrawn.
///
/// It used to be transferred into the referrer's wallet the instant a referral
/// completed, which left nothing to claim and nothing to show. It now
/// accumulates server-side and the user moves it into their personal wallet on
/// demand.
///
/// Every amount is in MINOR units — kobo for NGN — matching the backend's
/// ledger. Treating one of these as naira is a 100x error on the one number the
/// user acts on, so the conversion happens once, in [majorOf].
class ReferralBonusBalanceEntity extends Equatable {
  /// Accrued, not withdrawn, and not committed to a withdrawal in flight.
  /// This is what the user can take right now.
  final int availableMinor;
  final int lifetimeAccruedMinor;
  final int lifetimeWithdrawnMinor;

  /// Committed to a withdrawal that has not settled. Shown so a user whose
  /// transfer is retrying can see where the money went instead of a silent gap.
  final int pendingWithdrawalMinor;

  final String currency;

  /// False once the operator discontinues the programme. An accrued balance
  /// stays withdrawable — it was earned under the programme and is the user's.
  final bool programmeActive;

  /// Below this, withdrawal is refused. 0 means no minimum.
  final int minimumWithdrawalMinor;

  /// The operator's own words for a discontinued programme. Empty means use a
  /// neutral default rather than inventing copy.
  final String programmeNotice;

  const ReferralBonusBalanceEntity({
    required this.availableMinor,
    required this.lifetimeAccruedMinor,
    required this.lifetimeWithdrawnMinor,
    required this.pendingWithdrawalMinor,
    required this.currency,
    required this.programmeActive,
    required this.minimumWithdrawalMinor,
    required this.programmeNotice,
  });

  static const empty = ReferralBonusBalanceEntity(
    availableMinor: 0,
    lifetimeAccruedMinor: 0,
    lifetimeWithdrawnMinor: 0,
    pendingWithdrawalMinor: 0,
    currency: 'NGN',
    programmeActive: true,
    minimumWithdrawalMinor: 0,
    programmeNotice: '',
  );

  static double majorOf(int minor) => minor / 100;

  bool get hasAnything => lifetimeAccruedMinor > 0 || availableMinor > 0;

  /// Whether a withdrawal is possible at all right now. The server re-checks
  /// every one of these; this only decides whether to offer the button.
  bool get canWithdraw =>
      availableMinor > 0 && availableMinor >= minimumWithdrawalMinor;

  /// Why the button is unavailable, in words the user can act on. Null when it
  /// is available.
  String? get blockedReason {
    if (availableMinor <= 0) {
      return pendingWithdrawalMinor > 0
          ? 'Your withdrawal is being processed'
          : null;
    }
    if (availableMinor < minimumWithdrawalMinor) {
      return 'Minimum withdrawal is '
          '${majorOf(minimumWithdrawalMinor).toStringAsFixed(0)}';
    }
    return null;
  }

  @override
  List<Object?> get props => [
        availableMinor,
        lifetimeAccruedMinor,
        lifetimeWithdrawnMinor,
        pendingWithdrawalMinor,
        currency,
        programmeActive,
        minimumWithdrawalMinor,
        programmeNotice,
      ];
}

/// The outcome of a settled withdrawal.
class ReferralBonusWithdrawalEntity extends Equatable {
  final String withdrawalId;
  final int amountMinor;
  final String currency;

  /// What is left afterwards, so the screen can redraw without re-fetching.
  final int remainingMinor;

  /// Where it landed, in the server's words — always the personal wallet.
  final String destination;

  const ReferralBonusWithdrawalEntity({
    required this.withdrawalId,
    required this.amountMinor,
    required this.currency,
    required this.remainingMinor,
    required this.destination,
  });

  @override
  List<Object?> get props =>
      [withdrawalId, amountMinor, currency, remainingMinor, destination];
}
