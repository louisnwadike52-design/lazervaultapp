///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crypto.pb.dart' as $0;
export 'crypto.pb.dart';

class CryptoServiceClient extends $grpc.Client {
  static final _$getCryptos =
      $grpc.ClientMethod<$0.GetCryptosRequest, $0.GetCryptosResponse>(
          '/pb.CryptoService/GetCryptos',
          ($0.GetCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCryptosResponse.fromBuffer(value));
  static final _$getCryptoById =
      $grpc.ClientMethod<$0.GetCryptoByIdRequest, $0.GetCryptoByIdResponse>(
          '/pb.CryptoService/GetCryptoById',
          ($0.GetCryptoByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCryptoByIdResponse.fromBuffer(value));
  static final _$searchCryptos =
      $grpc.ClientMethod<$0.SearchCryptosRequest, $0.SearchCryptosResponse>(
          '/pb.CryptoService/SearchCryptos',
          ($0.SearchCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SearchCryptosResponse.fromBuffer(value));
  static final _$getCryptoPriceHistory = $grpc.ClientMethod<
          $0.GetCryptoPriceHistoryRequest, $0.GetCryptoPriceHistoryResponse>(
      '/pb.CryptoService/GetCryptoPriceHistory',
      ($0.GetCryptoPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCryptoPriceHistoryResponse.fromBuffer(value));
  static final _$getTrendingCryptos = $grpc.ClientMethod<
          $0.GetTrendingCryptosRequest, $0.GetTrendingCryptosResponse>(
      '/pb.CryptoService/GetTrendingCryptos',
      ($0.GetTrendingCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTrendingCryptosResponse.fromBuffer(value));
  static final _$getTopCryptos =
      $grpc.ClientMethod<$0.GetTopCryptosRequest, $0.GetTopCryptosResponse>(
          '/pb.CryptoService/GetTopCryptos',
          ($0.GetTopCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTopCryptosResponse.fromBuffer(value));
  static final _$getMarketChart =
      $grpc.ClientMethod<$0.GetMarketChartRequest, $0.GetMarketChartResponse>(
          '/pb.CryptoService/GetMarketChart',
          ($0.GetMarketChartRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetMarketChartResponse.fromBuffer(value));
  static final _$getGlobalMarketData = $grpc.ClientMethod<
          $0.GetGlobalMarketDataRequest, $0.GetGlobalMarketDataResponse>(
      '/pb.CryptoService/GetGlobalMarketData',
      ($0.GetGlobalMarketDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetGlobalMarketDataResponse.fromBuffer(value));

  CryptoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetCryptosResponse> getCryptos(
      $0.GetCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoByIdResponse> getCryptoById(
      $0.GetCryptoByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoById, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchCryptosResponse> searchCryptos(
      $0.SearchCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoPriceHistoryResponse> getCryptoPriceHistory(
      $0.GetCryptoPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrendingCryptosResponse> getTrendingCryptos(
      $0.GetTrendingCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTopCryptosResponse> getTopCryptos(
      $0.GetTopCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketChartResponse> getMarketChart(
      $0.GetMarketChartRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketChart, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGlobalMarketDataResponse> getGlobalMarketData(
      $0.GetGlobalMarketDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGlobalMarketData, request, options: options);
  }
}

abstract class CryptoServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CryptoService';

  CryptoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetCryptosRequest, $0.GetCryptosResponse>(
        'GetCryptos',
        getCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCryptosRequest.fromBuffer(value),
        ($0.GetCryptosResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCryptoByIdRequest, $0.GetCryptoByIdResponse>(
            'GetCryptoById',
            getCryptoById_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCryptoByIdRequest.fromBuffer(value),
            ($0.GetCryptoByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchCryptosRequest, $0.SearchCryptosResponse>(
            'SearchCryptos',
            searchCryptos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SearchCryptosRequest.fromBuffer(value),
            ($0.SearchCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoPriceHistoryRequest,
            $0.GetCryptoPriceHistoryResponse>(
        'GetCryptoPriceHistory',
        getCryptoPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoPriceHistoryRequest.fromBuffer(value),
        ($0.GetCryptoPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrendingCryptosRequest,
            $0.GetTrendingCryptosResponse>(
        'GetTrendingCryptos',
        getTrendingCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTrendingCryptosRequest.fromBuffer(value),
        ($0.GetTrendingCryptosResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetTopCryptosRequest, $0.GetTopCryptosResponse>(
            'GetTopCryptos',
            getTopCryptos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTopCryptosRequest.fromBuffer(value),
            ($0.GetTopCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketChartRequest,
            $0.GetMarketChartResponse>(
        'GetMarketChart',
        getMarketChart_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketChartRequest.fromBuffer(value),
        ($0.GetMarketChartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGlobalMarketDataRequest,
            $0.GetGlobalMarketDataResponse>(
        'GetGlobalMarketData',
        getGlobalMarketData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGlobalMarketDataRequest.fromBuffer(value),
        ($0.GetGlobalMarketDataResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetCryptosResponse> getCryptos_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetCryptosRequest> request) async {
    return getCryptos(call, await request);
  }

  $async.Future<$0.GetCryptoByIdResponse> getCryptoById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoByIdRequest> request) async {
    return getCryptoById(call, await request);
  }

  $async.Future<$0.SearchCryptosResponse> searchCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchCryptosRequest> request) async {
    return searchCryptos(call, await request);
  }

  $async.Future<$0.GetCryptoPriceHistoryResponse> getCryptoPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoPriceHistoryRequest> request) async {
    return getCryptoPriceHistory(call, await request);
  }

  $async.Future<$0.GetTrendingCryptosResponse> getTrendingCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTrendingCryptosRequest> request) async {
    return getTrendingCryptos(call, await request);
  }

  $async.Future<$0.GetTopCryptosResponse> getTopCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTopCryptosRequest> request) async {
    return getTopCryptos(call, await request);
  }

  $async.Future<$0.GetMarketChartResponse> getMarketChart_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMarketChartRequest> request) async {
    return getMarketChart(call, await request);
  }

  $async.Future<$0.GetGlobalMarketDataResponse> getGlobalMarketData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGlobalMarketDataRequest> request) async {
    return getGlobalMarketData(call, await request);
  }

  $async.Future<$0.GetCryptosResponse> getCryptos(
      $grpc.ServiceCall call, $0.GetCryptosRequest request);
  $async.Future<$0.GetCryptoByIdResponse> getCryptoById(
      $grpc.ServiceCall call, $0.GetCryptoByIdRequest request);
  $async.Future<$0.SearchCryptosResponse> searchCryptos(
      $grpc.ServiceCall call, $0.SearchCryptosRequest request);
  $async.Future<$0.GetCryptoPriceHistoryResponse> getCryptoPriceHistory(
      $grpc.ServiceCall call, $0.GetCryptoPriceHistoryRequest request);
  $async.Future<$0.GetTrendingCryptosResponse> getTrendingCryptos(
      $grpc.ServiceCall call, $0.GetTrendingCryptosRequest request);
  $async.Future<$0.GetTopCryptosResponse> getTopCryptos(
      $grpc.ServiceCall call, $0.GetTopCryptosRequest request);
  $async.Future<$0.GetMarketChartResponse> getMarketChart(
      $grpc.ServiceCall call, $0.GetMarketChartRequest request);
  $async.Future<$0.GetGlobalMarketDataResponse> getGlobalMarketData(
      $grpc.ServiceCall call, $0.GetGlobalMarketDataRequest request);
}
