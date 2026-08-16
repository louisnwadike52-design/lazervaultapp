import '../entities/escrow_deal_entity.dart';

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
}
