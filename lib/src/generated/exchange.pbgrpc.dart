// This is a generated file - do not edit.
//
// Generated from exchange.proto.

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

import 'exchange.pb.dart' as $0;

export 'exchange.pb.dart';

/// --- Service Definition ---
@$pb.GrpcServiceName('pb.ExchangeService')
class ExchangeServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ExchangeServiceClient(super.channel, {super.options, super.interceptors});

  /// Get the current exchange rate between two currencies
  $grpc.ResponseFuture<$0.GetExchangeRateResponse> getExchangeRate(
    $0.GetExchangeRateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  /// Initiate an international currency transfer
  $grpc.ResponseFuture<$0.InitiateInternationalTransferResponse>
      initiateInternationalTransfer(
    $0.InitiateInternationalTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  /// Get recent exchange transactions for the authenticated user
  $grpc.ResponseFuture<$0.GetRecentExchangesResponse> getRecentExchanges(
    $0.GetRecentExchangesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecentExchanges, request, options: options);
  }

  /// Convert currency between user's own wallets
  $grpc.ResponseFuture<$0.ConvertCurrencyResponse> convertCurrency(
    $0.ConvertCurrencyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$convertCurrency, request, options: options);
  }

  /// Get the status of an exchange transaction
  $grpc.ResponseFuture<$0.GetTransactionStatusResponse> getTransactionStatus(
    $0.GetTransactionStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTransactionStatus, request, options: options);
  }

  /// Get the user's FX conversion limits based on KYC tier
  $grpc.ResponseFuture<$0.GetExchangeLimitsResponse> getExchangeLimits(
    $0.GetExchangeLimitsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getExchangeLimits, request, options: options);
  }

  /// Get list of supported currencies for exchange
  $grpc.ResponseFuture<$0.GetSupportedCurrenciesResponse>
      getSupportedCurrencies(
    $0.GetSupportedCurrenciesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedCurrencies, request,
        options: options);
  }

  // method descriptors

  static final _$getExchangeRate =
      $grpc.ClientMethod<$0.GetExchangeRateRequest, $0.GetExchangeRateResponse>(
          '/pb.ExchangeService/GetExchangeRate',
          ($0.GetExchangeRateRequest value) => value.writeToBuffer(),
          $0.GetExchangeRateResponse.fromBuffer);
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $0.InitiateInternationalTransferRequest,
          $0.InitiateInternationalTransferResponse>(
      '/pb.ExchangeService/InitiateInternationalTransfer',
      ($0.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      $0.InitiateInternationalTransferResponse.fromBuffer);
  static final _$getRecentExchanges = $grpc.ClientMethod<
          $0.GetRecentExchangesRequest, $0.GetRecentExchangesResponse>(
      '/pb.ExchangeService/GetRecentExchanges',
      ($0.GetRecentExchangesRequest value) => value.writeToBuffer(),
      $0.GetRecentExchangesResponse.fromBuffer);
  static final _$convertCurrency =
      $grpc.ClientMethod<$0.ConvertCurrencyRequest, $0.ConvertCurrencyResponse>(
          '/pb.ExchangeService/ConvertCurrency',
          ($0.ConvertCurrencyRequest value) => value.writeToBuffer(),
          $0.ConvertCurrencyResponse.fromBuffer);
  static final _$getTransactionStatus = $grpc.ClientMethod<
          $0.GetTransactionStatusRequest, $0.GetTransactionStatusResponse>(
      '/pb.ExchangeService/GetTransactionStatus',
      ($0.GetTransactionStatusRequest value) => value.writeToBuffer(),
      $0.GetTransactionStatusResponse.fromBuffer);
  static final _$getExchangeLimits = $grpc.ClientMethod<
          $0.GetExchangeLimitsRequest, $0.GetExchangeLimitsResponse>(
      '/pb.ExchangeService/GetExchangeLimits',
      ($0.GetExchangeLimitsRequest value) => value.writeToBuffer(),
      $0.GetExchangeLimitsResponse.fromBuffer);
  static final _$getSupportedCurrencies = $grpc.ClientMethod<
          $0.GetSupportedCurrenciesRequest, $0.GetSupportedCurrenciesResponse>(
      '/pb.ExchangeService/GetSupportedCurrencies',
      ($0.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      $0.GetSupportedCurrenciesResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.ExchangeService')
abstract class ExchangeServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ExchangeService';

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
      $grpc.ServiceCall $call,
      $async.Future<$0.GetExchangeRateRequest> $request) async {
    return getExchangeRate($call, await $request);
  }

  $async.Future<$0.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $0.GetExchangeRateRequest request);

  $async.Future<$0.InitiateInternationalTransferResponse>
      initiateInternationalTransfer_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.InitiateInternationalTransferRequest>
              $request) async {
    return initiateInternationalTransfer($call, await $request);
  }

  $async.Future<$0.InitiateInternationalTransferResponse>
      initiateInternationalTransfer($grpc.ServiceCall call,
          $0.InitiateInternationalTransferRequest request);

  $async.Future<$0.GetRecentExchangesResponse> getRecentExchanges_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetRecentExchangesRequest> $request) async {
    return getRecentExchanges($call, await $request);
  }

  $async.Future<$0.GetRecentExchangesResponse> getRecentExchanges(
      $grpc.ServiceCall call, $0.GetRecentExchangesRequest request);

  $async.Future<$0.ConvertCurrencyResponse> convertCurrency_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ConvertCurrencyRequest> $request) async {
    return convertCurrency($call, await $request);
  }

  $async.Future<$0.ConvertCurrencyResponse> convertCurrency(
      $grpc.ServiceCall call, $0.ConvertCurrencyRequest request);

  $async.Future<$0.GetTransactionStatusResponse> getTransactionStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTransactionStatusRequest> $request) async {
    return getTransactionStatus($call, await $request);
  }

  $async.Future<$0.GetTransactionStatusResponse> getTransactionStatus(
      $grpc.ServiceCall call, $0.GetTransactionStatusRequest request);

  $async.Future<$0.GetExchangeLimitsResponse> getExchangeLimits_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetExchangeLimitsRequest> $request) async {
    return getExchangeLimits($call, await $request);
  }

  $async.Future<$0.GetExchangeLimitsResponse> getExchangeLimits(
      $grpc.ServiceCall call, $0.GetExchangeLimitsRequest request);

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedCurrenciesRequest> $request) async {
    return getSupportedCurrencies($call, await $request);
  }

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies(
      $grpc.ServiceCall call, $0.GetSupportedCurrenciesRequest request);
}
