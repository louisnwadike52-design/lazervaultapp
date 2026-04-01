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
  static final _$getSupportedAssets = $grpc.ClientMethod<
          $0.GetSupportedAssetsRequest, $0.GetSupportedAssetsResponse>(
      '/pb.CryptoService/GetSupportedAssets',
      ($0.GetSupportedAssetsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSupportedAssetsResponse.fromBuffer(value));
  static final _$getCryptoFiatRate = $grpc.ClientMethod<
          $0.GetCryptoFiatRateRequest, $0.GetCryptoFiatRateResponse>(
      '/pb.CryptoService/GetCryptoFiatRate',
      ($0.GetCryptoFiatRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCryptoFiatRateResponse.fromBuffer(value));
  static final _$getCryptoHoldings = $grpc.ClientMethod<
          $0.GetCryptoHoldingsRequest, $0.GetCryptoHoldingsResponse>(
      '/pb.CryptoService/GetCryptoHoldings',
      ($0.GetCryptoHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCryptoHoldingsResponse.fromBuffer(value));
  static final _$getCryptoTransactions = $grpc.ClientMethod<
          $0.GetCryptoTransactionsRequest, $0.GetCryptoTransactionsResponse>(
      '/pb.CryptoService/GetCryptoTransactions',
      ($0.GetCryptoTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCryptoTransactionsResponse.fromBuffer(value));
  static final _$buyCrypto =
      $grpc.ClientMethod<$0.BuyCryptoRequest, $0.BuyCryptoResponse>(
          '/pb.CryptoService/BuyCrypto',
          ($0.BuyCryptoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyCryptoResponse.fromBuffer(value));
  static final _$sellCrypto =
      $grpc.ClientMethod<$0.SellCryptoRequest, $0.SellCryptoResponse>(
          '/pb.CryptoService/SellCrypto',
          ($0.SellCryptoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SellCryptoResponse.fromBuffer(value));
  static final _$convertCrypto =
      $grpc.ClientMethod<$0.ConvertCryptoRequest, $0.ConvertCryptoResponse>(
          '/pb.CryptoService/ConvertCrypto',
          ($0.ConvertCryptoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ConvertCryptoResponse.fromBuffer(value));
  static final _$getWallets =
      $grpc.ClientMethod<$0.GetWalletsRequest, $0.GetWalletsResponse>(
          '/pb.CryptoService/GetWallets',
          ($0.GetWalletsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetWalletsResponse.fromBuffer(value));
  static final _$createWallet =
      $grpc.ClientMethod<$0.CreateWalletRequest, $0.CreateWalletResponse>(
          '/pb.CryptoService/CreateWallet',
          ($0.CreateWalletRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateWalletResponse.fromBuffer(value));
  static final _$getWalletBalance = $grpc.ClientMethod<
          $0.GetWalletBalanceRequest, $0.GetWalletBalanceResponse>(
      '/pb.CryptoService/GetWalletBalance',
      ($0.GetWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWalletBalanceResponse.fromBuffer(value));
  static final _$batchCreateWallets = $grpc.ClientMethod<
          $0.BatchCreateWalletsRequest, $0.BatchCreateWalletsResponse>(
      '/pb.CryptoService/BatchCreateWallets',
      ($0.BatchCreateWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.BatchCreateWalletsResponse.fromBuffer(value));
  static final _$createWatchlist =
      $grpc.ClientMethod<$0.CreateWatchlistRequest, $0.CreateWatchlistResponse>(
          '/pb.CryptoService/CreateWatchlist',
          ($0.CreateWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateWatchlistResponse.fromBuffer(value));
  static final _$getWatchlists =
      $grpc.ClientMethod<$0.GetWatchlistsRequest, $0.GetWatchlistsResponse>(
          '/pb.CryptoService/GetWatchlists',
          ($0.GetWatchlistsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetWatchlistsResponse.fromBuffer(value));
  static final _$addToWatchlist =
      $grpc.ClientMethod<$0.AddToWatchlistRequest, $0.AddToWatchlistResponse>(
          '/pb.CryptoService/AddToWatchlist',
          ($0.AddToWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddToWatchlistResponse.fromBuffer(value));
  static final _$removeFromWatchlist = $grpc.ClientMethod<
          $0.RemoveFromWatchlistRequest, $0.RemoveFromWatchlistResponse>(
      '/pb.CryptoService/RemoveFromWatchlist',
      ($0.RemoveFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RemoveFromWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist =
      $grpc.ClientMethod<$0.DeleteWatchlistRequest, $0.DeleteWatchlistResponse>(
          '/pb.CryptoService/DeleteWatchlist',
          ($0.DeleteWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteWatchlistResponse.fromBuffer(value));
  static final _$toggleFavorite =
      $grpc.ClientMethod<$0.ToggleFavoriteRequest, $0.ToggleFavoriteResponse>(
          '/pb.CryptoService/ToggleFavorite',
          ($0.ToggleFavoriteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ToggleFavoriteResponse.fromBuffer(value));
  static final _$getCryptoNews =
      $grpc.ClientMethod<$0.GetCryptoNewsRequest, $0.GetCryptoNewsResponse>(
          '/pb.CryptoService/GetCryptoNews',
          ($0.GetCryptoNewsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCryptoNewsResponse.fromBuffer(value));
  static final _$getOHLCV =
      $grpc.ClientMethod<$0.GetOHLCVRequest, $0.GetOHLCVResponse>(
          '/pb.CryptoService/GetOHLCV',
          ($0.GetOHLCVRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetOHLCVResponse.fromBuffer(value));
  static final _$getOrderBook =
      $grpc.ClientMethod<$0.GetOrderBookRequest, $0.GetOrderBookResponse>(
          '/pb.CryptoService/GetOrderBook',
          ($0.GetOrderBookRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetOrderBookResponse.fromBuffer(value));
  static final _$getRecentTrades =
      $grpc.ClientMethod<$0.GetRecentTradesRequest, $0.GetRecentTradesResponse>(
          '/pb.CryptoService/GetRecentTrades',
          ($0.GetRecentTradesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetRecentTradesResponse.fromBuffer(value));
  static final _$getFearGreedIndex = $grpc.ClientMethod<
          $0.GetFearGreedIndexRequest, $0.GetFearGreedIndexResponse>(
      '/pb.CryptoService/GetFearGreedIndex',
      ($0.GetFearGreedIndexRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetFearGreedIndexResponse.fromBuffer(value));
  static final _$createPriceAlert = $grpc.ClientMethod<
          $0.CreatePriceAlertRequest, $0.CreatePriceAlertResponse>(
      '/pb.CryptoService/CreatePriceAlert',
      ($0.CreatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreatePriceAlertResponse.fromBuffer(value));
  static final _$getPriceAlerts =
      $grpc.ClientMethod<$0.GetPriceAlertsRequest, $0.GetPriceAlertsResponse>(
          '/pb.CryptoService/GetPriceAlerts',
          ($0.GetPriceAlertsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetPriceAlertsResponse.fromBuffer(value));
  static final _$deletePriceAlert = $grpc.ClientMethod<
          $0.DeletePriceAlertRequest, $0.DeletePriceAlertResponse>(
      '/pb.CryptoService/DeletePriceAlert',
      ($0.DeletePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeletePriceAlertResponse.fromBuffer(value));
  static final _$getPlatformCryptoPortfolio = $grpc.ClientMethod<
          $0.GetPlatformCryptoPortfolioRequest,
          $0.GetPlatformCryptoPortfolioResponse>(
      '/pb.CryptoService/GetPlatformCryptoPortfolio',
      ($0.GetPlatformCryptoPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPlatformCryptoPortfolioResponse.fromBuffer(value));
  static final _$getPlatformCryptoTransactions = $grpc.ClientMethod<
          $0.GetPlatformCryptoTransactionsRequest,
          $0.GetPlatformCryptoTransactionsResponse>(
      '/pb.CryptoService/GetPlatformCryptoTransactions',
      ($0.GetPlatformCryptoTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPlatformCryptoTransactionsResponse.fromBuffer(value));
  static final _$getFeeTiers =
      $grpc.ClientMethod<$0.GetFeeTiersRequest, $0.GetFeeTiersResponse>(
          '/pb.CryptoService/GetFeeTiers',
          ($0.GetFeeTiersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetFeeTiersResponse.fromBuffer(value));
  static final _$createFeeTier =
      $grpc.ClientMethod<$0.CreateFeeTierRequest, $0.CreateFeeTierResponse>(
          '/pb.CryptoService/CreateFeeTier',
          ($0.CreateFeeTierRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateFeeTierResponse.fromBuffer(value));
  static final _$updateFeeTier =
      $grpc.ClientMethod<$0.UpdateFeeTierRequest, $0.UpdateFeeTierResponse>(
          '/pb.CryptoService/UpdateFeeTier',
          ($0.UpdateFeeTierRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateFeeTierResponse.fromBuffer(value));
  static final _$deleteFeeTier =
      $grpc.ClientMethod<$0.DeleteFeeTierRequest, $0.DeleteFeeTierResponse>(
          '/pb.CryptoService/DeleteFeeTier',
          ($0.DeleteFeeTierRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteFeeTierResponse.fromBuffer(value));
  static final _$runReconciliation =
      $grpc.ClientMethod<$0.RunReconciliationRequest, $0.ReconciliationResult>(
          '/pb.CryptoService/RunReconciliation',
          ($0.RunReconciliationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ReconciliationResult.fromBuffer(value));
  static final _$getReconciliationLogs = $grpc.ClientMethod<
          $0.GetReconciliationLogsRequest, $0.GetReconciliationLogsResponse>(
      '/pb.CryptoService/GetReconciliationLogs',
      ($0.GetReconciliationLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetReconciliationLogsResponse.fromBuffer(value));

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

  $grpc.ResponseFuture<$0.GetSupportedAssetsResponse> getSupportedAssets(
      $0.GetSupportedAssetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedAssets, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoFiatRateResponse> getCryptoFiatRate(
      $0.GetCryptoFiatRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoFiatRate, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoHoldingsResponse> getCryptoHoldings(
      $0.GetCryptoHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoTransactionsResponse> getCryptoTransactions(
      $0.GetCryptoTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyCryptoResponse> buyCrypto(
      $0.BuyCryptoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$0.SellCryptoResponse> sellCrypto(
      $0.SellCryptoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConvertCryptoResponse> convertCrypto(
      $0.ConvertCryptoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWalletsResponse> getWallets(
      $0.GetWalletsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWallets, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateWalletResponse> createWallet(
      $0.CreateWalletRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWalletBalanceResponse> getWalletBalance(
      $0.GetWalletBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchCreateWalletsResponse> batchCreateWallets(
      $0.BatchCreateWalletsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchCreateWallets, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateWatchlistResponse> createWatchlist(
      $0.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWatchlistsResponse> getWatchlists(
      $0.GetWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddToWatchlistResponse> addToWatchlist(
      $0.AddToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveFromWatchlistResponse> removeFromWatchlist(
      $0.RemoveFromWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFromWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteWatchlistResponse> deleteWatchlist(
      $0.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.ToggleFavoriteResponse> toggleFavorite(
      $0.ToggleFavoriteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleFavorite, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoNewsResponse> getCryptoNews(
      $0.GetCryptoNewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoNews, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOHLCVResponse> getOHLCV($0.GetOHLCVRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOHLCV, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderBookResponse> getOrderBook(
      $0.GetOrderBookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderBook, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRecentTradesResponse> getRecentTrades(
      $0.GetRecentTradesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentTrades, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFearGreedIndexResponse> getFearGreedIndex(
      $0.GetFearGreedIndexRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFearGreedIndex, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreatePriceAlertResponse> createPriceAlert(
      $0.CreatePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPriceAlertsResponse> getPriceAlerts(
      $0.GetPriceAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPriceAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeletePriceAlertResponse> deletePriceAlert(
      $0.DeletePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPlatformCryptoPortfolioResponse>
      getPlatformCryptoPortfolio($0.GetPlatformCryptoPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlatformCryptoPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetPlatformCryptoTransactionsResponse>
      getPlatformCryptoTransactions(
          $0.GetPlatformCryptoTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlatformCryptoTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetFeeTiersResponse> getFeeTiers(
      $0.GetFeeTiersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFeeTiers, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateFeeTierResponse> createFeeTier(
      $0.CreateFeeTierRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFeeTier, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateFeeTierResponse> updateFeeTier(
      $0.UpdateFeeTierRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFeeTier, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteFeeTierResponse> deleteFeeTier(
      $0.DeleteFeeTierRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFeeTier, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReconciliationResult> runReconciliation(
      $0.RunReconciliationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runReconciliation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetReconciliationLogsResponse> getReconciliationLogs(
      $0.GetReconciliationLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationLogs, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.GetSupportedAssetsRequest,
            $0.GetSupportedAssetsResponse>(
        'GetSupportedAssets',
        getSupportedAssets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedAssetsRequest.fromBuffer(value),
        ($0.GetSupportedAssetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoFiatRateRequest,
            $0.GetCryptoFiatRateResponse>(
        'GetCryptoFiatRate',
        getCryptoFiatRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoFiatRateRequest.fromBuffer(value),
        ($0.GetCryptoFiatRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoHoldingsRequest,
            $0.GetCryptoHoldingsResponse>(
        'GetCryptoHoldings',
        getCryptoHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoHoldingsRequest.fromBuffer(value),
        ($0.GetCryptoHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoTransactionsRequest,
            $0.GetCryptoTransactionsResponse>(
        'GetCryptoTransactions',
        getCryptoTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoTransactionsRequest.fromBuffer(value),
        ($0.GetCryptoTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyCryptoRequest, $0.BuyCryptoResponse>(
        'BuyCrypto',
        buyCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyCryptoRequest.fromBuffer(value),
        ($0.BuyCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SellCryptoRequest, $0.SellCryptoResponse>(
        'SellCrypto',
        sellCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SellCryptoRequest.fromBuffer(value),
        ($0.SellCryptoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ConvertCryptoRequest, $0.ConvertCryptoResponse>(
            'ConvertCrypto',
            convertCrypto_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ConvertCryptoRequest.fromBuffer(value),
            ($0.ConvertCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWalletsRequest, $0.GetWalletsResponse>(
        'GetWallets',
        getWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetWalletsRequest.fromBuffer(value),
        ($0.GetWalletsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CreateWalletRequest, $0.CreateWalletResponse>(
            'CreateWallet',
            createWallet_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateWalletRequest.fromBuffer(value),
            ($0.CreateWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWalletBalanceRequest,
            $0.GetWalletBalanceResponse>(
        'GetWalletBalance',
        getWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWalletBalanceRequest.fromBuffer(value),
        ($0.GetWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchCreateWalletsRequest,
            $0.BatchCreateWalletsResponse>(
        'BatchCreateWallets',
        batchCreateWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BatchCreateWalletsRequest.fromBuffer(value),
        ($0.BatchCreateWalletsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateWatchlistRequest,
            $0.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateWatchlistRequest.fromBuffer(value),
        ($0.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetWatchlistsRequest, $0.GetWatchlistsResponse>(
            'GetWatchlists',
            getWatchlists_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetWatchlistsRequest.fromBuffer(value),
            ($0.GetWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddToWatchlistRequest,
            $0.AddToWatchlistResponse>(
        'AddToWatchlist',
        addToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddToWatchlistRequest.fromBuffer(value),
        ($0.AddToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveFromWatchlistRequest,
            $0.RemoveFromWatchlistResponse>(
        'RemoveFromWatchlist',
        removeFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveFromWatchlistRequest.fromBuffer(value),
        ($0.RemoveFromWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteWatchlistRequest,
            $0.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteWatchlistRequest.fromBuffer(value),
        ($0.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ToggleFavoriteRequest,
            $0.ToggleFavoriteResponse>(
        'ToggleFavorite',
        toggleFavorite_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ToggleFavoriteRequest.fromBuffer(value),
        ($0.ToggleFavoriteResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCryptoNewsRequest, $0.GetCryptoNewsResponse>(
            'GetCryptoNews',
            getCryptoNews_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCryptoNewsRequest.fromBuffer(value),
            ($0.GetCryptoNewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOHLCVRequest, $0.GetOHLCVResponse>(
        'GetOHLCV',
        getOHLCV_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOHLCVRequest.fromBuffer(value),
        ($0.GetOHLCVResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetOrderBookRequest, $0.GetOrderBookResponse>(
            'GetOrderBook',
            getOrderBook_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOrderBookRequest.fromBuffer(value),
            ($0.GetOrderBookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecentTradesRequest,
            $0.GetRecentTradesResponse>(
        'GetRecentTrades',
        getRecentTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecentTradesRequest.fromBuffer(value),
        ($0.GetRecentTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFearGreedIndexRequest,
            $0.GetFearGreedIndexResponse>(
        'GetFearGreedIndex',
        getFearGreedIndex_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFearGreedIndexRequest.fromBuffer(value),
        ($0.GetFearGreedIndexResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreatePriceAlertRequest,
            $0.CreatePriceAlertResponse>(
        'CreatePriceAlert',
        createPriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreatePriceAlertRequest.fromBuffer(value),
        ($0.CreatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPriceAlertsRequest,
            $0.GetPriceAlertsResponse>(
        'GetPriceAlerts',
        getPriceAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPriceAlertsRequest.fromBuffer(value),
        ($0.GetPriceAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeletePriceAlertRequest,
            $0.DeletePriceAlertResponse>(
        'DeletePriceAlert',
        deletePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeletePriceAlertRequest.fromBuffer(value),
        ($0.DeletePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPlatformCryptoPortfolioRequest,
            $0.GetPlatformCryptoPortfolioResponse>(
        'GetPlatformCryptoPortfolio',
        getPlatformCryptoPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPlatformCryptoPortfolioRequest.fromBuffer(value),
        ($0.GetPlatformCryptoPortfolioResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPlatformCryptoTransactionsRequest,
            $0.GetPlatformCryptoTransactionsResponse>(
        'GetPlatformCryptoTransactions',
        getPlatformCryptoTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPlatformCryptoTransactionsRequest.fromBuffer(value),
        ($0.GetPlatformCryptoTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetFeeTiersRequest, $0.GetFeeTiersResponse>(
            'GetFeeTiers',
            getFeeTiers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetFeeTiersRequest.fromBuffer(value),
            ($0.GetFeeTiersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CreateFeeTierRequest, $0.CreateFeeTierResponse>(
            'CreateFeeTier',
            createFeeTier_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateFeeTierRequest.fromBuffer(value),
            ($0.CreateFeeTierResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UpdateFeeTierRequest, $0.UpdateFeeTierResponse>(
            'UpdateFeeTier',
            updateFeeTier_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateFeeTierRequest.fromBuffer(value),
            ($0.UpdateFeeTierResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DeleteFeeTierRequest, $0.DeleteFeeTierResponse>(
            'DeleteFeeTier',
            deleteFeeTier_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DeleteFeeTierRequest.fromBuffer(value),
            ($0.DeleteFeeTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RunReconciliationRequest,
            $0.ReconciliationResult>(
        'RunReconciliation',
        runReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RunReconciliationRequest.fromBuffer(value),
        ($0.ReconciliationResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReconciliationLogsRequest,
            $0.GetReconciliationLogsResponse>(
        'GetReconciliationLogs',
        getReconciliationLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetReconciliationLogsRequest.fromBuffer(value),
        ($0.GetReconciliationLogsResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.GetSupportedAssetsResponse> getSupportedAssets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSupportedAssetsRequest> request) async {
    return getSupportedAssets(call, await request);
  }

  $async.Future<$0.GetCryptoFiatRateResponse> getCryptoFiatRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoFiatRateRequest> request) async {
    return getCryptoFiatRate(call, await request);
  }

  $async.Future<$0.GetCryptoHoldingsResponse> getCryptoHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoHoldingsRequest> request) async {
    return getCryptoHoldings(call, await request);
  }

  $async.Future<$0.GetCryptoTransactionsResponse> getCryptoTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoTransactionsRequest> request) async {
    return getCryptoTransactions(call, await request);
  }

  $async.Future<$0.BuyCryptoResponse> buyCrypto_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyCryptoRequest> request) async {
    return buyCrypto(call, await request);
  }

  $async.Future<$0.SellCryptoResponse> sellCrypto_Pre($grpc.ServiceCall call,
      $async.Future<$0.SellCryptoRequest> request) async {
    return sellCrypto(call, await request);
  }

  $async.Future<$0.ConvertCryptoResponse> convertCrypto_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ConvertCryptoRequest> request) async {
    return convertCrypto(call, await request);
  }

  $async.Future<$0.GetWalletsResponse> getWallets_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetWalletsRequest> request) async {
    return getWallets(call, await request);
  }

  $async.Future<$0.CreateWalletResponse> createWallet_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateWalletRequest> request) async {
    return createWallet(call, await request);
  }

  $async.Future<$0.GetWalletBalanceResponse> getWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWalletBalanceRequest> request) async {
    return getWalletBalance(call, await request);
  }

  $async.Future<$0.BatchCreateWalletsResponse> batchCreateWallets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.BatchCreateWalletsRequest> request) async {
    return batchCreateWallets(call, await request);
  }

  $async.Future<$0.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$0.GetWatchlistsResponse> getWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWatchlistsRequest> request) async {
    return getWatchlists(call, await request);
  }

  $async.Future<$0.AddToWatchlistResponse> addToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AddToWatchlistRequest> request) async {
    return addToWatchlist(call, await request);
  }

  $async.Future<$0.RemoveFromWatchlistResponse> removeFromWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RemoveFromWatchlistRequest> request) async {
    return removeFromWatchlist(call, await request);
  }

  $async.Future<$0.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$0.ToggleFavoriteResponse> toggleFavorite_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ToggleFavoriteRequest> request) async {
    return toggleFavorite(call, await request);
  }

  $async.Future<$0.GetCryptoNewsResponse> getCryptoNews_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoNewsRequest> request) async {
    return getCryptoNews(call, await request);
  }

  $async.Future<$0.GetOHLCVResponse> getOHLCV_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetOHLCVRequest> request) async {
    return getOHLCV(call, await request);
  }

  $async.Future<$0.GetOrderBookResponse> getOrderBook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetOrderBookRequest> request) async {
    return getOrderBook(call, await request);
  }

  $async.Future<$0.GetRecentTradesResponse> getRecentTrades_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetRecentTradesRequest> request) async {
    return getRecentTrades(call, await request);
  }

  $async.Future<$0.GetFearGreedIndexResponse> getFearGreedIndex_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFearGreedIndexRequest> request) async {
    return getFearGreedIndex(call, await request);
  }

  $async.Future<$0.CreatePriceAlertResponse> createPriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreatePriceAlertRequest> request) async {
    return createPriceAlert(call, await request);
  }

  $async.Future<$0.GetPriceAlertsResponse> getPriceAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPriceAlertsRequest> request) async {
    return getPriceAlerts(call, await request);
  }

  $async.Future<$0.DeletePriceAlertResponse> deletePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeletePriceAlertRequest> request) async {
    return deletePriceAlert(call, await request);
  }

  $async.Future<$0.GetPlatformCryptoPortfolioResponse>
      getPlatformCryptoPortfolio_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetPlatformCryptoPortfolioRequest> request) async {
    return getPlatformCryptoPortfolio(call, await request);
  }

  $async.Future<$0.GetPlatformCryptoTransactionsResponse>
      getPlatformCryptoTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetPlatformCryptoTransactionsRequest>
              request) async {
    return getPlatformCryptoTransactions(call, await request);
  }

  $async.Future<$0.GetFeeTiersResponse> getFeeTiers_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetFeeTiersRequest> request) async {
    return getFeeTiers(call, await request);
  }

  $async.Future<$0.CreateFeeTierResponse> createFeeTier_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateFeeTierRequest> request) async {
    return createFeeTier(call, await request);
  }

  $async.Future<$0.UpdateFeeTierResponse> updateFeeTier_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateFeeTierRequest> request) async {
    return updateFeeTier(call, await request);
  }

  $async.Future<$0.DeleteFeeTierResponse> deleteFeeTier_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteFeeTierRequest> request) async {
    return deleteFeeTier(call, await request);
  }

  $async.Future<$0.ReconciliationResult> runReconciliation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RunReconciliationRequest> request) async {
    return runReconciliation(call, await request);
  }

  $async.Future<$0.GetReconciliationLogsResponse> getReconciliationLogs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetReconciliationLogsRequest> request) async {
    return getReconciliationLogs(call, await request);
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
  $async.Future<$0.GetSupportedAssetsResponse> getSupportedAssets(
      $grpc.ServiceCall call, $0.GetSupportedAssetsRequest request);
  $async.Future<$0.GetCryptoFiatRateResponse> getCryptoFiatRate(
      $grpc.ServiceCall call, $0.GetCryptoFiatRateRequest request);
  $async.Future<$0.GetCryptoHoldingsResponse> getCryptoHoldings(
      $grpc.ServiceCall call, $0.GetCryptoHoldingsRequest request);
  $async.Future<$0.GetCryptoTransactionsResponse> getCryptoTransactions(
      $grpc.ServiceCall call, $0.GetCryptoTransactionsRequest request);
  $async.Future<$0.BuyCryptoResponse> buyCrypto(
      $grpc.ServiceCall call, $0.BuyCryptoRequest request);
  $async.Future<$0.SellCryptoResponse> sellCrypto(
      $grpc.ServiceCall call, $0.SellCryptoRequest request);
  $async.Future<$0.ConvertCryptoResponse> convertCrypto(
      $grpc.ServiceCall call, $0.ConvertCryptoRequest request);
  $async.Future<$0.GetWalletsResponse> getWallets(
      $grpc.ServiceCall call, $0.GetWalletsRequest request);
  $async.Future<$0.CreateWalletResponse> createWallet(
      $grpc.ServiceCall call, $0.CreateWalletRequest request);
  $async.Future<$0.GetWalletBalanceResponse> getWalletBalance(
      $grpc.ServiceCall call, $0.GetWalletBalanceRequest request);
  $async.Future<$0.BatchCreateWalletsResponse> batchCreateWallets(
      $grpc.ServiceCall call, $0.BatchCreateWalletsRequest request);
  $async.Future<$0.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $0.CreateWatchlistRequest request);
  $async.Future<$0.GetWatchlistsResponse> getWatchlists(
      $grpc.ServiceCall call, $0.GetWatchlistsRequest request);
  $async.Future<$0.AddToWatchlistResponse> addToWatchlist(
      $grpc.ServiceCall call, $0.AddToWatchlistRequest request);
  $async.Future<$0.RemoveFromWatchlistResponse> removeFromWatchlist(
      $grpc.ServiceCall call, $0.RemoveFromWatchlistRequest request);
  $async.Future<$0.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $0.DeleteWatchlistRequest request);
  $async.Future<$0.ToggleFavoriteResponse> toggleFavorite(
      $grpc.ServiceCall call, $0.ToggleFavoriteRequest request);
  $async.Future<$0.GetCryptoNewsResponse> getCryptoNews(
      $grpc.ServiceCall call, $0.GetCryptoNewsRequest request);
  $async.Future<$0.GetOHLCVResponse> getOHLCV(
      $grpc.ServiceCall call, $0.GetOHLCVRequest request);
  $async.Future<$0.GetOrderBookResponse> getOrderBook(
      $grpc.ServiceCall call, $0.GetOrderBookRequest request);
  $async.Future<$0.GetRecentTradesResponse> getRecentTrades(
      $grpc.ServiceCall call, $0.GetRecentTradesRequest request);
  $async.Future<$0.GetFearGreedIndexResponse> getFearGreedIndex(
      $grpc.ServiceCall call, $0.GetFearGreedIndexRequest request);
  $async.Future<$0.CreatePriceAlertResponse> createPriceAlert(
      $grpc.ServiceCall call, $0.CreatePriceAlertRequest request);
  $async.Future<$0.GetPriceAlertsResponse> getPriceAlerts(
      $grpc.ServiceCall call, $0.GetPriceAlertsRequest request);
  $async.Future<$0.DeletePriceAlertResponse> deletePriceAlert(
      $grpc.ServiceCall call, $0.DeletePriceAlertRequest request);
  $async.Future<$0.GetPlatformCryptoPortfolioResponse>
      getPlatformCryptoPortfolio(
          $grpc.ServiceCall call, $0.GetPlatformCryptoPortfolioRequest request);
  $async.Future<$0.GetPlatformCryptoTransactionsResponse>
      getPlatformCryptoTransactions($grpc.ServiceCall call,
          $0.GetPlatformCryptoTransactionsRequest request);
  $async.Future<$0.GetFeeTiersResponse> getFeeTiers(
      $grpc.ServiceCall call, $0.GetFeeTiersRequest request);
  $async.Future<$0.CreateFeeTierResponse> createFeeTier(
      $grpc.ServiceCall call, $0.CreateFeeTierRequest request);
  $async.Future<$0.UpdateFeeTierResponse> updateFeeTier(
      $grpc.ServiceCall call, $0.UpdateFeeTierRequest request);
  $async.Future<$0.DeleteFeeTierResponse> deleteFeeTier(
      $grpc.ServiceCall call, $0.DeleteFeeTierRequest request);
  $async.Future<$0.ReconciliationResult> runReconciliation(
      $grpc.ServiceCall call, $0.RunReconciliationRequest request);
  $async.Future<$0.GetReconciliationLogsResponse> getReconciliationLogs(
      $grpc.ServiceCall call, $0.GetReconciliationLogsRequest request);
}
