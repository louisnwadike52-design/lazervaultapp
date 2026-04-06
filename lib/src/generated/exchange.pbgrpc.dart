///
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'exchange.pb.dart' as $16;
export 'exchange.pb.dart';

class ExchangeServiceClient extends $grpc.Client {
  static final _$getExchangeRate = $grpc.ClientMethod<
          $16.GetExchangeRateRequest, $16.GetExchangeRateResponse>(
      '/exchange.ExchangeService/GetExchangeRate',
      ($16.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetExchangeRateResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $16.InitiateInternationalTransferRequest,
          $16.InitiateInternationalTransferResponse>(
      '/exchange.ExchangeService/InitiateInternationalTransfer',
      ($16.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.InitiateInternationalTransferResponse.fromBuffer(value));
  static final _$getRecentExchanges = $grpc.ClientMethod<
          $16.GetRecentExchangesRequest, $16.GetRecentExchangesResponse>(
      '/exchange.ExchangeService/GetRecentExchanges',
      ($16.GetRecentExchangesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetRecentExchangesResponse.fromBuffer(value));
  static final _$convertCurrency = $grpc.ClientMethod<
          $16.ConvertCurrencyRequest, $16.ConvertCurrencyResponse>(
      '/exchange.ExchangeService/ConvertCurrency',
      ($16.ConvertCurrencyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ConvertCurrencyResponse.fromBuffer(value));
  static final _$getTransactionStatus = $grpc.ClientMethod<
          $16.GetTransactionStatusRequest, $16.GetTransactionStatusResponse>(
      '/exchange.ExchangeService/GetTransactionStatus',
      ($16.GetTransactionStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetTransactionStatusResponse.fromBuffer(value));
  static final _$getExchangeLimits = $grpc.ClientMethod<
          $16.GetExchangeLimitsRequest, $16.GetExchangeLimitsResponse>(
      '/exchange.ExchangeService/GetExchangeLimits',
      ($16.GetExchangeLimitsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetExchangeLimitsResponse.fromBuffer(value));
  static final _$getSupportedCurrencies = $grpc.ClientMethod<
          $16.GetSupportedCurrenciesRequest,
          $16.GetSupportedCurrenciesResponse>(
      '/exchange.ExchangeService/GetSupportedCurrencies',
      ($16.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetSupportedCurrenciesResponse.fromBuffer(value));

  ExchangeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$16.GetExchangeRateResponse> getExchangeRate(
      $16.GetExchangeRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$16.InitiateInternationalTransferResponse>
      initiateInternationalTransfer(
          $16.InitiateInternationalTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetRecentExchangesResponse> getRecentExchanges(
      $16.GetRecentExchangesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentExchanges, request, options: options);
  }

  $grpc.ResponseFuture<$16.ConvertCurrencyResponse> convertCurrency(
      $16.ConvertCurrencyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertCurrency, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetTransactionStatusResponse> getTransactionStatus(
      $16.GetTransactionStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionStatus, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetExchangeLimitsResponse> getExchangeLimits(
      $16.GetExchangeLimitsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeLimits, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetSupportedCurrenciesResponse>
      getSupportedCurrencies($16.GetSupportedCurrenciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCurrencies, request,
        options: options);
  }
}

abstract class ExchangeServiceBase extends $grpc.Service {
  $core.String get $name => 'exchange.ExchangeService';

  ExchangeServiceBase() {
    $addMethod($grpc.ServiceMethod<$16.GetExchangeRateRequest,
            $16.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetExchangeRateRequest.fromBuffer(value),
        ($16.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.InitiateInternationalTransferRequest,
            $16.InitiateInternationalTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.InitiateInternationalTransferRequest.fromBuffer(value),
        ($16.InitiateInternationalTransferResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetRecentExchangesRequest,
            $16.GetRecentExchangesResponse>(
        'GetRecentExchanges',
        getRecentExchanges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetRecentExchangesRequest.fromBuffer(value),
        ($16.GetRecentExchangesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ConvertCurrencyRequest,
            $16.ConvertCurrencyResponse>(
        'ConvertCurrency',
        convertCurrency_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ConvertCurrencyRequest.fromBuffer(value),
        ($16.ConvertCurrencyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetTransactionStatusRequest,
            $16.GetTransactionStatusResponse>(
        'GetTransactionStatus',
        getTransactionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetTransactionStatusRequest.fromBuffer(value),
        ($16.GetTransactionStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetExchangeLimitsRequest,
            $16.GetExchangeLimitsResponse>(
        'GetExchangeLimits',
        getExchangeLimits_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetExchangeLimitsRequest.fromBuffer(value),
        ($16.GetExchangeLimitsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetSupportedCurrenciesRequest,
            $16.GetSupportedCurrenciesResponse>(
        'GetSupportedCurrencies',
        getSupportedCurrencies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($16.GetSupportedCurrenciesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$16.GetExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$16.InitiateInternationalTransferResponse>
      initiateInternationalTransfer_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.InitiateInternationalTransferRequest>
              request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$16.GetRecentExchangesResponse> getRecentExchanges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetRecentExchangesRequest> request) async {
    return getRecentExchanges(call, await request);
  }

  $async.Future<$16.ConvertCurrencyResponse> convertCurrency_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ConvertCurrencyRequest> request) async {
    return convertCurrency(call, await request);
  }

  $async.Future<$16.GetTransactionStatusResponse> getTransactionStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetTransactionStatusRequest> request) async {
    return getTransactionStatus(call, await request);
  }

  $async.Future<$16.GetExchangeLimitsResponse> getExchangeLimits_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetExchangeLimitsRequest> request) async {
    return getExchangeLimits(call, await request);
  }

  $async.Future<$16.GetSupportedCurrenciesResponse> getSupportedCurrencies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetSupportedCurrenciesRequest> request) async {
    return getSupportedCurrencies(call, await request);
  }

  $async.Future<$16.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $16.GetExchangeRateRequest request);
  $async.Future<$16.InitiateInternationalTransferResponse>
      initiateInternationalTransfer($grpc.ServiceCall call,
          $16.InitiateInternationalTransferRequest request);
  $async.Future<$16.GetRecentExchangesResponse> getRecentExchanges(
      $grpc.ServiceCall call, $16.GetRecentExchangesRequest request);
  $async.Future<$16.ConvertCurrencyResponse> convertCurrency(
      $grpc.ServiceCall call, $16.ConvertCurrencyRequest request);
  $async.Future<$16.GetTransactionStatusResponse> getTransactionStatus(
      $grpc.ServiceCall call, $16.GetTransactionStatusRequest request);
  $async.Future<$16.GetExchangeLimitsResponse> getExchangeLimits(
      $grpc.ServiceCall call, $16.GetExchangeLimitsRequest request);
  $async.Future<$16.GetSupportedCurrenciesResponse> getSupportedCurrencies(
      $grpc.ServiceCall call, $16.GetSupportedCurrenciesRequest request);
}
