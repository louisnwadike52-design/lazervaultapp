// Domain entities for the Escrow feature. Mapped from the generated proto
// in the repository layer so the UI never touches protobuf types.

class EscrowDealEntity {
  final String id;
  final String reference;
  final String buyerUserId;
  final String buyerAccountId;
  final String buyerName;
  final String sellerUserId;
  final String sellerAccountId;
  final String sellerName;
  final String title;
  final String description;
  final String currency;
  final double amount;
  final double fee;
  final String feePayer;
  final double buyerTotal;
  final double sellerNet;
  final String status;
  final int fraudScore;
  final bool requiresAdminReview;
  final String deliveryNote;
  // Buyer's product/service image + seller's proof-of-delivery image
  // (storage-service public URLs). Empty when not uploaded.
  final String buyerItemImageUrl;
  final String sellerProofImageUrl;
  final DateTime? deadlineAt;
  final DateTime? fundedAt;
  final DateTime? deliveredAt;
  final DateTime? releasedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<EscrowDealEventEntity> events;
  // Rich media evidence attached across the deal's life (buyer's item photos,
  // delivery proof, dispute evidence, refund evidence). Empty on older deals.
  final List<EscrowAttachmentEntity> attachments;
  // Present only when the buyer has asked for a refund after delivery.
  final EscrowRefundRequestEntity? refundRequest;

  const EscrowDealEntity({
    required this.id,
    required this.reference,
    required this.buyerUserId,
    required this.buyerAccountId,
    required this.buyerName,
    required this.sellerUserId,
    required this.sellerAccountId,
    required this.sellerName,
    required this.title,
    required this.description,
    required this.currency,
    required this.amount,
    required this.fee,
    required this.feePayer,
    required this.buyerTotal,
    required this.sellerNet,
    required this.status,
    required this.fraudScore,
    required this.requiresAdminReview,
    required this.deliveryNote,
    this.buyerItemImageUrl = '',
    this.sellerProofImageUrl = '',
    this.deadlineAt,
    this.fundedAt,
    this.deliveredAt,
    this.releasedAt,
    this.createdAt,
    this.updatedAt,
    this.events = const [],
    this.attachments = const [],
    this.refundRequest,
  });

  /// True if [userId] is the buyer in this deal.
  bool isBuyer(String userId) => buyerUserId == userId;

  /// True if [userId] is the seller in this deal.
  bool isSeller(String userId) => sellerUserId == userId;

  bool get isFunded => status == 'FUNDED' || status == 'IN_PROGRESS';
  bool get isDelivered => status == 'DELIVERED';
  bool get isReleased => status == 'RELEASED' || status == 'RESOLVED_RELEASED';
  bool get isRefunded =>
      status == 'CANCELLED' || status == 'REFUNDED' || status == 'RESOLVED_REFUNDED';
  bool get isRefundRequested => status == 'REFUND_REQUESTED';
  bool get isDisputed => status == 'DISPUTED';
  bool get isActive => isFunded || isDelivered || isDisputed || isRefundRequested;

  /// Seller can mark delivered while funded/in-progress.
  bool canMarkDelivered(String userId) => isSeller(userId) && isFunded;

  /// Buyer can release while funded/delivered and not under review.
  bool canRelease(String userId) =>
      isBuyer(userId) && (isFunded || isDelivered) && !requiresAdminReview;

  /// Either party can cancel (refund) only BEFORE delivery. Once delivered the
  /// buyer must release or dispute — mirrors the server rule so the UI doesn't
  /// offer a cancel the backend will reject.
  bool canCancel(String userId) =>
      (isBuyer(userId) || isSeller(userId)) && isFunded;

  /// Either party can open a dispute while the deal is live.
  bool canDispute(String userId) =>
      (isBuyer(userId) || isSeller(userId)) && (isFunded || isDelivered);

  /// The buyer can ask for a refund once the seller has marked delivery (before
  /// releasing). Mirrors the server rule so we only show it when it will stick.
  bool canRequestRefund(String userId) => isBuyer(userId) && isDelivered;

  /// The seller responds to a pending refund request.
  bool canRespondRefund(String userId) => isSeller(userId) && isRefundRequested;

  String get _sellerLabel => sellerName.trim().isEmpty ? 'the seller' : sellerName;
  String get _buyerLabel => buyerName.trim().isEmpty ? 'the buyer' : buyerName;

