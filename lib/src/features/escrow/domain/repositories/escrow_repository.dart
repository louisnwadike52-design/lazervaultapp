import '../entities/escrow_deal_entity.dart';
import '../entities/escrow_offer_entity.dart';

/// Abstract repository for the Escrow feature. The data layer implements this
/// over gRPC to commerce-gateway (EscrowService).
abstract class EscrowRepository {
  /// Fee preview for a prospective deal (reads admin-configurable fee config).
  Future<EscrowFeeQuote> quoteFee({required double amount, String currency = 'NGN'});

  /// Create + fund a deal (buyer locks funds into the escrow pool). PIN-gated.
  Future<EscrowDealEntity> createDeal({
    required String buyerAccountId,
    required String sellerQuery,
    required String title,
    String description = '',
    required double amount,
    int deadlineDays = 0,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String buyerItemImageUrl = '',
  });

  /// List the caller's deals (role: "buyer" | "seller" | "" for all).
  Future<List<EscrowDealEntity>> listMyDeals({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 50,
  });

  /// Single deal detail (+ timeline events).
  Future<EscrowDealEntity> getDeal(String dealId);

  /// Seller marks the deal delivered.
  Future<EscrowDealEntity> markDelivered({
    required String dealId,
    String deliveryNote = '',
    String sellerProofImageUrl = '',
  });

  /// Buyer validates delivery → release funds to seller. PIN-gated.
  Future<EscrowDealEntity> validateRelease({
    required String dealId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  /// Cancel a not-yet-delivered deal → refund buyer.
  Future<EscrowDealEntity> cancelDeal({
    required String dealId,
    String reason = '',
    required String idempotencyKey,
  });

  /// Open a dispute (→ admin queue).
  Future<EscrowDealEntity> openDispute({
    required String dealId,
    required String reason,
    String evidenceUrl = '',
  });

  /// Attach a piece of media evidence (already uploaded to storage) to a deal.
  Future<void> addAttachment({
    required String dealId,
    required String purpose,
    required String mediaKind,
    required String url,
    String contentType = '',
    int sizeBytes = 0,
    int durationSeconds = 0,
  });

  /// Buyer asks for a refund after delivery.
  Future<EscrowDealEntity> requestRefund({
    required String dealId,
    required String reason,
  });

  /// Seller accepts or declines a pending refund request.
  Future<EscrowDealEntity> respondRefund({
    required String dealId,
    required bool accept,
    String note = '',
  });

  // ── Two-sided offers (money-free agreement phase before funding) ──

  /// Publish an offer (seller listing or buyer request). No PIN — no money.
  Future<EscrowOfferEntity> createOffer({
    required String direction,
    String counterpartyQuery = '',
    required String title,
    String description = '',
    required double amount,
    String currency = 'NGN',
    String feePayerPreference = '',
    int deliveryDeadlineDays = 0,
  });

  /// Read an offer as one of its parties.
  Future<EscrowOfferEntity> getOffer(String offerId);

  /// Resolve a share link (any signed-in user).
  Future<EscrowOfferEntity> getOfferByShareToken(String shareToken);

  /// List offers I created / that are addressed to me.
  Future<List<EscrowOfferEntity>> listMyOffers({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 50,
  });

  /// Addressed counterparty accepts (buy_request) or declines an OPEN offer.
  Future<EscrowOfferEntity> respondOffer({
    required String offerId,
    required bool accept,
    String note = '',
  });

  /// Fund an agreed offer — THE money movement. PIN-gated; returns the deal.
  Future<EscrowDealEntity> fundOffer({
    required String offerId,
    required String buyerAccountId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  /// Creator withdraws a not-yet-converted offer.
  Future<EscrowOfferEntity> cancelOffer(String offerId);

  /// Attach listing media (already uploaded to storage) to a live offer.
  Future<void> addOfferAttachment({
    required String offerId,
    required String mediaKind,
    required String url,
    String contentType = '',
    int sizeBytes = 0,
    int durationSeconds = 0,
  });
}
