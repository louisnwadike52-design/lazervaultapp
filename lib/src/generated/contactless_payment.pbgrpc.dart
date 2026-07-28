// This is a generated file - do not edit.
//
// Generated from contactless_payment.proto.

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

import 'contactless_payment.pb.dart' as $0;

export 'contactless_payment.pb.dart';

/// ContactlessPaymentService handles NFC-based peer-to-peer payments
/// Similar to SumUp/Apple Pay tap-to-pay functionality
@$pb.GrpcServiceName('contactless.ContactlessPaymentService')
class ContactlessPaymentServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ContactlessPaymentServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Receiver creates a payment session that can be broadcast via NFC
  $grpc.ResponseFuture<$0.CreatePaymentSessionResponse> createPaymentSession(
    $0.CreatePaymentSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createPaymentSession, request, options: options);
  }

  /// Get session details by session ID (used when payer taps NFC)
  $grpc.ResponseFuture<$0.GetPaymentSessionResponse> getPaymentSession(
    $0.GetPaymentSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPaymentSession, request, options: options);
  }

  /// Process payment after payer confirms (with PIN verification)
  $grpc.ResponseFuture<$0.ProcessContactlessPaymentResponse>
      processContactlessPayment(
    $0.ProcessContactlessPaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processContactlessPayment, request,
        options: options);
  }

  /// Cancel a pending payment session
  $grpc.ResponseFuture<$0.CancelPaymentSessionResponse> cancelPaymentSession(
    $0.CancelPaymentSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelPaymentSession, request, options: options);
  }

  /// Get receiver's created payment sessions
  $grpc.ResponseFuture<$0.GetMyPaymentSessionsResponse> getMyPaymentSessions(
    $0.GetMyPaymentSessionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMyPaymentSessions, request, options: options);
  }

  /// Get payer's contactless payment history
  $grpc.ResponseFuture<$0.GetMyContactlessPaymentsResponse>
      getMyContactlessPayments(
    $0.GetMyContactlessPaymentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMyContactlessPayments, request,
        options: options);
  }

  /// Check session status (for polling during NFC exchange)
  $grpc.ResponseFuture<$0.CheckSessionStatusResponse> checkSessionStatus(
    $0.CheckSessionStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkSessionStatus, request, options: options);
  }

  /// Acknowledge session read (payer confirms they read the NFC data)
  $grpc.ResponseFuture<$0.AcknowledgeSessionReadResponse>
      acknowledgeSessionRead(
    $0.AcknowledgeSessionReadRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$acknowledgeSessionRead, request,
        options: options);
  }

  // method descriptors

  static final _$createPaymentSession = $grpc.ClientMethod<
          $0.CreatePaymentSessionRequest, $0.CreatePaymentSessionResponse>(
      '/contactless.ContactlessPaymentService/CreatePaymentSession',
      ($0.CreatePaymentSessionRequest value) => value.writeToBuffer(),
      $0.CreatePaymentSessionResponse.fromBuffer);
  static final _$getPaymentSession = $grpc.ClientMethod<
          $0.GetPaymentSessionRequest, $0.GetPaymentSessionResponse>(
      '/contactless.ContactlessPaymentService/GetPaymentSession',
      ($0.GetPaymentSessionRequest value) => value.writeToBuffer(),
      $0.GetPaymentSessionResponse.fromBuffer);
  static final _$processContactlessPayment = $grpc.ClientMethod<
          $0.ProcessContactlessPaymentRequest,
          $0.ProcessContactlessPaymentResponse>(
      '/contactless.ContactlessPaymentService/ProcessContactlessPayment',
      ($0.ProcessContactlessPaymentRequest value) => value.writeToBuffer(),
      $0.ProcessContactlessPaymentResponse.fromBuffer);
  static final _$cancelPaymentSession = $grpc.ClientMethod<
          $0.CancelPaymentSessionRequest, $0.CancelPaymentSessionResponse>(
      '/contactless.ContactlessPaymentService/CancelPaymentSession',
      ($0.CancelPaymentSessionRequest value) => value.writeToBuffer(),
      $0.CancelPaymentSessionResponse.fromBuffer);
  static final _$getMyPaymentSessions = $grpc.ClientMethod<
          $0.GetMyPaymentSessionsRequest, $0.GetMyPaymentSessionsResponse>(
      '/contactless.ContactlessPaymentService/GetMyPaymentSessions',
      ($0.GetMyPaymentSessionsRequest value) => value.writeToBuffer(),
      $0.GetMyPaymentSessionsResponse.fromBuffer);
  static final _$getMyContactlessPayments = $grpc.ClientMethod<
          $0.GetMyContactlessPaymentsRequest,
          $0.GetMyContactlessPaymentsResponse>(
      '/contactless.ContactlessPaymentService/GetMyContactlessPayments',
      ($0.GetMyContactlessPaymentsRequest value) => value.writeToBuffer(),
      $0.GetMyContactlessPaymentsResponse.fromBuffer);
  static final _$checkSessionStatus = $grpc.ClientMethod<
          $0.CheckSessionStatusRequest, $0.CheckSessionStatusResponse>(
      '/contactless.ContactlessPaymentService/CheckSessionStatus',
      ($0.CheckSessionStatusRequest value) => value.writeToBuffer(),
      $0.CheckSessionStatusResponse.fromBuffer);
  static final _$acknowledgeSessionRead = $grpc.ClientMethod<
          $0.AcknowledgeSessionReadRequest, $0.AcknowledgeSessionReadResponse>(
      '/contactless.ContactlessPaymentService/AcknowledgeSessionRead',
      ($0.AcknowledgeSessionReadRequest value) => value.writeToBuffer(),
      $0.AcknowledgeSessionReadResponse.fromBuffer);
}

