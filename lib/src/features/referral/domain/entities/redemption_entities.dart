/// What converting LazerPoints to cash would produce, and what it did.
///
/// Amounts are MINOR units (kobo), matching every other money value crossing a
/// service boundary. Converted once at the display edge, so no screen has to
/// remember which unit it is holding.
class RedemptionQuoteEntity {
  /// Points that would actually be spent. Can be fewer than the balance: any
  /// remainder that does not divide into a whole kobo stays behind rather than
  /// being rounded away.
  final int points;
  final int cashMinor;
  final String currency;
  final int pointsPerMajorUnit;
  final int minRedeemPoints;

  /// False is a NORMAL state for a new account, not a failure — [reason] says
  /// why, so the button can explain itself instead of sitting inert.
  final bool canRedeem;
  final String reason;

  const RedemptionQuoteEntity({
    required this.points,
    required this.cashMinor,
    required this.currency,
    required this.pointsPerMajorUnit,
    required this.minRedeemPoints,
    required this.canRedeem,
    required this.reason,
  });

  double get cashMajor => cashMinor / 100.0;
}

class RedemptionResultEntity {
  final int pointsRedeemed;
  final int cashMinor;
  final String currency;
  final int newBalance;
  final String reference;

  const RedemptionResultEntity({
    required this.pointsRedeemed,
    required this.cashMinor,
    required this.currency,
    required this.newBalance,
    required this.reference,
  });

  double get cashMajor => cashMinor / 100.0;
}
