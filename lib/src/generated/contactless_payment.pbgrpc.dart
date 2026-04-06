///
//  Generated code. Do not modify.
//  source: contactless_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'contactless_payment.pb.dart' as $10;
export 'contactless_payment.pb.dart';

class ContactlessPaymentServiceClient extends $grpc.Client {
  static final _$createPaymentSession = $grpc.ClientMethod<
          $10.CreatePaymentSessionRequest, $10.CreatePaymentSessionResponse>(
      '/contactless.ContactlessPaymentService/CreatePaymentSession',
      ($10.CreatePaymentSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.CreatePaymentSessionResponse.fromBuffer(value));
  static final _$getPaymentSession = $grpc.ClientMethod<
          $10.GetPaymentSessionRequest, $10.GetPaymentSessionResponse>(
      '/contactless.ContactlessPaymentService/GetPaymentSession',
      ($10.GetPaymentSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetPaymentSessionResponse.fromBuffer(value));
  static final _$processContactlessPayment = $grpc.ClientMethod<
          $10.ProcessContactlessPaymentRequest,
          $10.ProcessContactlessPaymentResponse>(
      '/contactless.ContactlessPaymentService/ProcessContactlessPayment',
      ($10.ProcessContactlessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.ProcessContactlessPaymentResponse.fromBuffer(value));
  static final _$cancelPaymentSession = $grpc.ClientMethod<
          $10.CancelPaymentSessionRequest, $10.CancelPaymentSessionResponse>(
      '/contactless.ContactlessPaymentService/CancelPaymentSession',
      ($10.CancelPaymentSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.CancelPaymentSessionResponse.fromBuffer(value));
  static final _$getMyPaymentSessions = $grpc.ClientMethod<
          $10.GetMyPaymentSessionsRequest, $10.GetMyPaymentSessionsResponse>(
      '/contactless.ContactlessPaymentService/GetMyPaymentSessions',
      ($10.GetMyPaymentSessionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetMyPaymentSessionsResponse.fromBuffer(value));
  static final _$getMyContactlessPayments = $grpc.ClientMethod<
          $10.GetMyContactlessPaymentsRequest,
          $10.GetMyContactlessPaymentsResponse>(
      '/contactless.ContactlessPaymentService/GetMyContactlessPayments',
      ($10.GetMyContactlessPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetMyContactlessPaymentsResponse.fromBuffer(value));
  static final _$checkSessionStatus = $grpc.ClientMethod<
          $10.CheckSessionStatusRequest, $10.CheckSessionStatusResponse>(
      '/contactless.ContactlessPaymentService/CheckSessionStatus',
      ($10.CheckSessionStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.CheckSessionStatusResponse.fromBuffer(value));
  static final _$acknowledgeSessionRead = $grpc.ClientMethod<
          $10.AcknowledgeSessionReadRequest,
          $10.AcknowledgeSessionReadResponse>(
      '/contactless.ContactlessPaymentService/AcknowledgeSessionRead',
      ($10.AcknowledgeSessionReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.AcknowledgeSessionReadResponse.fromBuffer(value));

  ContactlessPaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.CreatePaymentSessionResponse> createPaymentSession(
      $10.CreatePaymentSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPaymentSession, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetPaymentSessionResponse> getPaymentSession(
      $10.GetPaymentSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentSession, request, options: options);
  }

  $grpc.ResponseFuture<$10.ProcessContactlessPaymentResponse>
      processContactlessPayment($10.ProcessContactlessPaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processContactlessPayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$10.CancelPaymentSessionResponse> cancelPaymentSession(
      $10.CancelPaymentSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelPaymentSession, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetMyPaymentSessionsResponse> getMyPaymentSessions(
      $10.GetMyPaymentSessionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyPaymentSessions, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetMyContactlessPaymentsResponse>
      getMyContactlessPayments($10.GetMyContactlessPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyContactlessPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$10.CheckSessionStatusResponse> checkSessionStatus(
      $10.CheckSessionStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkSessionStatus, request, options: options);
  }

  $grpc.ResponseFuture<$10.AcknowledgeSessionReadResponse>
      acknowledgeSessionRead($10.AcknowledgeSessionReadRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acknowledgeSessionRead, request,
        options: options);
  }
}

abstract class ContactlessPaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'contactless.ContactlessPaymentService';

  ContactlessPaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.CreatePaymentSessionRequest,
            $10.CreatePaymentSessionResponse>(
        'CreatePaymentSession',
        createPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CreatePaymentSessionRequest.fromBuffer(value),
        ($10.CreatePaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetPaymentSessionRequest,
            $10.GetPaymentSessionResponse>(
        'GetPaymentSession',
        getPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetPaymentSessionRequest.fromBuffer(value),
        ($10.GetPaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.ProcessContactlessPaymentRequest,
            $10.ProcessContactlessPaymentResponse>(
        'ProcessContactlessPayment',
        processContactlessPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ProcessContactlessPaymentRequest.fromBuffer(value),
        ($10.ProcessContactlessPaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.CancelPaymentSessionRequest,
            $10.CancelPaymentSessionResponse>(
        'CancelPaymentSession',
        cancelPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CancelPaymentSessionRequest.fromBuffer(value),
        ($10.CancelPaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetMyPaymentSessionsRequest,
            $10.GetMyPaymentSessionsResponse>(
        'GetMyPaymentSessions',
        getMyPaymentSessions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetMyPaymentSessionsRequest.fromBuffer(value),
        ($10.GetMyPaymentSessionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetMyContactlessPaymentsRequest,
            $10.GetMyContactlessPaymentsResponse>(
        'GetMyContactlessPayments',
        getMyContactlessPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetMyContactlessPaymentsRequest.fromBuffer(value),
        ($10.GetMyContactlessPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.CheckSessionStatusRequest,
            $10.CheckSessionStatusResponse>(
        'CheckSessionStatus',
        checkSessionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CheckSessionStatusRequest.fromBuffer(value),
        ($10.CheckSessionStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.AcknowledgeSessionReadRequest,
            $10.AcknowledgeSessionReadResponse>(
        'AcknowledgeSessionRead',
        acknowledgeSessionRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.AcknowledgeSessionReadRequest.fromBuffer(value),
        ($10.AcknowledgeSessionReadResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.CreatePaymentSessionResponse> createPaymentSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.CreatePaymentSessionRequest> request) async {
    return createPaymentSession(call, await request);
  }

  $async.Future<$10.GetPaymentSessionResponse> getPaymentSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetPaymentSessionRequest> request) async {
    return getPaymentSession(call, await request);
  }

  $async.Future<$10.ProcessContactlessPaymentResponse>
      processContactlessPayment_Pre($grpc.ServiceCall call,
          $async.Future<$10.ProcessContactlessPaymentRequest> request) async {
    return processContactlessPayment(call, await request);
  }

  $async.Future<$10.CancelPaymentSessionResponse> cancelPaymentSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.CancelPaymentSessionRequest> request) async {
    return cancelPaymentSession(call, await request);
  }

  $async.Future<$10.GetMyPaymentSessionsResponse> getMyPaymentSessions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetMyPaymentSessionsRequest> request) async {
    return getMyPaymentSessions(call, await request);
  }

  $async.Future<$10.GetMyContactlessPaymentsResponse>
      getMyContactlessPayments_Pre($grpc.ServiceCall call,
          $async.Future<$10.GetMyContactlessPaymentsRequest> request) async {
    return getMyContactlessPayments(call, await request);
  }

  $async.Future<$10.CheckSessionStatusResponse> checkSessionStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.CheckSessionStatusRequest> request) async {
    return checkSessionStatus(call, await request);
  }

  $async.Future<$10.AcknowledgeSessionReadResponse> acknowledgeSessionRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.AcknowledgeSessionReadRequest> request) async {
    return acknowledgeSessionRead(call, await request);
  }

  $async.Future<$10.CreatePaymentSessionResponse> createPaymentSession(
      $grpc.ServiceCall call, $10.CreatePaymentSessionRequest request);
  $async.Future<$10.GetPaymentSessionResponse> getPaymentSession(
      $grpc.ServiceCall call, $10.GetPaymentSessionRequest request);
  $async.Future<$10.ProcessContactlessPaymentResponse>
      processContactlessPayment(
          $grpc.ServiceCall call, $10.ProcessContactlessPaymentRequest request);
  $async.Future<$10.CancelPaymentSessionResponse> cancelPaymentSession(
      $grpc.ServiceCall call, $10.CancelPaymentSessionRequest request);
  $async.Future<$10.GetMyPaymentSessionsResponse> getMyPaymentSessions(
      $grpc.ServiceCall call, $10.GetMyPaymentSessionsRequest request);
  $async.Future<$10.GetMyContactlessPaymentsResponse> getMyContactlessPayments(
      $grpc.ServiceCall call, $10.GetMyContactlessPaymentsRequest request);
  $async.Future<$10.CheckSessionStatusResponse> checkSessionStatus(
      $grpc.ServiceCall call, $10.CheckSessionStatusRequest request);
  $async.Future<$10.AcknowledgeSessionReadResponse> acknowledgeSessionRead(
      $grpc.ServiceCall call, $10.AcknowledgeSessionReadRequest request);
}
