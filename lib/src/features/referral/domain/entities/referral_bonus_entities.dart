import 'package:equatable/equatable.dart';

/// Somebody's referral EARNINGS.
///
/// A bonus is earned when the person they referred passes KYC, and deposited
/// into their personal wallet automatically within about a minute. There is no
/// claim step and nothing for the user to press — this screen reports what
/// happened rather than offering an action.
///
/// Every amount is in MINOR units — kobo for NGN — matching the backend's
/// ledger. Treating one of these as naira is a 100x error on the one number the
/// user acts on, so the conversion happens once, in [majorOf].
class ReferralBonusBalanceEntity extends Equatable {
  /// Always 0 from the server: nothing is claimable. Kept because the field
  /// is still on the wire.
  final int availableMinor;

  /// Everything ever earned. The headline number.
  final int lifetimeAccruedMinor;

  /// Everything that has reached the personal wallet.
  final int lifetimeWithdrawnMinor;

  /// Earned but not yet deposited — normally under a minute, longer if there
  /// is no personal wallet in this currency yet. Shown so the gap between "my
  /// friend verified" and "money arrived" is never silent.
  final int pendingWithdrawalMinor;

  final String currency;

  /// False once the operator discontinues the programme. Bonuses already
  /// earned are still paid — they were earned under the programme and ending
  /// it does not cancel the obligation.
  final bool programmeActive;

  /// Unused now that bonuses are automatic; there is no amount to choose.
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

  bool get hasAnything => lifetimeAccruedMinor > 0;

  /// Earned, deposit still owed. True for the short window between the
  /// referee's KYC and the deposit worker's next pass — or indefinitely if the
  /// user has no personal wallet in this currency, which is the one case worth
  /// telling them about.
  bool get awaitingDeposit => pendingWithdrawalMinor > 0;

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
