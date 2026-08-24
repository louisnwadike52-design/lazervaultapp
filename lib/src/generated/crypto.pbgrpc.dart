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
  static final _$getSpreadConfig =
      $grpc.ClientMethod<$0.GetSpreadConfigRequest, $0.GetSpreadConfigResponse>(
          '/pb.CryptoService/GetSpreadConfig',
          ($0.GetSpreadConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSpreadConfigResponse.fromBuffer(value));
  static final _$updateSpreadConfig = $grpc.ClientMethod<
          $0.UpdateSpreadConfigRequest, $0.UpdateSpreadConfigResponse>(
      '/pb.CryptoService/UpdateSpreadConfig',
      ($0.UpdateSpreadConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateSpreadConfigResponse.fromBuffer(value));
  static final _$getFeeConfig =
      $grpc.ClientMethod<$0.GetFeeConfigRequest, $0.GetFeeConfigResponse>(
          '/pb.CryptoService/GetFeeConfig',
          ($0.GetFeeConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetFeeConfigResponse.fromBuffer(value));
  static final _$updateFeeConfig =
      $grpc.ClientMethod<$0.UpdateFeeConfigRequest, $0.UpdateFeeConfigResponse>(
          '/pb.CryptoService/UpdateFeeConfig',
          ($0.UpdateFeeConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateFeeConfigResponse.fromBuffer(value));
  static final _$getWalletReconciliations = $grpc.ClientMethod<
          $0.GetWalletReconciliationsRequest,
          $0.GetWalletReconciliationsResponse>(
      '/pb.CryptoService/GetWalletReconciliations',
      ($0.GetWalletReconciliationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWalletReconciliationsResponse.fromBuffer(value));
  static final _$triggerWalletReconciliation = $grpc.ClientMethod<
          $0.TriggerWalletReconciliationRequest,
          $0.TriggerWalletReconciliationResponse>(
      '/pb.CryptoService/TriggerWalletReconciliation',
      ($0.TriggerWalletReconciliationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TriggerWalletReconciliationResponse.fromBuffer(value));
  static final _$getSettlements =
      $grpc.ClientMethod<$0.GetSettlementsRequest, $0.GetSettlementsResponse>(
          '/pb.CryptoService/GetSettlements',
          ($0.GetSettlementsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSettlementsResponse.fromBuffer(value));
  static final _$markSettlementsPaid = $grpc.ClientMethod<
          $0.MarkSettlementsPaidRequest, $0.MarkSettlementsPaidResponse>(
      '/pb.CryptoService/MarkSettlementsPaid',
      ($0.MarkSettlementsPaidRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkSettlementsPaidResponse.fromBuffer(value));
  static final _$getTransactionDetail = $grpc.ClientMethod<
          $0.GetTransactionDetailRequest, $0.GetTransactionDetailResponse>(
      '/pb.CryptoService/GetTransactionDetail',
      ($0.GetTransactionDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTransactionDetailResponse.fromBuffer(value));
  static final _$retryTransaction = $grpc.ClientMethod<
          $0.RetryTransactionRequest, $0.RetryTransactionResponse>(
      '/pb.CryptoService/RetryTransaction',
      ($0.RetryTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RetryTransactionResponse.fromBuffer(value));
  static final _$reverseTransaction = $grpc.ClientMethod<
          $0.ReverseTransactionRequest, $0.ReverseTransactionResponse>(
      '/pb.CryptoService/ReverseTransaction',
      ($0.ReverseTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ReverseTransactionResponse.fromBuffer(value));
  static final _$getUserCryptoAuditTrail = $grpc.ClientMethod<
          $0.GetUserCryptoAuditTrailRequest,
          $0.GetUserCryptoAuditTrailResponse>(
      '/pb.CryptoService/GetUserCryptoAuditTrail',
      ($0.GetUserCryptoAuditTrailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserCryptoAuditTrailResponse.fromBuffer(value));
  static final _$setTradingSuspension = $grpc.ClientMethod<
          $0.SetTradingSuspensionRequest, $0.SetTradingSuspensionResponse>(
      '/pb.CryptoService/SetTradingSuspension',
      ($0.SetTradingSuspensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SetTradingSuspensionResponse.fromBuffer(value));
  static final _$getTradingSuspension = $grpc.ClientMethod<
          $0.GetTradingSuspensionRequest, $0.GetTradingSuspensionResponse>(
      '/pb.CryptoService/GetTradingSuspension',
      ($0.GetTradingSuspensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTradingSuspensionResponse.fromBuffer(value));
  static final _$setUserCryptoFreeze = $grpc.ClientMethod<
          $0.SetUserCryptoFreezeRequest, $0.SetUserCryptoFreezeResponse>(
      '/pb.CryptoService/SetUserCryptoFreeze',
      ($0.SetUserCryptoFreezeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SetUserCryptoFreezeResponse.fromBuffer(value));
  static final _$getUserCryptoFreeze = $grpc.ClientMethod<
          $0.GetUserCryptoFreezeRequest, $0.GetUserCryptoFreezeResponse>(
      '/pb.CryptoService/GetUserCryptoFreeze',
      ($0.GetUserCryptoFreezeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserCryptoFreezeResponse.fromBuffer(value));
  static final _$getCryptoConfig =
      $grpc.ClientMethod<$0.GetCryptoConfigRequest, $0.GetCryptoConfigResponse>(
          '/pb.CryptoService/GetCryptoConfig',
          ($0.GetCryptoConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCryptoConfigResponse.fromBuffer(value));
  static final _$withdraw =
      $grpc.ClientMethod<$0.WithdrawRequest, $0.WithdrawResponse>(
          '/pb.CryptoService/Withdraw',
          ($0.WithdrawRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WithdrawResponse.fromBuffer(value));
  static final _$getCryptoWithdrawalStatus = $grpc.ClientMethod<
          $0.GetCryptoWithdrawalStatusRequest,
          $0.GetCryptoWithdrawalStatusResponse>(
      '/pb.CryptoService/GetCryptoWithdrawalStatus',
      ($0.GetCryptoWithdrawalStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCryptoWithdrawalStatusResponse.fromBuffer(value));
  static final _$getUserCryptoWithdrawals = $grpc.ClientMethod<
          $0.GetUserCryptoWithdrawalsRequest,
          $0.GetUserCryptoWithdrawalsResponse>(
      '/pb.CryptoService/GetUserCryptoWithdrawals',
      ($0.GetUserCryptoWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserCryptoWithdrawalsResponse.fromBuffer(value));
  static final _$getSupportedAssetNetworks = $grpc.ClientMethod<
          $0.GetSupportedAssetNetworksRequest,
          $0.GetSupportedAssetNetworksResponse>(
      '/pb.CryptoService/GetSupportedAssetNetworks',
      ($0.GetSupportedAssetNetworksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSupportedAssetNetworksResponse.fromBuffer(value));
  static final _$getAssetNetworkStatus = $grpc.ClientMethod<
          $0.GetAssetNetworkStatusRequest, $0.GetAssetNetworkStatusResponse>(
      '/pb.CryptoService/GetAssetNetworkStatus',
      ($0.GetAssetNetworkStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAssetNetworkStatusResponse.fromBuffer(value));
  static final _$getCryptoEligibility = $grpc.ClientMethod<
          $0.GetCryptoEligibilityRequest, $0.GetCryptoEligibilityResponse>(
      '/pb.CryptoService/GetCryptoEligibility',
      ($0.GetCryptoEligibilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCryptoEligibilityResponse.fromBuffer(value));
  static final _$ensureWalletAddress = $grpc.ClientMethod<
          $0.EnsureWalletAddressRequest, $0.EnsureWalletAddressResponse>(
      '/pb.CryptoService/EnsureWalletAddress',
      ($0.EnsureWalletAddressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.EnsureWalletAddressResponse.fromBuffer(value));
  static final _$resolveRecipientWallet = $grpc.ClientMethod<
          $0.ResolveRecipientWalletRequest, $0.ResolveRecipientWalletResponse>(
      '/pb.CryptoService/ResolveRecipientWallet',
      ($0.ResolveRecipientWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResolveRecipientWalletResponse.fromBuffer(value));
  static final _$getUserCryptoDeposits = $grpc.ClientMethod<
          $0.GetUserCryptoDepositsRequest, $0.GetUserCryptoDepositsResponse>(
      '/pb.CryptoService/GetUserCryptoDeposits',
      ($0.GetUserCryptoDepositsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserCryptoDepositsResponse.fromBuffer(value));
  static final _$adminListAssetNetworks = $grpc.ClientMethod<
          $0.AdminListAssetNetworksRequest, $0.AdminListAssetNetworksResponse>(
      '/pb.CryptoService/AdminListAssetNetworks',
      ($0.AdminListAssetNetworksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListAssetNetworksResponse.fromBuffer(value));
  static final _$adminUpdateAssetNetwork = $grpc.ClientMethod<
          $0.AdminUpdateAssetNetworkRequest,
          $0.AdminUpdateAssetNetworkResponse>(
      '/pb.CryptoService/AdminUpdateAssetNetwork',
      ($0.AdminUpdateAssetNetworkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminUpdateAssetNetworkResponse.fromBuffer(value));
  static final _$adminListSupportedMarkets = $grpc.ClientMethod<
          $0.AdminListSupportedMarketsRequest,
          $0.AdminListSupportedMarketsResponse>(
      '/pb.CryptoService/AdminListSupportedMarkets',
      ($0.AdminListSupportedMarketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListSupportedMarketsResponse.fromBuffer(value));
  static final _$adminUpdateSupportedMarket = $grpc.ClientMethod<
          $0.AdminUpdateSupportedMarketRequest,
          $0.AdminUpdateSupportedMarketResponse>(
      '/pb.CryptoService/AdminUpdateSupportedMarket',
      ($0.AdminUpdateSupportedMarketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminUpdateSupportedMarketResponse.fromBuffer(value));
  static final _$adminListAssets =
      $grpc.ClientMethod<$0.AdminListAssetsRequest, $0.AdminListAssetsResponse>(
          '/pb.CryptoService/AdminListAssets',
          ($0.AdminListAssetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AdminListAssetsResponse.fromBuffer(value));
  static final _$adminSetAssetOverride = $grpc.ClientMethod<
          $0.AdminSetAssetOverrideRequest, $0.AdminSetAssetOverrideResponse>(
      '/pb.CryptoService/AdminSetAssetOverride',
      ($0.AdminSetAssetOverrideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminSetAssetOverrideResponse.fromBuffer(value));
  static final _$adminSetGlobalAssetVisibility = $grpc.ClientMethod<
          $0.AdminSetGlobalAssetVisibilityRequest,
          $0.AdminSetGlobalAssetVisibilityResponse>(
      '/pb.CryptoService/AdminSetGlobalAssetVisibility',
      ($0.AdminSetGlobalAssetVisibilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminSetGlobalAssetVisibilityResponse.fromBuffer(value));
  static final _$adminGetBridgeMetrics = $grpc.ClientMethod<
          $0.AdminGetBridgeMetricsRequest, $0.AdminGetBridgeMetricsResponse>(
      '/pb.CryptoService/AdminGetBridgeMetrics',
      ($0.AdminGetBridgeMetricsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetBridgeMetricsResponse.fromBuffer(value));
  static final _$adminToggleBridge = $grpc.ClientMethod<
          $0.AdminToggleBridgeRequest, $0.AdminToggleBridgeResponse>(
      '/pb.CryptoService/AdminToggleBridge',
      ($0.AdminToggleBridgeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminToggleBridgeResponse.fromBuffer(value));
  static final _$adminListCompensations = $grpc.ClientMethod<
          $0.AdminListCompensationsRequest, $0.AdminListCompensationsResponse>(
      '/pb.CryptoService/AdminListCompensations',
      ($0.AdminListCompensationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListCompensationsResponse.fromBuffer(value));
  static final _$adminGetCompensationDetail = $grpc.ClientMethod<
          $0.AdminGetCompensationDetailRequest,
          $0.AdminGetCompensationDetailResponse>(
      '/pb.CryptoService/AdminGetCompensationDetail',
      ($0.AdminGetCompensationDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetCompensationDetailResponse.fromBuffer(value));
  static final _$adminRetryCompensation = $grpc.ClientMethod<
          $0.AdminRetryCompensationRequest, $0.AdminRetryCompensationResponse>(
      '/pb.CryptoService/AdminRetryCompensation',
      ($0.AdminRetryCompensationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminRetryCompensationResponse.fromBuffer(value));
  static final _$adminWriteOffCompensation = $grpc.ClientMethod<
          $0.AdminWriteOffCompensationRequest,
          $0.AdminWriteOffCompensationResponse>(
      '/pb.CryptoService/AdminWriteOffCompensation',
      ($0.AdminWriteOffCompensationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminWriteOffCompensationResponse.fromBuffer(value));
  static final _$createSwapQuote =
      $grpc.ClientMethod<$0.CreateSwapQuoteRequest, $0.CreateSwapQuoteResponse>(
          '/pb.CryptoService/CreateSwapQuote',
          ($0.CreateSwapQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateSwapQuoteResponse.fromBuffer(value));
  static final _$refreshSwapQuote = $grpc.ClientMethod<
          $0.RefreshSwapQuoteRequest, $0.RefreshSwapQuoteResponse>(
      '/pb.CryptoService/RefreshSwapQuote',
      ($0.RefreshSwapQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RefreshSwapQuoteResponse.fromBuffer(value));
  static final _$confirmSwap =
      $grpc.ClientMethod<$0.ConfirmSwapRequest, $0.ConfirmSwapResponse>(
          '/pb.CryptoService/ConfirmSwap',
          ($0.ConfirmSwapRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ConfirmSwapResponse.fromBuffer(value));
  static final _$getSwapStatus =
      $grpc.ClientMethod<$0.GetSwapStatusRequest, $0.GetSwapStatusResponse>(
          '/pb.CryptoService/GetSwapStatus',
          ($0.GetSwapStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSwapStatusResponse.fromBuffer(value));
  static final _$adminGetMasterFloat = $grpc.ClientMethod<
          $0.AdminGetMasterFloatRequest, $0.AdminGetMasterFloatResponse>(
      '/pb.CryptoService/AdminGetMasterFloat',
      ($0.AdminGetMasterFloatRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetMasterFloatResponse.fromBuffer(value));
  static final _$adminTriggerMasterFloatRecon = $grpc.ClientMethod<
          $0.AdminTriggerMasterFloatReconRequest,
          $0.AdminTriggerMasterFloatReconResponse>(
      '/pb.CryptoService/AdminTriggerMasterFloatRecon',
      ($0.AdminTriggerMasterFloatReconRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminTriggerMasterFloatReconResponse.fromBuffer(value));
  static final _$adminPushMasterFloat = $grpc.ClientMethod<
          $0.AdminPushMasterFloatRequest, $0.AdminPushMasterFloatResponse>(
      '/pb.CryptoService/AdminPushMasterFloat',
      ($0.AdminPushMasterFloatRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminPushMasterFloatResponse.fromBuffer(value));
  static final _$adminListSwapTransactions = $grpc.ClientMethod<
          $0.AdminListSwapTransactionsRequest,
          $0.AdminListSwapTransactionsResponse>(
      '/pb.CryptoService/AdminListSwapTransactions',
      ($0.AdminListSwapTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListSwapTransactionsResponse.fromBuffer(value));
  static final _$adminGetSwapTransactionDetail = $grpc.ClientMethod<
          $0.AdminGetSwapTransactionDetailRequest,
          $0.AdminGetSwapTransactionDetailResponse>(
      '/pb.CryptoService/AdminGetSwapTransactionDetail',
      ($0.AdminGetSwapTransactionDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetSwapTransactionDetailResponse.fromBuffer(value));
  static final _$adminGetCryptoRevenueSummary = $grpc.ClientMethod<
          $0.AdminGetCryptoRevenueSummaryRequest,
          $0.AdminGetCryptoRevenueSummaryResponse>(
      '/pb.CryptoService/AdminGetCryptoRevenueSummary',
      ($0.AdminGetCryptoRevenueSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetCryptoRevenueSummaryResponse.fromBuffer(value));
  static final _$adminListRollbacks = $grpc.ClientMethod<
          $0.AdminListRollbacksRequest, $0.AdminListRollbacksResponse>(
      '/pb.CryptoService/AdminListRollbacks',
      ($0.AdminListRollbacksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListRollbacksResponse.fromBuffer(value));
  static final _$adminRetryRollbackPhase = $grpc.ClientMethod<
          $0.AdminRetryRollbackPhaseRequest,
          $0.AdminRetryRollbackPhaseResponse>(
      '/pb.CryptoService/AdminRetryRollbackPhase',
      ($0.AdminRetryRollbackPhaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminRetryRollbackPhaseResponse.fromBuffer(value));
  static final _$adminGetQuidaxConfig = $grpc.ClientMethod<
          $0.AdminGetQuidaxConfigRequest, $0.AdminGetQuidaxConfigResponse>(
      '/pb.CryptoService/AdminGetQuidaxConfig',
      ($0.AdminGetQuidaxConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetQuidaxConfigResponse.fromBuffer(value));
  static final _$adminUpdateQuidaxConfig = $grpc.ClientMethod<
          $0.AdminUpdateQuidaxConfigRequest,
          $0.AdminUpdateQuidaxConfigResponse>(
      '/pb.CryptoService/AdminUpdateQuidaxConfig',
      ($0.AdminUpdateQuidaxConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminUpdateQuidaxConfigResponse.fromBuffer(value));
  static final _$adminListStuckSwaps = $grpc.ClientMethod<
          $0.AdminListStuckSwapsRequest, $0.AdminListStuckSwapsResponse>(
      '/pb.CryptoService/AdminListStuckSwaps',
      ($0.AdminListStuckSwapsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListStuckSwapsResponse.fromBuffer(value));
  static final _$adminGetCryptoRevenueTimeseries = $grpc.ClientMethod<
          $0.AdminGetCryptoRevenueTimeseriesRequest,
          $0.AdminGetCryptoRevenueTimeseriesResponse>(
      '/pb.CryptoService/AdminGetCryptoRevenueTimeseries',
      ($0.AdminGetCryptoRevenueTimeseriesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetCryptoRevenueTimeseriesResponse.fromBuffer(value));
  static final _$adminListTriageQueue = $grpc.ClientMethod<
          $0.AdminListTriageQueueRequest, $0.AdminListTriageQueueResponse>(
      '/pb.CryptoService/AdminListTriageQueue',
      ($0.AdminListTriageQueueRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListTriageQueueResponse.fromBuffer(value));
  static final _$adminGetSubAccount = $grpc.ClientMethod<
          $0.AdminGetSubAccountRequest, $0.AdminGetSubAccountResponse>(
      '/pb.CryptoService/AdminGetSubAccount',
      ($0.AdminGetSubAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetSubAccountResponse.fromBuffer(value));
  static final _$adminListSubAccounts = $grpc.ClientMethod<
          $0.AdminListSubAccountsRequest, $0.AdminListSubAccountsResponse>(
      '/pb.CryptoService/AdminListSubAccounts',
      ($0.AdminListSubAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListSubAccountsResponse.fromBuffer(value));
  static final _$adminListDeposits = $grpc.ClientMethod<
          $0.AdminListDepositsRequest, $0.AdminListDepositsResponse>(
      '/pb.CryptoService/AdminListDeposits',
      ($0.AdminListDepositsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListDepositsResponse.fromBuffer(value));
  static final _$adminListWithdrawals = $grpc.ClientMethod<
          $0.AdminListWithdrawalsRequest, $0.AdminListWithdrawalsResponse>(
      '/pb.CryptoService/AdminListWithdrawals',
      ($0.AdminListWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListWithdrawalsResponse.fromBuffer(value));
  static final _$adminListUserWithdrawals = $grpc.ClientMethod<
          $0.AdminListUserWithdrawalsRequest,
          $0.AdminListUserWithdrawalsResponse>(
      '/pb.CryptoService/AdminListUserWithdrawals',
      ($0.AdminListUserWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListUserWithdrawalsResponse.fromBuffer(value));
  static final _$adminListWalletAddresses = $grpc.ClientMethod<
          $0.AdminListWalletAddressesRequest,
          $0.AdminListWalletAddressesResponse>(
      '/pb.CryptoService/AdminListWalletAddresses',
      ($0.AdminListWalletAddressesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListWalletAddressesResponse.fromBuffer(value));
  static final _$adminListOrphanWebhooks = $grpc.ClientMethod<
          $0.AdminListOrphanWebhooksRequest,
          $0.AdminListOrphanWebhooksResponse>(
      '/pb.CryptoService/AdminListOrphanWebhooks',
      ($0.AdminListOrphanWebhooksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListOrphanWebhooksResponse.fromBuffer(value));
  static final _$adminDropOrphanWebhook = $grpc.ClientMethod<
          $0.AdminDropOrphanWebhookRequest, $0.AdminDropOrphanWebhookResponse>(
      '/pb.CryptoService/AdminDropOrphanWebhook',
      ($0.AdminDropOrphanWebhookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminDropOrphanWebhookResponse.fromBuffer(value));
  static final _$adminGetRollbackDetail = $grpc.ClientMethod<
          $0.AdminGetRollbackDetailRequest, $0.AdminGetRollbackDetailResponse>(
      '/pb.CryptoService/AdminGetRollbackDetail',
      ($0.AdminGetRollbackDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetRollbackDetailResponse.fromBuffer(value));
  static final _$getPriceAlertWorkerStatus = $grpc.ClientMethod<
          $0.GetPriceAlertWorkerStatusRequest,
          $0.GetPriceAlertWorkerStatusResponse>(
      '/pb.CryptoService/GetPriceAlertWorkerStatus',
      ($0.GetPriceAlertWorkerStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPriceAlertWorkerStatusResponse.fromBuffer(value));
  static final _$updatePriceAlertWorkerConfig = $grpc.ClientMethod<
          $0.UpdatePriceAlertWorkerConfigRequest,
          $0.UpdatePriceAlertWorkerConfigResponse>(
      '/pb.CryptoService/UpdatePriceAlertWorkerConfig',
      ($0.UpdatePriceAlertWorkerConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdatePriceAlertWorkerConfigResponse.fromBuffer(value));
  static final _$triggerPriceAlertWorkerNow = $grpc.ClientMethod<
          $0.TriggerPriceAlertWorkerNowRequest,
          $0.TriggerPriceAlertWorkerNowResponse>(
      '/pb.CryptoService/TriggerPriceAlertWorkerNow',
      ($0.TriggerPriceAlertWorkerNowRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TriggerPriceAlertWorkerNowResponse.fromBuffer(value));
  static final _$adminListPriceAlerts = $grpc.ClientMethod<
          $0.AdminListPriceAlertsRequest, $0.AdminListPriceAlertsResponse>(
      '/pb.CryptoService/AdminListPriceAlerts',
      ($0.AdminListPriceAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListPriceAlertsResponse.fromBuffer(value));
  static final _$adminForceTriggerPriceAlert = $grpc.ClientMethod<
          $0.AdminForceTriggerPriceAlertRequest,
          $0.AdminForceTriggerPriceAlertResponse>(
      '/pb.CryptoService/AdminForceTriggerPriceAlert',
      ($0.AdminForceTriggerPriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminForceTriggerPriceAlertResponse.fromBuffer(value));
  static final _$adminDisablePriceAlert = $grpc.ClientMethod<
          $0.AdminDisablePriceAlertRequest, $0.AdminDisablePriceAlertResponse>(
      '/pb.CryptoService/AdminDisablePriceAlert',
      ($0.AdminDisablePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminDisablePriceAlertResponse.fromBuffer(value));
  static final _$createAutoOrder =
      $grpc.ClientMethod<$0.CreateAutoOrderRequest, $0.CreateAutoOrderResponse>(
          '/pb.CryptoService/CreateAutoOrder',
          ($0.CreateAutoOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateAutoOrderResponse.fromBuffer(value));
  static final _$listAutoOrders =
      $grpc.ClientMethod<$0.ListAutoOrdersRequest, $0.ListAutoOrdersResponse>(
          '/pb.CryptoService/ListAutoOrders',
          ($0.ListAutoOrdersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListAutoOrdersResponse.fromBuffer(value));
  static final _$cancelAutoOrder =
      $grpc.ClientMethod<$0.CancelAutoOrderRequest, $0.CancelAutoOrderResponse>(
          '/pb.CryptoService/CancelAutoOrder',
          ($0.CancelAutoOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelAutoOrderResponse.fromBuffer(value));
  static final _$getAutoOrderWorkerStatus = $grpc.ClientMethod<
          $0.GetAutoOrderWorkerStatusRequest,
          $0.GetAutoOrderWorkerStatusResponse>(
      '/pb.CryptoService/GetAutoOrderWorkerStatus',
      ($0.GetAutoOrderWorkerStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAutoOrderWorkerStatusResponse.fromBuffer(value));
  static final _$updateAutoOrderWorkerConfig = $grpc.ClientMethod<
          $0.UpdateAutoOrderWorkerConfigRequest,
          $0.UpdateAutoOrderWorkerConfigResponse>(
      '/pb.CryptoService/UpdateAutoOrderWorkerConfig',
      ($0.UpdateAutoOrderWorkerConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAutoOrderWorkerConfigResponse.fromBuffer(value));
  static final _$triggerAutoOrderWorkerNow = $grpc.ClientMethod<
          $0.TriggerAutoOrderWorkerNowRequest,
          $0.TriggerAutoOrderWorkerNowResponse>(
      '/pb.CryptoService/TriggerAutoOrderWorkerNow',
      ($0.TriggerAutoOrderWorkerNowRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TriggerAutoOrderWorkerNowResponse.fromBuffer(value));
  static final _$adminListAutoOrders = $grpc.ClientMethod<
          $0.AdminListAutoOrdersRequest, $0.AdminListAutoOrdersResponse>(
      '/pb.CryptoService/AdminListAutoOrders',
      ($0.AdminListAutoOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListAutoOrdersResponse.fromBuffer(value));
  static final _$adminCancelAutoOrder = $grpc.ClientMethod<
          $0.AdminCancelAutoOrderRequest, $0.AdminCancelAutoOrderResponse>(
      '/pb.CryptoService/AdminCancelAutoOrder',
      ($0.AdminCancelAutoOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminCancelAutoOrderResponse.fromBuffer(value));
  static final _$adminListWatchlists = $grpc.ClientMethod<
          $0.AdminListWatchlistsRequest, $0.AdminListWatchlistsResponse>(
      '/pb.CryptoService/AdminListWatchlists',
      ($0.AdminListWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListWatchlistsResponse.fromBuffer(value));
  static final _$getLearnLessons =
      $grpc.ClientMethod<$0.GetLearnLessonsRequest, $0.GetLearnLessonsResponse>(
          '/pb.CryptoService/GetLearnLessons',
          ($0.GetLearnLessonsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetLearnLessonsResponse.fromBuffer(value));
  static final _$adminListLearnLessons = $grpc.ClientMethod<
          $0.AdminListLearnLessonsRequest, $0.AdminListLearnLessonsResponse>(
      '/pb.CryptoService/AdminListLearnLessons',
      ($0.AdminListLearnLessonsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminListLearnLessonsResponse.fromBuffer(value));
  static final _$adminUpsertLearnLesson = $grpc.ClientMethod<
          $0.AdminUpsertLearnLessonRequest, $0.AdminUpsertLearnLessonResponse>(
      '/pb.CryptoService/AdminUpsertLearnLesson',
      ($0.AdminUpsertLearnLessonRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminUpsertLearnLessonResponse.fromBuffer(value));
  static final _$adminDeleteLearnLesson = $grpc.ClientMethod<
          $0.AdminDeleteLearnLessonRequest, $0.AdminDeleteLearnLessonResponse>(
      '/pb.CryptoService/AdminDeleteLearnLesson',
      ($0.AdminDeleteLearnLessonRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminDeleteLearnLessonResponse.fromBuffer(value));

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

  $grpc.ResponseFuture<$0.GetSpreadConfigResponse> getSpreadConfig(
      $0.GetSpreadConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpreadConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSpreadConfigResponse> updateSpreadConfig(
      $0.UpdateSpreadConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSpreadConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFeeConfigResponse> getFeeConfig(
      $0.GetFeeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFeeConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateFeeConfigResponse> updateFeeConfig(
      $0.UpdateFeeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFeeConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWalletReconciliationsResponse>
      getWalletReconciliations($0.GetWalletReconciliationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletReconciliations, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TriggerWalletReconciliationResponse>
      triggerWalletReconciliation($0.TriggerWalletReconciliationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerWalletReconciliation, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetSettlementsResponse> getSettlements(
      $0.GetSettlementsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSettlements, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkSettlementsPaidResponse> markSettlementsPaid(
      $0.MarkSettlementsPaidRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markSettlementsPaid, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionDetailResponse> getTransactionDetail(
      $0.GetTransactionDetailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionDetail, request, options: options);
  }

  $grpc.ResponseFuture<$0.RetryTransactionResponse> retryTransaction(
      $0.RetryTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReverseTransactionResponse> reverseTransaction(
      $0.ReverseTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reverseTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCryptoAuditTrailResponse>
      getUserCryptoAuditTrail($0.GetUserCryptoAuditTrailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCryptoAuditTrail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SetTradingSuspensionResponse> setTradingSuspension(
      $0.SetTradingSuspensionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setTradingSuspension, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTradingSuspensionResponse> getTradingSuspension(
      $0.GetTradingSuspensionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTradingSuspension, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetUserCryptoFreezeResponse> setUserCryptoFreeze(
      $0.SetUserCryptoFreezeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setUserCryptoFreeze, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCryptoFreezeResponse> getUserCryptoFreeze(
      $0.GetUserCryptoFreezeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCryptoFreeze, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoConfigResponse> getCryptoConfig(
      $0.GetCryptoConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawResponse> withdraw($0.WithdrawRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdraw, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoWithdrawalStatusResponse>
      getCryptoWithdrawalStatus($0.GetCryptoWithdrawalStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoWithdrawalStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCryptoWithdrawalsResponse>
      getUserCryptoWithdrawals($0.GetUserCryptoWithdrawalsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCryptoWithdrawals, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetSupportedAssetNetworksResponse>
      getSupportedAssetNetworks($0.GetSupportedAssetNetworksRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedAssetNetworks, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAssetNetworkStatusResponse> getAssetNetworkStatus(
      $0.GetAssetNetworkStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAssetNetworkStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoEligibilityResponse> getCryptoEligibility(
      $0.GetCryptoEligibilityRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoEligibility, request, options: options);
  }

  $grpc.ResponseFuture<$0.EnsureWalletAddressResponse> ensureWalletAddress(
      $0.EnsureWalletAddressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ensureWalletAddress, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResolveRecipientWalletResponse>
      resolveRecipientWallet($0.ResolveRecipientWalletRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveRecipientWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCryptoDepositsResponse> getUserCryptoDeposits(
      $0.GetUserCryptoDepositsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCryptoDeposits, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListAssetNetworksResponse>
      adminListAssetNetworks($0.AdminListAssetNetworksRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListAssetNetworks, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminUpdateAssetNetworkResponse>
      adminUpdateAssetNetwork($0.AdminUpdateAssetNetworkRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpdateAssetNetwork, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListSupportedMarketsResponse>
      adminListSupportedMarkets($0.AdminListSupportedMarketsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSupportedMarkets, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminUpdateSupportedMarketResponse>
      adminUpdateSupportedMarket($0.AdminUpdateSupportedMarketRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpdateSupportedMarket, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListAssetsResponse> adminListAssets(
      $0.AdminListAssetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListAssets, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminSetAssetOverrideResponse> adminSetAssetOverride(
      $0.AdminSetAssetOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminSetAssetOverride, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminSetGlobalAssetVisibilityResponse>
      adminSetGlobalAssetVisibility(
          $0.AdminSetGlobalAssetVisibilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminSetGlobalAssetVisibility, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetBridgeMetricsResponse> adminGetBridgeMetrics(
      $0.AdminGetBridgeMetricsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetBridgeMetrics, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminToggleBridgeResponse> adminToggleBridge(
      $0.AdminToggleBridgeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminToggleBridge, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListCompensationsResponse>
      adminListCompensations($0.AdminListCompensationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListCompensations, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetCompensationDetailResponse>
      adminGetCompensationDetail($0.AdminGetCompensationDetailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetCompensationDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminRetryCompensationResponse>
      adminRetryCompensation($0.AdminRetryCompensationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRetryCompensation, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminWriteOffCompensationResponse>
      adminWriteOffCompensation($0.AdminWriteOffCompensationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminWriteOffCompensation, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateSwapQuoteResponse> createSwapQuote(
      $0.CreateSwapQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSwapQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.RefreshSwapQuoteResponse> refreshSwapQuote(
      $0.RefreshSwapQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshSwapQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConfirmSwapResponse> confirmSwap(
      $0.ConfirmSwapRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$confirmSwap, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSwapStatusResponse> getSwapStatus(
      $0.GetSwapStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSwapStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetMasterFloatResponse> adminGetMasterFloat(
      $0.AdminGetMasterFloatRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetMasterFloat, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminTriggerMasterFloatReconResponse>
      adminTriggerMasterFloatRecon(
          $0.AdminTriggerMasterFloatReconRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminTriggerMasterFloatRecon, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminPushMasterFloatResponse> adminPushMasterFloat(
      $0.AdminPushMasterFloatRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminPushMasterFloat, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListSwapTransactionsResponse>
      adminListSwapTransactions($0.AdminListSwapTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSwapTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetSwapTransactionDetailResponse>
      adminGetSwapTransactionDetail(
          $0.AdminGetSwapTransactionDetailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetSwapTransactionDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetCryptoRevenueSummaryResponse>
      adminGetCryptoRevenueSummary(
          $0.AdminGetCryptoRevenueSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetCryptoRevenueSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListRollbacksResponse> adminListRollbacks(
      $0.AdminListRollbacksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListRollbacks, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminRetryRollbackPhaseResponse>
      adminRetryRollbackPhase($0.AdminRetryRollbackPhaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRetryRollbackPhase, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetQuidaxConfigResponse> adminGetQuidaxConfig(
      $0.AdminGetQuidaxConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetQuidaxConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminUpdateQuidaxConfigResponse>
      adminUpdateQuidaxConfig($0.AdminUpdateQuidaxConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpdateQuidaxConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListStuckSwapsResponse> adminListStuckSwaps(
      $0.AdminListStuckSwapsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListStuckSwaps, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetCryptoRevenueTimeseriesResponse>
      adminGetCryptoRevenueTimeseries(
          $0.AdminGetCryptoRevenueTimeseriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetCryptoRevenueTimeseries, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListTriageQueueResponse> adminListTriageQueue(
      $0.AdminListTriageQueueRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListTriageQueue, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetSubAccountResponse> adminGetSubAccount(
      $0.AdminGetSubAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetSubAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListSubAccountsResponse> adminListSubAccounts(
      $0.AdminListSubAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSubAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListDepositsResponse> adminListDeposits(
      $0.AdminListDepositsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListDeposits, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListWithdrawalsResponse> adminListWithdrawals(
      $0.AdminListWithdrawalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListWithdrawals, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListUserWithdrawalsResponse>
      adminListUserWithdrawals($0.AdminListUserWithdrawalsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListUserWithdrawals, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListWalletAddressesResponse>
      adminListWalletAddresses($0.AdminListWalletAddressesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListWalletAddresses, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListOrphanWebhooksResponse>
      adminListOrphanWebhooks($0.AdminListOrphanWebhooksRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListOrphanWebhooks, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminDropOrphanWebhookResponse>
      adminDropOrphanWebhook($0.AdminDropOrphanWebhookRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminDropOrphanWebhook, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetRollbackDetailResponse>
      adminGetRollbackDetail($0.AdminGetRollbackDetailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetRollbackDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetPriceAlertWorkerStatusResponse>
      getPriceAlertWorkerStatus($0.GetPriceAlertWorkerStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPriceAlertWorkerStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePriceAlertWorkerConfigResponse>
      updatePriceAlertWorkerConfig(
          $0.UpdatePriceAlertWorkerConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePriceAlertWorkerConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TriggerPriceAlertWorkerNowResponse>
      triggerPriceAlertWorkerNow($0.TriggerPriceAlertWorkerNowRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerPriceAlertWorkerNow, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListPriceAlertsResponse> adminListPriceAlerts(
      $0.AdminListPriceAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListPriceAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminForceTriggerPriceAlertResponse>
      adminForceTriggerPriceAlert($0.AdminForceTriggerPriceAlertRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminForceTriggerPriceAlert, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminDisablePriceAlertResponse>
      adminDisablePriceAlert($0.AdminDisablePriceAlertRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminDisablePriceAlert, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateAutoOrderResponse> createAutoOrder(
      $0.CreateAutoOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListAutoOrdersResponse> listAutoOrders(
      $0.ListAutoOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAutoOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelAutoOrderResponse> cancelAutoOrder(
      $0.CancelAutoOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelAutoOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoOrderWorkerStatusResponse>
      getAutoOrderWorkerStatus($0.GetAutoOrderWorkerStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoOrderWorkerStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoOrderWorkerConfigResponse>
      updateAutoOrderWorkerConfig($0.UpdateAutoOrderWorkerConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoOrderWorkerConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TriggerAutoOrderWorkerNowResponse>
      triggerAutoOrderWorkerNow($0.TriggerAutoOrderWorkerNowRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoOrderWorkerNow, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminListAutoOrdersResponse> adminListAutoOrders(
      $0.AdminListAutoOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListAutoOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminCancelAutoOrderResponse> adminCancelAutoOrder(
      $0.AdminCancelAutoOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminCancelAutoOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListWatchlistsResponse> adminListWatchlists(
      $0.AdminListWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLearnLessonsResponse> getLearnLessons(
      $0.GetLearnLessonsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLearnLessons, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListLearnLessonsResponse> adminListLearnLessons(
      $0.AdminListLearnLessonsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListLearnLessons, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminUpsertLearnLessonResponse>
      adminUpsertLearnLesson($0.AdminUpsertLearnLessonRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpsertLearnLesson, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminDeleteLearnLessonResponse>
      adminDeleteLearnLesson($0.AdminDeleteLearnLessonRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminDeleteLearnLesson, request,
        options: options);
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
    $addMethod($grpc.ServiceMethod<$0.GetSpreadConfigRequest,
            $0.GetSpreadConfigResponse>(
        'GetSpreadConfig',
        getSpreadConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSpreadConfigRequest.fromBuffer(value),
        ($0.GetSpreadConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSpreadConfigRequest,
            $0.UpdateSpreadConfigResponse>(
        'UpdateSpreadConfig',
        updateSpreadConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateSpreadConfigRequest.fromBuffer(value),
        ($0.UpdateSpreadConfigResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetFeeConfigRequest, $0.GetFeeConfigResponse>(
            'GetFeeConfig',
            getFeeConfig_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetFeeConfigRequest.fromBuffer(value),
            ($0.GetFeeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFeeConfigRequest,
            $0.UpdateFeeConfigResponse>(
        'UpdateFeeConfig',
        updateFeeConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateFeeConfigRequest.fromBuffer(value),
        ($0.UpdateFeeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWalletReconciliationsRequest,
            $0.GetWalletReconciliationsResponse>(
        'GetWalletReconciliations',
        getWalletReconciliations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWalletReconciliationsRequest.fromBuffer(value),
        ($0.GetWalletReconciliationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerWalletReconciliationRequest,
            $0.TriggerWalletReconciliationResponse>(
        'TriggerWalletReconciliation',
        triggerWalletReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TriggerWalletReconciliationRequest.fromBuffer(value),
        ($0.TriggerWalletReconciliationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSettlementsRequest,
            $0.GetSettlementsResponse>(
        'GetSettlements',
        getSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSettlementsRequest.fromBuffer(value),
        ($0.GetSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkSettlementsPaidRequest,
            $0.MarkSettlementsPaidResponse>(
        'MarkSettlementsPaid',
        markSettlementsPaid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkSettlementsPaidRequest.fromBuffer(value),
        ($0.MarkSettlementsPaidResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionDetailRequest,
            $0.GetTransactionDetailResponse>(
        'GetTransactionDetail',
        getTransactionDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionDetailRequest.fromBuffer(value),
        ($0.GetTransactionDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RetryTransactionRequest,
            $0.RetryTransactionResponse>(
        'RetryTransaction',
        retryTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RetryTransactionRequest.fromBuffer(value),
        ($0.RetryTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReverseTransactionRequest,
            $0.ReverseTransactionResponse>(
        'ReverseTransaction',
        reverseTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReverseTransactionRequest.fromBuffer(value),
        ($0.ReverseTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCryptoAuditTrailRequest,
            $0.GetUserCryptoAuditTrailResponse>(
        'GetUserCryptoAuditTrail',
        getUserCryptoAuditTrail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCryptoAuditTrailRequest.fromBuffer(value),
        ($0.GetUserCryptoAuditTrailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetTradingSuspensionRequest,
            $0.SetTradingSuspensionResponse>(
        'SetTradingSuspension',
        setTradingSuspension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetTradingSuspensionRequest.fromBuffer(value),
        ($0.SetTradingSuspensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTradingSuspensionRequest,
            $0.GetTradingSuspensionResponse>(
        'GetTradingSuspension',
        getTradingSuspension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTradingSuspensionRequest.fromBuffer(value),
        ($0.GetTradingSuspensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetUserCryptoFreezeRequest,
            $0.SetUserCryptoFreezeResponse>(
        'SetUserCryptoFreeze',
        setUserCryptoFreeze_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetUserCryptoFreezeRequest.fromBuffer(value),
        ($0.SetUserCryptoFreezeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCryptoFreezeRequest,
            $0.GetUserCryptoFreezeResponse>(
        'GetUserCryptoFreeze',
        getUserCryptoFreeze_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCryptoFreezeRequest.fromBuffer(value),
        ($0.GetUserCryptoFreezeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoConfigRequest,
            $0.GetCryptoConfigResponse>(
        'GetCryptoConfig',
        getCryptoConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoConfigRequest.fromBuffer(value),
        ($0.GetCryptoConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawRequest, $0.WithdrawResponse>(
        'Withdraw',
        withdraw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WithdrawRequest.fromBuffer(value),
        ($0.WithdrawResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoWithdrawalStatusRequest,
            $0.GetCryptoWithdrawalStatusResponse>(
        'GetCryptoWithdrawalStatus',
        getCryptoWithdrawalStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoWithdrawalStatusRequest.fromBuffer(value),
        ($0.GetCryptoWithdrawalStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCryptoWithdrawalsRequest,
            $0.GetUserCryptoWithdrawalsResponse>(
        'GetUserCryptoWithdrawals',
        getUserCryptoWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCryptoWithdrawalsRequest.fromBuffer(value),
        ($0.GetUserCryptoWithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedAssetNetworksRequest,
            $0.GetSupportedAssetNetworksResponse>(
        'GetSupportedAssetNetworks',
        getSupportedAssetNetworks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedAssetNetworksRequest.fromBuffer(value),
        ($0.GetSupportedAssetNetworksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAssetNetworkStatusRequest,
            $0.GetAssetNetworkStatusResponse>(
        'GetAssetNetworkStatus',
        getAssetNetworkStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAssetNetworkStatusRequest.fromBuffer(value),
        ($0.GetAssetNetworkStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoEligibilityRequest,
            $0.GetCryptoEligibilityResponse>(
        'GetCryptoEligibility',
        getCryptoEligibility_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoEligibilityRequest.fromBuffer(value),
        ($0.GetCryptoEligibilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EnsureWalletAddressRequest,
            $0.EnsureWalletAddressResponse>(
        'EnsureWalletAddress',
        ensureWalletAddress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EnsureWalletAddressRequest.fromBuffer(value),
        ($0.EnsureWalletAddressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveRecipientWalletRequest,
            $0.ResolveRecipientWalletResponse>(
        'ResolveRecipientWallet',
        resolveRecipientWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResolveRecipientWalletRequest.fromBuffer(value),
        ($0.ResolveRecipientWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCryptoDepositsRequest,
            $0.GetUserCryptoDepositsResponse>(
        'GetUserCryptoDeposits',
        getUserCryptoDeposits_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCryptoDepositsRequest.fromBuffer(value),
        ($0.GetUserCryptoDepositsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListAssetNetworksRequest,
            $0.AdminListAssetNetworksResponse>(
        'AdminListAssetNetworks',
        adminListAssetNetworks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListAssetNetworksRequest.fromBuffer(value),
        ($0.AdminListAssetNetworksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpdateAssetNetworkRequest,
            $0.AdminUpdateAssetNetworkResponse>(
        'AdminUpdateAssetNetwork',
        adminUpdateAssetNetwork_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUpdateAssetNetworkRequest.fromBuffer(value),
        ($0.AdminUpdateAssetNetworkResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListSupportedMarketsRequest,
            $0.AdminListSupportedMarketsResponse>(
        'AdminListSupportedMarkets',
        adminListSupportedMarkets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListSupportedMarketsRequest.fromBuffer(value),
        ($0.AdminListSupportedMarketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpdateSupportedMarketRequest,
            $0.AdminUpdateSupportedMarketResponse>(
        'AdminUpdateSupportedMarket',
        adminUpdateSupportedMarket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUpdateSupportedMarketRequest.fromBuffer(value),
        ($0.AdminUpdateSupportedMarketResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListAssetsRequest,
            $0.AdminListAssetsResponse>(
        'AdminListAssets',
        adminListAssets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListAssetsRequest.fromBuffer(value),
        ($0.AdminListAssetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminSetAssetOverrideRequest,
            $0.AdminSetAssetOverrideResponse>(
        'AdminSetAssetOverride',
        adminSetAssetOverride_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminSetAssetOverrideRequest.fromBuffer(value),
        ($0.AdminSetAssetOverrideResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminSetGlobalAssetVisibilityRequest,
            $0.AdminSetGlobalAssetVisibilityResponse>(
        'AdminSetGlobalAssetVisibility',
        adminSetGlobalAssetVisibility_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminSetGlobalAssetVisibilityRequest.fromBuffer(value),
        ($0.AdminSetGlobalAssetVisibilityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetBridgeMetricsRequest,
            $0.AdminGetBridgeMetricsResponse>(
        'AdminGetBridgeMetrics',
        adminGetBridgeMetrics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetBridgeMetricsRequest.fromBuffer(value),
        ($0.AdminGetBridgeMetricsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminToggleBridgeRequest,
            $0.AdminToggleBridgeResponse>(
        'AdminToggleBridge',
        adminToggleBridge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminToggleBridgeRequest.fromBuffer(value),
        ($0.AdminToggleBridgeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListCompensationsRequest,
            $0.AdminListCompensationsResponse>(
        'AdminListCompensations',
        adminListCompensations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListCompensationsRequest.fromBuffer(value),
        ($0.AdminListCompensationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetCompensationDetailRequest,
            $0.AdminGetCompensationDetailResponse>(
        'AdminGetCompensationDetail',
        adminGetCompensationDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetCompensationDetailRequest.fromBuffer(value),
        ($0.AdminGetCompensationDetailResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminRetryCompensationRequest,
            $0.AdminRetryCompensationResponse>(
        'AdminRetryCompensation',
        adminRetryCompensation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminRetryCompensationRequest.fromBuffer(value),
        ($0.AdminRetryCompensationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminWriteOffCompensationRequest,
            $0.AdminWriteOffCompensationResponse>(
        'AdminWriteOffCompensation',
        adminWriteOffCompensation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminWriteOffCompensationRequest.fromBuffer(value),
        ($0.AdminWriteOffCompensationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateSwapQuoteRequest,
            $0.CreateSwapQuoteResponse>(
        'CreateSwapQuote',
        createSwapQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateSwapQuoteRequest.fromBuffer(value),
        ($0.CreateSwapQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefreshSwapQuoteRequest,
            $0.RefreshSwapQuoteResponse>(
        'RefreshSwapQuote',
        refreshSwapQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefreshSwapQuoteRequest.fromBuffer(value),
        ($0.RefreshSwapQuoteResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ConfirmSwapRequest, $0.ConfirmSwapResponse>(
            'ConfirmSwap',
            confirmSwap_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ConfirmSwapRequest.fromBuffer(value),
            ($0.ConfirmSwapResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetSwapStatusRequest, $0.GetSwapStatusResponse>(
            'GetSwapStatus',
            getSwapStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetSwapStatusRequest.fromBuffer(value),
            ($0.GetSwapStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetMasterFloatRequest,
            $0.AdminGetMasterFloatResponse>(
        'AdminGetMasterFloat',
        adminGetMasterFloat_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetMasterFloatRequest.fromBuffer(value),
        ($0.AdminGetMasterFloatResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminTriggerMasterFloatReconRequest,
            $0.AdminTriggerMasterFloatReconResponse>(
        'AdminTriggerMasterFloatRecon',
        adminTriggerMasterFloatRecon_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminTriggerMasterFloatReconRequest.fromBuffer(value),
        ($0.AdminTriggerMasterFloatReconResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminPushMasterFloatRequest,
            $0.AdminPushMasterFloatResponse>(
        'AdminPushMasterFloat',
        adminPushMasterFloat_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminPushMasterFloatRequest.fromBuffer(value),
        ($0.AdminPushMasterFloatResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListSwapTransactionsRequest,
            $0.AdminListSwapTransactionsResponse>(
        'AdminListSwapTransactions',
        adminListSwapTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListSwapTransactionsRequest.fromBuffer(value),
        ($0.AdminListSwapTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetSwapTransactionDetailRequest,
            $0.AdminGetSwapTransactionDetailResponse>(
        'AdminGetSwapTransactionDetail',
        adminGetSwapTransactionDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetSwapTransactionDetailRequest.fromBuffer(value),
        ($0.AdminGetSwapTransactionDetailResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetCryptoRevenueSummaryRequest,
            $0.AdminGetCryptoRevenueSummaryResponse>(
        'AdminGetCryptoRevenueSummary',
        adminGetCryptoRevenueSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetCryptoRevenueSummaryRequest.fromBuffer(value),
        ($0.AdminGetCryptoRevenueSummaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListRollbacksRequest,
            $0.AdminListRollbacksResponse>(
        'AdminListRollbacks',
        adminListRollbacks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListRollbacksRequest.fromBuffer(value),
        ($0.AdminListRollbacksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminRetryRollbackPhaseRequest,
            $0.AdminRetryRollbackPhaseResponse>(
        'AdminRetryRollbackPhase',
        adminRetryRollbackPhase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminRetryRollbackPhaseRequest.fromBuffer(value),
        ($0.AdminRetryRollbackPhaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetQuidaxConfigRequest,
            $0.AdminGetQuidaxConfigResponse>(
        'AdminGetQuidaxConfig',
        adminGetQuidaxConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetQuidaxConfigRequest.fromBuffer(value),
        ($0.AdminGetQuidaxConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpdateQuidaxConfigRequest,
            $0.AdminUpdateQuidaxConfigResponse>(
        'AdminUpdateQuidaxConfig',
        adminUpdateQuidaxConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUpdateQuidaxConfigRequest.fromBuffer(value),
        ($0.AdminUpdateQuidaxConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListStuckSwapsRequest,
            $0.AdminListStuckSwapsResponse>(
        'AdminListStuckSwaps',
        adminListStuckSwaps_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListStuckSwapsRequest.fromBuffer(value),
        ($0.AdminListStuckSwapsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetCryptoRevenueTimeseriesRequest,
            $0.AdminGetCryptoRevenueTimeseriesResponse>(
        'AdminGetCryptoRevenueTimeseries',
        adminGetCryptoRevenueTimeseries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetCryptoRevenueTimeseriesRequest.fromBuffer(value),
        ($0.AdminGetCryptoRevenueTimeseriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListTriageQueueRequest,
            $0.AdminListTriageQueueResponse>(
        'AdminListTriageQueue',
        adminListTriageQueue_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListTriageQueueRequest.fromBuffer(value),
        ($0.AdminListTriageQueueResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetSubAccountRequest,
            $0.AdminGetSubAccountResponse>(
        'AdminGetSubAccount',
        adminGetSubAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetSubAccountRequest.fromBuffer(value),
        ($0.AdminGetSubAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListSubAccountsRequest,
            $0.AdminListSubAccountsResponse>(
        'AdminListSubAccounts',
        adminListSubAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListSubAccountsRequest.fromBuffer(value),
        ($0.AdminListSubAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListDepositsRequest,
            $0.AdminListDepositsResponse>(
        'AdminListDeposits',
        adminListDeposits_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListDepositsRequest.fromBuffer(value),
        ($0.AdminListDepositsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListWithdrawalsRequest,
            $0.AdminListWithdrawalsResponse>(
        'AdminListWithdrawals',
        adminListWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListWithdrawalsRequest.fromBuffer(value),
        ($0.AdminListWithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListUserWithdrawalsRequest,
            $0.AdminListUserWithdrawalsResponse>(
        'AdminListUserWithdrawals',
        adminListUserWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListUserWithdrawalsRequest.fromBuffer(value),
        ($0.AdminListUserWithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListWalletAddressesRequest,
            $0.AdminListWalletAddressesResponse>(
        'AdminListWalletAddresses',
        adminListWalletAddresses_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListWalletAddressesRequest.fromBuffer(value),
        ($0.AdminListWalletAddressesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListOrphanWebhooksRequest,
            $0.AdminListOrphanWebhooksResponse>(
        'AdminListOrphanWebhooks',
        adminListOrphanWebhooks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListOrphanWebhooksRequest.fromBuffer(value),
        ($0.AdminListOrphanWebhooksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminDropOrphanWebhookRequest,
            $0.AdminDropOrphanWebhookResponse>(
        'AdminDropOrphanWebhook',
        adminDropOrphanWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminDropOrphanWebhookRequest.fromBuffer(value),
        ($0.AdminDropOrphanWebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetRollbackDetailRequest,
            $0.AdminGetRollbackDetailResponse>(
        'AdminGetRollbackDetail',
        adminGetRollbackDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetRollbackDetailRequest.fromBuffer(value),
        ($0.AdminGetRollbackDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPriceAlertWorkerStatusRequest,
            $0.GetPriceAlertWorkerStatusResponse>(
        'GetPriceAlertWorkerStatus',
        getPriceAlertWorkerStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPriceAlertWorkerStatusRequest.fromBuffer(value),
        ($0.GetPriceAlertWorkerStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePriceAlertWorkerConfigRequest,
            $0.UpdatePriceAlertWorkerConfigResponse>(
        'UpdatePriceAlertWorkerConfig',
        updatePriceAlertWorkerConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdatePriceAlertWorkerConfigRequest.fromBuffer(value),
        ($0.UpdatePriceAlertWorkerConfigResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerPriceAlertWorkerNowRequest,
            $0.TriggerPriceAlertWorkerNowResponse>(
        'TriggerPriceAlertWorkerNow',
        triggerPriceAlertWorkerNow_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TriggerPriceAlertWorkerNowRequest.fromBuffer(value),
        ($0.TriggerPriceAlertWorkerNowResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListPriceAlertsRequest,
            $0.AdminListPriceAlertsResponse>(
        'AdminListPriceAlerts',
        adminListPriceAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListPriceAlertsRequest.fromBuffer(value),
        ($0.AdminListPriceAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminForceTriggerPriceAlertRequest,
            $0.AdminForceTriggerPriceAlertResponse>(
        'AdminForceTriggerPriceAlert',
        adminForceTriggerPriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminForceTriggerPriceAlertRequest.fromBuffer(value),
        ($0.AdminForceTriggerPriceAlertResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminDisablePriceAlertRequest,
            $0.AdminDisablePriceAlertResponse>(
        'AdminDisablePriceAlert',
        adminDisablePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminDisablePriceAlertRequest.fromBuffer(value),
        ($0.AdminDisablePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAutoOrderRequest,
            $0.CreateAutoOrderResponse>(
        'CreateAutoOrder',
        createAutoOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAutoOrderRequest.fromBuffer(value),
        ($0.CreateAutoOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListAutoOrdersRequest,
            $0.ListAutoOrdersResponse>(
        'ListAutoOrders',
        listAutoOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListAutoOrdersRequest.fromBuffer(value),
        ($0.ListAutoOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelAutoOrderRequest,
            $0.CancelAutoOrderResponse>(
        'CancelAutoOrder',
        cancelAutoOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelAutoOrderRequest.fromBuffer(value),
        ($0.CancelAutoOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoOrderWorkerStatusRequest,
            $0.GetAutoOrderWorkerStatusResponse>(
        'GetAutoOrderWorkerStatus',
        getAutoOrderWorkerStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAutoOrderWorkerStatusRequest.fromBuffer(value),
        ($0.GetAutoOrderWorkerStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoOrderWorkerConfigRequest,
            $0.UpdateAutoOrderWorkerConfigResponse>(
        'UpdateAutoOrderWorkerConfig',
        updateAutoOrderWorkerConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAutoOrderWorkerConfigRequest.fromBuffer(value),
        ($0.UpdateAutoOrderWorkerConfigResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerAutoOrderWorkerNowRequest,
            $0.TriggerAutoOrderWorkerNowResponse>(
        'TriggerAutoOrderWorkerNow',
        triggerAutoOrderWorkerNow_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TriggerAutoOrderWorkerNowRequest.fromBuffer(value),
        ($0.TriggerAutoOrderWorkerNowResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListAutoOrdersRequest,
            $0.AdminListAutoOrdersResponse>(
        'AdminListAutoOrders',
        adminListAutoOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListAutoOrdersRequest.fromBuffer(value),
        ($0.AdminListAutoOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminCancelAutoOrderRequest,
            $0.AdminCancelAutoOrderResponse>(
        'AdminCancelAutoOrder',
        adminCancelAutoOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminCancelAutoOrderRequest.fromBuffer(value),
        ($0.AdminCancelAutoOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListWatchlistsRequest,
            $0.AdminListWatchlistsResponse>(
        'AdminListWatchlists',
        adminListWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListWatchlistsRequest.fromBuffer(value),
        ($0.AdminListWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLearnLessonsRequest,
            $0.GetLearnLessonsResponse>(
        'GetLearnLessons',
        getLearnLessons_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLearnLessonsRequest.fromBuffer(value),
        ($0.GetLearnLessonsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListLearnLessonsRequest,
            $0.AdminListLearnLessonsResponse>(
        'AdminListLearnLessons',
        adminListLearnLessons_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListLearnLessonsRequest.fromBuffer(value),
        ($0.AdminListLearnLessonsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpsertLearnLessonRequest,
            $0.AdminUpsertLearnLessonResponse>(
        'AdminUpsertLearnLesson',
        adminUpsertLearnLesson_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUpsertLearnLessonRequest.fromBuffer(value),
        ($0.AdminUpsertLearnLessonResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminDeleteLearnLessonRequest,
            $0.AdminDeleteLearnLessonResponse>(
        'AdminDeleteLearnLesson',
        adminDeleteLearnLesson_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminDeleteLearnLessonRequest.fromBuffer(value),
        ($0.AdminDeleteLearnLessonResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.GetSpreadConfigResponse> getSpreadConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSpreadConfigRequest> request) async {
    return getSpreadConfig(call, await request);
  }

  $async.Future<$0.UpdateSpreadConfigResponse> updateSpreadConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateSpreadConfigRequest> request) async {
    return updateSpreadConfig(call, await request);
  }

  $async.Future<$0.GetFeeConfigResponse> getFeeConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFeeConfigRequest> request) async {
    return getFeeConfig(call, await request);
  }

  $async.Future<$0.UpdateFeeConfigResponse> updateFeeConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateFeeConfigRequest> request) async {
    return updateFeeConfig(call, await request);
  }

  $async.Future<$0.GetWalletReconciliationsResponse>
      getWalletReconciliations_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetWalletReconciliationsRequest> request) async {
    return getWalletReconciliations(call, await request);
  }

  $async.Future<$0.TriggerWalletReconciliationResponse>
      triggerWalletReconciliation_Pre($grpc.ServiceCall call,
          $async.Future<$0.TriggerWalletReconciliationRequest> request) async {
    return triggerWalletReconciliation(call, await request);
  }

  $async.Future<$0.GetSettlementsResponse> getSettlements_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSettlementsRequest> request) async {
    return getSettlements(call, await request);
  }

  $async.Future<$0.MarkSettlementsPaidResponse> markSettlementsPaid_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MarkSettlementsPaidRequest> request) async {
    return markSettlementsPaid(call, await request);
  }

  $async.Future<$0.GetTransactionDetailResponse> getTransactionDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransactionDetailRequest> request) async {
    return getTransactionDetail(call, await request);
  }

  $async.Future<$0.RetryTransactionResponse> retryTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RetryTransactionRequest> request) async {
    return retryTransaction(call, await request);
  }

  $async.Future<$0.ReverseTransactionResponse> reverseTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ReverseTransactionRequest> request) async {
    return reverseTransaction(call, await request);
  }

  $async.Future<$0.GetUserCryptoAuditTrailResponse> getUserCryptoAuditTrail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserCryptoAuditTrailRequest> request) async {
    return getUserCryptoAuditTrail(call, await request);
  }

  $async.Future<$0.SetTradingSuspensionResponse> setTradingSuspension_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetTradingSuspensionRequest> request) async {
    return setTradingSuspension(call, await request);
  }

  $async.Future<$0.GetTradingSuspensionResponse> getTradingSuspension_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTradingSuspensionRequest> request) async {
    return getTradingSuspension(call, await request);
  }

  $async.Future<$0.SetUserCryptoFreezeResponse> setUserCryptoFreeze_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetUserCryptoFreezeRequest> request) async {
    return setUserCryptoFreeze(call, await request);
  }

  $async.Future<$0.GetUserCryptoFreezeResponse> getUserCryptoFreeze_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserCryptoFreezeRequest> request) async {
    return getUserCryptoFreeze(call, await request);
  }

  $async.Future<$0.GetCryptoConfigResponse> getCryptoConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoConfigRequest> request) async {
    return getCryptoConfig(call, await request);
  }

  $async.Future<$0.WithdrawResponse> withdraw_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WithdrawRequest> request) async {
    return withdraw(call, await request);
  }

  $async.Future<$0.GetCryptoWithdrawalStatusResponse>
      getCryptoWithdrawalStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetCryptoWithdrawalStatusRequest> request) async {
    return getCryptoWithdrawalStatus(call, await request);
  }

  $async.Future<$0.GetUserCryptoWithdrawalsResponse>
      getUserCryptoWithdrawals_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetUserCryptoWithdrawalsRequest> request) async {
    return getUserCryptoWithdrawals(call, await request);
  }

  $async.Future<$0.GetSupportedAssetNetworksResponse>
      getSupportedAssetNetworks_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetSupportedAssetNetworksRequest> request) async {
    return getSupportedAssetNetworks(call, await request);
  }

  $async.Future<$0.GetAssetNetworkStatusResponse> getAssetNetworkStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAssetNetworkStatusRequest> request) async {
    return getAssetNetworkStatus(call, await request);
  }

  $async.Future<$0.GetCryptoEligibilityResponse> getCryptoEligibility_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCryptoEligibilityRequest> request) async {
    return getCryptoEligibility(call, await request);
  }

  $async.Future<$0.EnsureWalletAddressResponse> ensureWalletAddress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.EnsureWalletAddressRequest> request) async {
    return ensureWalletAddress(call, await request);
  }

  $async.Future<$0.ResolveRecipientWalletResponse> resolveRecipientWallet_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResolveRecipientWalletRequest> request) async {
    return resolveRecipientWallet(call, await request);
  }

  $async.Future<$0.GetUserCryptoDepositsResponse> getUserCryptoDeposits_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserCryptoDepositsRequest> request) async {
    return getUserCryptoDeposits(call, await request);
  }

  $async.Future<$0.AdminListAssetNetworksResponse> adminListAssetNetworks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListAssetNetworksRequest> request) async {
    return adminListAssetNetworks(call, await request);
  }

  $async.Future<$0.AdminUpdateAssetNetworkResponse> adminUpdateAssetNetwork_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminUpdateAssetNetworkRequest> request) async {
    return adminUpdateAssetNetwork(call, await request);
  }

  $async.Future<$0.AdminListSupportedMarketsResponse>
      adminListSupportedMarkets_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminListSupportedMarketsRequest> request) async {
    return adminListSupportedMarkets(call, await request);
  }

  $async.Future<$0.AdminUpdateSupportedMarketResponse>
      adminUpdateSupportedMarket_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminUpdateSupportedMarketRequest> request) async {
    return adminUpdateSupportedMarket(call, await request);
  }

  $async.Future<$0.AdminListAssetsResponse> adminListAssets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListAssetsRequest> request) async {
    return adminListAssets(call, await request);
  }

  $async.Future<$0.AdminSetAssetOverrideResponse> adminSetAssetOverride_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminSetAssetOverrideRequest> request) async {
    return adminSetAssetOverride(call, await request);
  }

  $async.Future<$0.AdminSetGlobalAssetVisibilityResponse>
      adminSetGlobalAssetVisibility_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.AdminSetGlobalAssetVisibilityRequest>
              request) async {
    return adminSetGlobalAssetVisibility(call, await request);
  }

  $async.Future<$0.AdminGetBridgeMetricsResponse> adminGetBridgeMetrics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetBridgeMetricsRequest> request) async {
    return adminGetBridgeMetrics(call, await request);
  }

  $async.Future<$0.AdminToggleBridgeResponse> adminToggleBridge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminToggleBridgeRequest> request) async {
    return adminToggleBridge(call, await request);
  }

  $async.Future<$0.AdminListCompensationsResponse> adminListCompensations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListCompensationsRequest> request) async {
    return adminListCompensations(call, await request);
  }

  $async.Future<$0.AdminGetCompensationDetailResponse>
      adminGetCompensationDetail_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminGetCompensationDetailRequest> request) async {
    return adminGetCompensationDetail(call, await request);
  }

  $async.Future<$0.AdminRetryCompensationResponse> adminRetryCompensation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminRetryCompensationRequest> request) async {
    return adminRetryCompensation(call, await request);
  }

  $async.Future<$0.AdminWriteOffCompensationResponse>
      adminWriteOffCompensation_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminWriteOffCompensationRequest> request) async {
    return adminWriteOffCompensation(call, await request);
  }

  $async.Future<$0.CreateSwapQuoteResponse> createSwapQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateSwapQuoteRequest> request) async {
    return createSwapQuote(call, await request);
  }

  $async.Future<$0.RefreshSwapQuoteResponse> refreshSwapQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RefreshSwapQuoteRequest> request) async {
    return refreshSwapQuote(call, await request);
  }

  $async.Future<$0.ConfirmSwapResponse> confirmSwap_Pre($grpc.ServiceCall call,
      $async.Future<$0.ConfirmSwapRequest> request) async {
    return confirmSwap(call, await request);
  }

  $async.Future<$0.GetSwapStatusResponse> getSwapStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSwapStatusRequest> request) async {
    return getSwapStatus(call, await request);
  }

  $async.Future<$0.AdminGetMasterFloatResponse> adminGetMasterFloat_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetMasterFloatRequest> request) async {
    return adminGetMasterFloat(call, await request);
  }

  $async.Future<$0.AdminTriggerMasterFloatReconResponse>
      adminTriggerMasterFloatRecon_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminTriggerMasterFloatReconRequest> request) async {
    return adminTriggerMasterFloatRecon(call, await request);
  }

  $async.Future<$0.AdminPushMasterFloatResponse> adminPushMasterFloat_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminPushMasterFloatRequest> request) async {
    return adminPushMasterFloat(call, await request);
  }

  $async.Future<$0.AdminListSwapTransactionsResponse>
      adminListSwapTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminListSwapTransactionsRequest> request) async {
    return adminListSwapTransactions(call, await request);
  }

  $async.Future<$0.AdminGetSwapTransactionDetailResponse>
      adminGetSwapTransactionDetail_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.AdminGetSwapTransactionDetailRequest>
              request) async {
    return adminGetSwapTransactionDetail(call, await request);
  }

  $async.Future<$0.AdminGetCryptoRevenueSummaryResponse>
      adminGetCryptoRevenueSummary_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminGetCryptoRevenueSummaryRequest> request) async {
    return adminGetCryptoRevenueSummary(call, await request);
  }

  $async.Future<$0.AdminListRollbacksResponse> adminListRollbacks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListRollbacksRequest> request) async {
    return adminListRollbacks(call, await request);
  }

  $async.Future<$0.AdminRetryRollbackPhaseResponse> adminRetryRollbackPhase_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminRetryRollbackPhaseRequest> request) async {
    return adminRetryRollbackPhase(call, await request);
  }

  $async.Future<$0.AdminGetQuidaxConfigResponse> adminGetQuidaxConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetQuidaxConfigRequest> request) async {
    return adminGetQuidaxConfig(call, await request);
  }

  $async.Future<$0.AdminUpdateQuidaxConfigResponse> adminUpdateQuidaxConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminUpdateQuidaxConfigRequest> request) async {
    return adminUpdateQuidaxConfig(call, await request);
  }

  $async.Future<$0.AdminListStuckSwapsResponse> adminListStuckSwaps_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListStuckSwapsRequest> request) async {
    return adminListStuckSwaps(call, await request);
  }

  $async.Future<$0.AdminGetCryptoRevenueTimeseriesResponse>
      adminGetCryptoRevenueTimeseries_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.AdminGetCryptoRevenueTimeseriesRequest>
              request) async {
    return adminGetCryptoRevenueTimeseries(call, await request);
  }

  $async.Future<$0.AdminListTriageQueueResponse> adminListTriageQueue_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListTriageQueueRequest> request) async {
    return adminListTriageQueue(call, await request);
  }

  $async.Future<$0.AdminGetSubAccountResponse> adminGetSubAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetSubAccountRequest> request) async {
    return adminGetSubAccount(call, await request);
  }

  $async.Future<$0.AdminListSubAccountsResponse> adminListSubAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListSubAccountsRequest> request) async {
    return adminListSubAccounts(call, await request);
  }

  $async.Future<$0.AdminListDepositsResponse> adminListDeposits_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListDepositsRequest> request) async {
    return adminListDeposits(call, await request);
  }

  $async.Future<$0.AdminListWithdrawalsResponse> adminListWithdrawals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListWithdrawalsRequest> request) async {
    return adminListWithdrawals(call, await request);
  }

  $async.Future<$0.AdminListUserWithdrawalsResponse>
      adminListUserWithdrawals_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminListUserWithdrawalsRequest> request) async {
    return adminListUserWithdrawals(call, await request);
  }

  $async.Future<$0.AdminListWalletAddressesResponse>
      adminListWalletAddresses_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminListWalletAddressesRequest> request) async {
    return adminListWalletAddresses(call, await request);
  }

  $async.Future<$0.AdminListOrphanWebhooksResponse> adminListOrphanWebhooks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListOrphanWebhooksRequest> request) async {
    return adminListOrphanWebhooks(call, await request);
  }

  $async.Future<$0.AdminDropOrphanWebhookResponse> adminDropOrphanWebhook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminDropOrphanWebhookRequest> request) async {
    return adminDropOrphanWebhook(call, await request);
  }

  $async.Future<$0.AdminGetRollbackDetailResponse> adminGetRollbackDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetRollbackDetailRequest> request) async {
    return adminGetRollbackDetail(call, await request);
  }

  $async.Future<$0.GetPriceAlertWorkerStatusResponse>
      getPriceAlertWorkerStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetPriceAlertWorkerStatusRequest> request) async {
    return getPriceAlertWorkerStatus(call, await request);
  }

  $async.Future<$0.UpdatePriceAlertWorkerConfigResponse>
      updatePriceAlertWorkerConfig_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdatePriceAlertWorkerConfigRequest> request) async {
    return updatePriceAlertWorkerConfig(call, await request);
  }

  $async.Future<$0.TriggerPriceAlertWorkerNowResponse>
      triggerPriceAlertWorkerNow_Pre($grpc.ServiceCall call,
          $async.Future<$0.TriggerPriceAlertWorkerNowRequest> request) async {
    return triggerPriceAlertWorkerNow(call, await request);
  }

  $async.Future<$0.AdminListPriceAlertsResponse> adminListPriceAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListPriceAlertsRequest> request) async {
    return adminListPriceAlerts(call, await request);
  }

  $async.Future<$0.AdminForceTriggerPriceAlertResponse>
      adminForceTriggerPriceAlert_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminForceTriggerPriceAlertRequest> request) async {
    return adminForceTriggerPriceAlert(call, await request);
  }

  $async.Future<$0.AdminDisablePriceAlertResponse> adminDisablePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminDisablePriceAlertRequest> request) async {
    return adminDisablePriceAlert(call, await request);
  }

  $async.Future<$0.CreateAutoOrderResponse> createAutoOrder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateAutoOrderRequest> request) async {
    return createAutoOrder(call, await request);
  }

  $async.Future<$0.ListAutoOrdersResponse> listAutoOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListAutoOrdersRequest> request) async {
    return listAutoOrders(call, await request);
  }

  $async.Future<$0.CancelAutoOrderResponse> cancelAutoOrder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelAutoOrderRequest> request) async {
    return cancelAutoOrder(call, await request);
  }

  $async.Future<$0.GetAutoOrderWorkerStatusResponse>
      getAutoOrderWorkerStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetAutoOrderWorkerStatusRequest> request) async {
    return getAutoOrderWorkerStatus(call, await request);
  }

  $async.Future<$0.UpdateAutoOrderWorkerConfigResponse>
      updateAutoOrderWorkerConfig_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateAutoOrderWorkerConfigRequest> request) async {
    return updateAutoOrderWorkerConfig(call, await request);
  }

  $async.Future<$0.TriggerAutoOrderWorkerNowResponse>
      triggerAutoOrderWorkerNow_Pre($grpc.ServiceCall call,
          $async.Future<$0.TriggerAutoOrderWorkerNowRequest> request) async {
    return triggerAutoOrderWorkerNow(call, await request);
  }

  $async.Future<$0.AdminListAutoOrdersResponse> adminListAutoOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListAutoOrdersRequest> request) async {
    return adminListAutoOrders(call, await request);
  }

  $async.Future<$0.AdminCancelAutoOrderResponse> adminCancelAutoOrder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminCancelAutoOrderRequest> request) async {
    return adminCancelAutoOrder(call, await request);
  }

  $async.Future<$0.AdminListWatchlistsResponse> adminListWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListWatchlistsRequest> request) async {
    return adminListWatchlists(call, await request);
  }

  $async.Future<$0.GetLearnLessonsResponse> getLearnLessons_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetLearnLessonsRequest> request) async {
    return getLearnLessons(call, await request);
  }

  $async.Future<$0.AdminListLearnLessonsResponse> adminListLearnLessons_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminListLearnLessonsRequest> request) async {
    return adminListLearnLessons(call, await request);
  }

  $async.Future<$0.AdminUpsertLearnLessonResponse> adminUpsertLearnLesson_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminUpsertLearnLessonRequest> request) async {
    return adminUpsertLearnLesson(call, await request);
  }

  $async.Future<$0.AdminDeleteLearnLessonResponse> adminDeleteLearnLesson_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminDeleteLearnLessonRequest> request) async {
    return adminDeleteLearnLesson(call, await request);
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
  $async.Future<$0.GetSpreadConfigResponse> getSpreadConfig(
      $grpc.ServiceCall call, $0.GetSpreadConfigRequest request);
  $async.Future<$0.UpdateSpreadConfigResponse> updateSpreadConfig(
      $grpc.ServiceCall call, $0.UpdateSpreadConfigRequest request);
  $async.Future<$0.GetFeeConfigResponse> getFeeConfig(
      $grpc.ServiceCall call, $0.GetFeeConfigRequest request);
  $async.Future<$0.UpdateFeeConfigResponse> updateFeeConfig(
      $grpc.ServiceCall call, $0.UpdateFeeConfigRequest request);
  $async.Future<$0.GetWalletReconciliationsResponse> getWalletReconciliations(
      $grpc.ServiceCall call, $0.GetWalletReconciliationsRequest request);
  $async.Future<$0.TriggerWalletReconciliationResponse>
      triggerWalletReconciliation($grpc.ServiceCall call,
          $0.TriggerWalletReconciliationRequest request);
  $async.Future<$0.GetSettlementsResponse> getSettlements(
      $grpc.ServiceCall call, $0.GetSettlementsRequest request);
  $async.Future<$0.MarkSettlementsPaidResponse> markSettlementsPaid(
      $grpc.ServiceCall call, $0.MarkSettlementsPaidRequest request);
  $async.Future<$0.GetTransactionDetailResponse> getTransactionDetail(
      $grpc.ServiceCall call, $0.GetTransactionDetailRequest request);
  $async.Future<$0.RetryTransactionResponse> retryTransaction(
      $grpc.ServiceCall call, $0.RetryTransactionRequest request);
  $async.Future<$0.ReverseTransactionResponse> reverseTransaction(
      $grpc.ServiceCall call, $0.ReverseTransactionRequest request);
  $async.Future<$0.GetUserCryptoAuditTrailResponse> getUserCryptoAuditTrail(
      $grpc.ServiceCall call, $0.GetUserCryptoAuditTrailRequest request);
  $async.Future<$0.SetTradingSuspensionResponse> setTradingSuspension(
      $grpc.ServiceCall call, $0.SetTradingSuspensionRequest request);
  $async.Future<$0.GetTradingSuspensionResponse> getTradingSuspension(
      $grpc.ServiceCall call, $0.GetTradingSuspensionRequest request);
  $async.Future<$0.SetUserCryptoFreezeResponse> setUserCryptoFreeze(
      $grpc.ServiceCall call, $0.SetUserCryptoFreezeRequest request);
  $async.Future<$0.GetUserCryptoFreezeResponse> getUserCryptoFreeze(
      $grpc.ServiceCall call, $0.GetUserCryptoFreezeRequest request);
  $async.Future<$0.GetCryptoConfigResponse> getCryptoConfig(
      $grpc.ServiceCall call, $0.GetCryptoConfigRequest request);
  $async.Future<$0.WithdrawResponse> withdraw(
      $grpc.ServiceCall call, $0.WithdrawRequest request);
  $async.Future<$0.GetCryptoWithdrawalStatusResponse> getCryptoWithdrawalStatus(
      $grpc.ServiceCall call, $0.GetCryptoWithdrawalStatusRequest request);
  $async.Future<$0.GetUserCryptoWithdrawalsResponse> getUserCryptoWithdrawals(
      $grpc.ServiceCall call, $0.GetUserCryptoWithdrawalsRequest request);
  $async.Future<$0.GetSupportedAssetNetworksResponse> getSupportedAssetNetworks(
      $grpc.ServiceCall call, $0.GetSupportedAssetNetworksRequest request);
  $async.Future<$0.GetAssetNetworkStatusResponse> getAssetNetworkStatus(
      $grpc.ServiceCall call, $0.GetAssetNetworkStatusRequest request);
  $async.Future<$0.GetCryptoEligibilityResponse> getCryptoEligibility(
      $grpc.ServiceCall call, $0.GetCryptoEligibilityRequest request);
  $async.Future<$0.EnsureWalletAddressResponse> ensureWalletAddress(
      $grpc.ServiceCall call, $0.EnsureWalletAddressRequest request);
  $async.Future<$0.ResolveRecipientWalletResponse> resolveRecipientWallet(
      $grpc.ServiceCall call, $0.ResolveRecipientWalletRequest request);
  $async.Future<$0.GetUserCryptoDepositsResponse> getUserCryptoDeposits(
      $grpc.ServiceCall call, $0.GetUserCryptoDepositsRequest request);
  $async.Future<$0.AdminListAssetNetworksResponse> adminListAssetNetworks(
      $grpc.ServiceCall call, $0.AdminListAssetNetworksRequest request);
  $async.Future<$0.AdminUpdateAssetNetworkResponse> adminUpdateAssetNetwork(
      $grpc.ServiceCall call, $0.AdminUpdateAssetNetworkRequest request);
  $async.Future<$0.AdminListSupportedMarketsResponse> adminListSupportedMarkets(
      $grpc.ServiceCall call, $0.AdminListSupportedMarketsRequest request);
  $async.Future<$0.AdminUpdateSupportedMarketResponse>
      adminUpdateSupportedMarket(
          $grpc.ServiceCall call, $0.AdminUpdateSupportedMarketRequest request);
  $async.Future<$0.AdminListAssetsResponse> adminListAssets(
      $grpc.ServiceCall call, $0.AdminListAssetsRequest request);
  $async.Future<$0.AdminSetAssetOverrideResponse> adminSetAssetOverride(
      $grpc.ServiceCall call, $0.AdminSetAssetOverrideRequest request);
  $async.Future<$0.AdminSetGlobalAssetVisibilityResponse>
      adminSetGlobalAssetVisibility($grpc.ServiceCall call,
          $0.AdminSetGlobalAssetVisibilityRequest request);
  $async.Future<$0.AdminGetBridgeMetricsResponse> adminGetBridgeMetrics(
      $grpc.ServiceCall call, $0.AdminGetBridgeMetricsRequest request);
  $async.Future<$0.AdminToggleBridgeResponse> adminToggleBridge(
      $grpc.ServiceCall call, $0.AdminToggleBridgeRequest request);
  $async.Future<$0.AdminListCompensationsResponse> adminListCompensations(
      $grpc.ServiceCall call, $0.AdminListCompensationsRequest request);
  $async.Future<$0.AdminGetCompensationDetailResponse>
      adminGetCompensationDetail(
          $grpc.ServiceCall call, $0.AdminGetCompensationDetailRequest request);
  $async.Future<$0.AdminRetryCompensationResponse> adminRetryCompensation(
      $grpc.ServiceCall call, $0.AdminRetryCompensationRequest request);
  $async.Future<$0.AdminWriteOffCompensationResponse> adminWriteOffCompensation(
      $grpc.ServiceCall call, $0.AdminWriteOffCompensationRequest request);
  $async.Future<$0.CreateSwapQuoteResponse> createSwapQuote(
      $grpc.ServiceCall call, $0.CreateSwapQuoteRequest request);
  $async.Future<$0.RefreshSwapQuoteResponse> refreshSwapQuote(
      $grpc.ServiceCall call, $0.RefreshSwapQuoteRequest request);
  $async.Future<$0.ConfirmSwapResponse> confirmSwap(
      $grpc.ServiceCall call, $0.ConfirmSwapRequest request);
  $async.Future<$0.GetSwapStatusResponse> getSwapStatus(
      $grpc.ServiceCall call, $0.GetSwapStatusRequest request);
  $async.Future<$0.AdminGetMasterFloatResponse> adminGetMasterFloat(
      $grpc.ServiceCall call, $0.AdminGetMasterFloatRequest request);
  $async.Future<$0.AdminTriggerMasterFloatReconResponse>
      adminTriggerMasterFloatRecon($grpc.ServiceCall call,
          $0.AdminTriggerMasterFloatReconRequest request);
  $async.Future<$0.AdminPushMasterFloatResponse> adminPushMasterFloat(
      $grpc.ServiceCall call, $0.AdminPushMasterFloatRequest request);
  $async.Future<$0.AdminListSwapTransactionsResponse> adminListSwapTransactions(
      $grpc.ServiceCall call, $0.AdminListSwapTransactionsRequest request);
  $async.Future<$0.AdminGetSwapTransactionDetailResponse>
      adminGetSwapTransactionDetail($grpc.ServiceCall call,
          $0.AdminGetSwapTransactionDetailRequest request);
  $async.Future<$0.AdminGetCryptoRevenueSummaryResponse>
      adminGetCryptoRevenueSummary($grpc.ServiceCall call,
          $0.AdminGetCryptoRevenueSummaryRequest request);
  $async.Future<$0.AdminListRollbacksResponse> adminListRollbacks(
      $grpc.ServiceCall call, $0.AdminListRollbacksRequest request);
  $async.Future<$0.AdminRetryRollbackPhaseResponse> adminRetryRollbackPhase(
      $grpc.ServiceCall call, $0.AdminRetryRollbackPhaseRequest request);
  $async.Future<$0.AdminGetQuidaxConfigResponse> adminGetQuidaxConfig(
      $grpc.ServiceCall call, $0.AdminGetQuidaxConfigRequest request);
  $async.Future<$0.AdminUpdateQuidaxConfigResponse> adminUpdateQuidaxConfig(
      $grpc.ServiceCall call, $0.AdminUpdateQuidaxConfigRequest request);
  $async.Future<$0.AdminListStuckSwapsResponse> adminListStuckSwaps(
      $grpc.ServiceCall call, $0.AdminListStuckSwapsRequest request);
  $async.Future<$0.AdminGetCryptoRevenueTimeseriesResponse>
      adminGetCryptoRevenueTimeseries($grpc.ServiceCall call,
          $0.AdminGetCryptoRevenueTimeseriesRequest request);
  $async.Future<$0.AdminListTriageQueueResponse> adminListTriageQueue(
      $grpc.ServiceCall call, $0.AdminListTriageQueueRequest request);
  $async.Future<$0.AdminGetSubAccountResponse> adminGetSubAccount(
      $grpc.ServiceCall call, $0.AdminGetSubAccountRequest request);
  $async.Future<$0.AdminListSubAccountsResponse> adminListSubAccounts(
      $grpc.ServiceCall call, $0.AdminListSubAccountsRequest request);
  $async.Future<$0.AdminListDepositsResponse> adminListDeposits(
      $grpc.ServiceCall call, $0.AdminListDepositsRequest request);
  $async.Future<$0.AdminListWithdrawalsResponse> adminListWithdrawals(
      $grpc.ServiceCall call, $0.AdminListWithdrawalsRequest request);
  $async.Future<$0.AdminListUserWithdrawalsResponse> adminListUserWithdrawals(
      $grpc.ServiceCall call, $0.AdminListUserWithdrawalsRequest request);
  $async.Future<$0.AdminListWalletAddressesResponse> adminListWalletAddresses(
      $grpc.ServiceCall call, $0.AdminListWalletAddressesRequest request);
  $async.Future<$0.AdminListOrphanWebhooksResponse> adminListOrphanWebhooks(
      $grpc.ServiceCall call, $0.AdminListOrphanWebhooksRequest request);
  $async.Future<$0.AdminDropOrphanWebhookResponse> adminDropOrphanWebhook(
      $grpc.ServiceCall call, $0.AdminDropOrphanWebhookRequest request);
  $async.Future<$0.AdminGetRollbackDetailResponse> adminGetRollbackDetail(
      $grpc.ServiceCall call, $0.AdminGetRollbackDetailRequest request);
  $async.Future<$0.GetPriceAlertWorkerStatusResponse> getPriceAlertWorkerStatus(
      $grpc.ServiceCall call, $0.GetPriceAlertWorkerStatusRequest request);
  $async.Future<$0.UpdatePriceAlertWorkerConfigResponse>
      updatePriceAlertWorkerConfig($grpc.ServiceCall call,
          $0.UpdatePriceAlertWorkerConfigRequest request);
  $async.Future<$0.TriggerPriceAlertWorkerNowResponse>
      triggerPriceAlertWorkerNow(
          $grpc.ServiceCall call, $0.TriggerPriceAlertWorkerNowRequest request);
  $async.Future<$0.AdminListPriceAlertsResponse> adminListPriceAlerts(
      $grpc.ServiceCall call, $0.AdminListPriceAlertsRequest request);
  $async.Future<$0.AdminForceTriggerPriceAlertResponse>
      adminForceTriggerPriceAlert($grpc.ServiceCall call,
          $0.AdminForceTriggerPriceAlertRequest request);
  $async.Future<$0.AdminDisablePriceAlertResponse> adminDisablePriceAlert(
      $grpc.ServiceCall call, $0.AdminDisablePriceAlertRequest request);
  $async.Future<$0.CreateAutoOrderResponse> createAutoOrder(
      $grpc.ServiceCall call, $0.CreateAutoOrderRequest request);
  $async.Future<$0.ListAutoOrdersResponse> listAutoOrders(
      $grpc.ServiceCall call, $0.ListAutoOrdersRequest request);
  $async.Future<$0.CancelAutoOrderResponse> cancelAutoOrder(
      $grpc.ServiceCall call, $0.CancelAutoOrderRequest request);
  $async.Future<$0.GetAutoOrderWorkerStatusResponse> getAutoOrderWorkerStatus(
      $grpc.ServiceCall call, $0.GetAutoOrderWorkerStatusRequest request);
  $async.Future<$0.UpdateAutoOrderWorkerConfigResponse>
      updateAutoOrderWorkerConfig($grpc.ServiceCall call,
          $0.UpdateAutoOrderWorkerConfigRequest request);
  $async.Future<$0.TriggerAutoOrderWorkerNowResponse> triggerAutoOrderWorkerNow(
      $grpc.ServiceCall call, $0.TriggerAutoOrderWorkerNowRequest request);
  $async.Future<$0.AdminListAutoOrdersResponse> adminListAutoOrders(
      $grpc.ServiceCall call, $0.AdminListAutoOrdersRequest request);
  $async.Future<$0.AdminCancelAutoOrderResponse> adminCancelAutoOrder(
      $grpc.ServiceCall call, $0.AdminCancelAutoOrderRequest request);
  $async.Future<$0.AdminListWatchlistsResponse> adminListWatchlists(
      $grpc.ServiceCall call, $0.AdminListWatchlistsRequest request);
  $async.Future<$0.GetLearnLessonsResponse> getLearnLessons(
      $grpc.ServiceCall call, $0.GetLearnLessonsRequest request);
  $async.Future<$0.AdminListLearnLessonsResponse> adminListLearnLessons(
      $grpc.ServiceCall call, $0.AdminListLearnLessonsRequest request);
  $async.Future<$0.AdminUpsertLearnLessonResponse> adminUpsertLearnLesson(
      $grpc.ServiceCall call, $0.AdminUpsertLearnLessonRequest request);
  $async.Future<$0.AdminDeleteLearnLessonResponse> adminDeleteLearnLesson(
      $grpc.ServiceCall call, $0.AdminDeleteLearnLessonRequest request);
}
