///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'giftcards.pb.dart' as $20;
export 'giftcards.pb.dart';

class GiftCardsServiceClient extends $grpc.Client {
  static final _$buyGiftCard =
      $grpc.ClientMethod<$20.BuyGiftCardRequest, $20.BuyGiftCardResponse>(
          '/giftcards.GiftCardsService/BuyGiftCard',
          ($20.BuyGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.BuyGiftCardResponse.fromBuffer(value));
  static final _$getRedeemCode =
      $grpc.ClientMethod<$20.GetRedeemCodeRequest, $20.GetRedeemCodeResponse>(
          '/giftcards.GiftCardsService/GetRedeemCode',
          ($20.GetRedeemCodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetRedeemCodeResponse.fromBuffer(value));
  static final _$getGiftCards =
      $grpc.ClientMethod<$20.GetGiftCardsRequest, $20.GetGiftCardsResponse>(
          '/giftcards.GiftCardsService/GetGiftCards',
          ($20.GetGiftCardsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetGiftCardsResponse.fromBuffer(value));
  static final _$getGiftCard =
      $grpc.ClientMethod<$20.GetGiftCardRequest, $20.GetGiftCardResponse>(
          '/giftcards.GiftCardsService/GetGiftCard',
          ($20.GetGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetGiftCardResponse.fromBuffer(value));
  static final _$getGiftCardBrands = $grpc.ClientMethod<
          $20.GetGiftCardBrandsRequest, $20.GetGiftCardBrandsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardBrands',
      ($20.GetGiftCardBrandsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetGiftCardBrandsResponse.fromBuffer(value));
  static final _$getGiftCardHistory = $grpc.ClientMethod<
          $20.GetGiftCardHistoryRequest, $20.GetGiftCardHistoryResponse>(
      '/giftcards.GiftCardsService/GetGiftCardHistory',
      ($20.GetGiftCardHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetGiftCardHistoryResponse.fromBuffer(value));
  static final _$getSellableCards = $grpc.ClientMethod<
          $20.GetSellableCardsRequest, $20.GetSellableCardsResponse>(
      '/giftcards.GiftCardsService/GetSellableCards',
      ($20.GetSellableCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetSellableCardsResponse.fromBuffer(value));
  static final _$getSellProvider = $grpc.ClientMethod<
          $20.GetSellProviderRequest, $20.GetSellProviderResponse>(
      '/giftcards.GiftCardsService/GetSellProvider',
      ($20.GetSellProviderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetSellProviderResponse.fromBuffer(value));
  static final _$updateFeatureFlag = $grpc.ClientMethod<
          $20.UpdateFeatureFlagRequest, $20.UpdateFeatureFlagResponse>(
      '/giftcards.GiftCardsService/UpdateFeatureFlag',
      ($20.UpdateFeatureFlagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.UpdateFeatureFlagResponse.fromBuffer(value));
  static final _$getPayoutMethods = $grpc.ClientMethod<
          $20.GetPayoutMethodsRequest, $20.GetPayoutMethodsResponse>(
      '/giftcards.GiftCardsService/GetPayoutMethods',
      ($20.GetPayoutMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetPayoutMethodsResponse.fromBuffer(value));
  static final _$getSellRate =
      $grpc.ClientMethod<$20.GetSellRateRequest, $20.GetSellRateResponse>(
          '/giftcards.GiftCardsService/GetSellRate',
          ($20.GetSellRateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetSellRateResponse.fromBuffer(value));
  static final _$uploadSellImage = $grpc.ClientMethod<
          $20.UploadSellImageRequest, $20.UploadSellImageResponse>(
      '/giftcards.GiftCardsService/UploadSellImage',
      ($20.UploadSellImageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.UploadSellImageResponse.fromBuffer(value));
  static final _$extractCardDetails = $grpc.ClientMethod<
          $20.ExtractCardDetailsRequest, $20.ExtractCardDetailsResponse>(
      '/giftcards.GiftCardsService/ExtractCardDetails',
      ($20.ExtractCardDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.ExtractCardDetailsResponse.fromBuffer(value));
  static final _$sellGiftCard =
      $grpc.ClientMethod<$20.SellGiftCardRequest, $20.SellGiftCardResponse>(
          '/giftcards.GiftCardsService/SellGiftCard',
          ($20.SellGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.SellGiftCardResponse.fromBuffer(value));
  static final _$getSellStatus =
      $grpc.ClientMethod<$20.GetSellStatusRequest, $20.GetSellStatusResponse>(
          '/giftcards.GiftCardsService/GetSellStatus',
          ($20.GetSellStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetSellStatusResponse.fromBuffer(value));
  static final _$getMySales =
      $grpc.ClientMethod<$20.GetMySalesRequest, $20.GetMySalesResponse>(
          '/giftcards.GiftCardsService/GetMySales',
          ($20.GetMySalesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetMySalesResponse.fromBuffer(value));
  static final _$adminListPendingSales = $grpc.ClientMethod<
          $20.AdminListPendingSalesRequest, $20.AdminListPendingSalesResponse>(
      '/giftcards.GiftCardsService/AdminListPendingSales',
      ($20.AdminListPendingSalesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminListPendingSalesResponse.fromBuffer(value));
  static final _$adminListBuyTransactions = $grpc.ClientMethod<
          $20.AdminListBuyTransactionsRequest,
          $20.AdminListBuyTransactionsResponse>(
      '/giftcards.GiftCardsService/AdminListBuyTransactions',
      ($20.AdminListBuyTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminListBuyTransactionsResponse.fromBuffer(value));
  static final _$adminListSellSettlements = $grpc.ClientMethod<
          $20.AdminListSellSettlementsRequest,
          $20.AdminListSellSettlementsResponse>(
      '/giftcards.GiftCardsService/AdminListSellSettlements',
      ($20.AdminListSellSettlementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminListSellSettlementsResponse.fromBuffer(value));
  static final _$adminListRefundLedger = $grpc.ClientMethod<
          $20.AdminListRefundLedgerRequest, $20.AdminListRefundLedgerResponse>(
      '/giftcards.GiftCardsService/AdminListRefundLedger',
      ($20.AdminListRefundLedgerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminListRefundLedgerResponse.fromBuffer(value));
  static final _$adminGetSaleDetail = $grpc.ClientMethod<
          $20.AdminGetSaleDetailRequest, $20.AdminGetSaleDetailResponse>(
      '/giftcards.GiftCardsService/AdminGetSaleDetail',
      ($20.AdminGetSaleDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminGetSaleDetailResponse.fromBuffer(value));
  static final _$adminApproveSale = $grpc.ClientMethod<
          $20.AdminApproveSaleRequest, $20.AdminApproveSaleResponse>(
      '/giftcards.GiftCardsService/AdminApproveSale',
      ($20.AdminApproveSaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminApproveSaleResponse.fromBuffer(value));
  static final _$adminProcessPayout = $grpc.ClientMethod<
          $20.AdminProcessPayoutRequest, $20.AdminProcessPayoutResponse>(
      '/giftcards.GiftCardsService/AdminProcessPayout',
      ($20.AdminProcessPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminProcessPayoutResponse.fromBuffer(value));
  static final _$adminRejectSale = $grpc.ClientMethod<
          $20.AdminRejectSaleRequest, $20.AdminRejectSaleResponse>(
      '/giftcards.GiftCardsService/AdminRejectSale',
      ($20.AdminRejectSaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminRejectSaleResponse.fromBuffer(value));
  static final _$adminRetryHoldRelease = $grpc.ClientMethod<
          $20.AdminRetryHoldReleaseRequest, $20.AdminRetryHoldReleaseResponse>(
      '/giftcards.GiftCardsService/AdminRetryHoldRelease',
      ($20.AdminRetryHoldReleaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminRetryHoldReleaseResponse.fromBuffer(value));
  static final _$adminManualRefundPurchase = $grpc.ClientMethod<
          $20.AdminManualRefundPurchaseRequest,
          $20.AdminManualRefundPurchaseResponse>(
      '/giftcards.GiftCardsService/AdminManualRefundPurchase',
      ($20.AdminManualRefundPurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminManualRefundPurchaseResponse.fromBuffer(value));
  static final _$adminForceReconcilePurchase = $grpc.ClientMethod<
          $20.AdminForceReconcilePurchaseRequest,
          $20.AdminForceReconcilePurchaseResponse>(
      '/giftcards.GiftCardsService/AdminForceReconcilePurchase',
      ($20.AdminForceReconcilePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminForceReconcilePurchaseResponse.fromBuffer(value));
  static final _$adminSetSellPayoutOverride = $grpc.ClientMethod<
          $20.AdminSetSellPayoutOverrideRequest,
          $20.AdminSetSellPayoutOverrideResponse>(
      '/giftcards.GiftCardsService/AdminSetSellPayoutOverride',
      ($20.AdminSetSellPayoutOverrideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminSetSellPayoutOverrideResponse.fromBuffer(value));
  static final _$adminListSellRates = $grpc.ClientMethod<
          $20.AdminListSellRatesRequest, $20.AdminListSellRatesResponse>(
      '/giftcards.GiftCardsService/AdminListSellRates',
      ($20.AdminListSellRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminListSellRatesResponse.fromBuffer(value));
  static final _$adminCreateSellRate = $grpc.ClientMethod<
          $20.AdminCreateSellRateRequest, $20.AdminCreateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminCreateSellRate',
      ($20.AdminCreateSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminCreateSellRateResponse.fromBuffer(value));
  static final _$adminUpdateSellRate = $grpc.ClientMethod<
          $20.AdminUpdateSellRateRequest, $20.AdminUpdateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminUpdateSellRate',
      ($20.AdminUpdateSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminUpdateSellRateResponse.fromBuffer(value));
  static final _$adminToggleSellRate = $grpc.ClientMethod<
          $20.AdminToggleSellRateRequest, $20.AdminToggleSellRateResponse>(
      '/giftcards.GiftCardsService/AdminToggleSellRate',
      ($20.AdminToggleSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminToggleSellRateResponse.fromBuffer(value));
  static final _$getSupportedCountries = $grpc.ClientMethod<
          $20.GetSupportedCountriesRequest, $20.GetSupportedCountriesResponse>(
      '/giftcards.GiftCardsService/GetSupportedCountries',
      ($20.GetSupportedCountriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetSupportedCountriesResponse.fromBuffer(value));
  static final _$getGiftCardsAnalytics = $grpc.ClientMethod<
          $20.GetGiftCardsAnalyticsRequest, $20.GetGiftCardsAnalyticsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardsAnalytics',
      ($20.GetGiftCardsAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetGiftCardsAnalyticsResponse.fromBuffer(value));
  static final _$getReconciliationOverview = $grpc.ClientMethod<
          $20.GetReconciliationOverviewRequest,
          $20.GetReconciliationOverviewResponse>(
      '/giftcards.GiftCardsService/GetReconciliationOverview',
      ($20.GetReconciliationOverviewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetReconciliationOverviewResponse.fromBuffer(value));
  static final _$getOrphanedTransactions = $grpc.ClientMethod<
          $20.GetOrphanedTransactionsRequest,
          $20.GetOrphanedTransactionsResponse>(
      '/giftcards.GiftCardsService/GetOrphanedTransactions',
      ($20.GetOrphanedTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetOrphanedTransactionsResponse.fromBuffer(value));
  static final _$resolveOrphanedTransaction = $grpc.ClientMethod<
          $20.ResolveOrphanedTransactionRequest,
          $20.ResolveOrphanedTransactionResponse>(
      '/giftcards.GiftCardsService/ResolveOrphanedTransaction',
      ($20.ResolveOrphanedTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.ResolveOrphanedTransactionResponse.fromBuffer(value));
  static final _$getPendingVerifications = $grpc.ClientMethod<
          $20.GetPendingVerificationsRequest,
          $20.GetPendingVerificationsResponse>(
      '/giftcards.GiftCardsService/GetPendingVerifications',
      ($20.GetPendingVerificationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetPendingVerificationsResponse.fromBuffer(value));
  static final _$getEscalatedItems = $grpc.ClientMethod<
          $20.GetEscalatedItemsRequest, $20.GetEscalatedItemsResponse>(
      '/giftcards.GiftCardsService/GetEscalatedItems',
      ($20.GetEscalatedItemsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetEscalatedItemsResponse.fromBuffer(value));
  static final _$resolveEscalatedItem = $grpc.ClientMethod<
          $20.ResolveEscalatedItemRequest, $20.ResolveEscalatedItemResponse>(
      '/giftcards.GiftCardsService/ResolveEscalatedItem',
      ($20.ResolveEscalatedItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.ResolveEscalatedItemResponse.fromBuffer(value));
  static final _$getReconciliationHistory = $grpc.ClientMethod<
          $20.GetReconciliationHistoryRequest,
          $20.GetReconciliationHistoryResponse>(
      '/giftcards.GiftCardsService/GetReconciliationHistory',
      ($20.GetReconciliationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetReconciliationHistoryResponse.fromBuffer(value));
  static final _$lookupUser =
      $grpc.ClientMethod<$20.LookupUserRequest, $20.LookupUserResponse>(
          '/giftcards.GiftCardsService/LookupUser',
          ($20.LookupUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.LookupUserResponse.fromBuffer(value));
  static final _$getUserDetails =
      $grpc.ClientMethod<$20.GetUserDetailsRequest, $20.GetUserDetailsResponse>(
          '/giftcards.GiftCardsService/GetUserDetails',
          ($20.GetUserDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetUserDetailsResponse.fromBuffer(value));
  static final _$searchGiftCardTransaction = $grpc.ClientMethod<
          $20.SearchGiftCardTransactionRequest,
          $20.SearchGiftCardTransactionResponse>(
      '/giftcards.GiftCardsService/SearchGiftCardTransaction',
      ($20.SearchGiftCardTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.SearchGiftCardTransactionResponse.fromBuffer(value));
  static final _$bulkPerformManualOperation = $grpc.ClientMethod<
          $20.BulkPerformManualOperationRequest,
          $20.BulkPerformManualOperationResponse>(
      '/giftcards.GiftCardsService/BulkPerformManualOperation',
      ($20.BulkPerformManualOperationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.BulkPerformManualOperationResponse.fromBuffer(value));
  static final _$performManualOperation = $grpc.ClientMethod<
          $20.PerformManualOperationRequest,
          $20.PerformManualOperationResponse>(
      '/giftcards.GiftCardsService/PerformManualOperation',
      ($20.PerformManualOperationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.PerformManualOperationResponse.fromBuffer(value));
  static final _$getGiftCardAuditLog = $grpc.ClientMethod<
          $20.GetGiftCardAuditLogRequest, $20.GetGiftCardAuditLogResponse>(
      '/giftcards.GiftCardsService/GetGiftCardAuditLog',
      ($20.GetGiftCardAuditLogRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetGiftCardAuditLogResponse.fromBuffer(value));
  static final _$listSystemSettings = $grpc.ClientMethod<
          $20.ListSystemSettingsRequest, $20.ListSystemSettingsResponse>(
      '/giftcards.GiftCardsService/ListSystemSettings',
      ($20.ListSystemSettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.ListSystemSettingsResponse.fromBuffer(value));
  static final _$updateSystemSetting = $grpc.ClientMethod<
          $20.UpdateSystemSettingRequest, $20.UpdateSystemSettingResponse>(
      '/giftcards.GiftCardsService/UpdateSystemSetting',
      ($20.UpdateSystemSettingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.UpdateSystemSettingResponse.fromBuffer(value));

  GiftCardsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$20.BuyGiftCardResponse> buyGiftCard(
      $20.BuyGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetRedeemCodeResponse> getRedeemCode(
      $20.GetRedeemCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRedeemCode, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardsResponse> getGiftCards(
      $20.GetGiftCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCards, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardResponse> getGiftCard(
      $20.GetGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardBrandsResponse> getGiftCardBrands(
      $20.GetGiftCardBrandsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardBrands, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardHistoryResponse> getGiftCardHistory(
      $20.GetGiftCardHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardHistory, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSellableCardsResponse> getSellableCards(
      $20.GetSellableCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellableCards, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSellProviderResponse> getSellProvider(
      $20.GetSellProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellProvider, request, options: options);
  }

  $grpc.ResponseFuture<$20.UpdateFeatureFlagResponse> updateFeatureFlag(
      $20.UpdateFeatureFlagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFeatureFlag, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetPayoutMethodsResponse> getPayoutMethods(
      $20.GetPayoutMethodsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutMethods, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSellRateResponse> getSellRate(
      $20.GetSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$20.UploadSellImageResponse> uploadSellImage(
      $20.UploadSellImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadSellImage, request, options: options);
  }

  $grpc.ResponseFuture<$20.ExtractCardDetailsResponse> extractCardDetails(
      $20.ExtractCardDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$extractCardDetails, request, options: options);
  }

  $grpc.ResponseFuture<$20.SellGiftCardResponse> sellGiftCard(
      $20.SellGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSellStatusResponse> getSellStatus(
      $20.GetSellStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellStatus, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetMySalesResponse> getMySales(
      $20.GetMySalesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMySales, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminListPendingSalesResponse> adminListPendingSales(
      $20.AdminListPendingSalesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListPendingSales, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminListBuyTransactionsResponse>
      adminListBuyTransactions($20.AdminListBuyTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListBuyTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.AdminListSellSettlementsResponse>
      adminListSellSettlements($20.AdminListSellSettlementsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSellSettlements, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.AdminListRefundLedgerResponse> adminListRefundLedger(
      $20.AdminListRefundLedgerRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListRefundLedger, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminGetSaleDetailResponse> adminGetSaleDetail(
      $20.AdminGetSaleDetailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetSaleDetail, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminApproveSaleResponse> adminApproveSale(
      $20.AdminApproveSaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminApproveSale, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminProcessPayoutResponse> adminProcessPayout(
      $20.AdminProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminProcessPayout, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminRejectSaleResponse> adminRejectSale(
      $20.AdminRejectSaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRejectSale, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminRetryHoldReleaseResponse> adminRetryHoldRelease(
      $20.AdminRetryHoldReleaseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRetryHoldRelease, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminManualRefundPurchaseResponse>
      adminManualRefundPurchase($20.AdminManualRefundPurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminManualRefundPurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.AdminForceReconcilePurchaseResponse>
      adminForceReconcilePurchase(
          $20.AdminForceReconcilePurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminForceReconcilePurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.AdminSetSellPayoutOverrideResponse>
      adminSetSellPayoutOverride($20.AdminSetSellPayoutOverrideRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminSetSellPayoutOverride, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.AdminListSellRatesResponse> adminListSellRates(
      $20.AdminListSellRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSellRates, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminCreateSellRateResponse> adminCreateSellRate(
      $20.AdminCreateSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminCreateSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminUpdateSellRateResponse> adminUpdateSellRate(
      $20.AdminUpdateSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpdateSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$20.AdminToggleSellRateResponse> adminToggleSellRate(
      $20.AdminToggleSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminToggleSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSupportedCountriesResponse> getSupportedCountries(
      $20.GetSupportedCountriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCountries, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics(
      $20.GetGiftCardsAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardsAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetReconciliationOverviewResponse>
      getReconciliationOverview($20.GetReconciliationOverviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationOverview, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.GetOrphanedTransactionsResponse>
      getOrphanedTransactions($20.GetOrphanedTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrphanedTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.ResolveOrphanedTransactionResponse>
      resolveOrphanedTransaction($20.ResolveOrphanedTransactionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveOrphanedTransaction, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.GetPendingVerificationsResponse>
      getPendingVerifications($20.GetPendingVerificationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingVerifications, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.GetEscalatedItemsResponse> getEscalatedItems(
      $20.GetEscalatedItemsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEscalatedItems, request, options: options);
  }

  $grpc.ResponseFuture<$20.ResolveEscalatedItemResponse> resolveEscalatedItem(
      $20.ResolveEscalatedItemRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveEscalatedItem, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetReconciliationHistoryResponse>
      getReconciliationHistory($20.GetReconciliationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.LookupUserResponse> lookupUser(
      $20.LookupUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupUser, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetUserDetailsResponse> getUserDetails(
      $20.GetUserDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDetails, request, options: options);
  }

  $grpc.ResponseFuture<$20.SearchGiftCardTransactionResponse>
      searchGiftCardTransaction($20.SearchGiftCardTransactionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchGiftCardTransaction, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.BulkPerformManualOperationResponse>
      bulkPerformManualOperation($20.BulkPerformManualOperationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkPerformManualOperation, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.PerformManualOperationResponse>
      performManualOperation($20.PerformManualOperationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$performManualOperation, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardAuditLogResponse> getGiftCardAuditLog(
      $20.GetGiftCardAuditLogRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardAuditLog, request, options: options);
  }

  $grpc.ResponseFuture<$20.ListSystemSettingsResponse> listSystemSettings(
      $20.ListSystemSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSystemSettings, request, options: options);
  }

  $grpc.ResponseFuture<$20.UpdateSystemSettingResponse> updateSystemSetting(
      $20.UpdateSystemSettingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSystemSetting, request, options: options);
  }
}

abstract class GiftCardsServiceBase extends $grpc.Service {
  $core.String get $name => 'giftcards.GiftCardsService';

  GiftCardsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$20.BuyGiftCardRequest, $20.BuyGiftCardResponse>(
            'BuyGiftCard',
            buyGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.BuyGiftCardRequest.fromBuffer(value),
            ($20.BuyGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetRedeemCodeRequest,
            $20.GetRedeemCodeResponse>(
        'GetRedeemCode',
        getRedeemCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetRedeemCodeRequest.fromBuffer(value),
        ($20.GetRedeemCodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.GetGiftCardsRequest, $20.GetGiftCardsResponse>(
            'GetGiftCards',
            getGiftCards_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetGiftCardsRequest.fromBuffer(value),
            ($20.GetGiftCardsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.GetGiftCardRequest, $20.GetGiftCardResponse>(
            'GetGiftCard',
            getGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetGiftCardRequest.fromBuffer(value),
            ($20.GetGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetGiftCardBrandsRequest,
            $20.GetGiftCardBrandsResponse>(
        'GetGiftCardBrands',
        getGiftCardBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetGiftCardBrandsRequest.fromBuffer(value),
        ($20.GetGiftCardBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetGiftCardHistoryRequest,
            $20.GetGiftCardHistoryResponse>(
        'GetGiftCardHistory',
        getGiftCardHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetGiftCardHistoryRequest.fromBuffer(value),
        ($20.GetGiftCardHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSellableCardsRequest,
            $20.GetSellableCardsResponse>(
        'GetSellableCards',
        getSellableCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSellableCardsRequest.fromBuffer(value),
        ($20.GetSellableCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSellProviderRequest,
            $20.GetSellProviderResponse>(
        'GetSellProvider',
        getSellProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSellProviderRequest.fromBuffer(value),
        ($20.GetSellProviderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.UpdateFeatureFlagRequest,
            $20.UpdateFeatureFlagResponse>(
        'UpdateFeatureFlag',
        updateFeatureFlag_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.UpdateFeatureFlagRequest.fromBuffer(value),
        ($20.UpdateFeatureFlagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetPayoutMethodsRequest,
            $20.GetPayoutMethodsResponse>(
        'GetPayoutMethods',
        getPayoutMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetPayoutMethodsRequest.fromBuffer(value),
        ($20.GetPayoutMethodsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.GetSellRateRequest, $20.GetSellRateResponse>(
            'GetSellRate',
            getSellRate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetSellRateRequest.fromBuffer(value),
            ($20.GetSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.UploadSellImageRequest,
            $20.UploadSellImageResponse>(
        'UploadSellImage',
        uploadSellImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.UploadSellImageRequest.fromBuffer(value),
        ($20.UploadSellImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ExtractCardDetailsRequest,
            $20.ExtractCardDetailsResponse>(
        'ExtractCardDetails',
        extractCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.ExtractCardDetailsRequest.fromBuffer(value),
        ($20.ExtractCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.SellGiftCardRequest, $20.SellGiftCardResponse>(
            'SellGiftCard',
            sellGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.SellGiftCardRequest.fromBuffer(value),
            ($20.SellGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSellStatusRequest,
            $20.GetSellStatusResponse>(
        'GetSellStatus',
        getSellStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSellStatusRequest.fromBuffer(value),
        ($20.GetSellStatusResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.GetMySalesRequest, $20.GetMySalesResponse>(
            'GetMySales',
            getMySales_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetMySalesRequest.fromBuffer(value),
            ($20.GetMySalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminListPendingSalesRequest,
            $20.AdminListPendingSalesResponse>(
        'AdminListPendingSales',
        adminListPendingSales_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminListPendingSalesRequest.fromBuffer(value),
        ($20.AdminListPendingSalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminListBuyTransactionsRequest,
            $20.AdminListBuyTransactionsResponse>(
        'AdminListBuyTransactions',
        adminListBuyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminListBuyTransactionsRequest.fromBuffer(value),
        ($20.AdminListBuyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminListSellSettlementsRequest,
            $20.AdminListSellSettlementsResponse>(
        'AdminListSellSettlements',
        adminListSellSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminListSellSettlementsRequest.fromBuffer(value),
        ($20.AdminListSellSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminListRefundLedgerRequest,
            $20.AdminListRefundLedgerResponse>(
        'AdminListRefundLedger',
        adminListRefundLedger_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminListRefundLedgerRequest.fromBuffer(value),
        ($20.AdminListRefundLedgerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminGetSaleDetailRequest,
            $20.AdminGetSaleDetailResponse>(
        'AdminGetSaleDetail',
        adminGetSaleDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminGetSaleDetailRequest.fromBuffer(value),
        ($20.AdminGetSaleDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminApproveSaleRequest,
            $20.AdminApproveSaleResponse>(
        'AdminApproveSale',
        adminApproveSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminApproveSaleRequest.fromBuffer(value),
        ($20.AdminApproveSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminProcessPayoutRequest,
            $20.AdminProcessPayoutResponse>(
        'AdminProcessPayout',
        adminProcessPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminProcessPayoutRequest.fromBuffer(value),
        ($20.AdminProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminRejectSaleRequest,
            $20.AdminRejectSaleResponse>(
        'AdminRejectSale',
        adminRejectSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminRejectSaleRequest.fromBuffer(value),
        ($20.AdminRejectSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminRetryHoldReleaseRequest,
            $20.AdminRetryHoldReleaseResponse>(
        'AdminRetryHoldRelease',
        adminRetryHoldRelease_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminRetryHoldReleaseRequest.fromBuffer(value),
        ($20.AdminRetryHoldReleaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminManualRefundPurchaseRequest,
            $20.AdminManualRefundPurchaseResponse>(
        'AdminManualRefundPurchase',
        adminManualRefundPurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminManualRefundPurchaseRequest.fromBuffer(value),
        ($20.AdminManualRefundPurchaseResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminForceReconcilePurchaseRequest,
            $20.AdminForceReconcilePurchaseResponse>(
        'AdminForceReconcilePurchase',
        adminForceReconcilePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminForceReconcilePurchaseRequest.fromBuffer(value),
        ($20.AdminForceReconcilePurchaseResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminSetSellPayoutOverrideRequest,
            $20.AdminSetSellPayoutOverrideResponse>(
        'AdminSetSellPayoutOverride',
        adminSetSellPayoutOverride_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminSetSellPayoutOverrideRequest.fromBuffer(value),
        ($20.AdminSetSellPayoutOverrideResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminListSellRatesRequest,
            $20.AdminListSellRatesResponse>(
        'AdminListSellRates',
        adminListSellRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminListSellRatesRequest.fromBuffer(value),
        ($20.AdminListSellRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminCreateSellRateRequest,
            $20.AdminCreateSellRateResponse>(
        'AdminCreateSellRate',
        adminCreateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminCreateSellRateRequest.fromBuffer(value),
        ($20.AdminCreateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminUpdateSellRateRequest,
            $20.AdminUpdateSellRateResponse>(
        'AdminUpdateSellRate',
        adminUpdateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminUpdateSellRateRequest.fromBuffer(value),
        ($20.AdminUpdateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AdminToggleSellRateRequest,
            $20.AdminToggleSellRateResponse>(
        'AdminToggleSellRate',
        adminToggleSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminToggleSellRateRequest.fromBuffer(value),
        ($20.AdminToggleSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSupportedCountriesRequest,
            $20.GetSupportedCountriesResponse>(
        'GetSupportedCountries',
        getSupportedCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSupportedCountriesRequest.fromBuffer(value),
        ($20.GetSupportedCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetGiftCardsAnalyticsRequest,
            $20.GetGiftCardsAnalyticsResponse>(
        'GetGiftCardsAnalytics',
        getGiftCardsAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetGiftCardsAnalyticsRequest.fromBuffer(value),
        ($20.GetGiftCardsAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetReconciliationOverviewRequest,
            $20.GetReconciliationOverviewResponse>(
        'GetReconciliationOverview',
        getReconciliationOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetReconciliationOverviewRequest.fromBuffer(value),
        ($20.GetReconciliationOverviewResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetOrphanedTransactionsRequest,
            $20.GetOrphanedTransactionsResponse>(
        'GetOrphanedTransactions',
        getOrphanedTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetOrphanedTransactionsRequest.fromBuffer(value),
        ($20.GetOrphanedTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ResolveOrphanedTransactionRequest,
            $20.ResolveOrphanedTransactionResponse>(
        'ResolveOrphanedTransaction',
        resolveOrphanedTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.ResolveOrphanedTransactionRequest.fromBuffer(value),
        ($20.ResolveOrphanedTransactionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetPendingVerificationsRequest,
            $20.GetPendingVerificationsResponse>(
        'GetPendingVerifications',
        getPendingVerifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetPendingVerificationsRequest.fromBuffer(value),
        ($20.GetPendingVerificationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetEscalatedItemsRequest,
            $20.GetEscalatedItemsResponse>(
        'GetEscalatedItems',
        getEscalatedItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetEscalatedItemsRequest.fromBuffer(value),
        ($20.GetEscalatedItemsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ResolveEscalatedItemRequest,
            $20.ResolveEscalatedItemResponse>(
        'ResolveEscalatedItem',
        resolveEscalatedItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.ResolveEscalatedItemRequest.fromBuffer(value),
        ($20.ResolveEscalatedItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetReconciliationHistoryRequest,
            $20.GetReconciliationHistoryResponse>(
        'GetReconciliationHistory',
        getReconciliationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetReconciliationHistoryRequest.fromBuffer(value),
        ($20.GetReconciliationHistoryResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.LookupUserRequest, $20.LookupUserResponse>(
            'LookupUser',
            lookupUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.LookupUserRequest.fromBuffer(value),
            ($20.LookupUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetUserDetailsRequest,
            $20.GetUserDetailsResponse>(
        'GetUserDetails',
        getUserDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetUserDetailsRequest.fromBuffer(value),
        ($20.GetUserDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.SearchGiftCardTransactionRequest,
            $20.SearchGiftCardTransactionResponse>(
        'SearchGiftCardTransaction',
        searchGiftCardTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.SearchGiftCardTransactionRequest.fromBuffer(value),
        ($20.SearchGiftCardTransactionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.BulkPerformManualOperationRequest,
            $20.BulkPerformManualOperationResponse>(
        'BulkPerformManualOperation',
        bulkPerformManualOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.BulkPerformManualOperationRequest.fromBuffer(value),
        ($20.BulkPerformManualOperationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.PerformManualOperationRequest,
            $20.PerformManualOperationResponse>(
        'PerformManualOperation',
        performManualOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.PerformManualOperationRequest.fromBuffer(value),
        ($20.PerformManualOperationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetGiftCardAuditLogRequest,
            $20.GetGiftCardAuditLogResponse>(
        'GetGiftCardAuditLog',
        getGiftCardAuditLog_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetGiftCardAuditLogRequest.fromBuffer(value),
        ($20.GetGiftCardAuditLogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ListSystemSettingsRequest,
            $20.ListSystemSettingsResponse>(
        'ListSystemSettings',
        listSystemSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.ListSystemSettingsRequest.fromBuffer(value),
        ($20.ListSystemSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.UpdateSystemSettingRequest,
            $20.UpdateSystemSettingResponse>(
        'UpdateSystemSetting',
        updateSystemSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.UpdateSystemSettingRequest.fromBuffer(value),
        ($20.UpdateSystemSettingResponse value) => value.writeToBuffer()));
  }

  $async.Future<$20.BuyGiftCardResponse> buyGiftCard_Pre($grpc.ServiceCall call,
      $async.Future<$20.BuyGiftCardRequest> request) async {
    return buyGiftCard(call, await request);
  }

  $async.Future<$20.GetRedeemCodeResponse> getRedeemCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetRedeemCodeRequest> request) async {
    return getRedeemCode(call, await request);
  }

  $async.Future<$20.GetGiftCardsResponse> getGiftCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetGiftCardsRequest> request) async {
    return getGiftCards(call, await request);
  }

  $async.Future<$20.GetGiftCardResponse> getGiftCard_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetGiftCardRequest> request) async {
    return getGiftCard(call, await request);
  }

  $async.Future<$20.GetGiftCardBrandsResponse> getGiftCardBrands_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetGiftCardBrandsRequest> request) async {
    return getGiftCardBrands(call, await request);
  }

  $async.Future<$20.GetGiftCardHistoryResponse> getGiftCardHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetGiftCardHistoryRequest> request) async {
    return getGiftCardHistory(call, await request);
  }

  $async.Future<$20.GetSellableCardsResponse> getSellableCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSellableCardsRequest> request) async {
    return getSellableCards(call, await request);
  }

  $async.Future<$20.GetSellProviderResponse> getSellProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSellProviderRequest> request) async {
    return getSellProvider(call, await request);
  }

  $async.Future<$20.UpdateFeatureFlagResponse> updateFeatureFlag_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.UpdateFeatureFlagRequest> request) async {
    return updateFeatureFlag(call, await request);
  }

  $async.Future<$20.GetPayoutMethodsResponse> getPayoutMethods_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetPayoutMethodsRequest> request) async {
    return getPayoutMethods(call, await request);
  }

  $async.Future<$20.GetSellRateResponse> getSellRate_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetSellRateRequest> request) async {
    return getSellRate(call, await request);
  }

  $async.Future<$20.UploadSellImageResponse> uploadSellImage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.UploadSellImageRequest> request) async {
    return uploadSellImage(call, await request);
  }

  $async.Future<$20.ExtractCardDetailsResponse> extractCardDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.ExtractCardDetailsRequest> request) async {
    return extractCardDetails(call, await request);
  }

  $async.Future<$20.SellGiftCardResponse> sellGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.SellGiftCardRequest> request) async {
    return sellGiftCard(call, await request);
  }

  $async.Future<$20.GetSellStatusResponse> getSellStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSellStatusRequest> request) async {
    return getSellStatus(call, await request);
  }

  $async.Future<$20.GetMySalesResponse> getMySales_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetMySalesRequest> request) async {
    return getMySales(call, await request);
  }

  $async.Future<$20.AdminListPendingSalesResponse> adminListPendingSales_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminListPendingSalesRequest> request) async {
    return adminListPendingSales(call, await request);
  }

  $async.Future<$20.AdminListBuyTransactionsResponse>
      adminListBuyTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$20.AdminListBuyTransactionsRequest> request) async {
    return adminListBuyTransactions(call, await request);
  }

  $async.Future<$20.AdminListSellSettlementsResponse>
      adminListSellSettlements_Pre($grpc.ServiceCall call,
          $async.Future<$20.AdminListSellSettlementsRequest> request) async {
    return adminListSellSettlements(call, await request);
  }

  $async.Future<$20.AdminListRefundLedgerResponse> adminListRefundLedger_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminListRefundLedgerRequest> request) async {
    return adminListRefundLedger(call, await request);
  }

  $async.Future<$20.AdminGetSaleDetailResponse> adminGetSaleDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminGetSaleDetailRequest> request) async {
    return adminGetSaleDetail(call, await request);
  }

  $async.Future<$20.AdminApproveSaleResponse> adminApproveSale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminApproveSaleRequest> request) async {
    return adminApproveSale(call, await request);
  }

  $async.Future<$20.AdminProcessPayoutResponse> adminProcessPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminProcessPayoutRequest> request) async {
    return adminProcessPayout(call, await request);
  }

  $async.Future<$20.AdminRejectSaleResponse> adminRejectSale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminRejectSaleRequest> request) async {
    return adminRejectSale(call, await request);
  }

  $async.Future<$20.AdminRetryHoldReleaseResponse> adminRetryHoldRelease_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminRetryHoldReleaseRequest> request) async {
    return adminRetryHoldRelease(call, await request);
  }

  $async.Future<$20.AdminManualRefundPurchaseResponse>
      adminManualRefundPurchase_Pre($grpc.ServiceCall call,
          $async.Future<$20.AdminManualRefundPurchaseRequest> request) async {
    return adminManualRefundPurchase(call, await request);
  }

  $async.Future<$20.AdminForceReconcilePurchaseResponse>
      adminForceReconcilePurchase_Pre($grpc.ServiceCall call,
          $async.Future<$20.AdminForceReconcilePurchaseRequest> request) async {
    return adminForceReconcilePurchase(call, await request);
  }

  $async.Future<$20.AdminSetSellPayoutOverrideResponse>
      adminSetSellPayoutOverride_Pre($grpc.ServiceCall call,
          $async.Future<$20.AdminSetSellPayoutOverrideRequest> request) async {
    return adminSetSellPayoutOverride(call, await request);
  }

  $async.Future<$20.AdminListSellRatesResponse> adminListSellRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminListSellRatesRequest> request) async {
    return adminListSellRates(call, await request);
  }

  $async.Future<$20.AdminCreateSellRateResponse> adminCreateSellRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminCreateSellRateRequest> request) async {
    return adminCreateSellRate(call, await request);
  }

  $async.Future<$20.AdminUpdateSellRateResponse> adminUpdateSellRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminUpdateSellRateRequest> request) async {
    return adminUpdateSellRate(call, await request);
  }

  $async.Future<$20.AdminToggleSellRateResponse> adminToggleSellRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminToggleSellRateRequest> request) async {
    return adminToggleSellRate(call, await request);
  }

  $async.Future<$20.GetSupportedCountriesResponse> getSupportedCountries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSupportedCountriesRequest> request) async {
    return getSupportedCountries(call, await request);
  }

  $async.Future<$20.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetGiftCardsAnalyticsRequest> request) async {
    return getGiftCardsAnalytics(call, await request);
  }

  $async.Future<$20.GetReconciliationOverviewResponse>
      getReconciliationOverview_Pre($grpc.ServiceCall call,
          $async.Future<$20.GetReconciliationOverviewRequest> request) async {
    return getReconciliationOverview(call, await request);
  }

  $async.Future<$20.GetOrphanedTransactionsResponse>
      getOrphanedTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$20.GetOrphanedTransactionsRequest> request) async {
    return getOrphanedTransactions(call, await request);
  }

  $async.Future<$20.ResolveOrphanedTransactionResponse>
      resolveOrphanedTransaction_Pre($grpc.ServiceCall call,
          $async.Future<$20.ResolveOrphanedTransactionRequest> request) async {
    return resolveOrphanedTransaction(call, await request);
  }

  $async.Future<$20.GetPendingVerificationsResponse>
      getPendingVerifications_Pre($grpc.ServiceCall call,
          $async.Future<$20.GetPendingVerificationsRequest> request) async {
    return getPendingVerifications(call, await request);
  }

  $async.Future<$20.GetEscalatedItemsResponse> getEscalatedItems_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetEscalatedItemsRequest> request) async {
    return getEscalatedItems(call, await request);
  }

  $async.Future<$20.ResolveEscalatedItemResponse> resolveEscalatedItem_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.ResolveEscalatedItemRequest> request) async {
    return resolveEscalatedItem(call, await request);
  }

  $async.Future<$20.GetReconciliationHistoryResponse>
      getReconciliationHistory_Pre($grpc.ServiceCall call,
          $async.Future<$20.GetReconciliationHistoryRequest> request) async {
    return getReconciliationHistory(call, await request);
  }

  $async.Future<$20.LookupUserResponse> lookupUser_Pre($grpc.ServiceCall call,
      $async.Future<$20.LookupUserRequest> request) async {
    return lookupUser(call, await request);
  }

  $async.Future<$20.GetUserDetailsResponse> getUserDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetUserDetailsRequest> request) async {
    return getUserDetails(call, await request);
  }

  $async.Future<$20.SearchGiftCardTransactionResponse>
      searchGiftCardTransaction_Pre($grpc.ServiceCall call,
          $async.Future<$20.SearchGiftCardTransactionRequest> request) async {
    return searchGiftCardTransaction(call, await request);
  }

  $async.Future<$20.BulkPerformManualOperationResponse>
      bulkPerformManualOperation_Pre($grpc.ServiceCall call,
          $async.Future<$20.BulkPerformManualOperationRequest> request) async {
    return bulkPerformManualOperation(call, await request);
  }

  $async.Future<$20.PerformManualOperationResponse> performManualOperation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.PerformManualOperationRequest> request) async {
    return performManualOperation(call, await request);
  }

  $async.Future<$20.GetGiftCardAuditLogResponse> getGiftCardAuditLog_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetGiftCardAuditLogRequest> request) async {
    return getGiftCardAuditLog(call, await request);
  }

  $async.Future<$20.ListSystemSettingsResponse> listSystemSettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.ListSystemSettingsRequest> request) async {
    return listSystemSettings(call, await request);
  }

  $async.Future<$20.UpdateSystemSettingResponse> updateSystemSetting_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.UpdateSystemSettingRequest> request) async {
    return updateSystemSetting(call, await request);
  }

  $async.Future<$20.BuyGiftCardResponse> buyGiftCard(
      $grpc.ServiceCall call, $20.BuyGiftCardRequest request);
  $async.Future<$20.GetRedeemCodeResponse> getRedeemCode(
      $grpc.ServiceCall call, $20.GetRedeemCodeRequest request);
  $async.Future<$20.GetGiftCardsResponse> getGiftCards(
      $grpc.ServiceCall call, $20.GetGiftCardsRequest request);
  $async.Future<$20.GetGiftCardResponse> getGiftCard(
      $grpc.ServiceCall call, $20.GetGiftCardRequest request);
  $async.Future<$20.GetGiftCardBrandsResponse> getGiftCardBrands(
      $grpc.ServiceCall call, $20.GetGiftCardBrandsRequest request);
  $async.Future<$20.GetGiftCardHistoryResponse> getGiftCardHistory(
      $grpc.ServiceCall call, $20.GetGiftCardHistoryRequest request);
  $async.Future<$20.GetSellableCardsResponse> getSellableCards(
      $grpc.ServiceCall call, $20.GetSellableCardsRequest request);
  $async.Future<$20.GetSellProviderResponse> getSellProvider(
      $grpc.ServiceCall call, $20.GetSellProviderRequest request);
  $async.Future<$20.UpdateFeatureFlagResponse> updateFeatureFlag(
      $grpc.ServiceCall call, $20.UpdateFeatureFlagRequest request);
  $async.Future<$20.GetPayoutMethodsResponse> getPayoutMethods(
      $grpc.ServiceCall call, $20.GetPayoutMethodsRequest request);
  $async.Future<$20.GetSellRateResponse> getSellRate(
      $grpc.ServiceCall call, $20.GetSellRateRequest request);
  $async.Future<$20.UploadSellImageResponse> uploadSellImage(
      $grpc.ServiceCall call, $20.UploadSellImageRequest request);
  $async.Future<$20.ExtractCardDetailsResponse> extractCardDetails(
      $grpc.ServiceCall call, $20.ExtractCardDetailsRequest request);
  $async.Future<$20.SellGiftCardResponse> sellGiftCard(
      $grpc.ServiceCall call, $20.SellGiftCardRequest request);
  $async.Future<$20.GetSellStatusResponse> getSellStatus(
      $grpc.ServiceCall call, $20.GetSellStatusRequest request);
  $async.Future<$20.GetMySalesResponse> getMySales(
      $grpc.ServiceCall call, $20.GetMySalesRequest request);
  $async.Future<$20.AdminListPendingSalesResponse> adminListPendingSales(
      $grpc.ServiceCall call, $20.AdminListPendingSalesRequest request);
  $async.Future<$20.AdminListBuyTransactionsResponse> adminListBuyTransactions(
      $grpc.ServiceCall call, $20.AdminListBuyTransactionsRequest request);
  $async.Future<$20.AdminListSellSettlementsResponse> adminListSellSettlements(
      $grpc.ServiceCall call, $20.AdminListSellSettlementsRequest request);
  $async.Future<$20.AdminListRefundLedgerResponse> adminListRefundLedger(
      $grpc.ServiceCall call, $20.AdminListRefundLedgerRequest request);
  $async.Future<$20.AdminGetSaleDetailResponse> adminGetSaleDetail(
      $grpc.ServiceCall call, $20.AdminGetSaleDetailRequest request);
  $async.Future<$20.AdminApproveSaleResponse> adminApproveSale(
      $grpc.ServiceCall call, $20.AdminApproveSaleRequest request);
  $async.Future<$20.AdminProcessPayoutResponse> adminProcessPayout(
      $grpc.ServiceCall call, $20.AdminProcessPayoutRequest request);
  $async.Future<$20.AdminRejectSaleResponse> adminRejectSale(
      $grpc.ServiceCall call, $20.AdminRejectSaleRequest request);
  $async.Future<$20.AdminRetryHoldReleaseResponse> adminRetryHoldRelease(
      $grpc.ServiceCall call, $20.AdminRetryHoldReleaseRequest request);
  $async.Future<$20.AdminManualRefundPurchaseResponse>
      adminManualRefundPurchase(
          $grpc.ServiceCall call, $20.AdminManualRefundPurchaseRequest request);
  $async.Future<$20.AdminForceReconcilePurchaseResponse>
      adminForceReconcilePurchase($grpc.ServiceCall call,
          $20.AdminForceReconcilePurchaseRequest request);
  $async.Future<$20.AdminSetSellPayoutOverrideResponse>
      adminSetSellPayoutOverride($grpc.ServiceCall call,
          $20.AdminSetSellPayoutOverrideRequest request);
  $async.Future<$20.AdminListSellRatesResponse> adminListSellRates(
      $grpc.ServiceCall call, $20.AdminListSellRatesRequest request);
  $async.Future<$20.AdminCreateSellRateResponse> adminCreateSellRate(
      $grpc.ServiceCall call, $20.AdminCreateSellRateRequest request);
  $async.Future<$20.AdminUpdateSellRateResponse> adminUpdateSellRate(
      $grpc.ServiceCall call, $20.AdminUpdateSellRateRequest request);
  $async.Future<$20.AdminToggleSellRateResponse> adminToggleSellRate(
      $grpc.ServiceCall call, $20.AdminToggleSellRateRequest request);
  $async.Future<$20.GetSupportedCountriesResponse> getSupportedCountries(
      $grpc.ServiceCall call, $20.GetSupportedCountriesRequest request);
  $async.Future<$20.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics(
      $grpc.ServiceCall call, $20.GetGiftCardsAnalyticsRequest request);
  $async.Future<$20.GetReconciliationOverviewResponse>
      getReconciliationOverview(
          $grpc.ServiceCall call, $20.GetReconciliationOverviewRequest request);
  $async.Future<$20.GetOrphanedTransactionsResponse> getOrphanedTransactions(
      $grpc.ServiceCall call, $20.GetOrphanedTransactionsRequest request);
  $async.Future<$20.ResolveOrphanedTransactionResponse>
      resolveOrphanedTransaction($grpc.ServiceCall call,
          $20.ResolveOrphanedTransactionRequest request);
  $async.Future<$20.GetPendingVerificationsResponse> getPendingVerifications(
      $grpc.ServiceCall call, $20.GetPendingVerificationsRequest request);
  $async.Future<$20.GetEscalatedItemsResponse> getEscalatedItems(
      $grpc.ServiceCall call, $20.GetEscalatedItemsRequest request);
  $async.Future<$20.ResolveEscalatedItemResponse> resolveEscalatedItem(
      $grpc.ServiceCall call, $20.ResolveEscalatedItemRequest request);
  $async.Future<$20.GetReconciliationHistoryResponse> getReconciliationHistory(
      $grpc.ServiceCall call, $20.GetReconciliationHistoryRequest request);
  $async.Future<$20.LookupUserResponse> lookupUser(
      $grpc.ServiceCall call, $20.LookupUserRequest request);
  $async.Future<$20.GetUserDetailsResponse> getUserDetails(
      $grpc.ServiceCall call, $20.GetUserDetailsRequest request);
  $async.Future<$20.SearchGiftCardTransactionResponse>
      searchGiftCardTransaction(
          $grpc.ServiceCall call, $20.SearchGiftCardTransactionRequest request);
  $async.Future<$20.BulkPerformManualOperationResponse>
      bulkPerformManualOperation($grpc.ServiceCall call,
          $20.BulkPerformManualOperationRequest request);
  $async.Future<$20.PerformManualOperationResponse> performManualOperation(
      $grpc.ServiceCall call, $20.PerformManualOperationRequest request);
  $async.Future<$20.GetGiftCardAuditLogResponse> getGiftCardAuditLog(
      $grpc.ServiceCall call, $20.GetGiftCardAuditLogRequest request);
  $async.Future<$20.ListSystemSettingsResponse> listSystemSettings(
      $grpc.ServiceCall call, $20.ListSystemSettingsRequest request);
  $async.Future<$20.UpdateSystemSettingResponse> updateSystemSetting(
      $grpc.ServiceCall call, $20.UpdateSystemSettingRequest request);
}
