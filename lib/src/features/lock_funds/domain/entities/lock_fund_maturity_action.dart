part of 'lock_fund_entity.dart';

/// What a PiggyVault plan does the moment its term ends.
///
/// The slugs are the exact strings accounts-service stores in
/// `lock_funds.maturity_action`; never localise them.
///
/// [undecided] is the ABSENCE of a choice and deliberately has no slug. When
/// the column is empty the server falls back to the plan's `auto_renew` flag,
/// which may renew the plan rather than pay it out — so rendering empty as
/// [payout] would promise the user money the server has not agreed to send.
/// Every surface must show it as "not decided".
enum MaturityAction {
  undecided,
  payout,
  reinvestAll,
  reinvestPrincipal,
  reinvestInterest;

  /// Resolve from the backend slug. Anything unrecognised — including an
  /// action added server-side after this build shipped — reads as
  /// [undecided] rather than guessing, because the alternative is telling
  /// somebody their capital is being returned when it is being rolled over.
  static MaturityAction fromWire(String? raw) {
    switch ((raw ?? '').trim().toLowerCase()) {
      case 'payout':
        return MaturityAction.payout;
      case 'reinvest_all':
        return MaturityAction.reinvestAll;
      case 'reinvest_principal':
        return MaturityAction.reinvestPrincipal;
      case 'reinvest_interest':
        return MaturityAction.reinvestInterest;
      default:
        return MaturityAction.undecided;
    }
  }

  /// The slug to send. Empty for [undecided], which is how the RPC CLEARS a
  /// previous choice — the only way to hand a plan back to `auto_renew`
  /// without closing it.
  String get wireValue {
    switch (this) {
      case MaturityAction.undecided:
        return '';
      case MaturityAction.payout:
        return 'payout';
      case MaturityAction.reinvestAll:
        return 'reinvest_all';
      case MaturityAction.reinvestPrincipal:
        return 'reinvest_principal';
      case MaturityAction.reinvestInterest:
        return 'reinvest_interest';
    }
  }

  /// Sentence case throughout — PiggyVault copy is never title-cased.
  String get displayName {
    switch (this) {
      case MaturityAction.undecided:
        return 'Not decided';
      case MaturityAction.payout:
        return 'Pay out everything';
      case MaturityAction.reinvestAll:
        return 'Reinvest everything';
      case MaturityAction.reinvestPrincipal:
        return 'Reinvest capital only';
      case MaturityAction.reinvestInterest:
        return 'Reinvest returns only';
    }
  }

  String get description {
    switch (this) {
      case MaturityAction.undecided:
        return 'We will follow your auto-renew setting when the term ends.';
      case MaturityAction.payout:
        return 'Your capital and returns go back to your wallet.';
      case MaturityAction.reinvestAll:
        return 'Capital and returns start a fresh plan on the same terms.';
      case MaturityAction.reinvestPrincipal:
        return 'Your capital starts a fresh plan; the returns are paid out.';
      case MaturityAction.reinvestInterest:
        return 'Your returns start a fresh plan; the capital is paid out.';
    }
  }

  /// Whether any money is rolled into a new plan. Drives the "a new plan will
  /// be created" warning — [undecided] is excluded because the outcome is the
  /// `auto_renew` flag's to decide, not this field's.
  bool get isReinvestment =>
      this == MaturityAction.reinvestAll ||
      this == MaturityAction.reinvestPrincipal ||
      this == MaturityAction.reinvestInterest;

  /// The options offered in the picker, in the order they are shown. Excludes
  /// [undecided]: a user cannot *choose* indecision, they can only clear a
  /// choice, which the picker offers separately.
  static const List<MaturityAction> choices = <MaturityAction>[
    MaturityAction.payout,
    MaturityAction.reinvestAll,
    MaturityAction.reinvestPrincipal,
    MaturityAction.reinvestInterest,
  ];
}
