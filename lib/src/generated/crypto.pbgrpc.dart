///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crypto.pb.dart' as $12;
export 'crypto.pb.dart';

class CryptoServiceClient extends $grpc.Client {
  static final _$getCryptos =
      $grpc.ClientMethod<$12.GetCryptosRequest, $12.GetCryptosResponse>(
          '/pb.CryptoService/GetCryptos',
          ($12.GetCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetCryptosResponse.fromBuffer(value));
  static final _$getCryptoById =
      $grpc.ClientMethod<$12.GetCryptoByIdRequest, $12.GetCryptoByIdResponse>(
          '/pb.CryptoService/GetCryptoById',
          ($12.GetCryptoByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetCryptoByIdResponse.fromBuffer(value));
  static final _$searchCryptos =
      $grpc.ClientMethod<$12.SearchCryptosRequest, $12.SearchCryptosResponse>(
          '/pb.CryptoService/SearchCryptos',
          ($12.SearchCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.SearchCryptosResponse.fromBuffer(value));
  static final _$getCryptoPriceHistory = $grpc.ClientMethod<
          $12.GetCryptoPriceHistoryRequest, $12.GetCryptoPriceHistoryResponse>(
      '/pb.CryptoService/GetCryptoPriceHistory',
      ($12.GetCryptoPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetCryptoPriceHistoryResponse.fromBuffer(value));
  static final _$getTrendingCryptos = $grpc.ClientMethod<
          $12.GetTrendingCryptosRequest, $12.GetTrendingCryptosResponse>(
      '/pb.CryptoService/GetTrendingCryptos',
      ($12.GetTrendingCryptosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetTrendingCryptosResponse.fromBuffer(value));
  static final _$getTopCryptos =
      $grpc.ClientMethod<$12.GetTopCryptosRequest, $12.GetTopCryptosResponse>(
          '/pb.CryptoService/GetTopCryptos',
          ($12.GetTopCryptosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetTopCryptosResponse.fromBuffer(value));
  static final _$getMarketChart =
      $grpc.ClientMethod<$12.GetMarketChartRequest, $12.GetMarketChartResponse>(
          '/pb.CryptoService/GetMarketChart',
          ($12.GetMarketChartRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetMarketChartResponse.fromBuffer(value));
  static final _$getGlobalMarketData = $grpc.ClientMethod<
          $12.GetGlobalMarketDataRequest, $12.GetGlobalMarketDataResponse>(
      '/pb.CryptoService/GetGlobalMarketData',
      ($12.GetGlobalMarketDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetGlobalMarketDataResponse.fromBuffer(value));
  static final _$getSupportedAssets = $grpc.ClientMethod<
          $12.GetSupportedAssetsRequest, $12.GetSupportedAssetsResponse>(
      '/pb.CryptoService/GetSupportedAssets',
      ($12.GetSupportedAssetsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetSupportedAssetsResponse.fromBuffer(value));
  static final _$getCryptoFiatRate = $grpc.ClientMethod<
          $12.GetCryptoFiatRateRequest, $12.GetCryptoFiatRateResponse>(
      '/pb.CryptoService/GetCryptoFiatRate',
      ($12.GetCryptoFiatRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetCryptoFiatRateResponse.fromBuffer(value));
  static final _$getCryptoHoldings = $grpc.ClientMethod<
          $12.GetCryptoHoldingsRequest, $12.GetCryptoHoldingsResponse>(
      '/pb.CryptoService/GetCryptoHoldings',
      ($12.GetCryptoHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetCryptoHoldingsResponse.fromBuffer(value));
  static final _$getCryptoTransactions = $grpc.ClientMethod<
          $12.GetCryptoTransactionsRequest, $12.GetCryptoTransactionsResponse>(
      '/pb.CryptoService/GetCryptoTransactions',
      ($12.GetCryptoTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetCryptoTransactionsResponse.fromBuffer(value));
  static final _$buyCrypto =
      $grpc.ClientMethod<$12.BuyCryptoRequest, $12.BuyCryptoResponse>(
          '/pb.CryptoService/BuyCrypto',
          ($12.BuyCryptoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.BuyCryptoResponse.fromBuffer(value));
  static final _$sellCrypto =
      $grpc.ClientMethod<$12.SellCryptoRequest, $12.SellCryptoResponse>(
          '/pb.CryptoService/SellCrypto',
          ($12.SellCryptoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.SellCryptoResponse.fromBuffer(value));
  static final _$convertCrypto =
      $grpc.ClientMethod<$12.ConvertCryptoRequest, $12.ConvertCryptoResponse>(
          '/pb.CryptoService/ConvertCrypto',
          ($12.ConvertCryptoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.ConvertCryptoResponse.fromBuffer(value));
  static final _$getWallets =
      $grpc.ClientMethod<$12.GetWalletsRequest, $12.GetWalletsResponse>(
          '/pb.CryptoService/GetWallets',
          ($12.GetWalletsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetWalletsResponse.fromBuffer(value));
  static final _$createWallet =
      $grpc.ClientMethod<$12.CreateWalletRequest, $12.CreateWalletResponse>(
          '/pb.CryptoService/CreateWallet',
          ($12.CreateWalletRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.CreateWalletResponse.fromBuffer(value));
  static final _$getWalletBalance = $grpc.ClientMethod<
          $12.GetWalletBalanceRequest, $12.GetWalletBalanceResponse>(
      '/pb.CryptoService/GetWalletBalance',
      ($12.GetWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetWalletBalanceResponse.fromBuffer(value));
  static final _$batchCreateWallets = $grpc.ClientMethod<
          $12.BatchCreateWalletsRequest, $12.BatchCreateWalletsResponse>(
      '/pb.CryptoService/BatchCreateWallets',
      ($12.BatchCreateWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.BatchCreateWalletsResponse.fromBuffer(value));
  static final _$createWatchlist = $grpc.ClientMethod<
          $12.CreateWatchlistRequest, $12.CreateWatchlistResponse>(
      '/pb.CryptoService/CreateWatchlist',
      ($12.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.CreateWatchlistResponse.fromBuffer(value));
  static final _$getWatchlists =
      $grpc.ClientMethod<$12.GetWatchlistsRequest, $12.GetWatchlistsResponse>(
          '/pb.CryptoService/GetWatchlists',
          ($12.GetWatchlistsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetWatchlistsResponse.fromBuffer(value));
  static final _$addToWatchlist =
      $grpc.ClientMethod<$12.AddToWatchlistRequest, $12.AddToWatchlistResponse>(
          '/pb.CryptoService/AddToWatchlist',
          ($12.AddToWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.AddToWatchlistResponse.fromBuffer(value));
  static final _$removeFromWatchlist = $grpc.ClientMethod<
          $12.RemoveFromWatchlistRequest, $12.RemoveFromWatchlistResponse>(
      '/pb.CryptoService/RemoveFromWatchlist',
      ($12.RemoveFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.RemoveFromWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<
          $12.DeleteWatchlistRequest, $12.DeleteWatchlistResponse>(
      '/pb.CryptoService/DeleteWatchlist',
      ($12.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.DeleteWatchlistResponse.fromBuffer(value));
  static final _$toggleFavorite =
      $grpc.ClientMethod<$12.ToggleFavoriteRequest, $12.ToggleFavoriteResponse>(
          '/pb.CryptoService/ToggleFavorite',
          ($12.ToggleFavoriteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.ToggleFavoriteResponse.fromBuffer(value));
  static final _$getCryptoNews =
      $grpc.ClientMethod<$12.GetCryptoNewsRequest, $12.GetCryptoNewsResponse>(
          '/pb.CryptoService/GetCryptoNews',
          ($12.GetCryptoNewsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetCryptoNewsResponse.fromBuffer(value));
  static final _$getOHLCV =
      $grpc.ClientMethod<$12.GetOHLCVRequest, $12.GetOHLCVResponse>(
          '/pb.CryptoService/GetOHLCV',
          ($12.GetOHLCVRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetOHLCVResponse.fromBuffer(value));
  static final _$getOrderBook =
      $grpc.ClientMethod<$12.GetOrderBookRequest, $12.GetOrderBookResponse>(
          '/pb.CryptoService/GetOrderBook',
          ($12.GetOrderBookRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetOrderBookResponse.fromBuffer(value));
  static final _$getRecentTrades = $grpc.ClientMethod<
          $12.GetRecentTradesRequest, $12.GetRecentTradesResponse>(
      '/pb.CryptoService/GetRecentTrades',
      ($12.GetRecentTradesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetRecentTradesResponse.fromBuffer(value));
  static final _$getFearGreedIndex = $grpc.ClientMethod<
          $12.GetFearGreedIndexRequest, $12.GetFearGreedIndexResponse>(
      '/pb.CryptoService/GetFearGreedIndex',
      ($12.GetFearGreedIndexRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetFearGreedIndexResponse.fromBuffer(value));
  static final _$createPriceAlert = $grpc.ClientMethod<
          $12.CreatePriceAlertRequest, $12.CreatePriceAlertResponse>(
      '/pb.CryptoService/CreatePriceAlert',
      ($12.CreatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.CreatePriceAlertResponse.fromBuffer(value));
  static final _$getPriceAlerts =
      $grpc.ClientMethod<$12.GetPriceAlertsRequest, $12.GetPriceAlertsResponse>(
          '/pb.CryptoService/GetPriceAlerts',
          ($12.GetPriceAlertsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetPriceAlertsResponse.fromBuffer(value));
  static final _$deletePriceAlert = $grpc.ClientMethod<
          $12.DeletePriceAlertRequest, $12.DeletePriceAlertResponse>(
      '/pb.CryptoService/DeletePriceAlert',
      ($12.DeletePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.DeletePriceAlertResponse.fromBuffer(value));
  static final _$getPlatformCryptoPortfolio = $grpc.ClientMethod<
          $12.GetPlatformCryptoPortfolioRequest,
          $12.GetPlatformCryptoPortfolioResponse>(
      '/pb.CryptoService/GetPlatformCryptoPortfolio',
      ($12.GetPlatformCryptoPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetPlatformCryptoPortfolioResponse.fromBuffer(value));
  static final _$getPlatformCryptoTransactions = $grpc.ClientMethod<
          $12.GetPlatformCryptoTransactionsRequest,
          $12.GetPlatformCryptoTransactionsResponse>(
      '/pb.CryptoService/GetPlatformCryptoTransactions',
      ($12.GetPlatformCryptoTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetPlatformCryptoTransactionsResponse.fromBuffer(value));
  static final _$getFeeTiers =
      $grpc.ClientMethod<$12.GetFeeTiersRequest, $12.GetFeeTiersResponse>(
          '/pb.CryptoService/GetFeeTiers',
          ($12.GetFeeTiersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetFeeTiersResponse.fromBuffer(value));
  static final _$createFeeTier =
      $grpc.ClientMethod<$12.CreateFeeTierRequest, $12.CreateFeeTierResponse>(
          '/pb.CryptoService/CreateFeeTier',
          ($12.CreateFeeTierRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.CreateFeeTierResponse.fromBuffer(value));
  static final _$updateFeeTier =
      $grpc.ClientMethod<$12.UpdateFeeTierRequest, $12.UpdateFeeTierResponse>(
          '/pb.CryptoService/UpdateFeeTier',
          ($12.UpdateFeeTierRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.UpdateFeeTierResponse.fromBuffer(value));
  static final _$deleteFeeTier =
      $grpc.ClientMethod<$12.DeleteFeeTierRequest, $12.DeleteFeeTierResponse>(
          '/pb.CryptoService/DeleteFeeTier',
          ($12.DeleteFeeTierRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.DeleteFeeTierResponse.fromBuffer(value));
  static final _$runReconciliation = $grpc.ClientMethod<
          $12.RunReconciliationRequest, $12.ReconciliationResult>(
      '/pb.CryptoService/RunReconciliation',
      ($12.RunReconciliationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.ReconciliationResult.fromBuffer(value));
  static final _$getReconciliationLogs = $grpc.ClientMethod<
          $12.GetReconciliationLogsRequest, $12.GetReconciliationLogsResponse>(
      '/pb.CryptoService/GetReconciliationLogs',
      ($12.GetReconciliationLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetReconciliationLogsResponse.fromBuffer(value));
  static final _$getSpreadConfig = $grpc.ClientMethod<
          $12.GetSpreadConfigRequest, $12.GetSpreadConfigResponse>(
      '/pb.CryptoService/GetSpreadConfig',
      ($12.GetSpreadConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetSpreadConfigResponse.fromBuffer(value));
  static final _$updateSpreadConfig = $grpc.ClientMethod<
          $12.UpdateSpreadConfigRequest, $12.UpdateSpreadConfigResponse>(
      '/pb.CryptoService/UpdateSpreadConfig',
      ($12.UpdateSpreadConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdateSpreadConfigResponse.fromBuffer(value));
  static final _$getFeeConfig =
      $grpc.ClientMethod<$12.GetFeeConfigRequest, $12.GetFeeConfigResponse>(
          '/pb.CryptoService/GetFeeConfig',
          ($12.GetFeeConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetFeeConfigResponse.fromBuffer(value));
  static final _$updateFeeConfig = $grpc.ClientMethod<
          $12.UpdateFeeConfigRequest, $12.UpdateFeeConfigResponse>(
      '/pb.CryptoService/UpdateFeeConfig',
      ($12.UpdateFeeConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdateFeeConfigResponse.fromBuffer(value));
  static final _$getWalletReconciliations = $grpc.ClientMethod<
          $12.GetWalletReconciliationsRequest,
          $12.GetWalletReconciliationsResponse>(
      '/pb.CryptoService/GetWalletReconciliations',
      ($12.GetWalletReconciliationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetWalletReconciliationsResponse.fromBuffer(value));
  static final _$triggerWalletReconciliation = $grpc.ClientMethod<
          $12.TriggerWalletReconciliationRequest,
          $12.TriggerWalletReconciliationResponse>(
      '/pb.CryptoService/TriggerWalletReconciliation',
      ($12.TriggerWalletReconciliationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.TriggerWalletReconciliationResponse.fromBuffer(value));
  static final _$getSettlements =
      $grpc.ClientMethod<$12.GetSettlementsRequest, $12.GetSettlementsResponse>(
          '/pb.CryptoService/GetSettlements',
          ($12.GetSettlementsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetSettlementsResponse.fromBuffer(value));
  static final _$markSettlementsPaid = $grpc.ClientMethod<
          $12.MarkSettlementsPaidRequest, $12.MarkSettlementsPaidResponse>(
      '/pb.CryptoService/MarkSettlementsPaid',
      ($12.MarkSettlementsPaidRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.MarkSettlementsPaidResponse.fromBuffer(value));
  static final _$getTransactionDetail = $grpc.ClientMethod<
          $12.GetTransactionDetailRequest, $12.GetTransactionDetailResponse>(
      '/pb.CryptoService/GetTransactionDetail',
      ($12.GetTransactionDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetTransactionDetailResponse.fromBuffer(value));
  static final _$retryTransaction = $grpc.ClientMethod<
          $12.RetryTransactionRequest, $12.RetryTransactionResponse>(
      '/pb.CryptoService/RetryTransaction',
      ($12.RetryTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.RetryTransactionResponse.fromBuffer(value));
  static final _$reverseTransaction = $grpc.ClientMethod<
          $12.ReverseTransactionRequest, $12.ReverseTransactionResponse>(
      '/pb.CryptoService/ReverseTransaction',
      ($12.ReverseTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.ReverseTransactionResponse.fromBuffer(value));
  static final _$getUserCryptoAuditTrail = $grpc.ClientMethod<
          $12.GetUserCryptoAuditTrailRequest,
          $12.GetUserCryptoAuditTrailResponse>(
      '/pb.CryptoService/GetUserCryptoAuditTrail',
      ($12.GetUserCryptoAuditTrailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetUserCryptoAuditTrailResponse.fromBuffer(value));
  static final _$setTradingSuspension = $grpc.ClientMethod<
          $12.SetTradingSuspensionRequest, $12.SetTradingSuspensionResponse>(
      '/pb.CryptoService/SetTradingSuspension',
      ($12.SetTradingSuspensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.SetTradingSuspensionResponse.fromBuffer(value));
  static final _$getTradingSuspension = $grpc.ClientMethod<
          $12.GetTradingSuspensionRequest, $12.GetTradingSuspensionResponse>(
      '/pb.CryptoService/GetTradingSuspension',
      ($12.GetTradingSuspensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetTradingSuspensionResponse.fromBuffer(value));
  static final _$setUserCryptoFreeze = $grpc.ClientMethod<
          $12.SetUserCryptoFreezeRequest, $12.SetUserCryptoFreezeResponse>(
      '/pb.CryptoService/SetUserCryptoFreeze',
      ($12.SetUserCryptoFreezeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.SetUserCryptoFreezeResponse.fromBuffer(value));
  static final _$getUserCryptoFreeze = $grpc.ClientMethod<
          $12.GetUserCryptoFreezeRequest, $12.GetUserCryptoFreezeResponse>(
      '/pb.CryptoService/GetUserCryptoFreeze',
      ($12.GetUserCryptoFreezeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetUserCryptoFreezeResponse.fromBuffer(value));

  CryptoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$12.GetCryptosResponse> getCryptos(
      $12.GetCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCryptoByIdResponse> getCryptoById(
      $12.GetCryptoByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoById, request, options: options);
  }

  $grpc.ResponseFuture<$12.SearchCryptosResponse> searchCryptos(
      $12.SearchCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCryptoPriceHistoryResponse> getCryptoPriceHistory(
      $12.GetCryptoPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTrendingCryptosResponse> getTrendingCryptos(
      $12.GetTrendingCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTopCryptosResponse> getTopCryptos(
      $12.GetTopCryptosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopCryptos, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetMarketChartResponse> getMarketChart(
      $12.GetMarketChartRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketChart, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetGlobalMarketDataResponse> getGlobalMarketData(
      $12.GetGlobalMarketDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGlobalMarketData, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetSupportedAssetsResponse> getSupportedAssets(
      $12.GetSupportedAssetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedAssets, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCryptoFiatRateResponse> getCryptoFiatRate(
      $12.GetCryptoFiatRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoFiatRate, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCryptoHoldingsResponse> getCryptoHoldings(
      $12.GetCryptoHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCryptoTransactionsResponse> getCryptoTransactions(
      $12.GetCryptoTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$12.BuyCryptoResponse> buyCrypto(
      $12.BuyCryptoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$12.SellCryptoResponse> sellCrypto(
      $12.SellCryptoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$12.ConvertCryptoResponse> convertCrypto(
      $12.ConvertCryptoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetWalletsResponse> getWallets(
      $12.GetWalletsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWallets, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreateWalletResponse> createWallet(
      $12.CreateWalletRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWallet, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetWalletBalanceResponse> getWalletBalance(
      $12.GetWalletBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletBalance, request, options: options);
  }

  $grpc.ResponseFuture<$12.BatchCreateWalletsResponse> batchCreateWallets(
      $12.BatchCreateWalletsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchCreateWallets, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreateWatchlistResponse> createWatchlist(
      $12.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetWatchlistsResponse> getWatchlists(
      $12.GetWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$12.AddToWatchlistResponse> addToWatchlist(
      $12.AddToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$12.RemoveFromWatchlistResponse> removeFromWatchlist(
      $12.RemoveFromWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFromWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteWatchlistResponse> deleteWatchlist(
      $12.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$12.ToggleFavoriteResponse> toggleFavorite(
      $12.ToggleFavoriteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleFavorite, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCryptoNewsResponse> getCryptoNews(
      $12.GetCryptoNewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoNews, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetOHLCVResponse> getOHLCV(
      $12.GetOHLCVRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOHLCV, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetOrderBookResponse> getOrderBook(
      $12.GetOrderBookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderBook, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetRecentTradesResponse> getRecentTrades(
      $12.GetRecentTradesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentTrades, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetFearGreedIndexResponse> getFearGreedIndex(
      $12.GetFearGreedIndexRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFearGreedIndex, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreatePriceAlertResponse> createPriceAlert(
      $12.CreatePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetPriceAlertsResponse> getPriceAlerts(
      $12.GetPriceAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPriceAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeletePriceAlertResponse> deletePriceAlert(
      $12.DeletePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetPlatformCryptoPortfolioResponse>
      getPlatformCryptoPortfolio($12.GetPlatformCryptoPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlatformCryptoPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.GetPlatformCryptoTransactionsResponse>
      getPlatformCryptoTransactions(
          $12.GetPlatformCryptoTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlatformCryptoTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.GetFeeTiersResponse> getFeeTiers(
      $12.GetFeeTiersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFeeTiers, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreateFeeTierResponse> createFeeTier(
      $12.CreateFeeTierRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFeeTier, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateFeeTierResponse> updateFeeTier(
      $12.UpdateFeeTierRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFeeTier, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteFeeTierResponse> deleteFeeTier(
      $12.DeleteFeeTierRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFeeTier, request, options: options);
  }

  $grpc.ResponseFuture<$12.ReconciliationResult> runReconciliation(
      $12.RunReconciliationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runReconciliation, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetReconciliationLogsResponse> getReconciliationLogs(
      $12.GetReconciliationLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationLogs, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetSpreadConfigResponse> getSpreadConfig(
      $12.GetSpreadConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpreadConfig, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateSpreadConfigResponse> updateSpreadConfig(
      $12.UpdateSpreadConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSpreadConfig, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetFeeConfigResponse> getFeeConfig(
      $12.GetFeeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFeeConfig, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateFeeConfigResponse> updateFeeConfig(
      $12.UpdateFeeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFeeConfig, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetWalletReconciliationsResponse>
      getWalletReconciliations($12.GetWalletReconciliationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletReconciliations, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.TriggerWalletReconciliationResponse>
      triggerWalletReconciliation(
          $12.TriggerWalletReconciliationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerWalletReconciliation, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.GetSettlementsResponse> getSettlements(
      $12.GetSettlementsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSettlements, request, options: options);
  }

  $grpc.ResponseFuture<$12.MarkSettlementsPaidResponse> markSettlementsPaid(
      $12.MarkSettlementsPaidRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markSettlementsPaid, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTransactionDetailResponse> getTransactionDetail(
      $12.GetTransactionDetailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionDetail, request, options: options);
  }

  $grpc.ResponseFuture<$12.RetryTransactionResponse> retryTransaction(
      $12.RetryTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$12.ReverseTransactionResponse> reverseTransaction(
      $12.ReverseTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reverseTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetUserCryptoAuditTrailResponse>
      getUserCryptoAuditTrail($12.GetUserCryptoAuditTrailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCryptoAuditTrail, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.SetTradingSuspensionResponse> setTradingSuspension(
      $12.SetTradingSuspensionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setTradingSuspension, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTradingSuspensionResponse> getTradingSuspension(
      $12.GetTradingSuspensionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTradingSuspension, request, options: options);
  }

  $grpc.ResponseFuture<$12.SetUserCryptoFreezeResponse> setUserCryptoFreeze(
      $12.SetUserCryptoFreezeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setUserCryptoFreeze, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetUserCryptoFreezeResponse> getUserCryptoFreeze(
      $12.GetUserCryptoFreezeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCryptoFreeze, request, options: options);
  }
}

abstract class CryptoServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CryptoService';

  CryptoServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$12.GetCryptosRequest, $12.GetCryptosResponse>(
            'GetCryptos',
            getCryptos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetCryptosRequest.fromBuffer(value),
            ($12.GetCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCryptoByIdRequest,
            $12.GetCryptoByIdResponse>(
        'GetCryptoById',
        getCryptoById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetCryptoByIdRequest.fromBuffer(value),
        ($12.GetCryptoByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.SearchCryptosRequest,
            $12.SearchCryptosResponse>(
        'SearchCryptos',
        searchCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.SearchCryptosRequest.fromBuffer(value),
        ($12.SearchCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCryptoPriceHistoryRequest,
            $12.GetCryptoPriceHistoryResponse>(
        'GetCryptoPriceHistory',
        getCryptoPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetCryptoPriceHistoryRequest.fromBuffer(value),
        ($12.GetCryptoPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTrendingCryptosRequest,
            $12.GetTrendingCryptosResponse>(
        'GetTrendingCryptos',
        getTrendingCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetTrendingCryptosRequest.fromBuffer(value),
        ($12.GetTrendingCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTopCryptosRequest,
            $12.GetTopCryptosResponse>(
        'GetTopCryptos',
        getTopCryptos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetTopCryptosRequest.fromBuffer(value),
        ($12.GetTopCryptosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetMarketChartRequest,
            $12.GetMarketChartResponse>(
        'GetMarketChart',
        getMarketChart_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetMarketChartRequest.fromBuffer(value),
        ($12.GetMarketChartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetGlobalMarketDataRequest,
            $12.GetGlobalMarketDataResponse>(
        'GetGlobalMarketData',
        getGlobalMarketData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetGlobalMarketDataRequest.fromBuffer(value),
        ($12.GetGlobalMarketDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetSupportedAssetsRequest,
            $12.GetSupportedAssetsResponse>(
        'GetSupportedAssets',
        getSupportedAssets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetSupportedAssetsRequest.fromBuffer(value),
        ($12.GetSupportedAssetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCryptoFiatRateRequest,
            $12.GetCryptoFiatRateResponse>(
        'GetCryptoFiatRate',
        getCryptoFiatRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetCryptoFiatRateRequest.fromBuffer(value),
        ($12.GetCryptoFiatRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCryptoHoldingsRequest,
            $12.GetCryptoHoldingsResponse>(
        'GetCryptoHoldings',
        getCryptoHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetCryptoHoldingsRequest.fromBuffer(value),
        ($12.GetCryptoHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCryptoTransactionsRequest,
            $12.GetCryptoTransactionsResponse>(
        'GetCryptoTransactions',
        getCryptoTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetCryptoTransactionsRequest.fromBuffer(value),
        ($12.GetCryptoTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.BuyCryptoRequest, $12.BuyCryptoResponse>(
        'BuyCrypto',
        buyCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.BuyCryptoRequest.fromBuffer(value),
        ($12.BuyCryptoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.SellCryptoRequest, $12.SellCryptoResponse>(
            'SellCrypto',
            sellCrypto_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.SellCryptoRequest.fromBuffer(value),
            ($12.SellCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ConvertCryptoRequest,
            $12.ConvertCryptoResponse>(
        'ConvertCrypto',
        convertCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ConvertCryptoRequest.fromBuffer(value),
        ($12.ConvertCryptoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.GetWalletsRequest, $12.GetWalletsResponse>(
            'GetWallets',
            getWallets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetWalletsRequest.fromBuffer(value),
            ($12.GetWalletsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.CreateWalletRequest, $12.CreateWalletResponse>(
            'CreateWallet',
            createWallet_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.CreateWalletRequest.fromBuffer(value),
            ($12.CreateWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetWalletBalanceRequest,
            $12.GetWalletBalanceResponse>(
        'GetWalletBalance',
        getWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetWalletBalanceRequest.fromBuffer(value),
        ($12.GetWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.BatchCreateWalletsRequest,
            $12.BatchCreateWalletsResponse>(
        'BatchCreateWallets',
        batchCreateWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.BatchCreateWalletsRequest.fromBuffer(value),
        ($12.BatchCreateWalletsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.CreateWatchlistRequest,
            $12.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.CreateWatchlistRequest.fromBuffer(value),
        ($12.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetWatchlistsRequest,
            $12.GetWatchlistsResponse>(
        'GetWatchlists',
        getWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetWatchlistsRequest.fromBuffer(value),
        ($12.GetWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.AddToWatchlistRequest,
            $12.AddToWatchlistResponse>(
        'AddToWatchlist',
        addToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.AddToWatchlistRequest.fromBuffer(value),
        ($12.AddToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.RemoveFromWatchlistRequest,
            $12.RemoveFromWatchlistResponse>(
        'RemoveFromWatchlist',
        removeFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.RemoveFromWatchlistRequest.fromBuffer(value),
        ($12.RemoveFromWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteWatchlistRequest,
            $12.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeleteWatchlistRequest.fromBuffer(value),
        ($12.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ToggleFavoriteRequest,
            $12.ToggleFavoriteResponse>(
        'ToggleFavorite',
        toggleFavorite_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ToggleFavoriteRequest.fromBuffer(value),
        ($12.ToggleFavoriteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCryptoNewsRequest,
            $12.GetCryptoNewsResponse>(
        'GetCryptoNews',
        getCryptoNews_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetCryptoNewsRequest.fromBuffer(value),
        ($12.GetCryptoNewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetOHLCVRequest, $12.GetOHLCVResponse>(
        'GetOHLCV',
        getOHLCV_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetOHLCVRequest.fromBuffer(value),
        ($12.GetOHLCVResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.GetOrderBookRequest, $12.GetOrderBookResponse>(
            'GetOrderBook',
            getOrderBook_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetOrderBookRequest.fromBuffer(value),
            ($12.GetOrderBookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetRecentTradesRequest,
            $12.GetRecentTradesResponse>(
        'GetRecentTrades',
        getRecentTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetRecentTradesRequest.fromBuffer(value),
        ($12.GetRecentTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetFearGreedIndexRequest,
            $12.GetFearGreedIndexResponse>(
        'GetFearGreedIndex',
        getFearGreedIndex_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetFearGreedIndexRequest.fromBuffer(value),
        ($12.GetFearGreedIndexResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.CreatePriceAlertRequest,
            $12.CreatePriceAlertResponse>(
        'CreatePriceAlert',
        createPriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.CreatePriceAlertRequest.fromBuffer(value),
        ($12.CreatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetPriceAlertsRequest,
            $12.GetPriceAlertsResponse>(
        'GetPriceAlerts',
        getPriceAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetPriceAlertsRequest.fromBuffer(value),
        ($12.GetPriceAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeletePriceAlertRequest,
            $12.DeletePriceAlertResponse>(
        'DeletePriceAlert',
        deletePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeletePriceAlertRequest.fromBuffer(value),
        ($12.DeletePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetPlatformCryptoPortfolioRequest,
            $12.GetPlatformCryptoPortfolioResponse>(
        'GetPlatformCryptoPortfolio',
        getPlatformCryptoPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetPlatformCryptoPortfolioRequest.fromBuffer(value),
        ($12.GetPlatformCryptoPortfolioResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetPlatformCryptoTransactionsRequest,
            $12.GetPlatformCryptoTransactionsResponse>(
        'GetPlatformCryptoTransactions',
        getPlatformCryptoTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetPlatformCryptoTransactionsRequest.fromBuffer(value),
        ($12.GetPlatformCryptoTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.GetFeeTiersRequest, $12.GetFeeTiersResponse>(
            'GetFeeTiers',
            getFeeTiers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetFeeTiersRequest.fromBuffer(value),
            ($12.GetFeeTiersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.CreateFeeTierRequest,
            $12.CreateFeeTierResponse>(
        'CreateFeeTier',
        createFeeTier_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.CreateFeeTierRequest.fromBuffer(value),
        ($12.CreateFeeTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateFeeTierRequest,
            $12.UpdateFeeTierResponse>(
        'UpdateFeeTier',
        updateFeeTier_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateFeeTierRequest.fromBuffer(value),
        ($12.UpdateFeeTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteFeeTierRequest,
            $12.DeleteFeeTierResponse>(
        'DeleteFeeTier',
        deleteFeeTier_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeleteFeeTierRequest.fromBuffer(value),
        ($12.DeleteFeeTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.RunReconciliationRequest,
            $12.ReconciliationResult>(
        'RunReconciliation',
        runReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.RunReconciliationRequest.fromBuffer(value),
        ($12.ReconciliationResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetReconciliationLogsRequest,
            $12.GetReconciliationLogsResponse>(
        'GetReconciliationLogs',
        getReconciliationLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetReconciliationLogsRequest.fromBuffer(value),
        ($12.GetReconciliationLogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetSpreadConfigRequest,
            $12.GetSpreadConfigResponse>(
        'GetSpreadConfig',
        getSpreadConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetSpreadConfigRequest.fromBuffer(value),
        ($12.GetSpreadConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateSpreadConfigRequest,
            $12.UpdateSpreadConfigResponse>(
        'UpdateSpreadConfig',
        updateSpreadConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateSpreadConfigRequest.fromBuffer(value),
        ($12.UpdateSpreadConfigResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.GetFeeConfigRequest, $12.GetFeeConfigResponse>(
            'GetFeeConfig',
            getFeeConfig_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetFeeConfigRequest.fromBuffer(value),
            ($12.GetFeeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateFeeConfigRequest,
            $12.UpdateFeeConfigResponse>(
        'UpdateFeeConfig',
        updateFeeConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateFeeConfigRequest.fromBuffer(value),
        ($12.UpdateFeeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetWalletReconciliationsRequest,
            $12.GetWalletReconciliationsResponse>(
        'GetWalletReconciliations',
        getWalletReconciliations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetWalletReconciliationsRequest.fromBuffer(value),
        ($12.GetWalletReconciliationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.TriggerWalletReconciliationRequest,
            $12.TriggerWalletReconciliationResponse>(
        'TriggerWalletReconciliation',
        triggerWalletReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.TriggerWalletReconciliationRequest.fromBuffer(value),
        ($12.TriggerWalletReconciliationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetSettlementsRequest,
            $12.GetSettlementsResponse>(
        'GetSettlements',
        getSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetSettlementsRequest.fromBuffer(value),
        ($12.GetSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.MarkSettlementsPaidRequest,
            $12.MarkSettlementsPaidResponse>(
        'MarkSettlementsPaid',
        markSettlementsPaid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.MarkSettlementsPaidRequest.fromBuffer(value),
        ($12.MarkSettlementsPaidResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTransactionDetailRequest,
            $12.GetTransactionDetailResponse>(
        'GetTransactionDetail',
        getTransactionDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetTransactionDetailRequest.fromBuffer(value),
        ($12.GetTransactionDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.RetryTransactionRequest,
            $12.RetryTransactionResponse>(
        'RetryTransaction',
        retryTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.RetryTransactionRequest.fromBuffer(value),
        ($12.RetryTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ReverseTransactionRequest,
            $12.ReverseTransactionResponse>(
        'ReverseTransaction',
        reverseTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ReverseTransactionRequest.fromBuffer(value),
        ($12.ReverseTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetUserCryptoAuditTrailRequest,
            $12.GetUserCryptoAuditTrailResponse>(
        'GetUserCryptoAuditTrail',
        getUserCryptoAuditTrail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetUserCryptoAuditTrailRequest.fromBuffer(value),
        ($12.GetUserCryptoAuditTrailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.SetTradingSuspensionRequest,
            $12.SetTradingSuspensionResponse>(
        'SetTradingSuspension',
        setTradingSuspension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.SetTradingSuspensionRequest.fromBuffer(value),
        ($12.SetTradingSuspensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTradingSuspensionRequest,
            $12.GetTradingSuspensionResponse>(
        'GetTradingSuspension',
        getTradingSuspension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetTradingSuspensionRequest.fromBuffer(value),
        ($12.GetTradingSuspensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.SetUserCryptoFreezeRequest,
            $12.SetUserCryptoFreezeResponse>(
        'SetUserCryptoFreeze',
        setUserCryptoFreeze_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.SetUserCryptoFreezeRequest.fromBuffer(value),
        ($12.SetUserCryptoFreezeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetUserCryptoFreezeRequest,
            $12.GetUserCryptoFreezeResponse>(
        'GetUserCryptoFreeze',
        getUserCryptoFreeze_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetUserCryptoFreezeRequest.fromBuffer(value),
        ($12.GetUserCryptoFreezeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$12.GetCryptosResponse> getCryptos_Pre($grpc.ServiceCall call,
      $async.Future<$12.GetCryptosRequest> request) async {
    return getCryptos(call, await request);
  }

  $async.Future<$12.GetCryptoByIdResponse> getCryptoById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetCryptoByIdRequest> request) async {
    return getCryptoById(call, await request);
  }

  $async.Future<$12.SearchCryptosResponse> searchCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.SearchCryptosRequest> request) async {
    return searchCryptos(call, await request);
  }

  $async.Future<$12.GetCryptoPriceHistoryResponse> getCryptoPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetCryptoPriceHistoryRequest> request) async {
    return getCryptoPriceHistory(call, await request);
  }

  $async.Future<$12.GetTrendingCryptosResponse> getTrendingCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetTrendingCryptosRequest> request) async {
    return getTrendingCryptos(call, await request);
  }

  $async.Future<$12.GetTopCryptosResponse> getTopCryptos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetTopCryptosRequest> request) async {
    return getTopCryptos(call, await request);
  }

  $async.Future<$12.GetMarketChartResponse> getMarketChart_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetMarketChartRequest> request) async {
    return getMarketChart(call, await request);
  }

  $async.Future<$12.GetGlobalMarketDataResponse> getGlobalMarketData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetGlobalMarketDataRequest> request) async {
    return getGlobalMarketData(call, await request);
  }

  $async.Future<$12.GetSupportedAssetsResponse> getSupportedAssets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetSupportedAssetsRequest> request) async {
    return getSupportedAssets(call, await request);
  }

  $async.Future<$12.GetCryptoFiatRateResponse> getCryptoFiatRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetCryptoFiatRateRequest> request) async {
    return getCryptoFiatRate(call, await request);
  }

  $async.Future<$12.GetCryptoHoldingsResponse> getCryptoHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetCryptoHoldingsRequest> request) async {
    return getCryptoHoldings(call, await request);
  }

  $async.Future<$12.GetCryptoTransactionsResponse> getCryptoTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetCryptoTransactionsRequest> request) async {
    return getCryptoTransactions(call, await request);
  }

  $async.Future<$12.BuyCryptoResponse> buyCrypto_Pre($grpc.ServiceCall call,
      $async.Future<$12.BuyCryptoRequest> request) async {
    return buyCrypto(call, await request);
  }

  $async.Future<$12.SellCryptoResponse> sellCrypto_Pre($grpc.ServiceCall call,
      $async.Future<$12.SellCryptoRequest> request) async {
    return sellCrypto(call, await request);
  }

  $async.Future<$12.ConvertCryptoResponse> convertCrypto_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ConvertCryptoRequest> request) async {
    return convertCrypto(call, await request);
  }

  $async.Future<$12.GetWalletsResponse> getWallets_Pre($grpc.ServiceCall call,
      $async.Future<$12.GetWalletsRequest> request) async {
    return getWallets(call, await request);
  }

  $async.Future<$12.CreateWalletResponse> createWallet_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreateWalletRequest> request) async {
    return createWallet(call, await request);
  }

  $async.Future<$12.GetWalletBalanceResponse> getWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetWalletBalanceRequest> request) async {
    return getWalletBalance(call, await request);
  }

  $async.Future<$12.BatchCreateWalletsResponse> batchCreateWallets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.BatchCreateWalletsRequest> request) async {
    return batchCreateWallets(call, await request);
  }

  $async.Future<$12.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$12.GetWatchlistsResponse> getWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetWatchlistsRequest> request) async {
    return getWatchlists(call, await request);
  }

  $async.Future<$12.AddToWatchlistResponse> addToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.AddToWatchlistRequest> request) async {
    return addToWatchlist(call, await request);
  }

  $async.Future<$12.RemoveFromWatchlistResponse> removeFromWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.RemoveFromWatchlistRequest> request) async {
    return removeFromWatchlist(call, await request);
  }

  $async.Future<$12.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$12.ToggleFavoriteResponse> toggleFavorite_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ToggleFavoriteRequest> request) async {
    return toggleFavorite(call, await request);
  }

  $async.Future<$12.GetCryptoNewsResponse> getCryptoNews_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetCryptoNewsRequest> request) async {
    return getCryptoNews(call, await request);
  }

  $async.Future<$12.GetOHLCVResponse> getOHLCV_Pre($grpc.ServiceCall call,
      $async.Future<$12.GetOHLCVRequest> request) async {
    return getOHLCV(call, await request);
  }

  $async.Future<$12.GetOrderBookResponse> getOrderBook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetOrderBookRequest> request) async {
    return getOrderBook(call, await request);
  }

  $async.Future<$12.GetRecentTradesResponse> getRecentTrades_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetRecentTradesRequest> request) async {
    return getRecentTrades(call, await request);
  }

  $async.Future<$12.GetFearGreedIndexResponse> getFearGreedIndex_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetFearGreedIndexRequest> request) async {
    return getFearGreedIndex(call, await request);
  }

  $async.Future<$12.CreatePriceAlertResponse> createPriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreatePriceAlertRequest> request) async {
    return createPriceAlert(call, await request);
  }

  $async.Future<$12.GetPriceAlertsResponse> getPriceAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetPriceAlertsRequest> request) async {
    return getPriceAlerts(call, await request);
  }

  $async.Future<$12.DeletePriceAlertResponse> deletePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeletePriceAlertRequest> request) async {
    return deletePriceAlert(call, await request);
  }

  $async.Future<$12.GetPlatformCryptoPortfolioResponse>
      getPlatformCryptoPortfolio_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetPlatformCryptoPortfolioRequest> request) async {
    return getPlatformCryptoPortfolio(call, await request);
  }

  $async.Future<$12.GetPlatformCryptoTransactionsResponse>
      getPlatformCryptoTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$12.GetPlatformCryptoTransactionsRequest>
              request) async {
    return getPlatformCryptoTransactions(call, await request);
  }

  $async.Future<$12.GetFeeTiersResponse> getFeeTiers_Pre($grpc.ServiceCall call,
      $async.Future<$12.GetFeeTiersRequest> request) async {
    return getFeeTiers(call, await request);
  }

  $async.Future<$12.CreateFeeTierResponse> createFeeTier_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreateFeeTierRequest> request) async {
    return createFeeTier(call, await request);
  }

  $async.Future<$12.UpdateFeeTierResponse> updateFeeTier_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateFeeTierRequest> request) async {
    return updateFeeTier(call, await request);
  }

  $async.Future<$12.DeleteFeeTierResponse> deleteFeeTier_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeleteFeeTierRequest> request) async {
    return deleteFeeTier(call, await request);
  }

  $async.Future<$12.ReconciliationResult> runReconciliation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.RunReconciliationRequest> request) async {
    return runReconciliation(call, await request);
  }

  $async.Future<$12.GetReconciliationLogsResponse> getReconciliationLogs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetReconciliationLogsRequest> request) async {
    return getReconciliationLogs(call, await request);
  }

  $async.Future<$12.GetSpreadConfigResponse> getSpreadConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetSpreadConfigRequest> request) async {
    return getSpreadConfig(call, await request);
  }

  $async.Future<$12.UpdateSpreadConfigResponse> updateSpreadConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateSpreadConfigRequest> request) async {
    return updateSpreadConfig(call, await request);
  }

  $async.Future<$12.GetFeeConfigResponse> getFeeConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetFeeConfigRequest> request) async {
    return getFeeConfig(call, await request);
  }

  $async.Future<$12.UpdateFeeConfigResponse> updateFeeConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateFeeConfigRequest> request) async {
    return updateFeeConfig(call, await request);
  }

  $async.Future<$12.GetWalletReconciliationsResponse>
      getWalletReconciliations_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetWalletReconciliationsRequest> request) async {
    return getWalletReconciliations(call, await request);
  }

  $async.Future<$12.TriggerWalletReconciliationResponse>
      triggerWalletReconciliation_Pre($grpc.ServiceCall call,
          $async.Future<$12.TriggerWalletReconciliationRequest> request) async {
    return triggerWalletReconciliation(call, await request);
  }

  $async.Future<$12.GetSettlementsResponse> getSettlements_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetSettlementsRequest> request) async {
    return getSettlements(call, await request);
  }

  $async.Future<$12.MarkSettlementsPaidResponse> markSettlementsPaid_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.MarkSettlementsPaidRequest> request) async {
    return markSettlementsPaid(call, await request);
  }

  $async.Future<$12.GetTransactionDetailResponse> getTransactionDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetTransactionDetailRequest> request) async {
    return getTransactionDetail(call, await request);
  }

  $async.Future<$12.RetryTransactionResponse> retryTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.RetryTransactionRequest> request) async {
    return retryTransaction(call, await request);
  }

  $async.Future<$12.ReverseTransactionResponse> reverseTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ReverseTransactionRequest> request) async {
    return reverseTransaction(call, await request);
  }

  $async.Future<$12.GetUserCryptoAuditTrailResponse>
      getUserCryptoAuditTrail_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetUserCryptoAuditTrailRequest> request) async {
    return getUserCryptoAuditTrail(call, await request);
  }

  $async.Future<$12.SetTradingSuspensionResponse> setTradingSuspension_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.SetTradingSuspensionRequest> request) async {
    return setTradingSuspension(call, await request);
  }

  $async.Future<$12.GetTradingSuspensionResponse> getTradingSuspension_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetTradingSuspensionRequest> request) async {
    return getTradingSuspension(call, await request);
  }

  $async.Future<$12.SetUserCryptoFreezeResponse> setUserCryptoFreeze_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.SetUserCryptoFreezeRequest> request) async {
    return setUserCryptoFreeze(call, await request);
  }

  $async.Future<$12.GetUserCryptoFreezeResponse> getUserCryptoFreeze_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetUserCryptoFreezeRequest> request) async {
    return getUserCryptoFreeze(call, await request);
  }

  $async.Future<$12.GetCryptosResponse> getCryptos(
      $grpc.ServiceCall call, $12.GetCryptosRequest request);
  $async.Future<$12.GetCryptoByIdResponse> getCryptoById(
      $grpc.ServiceCall call, $12.GetCryptoByIdRequest request);
  $async.Future<$12.SearchCryptosResponse> searchCryptos(
      $grpc.ServiceCall call, $12.SearchCryptosRequest request);
  $async.Future<$12.GetCryptoPriceHistoryResponse> getCryptoPriceHistory(
      $grpc.ServiceCall call, $12.GetCryptoPriceHistoryRequest request);
  $async.Future<$12.GetTrendingCryptosResponse> getTrendingCryptos(
      $grpc.ServiceCall call, $12.GetTrendingCryptosRequest request);
  $async.Future<$12.GetTopCryptosResponse> getTopCryptos(
      $grpc.ServiceCall call, $12.GetTopCryptosRequest request);
  $async.Future<$12.GetMarketChartResponse> getMarketChart(
      $grpc.ServiceCall call, $12.GetMarketChartRequest request);
  $async.Future<$12.GetGlobalMarketDataResponse> getGlobalMarketData(
      $grpc.ServiceCall call, $12.GetGlobalMarketDataRequest request);
  $async.Future<$12.GetSupportedAssetsResponse> getSupportedAssets(
      $grpc.ServiceCall call, $12.GetSupportedAssetsRequest request);
  $async.Future<$12.GetCryptoFiatRateResponse> getCryptoFiatRate(
      $grpc.ServiceCall call, $12.GetCryptoFiatRateRequest request);
  $async.Future<$12.GetCryptoHoldingsResponse> getCryptoHoldings(
      $grpc.ServiceCall call, $12.GetCryptoHoldingsRequest request);
  $async.Future<$12.GetCryptoTransactionsResponse> getCryptoTransactions(
      $grpc.ServiceCall call, $12.GetCryptoTransactionsRequest request);
  $async.Future<$12.BuyCryptoResponse> buyCrypto(
      $grpc.ServiceCall call, $12.BuyCryptoRequest request);
  $async.Future<$12.SellCryptoResponse> sellCrypto(
      $grpc.ServiceCall call, $12.SellCryptoRequest request);
  $async.Future<$12.ConvertCryptoResponse> convertCrypto(
      $grpc.ServiceCall call, $12.ConvertCryptoRequest request);
  $async.Future<$12.GetWalletsResponse> getWallets(
      $grpc.ServiceCall call, $12.GetWalletsRequest request);
  $async.Future<$12.CreateWalletResponse> createWallet(
      $grpc.ServiceCall call, $12.CreateWalletRequest request);
  $async.Future<$12.GetWalletBalanceResponse> getWalletBalance(
      $grpc.ServiceCall call, $12.GetWalletBalanceRequest request);
  $async.Future<$12.BatchCreateWalletsResponse> batchCreateWallets(
      $grpc.ServiceCall call, $12.BatchCreateWalletsRequest request);
  $async.Future<$12.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $12.CreateWatchlistRequest request);
  $async.Future<$12.GetWatchlistsResponse> getWatchlists(
      $grpc.ServiceCall call, $12.GetWatchlistsRequest request);
  $async.Future<$12.AddToWatchlistResponse> addToWatchlist(
      $grpc.ServiceCall call, $12.AddToWatchlistRequest request);
  $async.Future<$12.RemoveFromWatchlistResponse> removeFromWatchlist(
      $grpc.ServiceCall call, $12.RemoveFromWatchlistRequest request);
  $async.Future<$12.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $12.DeleteWatchlistRequest request);
  $async.Future<$12.ToggleFavoriteResponse> toggleFavorite(
      $grpc.ServiceCall call, $12.ToggleFavoriteRequest request);
  $async.Future<$12.GetCryptoNewsResponse> getCryptoNews(
      $grpc.ServiceCall call, $12.GetCryptoNewsRequest request);
  $async.Future<$12.GetOHLCVResponse> getOHLCV(
      $grpc.ServiceCall call, $12.GetOHLCVRequest request);
  $async.Future<$12.GetOrderBookResponse> getOrderBook(
      $grpc.ServiceCall call, $12.GetOrderBookRequest request);
  $async.Future<$12.GetRecentTradesResponse> getRecentTrades(
      $grpc.ServiceCall call, $12.GetRecentTradesRequest request);
  $async.Future<$12.GetFearGreedIndexResponse> getFearGreedIndex(
      $grpc.ServiceCall call, $12.GetFearGreedIndexRequest request);
  $async.Future<$12.CreatePriceAlertResponse> createPriceAlert(
      $grpc.ServiceCall call, $12.CreatePriceAlertRequest request);
  $async.Future<$12.GetPriceAlertsResponse> getPriceAlerts(
      $grpc.ServiceCall call, $12.GetPriceAlertsRequest request);
  $async.Future<$12.DeletePriceAlertResponse> deletePriceAlert(
      $grpc.ServiceCall call, $12.DeletePriceAlertRequest request);
  $async.Future<$12.GetPlatformCryptoPortfolioResponse>
      getPlatformCryptoPortfolio($grpc.ServiceCall call,
          $12.GetPlatformCryptoPortfolioRequest request);
  $async.Future<$12.GetPlatformCryptoTransactionsResponse>
      getPlatformCryptoTransactions($grpc.ServiceCall call,
          $12.GetPlatformCryptoTransactionsRequest request);
  $async.Future<$12.GetFeeTiersResponse> getFeeTiers(
      $grpc.ServiceCall call, $12.GetFeeTiersRequest request);
  $async.Future<$12.CreateFeeTierResponse> createFeeTier(
      $grpc.ServiceCall call, $12.CreateFeeTierRequest request);
  $async.Future<$12.UpdateFeeTierResponse> updateFeeTier(
      $grpc.ServiceCall call, $12.UpdateFeeTierRequest request);
  $async.Future<$12.DeleteFeeTierResponse> deleteFeeTier(
      $grpc.ServiceCall call, $12.DeleteFeeTierRequest request);
  $async.Future<$12.ReconciliationResult> runReconciliation(
      $grpc.ServiceCall call, $12.RunReconciliationRequest request);
  $async.Future<$12.GetReconciliationLogsResponse> getReconciliationLogs(
      $grpc.ServiceCall call, $12.GetReconciliationLogsRequest request);
  $async.Future<$12.GetSpreadConfigResponse> getSpreadConfig(
      $grpc.ServiceCall call, $12.GetSpreadConfigRequest request);
  $async.Future<$12.UpdateSpreadConfigResponse> updateSpreadConfig(
      $grpc.ServiceCall call, $12.UpdateSpreadConfigRequest request);
  $async.Future<$12.GetFeeConfigResponse> getFeeConfig(
      $grpc.ServiceCall call, $12.GetFeeConfigRequest request);
  $async.Future<$12.UpdateFeeConfigResponse> updateFeeConfig(
      $grpc.ServiceCall call, $12.UpdateFeeConfigRequest request);
  $async.Future<$12.GetWalletReconciliationsResponse> getWalletReconciliations(
      $grpc.ServiceCall call, $12.GetWalletReconciliationsRequest request);
  $async.Future<$12.TriggerWalletReconciliationResponse>
      triggerWalletReconciliation($grpc.ServiceCall call,
          $12.TriggerWalletReconciliationRequest request);
  $async.Future<$12.GetSettlementsResponse> getSettlements(
      $grpc.ServiceCall call, $12.GetSettlementsRequest request);
  $async.Future<$12.MarkSettlementsPaidResponse> markSettlementsPaid(
      $grpc.ServiceCall call, $12.MarkSettlementsPaidRequest request);
  $async.Future<$12.GetTransactionDetailResponse> getTransactionDetail(
      $grpc.ServiceCall call, $12.GetTransactionDetailRequest request);
  $async.Future<$12.RetryTransactionResponse> retryTransaction(
      $grpc.ServiceCall call, $12.RetryTransactionRequest request);
  $async.Future<$12.ReverseTransactionResponse> reverseTransaction(
      $grpc.ServiceCall call, $12.ReverseTransactionRequest request);
  $async.Future<$12.GetUserCryptoAuditTrailResponse> getUserCryptoAuditTrail(
      $grpc.ServiceCall call, $12.GetUserCryptoAuditTrailRequest request);
  $async.Future<$12.SetTradingSuspensionResponse> setTradingSuspension(
      $grpc.ServiceCall call, $12.SetTradingSuspensionRequest request);
  $async.Future<$12.GetTradingSuspensionResponse> getTradingSuspension(
      $grpc.ServiceCall call, $12.GetTradingSuspensionRequest request);
  $async.Future<$12.SetUserCryptoFreezeResponse> setUserCryptoFreeze(
      $grpc.ServiceCall call, $12.SetUserCryptoFreezeRequest request);
  $async.Future<$12.GetUserCryptoFreezeResponse> getUserCryptoFreeze(
      $grpc.ServiceCall call, $12.GetUserCryptoFreezeRequest request);
}
