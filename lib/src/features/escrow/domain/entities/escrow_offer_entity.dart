import 'escrow_deal_entity.dart';

/// A money-free escrow OFFER awaiting mutual agreement — the phase before a
/// funded deal. A seller lists what they're selling (`sell_offer`, optionally
/// open + shared by link) or a buyer requests to buy from a named seller
/// (`buy_request`). Money only moves when the offer is FUNDED, which converts
/// it into a regular [EscrowDealEntity].
class EscrowOfferEntity {
  final String id;
  final String reference; // ESCROFR-…
  final String direction; // sell_offer | buy_request
  final String creatorUserId;
  final String creatorName;
  final String counterpartyUserId; // empty for open link-only sell offers
  final String counterpartyName;
  final String title;
  final String description;

  /// Item condition grade (Back-Market-style):
  /// brand_new|excellent|good|fair, or '' when unspecified (legacy offers and
  /// buy requests where the buyer accepts any condition).
  final String condition;
  final double amount;
  final String currency;
  final String feePayerMode;
  final int deliveryDeadlineDays;
  final String status; // OPEN|AWAITING_FUNDING|CONVERTED|DECLINED|CANCELLED|EXPIRED
  final String declineReason;
  final DateTime? expiresAt;
  final DateTime? fundingDeadlineAt;
  final String dealId; // set once CONVERTED
  final DateTime? acceptedAt;
  final DateTime? createdAt;
  final List<EscrowAttachmentEntity> attachments;
  final bool viewerIsCreator;

  /// Returned ONLY on create / creator reads — the capability for the share
  /// link. Never rendered directly; used to build the share URL.
  final String shareToken;

  const EscrowOfferEntity({
    required this.id,
    required this.reference,
    required this.direction,
    required this.creatorUserId,
    this.creatorName = '',
    this.counterpartyUserId = '',
    this.counterpartyName = '',
    required this.title,
    this.description = '',
    this.condition = '',
    required this.amount,
    this.currency = 'NGN',
    this.feePayerMode = '',
    this.deliveryDeadlineDays = 0,
    required this.status,
    this.declineReason = '',
    this.expiresAt,
    this.fundingDeadlineAt,
    this.dealId = '',
    this.acceptedAt,
    this.createdAt,
    this.attachments = const [],
    this.viewerIsCreator = false,
    this.shareToken = '',
  });

  bool get isSellOffer => direction == 'sell_offer';
  bool get isBuyRequest => direction == 'buy_request';

  bool get isOpen => status == 'OPEN';
  bool get isAwaitingFunding => status == 'AWAITING_FUNDING';
  bool get isConverted => status == 'CONVERTED';
  bool get isDeclined => status == 'DECLINED';
  bool get isCancelled => status == 'CANCELLED';
  bool get isExpired => status == 'EXPIRED';
  bool get isTerminal => isConverted || isDeclined || isCancelled || isExpired;
  bool get isAddressed => counterpartyUserId.isNotEmpty;

  /// Whether [userId] may FUND this offer right now (becomes/acts as buyer).
  bool canFund(String userId) {
    if (isSellOffer && isOpen) {
      if (userId == creatorUserId) return false; // can't buy your own listing
      return !isAddressed || counterpartyUserId == userId;
    }
    if (isBuyRequest && (isOpen || isAwaitingFunding)) {
      // A buyer-created escrow funds at creation (money held now); no seller-
      // accept gate, so an OPEN request is directly fundable by its creator.
      // AWAITING_FUNDING stays fundable for legacy accept-then-fund offers.
      return userId == creatorUserId;
    }
    return false;
  }

  /// Whether [userId] may accept/decline. The buyer-created escrow now funds
  /// at creation with no seller-accept stage, so this is always false — the
  /// seller acts on the resulting DEAL (deliver / release), never the offer.
  bool canRespond(String userId) => false;

  /// Whether [userId] may DECLINE this offer — the addressed counterparty of a
  /// still-OPEN offer. A sell_offer's targeted buyer declines a listing; a
  /// still-unfunded buy_request's seller declines the request.
  bool canDecline(String userId) =>
      isOpen && isAddressed && counterpartyUserId == userId;

  /// True when [userId] is neither the creator nor the addressed counterparty
  /// of an ADDRESSED offer — e.g. someone who opened a share link meant for a
  /// specific person. They may view but not act.
  bool isForeignViewer(String userId) =>
      isAddressed &&
      userId.isNotEmpty &&
      userId != creatorUserId &&
      userId != counterpartyUserId;

  /// Whether [userId] may withdraw the offer.
  bool canCancel(String userId) =>
      (isOpen || isAwaitingFunding) && userId == creatorUserId;

  /// Human label for the SELLER of this offer, whichever side created it.
  String get sellerName => isSellOffer ? creatorName : counterpartyName;

  /// Human label for the party [userId] sees as "the other side".
  String otherPartyName(String userId) =>
      userId == creatorUserId ? counterpartyName : creatorName;

  EscrowOfferEntity copyWith({String? shareToken}) => EscrowOfferEntity(
        id: id,
        reference: reference,
        direction: direction,
        creatorUserId: creatorUserId,
        creatorName: creatorName,
        counterpartyUserId: counterpartyUserId,
        counterpartyName: counterpartyName,
        title: title,
        description: description,
        condition: condition,
        amount: amount,
        currency: currency,
        feePayerMode: feePayerMode,
        deliveryDeadlineDays: deliveryDeadlineDays,
        status: status,
        declineReason: declineReason,
        expiresAt: expiresAt,
        fundingDeadlineAt: fundingDeadlineAt,
        dealId: dealId,
        acceptedAt: acceptedAt,
        createdAt: createdAt,
        attachments: attachments,
        viewerIsCreator: viewerIsCreator,
        shareToken: shareToken ?? this.shareToken,
      );
}
