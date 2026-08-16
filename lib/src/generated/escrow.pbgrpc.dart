///
//  Generated code. Do not modify.
//  source: escrow.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'escrow.pb.dart' as $0;
export 'escrow.pb.dart';

class EscrowServiceClient extends $grpc.Client {
  static final _$createDeal =
      $grpc.ClientMethod<$0.CreateDealRequest, $0.DealResponse>(
          '/escrow.EscrowService/CreateDeal',
          ($0.CreateDealRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$listMyDeals =
      $grpc.ClientMethod<$0.ListMyDealsRequest, $0.ListDealsResponse>(
          '/escrow.EscrowService/ListMyDeals',
          ($0.ListMyDealsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListDealsResponse.fromBuffer(value));
  static final _$getDeal =
      $grpc.ClientMethod<$0.GetDealRequest, $0.DealResponse>(
          '/escrow.EscrowService/GetDeal',
          ($0.GetDealRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$markDelivered =
      $grpc.ClientMethod<$0.MarkDeliveredRequest, $0.DealResponse>(
          '/escrow.EscrowService/MarkDelivered',
          ($0.MarkDeliveredRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$validateRelease =
      $grpc.ClientMethod<$0.ValidateReleaseRequest, $0.DealResponse>(
          '/escrow.EscrowService/ValidateRelease',
          ($0.ValidateReleaseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$cancelDeal =
      $grpc.ClientMethod<$0.CancelDealRequest, $0.DealResponse>(
          '/escrow.EscrowService/CancelDeal',
          ($0.CancelDealRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$openDispute =
      $grpc.ClientMethod<$0.OpenDisputeRequest, $0.DealResponse>(
          '/escrow.EscrowService/OpenDispute',
          ($0.OpenDisputeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$quoteFee =
      $grpc.ClientMethod<$0.QuoteFeeRequest, $0.QuoteFeeResponse>(
          '/escrow.EscrowService/QuoteFee',
          ($0.QuoteFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.QuoteFeeResponse.fromBuffer(value));
  static final _$addAttachment =
      $grpc.ClientMethod<$0.AddAttachmentRequest, $0.AttachmentResponse>(
          '/escrow.EscrowService/AddAttachment',
          ($0.AddAttachmentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AttachmentResponse.fromBuffer(value));
  static final _$requestRefund =
      $grpc.ClientMethod<$0.RequestRefundRequest, $0.DealResponse>(
          '/escrow.EscrowService/RequestRefund',
          ($0.RequestRefundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));
  static final _$respondRefund =
      $grpc.ClientMethod<$0.RespondRefundRequest, $0.DealResponse>(
          '/escrow.EscrowService/RespondRefund',
          ($0.RespondRefundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.DealResponse.fromBuffer(value));

  EscrowServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.DealResponse> createDeal($0.CreateDealRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDeal, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListDealsResponse> listMyDeals(
      $0.ListMyDealsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMyDeals, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> getDeal($0.GetDealRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDeal, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> markDelivered(
      $0.MarkDeliveredRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markDelivered, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> validateRelease(
      $0.ValidateReleaseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateRelease, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> cancelDeal($0.CancelDealRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelDeal, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> openDispute(
      $0.OpenDisputeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$openDispute, request, options: options);
  }

  $grpc.ResponseFuture<$0.QuoteFeeResponse> quoteFee($0.QuoteFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$quoteFee, request, options: options);
  }

  $grpc.ResponseFuture<$0.AttachmentResponse> addAttachment(
      $0.AddAttachmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addAttachment, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> requestRefund(
      $0.RequestRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestRefund, request, options: options);
  }

  $grpc.ResponseFuture<$0.DealResponse> respondRefund(
      $0.RespondRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$respondRefund, request, options: options);
  }
}

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
  }

  $async.Future<$0.DealResponse> createDeal_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateDealRequest> request) async {
    return createDeal(call, await request);
  }

  $async.Future<$0.ListDealsResponse> listMyDeals_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListMyDealsRequest> request) async {
    return listMyDeals(call, await request);
  }

  $async.Future<$0.DealResponse> getDeal_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetDealRequest> request) async {
    return getDeal(call, await request);
  }

  $async.Future<$0.DealResponse> markDelivered_Pre($grpc.ServiceCall call,
      $async.Future<$0.MarkDeliveredRequest> request) async {
    return markDelivered(call, await request);
  }

  $async.Future<$0.DealResponse> validateRelease_Pre($grpc.ServiceCall call,
      $async.Future<$0.ValidateReleaseRequest> request) async {
    return validateRelease(call, await request);
  }

  $async.Future<$0.DealResponse> cancelDeal_Pre($grpc.ServiceCall call,
      $async.Future<$0.CancelDealRequest> request) async {
    return cancelDeal(call, await request);
  }

  $async.Future<$0.DealResponse> openDispute_Pre($grpc.ServiceCall call,
      $async.Future<$0.OpenDisputeRequest> request) async {
    return openDispute(call, await request);
  }

  $async.Future<$0.QuoteFeeResponse> quoteFee_Pre(
      $grpc.ServiceCall call, $async.Future<$0.QuoteFeeRequest> request) async {
    return quoteFee(call, await request);
  }

  $async.Future<$0.AttachmentResponse> addAttachment_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddAttachmentRequest> request) async {
    return addAttachment(call, await request);
  }

  $async.Future<$0.DealResponse> requestRefund_Pre($grpc.ServiceCall call,
      $async.Future<$0.RequestRefundRequest> request) async {
    return requestRefund(call, await request);
  }

  $async.Future<$0.DealResponse> respondRefund_Pre($grpc.ServiceCall call,
      $async.Future<$0.RespondRefundRequest> request) async {
    return respondRefund(call, await request);
  }

  $async.Future<$0.DealResponse> createDeal(
      $grpc.ServiceCall call, $0.CreateDealRequest request);
  $async.Future<$0.ListDealsResponse> listMyDeals(
      $grpc.ServiceCall call, $0.ListMyDealsRequest request);
  $async.Future<$0.DealResponse> getDeal(
      $grpc.ServiceCall call, $0.GetDealRequest request);
  $async.Future<$0.DealResponse> markDelivered(
      $grpc.ServiceCall call, $0.MarkDeliveredRequest request);
  $async.Future<$0.DealResponse> validateRelease(
      $grpc.ServiceCall call, $0.ValidateReleaseRequest request);
  $async.Future<$0.DealResponse> cancelDeal(
      $grpc.ServiceCall call, $0.CancelDealRequest request);
  $async.Future<$0.DealResponse> openDispute(
      $grpc.ServiceCall call, $0.OpenDisputeRequest request);
  $async.Future<$0.QuoteFeeResponse> quoteFee(
      $grpc.ServiceCall call, $0.QuoteFeeRequest request);
  $async.Future<$0.AttachmentResponse> addAttachment(
      $grpc.ServiceCall call, $0.AddAttachmentRequest request);
  $async.Future<$0.DealResponse> requestRefund(
      $grpc.ServiceCall call, $0.RequestRefundRequest request);
  $async.Future<$0.DealResponse> respondRefund(
      $grpc.ServiceCall call, $0.RespondRefundRequest request);
}
