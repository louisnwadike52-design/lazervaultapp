//
//  Generated code. Do not modify.
//  source: exchange.proto
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

import 'exchange.pb.dart' as $0;

export 'exchange.pb.dart';

@$pb.GrpcServiceName('pb.ExchangeService')
class ExchangeServiceClient extends $grpc.Client {
  static final _$getExchangeRate = $grpc.ClientMethod<$0.GetExchangeRateRequest, $0.GetExchangeRateResponse>(
      '/pb.ExchangeService/GetExchangeRate',
      ($0.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetExchangeRateResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<$0.InitiateInternationalTransferRequest, $0.InitiateInternationalTransferResponse>(
      '/pb.ExchangeService/InitiateInternationalTransfer',
      ($0.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InitiateInternationalTransferResponse.fromBuffer(value));
  static final _$getRecentExchanges = $grpc.ClientMethod<$0.GetRecentExchangesRequest, $0.GetRecentExchangesResponse>(
      '/pb.ExchangeService/GetRecentExchanges',
      ($0.GetRecentExchangesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetRecentExchangesResponse.fromBuffer(value));

  ExchangeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetExchangeRateResponse> getExchangeRate($0.GetExchangeRateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$0.InitiateInternationalTransferResponse> initiateInternationalTransfer($0.InitiateInternationalTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRecentExchangesResponse> getRecentExchanges($0.GetRecentExchangesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentExchanges, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.ExchangeService')
abstract class ExchangeServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ExchangeService';

  ExchangeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetExchangeRateRequest, $0.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetExchangeRateRequest.fromBuffer(value),
        ($0.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateInternationalTransferRequest, $0.InitiateInternationalTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InitiateInternationalTransferRequest.fromBuffer(value),
        ($0.InitiateInternationalTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecentExchangesRequest, $0.GetRecentExchangesResponse>(
        'GetRecentExchanges',
        getRecentExchanges_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRecentExchangesRequest.fromBuffer(value),
        ($0.GetRecentExchangesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetExchangeRateResponse> getExchangeRate_Pre($grpc.ServiceCall call, $async.Future<$0.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$0.InitiateInternationalTransferResponse> initiateInternationalTransfer_Pre($grpc.ServiceCall call, $async.Future<$0.InitiateInternationalTransferRequest> request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$0.GetRecentExchangesResponse> getRecentExchanges_Pre($grpc.ServiceCall call, $async.Future<$0.GetRecentExchangesRequest> request) async {
    return getRecentExchanges(call, await request);
  }

  $async.Future<$0.GetExchangeRateResponse> getExchangeRate($grpc.ServiceCall call, $0.GetExchangeRateRequest request);
  $async.Future<$0.InitiateInternationalTransferResponse> initiateInternationalTransfer($grpc.ServiceCall call, $0.InitiateInternationalTransferRequest request);
  $async.Future<$0.GetRecentExchangesResponse> getRecentExchanges($grpc.ServiceCall call, $0.GetRecentExchangesRequest request);
}
