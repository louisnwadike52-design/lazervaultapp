///
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'exchange.pb.dart' as $0;
export 'exchange.pb.dart';

class ExchangeServiceClient extends $grpc.Client {
  static final _$getExchangeRate =
      $grpc.ClientMethod<$0.GetExchangeRateRequest, $0.GetExchangeRateResponse>(
          '/exchange.ExchangeService/GetExchangeRate',
          ($0.GetExchangeRateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetExchangeRateResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $0.InitiateInternationalTransferRequest,
          $0.InitiateInternationalTransferResponse>(
      '/exchange.ExchangeService/InitiateInternationalTransfer',
      ($0.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateInternationalTransferResponse.fromBuffer(value));
  static final _$getRecentExchanges = $grpc.ClientMethod<
          $0.GetRecentExchangesRequest, $0.GetRecentExchangesResponse>(
      '/exchange.ExchangeService/GetRecentExchanges',
      ($0.GetRecentExchangesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRecentExchangesResponse.fromBuffer(value));
  static final _$convertCurrency =
      $grpc.ClientMethod<$0.ConvertCurrencyRequest, $0.ConvertCurrencyResponse>(
          '/exchange.ExchangeService/ConvertCurrency',
          ($0.ConvertCurrencyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ConvertCurrencyResponse.fromBuffer(value));
  static final _$getTransactionStatus = $grpc.ClientMethod<
          $0.GetTransactionStatusRequest, $0.GetTransactionStatusResponse>(
      '/exchange.ExchangeService/GetTransactionStatus',
      ($0.GetTransactionStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTransactionStatusResponse.fromBuffer(value));
  static final _$getExchangeLimits = $grpc.ClientMethod<
          $0.GetExchangeLimitsRequest, $0.GetExchangeLimitsResponse>(
      '/exchange.ExchangeService/GetExchangeLimits',
      ($0.GetExchangeLimitsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetExchangeLimitsResponse.fromBuffer(value));
  static final _$getSupportedCurrencies = $grpc.ClientMethod<
          $0.GetSupportedCurrenciesRequest, $0.GetSupportedCurrenciesResponse>(
      '/exchange.ExchangeService/GetSupportedCurrencies',
      ($0.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSupportedCurrenciesResponse.fromBuffer(value));

  ExchangeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetExchangeRateResponse> getExchangeRate(
      $0.GetExchangeRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$0.InitiateInternationalTransferResponse>
      initiateInternationalTransfer(
          $0.InitiateInternationalTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetRecentExchangesResponse> getRecentExchanges(
      $0.GetRecentExchangesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentExchanges, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConvertCurrencyResponse> convertCurrency(
      $0.ConvertCurrencyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertCurrency, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionStatusResponse> getTransactionStatus(
      $0.GetTransactionStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExchangeLimitsResponse> getExchangeLimits(
      $0.GetExchangeLimitsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeLimits, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSupportedCurrenciesResponse>
      getSupportedCurrencies($0.GetSupportedCurrenciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCurrencies, request,
        options: options);
  }
}

abstract class ExchangeServiceBase extends $grpc.Service {
  $core.String get $name => 'exchange.ExchangeService';

  ExchangeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetExchangeRateRequest,
            $0.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetExchangeRateRequest.fromBuffer(value),
        ($0.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateInternationalTransferRequest,
            $0.InitiateInternationalTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateInternationalTransferRequest.fromBuffer(value),
        ($0.InitiateInternationalTransferResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecentExchangesRequest,
            $0.GetRecentExchangesResponse>(
        'GetRecentExchanges',
        getRecentExchanges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecentExchangesRequest.fromBuffer(value),
        ($0.GetRecentExchangesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConvertCurrencyRequest,
            $0.ConvertCurrencyResponse>(
        'ConvertCurrency',
        convertCurrency_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ConvertCurrencyRequest.fromBuffer(value),
        ($0.ConvertCurrencyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionStatusRequest,
            $0.GetTransactionStatusResponse>(
        'GetTransactionStatus',
        getTransactionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionStatusRequest.fromBuffer(value),
        ($0.GetTransactionStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExchangeLimitsRequest,
            $0.GetExchangeLimitsResponse>(
        'GetExchangeLimits',
        getExchangeLimits_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetExchangeLimitsRequest.fromBuffer(value),
        ($0.GetExchangeLimitsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCurrenciesRequest,
            $0.GetSupportedCurrenciesResponse>(
        'GetSupportedCurrencies',
        getSupportedCurrencies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($0.GetSupportedCurrenciesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$0.InitiateInternationalTransferResponse>
      initiateInternationalTransfer_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.InitiateInternationalTransferRequest>
              request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$0.GetRecentExchangesResponse> getRecentExchanges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetRecentExchangesRequest> request) async {
    return getRecentExchanges(call, await request);
  }

  $async.Future<$0.ConvertCurrencyResponse> convertCurrency_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ConvertCurrencyRequest> request) async {
    return convertCurrency(call, await request);
  }

  $async.Future<$0.GetTransactionStatusResponse> getTransactionStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransactionStatusRequest> request) async {
    return getTransactionStatus(call, await request);
  }

  $async.Future<$0.GetExchangeLimitsResponse> getExchangeLimits_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetExchangeLimitsRequest> request) async {
    return getExchangeLimits(call, await request);
  }

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSupportedCurrenciesRequest> request) async {
    return getSupportedCurrencies(call, await request);
  }

  $async.Future<$0.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $0.GetExchangeRateRequest request);
  $async.Future<$0.InitiateInternationalTransferResponse>
      initiateInternationalTransfer($grpc.ServiceCall call,
          $0.InitiateInternationalTransferRequest request);
  $async.Future<$0.GetRecentExchangesResponse> getRecentExchanges(
      $grpc.ServiceCall call, $0.GetRecentExchangesRequest request);
  $async.Future<$0.ConvertCurrencyResponse> convertCurrency(
      $grpc.ServiceCall call, $0.ConvertCurrencyRequest request);
  $async.Future<$0.GetTransactionStatusResponse> getTransactionStatus(
      $grpc.ServiceCall call, $0.GetTransactionStatusRequest request);
  $async.Future<$0.GetExchangeLimitsResponse> getExchangeLimits(
      $grpc.ServiceCall call, $0.GetExchangeLimitsRequest request);
  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies(
      $grpc.ServiceCall call, $0.GetSupportedCurrenciesRequest request);
}
