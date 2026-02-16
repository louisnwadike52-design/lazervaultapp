//
//  Generated code. Do not modify.
//  source: id_pay.proto
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

import 'id_pay.pb.dart' as $0;

export 'id_pay.pb.dart';

@$pb.GrpcServiceName('id_pay.IDPayService')
class IDPayServiceClient extends $grpc.Client {
  static final _$createIDPay = $grpc.ClientMethod<$0.CreateIDPayRequest, $0.CreateIDPayResponse>(
      '/id_pay.IDPayService/CreateIDPay',
      ($0.CreateIDPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateIDPayResponse.fromBuffer(value));
  static final _$lookupIDPay = $grpc.ClientMethod<$0.LookupIDPayRequest, $0.LookupIDPayResponse>(
      '/id_pay.IDPayService/LookupIDPay',
      ($0.LookupIDPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LookupIDPayResponse.fromBuffer(value));
  static final _$payIDPay = $grpc.ClientMethod<$0.PayIDPayRequest, $0.PayIDPayResponse>(
      '/id_pay.IDPayService/PayIDPay',
      ($0.PayIDPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayIDPayResponse.fromBuffer(value));
  static final _$getMyIDPays = $grpc.ClientMethod<$0.GetMyIDPaysRequest, $0.GetMyIDPaysResponse>(
      '/id_pay.IDPayService/GetMyIDPays',
      ($0.GetMyIDPaysRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyIDPaysResponse.fromBuffer(value));
  static final _$getIDPayTransactions = $grpc.ClientMethod<$0.GetIDPayTransactionsRequest, $0.GetIDPayTransactionsResponse>(
      '/id_pay.IDPayService/GetIDPayTransactions',
      ($0.GetIDPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetIDPayTransactionsResponse.fromBuffer(value));
  static final _$cancelIDPay = $grpc.ClientMethod<$0.CancelIDPayRequest, $0.CancelIDPayResponse>(
      '/id_pay.IDPayService/CancelIDPay',
      ($0.CancelIDPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelIDPayResponse.fromBuffer(value));
  static final _$getIDPayDetails = $grpc.ClientMethod<$0.GetIDPayDetailsRequest, $0.GetIDPayDetailsResponse>(
      '/id_pay.IDPayService/GetIDPayDetails',
      ($0.GetIDPayDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetIDPayDetailsResponse.fromBuffer(value));

  IDPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateIDPayResponse> createIDPay($0.CreateIDPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.LookupIDPayResponse> lookupIDPay($0.LookupIDPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayIDPayResponse> payIDPay($0.PayIDPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyIDPaysResponse> getMyIDPays($0.GetMyIDPaysRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIDPays, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIDPayTransactionsResponse> getIDPayTransactions($0.GetIDPayTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelIDPayResponse> cancelIDPay($0.CancelIDPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIDPayDetailsResponse> getIDPayDetails($0.GetIDPayDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDPayDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('id_pay.IDPayService')
abstract class IDPayServiceBase extends $grpc.Service {
  $core.String get $name => 'id_pay.IDPayService';

  IDPayServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateIDPayRequest, $0.CreateIDPayResponse>(
        'CreateIDPay',
        createIDPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateIDPayRequest.fromBuffer(value),
        ($0.CreateIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LookupIDPayRequest, $0.LookupIDPayResponse>(
        'LookupIDPay',
        lookupIDPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LookupIDPayRequest.fromBuffer(value),
        ($0.LookupIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayIDPayRequest, $0.PayIDPayResponse>(
        'PayIDPay',
        payIDPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayIDPayRequest.fromBuffer(value),
        ($0.PayIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyIDPaysRequest, $0.GetMyIDPaysResponse>(
        'GetMyIDPays',
        getMyIDPays_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyIDPaysRequest.fromBuffer(value),
        ($0.GetMyIDPaysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIDPayTransactionsRequest, $0.GetIDPayTransactionsResponse>(
        'GetIDPayTransactions',
        getIDPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetIDPayTransactionsRequest.fromBuffer(value),
        ($0.GetIDPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelIDPayRequest, $0.CancelIDPayResponse>(
        'CancelIDPay',
        cancelIDPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelIDPayRequest.fromBuffer(value),
        ($0.CancelIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIDPayDetailsRequest, $0.GetIDPayDetailsResponse>(
        'GetIDPayDetails',
        getIDPayDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetIDPayDetailsRequest.fromBuffer(value),
        ($0.GetIDPayDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateIDPayResponse> createIDPay_Pre($grpc.ServiceCall call, $async.Future<$0.CreateIDPayRequest> request) async {
    return createIDPay(call, await request);
  }

  $async.Future<$0.LookupIDPayResponse> lookupIDPay_Pre($grpc.ServiceCall call, $async.Future<$0.LookupIDPayRequest> request) async {
    return lookupIDPay(call, await request);
  }

  $async.Future<$0.PayIDPayResponse> payIDPay_Pre($grpc.ServiceCall call, $async.Future<$0.PayIDPayRequest> request) async {
    return payIDPay(call, await request);
  }

  $async.Future<$0.GetMyIDPaysResponse> getMyIDPays_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyIDPaysRequest> request) async {
    return getMyIDPays(call, await request);
  }

  $async.Future<$0.GetIDPayTransactionsResponse> getIDPayTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetIDPayTransactionsRequest> request) async {
    return getIDPayTransactions(call, await request);
  }

  $async.Future<$0.CancelIDPayResponse> cancelIDPay_Pre($grpc.ServiceCall call, $async.Future<$0.CancelIDPayRequest> request) async {
    return cancelIDPay(call, await request);
  }

  $async.Future<$0.GetIDPayDetailsResponse> getIDPayDetails_Pre($grpc.ServiceCall call, $async.Future<$0.GetIDPayDetailsRequest> request) async {
    return getIDPayDetails(call, await request);
  }

  $async.Future<$0.CreateIDPayResponse> createIDPay($grpc.ServiceCall call, $0.CreateIDPayRequest request);
  $async.Future<$0.LookupIDPayResponse> lookupIDPay($grpc.ServiceCall call, $0.LookupIDPayRequest request);
  $async.Future<$0.PayIDPayResponse> payIDPay($grpc.ServiceCall call, $0.PayIDPayRequest request);
  $async.Future<$0.GetMyIDPaysResponse> getMyIDPays($grpc.ServiceCall call, $0.GetMyIDPaysRequest request);
  $async.Future<$0.GetIDPayTransactionsResponse> getIDPayTransactions($grpc.ServiceCall call, $0.GetIDPayTransactionsRequest request);
  $async.Future<$0.CancelIDPayResponse> cancelIDPay($grpc.ServiceCall call, $0.CancelIDPayRequest request);
  $async.Future<$0.GetIDPayDetailsResponse> getIDPayDetails($grpc.ServiceCall call, $0.GetIDPayDetailsRequest request);
}
