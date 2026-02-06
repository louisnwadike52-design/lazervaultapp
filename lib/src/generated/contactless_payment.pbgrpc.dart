//
//  Generated code. Do not modify.
//  source: contactless_payment.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'contactless_payment.pb.dart' as $11;

export 'contactless_payment.pb.dart';

@$pb.GrpcServiceName('contactless_payment.ContactlessPaymentService')
class ContactlessPaymentServiceClient extends $grpc.Client {
  static final _$createPaymentSession = $grpc.ClientMethod<$11.CreatePaymentSessionRequest, $11.CreatePaymentSessionResponse>(
      '/contactless_payment.ContactlessPaymentService/CreatePaymentSession',
      ($11.CreatePaymentSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.CreatePaymentSessionResponse.fromBuffer(value));
  static final _$getPaymentSession = $grpc.ClientMethod<$11.GetPaymentSessionRequest, $11.GetPaymentSessionResponse>(
      '/contactless_payment.ContactlessPaymentService/GetPaymentSession',
      ($11.GetPaymentSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.GetPaymentSessionResponse.fromBuffer(value));
  static final _$processContactlessPayment = $grpc.ClientMethod<$11.ProcessContactlessPaymentRequest, $11.ProcessContactlessPaymentResponse>(
      '/contactless_payment.ContactlessPaymentService/ProcessContactlessPayment',
      ($11.ProcessContactlessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.ProcessContactlessPaymentResponse.fromBuffer(value));
  static final _$cancelPaymentSession = $grpc.ClientMethod<$11.CancelPaymentSessionRequest, $11.CancelPaymentSessionResponse>(
      '/contactless_payment.ContactlessPaymentService/CancelPaymentSession',
      ($11.CancelPaymentSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.CancelPaymentSessionResponse.fromBuffer(value));
  static final _$getMyPaymentSessions = $grpc.ClientMethod<$11.GetMyPaymentSessionsRequest, $11.GetMyPaymentSessionsResponse>(
      '/contactless_payment.ContactlessPaymentService/GetMyPaymentSessions',
      ($11.GetMyPaymentSessionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.GetMyPaymentSessionsResponse.fromBuffer(value));
  static final _$getMyContactlessPayments = $grpc.ClientMethod<$11.GetMyContactlessPaymentsRequest, $11.GetMyContactlessPaymentsResponse>(
      '/contactless_payment.ContactlessPaymentService/GetMyContactlessPayments',
      ($11.GetMyContactlessPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.GetMyContactlessPaymentsResponse.fromBuffer(value));
  static final _$checkSessionStatus = $grpc.ClientMethod<$11.CheckSessionStatusRequest, $11.CheckSessionStatusResponse>(
      '/contactless_payment.ContactlessPaymentService/CheckSessionStatus',
      ($11.CheckSessionStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.CheckSessionStatusResponse.fromBuffer(value));
  static final _$acknowledgeSessionRead = $grpc.ClientMethod<$11.AcknowledgeSessionReadRequest, $11.AcknowledgeSessionReadResponse>(
      '/contactless_payment.ContactlessPaymentService/AcknowledgeSessionRead',
      ($11.AcknowledgeSessionReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.AcknowledgeSessionReadResponse.fromBuffer(value));

  ContactlessPaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$11.CreatePaymentSessionResponse> createPaymentSession($11.CreatePaymentSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPaymentSession, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetPaymentSessionResponse> getPaymentSession($11.GetPaymentSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentSession, request, options: options);
  }

  $grpc.ResponseFuture<$11.ProcessContactlessPaymentResponse> processContactlessPayment($11.ProcessContactlessPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processContactlessPayment, request, options: options);
  }

  $grpc.ResponseFuture<$11.CancelPaymentSessionResponse> cancelPaymentSession($11.CancelPaymentSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelPaymentSession, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetMyPaymentSessionsResponse> getMyPaymentSessions($11.GetMyPaymentSessionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyPaymentSessions, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetMyContactlessPaymentsResponse> getMyContactlessPayments($11.GetMyContactlessPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyContactlessPayments, request, options: options);
  }

  $grpc.ResponseFuture<$11.CheckSessionStatusResponse> checkSessionStatus($11.CheckSessionStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkSessionStatus, request, options: options);
  }

  $grpc.ResponseFuture<$11.AcknowledgeSessionReadResponse> acknowledgeSessionRead($11.AcknowledgeSessionReadRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acknowledgeSessionRead, request, options: options);
  }
}

@$pb.GrpcServiceName('contactless_payment.ContactlessPaymentService')
abstract class ContactlessPaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'contactless_payment.ContactlessPaymentService';

  ContactlessPaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$11.CreatePaymentSessionRequest, $11.CreatePaymentSessionResponse>(
        'CreatePaymentSession',
        createPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.CreatePaymentSessionRequest.fromBuffer(value),
        ($11.CreatePaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetPaymentSessionRequest, $11.GetPaymentSessionResponse>(
        'GetPaymentSession',
        getPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.GetPaymentSessionRequest.fromBuffer(value),
        ($11.GetPaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.ProcessContactlessPaymentRequest, $11.ProcessContactlessPaymentResponse>(
        'ProcessContactlessPayment',
        processContactlessPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.ProcessContactlessPaymentRequest.fromBuffer(value),
        ($11.ProcessContactlessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.CancelPaymentSessionRequest, $11.CancelPaymentSessionResponse>(
        'CancelPaymentSession',
        cancelPaymentSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.CancelPaymentSessionRequest.fromBuffer(value),
        ($11.CancelPaymentSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetMyPaymentSessionsRequest, $11.GetMyPaymentSessionsResponse>(
        'GetMyPaymentSessions',
        getMyPaymentSessions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.GetMyPaymentSessionsRequest.fromBuffer(value),
        ($11.GetMyPaymentSessionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetMyContactlessPaymentsRequest, $11.GetMyContactlessPaymentsResponse>(
        'GetMyContactlessPayments',
        getMyContactlessPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.GetMyContactlessPaymentsRequest.fromBuffer(value),
        ($11.GetMyContactlessPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.CheckSessionStatusRequest, $11.CheckSessionStatusResponse>(
        'CheckSessionStatus',
        checkSessionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.CheckSessionStatusRequest.fromBuffer(value),
        ($11.CheckSessionStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.AcknowledgeSessionReadRequest, $11.AcknowledgeSessionReadResponse>(
        'AcknowledgeSessionRead',
        acknowledgeSessionRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.AcknowledgeSessionReadRequest.fromBuffer(value),
        ($11.AcknowledgeSessionReadResponse value) => value.writeToBuffer()));
  }

  $async.Future<$11.CreatePaymentSessionResponse> createPaymentSession_Pre($grpc.ServiceCall call, $async.Future<$11.CreatePaymentSessionRequest> request) async {
    return createPaymentSession(call, await request);
  }

  $async.Future<$11.GetPaymentSessionResponse> getPaymentSession_Pre($grpc.ServiceCall call, $async.Future<$11.GetPaymentSessionRequest> request) async {
    return getPaymentSession(call, await request);
  }

  $async.Future<$11.ProcessContactlessPaymentResponse> processContactlessPayment_Pre($grpc.ServiceCall call, $async.Future<$11.ProcessContactlessPaymentRequest> request) async {
    return processContactlessPayment(call, await request);
  }

  $async.Future<$11.CancelPaymentSessionResponse> cancelPaymentSession_Pre($grpc.ServiceCall call, $async.Future<$11.CancelPaymentSessionRequest> request) async {
    return cancelPaymentSession(call, await request);
  }

  $async.Future<$11.GetMyPaymentSessionsResponse> getMyPaymentSessions_Pre($grpc.ServiceCall call, $async.Future<$11.GetMyPaymentSessionsRequest> request) async {
    return getMyPaymentSessions(call, await request);
  }

  $async.Future<$11.GetMyContactlessPaymentsResponse> getMyContactlessPayments_Pre($grpc.ServiceCall call, $async.Future<$11.GetMyContactlessPaymentsRequest> request) async {
    return getMyContactlessPayments(call, await request);
  }

  $async.Future<$11.CheckSessionStatusResponse> checkSessionStatus_Pre($grpc.ServiceCall call, $async.Future<$11.CheckSessionStatusRequest> request) async {
    return checkSessionStatus(call, await request);
  }

  $async.Future<$11.AcknowledgeSessionReadResponse> acknowledgeSessionRead_Pre($grpc.ServiceCall call, $async.Future<$11.AcknowledgeSessionReadRequest> request) async {
    return acknowledgeSessionRead(call, await request);
  }

  $async.Future<$11.CreatePaymentSessionResponse> createPaymentSession($grpc.ServiceCall call, $11.CreatePaymentSessionRequest request);
  $async.Future<$11.GetPaymentSessionResponse> getPaymentSession($grpc.ServiceCall call, $11.GetPaymentSessionRequest request);
  $async.Future<$11.ProcessContactlessPaymentResponse> processContactlessPayment($grpc.ServiceCall call, $11.ProcessContactlessPaymentRequest request);
  $async.Future<$11.CancelPaymentSessionResponse> cancelPaymentSession($grpc.ServiceCall call, $11.CancelPaymentSessionRequest request);
  $async.Future<$11.GetMyPaymentSessionsResponse> getMyPaymentSessions($grpc.ServiceCall call, $11.GetMyPaymentSessionsRequest request);
  $async.Future<$11.GetMyContactlessPaymentsResponse> getMyContactlessPayments($grpc.ServiceCall call, $11.GetMyContactlessPaymentsRequest request);
  $async.Future<$11.CheckSessionStatusResponse> checkSessionStatus($grpc.ServiceCall call, $11.CheckSessionStatusRequest request);
  $async.Future<$11.AcknowledgeSessionReadResponse> acknowledgeSessionRead($grpc.ServiceCall call, $11.AcknowledgeSessionReadRequest request);
}
