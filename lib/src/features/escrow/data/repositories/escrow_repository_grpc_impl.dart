import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/escrow.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as ts;
import '../../domain/entities/escrow_deal_entity.dart';
import '../../domain/entities/escrow_offer_entity.dart';
import '../../domain/repositories/escrow_repository.dart';

class EscrowRepositoryGrpcImpl implements EscrowRepository {
  final GrpcClient grpcClient;

  EscrowRepositoryGrpcImpl({required this.grpcClient});

  @override
  Future<EscrowFeeQuote> quoteFee({required double amount, String currency = 'NGN'}) async {
    return retryWithBackoff(operation: () async {
      final req = pb.QuoteFeeRequest()
        ..amount = amount
        ..currency = currency;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.quoteFee(req, options: options);
      return EscrowFeeQuote(
        amount: resp.amount,
        fee: resp.fee,
        feePayer: resp.feePayer,
        buyerTotal: resp.buyerTotal,
        sellerNet: resp.sellerNet,
      );
    });
  }

  @override
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
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.CreateDealRequest()
        ..buyerAccountId = buyerAccountId
        ..sellerQuery = sellerQuery
        ..title = title
        ..description = description
        ..amount = amount
        ..deadlineDays = deadlineDays
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey
        ..buyerItemImageUrl = buyerItemImageUrl;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.createDeal(req, options: options);
      return _dealFromProto(resp.deal);
    });
  }

  @override
  Future<List<EscrowDealEntity>> listMyDeals({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 50,
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.ListMyDealsRequest()
        ..role = role
        ..status = status
        ..page = page
        ..limit = limit;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.listMyDeals(req, options: options);
      return resp.deals.map(_dealFromProto).toList();
    });
  }

  @override
  Future<EscrowDealEntity> getDeal(String dealId) async {
    return retryWithBackoff(operation: () async {
      final req = pb.GetDealRequest()..dealId = dealId;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.getDeal(req, options: options);
      return _dealFromProto(resp.deal);
    });
  }

  @override
  Future<EscrowDealEntity> markDelivered({
    required String dealId,
    String deliveryNote = '',
    String sellerProofImageUrl = '',
  }) async {
    final req = pb.MarkDeliveredRequest()
      ..dealId = dealId
      ..deliveryNote = deliveryNote
      ..sellerProofImageUrl = sellerProofImageUrl;
    final options = await grpcClient.callOptions;
    final resp = await grpcClient.escrowClient.markDelivered(req, options: options);
    return _dealFromProto(resp.deal);
  }

  @override
  Future<EscrowDealEntity> validateRelease({
    required String dealId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    final req = pb.ValidateReleaseRequest()
      ..dealId = dealId
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey;
    final options = await grpcClient.callOptions;
    final resp = await grpcClient.escrowClient.validateRelease(req, options: options);
    return _dealFromProto(resp.deal);
  }

  @override
  Future<EscrowDealEntity> cancelDeal({
    required String dealId,
    String reason = '',
    required String idempotencyKey,
  }) async {
    final req = pb.CancelDealRequest()
      ..dealId = dealId
      ..reason = reason
      ..idempotencyKey = idempotencyKey;
    final options = await grpcClient.callOptions;
    final resp = await grpcClient.escrowClient.cancelDeal(req, options: options);
    return _dealFromProto(resp.deal);
  }

  @override
  Future<EscrowDealEntity> openDispute({
    required String dealId,
    required String reason,
    String evidenceUrl = '',
  }) async {
    final req = pb.OpenDisputeRequest()
      ..dealId = dealId
      ..reason = reason
      ..evidenceUrl = evidenceUrl;
    final options = await grpcClient.callOptions;
    final resp = await grpcClient.escrowClient.openDispute(req, options: options);
    return _dealFromProto(resp.deal);
  }

  @override
  Future<void> addAttachment({
    required String dealId,
    required String purpose,
    required String mediaKind,
    required String url,
    String contentType = '',
    int sizeBytes = 0,
    int durationSeconds = 0,
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.AddAttachmentRequest()
        ..dealId = dealId
        ..purpose = purpose
        ..mediaKind = mediaKind
        ..url = url
        ..contentType = contentType
        ..sizeBytes = Int64(sizeBytes)
        ..durationSeconds = durationSeconds;
      final options = await grpcClient.callOptions;
      await grpcClient.escrowClient.addAttachment(req, options: options);
    });
  }

  @override
  Future<EscrowDealEntity> requestRefund({
    required String dealId,
    required String reason,
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.RequestRefundRequest()
        ..dealId = dealId
        ..reason = reason;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.requestRefund(req, options: options);
      return _dealFromProto(resp.deal);
    });
  }

  @override
  Future<EscrowDealEntity> respondRefund({
    required String dealId,
    required bool accept,
    String note = '',
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.RespondRefundRequest()
        ..dealId = dealId
        ..accept = accept
        ..note = note;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.respondRefund(req, options: options);
      return _dealFromProto(resp.deal);
    });
  }

  // ── Two-sided offers (money-free agreement phase) ──

  @override
  Future<EscrowOfferEntity> createOffer({
    required String direction,
    String counterpartyQuery = '',
    required String title,
    String description = '',
    required double amount,
    String currency = 'NGN',
    String feePayerPreference = '',
    int deliveryDeadlineDays = 0,
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.CreateOfferRequest()
        ..direction = direction
        ..counterpartyQuery = counterpartyQuery
        ..title = title
        ..description = description
        ..amount = amount
        ..currency = currency
        ..feePayerPreference = feePayerPreference
        ..deliveryDeadlineDays = deliveryDeadlineDays;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.createOffer(req, options: options);
      // The share token rides the response envelope exactly once — attach it
      // to the entity so the success screen can build the share link.
      return _offerFromProto(resp.offer).copyWith(shareToken: resp.shareUrlToken);
    });
  }

  @override
  Future<EscrowOfferEntity> getOffer(String offerId) async {
    return retryWithBackoff(operation: () async {
      final req = pb.GetOfferRequest()..offerId = offerId;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.getOffer(req, options: options);
      return _offerFromProto(resp.offer).copyWith(shareToken: resp.shareUrlToken);
    });
  }

  @override
  Future<EscrowOfferEntity> getOfferByShareToken(String shareToken) async {
    return retryWithBackoff(operation: () async {
      final req = pb.GetOfferByShareTokenRequest()..shareToken = shareToken;
      final options = await grpcClient.callOptions;
      final resp =
          await grpcClient.escrowClient.getOfferByShareToken(req, options: options);
      return _offerFromProto(resp.offer);
    });
  }

  @override
  Future<List<EscrowOfferEntity>> listMyOffers({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 50,
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.ListMyOffersRequest()
        ..role = role
        ..status = status
        ..page = page
        ..limit = limit;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.listMyOffers(req, options: options);
      return resp.offers.map(_offerFromProto).toList();
    });
  }

  @override
  Future<EscrowOfferEntity> respondOffer({
    required String offerId,
    required bool accept,
    String note = '',
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.RespondOfferRequest()
        ..offerId = offerId
        ..accept = accept
        ..note = note;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.respondOffer(req, options: options);
      return _offerFromProto(resp.offer);
    });
  }

  @override
  Future<EscrowDealEntity> fundOffer({
    required String offerId,
    required String buyerAccountId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    // NO retry wrapper on the money RPC itself would be ideal, but FundOffer is
    // server-side idempotent end-to-end: the deal idempotency key reserves the
    // outcome before money moves, so a network-level retry can only replay into
    // the cached result — matching how createDeal is wired.
    return retryWithBackoff(operation: () async {
      final req = pb.FundOfferRequest()
        ..offerId = offerId
        ..buyerAccountId = buyerAccountId
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.fundOffer(req, options: options);
      return _dealFromProto(resp.deal);
    });
  }

  @override
  Future<EscrowOfferEntity> cancelOffer(String offerId) async {
    return retryWithBackoff(operation: () async {
      final req = pb.CancelOfferRequest()..offerId = offerId;
      final options = await grpcClient.callOptions;
      final resp = await grpcClient.escrowClient.cancelOffer(req, options: options);
      return _offerFromProto(resp.offer);
    });
  }

  @override
  Future<void> addOfferAttachment({
    required String offerId,
    required String mediaKind,
    required String url,
    String contentType = '',
    int sizeBytes = 0,
    int durationSeconds = 0,
  }) async {
    return retryWithBackoff(operation: () async {
      final req = pb.AddOfferAttachmentRequest()
        ..offerId = offerId
        ..mediaKind = mediaKind
        ..url = url
        ..contentType = contentType
        ..sizeBytes = Int64(sizeBytes)
        ..durationSeconds = durationSeconds;
      final options = await grpcClient.callOptions;
      await grpcClient.escrowClient.addOfferAttachment(req, options: options);
    });
  }

  EscrowOfferEntity _offerFromProto(pb.Offer o) => EscrowOfferEntity(
        id: o.id,
        reference: o.reference,
        direction: o.direction,
        creatorUserId: o.creatorUserId,
        creatorName: o.creatorName,
        counterpartyUserId: o.counterpartyUserId,
        counterpartyName: o.counterpartyName,
        title: o.title,
        description: o.description,
        amount: o.amount,
        currency: o.currency,
        feePayerMode: o.feePayerMode,
        deliveryDeadlineDays: o.deliveryDeadlineDays,
        status: o.status,
        declineReason: o.declineReason,
        expiresAt: o.hasExpiresAt() ? _toDate(o.expiresAt) : null,
        fundingDeadlineAt:
            o.hasFundingDeadlineAt() ? _toDate(o.fundingDeadlineAt) : null,
        dealId: o.dealId,
        acceptedAt: o.hasAcceptedAt() ? _toDate(o.acceptedAt) : null,
        createdAt: o.hasCreatedAt() ? _toDate(o.createdAt) : null,
        attachments: o.attachments.map(_attachmentFromProto).toList(),
        viewerIsCreator: o.viewerIsCreator,
      );

  // ---- proto → entity mapping ----

  EscrowAttachmentEntity _attachmentFromProto(pb.Attachment a) => EscrowAttachmentEntity(
        id: a.id,
        purpose: a.purpose,
        mediaKind: a.mediaKind,
        url: a.url,
        contentType: a.contentType,
        sizeBytes: a.sizeBytes.toInt(),
        durationSeconds: a.durationSeconds,
        uploadedBy: a.uploadedBy,
        actorRole: a.actorRole,
        createdAt: a.hasCreatedAt() ? _toDate(a.createdAt) : null,
      );

  EscrowRefundRequestEntity _refundFromProto(pb.RefundRequest r) => EscrowRefundRequestEntity(
        id: r.id,
        dealId: r.dealId,
        requestedBy: r.requestedBy,
        reason: r.reason,
        status: r.status,
        responseDeadlineAt:
            r.hasResponseDeadlineAt() ? _toDate(r.responseDeadlineAt) : null,
        respondedBy: r.respondedBy,
        responseNote: r.responseNote,
        respondedAt: r.hasRespondedAt() ? _toDate(r.respondedAt) : null,
        createdAt: r.hasCreatedAt() ? _toDate(r.createdAt) : null,
        attachments: r.attachments.map(_attachmentFromProto).toList(),
      );

  EscrowDealEntity _dealFromProto(pb.Deal d) {
    return EscrowDealEntity(
      id: d.id,
      reference: d.reference,
      buyerUserId: d.buyerUserId,
      buyerAccountId: d.buyerAccountId,
      buyerName: d.buyerName,
      sellerUserId: d.sellerUserId,
      sellerAccountId: d.sellerAccountId,
      sellerName: d.sellerName,
      title: d.title,
      description: d.description,
      currency: d.currency,
      amount: d.amount,
      fee: d.fee,
      feePayer: d.feePayer,
      buyerTotal: d.buyerTotal,
      sellerNet: d.sellerNet,
      status: d.status,
      fraudScore: d.fraudScore,
      requiresAdminReview: d.requiresAdminReview,
      deliveryNote: d.deliveryNote,
      buyerItemImageUrl: d.buyerItemImageUrl,
      sellerProofImageUrl: d.sellerProofImageUrl,
      deadlineAt: d.hasDeadlineAt() ? _toDate(d.deadlineAt) : null,
      fundedAt: d.hasFundedAt() ? _toDate(d.fundedAt) : null,
      deliveredAt: d.hasDeliveredAt() ? _toDate(d.deliveredAt) : null,
      releasedAt: d.hasReleasedAt() ? _toDate(d.releasedAt) : null,
      createdAt: d.hasCreatedAt() ? _toDate(d.createdAt) : null,
      updatedAt: d.hasUpdatedAt() ? _toDate(d.updatedAt) : null,
      events: d.events
          .map((e) => EscrowDealEventEntity(
                id: e.id,
                dealId: e.dealId,
                eventType: e.eventType,
                actor: e.actor,
                detail: e.detail,
                createdAt: e.hasCreatedAt() ? _toDate(e.createdAt) : null,
              ))
          .toList(),
      attachments: d.attachments.map(_attachmentFromProto).toList(),
      refundRequest: d.hasRefundRequest() ? _refundFromProto(d.refundRequest) : null,
    );
  }

  DateTime _toDate(ts.Timestamp t) =>
      DateTime.fromMillisecondsSinceEpoch(t.seconds.toInt() * 1000, isUtc: true).toLocal();
}