@$pb.GrpcServiceName('contactless.ContactlessPaymentService')
abstract class ContactlessPaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'contactless.ContactlessPaymentService';

  ContactlessPaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreatePaymentSessionRequest,
            $0.CreatePaymentSessionResponse>(
        'CreatePaymentSession',
        createPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreatePaymentSessionRequest.fromBuffer(value),
        ($0.CreatePaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentSessionRequest,
            $0.GetPaymentSessionResponse>(
        'GetPaymentSession',
        getPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPaymentSessionRequest.fromBuffer(value),
        ($0.GetPaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessContactlessPaymentRequest,
            $0.ProcessContactlessPaymentResponse>(
        'ProcessContactlessPayment',
        processContactlessPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessContactlessPaymentRequest.fromBuffer(value),
        ($0.ProcessContactlessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelPaymentSessionRequest,
            $0.CancelPaymentSessionResponse>(
        'CancelPaymentSession',
        cancelPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelPaymentSessionRequest.fromBuffer(value),
        ($0.CancelPaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyPaymentSessionsRequest,
            $0.GetMyPaymentSessionsResponse>(
        'GetMyPaymentSessions',
        getMyPaymentSessions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyPaymentSessionsRequest.fromBuffer(value),
        ($0.GetMyPaymentSessionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyContactlessPaymentsRequest,
            $0.GetMyContactlessPaymentsResponse>(
        'GetMyContactlessPayments',
        getMyContactlessPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyContactlessPaymentsRequest.fromBuffer(value),
        ($0.GetMyContactlessPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckSessionStatusRequest,
            $0.CheckSessionStatusResponse>(
        'CheckSessionStatus',
        checkSessionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CheckSessionStatusRequest.fromBuffer(value),
        ($0.CheckSessionStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AcknowledgeSessionReadRequest,
            $0.AcknowledgeSessionReadResponse>(
        'AcknowledgeSessionRead',
        acknowledgeSessionRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AcknowledgeSessionReadRequest.fromBuffer(value),
        ($0.AcknowledgeSessionReadResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreatePaymentSessionResponse> createPaymentSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreatePaymentSessionRequest> $request) async {
    return createPaymentSession($call, await $request);
  }

  $async.Future<$0.CreatePaymentSessionResponse> createPaymentSession(
      $grpc.ServiceCall call, $0.CreatePaymentSessionRequest request);

  $async.Future<$0.GetPaymentSessionResponse> getPaymentSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPaymentSessionRequest> $request) async {
    return getPaymentSession($call, await $request);
  }

  $async.Future<$0.GetPaymentSessionResponse> getPaymentSession(
      $grpc.ServiceCall call, $0.GetPaymentSessionRequest request);

  $async.Future<$0.ProcessContactlessPaymentResponse>
      processContactlessPayment_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ProcessContactlessPaymentRequest> $request) async {
    return processContactlessPayment($call, await $request);
  }

  $async.Future<$0.ProcessContactlessPaymentResponse> processContactlessPayment(
      $grpc.ServiceCall call, $0.ProcessContactlessPaymentRequest request);

  $async.Future<$0.CancelPaymentSessionResponse> cancelPaymentSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelPaymentSessionRequest> $request) async {
    return cancelPaymentSession($call, await $request);
  }

  $async.Future<$0.CancelPaymentSessionResponse> cancelPaymentSession(
      $grpc.ServiceCall call, $0.CancelPaymentSessionRequest request);

  $async.Future<$0.GetMyPaymentSessionsResponse> getMyPaymentSessions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMyPaymentSessionsRequest> $request) async {
    return getMyPaymentSessions($call, await $request);
  }

  $async.Future<$0.GetMyPaymentSessionsResponse> getMyPaymentSessions(
      $grpc.ServiceCall call, $0.GetMyPaymentSessionsRequest request);

  $async.Future<$0.GetMyContactlessPaymentsResponse>
      getMyContactlessPayments_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetMyContactlessPaymentsRequest> $request) async {
    return getMyContactlessPayments($call, await $request);
  }

  $async.Future<$0.GetMyContactlessPaymentsResponse> getMyContactlessPayments(
      $grpc.ServiceCall call, $0.GetMyContactlessPaymentsRequest request);

  $async.Future<$0.CheckSessionStatusResponse> checkSessionStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckSessionStatusRequest> $request) async {
    return checkSessionStatus($call, await $request);
  }

  $async.Future<$0.CheckSessionStatusResponse> checkSessionStatus(
      $grpc.ServiceCall call, $0.CheckSessionStatusRequest request);

  $async.Future<$0.AcknowledgeSessionReadResponse> acknowledgeSessionRead_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AcknowledgeSessionReadRequest> $request) async {
    return acknowledgeSessionRead($call, await $request);
  }

  $async.Future<$0.AcknowledgeSessionReadResponse> acknowledgeSessionRead(
      $grpc.ServiceCall call, $0.AcknowledgeSessionReadRequest request);
}
