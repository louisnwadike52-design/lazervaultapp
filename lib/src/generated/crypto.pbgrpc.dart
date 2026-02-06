//
//  Generated code. Do not modify.
//  source: crypto.proto
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

import 'crypto.pb.dart' as $13;

export 'crypto.pb.dart';

@$pb.GrpcServiceName('pb.CryptoService')
class CryptoServiceClient extends $grpc.Client {
  static final _$getCryptos = $grpc.ClientMethod<$13.GetCryptosRequest, $13.GetCryptosResponse>(
      '/pb.CryptoService/GetCryptos',
      ($13.GetCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetCryptosResponse.fromBuffer(value));
  static final _$getCryptoById = $grpc.ClientMethod<$13.GetCryptoByIdRequest, $13.GetCryptoByIdResponse>(
      '/pb.CryptoService/GetCryptoById',
      ($13.GetCryptoByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetCryptoByIdResponse.fromBuffer(value));
  static final _$searchCryptos = $grpc.ClientMethod<$13.SearchCryptosRequest, $13.SearchCryptosResponse>(
      '/pb.CryptoService/SearchCryptos',
      ($13.SearchCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.SearchCryptosResponse.fromBuffer(value));
  static final _$getCryptoPriceHistory = $grpc.ClientMethod<$13.GetCryptoPriceHistoryRequest, $13.GetCryptoPriceHistoryResponse>(
      '/pb.CryptoService/GetCryptoPriceHistory',
      ($13.GetCryptoPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetCryptoPriceHistoryResponse.fromBuffer(value));
  static final _$getTrendingCryptos = $grpc.ClientMethod<$13.GetTrendingCryptosRequest, $13.GetTrendingCryptosResponse>(
      '/pb.CryptoService/GetTrendingCryptos',
      ($13.GetTrendingCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetTrendingCryptosResponse.fromBuffer(value));
  static final _$getTopCryptos = $grpc.ClientMethod<$13.GetTopCryptosRequest, $13.GetTopCryptosResponse>(
      '/pb.CryptoService/GetTopCryptos',
      ($13.GetTopCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetTopCryptosResponse.fromBuffer(value));
  static final _$getMarketChart = $grpc.ClientMethod<$13.GetMarketChartRequest, $13.GetMarketChartResponse>(
      '/pb.CryptoService/GetMarketChart',
      ($13.GetMarketChartRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetMarketChartResponse.fromBuffer(value));
  static final _$getGlobalMarketData = $grpc.ClientMethod<$13.GetGlobalMarketDataRequest, $13.GetGlobalMarketDataResponse>(
      '/pb.CryptoService/GetGlobalMarketData',
      ($13.GetGlobalMarketDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetGlobalMarketDataResponse.fromBuffer(value));
  static final _$getCryptoHoldings = $grpc.ClientMethod<$13.GetCryptoHoldingsRequest, $13.GetCryptoHoldingsResponse>(
      '/pb.CryptoService/GetCryptoHoldings',
      ($13.GetCryptoHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetCryptoHoldingsResponse.fromBuffer(value));
  static final _$getCryptoTransactions = $grpc.ClientMethod<$13.GetCryptoTransactionsRequest, $13.GetCryptoTransactionsResponse>(
      '/pb.CryptoService/GetCryptoTransactions',
      ($13.GetCryptoTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetCryptoTransactionsResponse.fromBuffer(value));
  static final _$buyCrypto = $grpc.ClientMethod<$13.BuyCryptoRequest, $13.BuyCryptoResponse>(
      '/pb.CryptoService/BuyCrypto',
      ($13.BuyCryptoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.BuyCryptoResponse.fromBuffer(value));
  static final _$sellCrypto = $grpc.ClientMethod<$13.SellCryptoRequest, $13.SellCryptoResponse>(
      '/pb.CryptoService/SellCrypto',
      ($13.SellCryptoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.SellCryptoResponse.fromBuffer(value));
  static final _$convertCrypto = $grpc.ClientMethod<$13.ConvertCryptoRequest, $13.ConvertCryptoResponse>(
      '/pb.CryptoService/ConvertCrypto',
      ($13.ConvertCryptoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.ConvertCryptoResponse.fromBuffer(value));
  static final _$getWallets = $grpc.ClientMethod<$13.GetWalletsRequest, $13.GetWalletsResponse>(
      '/pb.CryptoService/GetWallets',
      ($13.GetWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetWalletsResponse.fromBuffer(value));
  static final _$createWallet = $grpc.ClientMethod<$13.CreateWalletRequest, $13.CreateWalletResponse>(
      '/pb.CryptoService/CreateWallet',
      ($13.CreateWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.CreateWalletResponse.fromBuffer(value));
  static final _$getWalletBalance = $grpc.ClientMethod<$13.GetWalletBalanceRequest, $13.GetWalletBalanceResponse>(
      '/pb.CryptoService/GetWalletBalance',
      ($13.GetWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.GetWalletBalanceResponse.fromBuffer(value));

  CryptoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$13.GetCryptosResponse> getCryptos($13.GetCryptosRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetCryptoByIdResponse> getCryptoById($13.GetCryptoByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoById, request, options: options);
  }

  $grpc.ResponseFuture<$13.SearchCryptosResponse> searchCryptos($13.SearchCryptosRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetCryptoPriceHistoryResponse> getCryptoPriceHistory($13.GetCryptoPriceHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetTrendingCryptosResponse> getTrendingCryptos($13.GetTrendingCryptosRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetTopCryptosResponse> getTopCryptos($13.GetTopCryptosRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetMarketChartResponse> getMarketChart($13.GetMarketChartRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketChart, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetGlobalMarketDataResponse> getGlobalMarketData($13.GetGlobalMarketDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGlobalMarketData, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetCryptoHoldingsResponse> getCryptoHoldings($13.GetCryptoHoldingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetCryptoTransactionsResponse> getCryptoTransactions($13.GetCryptoTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$13.BuyCryptoResponse> buyCrypto($13.BuyCryptoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$13.SellCryptoResponse> sellCrypto($13.SellCryptoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$13.ConvertCryptoResponse> convertCrypto($13.ConvertCryptoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetWalletsResponse> getWallets($13.GetWalletsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWallets, request, options: options);
  }

  $grpc.ResponseFuture<$13.CreateWalletResponse> createWallet($13.CreateWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWallet, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetWalletBalanceResponse> getWalletBalance($13.GetWalletBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletBalance, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.CryptoService')
abstract class CryptoServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CryptoService';

  CryptoServiceBase() {
    $addMethod($grpc.ServiceMethod<$13.GetCryptosRequest, $13.GetCryptosResponse>(
        'GetCryptos',
        getCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetCryptosRequest.fromBuffer(value),
        ($13.GetCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetCryptoByIdRequest, $13.GetCryptoByIdResponse>(
        'GetCryptoById',
        getCryptoById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetCryptoByIdRequest.fromBuffer(value),
        ($13.GetCryptoByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.SearchCryptosRequest, $13.SearchCryptosResponse>(
        'SearchCryptos',
        searchCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.SearchCryptosRequest.fromBuffer(value),
        ($13.SearchCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetCryptoPriceHistoryRequest, $13.GetCryptoPriceHistoryResponse>(
        'GetCryptoPriceHistory',
        getCryptoPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetCryptoPriceHistoryRequest.fromBuffer(value),
        ($13.GetCryptoPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetTrendingCryptosRequest, $13.GetTrendingCryptosResponse>(
        'GetTrendingCryptos',
        getTrendingCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetTrendingCryptosRequest.fromBuffer(value),
        ($13.GetTrendingCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetTopCryptosRequest, $13.GetTopCryptosResponse>(
        'GetTopCryptos',
        getTopCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetTopCryptosRequest.fromBuffer(value),
        ($13.GetTopCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetMarketChartRequest, $13.GetMarketChartResponse>(
        'GetMarketChart',
        getMarketChart_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetMarketChartRequest.fromBuffer(value),
        ($13.GetMarketChartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetGlobalMarketDataRequest, $13.GetGlobalMarketDataResponse>(
        'GetGlobalMarketData',
        getGlobalMarketData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetGlobalMarketDataRequest.fromBuffer(value),
        ($13.GetGlobalMarketDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetCryptoHoldingsRequest, $13.GetCryptoHoldingsResponse>(
        'GetCryptoHoldings',
        getCryptoHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetCryptoHoldingsRequest.fromBuffer(value),
        ($13.GetCryptoHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetCryptoTransactionsRequest, $13.GetCryptoTransactionsResponse>(
        'GetCryptoTransactions',
        getCryptoTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetCryptoTransactionsRequest.fromBuffer(value),
        ($13.GetCryptoTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.BuyCryptoRequest, $13.BuyCryptoResponse>(
        'BuyCrypto',
        buyCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.BuyCryptoRequest.fromBuffer(value),
        ($13.BuyCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.SellCryptoRequest, $13.SellCryptoResponse>(
        'SellCrypto',
        sellCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.SellCryptoRequest.fromBuffer(value),
        ($13.SellCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.ConvertCryptoRequest, $13.ConvertCryptoResponse>(
        'ConvertCrypto',
        convertCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.ConvertCryptoRequest.fromBuffer(value),
        ($13.ConvertCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetWalletsRequest, $13.GetWalletsResponse>(
        'GetWallets',
        getWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetWalletsRequest.fromBuffer(value),
        ($13.GetWalletsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.CreateWalletRequest, $13.CreateWalletResponse>(
        'CreateWallet',
        createWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.CreateWalletRequest.fromBuffer(value),
        ($13.CreateWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetWalletBalanceRequest, $13.GetWalletBalanceResponse>(
        'GetWalletBalance',
        getWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetWalletBalanceRequest.fromBuffer(value),
        ($13.GetWalletBalanceResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.GetCryptosResponse> getCryptos_Pre($grpc.ServiceCall call, $async.Future<$13.GetCryptosRequest> request) async {
    return getCryptos(call, await request);
  }

  $async.Future<$13.GetCryptoByIdResponse> getCryptoById_Pre($grpc.ServiceCall call, $async.Future<$13.GetCryptoByIdRequest> request) async {
    return getCryptoById(call, await request);
  }

  $async.Future<$13.SearchCryptosResponse> searchCryptos_Pre($grpc.ServiceCall call, $async.Future<$13.SearchCryptosRequest> request) async {
    return searchCryptos(call, await request);
  }

  $async.Future<$13.GetCryptoPriceHistoryResponse> getCryptoPriceHistory_Pre($grpc.ServiceCall call, $async.Future<$13.GetCryptoPriceHistoryRequest> request) async {
    return getCryptoPriceHistory(call, await request);
  }

  $async.Future<$13.GetTrendingCryptosResponse> getTrendingCryptos_Pre($grpc.ServiceCall call, $async.Future<$13.GetTrendingCryptosRequest> request) async {
    return getTrendingCryptos(call, await request);
  }

  $async.Future<$13.GetTopCryptosResponse> getTopCryptos_Pre($grpc.ServiceCall call, $async.Future<$13.GetTopCryptosRequest> request) async {
    return getTopCryptos(call, await request);
  }

  $async.Future<$13.GetMarketChartResponse> getMarketChart_Pre($grpc.ServiceCall call, $async.Future<$13.GetMarketChartRequest> request) async {
    return getMarketChart(call, await request);
  }

  $async.Future<$13.GetGlobalMarketDataResponse> getGlobalMarketData_Pre($grpc.ServiceCall call, $async.Future<$13.GetGlobalMarketDataRequest> request) async {
    return getGlobalMarketData(call, await request);
  }

  $async.Future<$13.GetCryptoHoldingsResponse> getCryptoHoldings_Pre($grpc.ServiceCall call, $async.Future<$13.GetCryptoHoldingsRequest> request) async {
    return getCryptoHoldings(call, await request);
  }

  $async.Future<$13.GetCryptoTransactionsResponse> getCryptoTransactions_Pre($grpc.ServiceCall call, $async.Future<$13.GetCryptoTransactionsRequest> request) async {
    return getCryptoTransactions(call, await request);
  }

  $async.Future<$13.BuyCryptoResponse> buyCrypto_Pre($grpc.ServiceCall call, $async.Future<$13.BuyCryptoRequest> request) async {
    return buyCrypto(call, await request);
  }

  $async.Future<$13.SellCryptoResponse> sellCrypto_Pre($grpc.ServiceCall call, $async.Future<$13.SellCryptoRequest> request) async {
    return sellCrypto(call, await request);
  }

  $async.Future<$13.ConvertCryptoResponse> convertCrypto_Pre($grpc.ServiceCall call, $async.Future<$13.ConvertCryptoRequest> request) async {
    return convertCrypto(call, await request);
  }

  $async.Future<$13.GetWalletsResponse> getWallets_Pre($grpc.ServiceCall call, $async.Future<$13.GetWalletsRequest> request) async {
    return getWallets(call, await request);
  }

  $async.Future<$13.CreateWalletResponse> createWallet_Pre($grpc.ServiceCall call, $async.Future<$13.CreateWalletRequest> request) async {
    return createWallet(call, await request);
  }

  $async.Future<$13.GetWalletBalanceResponse> getWalletBalance_Pre($grpc.ServiceCall call, $async.Future<$13.GetWalletBalanceRequest> request) async {
    return getWalletBalance(call, await request);
  }

  $async.Future<$13.GetCryptosResponse> getCryptos($grpc.ServiceCall call, $13.GetCryptosRequest request);
  $async.Future<$13.GetCryptoByIdResponse> getCryptoById($grpc.ServiceCall call, $13.GetCryptoByIdRequest request);
  $async.Future<$13.SearchCryptosResponse> searchCryptos($grpc.ServiceCall call, $13.SearchCryptosRequest request);
  $async.Future<$13.GetCryptoPriceHistoryResponse> getCryptoPriceHistory($grpc.ServiceCall call, $13.GetCryptoPriceHistoryRequest request);
  $async.Future<$13.GetTrendingCryptosResponse> getTrendingCryptos($grpc.ServiceCall call, $13.GetTrendingCryptosRequest request);
  $async.Future<$13.GetTopCryptosResponse> getTopCryptos($grpc.ServiceCall call, $13.GetTopCryptosRequest request);
  $async.Future<$13.GetMarketChartResponse> getMarketChart($grpc.ServiceCall call, $13.GetMarketChartRequest request);
  $async.Future<$13.GetGlobalMarketDataResponse> getGlobalMarketData($grpc.ServiceCall call, $13.GetGlobalMarketDataRequest request);
  $async.Future<$13.GetCryptoHoldingsResponse> getCryptoHoldings($grpc.ServiceCall call, $13.GetCryptoHoldingsRequest request);
  $async.Future<$13.GetCryptoTransactionsResponse> getCryptoTransactions($grpc.ServiceCall call, $13.GetCryptoTransactionsRequest request);
  $async.Future<$13.BuyCryptoResponse> buyCrypto($grpc.ServiceCall call, $13.BuyCryptoRequest request);
  $async.Future<$13.SellCryptoResponse> sellCrypto($grpc.ServiceCall call, $13.SellCryptoRequest request);
  $async.Future<$13.ConvertCryptoResponse> convertCrypto($grpc.ServiceCall call, $13.ConvertCryptoRequest request);
  $async.Future<$13.GetWalletsResponse> getWallets($grpc.ServiceCall call, $13.GetWalletsRequest request);
  $async.Future<$13.CreateWalletResponse> createWallet($grpc.ServiceCall call, $13.CreateWalletRequest request);
  $async.Future<$13.GetWalletBalanceResponse> getWalletBalance($grpc.ServiceCall call, $13.GetWalletBalanceRequest request);
}
