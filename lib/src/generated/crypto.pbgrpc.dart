///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crypto.pb.dart' as $10;
export 'crypto.pb.dart';

class CryptoServiceClient extends $grpc.Client {
  static final _$getCryptos =
      $grpc.ClientMethod<$10.GetCryptosRequest, $10.GetCryptosResponse>(
          '/pb.CryptoService/GetCryptos',
          ($10.GetCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.GetCryptosResponse.fromBuffer(value));
  static final _$getCryptoById =
      $grpc.ClientMethod<$10.GetCryptoByIdRequest, $10.GetCryptoByIdResponse>(
          '/pb.CryptoService/GetCryptoById',
          ($10.GetCryptoByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.GetCryptoByIdResponse.fromBuffer(value));
  static final _$searchCryptos =
      $grpc.ClientMethod<$10.SearchCryptosRequest, $10.SearchCryptosResponse>(
          '/pb.CryptoService/SearchCryptos',
          ($10.SearchCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.SearchCryptosResponse.fromBuffer(value));
  static final _$getCryptoPriceHistory = $grpc.ClientMethod<
          $10.GetCryptoPriceHistoryRequest, $10.GetCryptoPriceHistoryResponse>(
      '/pb.CryptoService/GetCryptoPriceHistory',
      ($10.GetCryptoPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetCryptoPriceHistoryResponse.fromBuffer(value));
  static final _$getTrendingCryptos = $grpc.ClientMethod<
          $10.GetTrendingCryptosRequest, $10.GetTrendingCryptosResponse>(
      '/pb.CryptoService/GetTrendingCryptos',
      ($10.GetTrendingCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetTrendingCryptosResponse.fromBuffer(value));
  static final _$getTopCryptos =
      $grpc.ClientMethod<$10.GetTopCryptosRequest, $10.GetTopCryptosResponse>(
          '/pb.CryptoService/GetTopCryptos',
          ($10.GetTopCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.GetTopCryptosResponse.fromBuffer(value));
  static final _$getMarketChart =
      $grpc.ClientMethod<$10.GetMarketChartRequest, $10.GetMarketChartResponse>(
          '/pb.CryptoService/GetMarketChart',
          ($10.GetMarketChartRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.GetMarketChartResponse.fromBuffer(value));
  static final _$getGlobalMarketData = $grpc.ClientMethod<
          $10.GetGlobalMarketDataRequest, $10.GetGlobalMarketDataResponse>(
      '/pb.CryptoService/GetGlobalMarketData',
      ($10.GetGlobalMarketDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetGlobalMarketDataResponse.fromBuffer(value));

  CryptoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.GetCryptosResponse> getCryptos(
      $10.GetCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetCryptoByIdResponse> getCryptoById(
      $10.GetCryptoByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoById, request, options: options);
  }

  $grpc.ResponseFuture<$10.SearchCryptosResponse> searchCryptos(
      $10.SearchCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetCryptoPriceHistoryResponse> getCryptoPriceHistory(
      $10.GetCryptoPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetTrendingCryptosResponse> getTrendingCryptos(
      $10.GetTrendingCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetTopCryptosResponse> getTopCryptos(
      $10.GetTopCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetMarketChartResponse> getMarketChart(
      $10.GetMarketChartRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketChart, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetGlobalMarketDataResponse> getGlobalMarketData(
      $10.GetGlobalMarketDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGlobalMarketData, request, options: options);
  }
}

abstract class CryptoServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CryptoService';

  CryptoServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$10.GetCryptosRequest, $10.GetCryptosResponse>(
            'GetCryptos',
            getCryptos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.GetCryptosRequest.fromBuffer(value),
            ($10.GetCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetCryptoByIdRequest,
            $10.GetCryptoByIdResponse>(
        'GetCryptoById',
        getCryptoById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetCryptoByIdRequest.fromBuffer(value),
        ($10.GetCryptoByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.SearchCryptosRequest,
            $10.SearchCryptosResponse>(
        'SearchCryptos',
        searchCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.SearchCryptosRequest.fromBuffer(value),
        ($10.SearchCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetCryptoPriceHistoryRequest,
            $10.GetCryptoPriceHistoryResponse>(
        'GetCryptoPriceHistory',
        getCryptoPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetCryptoPriceHistoryRequest.fromBuffer(value),
        ($10.GetCryptoPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetTrendingCryptosRequest,
            $10.GetTrendingCryptosResponse>(
        'GetTrendingCryptos',
        getTrendingCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetTrendingCryptosRequest.fromBuffer(value),
        ($10.GetTrendingCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetTopCryptosRequest,
            $10.GetTopCryptosResponse>(
        'GetTopCryptos',
        getTopCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetTopCryptosRequest.fromBuffer(value),
        ($10.GetTopCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetMarketChartRequest,
            $10.GetMarketChartResponse>(
        'GetMarketChart',
        getMarketChart_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetMarketChartRequest.fromBuffer(value),
        ($10.GetMarketChartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetGlobalMarketDataRequest,
            $10.GetGlobalMarketDataResponse>(
        'GetGlobalMarketData',
        getGlobalMarketData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetGlobalMarketDataRequest.fromBuffer(value),
        ($10.GetGlobalMarketDataResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.GetCryptosResponse> getCryptos_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetCryptosRequest> request) async {
    return getCryptos(call, await request);
  }

  $async.Future<$10.GetCryptoByIdResponse> getCryptoById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetCryptoByIdRequest> request) async {
    return getCryptoById(call, await request);
  }

  $async.Future<$10.SearchCryptosResponse> searchCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.SearchCryptosRequest> request) async {
    return searchCryptos(call, await request);
  }

  $async.Future<$10.GetCryptoPriceHistoryResponse> getCryptoPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetCryptoPriceHistoryRequest> request) async {
    return getCryptoPriceHistory(call, await request);
  }

  $async.Future<$10.GetTrendingCryptosResponse> getTrendingCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetTrendingCryptosRequest> request) async {
    return getTrendingCryptos(call, await request);
  }

  $async.Future<$10.GetTopCryptosResponse> getTopCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetTopCryptosRequest> request) async {
    return getTopCryptos(call, await request);
  }

  $async.Future<$10.GetMarketChartResponse> getMarketChart_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetMarketChartRequest> request) async {
    return getMarketChart(call, await request);
  }

  $async.Future<$10.GetGlobalMarketDataResponse> getGlobalMarketData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetGlobalMarketDataRequest> request) async {
    return getGlobalMarketData(call, await request);
  }

  $async.Future<$10.GetCryptosResponse> getCryptos(
      $grpc.ServiceCall call, $10.GetCryptosRequest request);
  $async.Future<$10.GetCryptoByIdResponse> getCryptoById(
      $grpc.ServiceCall call, $10.GetCryptoByIdRequest request);
  $async.Future<$10.SearchCryptosResponse> searchCryptos(
      $grpc.ServiceCall call, $10.SearchCryptosRequest request);
  $async.Future<$10.GetCryptoPriceHistoryResponse> getCryptoPriceHistory(
      $grpc.ServiceCall call, $10.GetCryptoPriceHistoryRequest request);
  $async.Future<$10.GetTrendingCryptosResponse> getTrendingCryptos(
      $grpc.ServiceCall call, $10.GetTrendingCryptosRequest request);
  $async.Future<$10.GetTopCryptosResponse> getTopCryptos(
      $grpc.ServiceCall call, $10.GetTopCryptosRequest request);
  $async.Future<$10.GetMarketChartResponse> getMarketChart(
      $grpc.ServiceCall call, $10.GetMarketChartRequest request);
  $async.Future<$10.GetGlobalMarketDataResponse> getGlobalMarketData(
      $grpc.ServiceCall call, $10.GetGlobalMarketDataRequest request);
}
