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

import 'exchange.pb.dart' as $16;

export 'exchange.pb.dart';

@$pb.GrpcServiceName('pb.ExchangeService')
class ExchangeServiceClient extends $grpc.Client {
  static final _$getExchangeRate = $grpc.ClientMethod<$16.GetExchangeRateRequest, $16.GetExchangeRateResponse>(
      '/pb.ExchangeService/GetExchangeRate',
      ($16.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $16.GetExchangeRateResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<$16.InitiateInternationalTransferRequest, $16.InitiateInternationalTransferResponse>(
      '/pb.ExchangeService/InitiateInternationalTransfer',
      ($16.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $16.InitiateInternationalTransferResponse.fromBuffer(value));
  static final _$getRecentExchanges = $grpc.ClientMethod<$16.GetRecentExchangesRequest, $16.GetRecentExchangesResponse>(
      '/pb.ExchangeService/GetRecentExchanges',
      ($16.GetRecentExchangesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $16.GetRecentExchangesResponse.fromBuffer(value));

  ExchangeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$16.GetExchangeRateResponse> getExchangeRate($16.GetExchangeRateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$16.InitiateInternationalTransferResponse> initiateInternationalTransfer($16.InitiateInternationalTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetRecentExchangesResponse> getRecentExchanges($16.GetRecentExchangesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentExchanges, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.ExchangeService')
abstract class ExchangeServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ExchangeService';

  ExchangeServiceBase() {
    $addMethod($grpc.ServiceMethod<$16.GetExchangeRateRequest, $16.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $16.GetExchangeRateRequest.fromBuffer(value),
        ($16.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.InitiateInternationalTransferRequest, $16.InitiateInternationalTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $16.InitiateInternationalTransferRequest.fromBuffer(value),
        ($16.InitiateInternationalTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetRecentExchangesRequest, $16.GetRecentExchangesResponse>(
        'GetRecentExchanges',
        getRecentExchanges_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $16.GetRecentExchangesRequest.fromBuffer(value),
        ($16.GetRecentExchangesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$16.GetExchangeRateResponse> getExchangeRate_Pre($grpc.ServiceCall call, $async.Future<$16.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$16.InitiateInternationalTransferResponse> initiateInternationalTransfer_Pre($grpc.ServiceCall call, $async.Future<$16.InitiateInternationalTransferRequest> request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$16.GetRecentExchangesResponse> getRecentExchanges_Pre($grpc.ServiceCall call, $async.Future<$16.GetRecentExchangesRequest> request) async {
    return getRecentExchanges(call, await request);
  }

  $async.Future<$16.GetExchangeRateResponse> getExchangeRate($grpc.ServiceCall call, $16.GetExchangeRateRequest request);
  $async.Future<$16.InitiateInternationalTransferResponse> initiateInternationalTransfer($grpc.ServiceCall call, $16.InitiateInternationalTransferRequest request);
  $async.Future<$16.GetRecentExchangesResponse> getRecentExchanges($grpc.ServiceCall call, $16.GetRecentExchangesRequest request);
}
