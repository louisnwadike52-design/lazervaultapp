// This is a generated file - do not edit.
//
// Generated from escrow.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'escrow.pb.dart' as $0;

export 'escrow.pb.dart';

/// Escrow Service — safe user-to-user deals. The BUYER funds a deal into the
/// platform ESCROW_POOL; the SELLER delivers; the BUYER validates; funds are
/// released from the pool to the seller (minus an admin-configurable fee).
/// Disputes are admin-arbitrated. State machine:
///   DRAFT → FUNDED → IN_PROGRESS → DELIVERED → RELEASED
///        → DISPUTED → RESOLVED_RELEASED | RESOLVED_REFUNDED
///        → CANCELLED | EXPIRED → REFUNDED
@$pb.GrpcServiceName('escrow.EscrowService')
class EscrowServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  EscrowServiceClient(super.channel, {super.options, super.interceptors});

  /// Create + fund a deal (buyer locks funds into the escrow pool). PIN-gated.
  $grpc.ResponseFuture<$0.DealResponse> createDeal(
    $0.CreateDealRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createDeal, request, options: options);
  }

  /// List the caller's deals (as buyer and/or seller).
  $grpc.ResponseFuture<$0.ListDealsResponse> listMyDeals(
    $0.ListMyDealsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyDeals, request, options: options);
  }

  /// Single deal detail (+ timeline events). Caller must be a party or admin.
  $grpc.ResponseFuture<$0.DealResponse> getDeal(
    $0.GetDealRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDeal, request, options: options);
  }

  /// Seller marks the deal delivered (→ DELIVERED, awaiting buyer validation).
  $grpc.ResponseFuture<$0.DealResponse> markDelivered(
    $0.MarkDeliveredRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$markDelivered, request, options: options);
  }

  /// Buyer validates delivery → release funds to seller (→ RELEASED). PIN-gated.
  $grpc.ResponseFuture<$0.DealResponse> validateRelease(
    $0.ValidateReleaseRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateRelease, request, options: options);
  }

  /// Buyer/seller cancels a not-yet-delivered deal → refund buyer (→ CANCELLED).
  $grpc.ResponseFuture<$0.DealResponse> cancelDeal(
    $0.CancelDealRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelDeal, request, options: options);
  }

  /// Either party opens a dispute (→ DISPUTED, admin queue).
  $grpc.ResponseFuture<$0.DealResponse> openDispute(
    $0.OpenDisputeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$openDispute, request, options: options);
  }

  /// Fee preview for a prospective deal (reads admin-configurable fee config).
  $grpc.ResponseFuture<$0.QuoteFeeResponse> quoteFee(
    $0.QuoteFeeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$quoteFee, request, options: options);
  }

  /// Attach an image or video to a deal (deal item, delivery proof, dispute or
  /// refund evidence). Bytes are uploaded to storage-service first; this records
  /// the public URL + metadata after party/size/duration validation.
  $grpc.ResponseFuture<$0.AttachmentResponse> addAttachment(
    $0.AddAttachmentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addAttachment, request, options: options);
  }

  /// Buyer requests a refund after delivery (within the inspection window). The
  /// seller is notified and can accept or decline.
  $grpc.ResponseFuture<$0.DealResponse> requestRefund(
    $0.RequestRefundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestRefund, request, options: options);
  }

  /// Seller responds to a buyer's refund request: accept (buyer refunded) or
  /// decline (escalated to an admin-arbitrated dispute).
  $grpc.ResponseFuture<$0.DealResponse> respondRefund(
    $0.RespondRefundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$respondRefund, request, options: options);
  }

  /// Publish an offer. NO PIN — nothing moves; the PIN gate stays on funding.
  $grpc.ResponseFuture<$0.OfferResponse> createOffer(
    $0.CreateOfferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createOffer, request, options: options);
  }

  /// Read an offer as a party (creator or addressed counterparty).
  $grpc.ResponseFuture<$0.OfferResponse> getOffer(
    $0.GetOfferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOffer, request, options: options);
  }

  /// Resolve a share link. Any AUTHENTICATED user may view; the 32-byte random
  /// share token is the capability (the reference carries no entropy).
  $grpc.ResponseFuture<$0.OfferResponse> getOfferByShareToken(
    $0.GetOfferByShareTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOfferByShareToken, request, options: options);
  }

  /// List offers I created ("created") or that are addressed to me ("received").
  $grpc.ResponseFuture<$0.ListOffersResponse> listMyOffers(
    $0.ListMyOffersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyOffers, request, options: options);
  }

  /// Addressed counterparty answers an OPEN offer. Accepting a buy_request moves
  /// it to AWAITING_FUNDING (the buyer then funds); a sell_offer is accepted by
  /// funding it, not through this RPC. Declining is terminal.
  $grpc.ResponseFuture<$0.OfferResponse> respondOffer(
    $0.RespondOfferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$respondOffer, request, options: options);
  }

  /// Fund an agreed offer — THE money movement. Requires PIN verification and
  /// runs the entire CreateDeal path; returns the FUNDED deal.
  $grpc.ResponseFuture<$0.DealResponse> fundOffer(
    $0.FundOfferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$fundOffer, request, options: options);
  }

  /// Creator withdraws a not-yet-converted offer.
  $grpc.ResponseFuture<$0.OfferResponse> cancelOffer(
    $0.CancelOfferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelOffer, request, options: options);
  }

  /// Creator attaches listing media (image/video) to a live offer. Same limits
  /// as deal attachments; media follows the offer into the deal at conversion.
  $grpc.ResponseFuture<$0.AttachmentResponse> addOfferAttachment(
    $0.AddOfferAttachmentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addOfferAttachment, request, options: options);
  }

  // method descriptors

  static final _$createDeal =
      $grpc.ClientMethod<$0.CreateDealRequest, $0.DealResponse>(
          '/escrow.EscrowService/CreateDeal',
          ($0.CreateDealRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$listMyDeals =
      $grpc.ClientMethod<$0.ListMyDealsRequest, $0.ListDealsResponse>(
          '/escrow.EscrowService/ListMyDeals',
          ($0.ListMyDealsRequest value) => value.writeToBuffer(),
          $0.ListDealsResponse.fromBuffer);
  static final _$getDeal =
      $grpc.ClientMethod<$0.GetDealRequest, $0.DealResponse>(
          '/escrow.EscrowService/GetDeal',
          ($0.GetDealRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$markDelivered =
      $grpc.ClientMethod<$0.MarkDeliveredRequest, $0.DealResponse>(
          '/escrow.EscrowService/MarkDelivered',
          ($0.MarkDeliveredRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$validateRelease =
      $grpc.ClientMethod<$0.ValidateReleaseRequest, $0.DealResponse>(
          '/escrow.EscrowService/ValidateRelease',
          ($0.ValidateReleaseRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$cancelDeal =
      $grpc.ClientMethod<$0.CancelDealRequest, $0.DealResponse>(
          '/escrow.EscrowService/CancelDeal',
          ($0.CancelDealRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$openDispute =
      $grpc.ClientMethod<$0.OpenDisputeRequest, $0.DealResponse>(
          '/escrow.EscrowService/OpenDispute',
          ($0.OpenDisputeRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$quoteFee =
      $grpc.ClientMethod<$0.QuoteFeeRequest, $0.QuoteFeeResponse>(
          '/escrow.EscrowService/QuoteFee',
          ($0.QuoteFeeRequest value) => value.writeToBuffer(),
          $0.QuoteFeeResponse.fromBuffer);
  static final _$addAttachment =
      $grpc.ClientMethod<$0.AddAttachmentRequest, $0.AttachmentResponse>(
          '/escrow.EscrowService/AddAttachment',
          ($0.AddAttachmentRequest value) => value.writeToBuffer(),
          $0.AttachmentResponse.fromBuffer);
  static final _$requestRefund =
      $grpc.ClientMethod<$0.RequestRefundRequest, $0.DealResponse>(
          '/escrow.EscrowService/RequestRefund',
          ($0.RequestRefundRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$respondRefund =
      $grpc.ClientMethod<$0.RespondRefundRequest, $0.DealResponse>(
          '/escrow.EscrowService/RespondRefund',
          ($0.RespondRefundRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$createOffer =
      $grpc.ClientMethod<$0.CreateOfferRequest, $0.OfferResponse>(
          '/escrow.EscrowService/CreateOffer',
          ($0.CreateOfferRequest value) => value.writeToBuffer(),
          $0.OfferResponse.fromBuffer);
  static final _$getOffer =
      $grpc.ClientMethod<$0.GetOfferRequest, $0.OfferResponse>(
          '/escrow.EscrowService/GetOffer',
          ($0.GetOfferRequest value) => value.writeToBuffer(),
          $0.OfferResponse.fromBuffer);
  static final _$getOfferByShareToken =
      $grpc.ClientMethod<$0.GetOfferByShareTokenRequest, $0.OfferResponse>(
          '/escrow.EscrowService/GetOfferByShareToken',
          ($0.GetOfferByShareTokenRequest value) => value.writeToBuffer(),
          $0.OfferResponse.fromBuffer);
  static final _$listMyOffers =
      $grpc.ClientMethod<$0.ListMyOffersRequest, $0.ListOffersResponse>(
          '/escrow.EscrowService/ListMyOffers',
          ($0.ListMyOffersRequest value) => value.writeToBuffer(),
          $0.ListOffersResponse.fromBuffer);
  static final _$respondOffer =
      $grpc.ClientMethod<$0.RespondOfferRequest, $0.OfferResponse>(
          '/escrow.EscrowService/RespondOffer',
          ($0.RespondOfferRequest value) => value.writeToBuffer(),
          $0.OfferResponse.fromBuffer);
  static final _$fundOffer =
      $grpc.ClientMethod<$0.FundOfferRequest, $0.DealResponse>(
          '/escrow.EscrowService/FundOffer',
          ($0.FundOfferRequest value) => value.writeToBuffer(),
          $0.DealResponse.fromBuffer);
  static final _$cancelOffer =
      $grpc.ClientMethod<$0.CancelOfferRequest, $0.OfferResponse>(
          '/escrow.EscrowService/CancelOffer',
          ($0.CancelOfferRequest value) => value.writeToBuffer(),
          $0.OfferResponse.fromBuffer);
  static final _$addOfferAttachment =
      $grpc.ClientMethod<$0.AddOfferAttachmentRequest, $0.AttachmentResponse>(
          '/escrow.EscrowService/AddOfferAttachment',
          ($0.AddOfferAttachmentRequest value) => value.writeToBuffer(),
          $0.AttachmentResponse.fromBuffer);
}

@$pb.GrpcServiceName('escrow.EscrowService')
abstract class EscrowServiceBase extends $grpc.Service {
  $core.String get $name => 'escrow.EscrowService';

  EscrowServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateDealRequest, $0.DealResponse>(
        'CreateDeal',
        createDeal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateDealRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListMyDealsRequest, $0.ListDealsResponse>(
        'ListMyDeals',
        listMyDeals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListMyDealsRequest.fromBuffer(value),
        ($0.ListDealsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDealRequest, $0.DealResponse>(
        'GetDeal',
        getDeal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDealRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkDeliveredRequest, $0.DealResponse>(
        'MarkDelivered',
        markDelivered_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkDeliveredRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateReleaseRequest, $0.DealResponse>(
        'ValidateRelease',
        validateRelease_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateReleaseRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelDealRequest, $0.DealResponse>(
        'CancelDeal',
        cancelDeal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelDealRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OpenDisputeRequest, $0.DealResponse>(
        'OpenDispute',
        openDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.OpenDisputeRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.QuoteFeeRequest, $0.QuoteFeeResponse>(
        'QuoteFee',
        quoteFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.QuoteFeeRequest.fromBuffer(value),
        ($0.QuoteFeeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AddAttachmentRequest, $0.AttachmentResponse>(
            'AddAttachment',
            addAttachment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddAttachmentRequest.fromBuffer(value),
            ($0.AttachmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestRefundRequest, $0.DealResponse>(
        'RequestRefund',
        requestRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestRefundRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RespondRefundRequest, $0.DealResponse>(
        'RespondRefund',
        respondRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RespondRefundRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateOfferRequest, $0.OfferResponse>(
        'CreateOffer',
        createOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateOfferRequest.fromBuffer(value),
        ($0.OfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOfferRequest, $0.OfferResponse>(
        'GetOffer',
        getOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOfferRequest.fromBuffer(value),
        ($0.OfferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetOfferByShareTokenRequest, $0.OfferResponse>(
            'GetOfferByShareToken',
            getOfferByShareToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOfferByShareTokenRequest.fromBuffer(value),
            ($0.OfferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListMyOffersRequest, $0.ListOffersResponse>(
            'ListMyOffers',
            listMyOffers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListMyOffersRequest.fromBuffer(value),
            ($0.ListOffersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RespondOfferRequest, $0.OfferResponse>(
        'RespondOffer',
        respondOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RespondOfferRequest.fromBuffer(value),
        ($0.OfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FundOfferRequest, $0.DealResponse>(
        'FundOffer',
        fundOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FundOfferRequest.fromBuffer(value),
        ($0.DealResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelOfferRequest, $0.OfferResponse>(
        'CancelOffer',
        cancelOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelOfferRequest.fromBuffer(value),
        ($0.OfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddOfferAttachmentRequest,
            $0.AttachmentResponse>(
        'AddOfferAttachment',
        addOfferAttachment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddOfferAttachmentRequest.fromBuffer(value),
        ($0.AttachmentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.DealResponse> createDeal_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateDealRequest> $request) async {
    return createDeal($call, await $request);
  }

  $async.Future<$0.DealResponse> createDeal(
      $grpc.ServiceCall call, $0.CreateDealRequest request);

  $async.Future<$0.ListDealsResponse> listMyDeals_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListMyDealsRequest> $request) async {
    return listMyDeals($call, await $request);
  }

  $async.Future<$0.ListDealsResponse> listMyDeals(
      $grpc.ServiceCall call, $0.ListMyDealsRequest request);

  $async.Future<$0.DealResponse> getDeal_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetDealRequest> $request) async {
    return getDeal($call, await $request);
  }

  $async.Future<$0.DealResponse> getDeal(
      $grpc.ServiceCall call, $0.GetDealRequest request);

  $async.Future<$0.DealResponse> markDelivered_Pre($grpc.ServiceCall $call,
      $async.Future<$0.MarkDeliveredRequest> $request) async {
    return markDelivered($call, await $request);
  }

  $async.Future<$0.DealResponse> markDelivered(
      $grpc.ServiceCall call, $0.MarkDeliveredRequest request);

  $async.Future<$0.DealResponse> validateRelease_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ValidateReleaseRequest> $request) async {
    return validateRelease($call, await $request);
  }

  $async.Future<$0.DealResponse> validateRelease(
      $grpc.ServiceCall call, $0.ValidateReleaseRequest request);

  $async.Future<$0.DealResponse> cancelDeal_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CancelDealRequest> $request) async {
    return cancelDeal($call, await $request);
  }

  $async.Future<$0.DealResponse> cancelDeal(
      $grpc.ServiceCall call, $0.CancelDealRequest request);

  $async.Future<$0.DealResponse> openDispute_Pre($grpc.ServiceCall $call,
      $async.Future<$0.OpenDisputeRequest> $request) async {
    return openDispute($call, await $request);
  }

  $async.Future<$0.DealResponse> openDispute(
      $grpc.ServiceCall call, $0.OpenDisputeRequest request);

  $async.Future<$0.QuoteFeeResponse> quoteFee_Pre($grpc.ServiceCall $call,
      $async.Future<$0.QuoteFeeRequest> $request) async {
    return quoteFee($call, await $request);
  }

  $async.Future<$0.QuoteFeeResponse> quoteFee(
      $grpc.ServiceCall call, $0.QuoteFeeRequest request);

  $async.Future<$0.AttachmentResponse> addAttachment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddAttachmentRequest> $request) async {
    return addAttachment($call, await $request);
  }

  $async.Future<$0.AttachmentResponse> addAttachment(
      $grpc.ServiceCall call, $0.AddAttachmentRequest request);

  $async.Future<$0.DealResponse> requestRefund_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RequestRefundRequest> $request) async {
    return requestRefund($call, await $request);
  }

  $async.Future<$0.DealResponse> requestRefund(
      $grpc.ServiceCall call, $0.RequestRefundRequest request);

  $async.Future<$0.DealResponse> respondRefund_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RespondRefundRequest> $request) async {
    return respondRefund($call, await $request);
  }

  $async.Future<$0.DealResponse> respondRefund(
      $grpc.ServiceCall call, $0.RespondRefundRequest request);

  $async.Future<$0.OfferResponse> createOffer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateOfferRequest> $request) async {
    return createOffer($call, await $request);
  }

  $async.Future<$0.OfferResponse> createOffer(
      $grpc.ServiceCall call, $0.CreateOfferRequest request);

  $async.Future<$0.OfferResponse> getOffer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetOfferRequest> $request) async {
    return getOffer($call, await $request);
  }

  $async.Future<$0.OfferResponse> getOffer(
      $grpc.ServiceCall call, $0.GetOfferRequest request);

  $async.Future<$0.OfferResponse> getOfferByShareToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOfferByShareTokenRequest> $request) async {
    return getOfferByShareToken($call, await $request);
  }

  $async.Future<$0.OfferResponse> getOfferByShareToken(
      $grpc.ServiceCall call, $0.GetOfferByShareTokenRequest request);

  $async.Future<$0.ListOffersResponse> listMyOffers_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListMyOffersRequest> $request) async {
    return listMyOffers($call, await $request);
  }

  $async.Future<$0.ListOffersResponse> listMyOffers(
      $grpc.ServiceCall call, $0.ListMyOffersRequest request);

  $async.Future<$0.OfferResponse> respondOffer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RespondOfferRequest> $request) async {
    return respondOffer($call, await $request);
  }

  $async.Future<$0.OfferResponse> respondOffer(
      $grpc.ServiceCall call, $0.RespondOfferRequest request);

  $async.Future<$0.DealResponse> fundOffer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.FundOfferRequest> $request) async {
    return fundOffer($call, await $request);
  }

  $async.Future<$0.DealResponse> fundOffer(
      $grpc.ServiceCall call, $0.FundOfferRequest request);

  $async.Future<$0.OfferResponse> cancelOffer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CancelOfferRequest> $request) async {
    return cancelOffer($call, await $request);
  }

  $async.Future<$0.OfferResponse> cancelOffer(
      $grpc.ServiceCall call, $0.CancelOfferRequest request);

  $async.Future<$0.AttachmentResponse> addOfferAttachment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddOfferAttachmentRequest> $request) async {
    return addOfferAttachment($call, await $request);
  }

  $async.Future<$0.AttachmentResponse> addOfferAttachment(
      $grpc.ServiceCall call, $0.AddOfferAttachmentRequest request);
}
