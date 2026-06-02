///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'giftcards.pb.dart' as $21;
export 'giftcards.pb.dart';

class GiftCardsServiceClient extends $grpc.Client {
  static final _$buyGiftCard =
      $grpc.ClientMethod<$21.BuyGiftCardRequest, $21.BuyGiftCardResponse>(
          '/giftcards.GiftCardsService/BuyGiftCard',
          ($21.BuyGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.BuyGiftCardResponse.fromBuffer(value));
  static final _$getRedeemCode =
      $grpc.ClientMethod<$21.GetRedeemCodeRequest, $21.GetRedeemCodeResponse>(
          '/giftcards.GiftCardsService/GetRedeemCode',
          ($21.GetRedeemCodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetRedeemCodeResponse.fromBuffer(value));
  static final _$getGiftCards =
      $grpc.ClientMethod<$21.GetGiftCardsRequest, $21.GetGiftCardsResponse>(
          '/giftcards.GiftCardsService/GetGiftCards',
          ($21.GetGiftCardsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetGiftCardsResponse.fromBuffer(value));
  static final _$getGiftCard =
      $grpc.ClientMethod<$21.GetGiftCardRequest, $21.GetGiftCardResponse>(
          '/giftcards.GiftCardsService/GetGiftCard',
          ($21.GetGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetGiftCardResponse.fromBuffer(value));
  static final _$getGiftCardBrands = $grpc.ClientMethod<
          $21.GetGiftCardBrandsRequest, $21.GetGiftCardBrandsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardBrands',
      ($21.GetGiftCardBrandsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetGiftCardBrandsResponse.fromBuffer(value));
  static final _$getGiftCardHistory = $grpc.ClientMethod<
          $21.GetGiftCardHistoryRequest, $21.GetGiftCardHistoryResponse>(
      '/giftcards.GiftCardsService/GetGiftCardHistory',
      ($21.GetGiftCardHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetGiftCardHistoryResponse.fromBuffer(value));
  static final _$getSellableCards = $grpc.ClientMethod<
          $21.GetSellableCardsRequest, $21.GetSellableCardsResponse>(
      '/giftcards.GiftCardsService/GetSellableCards',
      ($21.GetSellableCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetSellableCardsResponse.fromBuffer(value));
  static final _$getSellProvider = $grpc.ClientMethod<
          $21.GetSellProviderRequest, $21.GetSellProviderResponse>(
      '/giftcards.GiftCardsService/GetSellProvider',
      ($21.GetSellProviderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetSellProviderResponse.fromBuffer(value));
  static final _$updateFeatureFlag = $grpc.ClientMethod<
          $21.UpdateFeatureFlagRequest, $21.UpdateFeatureFlagResponse>(
      '/giftcards.GiftCardsService/UpdateFeatureFlag',
      ($21.UpdateFeatureFlagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.UpdateFeatureFlagResponse.fromBuffer(value));
  static final _$getPayoutMethods = $grpc.ClientMethod<
          $21.GetPayoutMethodsRequest, $21.GetPayoutMethodsResponse>(
      '/giftcards.GiftCardsService/GetPayoutMethods',
      ($21.GetPayoutMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetPayoutMethodsResponse.fromBuffer(value));
  static final _$getSellRate =
      $grpc.ClientMethod<$21.GetSellRateRequest, $21.GetSellRateResponse>(
          '/giftcards.GiftCardsService/GetSellRate',
          ($21.GetSellRateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetSellRateResponse.fromBuffer(value));
  static final _$uploadSellImage = $grpc.ClientMethod<
          $21.UploadSellImageRequest, $21.UploadSellImageResponse>(
      '/giftcards.GiftCardsService/UploadSellImage',
      ($21.UploadSellImageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.UploadSellImageResponse.fromBuffer(value));
  static final _$extractCardDetails = $grpc.ClientMethod<
          $21.ExtractCardDetailsRequest, $21.ExtractCardDetailsResponse>(
      '/giftcards.GiftCardsService/ExtractCardDetails',
      ($21.ExtractCardDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.ExtractCardDetailsResponse.fromBuffer(value));
  static final _$sellGiftCard =
      $grpc.ClientMethod<$21.SellGiftCardRequest, $21.SellGiftCardResponse>(
          '/giftcards.GiftCardsService/SellGiftCard',
          ($21.SellGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.SellGiftCardResponse.fromBuffer(value));
  static final _$getSellStatus =
      $grpc.ClientMethod<$21.GetSellStatusRequest, $21.GetSellStatusResponse>(
          '/giftcards.GiftCardsService/GetSellStatus',
          ($21.GetSellStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetSellStatusResponse.fromBuffer(value));
  static final _$getMySales =
      $grpc.ClientMethod<$21.GetMySalesRequest, $21.GetMySalesResponse>(
          '/giftcards.GiftCardsService/GetMySales',
          ($21.GetMySalesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetMySalesResponse.fromBuffer(value));
  static final _$adminListPendingSales = $grpc.ClientMethod<
          $21.AdminListPendingSalesRequest, $21.AdminListPendingSalesResponse>(
      '/giftcards.GiftCardsService/AdminListPendingSales',
      ($21.AdminListPendingSalesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminListPendingSalesResponse.fromBuffer(value));
  static final _$adminListBuyTransactions = $grpc.ClientMethod<
          $21.AdminListBuyTransactionsRequest,
          $21.AdminListBuyTransactionsResponse>(
      '/giftcards.GiftCardsService/AdminListBuyTransactions',
      ($21.AdminListBuyTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminListBuyTransactionsResponse.fromBuffer(value));
  static final _$adminListSellSettlements = $grpc.ClientMethod<
          $21.AdminListSellSettlementsRequest,
          $21.AdminListSellSettlementsResponse>(
      '/giftcards.GiftCardsService/AdminListSellSettlements',
      ($21.AdminListSellSettlementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminListSellSettlementsResponse.fromBuffer(value));
  static final _$adminListRefundLedger = $grpc.ClientMethod<
          $21.AdminListRefundLedgerRequest, $21.AdminListRefundLedgerResponse>(
      '/giftcards.GiftCardsService/AdminListRefundLedger',
      ($21.AdminListRefundLedgerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminListRefundLedgerResponse.fromBuffer(value));
  static final _$adminGetSaleDetail = $grpc.ClientMethod<
          $21.AdminGetSaleDetailRequest, $21.AdminGetSaleDetailResponse>(
      '/giftcards.GiftCardsService/AdminGetSaleDetail',
      ($21.AdminGetSaleDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminGetSaleDetailResponse.fromBuffer(value));
  static final _$adminApproveSale = $grpc.ClientMethod<
          $21.AdminApproveSaleRequest, $21.AdminApproveSaleResponse>(
      '/giftcards.GiftCardsService/AdminApproveSale',
      ($21.AdminApproveSaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminApproveSaleResponse.fromBuffer(value));
  static final _$adminProcessPayout = $grpc.ClientMethod<
          $21.AdminProcessPayoutRequest, $21.AdminProcessPayoutResponse>(
      '/giftcards.GiftCardsService/AdminProcessPayout',
      ($21.AdminProcessPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminProcessPayoutResponse.fromBuffer(value));
  static final _$adminRejectSale = $grpc.ClientMethod<
          $21.AdminRejectSaleRequest, $21.AdminRejectSaleResponse>(
      '/giftcards.GiftCardsService/AdminRejectSale',
      ($21.AdminRejectSaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminRejectSaleResponse.fromBuffer(value));
  static final _$adminRetryHoldRelease = $grpc.ClientMethod<
          $21.AdminRetryHoldReleaseRequest, $21.AdminRetryHoldReleaseResponse>(
      '/giftcards.GiftCardsService/AdminRetryHoldRelease',
      ($21.AdminRetryHoldReleaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminRetryHoldReleaseResponse.fromBuffer(value));
  static final _$adminManualRefundPurchase = $grpc.ClientMethod<
          $21.AdminManualRefundPurchaseRequest,
          $21.AdminManualRefundPurchaseResponse>(
      '/giftcards.GiftCardsService/AdminManualRefundPurchase',
      ($21.AdminManualRefundPurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminManualRefundPurchaseResponse.fromBuffer(value));
  static final _$adminForceReconcilePurchase = $grpc.ClientMethod<
          $21.AdminForceReconcilePurchaseRequest,
          $21.AdminForceReconcilePurchaseResponse>(
      '/giftcards.GiftCardsService/AdminForceReconcilePurchase',
      ($21.AdminForceReconcilePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminForceReconcilePurchaseResponse.fromBuffer(value));
  static final _$adminSetSellPayoutOverride = $grpc.ClientMethod<
          $21.AdminSetSellPayoutOverrideRequest,
          $21.AdminSetSellPayoutOverrideResponse>(
      '/giftcards.GiftCardsService/AdminSetSellPayoutOverride',
      ($21.AdminSetSellPayoutOverrideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminSetSellPayoutOverrideResponse.fromBuffer(value));
  static final _$adminListSellRates = $grpc.ClientMethod<
          $21.AdminListSellRatesRequest, $21.AdminListSellRatesResponse>(
      '/giftcards.GiftCardsService/AdminListSellRates',
      ($21.AdminListSellRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminListSellRatesResponse.fromBuffer(value));
  static final _$adminCreateSellRate = $grpc.ClientMethod<
          $21.AdminCreateSellRateRequest, $21.AdminCreateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminCreateSellRate',
      ($21.AdminCreateSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminCreateSellRateResponse.fromBuffer(value));
  static final _$adminUpdateSellRate = $grpc.ClientMethod<
          $21.AdminUpdateSellRateRequest, $21.AdminUpdateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminUpdateSellRate',
      ($21.AdminUpdateSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminUpdateSellRateResponse.fromBuffer(value));
  static final _$adminToggleSellRate = $grpc.ClientMethod<
          $21.AdminToggleSellRateRequest, $21.AdminToggleSellRateResponse>(
      '/giftcards.GiftCardsService/AdminToggleSellRate',
      ($21.AdminToggleSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AdminToggleSellRateResponse.fromBuffer(value));
  static final _$getSupportedCountries = $grpc.ClientMethod<
          $21.GetSupportedCountriesRequest, $21.GetSupportedCountriesResponse>(
      '/giftcards.GiftCardsService/GetSupportedCountries',
      ($21.GetSupportedCountriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetSupportedCountriesResponse.fromBuffer(value));
  static final _$getGiftCardsAnalytics = $grpc.ClientMethod<
          $21.GetGiftCardsAnalyticsRequest, $21.GetGiftCardsAnalyticsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardsAnalytics',
      ($21.GetGiftCardsAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetGiftCardsAnalyticsResponse.fromBuffer(value));
  static final _$getReconciliationOverview = $grpc.ClientMethod<
          $21.GetReconciliationOverviewRequest,
          $21.GetReconciliationOverviewResponse>(
      '/giftcards.GiftCardsService/GetReconciliationOverview',
      ($21.GetReconciliationOverviewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetReconciliationOverviewResponse.fromBuffer(value));
  static final _$getOrphanedTransactions = $grpc.ClientMethod<
          $21.GetOrphanedTransactionsRequest,
          $21.GetOrphanedTransactionsResponse>(
      '/giftcards.GiftCardsService/GetOrphanedTransactions',
      ($21.GetOrphanedTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetOrphanedTransactionsResponse.fromBuffer(value));
  static final _$resolveOrphanedTransaction = $grpc.ClientMethod<
          $21.ResolveOrphanedTransactionRequest,
          $21.ResolveOrphanedTransactionResponse>(
      '/giftcards.GiftCardsService/ResolveOrphanedTransaction',
      ($21.ResolveOrphanedTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.ResolveOrphanedTransactionResponse.fromBuffer(value));
  static final _$getPendingVerifications = $grpc.ClientMethod<
          $21.GetPendingVerificationsRequest,
          $21.GetPendingVerificationsResponse>(
      '/giftcards.GiftCardsService/GetPendingVerifications',
      ($21.GetPendingVerificationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetPendingVerificationsResponse.fromBuffer(value));
  static final _$getEscalatedItems = $grpc.ClientMethod<
          $21.GetEscalatedItemsRequest, $21.GetEscalatedItemsResponse>(
      '/giftcards.GiftCardsService/GetEscalatedItems',
      ($21.GetEscalatedItemsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetEscalatedItemsResponse.fromBuffer(value));
  static final _$resolveEscalatedItem = $grpc.ClientMethod<
          $21.ResolveEscalatedItemRequest, $21.ResolveEscalatedItemResponse>(
      '/giftcards.GiftCardsService/ResolveEscalatedItem',
      ($21.ResolveEscalatedItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.ResolveEscalatedItemResponse.fromBuffer(value));
  static final _$getReconciliationHistory = $grpc.ClientMethod<
          $21.GetReconciliationHistoryRequest,
          $21.GetReconciliationHistoryResponse>(
      '/giftcards.GiftCardsService/GetReconciliationHistory',
      ($21.GetReconciliationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetReconciliationHistoryResponse.fromBuffer(value));
  static final _$lookupUser =
      $grpc.ClientMethod<$21.LookupUserRequest, $21.LookupUserResponse>(
          '/giftcards.GiftCardsService/LookupUser',
          ($21.LookupUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.LookupUserResponse.fromBuffer(value));
  static final _$getUserDetails =
      $grpc.ClientMethod<$21.GetUserDetailsRequest, $21.GetUserDetailsResponse>(
          '/giftcards.GiftCardsService/GetUserDetails',
          ($21.GetUserDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetUserDetailsResponse.fromBuffer(value));
  static final _$searchGiftCardTransaction = $grpc.ClientMethod<
          $21.SearchGiftCardTransactionRequest,
          $21.SearchGiftCardTransactionResponse>(
      '/giftcards.GiftCardsService/SearchGiftCardTransaction',
      ($21.SearchGiftCardTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.SearchGiftCardTransactionResponse.fromBuffer(value));
  static final _$bulkPerformManualOperation = $grpc.ClientMethod<
          $21.BulkPerformManualOperationRequest,
          $21.BulkPerformManualOperationResponse>(
      '/giftcards.GiftCardsService/BulkPerformManualOperation',
      ($21.BulkPerformManualOperationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.BulkPerformManualOperationResponse.fromBuffer(value));
  static final _$performManualOperation = $grpc.ClientMethod<
          $21.PerformManualOperationRequest,
          $21.PerformManualOperationResponse>(
      '/giftcards.GiftCardsService/PerformManualOperation',
      ($21.PerformManualOperationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.PerformManualOperationResponse.fromBuffer(value));
  static final _$getGiftCardAuditLog = $grpc.ClientMethod<
          $21.GetGiftCardAuditLogRequest, $21.GetGiftCardAuditLogResponse>(
      '/giftcards.GiftCardsService/GetGiftCardAuditLog',
      ($21.GetGiftCardAuditLogRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetGiftCardAuditLogResponse.fromBuffer(value));
  static final _$listSystemSettings = $grpc.ClientMethod<
          $21.ListSystemSettingsRequest, $21.ListSystemSettingsResponse>(
      '/giftcards.GiftCardsService/ListSystemSettings',
      ($21.ListSystemSettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.ListSystemSettingsResponse.fromBuffer(value));
  static final _$updateSystemSetting = $grpc.ClientMethod<
          $21.UpdateSystemSettingRequest, $21.UpdateSystemSettingResponse>(
      '/giftcards.GiftCardsService/UpdateSystemSetting',
      ($21.UpdateSystemSettingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.UpdateSystemSettingResponse.fromBuffer(value));

  GiftCardsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$21.BuyGiftCardResponse> buyGiftCard(
      $21.BuyGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetRedeemCodeResponse> getRedeemCode(
      $21.GetRedeemCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRedeemCode, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGiftCardsResponse> getGiftCards(
      $21.GetGiftCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCards, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGiftCardResponse> getGiftCard(
      $21.GetGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGiftCardBrandsResponse> getGiftCardBrands(
      $21.GetGiftCardBrandsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardBrands, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGiftCardHistoryResponse> getGiftCardHistory(
      $21.GetGiftCardHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardHistory, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetSellableCardsResponse> getSellableCards(
      $21.GetSellableCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellableCards, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetSellProviderResponse> getSellProvider(
      $21.GetSellProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellProvider, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdateFeatureFlagResponse> updateFeatureFlag(
      $21.UpdateFeatureFlagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFeatureFlag, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetPayoutMethodsResponse> getPayoutMethods(
      $21.GetPayoutMethodsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutMethods, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetSellRateResponse> getSellRate(
      $21.GetSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$21.UploadSellImageResponse> uploadSellImage(
      $21.UploadSellImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadSellImage, request, options: options);
  }

  $grpc.ResponseFuture<$21.ExtractCardDetailsResponse> extractCardDetails(
      $21.ExtractCardDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$extractCardDetails, request, options: options);
  }

  $grpc.ResponseFuture<$21.SellGiftCardResponse> sellGiftCard(
      $21.SellGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetSellStatusResponse> getSellStatus(
      $21.GetSellStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellStatus, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetMySalesResponse> getMySales(
      $21.GetMySalesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMySales, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminListPendingSalesResponse> adminListPendingSales(
      $21.AdminListPendingSalesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListPendingSales, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminListBuyTransactionsResponse>
      adminListBuyTransactions($21.AdminListBuyTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListBuyTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.AdminListSellSettlementsResponse>
      adminListSellSettlements($21.AdminListSellSettlementsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSellSettlements, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.AdminListRefundLedgerResponse> adminListRefundLedger(
      $21.AdminListRefundLedgerRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListRefundLedger, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminGetSaleDetailResponse> adminGetSaleDetail(
      $21.AdminGetSaleDetailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetSaleDetail, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminApproveSaleResponse> adminApproveSale(
      $21.AdminApproveSaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminApproveSale, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminProcessPayoutResponse> adminProcessPayout(
      $21.AdminProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminProcessPayout, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminRejectSaleResponse> adminRejectSale(
      $21.AdminRejectSaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRejectSale, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminRetryHoldReleaseResponse> adminRetryHoldRelease(
      $21.AdminRetryHoldReleaseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRetryHoldRelease, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminManualRefundPurchaseResponse>
      adminManualRefundPurchase($21.AdminManualRefundPurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminManualRefundPurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.AdminForceReconcilePurchaseResponse>
      adminForceReconcilePurchase(
          $21.AdminForceReconcilePurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminForceReconcilePurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.AdminSetSellPayoutOverrideResponse>
      adminSetSellPayoutOverride($21.AdminSetSellPayoutOverrideRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminSetSellPayoutOverride, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.AdminListSellRatesResponse> adminListSellRates(
      $21.AdminListSellRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListSellRates, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminCreateSellRateResponse> adminCreateSellRate(
      $21.AdminCreateSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminCreateSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminUpdateSellRateResponse> adminUpdateSellRate(
      $21.AdminUpdateSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpdateSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdminToggleSellRateResponse> adminToggleSellRate(
      $21.AdminToggleSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminToggleSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetSupportedCountriesResponse> getSupportedCountries(
      $21.GetSupportedCountriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCountries, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics(
      $21.GetGiftCardsAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardsAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetReconciliationOverviewResponse>
      getReconciliationOverview($21.GetReconciliationOverviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationOverview, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.GetOrphanedTransactionsResponse>
      getOrphanedTransactions($21.GetOrphanedTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrphanedTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.ResolveOrphanedTransactionResponse>
      resolveOrphanedTransaction($21.ResolveOrphanedTransactionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveOrphanedTransaction, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.GetPendingVerificationsResponse>
      getPendingVerifications($21.GetPendingVerificationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingVerifications, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.GetEscalatedItemsResponse> getEscalatedItems(
      $21.GetEscalatedItemsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEscalatedItems, request, options: options);
  }

  $grpc.ResponseFuture<$21.ResolveEscalatedItemResponse> resolveEscalatedItem(
      $21.ResolveEscalatedItemRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveEscalatedItem, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetReconciliationHistoryResponse>
      getReconciliationHistory($21.GetReconciliationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.LookupUserResponse> lookupUser(
      $21.LookupUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupUser, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetUserDetailsResponse> getUserDetails(
      $21.GetUserDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDetails, request, options: options);
  }

  $grpc.ResponseFuture<$21.SearchGiftCardTransactionResponse>
      searchGiftCardTransaction($21.SearchGiftCardTransactionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchGiftCardTransaction, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.BulkPerformManualOperationResponse>
      bulkPerformManualOperation($21.BulkPerformManualOperationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkPerformManualOperation, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.PerformManualOperationResponse>
      performManualOperation($21.PerformManualOperationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$performManualOperation, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.GetGiftCardAuditLogResponse> getGiftCardAuditLog(
      $21.GetGiftCardAuditLogRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardAuditLog, request, options: options);
  }

  $grpc.ResponseFuture<$21.ListSystemSettingsResponse> listSystemSettings(
      $21.ListSystemSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSystemSettings, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdateSystemSettingResponse> updateSystemSetting(
      $21.UpdateSystemSettingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSystemSetting, request, options: options);
  }
}

abstract class GiftCardsServiceBase extends $grpc.Service {
  $core.String get $name => 'giftcards.GiftCardsService';

  GiftCardsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$21.BuyGiftCardRequest, $21.BuyGiftCardResponse>(
            'BuyGiftCard',
            buyGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.BuyGiftCardRequest.fromBuffer(value),
            ($21.BuyGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetRedeemCodeRequest,
            $21.GetRedeemCodeResponse>(
        'GetRedeemCode',
        getRedeemCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetRedeemCodeRequest.fromBuffer(value),
        ($21.GetRedeemCodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.GetGiftCardsRequest, $21.GetGiftCardsResponse>(
            'GetGiftCards',
            getGiftCards_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.GetGiftCardsRequest.fromBuffer(value),
            ($21.GetGiftCardsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.GetGiftCardRequest, $21.GetGiftCardResponse>(
            'GetGiftCard',
            getGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.GetGiftCardRequest.fromBuffer(value),
            ($21.GetGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGiftCardBrandsRequest,
            $21.GetGiftCardBrandsResponse>(
        'GetGiftCardBrands',
        getGiftCardBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetGiftCardBrandsRequest.fromBuffer(value),
        ($21.GetGiftCardBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGiftCardHistoryRequest,
            $21.GetGiftCardHistoryResponse>(
        'GetGiftCardHistory',
        getGiftCardHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetGiftCardHistoryRequest.fromBuffer(value),
        ($21.GetGiftCardHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetSellableCardsRequest,
            $21.GetSellableCardsResponse>(
        'GetSellableCards',
        getSellableCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetSellableCardsRequest.fromBuffer(value),
        ($21.GetSellableCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetSellProviderRequest,
            $21.GetSellProviderResponse>(
        'GetSellProvider',
        getSellProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetSellProviderRequest.fromBuffer(value),
        ($21.GetSellProviderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdateFeatureFlagRequest,
            $21.UpdateFeatureFlagResponse>(
        'UpdateFeatureFlag',
        updateFeatureFlag_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.UpdateFeatureFlagRequest.fromBuffer(value),
        ($21.UpdateFeatureFlagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPayoutMethodsRequest,
            $21.GetPayoutMethodsResponse>(
        'GetPayoutMethods',
        getPayoutMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetPayoutMethodsRequest.fromBuffer(value),
        ($21.GetPayoutMethodsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.GetSellRateRequest, $21.GetSellRateResponse>(
            'GetSellRate',
            getSellRate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.GetSellRateRequest.fromBuffer(value),
            ($21.GetSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UploadSellImageRequest,
            $21.UploadSellImageResponse>(
        'UploadSellImage',
        uploadSellImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.UploadSellImageRequest.fromBuffer(value),
        ($21.UploadSellImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ExtractCardDetailsRequest,
            $21.ExtractCardDetailsResponse>(
        'ExtractCardDetails',
        extractCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.ExtractCardDetailsRequest.fromBuffer(value),
        ($21.ExtractCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.SellGiftCardRequest, $21.SellGiftCardResponse>(
            'SellGiftCard',
            sellGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.SellGiftCardRequest.fromBuffer(value),
            ($21.SellGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetSellStatusRequest,
            $21.GetSellStatusResponse>(
        'GetSellStatus',
        getSellStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetSellStatusRequest.fromBuffer(value),
        ($21.GetSellStatusResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.GetMySalesRequest, $21.GetMySalesResponse>(
            'GetMySales',
            getMySales_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.GetMySalesRequest.fromBuffer(value),
            ($21.GetMySalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminListPendingSalesRequest,
            $21.AdminListPendingSalesResponse>(
        'AdminListPendingSales',
        adminListPendingSales_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminListPendingSalesRequest.fromBuffer(value),
        ($21.AdminListPendingSalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminListBuyTransactionsRequest,
            $21.AdminListBuyTransactionsResponse>(
        'AdminListBuyTransactions',
        adminListBuyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminListBuyTransactionsRequest.fromBuffer(value),
        ($21.AdminListBuyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminListSellSettlementsRequest,
            $21.AdminListSellSettlementsResponse>(
        'AdminListSellSettlements',
        adminListSellSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminListSellSettlementsRequest.fromBuffer(value),
        ($21.AdminListSellSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminListRefundLedgerRequest,
            $21.AdminListRefundLedgerResponse>(
        'AdminListRefundLedger',
        adminListRefundLedger_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminListRefundLedgerRequest.fromBuffer(value),
        ($21.AdminListRefundLedgerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminGetSaleDetailRequest,
            $21.AdminGetSaleDetailResponse>(
        'AdminGetSaleDetail',
        adminGetSaleDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminGetSaleDetailRequest.fromBuffer(value),
        ($21.AdminGetSaleDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminApproveSaleRequest,
            $21.AdminApproveSaleResponse>(
        'AdminApproveSale',
        adminApproveSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminApproveSaleRequest.fromBuffer(value),
        ($21.AdminApproveSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminProcessPayoutRequest,
            $21.AdminProcessPayoutResponse>(
        'AdminProcessPayout',
        adminProcessPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminProcessPayoutRequest.fromBuffer(value),
        ($21.AdminProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminRejectSaleRequest,
            $21.AdminRejectSaleResponse>(
        'AdminRejectSale',
        adminRejectSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminRejectSaleRequest.fromBuffer(value),
        ($21.AdminRejectSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminRetryHoldReleaseRequest,
            $21.AdminRetryHoldReleaseResponse>(
        'AdminRetryHoldRelease',
        adminRetryHoldRelease_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminRetryHoldReleaseRequest.fromBuffer(value),
        ($21.AdminRetryHoldReleaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminManualRefundPurchaseRequest,
            $21.AdminManualRefundPurchaseResponse>(
        'AdminManualRefundPurchase',
        adminManualRefundPurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminManualRefundPurchaseRequest.fromBuffer(value),
        ($21.AdminManualRefundPurchaseResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminForceReconcilePurchaseRequest,
            $21.AdminForceReconcilePurchaseResponse>(
        'AdminForceReconcilePurchase',
        adminForceReconcilePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminForceReconcilePurchaseRequest.fromBuffer(value),
        ($21.AdminForceReconcilePurchaseResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminSetSellPayoutOverrideRequest,
            $21.AdminSetSellPayoutOverrideResponse>(
        'AdminSetSellPayoutOverride',
        adminSetSellPayoutOverride_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminSetSellPayoutOverrideRequest.fromBuffer(value),
        ($21.AdminSetSellPayoutOverrideResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminListSellRatesRequest,
            $21.AdminListSellRatesResponse>(
        'AdminListSellRates',
        adminListSellRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminListSellRatesRequest.fromBuffer(value),
        ($21.AdminListSellRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminCreateSellRateRequest,
            $21.AdminCreateSellRateResponse>(
        'AdminCreateSellRate',
        adminCreateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminCreateSellRateRequest.fromBuffer(value),
        ($21.AdminCreateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminUpdateSellRateRequest,
            $21.AdminUpdateSellRateResponse>(
        'AdminUpdateSellRate',
        adminUpdateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminUpdateSellRateRequest.fromBuffer(value),
        ($21.AdminUpdateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdminToggleSellRateRequest,
            $21.AdminToggleSellRateResponse>(
        'AdminToggleSellRate',
        adminToggleSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AdminToggleSellRateRequest.fromBuffer(value),
        ($21.AdminToggleSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetSupportedCountriesRequest,
            $21.GetSupportedCountriesResponse>(
        'GetSupportedCountries',
        getSupportedCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetSupportedCountriesRequest.fromBuffer(value),
        ($21.GetSupportedCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGiftCardsAnalyticsRequest,
            $21.GetGiftCardsAnalyticsResponse>(
        'GetGiftCardsAnalytics',
        getGiftCardsAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetGiftCardsAnalyticsRequest.fromBuffer(value),
        ($21.GetGiftCardsAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetReconciliationOverviewRequest,
            $21.GetReconciliationOverviewResponse>(
        'GetReconciliationOverview',
        getReconciliationOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetReconciliationOverviewRequest.fromBuffer(value),
        ($21.GetReconciliationOverviewResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetOrphanedTransactionsRequest,
            $21.GetOrphanedTransactionsResponse>(
        'GetOrphanedTransactions',
        getOrphanedTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetOrphanedTransactionsRequest.fromBuffer(value),
        ($21.GetOrphanedTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ResolveOrphanedTransactionRequest,
            $21.ResolveOrphanedTransactionResponse>(
        'ResolveOrphanedTransaction',
        resolveOrphanedTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.ResolveOrphanedTransactionRequest.fromBuffer(value),
        ($21.ResolveOrphanedTransactionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPendingVerificationsRequest,
            $21.GetPendingVerificationsResponse>(
        'GetPendingVerifications',
        getPendingVerifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetPendingVerificationsRequest.fromBuffer(value),
        ($21.GetPendingVerificationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetEscalatedItemsRequest,
            $21.GetEscalatedItemsResponse>(
        'GetEscalatedItems',
        getEscalatedItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetEscalatedItemsRequest.fromBuffer(value),
        ($21.GetEscalatedItemsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ResolveEscalatedItemRequest,
            $21.ResolveEscalatedItemResponse>(
        'ResolveEscalatedItem',
        resolveEscalatedItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.ResolveEscalatedItemRequest.fromBuffer(value),
        ($21.ResolveEscalatedItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetReconciliationHistoryRequest,
            $21.GetReconciliationHistoryResponse>(
        'GetReconciliationHistory',
        getReconciliationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetReconciliationHistoryRequest.fromBuffer(value),
        ($21.GetReconciliationHistoryResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.LookupUserRequest, $21.LookupUserResponse>(
            'LookupUser',
            lookupUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.LookupUserRequest.fromBuffer(value),
            ($21.LookupUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetUserDetailsRequest,
            $21.GetUserDetailsResponse>(
        'GetUserDetails',
        getUserDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetUserDetailsRequest.fromBuffer(value),
        ($21.GetUserDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.SearchGiftCardTransactionRequest,
            $21.SearchGiftCardTransactionResponse>(
        'SearchGiftCardTransaction',
        searchGiftCardTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.SearchGiftCardTransactionRequest.fromBuffer(value),
        ($21.SearchGiftCardTransactionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.BulkPerformManualOperationRequest,
            $21.BulkPerformManualOperationResponse>(
        'BulkPerformManualOperation',
        bulkPerformManualOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.BulkPerformManualOperationRequest.fromBuffer(value),
        ($21.BulkPerformManualOperationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.PerformManualOperationRequest,
            $21.PerformManualOperationResponse>(
        'PerformManualOperation',
        performManualOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.PerformManualOperationRequest.fromBuffer(value),
        ($21.PerformManualOperationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGiftCardAuditLogRequest,
            $21.GetGiftCardAuditLogResponse>(
        'GetGiftCardAuditLog',
        getGiftCardAuditLog_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetGiftCardAuditLogRequest.fromBuffer(value),
        ($21.GetGiftCardAuditLogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ListSystemSettingsRequest,
            $21.ListSystemSettingsResponse>(
        'ListSystemSettings',
        listSystemSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.ListSystemSettingsRequest.fromBuffer(value),
        ($21.ListSystemSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdateSystemSettingRequest,
            $21.UpdateSystemSettingResponse>(
        'UpdateSystemSetting',
        updateSystemSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.UpdateSystemSettingRequest.fromBuffer(value),
        ($21.UpdateSystemSettingResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.BuyGiftCardResponse> buyGiftCard_Pre($grpc.ServiceCall call,
      $async.Future<$21.BuyGiftCardRequest> request) async {
    return buyGiftCard(call, await request);
  }

  $async.Future<$21.GetRedeemCodeResponse> getRedeemCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetRedeemCodeRequest> request) async {
    return getRedeemCode(call, await request);
  }

  $async.Future<$21.GetGiftCardsResponse> getGiftCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetGiftCardsRequest> request) async {
    return getGiftCards(call, await request);
  }

  $async.Future<$21.GetGiftCardResponse> getGiftCard_Pre($grpc.ServiceCall call,
      $async.Future<$21.GetGiftCardRequest> request) async {
    return getGiftCard(call, await request);
  }

  $async.Future<$21.GetGiftCardBrandsResponse> getGiftCardBrands_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetGiftCardBrandsRequest> request) async {
    return getGiftCardBrands(call, await request);
  }

  $async.Future<$21.GetGiftCardHistoryResponse> getGiftCardHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetGiftCardHistoryRequest> request) async {
    return getGiftCardHistory(call, await request);
  }

  $async.Future<$21.GetSellableCardsResponse> getSellableCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetSellableCardsRequest> request) async {
    return getSellableCards(call, await request);
  }

  $async.Future<$21.GetSellProviderResponse> getSellProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetSellProviderRequest> request) async {
    return getSellProvider(call, await request);
  }

  $async.Future<$21.UpdateFeatureFlagResponse> updateFeatureFlag_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.UpdateFeatureFlagRequest> request) async {
    return updateFeatureFlag(call, await request);
  }

  $async.Future<$21.GetPayoutMethodsResponse> getPayoutMethods_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetPayoutMethodsRequest> request) async {
    return getPayoutMethods(call, await request);
  }

  $async.Future<$21.GetSellRateResponse> getSellRate_Pre($grpc.ServiceCall call,
      $async.Future<$21.GetSellRateRequest> request) async {
    return getSellRate(call, await request);
  }

  $async.Future<$21.UploadSellImageResponse> uploadSellImage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.UploadSellImageRequest> request) async {
    return uploadSellImage(call, await request);
  }

  $async.Future<$21.ExtractCardDetailsResponse> extractCardDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.ExtractCardDetailsRequest> request) async {
    return extractCardDetails(call, await request);
  }

  $async.Future<$21.SellGiftCardResponse> sellGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.SellGiftCardRequest> request) async {
    return sellGiftCard(call, await request);
  }

  $async.Future<$21.GetSellStatusResponse> getSellStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetSellStatusRequest> request) async {
    return getSellStatus(call, await request);
  }

  $async.Future<$21.GetMySalesResponse> getMySales_Pre($grpc.ServiceCall call,
      $async.Future<$21.GetMySalesRequest> request) async {
    return getMySales(call, await request);
  }

  $async.Future<$21.AdminListPendingSalesResponse> adminListPendingSales_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminListPendingSalesRequest> request) async {
    return adminListPendingSales(call, await request);
  }

  $async.Future<$21.AdminListBuyTransactionsResponse>
      adminListBuyTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$21.AdminListBuyTransactionsRequest> request) async {
    return adminListBuyTransactions(call, await request);
  }

  $async.Future<$21.AdminListSellSettlementsResponse>
      adminListSellSettlements_Pre($grpc.ServiceCall call,
          $async.Future<$21.AdminListSellSettlementsRequest> request) async {
    return adminListSellSettlements(call, await request);
  }

  $async.Future<$21.AdminListRefundLedgerResponse> adminListRefundLedger_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminListRefundLedgerRequest> request) async {
    return adminListRefundLedger(call, await request);
  }

  $async.Future<$21.AdminGetSaleDetailResponse> adminGetSaleDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminGetSaleDetailRequest> request) async {
    return adminGetSaleDetail(call, await request);
  }

  $async.Future<$21.AdminApproveSaleResponse> adminApproveSale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminApproveSaleRequest> request) async {
    return adminApproveSale(call, await request);
  }

  $async.Future<$21.AdminProcessPayoutResponse> adminProcessPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminProcessPayoutRequest> request) async {
    return adminProcessPayout(call, await request);
  }

  $async.Future<$21.AdminRejectSaleResponse> adminRejectSale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminRejectSaleRequest> request) async {
    return adminRejectSale(call, await request);
  }

  $async.Future<$21.AdminRetryHoldReleaseResponse> adminRetryHoldRelease_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminRetryHoldReleaseRequest> request) async {
    return adminRetryHoldRelease(call, await request);
  }

  $async.Future<$21.AdminManualRefundPurchaseResponse>
      adminManualRefundPurchase_Pre($grpc.ServiceCall call,
          $async.Future<$21.AdminManualRefundPurchaseRequest> request) async {
    return adminManualRefundPurchase(call, await request);
  }

  $async.Future<$21.AdminForceReconcilePurchaseResponse>
      adminForceReconcilePurchase_Pre($grpc.ServiceCall call,
          $async.Future<$21.AdminForceReconcilePurchaseRequest> request) async {
    return adminForceReconcilePurchase(call, await request);
  }

  $async.Future<$21.AdminSetSellPayoutOverrideResponse>
      adminSetSellPayoutOverride_Pre($grpc.ServiceCall call,
          $async.Future<$21.AdminSetSellPayoutOverrideRequest> request) async {
    return adminSetSellPayoutOverride(call, await request);
  }

  $async.Future<$21.AdminListSellRatesResponse> adminListSellRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminListSellRatesRequest> request) async {
    return adminListSellRates(call, await request);
  }

  $async.Future<$21.AdminCreateSellRateResponse> adminCreateSellRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminCreateSellRateRequest> request) async {
    return adminCreateSellRate(call, await request);
  }

  $async.Future<$21.AdminUpdateSellRateResponse> adminUpdateSellRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminUpdateSellRateRequest> request) async {
    return adminUpdateSellRate(call, await request);
  }

  $async.Future<$21.AdminToggleSellRateResponse> adminToggleSellRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AdminToggleSellRateRequest> request) async {
    return adminToggleSellRate(call, await request);
  }

  $async.Future<$21.GetSupportedCountriesResponse> getSupportedCountries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetSupportedCountriesRequest> request) async {
    return getSupportedCountries(call, await request);
  }

  $async.Future<$21.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetGiftCardsAnalyticsRequest> request) async {
    return getGiftCardsAnalytics(call, await request);
  }

  $async.Future<$21.GetReconciliationOverviewResponse>
      getReconciliationOverview_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetReconciliationOverviewRequest> request) async {
    return getReconciliationOverview(call, await request);
  }

  $async.Future<$21.GetOrphanedTransactionsResponse>
      getOrphanedTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetOrphanedTransactionsRequest> request) async {
    return getOrphanedTransactions(call, await request);
  }

  $async.Future<$21.ResolveOrphanedTransactionResponse>
      resolveOrphanedTransaction_Pre($grpc.ServiceCall call,
          $async.Future<$21.ResolveOrphanedTransactionRequest> request) async {
    return resolveOrphanedTransaction(call, await request);
  }

  $async.Future<$21.GetPendingVerificationsResponse>
      getPendingVerifications_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetPendingVerificationsRequest> request) async {
    return getPendingVerifications(call, await request);
  }

  $async.Future<$21.GetEscalatedItemsResponse> getEscalatedItems_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetEscalatedItemsRequest> request) async {
    return getEscalatedItems(call, await request);
  }

  $async.Future<$21.ResolveEscalatedItemResponse> resolveEscalatedItem_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.ResolveEscalatedItemRequest> request) async {
    return resolveEscalatedItem(call, await request);
  }

  $async.Future<$21.GetReconciliationHistoryResponse>
      getReconciliationHistory_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetReconciliationHistoryRequest> request) async {
    return getReconciliationHistory(call, await request);
  }

  $async.Future<$21.LookupUserResponse> lookupUser_Pre($grpc.ServiceCall call,
      $async.Future<$21.LookupUserRequest> request) async {
    return lookupUser(call, await request);
  }

  $async.Future<$21.GetUserDetailsResponse> getUserDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetUserDetailsRequest> request) async {
    return getUserDetails(call, await request);
  }

  $async.Future<$21.SearchGiftCardTransactionResponse>
      searchGiftCardTransaction_Pre($grpc.ServiceCall call,
          $async.Future<$21.SearchGiftCardTransactionRequest> request) async {
    return searchGiftCardTransaction(call, await request);
  }

  $async.Future<$21.BulkPerformManualOperationResponse>
      bulkPerformManualOperation_Pre($grpc.ServiceCall call,
          $async.Future<$21.BulkPerformManualOperationRequest> request) async {
    return bulkPerformManualOperation(call, await request);
  }

  $async.Future<$21.PerformManualOperationResponse> performManualOperation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.PerformManualOperationRequest> request) async {
    return performManualOperation(call, await request);
  }

  $async.Future<$21.GetGiftCardAuditLogResponse> getGiftCardAuditLog_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetGiftCardAuditLogRequest> request) async {
    return getGiftCardAuditLog(call, await request);
  }

  $async.Future<$21.ListSystemSettingsResponse> listSystemSettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.ListSystemSettingsRequest> request) async {
    return listSystemSettings(call, await request);
  }

  $async.Future<$21.UpdateSystemSettingResponse> updateSystemSetting_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.UpdateSystemSettingRequest> request) async {
    return updateSystemSetting(call, await request);
  }

  $async.Future<$21.BuyGiftCardResponse> buyGiftCard(
      $grpc.ServiceCall call, $21.BuyGiftCardRequest request);
  $async.Future<$21.GetRedeemCodeResponse> getRedeemCode(
      $grpc.ServiceCall call, $21.GetRedeemCodeRequest request);
  $async.Future<$21.GetGiftCardsResponse> getGiftCards(
      $grpc.ServiceCall call, $21.GetGiftCardsRequest request);
  $async.Future<$21.GetGiftCardResponse> getGiftCard(
      $grpc.ServiceCall call, $21.GetGiftCardRequest request);
  $async.Future<$21.GetGiftCardBrandsResponse> getGiftCardBrands(
      $grpc.ServiceCall call, $21.GetGiftCardBrandsRequest request);
  $async.Future<$21.GetGiftCardHistoryResponse> getGiftCardHistory(
      $grpc.ServiceCall call, $21.GetGiftCardHistoryRequest request);
  $async.Future<$21.GetSellableCardsResponse> getSellableCards(
      $grpc.ServiceCall call, $21.GetSellableCardsRequest request);
  $async.Future<$21.GetSellProviderResponse> getSellProvider(
      $grpc.ServiceCall call, $21.GetSellProviderRequest request);
  $async.Future<$21.UpdateFeatureFlagResponse> updateFeatureFlag(
      $grpc.ServiceCall call, $21.UpdateFeatureFlagRequest request);
  $async.Future<$21.GetPayoutMethodsResponse> getPayoutMethods(
      $grpc.ServiceCall call, $21.GetPayoutMethodsRequest request);
  $async.Future<$21.GetSellRateResponse> getSellRate(
      $grpc.ServiceCall call, $21.GetSellRateRequest request);
  $async.Future<$21.UploadSellImageResponse> uploadSellImage(
      $grpc.ServiceCall call, $21.UploadSellImageRequest request);
  $async.Future<$21.ExtractCardDetailsResponse> extractCardDetails(
      $grpc.ServiceCall call, $21.ExtractCardDetailsRequest request);
  $async.Future<$21.SellGiftCardResponse> sellGiftCard(
      $grpc.ServiceCall call, $21.SellGiftCardRequest request);
  $async.Future<$21.GetSellStatusResponse> getSellStatus(
      $grpc.ServiceCall call, $21.GetSellStatusRequest request);
  $async.Future<$21.GetMySalesResponse> getMySales(
      $grpc.ServiceCall call, $21.GetMySalesRequest request);
  $async.Future<$21.AdminListPendingSalesResponse> adminListPendingSales(
      $grpc.ServiceCall call, $21.AdminListPendingSalesRequest request);
  $async.Future<$21.AdminListBuyTransactionsResponse> adminListBuyTransactions(
      $grpc.ServiceCall call, $21.AdminListBuyTransactionsRequest request);
  $async.Future<$21.AdminListSellSettlementsResponse> adminListSellSettlements(
      $grpc.ServiceCall call, $21.AdminListSellSettlementsRequest request);
  $async.Future<$21.AdminListRefundLedgerResponse> adminListRefundLedger(
      $grpc.ServiceCall call, $21.AdminListRefundLedgerRequest request);
  $async.Future<$21.AdminGetSaleDetailResponse> adminGetSaleDetail(
      $grpc.ServiceCall call, $21.AdminGetSaleDetailRequest request);
  $async.Future<$21.AdminApproveSaleResponse> adminApproveSale(
      $grpc.ServiceCall call, $21.AdminApproveSaleRequest request);
  $async.Future<$21.AdminProcessPayoutResponse> adminProcessPayout(
      $grpc.ServiceCall call, $21.AdminProcessPayoutRequest request);
  $async.Future<$21.AdminRejectSaleResponse> adminRejectSale(
      $grpc.ServiceCall call, $21.AdminRejectSaleRequest request);
  $async.Future<$21.AdminRetryHoldReleaseResponse> adminRetryHoldRelease(
      $grpc.ServiceCall call, $21.AdminRetryHoldReleaseRequest request);
  $async.Future<$21.AdminManualRefundPurchaseResponse>
      adminManualRefundPurchase(
          $grpc.ServiceCall call, $21.AdminManualRefundPurchaseRequest request);
  $async.Future<$21.AdminForceReconcilePurchaseResponse>
      adminForceReconcilePurchase($grpc.ServiceCall call,
          $21.AdminForceReconcilePurchaseRequest request);
  $async.Future<$21.AdminSetSellPayoutOverrideResponse>
      adminSetSellPayoutOverride($grpc.ServiceCall call,
          $21.AdminSetSellPayoutOverrideRequest request);
  $async.Future<$21.AdminListSellRatesResponse> adminListSellRates(
      $grpc.ServiceCall call, $21.AdminListSellRatesRequest request);
  $async.Future<$21.AdminCreateSellRateResponse> adminCreateSellRate(
      $grpc.ServiceCall call, $21.AdminCreateSellRateRequest request);
  $async.Future<$21.AdminUpdateSellRateResponse> adminUpdateSellRate(
      $grpc.ServiceCall call, $21.AdminUpdateSellRateRequest request);
  $async.Future<$21.AdminToggleSellRateResponse> adminToggleSellRate(
      $grpc.ServiceCall call, $21.AdminToggleSellRateRequest request);
  $async.Future<$21.GetSupportedCountriesResponse> getSupportedCountries(
      $grpc.ServiceCall call, $21.GetSupportedCountriesRequest request);
  $async.Future<$21.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics(
      $grpc.ServiceCall call, $21.GetGiftCardsAnalyticsRequest request);
  $async.Future<$21.GetReconciliationOverviewResponse>
      getReconciliationOverview(
          $grpc.ServiceCall call, $21.GetReconciliationOverviewRequest request);
  $async.Future<$21.GetOrphanedTransactionsResponse> getOrphanedTransactions(
      $grpc.ServiceCall call, $21.GetOrphanedTransactionsRequest request);
  $async.Future<$21.ResolveOrphanedTransactionResponse>
      resolveOrphanedTransaction($grpc.ServiceCall call,
          $21.ResolveOrphanedTransactionRequest request);
  $async.Future<$21.GetPendingVerificationsResponse> getPendingVerifications(
      $grpc.ServiceCall call, $21.GetPendingVerificationsRequest request);
  $async.Future<$21.GetEscalatedItemsResponse> getEscalatedItems(
      $grpc.ServiceCall call, $21.GetEscalatedItemsRequest request);
  $async.Future<$21.ResolveEscalatedItemResponse> resolveEscalatedItem(
      $grpc.ServiceCall call, $21.ResolveEscalatedItemRequest request);
  $async.Future<$21.GetReconciliationHistoryResponse> getReconciliationHistory(
      $grpc.ServiceCall call, $21.GetReconciliationHistoryRequest request);
  $async.Future<$21.LookupUserResponse> lookupUser(
      $grpc.ServiceCall call, $21.LookupUserRequest request);
  $async.Future<$21.GetUserDetailsResponse> getUserDetails(
      $grpc.ServiceCall call, $21.GetUserDetailsRequest request);
  $async.Future<$21.SearchGiftCardTransactionResponse>
      searchGiftCardTransaction(
          $grpc.ServiceCall call, $21.SearchGiftCardTransactionRequest request);
  $async.Future<$21.BulkPerformManualOperationResponse>
      bulkPerformManualOperation($grpc.ServiceCall call,
          $21.BulkPerformManualOperationRequest request);
  $async.Future<$21.PerformManualOperationResponse> performManualOperation(
      $grpc.ServiceCall call, $21.PerformManualOperationRequest request);
  $async.Future<$21.GetGiftCardAuditLogResponse> getGiftCardAuditLog(
      $grpc.ServiceCall call, $21.GetGiftCardAuditLogRequest request);
  $async.Future<$21.ListSystemSettingsResponse> listSystemSettings(
      $grpc.ServiceCall call, $21.ListSystemSettingsRequest request);
  $async.Future<$21.UpdateSystemSettingResponse> updateSystemSetting(
      $grpc.ServiceCall call, $21.UpdateSystemSettingRequest request);
}