  /// Role- and state-aware progress line, e.g. "Funds held. Waiting for Jane to
  /// deliver." `yourTurn` is true when [userId] is the party the deal is waiting
  /// on, so the UI can emphasise it. Returns ('', false) when there's nothing
  /// useful to add beyond the status chip.
  ({String text, bool yourTurn}) waitingSubtitle(String userId) {
    final buyer = isBuyer(userId);
    final seller = isSeller(userId);
    if (!buyer && !seller) return (text: '', yourTurn: false);

    if (requiresAdminReview && (isFunded || isDelivered)) {
      return (
        text: 'Funds held. Under review for your protection. Release is paused for now.',
        yourTurn: false,
      );
    }

    switch (status) {
      case 'FUNDED':
      case 'IN_PROGRESS':
        return buyer
            ? (text: 'Funds held. Waiting for $_sellerLabel to deliver.', yourTurn: false)
            : (text: 'Funds held. Deliver, then $_buyerLabel releases your payment.', yourTurn: true);
      case 'DELIVERED':
        return buyer
            ? (text: '$_sellerLabel marked delivered. Review and release when satisfied.', yourTurn: true)
            : (text: 'Delivered. Waiting for $_buyerLabel to confirm & release.', yourTurn: false);
      case 'REFUND_REQUESTED':
        return buyer
            ? (text: 'You asked for a refund. Waiting for $_sellerLabel to respond.', yourTurn: false)
            : (text: '$_buyerLabel asked for a refund. Please accept it or decline.', yourTurn: true);
      case 'DISPUTED':
        return (text: 'Disputed. Our team is reviewing it.', yourTurn: false);
      case 'RELEASED':
      case 'RESOLVED_RELEASED':
        return buyer
            ? (text: 'Completed. You released the funds to $_sellerLabel.', yourTurn: false)
            : (text: 'Completed. Funds were released to you.', yourTurn: false);
      case 'CANCELLED':
      case 'REFUNDED':
      case 'RESOLVED_REFUNDED':
        return buyer
            ? (text: 'Cancelled. You were refunded.', yourTurn: false)
            : (text: 'Cancelled. No funds changed hands.', yourTurn: false);
      case 'EXPIRED':
        return (text: 'Expired. The held funds were returned to $_buyerLabel.', yourTurn: false);
      default:
        return (text: '', yourTurn: false);
    }
  }
}

class EscrowDealEventEntity {
  final String id;
  final String dealId;
  final String eventType;
  final String actor;
  final String detail;
  final DateTime? createdAt;

  const EscrowDealEventEntity({
    required this.id,
    required this.dealId,
    required this.eventType,
    required this.actor,
    required this.detail,
    this.createdAt,
  });
}

/// A single piece of media evidence on a deal. `purpose` is one of
/// `deal_item` | `delivery_proof` | `dispute_evidence` | `refund_evidence`;
/// `mediaKind` is `image` | `video`.
class EscrowAttachmentEntity {
  final String id;
  final String purpose;
  final String mediaKind;
  final String url;
  final String contentType;
  final int sizeBytes;
  final int durationSeconds;
  final String uploadedBy;
  final String actorRole;
  final DateTime? createdAt;

  const EscrowAttachmentEntity({
    required this.id,
    required this.purpose,
    required this.mediaKind,
    required this.url,
    this.contentType = '',
    this.sizeBytes = 0,
    this.durationSeconds = 0,
    this.uploadedBy = '',
    this.actorRole = '',
    this.createdAt,
  });

  bool get isVideo => mediaKind == 'video';
  bool get isImage => !isVideo;
}

/// The buyer's post-delivery refund request and the seller's response.
class EscrowRefundRequestEntity {
  final String id;
  final String dealId;
  final String requestedBy;
  final String reason;
  final String status;
  final DateTime? responseDeadlineAt;
  final String respondedBy;
  final String responseNote;
  final DateTime? respondedAt;
  final DateTime? createdAt;
  final List<EscrowAttachmentEntity> attachments;

  const EscrowRefundRequestEntity({
    required this.id,
    required this.dealId,
    required this.requestedBy,
    required this.reason,
    this.status = '',
    this.responseDeadlineAt,
    this.respondedBy = '',
    this.responseNote = '',
    this.respondedAt,
    this.createdAt,
    this.attachments = const [],
  });
}

/// Fee preview returned by QuoteFee.
class EscrowFeeQuote {
  final double amount;
  final double fee;
  final String feePayer;
  final double buyerTotal;
  final double sellerNet;

  const EscrowFeeQuote({
    required this.amount,
    required this.fee,
    required this.feePayer,
    required this.buyerTotal,
    required this.sellerNet,
  });
}
