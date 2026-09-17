/// A card sale taken on the merchant's phone.
///
/// Mirrors the wire shape rather than re-modelling it: these are billing
/// records read onto a screen, and a parallel entity layer with its own
/// vocabulary is one more place for "succeeded" and "settled" to drift apart.
class CardChargeEntity {
  const CardChargeEntity({
    required this.reference,
    required this.status,
    required this.amountMinor,
    required this.currency,
    this.provider = '',
    this.providerReference = '',
    this.feeMinor = 0,
    this.description = '',
    this.terminalId = '',
    this.staffUserId = '',
    this.cardLast4 = '',
    this.cardBrand = '',
    this.authCode = '',
    this.failureReason = '',
    this.settlementReference = '',
    this.authorisedAt,
    this.settledAt,
    this.createdAt,
  });

  /// Our id for the sale. Unique, and what a retry is matched against.
  final String reference;

  /// pending | succeeded | failed | refunded
  final String status;

  final int amountMinor;
  final String currency;
  final String provider;
  final String providerReference;

  /// The acquirer's cut, as the provider reported it.
  final int feeMinor;

  final String description;
  final String terminalId;
  final String staffUserId;

  /// The only card details that may travel — the ones printed on a paper
  /// receipt. None of them can reconstruct a payment.
  final String cardLast4;
  final String cardBrand;
  final String authCode;

  final String failureReason;

  /// Empty until the merchant has actually been paid. NOT the same as
  /// [isSucceeded], which only means the card was charged.
  final String settlementReference;

  final DateTime? authorisedAt;
  final DateTime? settledAt;
  final DateTime? createdAt;

  bool get isSucceeded => status == 'succeeded';
  bool get isFailed => status == 'failed';
  bool get isRefunded => status == 'refunded';
  bool get isPending => status == 'pending';

  /// A sale is only finished when it can no longer change. Polling stops here.
  bool get isTerminal => isSucceeded || isFailed || isRefunded;

  /// Charged but not yet paid out — the state a merchant asks about.
  bool get awaitingSettlement => isSucceeded && settlementReference.isEmpty;

  /// What the merchant actually receives, after the acquirer's cut.
  int get netMinor => amountMinor - feeMinor;

  String get maskedCard {
    if (cardLast4.isEmpty && cardBrand.isEmpty) return '';
    final brand = cardBrand.isEmpty ? 'Card' : cardBrand;
    return cardLast4.isEmpty ? brand : '$brand ••••$cardLast4';
  }
}

/// Whether card payments can be taken at all right now.
///
/// Asked BEFORE the merchant reaches the amount screen: finding out at the tap
/// means a customer is already standing there.
class CardAcceptanceStatusEntity {
  const CardAcceptanceStatusEntity({
    required this.available,
    this.activeProvider = '',
    this.usableProviders = const [],
    this.unavailableReason = '',
  });

  final bool available;
  final String activeProvider;
  final List<String> usableProviders;
  final String unavailableReason;
}
