import '../entities/escrow_deal_entity.dart';
import '../entities/escrow_offer_entity.dart';
import '../entities/escrow_message_entity.dart';

/// Abstract repository for the Escrow feature. The data layer implements this
/// over gRPC to commerce-gateway (EscrowService).
abstract class EscrowRepository {
  /// The deal's OWN conversation, oldest first.
  ///
  /// Separate from the parties' general direct-message thread so a dispute
  /// has "the chat for this deal" and an admin adjudicating it reads that
  /// and nothing else.
  /// One page of this user's deals, WITH the server's total.
  ///
  /// Separate from listMyDeals because that one discards `total`, and
  /// without a total the app cannot say how many pages there are, which is
  /// the whole point of numbered pagination.
  Future<EscrowDealsPage> listMyDealsPaged({
    String role,
    String status,
    int page,
    int limit,
  });

  /// The rules the app must obey and show, from admin settings.
  ///
  /// Never throws: callers get the built-in defaults when the server cannot
  /// answer, because a policy read must not be the thing that stops someone
  /// creating a deal.
  Future<EscrowPolicy> getPolicy();

  Future<List<EscrowMessageEntity>> listDealMessages(String dealId);

  Future<EscrowMessageEntity> sendDealMessage({
    required String dealId,
    required String body,
  });

  /// Fee preview for a prospective deal (reads admin-configurable fee config).
  /// [offerId], when given, prices the quote with THAT OFFER'S agreed fee
  /// split instead of the global default — so a listing whose seller absorbed
  /// the fee quotes the buyer what they will actually be charged.
  Future<EscrowFeeQuote> quoteFee(
      {required double amount, String currency = 'NGN', String offerId = ''});

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
    String condition = '',
  });

  /// Read an offer as one of its parties.
  Future<EscrowOfferEntity> getOffer(String offerId);

  /// Resolve a share link (any signed-in user).
  Future<EscrowOfferEntity> getOfferByShareToken(String shareToken);

  /// List offers I created / that are addressed to me.
  ///
  /// Kept for callers that want a plain list. The offers SCREEN uses
  /// [listMyOffersPaged] — see there for why the total matters.
  Future<List<EscrowOfferEntity>> listMyOffers({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 50,
  });

  /// One page of offers, WITH the server's total.
  ///
  /// Separate from [listMyOffers] for the same reason [listMyDealsPaged] is
  /// separate from the plain deals list: that one discards `total`, and
  /// without a total the app cannot say how many pages there are — which is
  /// the whole point of numbered pagination. The RPC has always returned it;
  /// the repository was throwing it away.
  Future<EscrowOffersPage> listMyOffersPaged({
    String role,
    String status,
    int page,
    int limit,
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

/// Admin-set limits and copy. Zero/empty means "not configured", and the
/// app keeps its own default, which is what lets this ship before anything
/// is set in the dashboard.
class EscrowPolicy {
  final int titleMaxChars;
  final int specsMaxChars;
  final int messageMaxChars;
  final String termsMarkdown;

  const EscrowPolicy({
    this.titleMaxChars = 0,
    this.specsMaxChars = 0,
    this.messageMaxChars = 0,
    this.termsMarkdown = '',
  });

  /// Built-in fallbacks, matching the service's own defaults. Kept in step
  /// deliberately: two different numbers would mean the app stops a user at
  /// one length and the server at another.
  static const fallback = EscrowPolicy(
    titleMaxChars: 120,
    specsMaxChars: 1000,
    messageMaxChars: 4000,
  );

  int get title => titleMaxChars > 0 ? titleMaxChars : fallback.titleMaxChars;
  int get specs => specsMaxChars > 0 ? specsMaxChars : fallback.specsMaxChars;
  int get message =>
      messageMaxChars > 0 ? messageMaxChars : fallback.messageMaxChars;
}

/// One page of deals plus the server's total, so the UI can render real
/// page numbers rather than guessing from whether a page came back full.
class EscrowDealsPage {
  final List<EscrowDealEntity> items;
  final int total;
  final int page;
  final int limit;

  const EscrowDealsPage({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });

  static const empty = EscrowDealsPage(items: [], total: 0, page: 1, limit: 20);

  /// At least 1, so an empty list is "page 1 of 1" rather than "of 0",
  /// which reads as a broken counter.
  int get totalPages => total <= 0 ? 1 : ((total + limit - 1) ~/ limit);
}

/// One page of offers plus the server's total. Mirrors [EscrowDealsPage] —
/// the two lists page identically, so they share a shape rather than each
/// inventing one.
class EscrowOffersPage {
  final List<EscrowOfferEntity> items;
  final int total;
  final int page;
  final int limit;

  const EscrowOffersPage({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });

  static const empty = EscrowOffersPage(items: [], total: 0, page: 1, limit: 5);

  /// At least 1, for the same reason as above.
  int get totalPages => total <= 0 ? 1 : ((total + limit - 1) ~/ limit);
}
