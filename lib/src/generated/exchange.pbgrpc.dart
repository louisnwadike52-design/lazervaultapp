///
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'exchange.pb.dart' as $11;
export 'exchange.pb.dart';

class ExchangeServiceClient extends $grpc.Client {
  static final _$getExchangeRate = $grpc.ClientMethod<
          $11.GetExchangeRateRequest, $11.GetExchangeRateResponse>(
      '/pb.ExchangeService/GetExchangeRate',
      ($11.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetExchangeRateResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $11.InitiateInternationalTransferRequest,
          $11.InitiateInternationalTransferResponse>(
      '/pb.ExchangeService/InitiateInternationalTransfer',
      ($11.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.InitiateInternationalTransferResponse.fromBuffer(value));
  static final _$getRecentExchanges = $grpc.ClientMethod<
          $11.GetRecentExchangesRequest, $11.GetRecentExchangesResponse>(
      '/pb.ExchangeService/GetRecentExchanges',
      ($11.GetRecentExchangesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetRecentExchangesResponse.fromBuffer(value));

  ExchangeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$11.GetExchangeRateResponse> getExchangeRate(
      $11.GetExchangeRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$11.InitiateInternationalTransferResponse>
      initiateInternationalTransfer(
          $11.InitiateInternationalTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.GetRecentExchangesResponse> getRecentExchanges(
      $11.GetRecentExchangesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentExchanges, request, options: options);
  }
}

abstract class ExchangeServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ExchangeService';

  ExchangeServiceBase() {
    $addMethod($grpc.ServiceMethod<$11.GetExchangeRateRequest,
            $11.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetExchangeRateRequest.fromBuffer(value),
        ($11.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.InitiateInternationalTransferRequest,
            $11.InitiateInternationalTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.InitiateInternationalTransferRequest.fromBuffer(value),
        ($11.InitiateInternationalTransferResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetRecentExchangesRequest,
            $11.GetRecentExchangesResponse>(
        'GetRecentExchanges',
        getRecentExchanges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetRecentExchangesRequest.fromBuffer(value),
        ($11.GetRecentExchangesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$11.GetExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$11.InitiateInternationalTransferResponse>
      initiateInternationalTransfer_Pre(
          $grpc.ServiceCall call,
          $async.Future<$11.InitiateInternationalTransferRequest>
              request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$11.GetRecentExchangesResponse> getRecentExchanges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetRecentExchangesRequest> request) async {
    return getRecentExchanges(call, await request);
  }

  $async.Future<$11.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $11.GetExchangeRateRequest request);
  $async.Future<$11.InitiateInternationalTransferResponse>
      initiateInternationalTransfer($grpc.ServiceCall call,
          $11.InitiateInternationalTransferRequest request);
  $async.Future<$11.GetRecentExchangesResponse> getRecentExchanges(
      $grpc.ServiceCall call, $11.GetRecentExchangesRequest request);
}
