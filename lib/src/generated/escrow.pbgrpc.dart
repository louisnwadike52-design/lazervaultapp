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
}
