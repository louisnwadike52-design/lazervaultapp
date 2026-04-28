// This is a generated file - do not edit.
//
// Generated from giftcards.proto.

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

import 'giftcards.pb.dart' as $0;

export 'giftcards.pb.dart';

/// Gift Cards Service - Buy, redeem, and manage gift cards via Reloadly
@$pb.GrpcServiceName('giftcards.GiftCardsService')
class GiftCardsServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GiftCardsServiceClient(super.channel, {super.options, super.interceptors});

  /// Buy a gift card (giftCards from AppServiceName)
  $grpc.ResponseFuture<$0.BuyGiftCardResponse> buyGiftCard($0.BuyGiftCardRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$buyGiftCard, request, options: options);
  }

  /// Get the merchant redeem code for a purchased gift card (fetches from Reloadly)
  $grpc.ResponseFuture<$0.GetRedeemCodeResponse> getRedeemCode($0.GetRedeemCodeRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getRedeemCode, request, options: options);
  }

  /// Get user's gift cards
  $grpc.ResponseFuture<$0.GetGiftCardsResponse> getGiftCards($0.GetGiftCardsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getGiftCards, request, options: options);
  }

  /// Get specific gift card details
  $grpc.ResponseFuture<$0.GetGiftCardResponse> getGiftCard($0.GetGiftCardRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getGiftCard, request, options: options);
  }

  /// Transfer gift card to another user
  $grpc.ResponseFuture<$0.TransferGiftCardResponse> transferGiftCard($0.TransferGiftCardRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$transferGiftCard, request, options: options);
  }

  /// Get available gift card brands/merchants
  $grpc.ResponseFuture<$0.GetGiftCardBrandsResponse> getGiftCardBrands($0.GetGiftCardBrandsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getGiftCardBrands, request, options: options);
  }

  /// Get gift card transaction history
  $grpc.ResponseFuture<$0.GetGiftCardHistoryResponse> getGiftCardHistory($0.GetGiftCardHistoryRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getGiftCardHistory, request, options: options);
  }

  /// Get card types available for selling
  $grpc.ResponseFuture<$0.GetSellableCardsResponse> getSellableCards($0.GetSellableCardsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getSellableCards, request, options: options);
  }

  /// Get active gift card sell provider (manual or prestmit)
  $grpc.ResponseFuture<$0.GetSellProviderResponse> getSellProvider($0.GetSellProviderRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getSellProvider, request, options: options);
  }

  /// Update gift card feature flag (admin only)
  $grpc.ResponseFuture<$0.UpdateFeatureFlagResponse> updateFeatureFlag($0.UpdateFeatureFlagRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$updateFeatureFlag, request, options: options);
  }

  /// Get current sell rate for a card type + denomination
  /// GetPayoutMethods returns Prestmit's available payout methods,
  /// pre-filtered to available==true. Sourced from
  /// /giftcard-trade/sell/rate-calculator-data per the docs (the only
  /// payout-methods JSON shape Prestmit publishes verbatim).
  $grpc.ResponseFuture<$0.GetPayoutMethodsResponse> getPayoutMethods($0.GetPayoutMethodsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getPayoutMethods, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSellRateResponse> getSellRate($0.GetSellRateRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getSellRate, request, options: options);
  }

  /// Upload a gift card image for selling
  $grpc.ResponseFuture<$0.UploadSellImageResponse> uploadSellImage($0.UploadSellImageRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$uploadSellImage, request, options: options);
  }

  /// Extract gift card details from uploaded images using LLM OCR
  $grpc.ResponseFuture<$0.ExtractCardDetailsResponse> extractCardDetails($0.ExtractCardDetailsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$extractCardDetails, request, options: options);
  }

  /// Submit a gift card for sale (goes to pending_review for admin approval)
  $grpc.ResponseFuture<$0.SellGiftCardResponse> sellGiftCard($0.SellGiftCardRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  /// Get status of a sell transaction
  $grpc.ResponseFuture<$0.GetSellStatusResponse> getSellStatus($0.GetSellStatusRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getSellStatus, request, options: options);
  }

  /// Get user's sell transactions
  $grpc.ResponseFuture<$0.GetMySalesResponse> getMySales($0.GetMySalesRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getMySales, request, options: options);
  }

  /// List sell requests pending admin review
  $grpc.ResponseFuture<$0.AdminListPendingSalesResponse> adminListPendingSales($0.AdminListPendingSalesRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminListPendingSales, request, options: options);
  }

  /// List buy-side gift-card purchases (the giftcards table) for the
  /// admin Transactions tab. Filterable by status; results paginated.
  /// Sell-side transactions are listed via AdminListPendingSales(status="all").
  $grpc.ResponseFuture<$0.AdminListBuyTransactionsResponse> adminListBuyTransactions($0.AdminListBuyTransactionsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminListBuyTransactions, request, options: options);
  }

  /// Get full sell request details for admin review (includes images)
  $grpc.ResponseFuture<$0.AdminGetSaleDetailResponse> adminGetSaleDetail($0.AdminGetSaleDetailRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminGetSaleDetail, request, options: options);
  }

  /// Approve a sell request (marks as approved, payout is separate)
  $grpc.ResponseFuture<$0.AdminApproveSaleResponse> adminApproveSale($0.AdminApproveSaleRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminApproveSale, request, options: options);
  }

  /// Process payout for an approved sale (credits user account)
  $grpc.ResponseFuture<$0.AdminProcessPayoutResponse> adminProcessPayout($0.AdminProcessPayoutRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminProcessPayout, request, options: options);
  }

  /// Reject a sell request with reason
  $grpc.ResponseFuture<$0.AdminRejectSaleResponse> adminRejectSale($0.AdminRejectSaleRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminRejectSale, request, options: options);
  }

  /// List all sell rate configurations
  $grpc.ResponseFuture<$0.AdminListSellRatesResponse> adminListSellRates($0.AdminListSellRatesRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminListSellRates, request, options: options);
  }

  /// Create a new sell rate configuration
  $grpc.ResponseFuture<$0.AdminCreateSellRateResponse> adminCreateSellRate($0.AdminCreateSellRateRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminCreateSellRate, request, options: options);
  }

  /// Update an existing sell rate configuration
  $grpc.ResponseFuture<$0.AdminUpdateSellRateResponse> adminUpdateSellRate($0.AdminUpdateSellRateRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminUpdateSellRate, request, options: options);
  }

  /// Toggle active/inactive status for a sell rate
  $grpc.ResponseFuture<$0.AdminToggleSellRateResponse> adminToggleSellRate($0.AdminToggleSellRateRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$adminToggleSellRate, request, options: options);
  }

  /// Get supported countries for gift cards (from Reloadly)
  $grpc.ResponseFuture<$0.GetSupportedCountriesResponse> getSupportedCountries($0.GetSupportedCountriesRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getSupportedCountries, request, options: options);
  }

  /// Get gift cards analytics dashboard data
  $grpc.ResponseFuture<$0.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics($0.GetGiftCardsAnalyticsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getGiftCardsAnalytics, request, options: options);
  }

  /// Get reconciliation overview
  $grpc.ResponseFuture<$0.GetReconciliationOverviewResponse> getReconciliationOverview($0.GetReconciliationOverviewRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getReconciliationOverview, request, options: options);
  }

  /// Get orphaned transactions
  $grpc.ResponseFuture<$0.GetOrphanedTransactionsResponse> getOrphanedTransactions($0.GetOrphanedTransactionsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getOrphanedTransactions, request, options: options);
  }

  /// Resolve orphaned transaction
  $grpc.ResponseFuture<$0.ResolveOrphanedTransactionResponse> resolveOrphanedTransaction($0.ResolveOrphanedTransactionRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$resolveOrphanedTransaction, request, options: options);
  }

  /// Get pending verifications
  $grpc.ResponseFuture<$0.GetPendingVerificationsResponse> getPendingVerifications($0.GetPendingVerificationsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getPendingVerifications, request, options: options);
  }

  /// Get escalated items
  $grpc.ResponseFuture<$0.GetEscalatedItemsResponse> getEscalatedItems($0.GetEscalatedItemsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getEscalatedItems, request, options: options);
  }

  /// Resolve escalated item
  $grpc.ResponseFuture<$0.ResolveEscalatedItemResponse> resolveEscalatedItem($0.ResolveEscalatedItemRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$resolveEscalatedItem, request, options: options);
  }

  /// Get reconciliation history
  $grpc.ResponseFuture<$0.GetReconciliationHistoryResponse> getReconciliationHistory($0.GetReconciliationHistoryRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getReconciliationHistory, request, options: options);
  }

  /// Lookup user by email, userId, or phoneNumber
  $grpc.ResponseFuture<$0.LookupUserResponse> lookupUser($0.LookupUserRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$lookupUser, request, options: options);
  }

  /// Get user details for support
  $grpc.ResponseFuture<$0.GetUserDetailsResponse> getUserDetails($0.GetUserDetailsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUserDetails, request, options: options);
  }

  /// Search gift card transaction by reference
  $grpc.ResponseFuture<$0.SearchGiftCardTransactionResponse> searchGiftCardTransaction($0.SearchGiftCardTransactionRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$searchGiftCardTransaction, request, options: options);
  }

  /// Perform manual operation (retry, reverse, cancel, etc.)
  $grpc.ResponseFuture<$0.PerformManualOperationResponse> performManualOperation($0.PerformManualOperationRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$performManualOperation, request, options: options);
  }

  /// Get gift card audit log
  $grpc.ResponseFuture<$0.GetGiftCardAuditLogResponse> getGiftCardAuditLog($0.GetGiftCardAuditLogRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getGiftCardAuditLog, request, options: options);
  }

  /// List system settings (sync/async toggles, cache TTL, reconciler intervals).
  /// Reads from the system_settings table. Filter by category to scope to
  /// giftcards-only rows.
  $grpc.ResponseFuture<$0.ListSystemSettingsResponse> listSystemSettings($0.ListSystemSettingsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$listSystemSettings, request, options: options);
  }

  /// Update a single system setting. Invalidates the in-memory cache so the
  /// change takes effect within ~10s (next miss in the SettingsService TTL).
  $grpc.ResponseFuture<$0.UpdateSystemSettingResponse> updateSystemSetting($0.UpdateSystemSettingRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$updateSystemSetting, request, options: options);
  }

    // method descriptors

  static final _$buyGiftCard = $grpc.ClientMethod<$0.BuyGiftCardRequest, $0.BuyGiftCardResponse>(
      '/giftcards.GiftCardsService/BuyGiftCard',
      ($0.BuyGiftCardRequest value) => value.writeToBuffer(),
      $0.BuyGiftCardResponse.fromBuffer);
  static final _$getRedeemCode = $grpc.ClientMethod<$0.GetRedeemCodeRequest, $0.GetRedeemCodeResponse>(
      '/giftcards.GiftCardsService/GetRedeemCode',
      ($0.GetRedeemCodeRequest value) => value.writeToBuffer(),
      $0.GetRedeemCodeResponse.fromBuffer);
  static final _$getGiftCards = $grpc.ClientMethod<$0.GetGiftCardsRequest, $0.GetGiftCardsResponse>(
      '/giftcards.GiftCardsService/GetGiftCards',
      ($0.GetGiftCardsRequest value) => value.writeToBuffer(),
      $0.GetGiftCardsResponse.fromBuffer);
  static final _$getGiftCard = $grpc.ClientMethod<$0.GetGiftCardRequest, $0.GetGiftCardResponse>(
      '/giftcards.GiftCardsService/GetGiftCard',
      ($0.GetGiftCardRequest value) => value.writeToBuffer(),
      $0.GetGiftCardResponse.fromBuffer);
  static final _$transferGiftCard = $grpc.ClientMethod<$0.TransferGiftCardRequest, $0.TransferGiftCardResponse>(
      '/giftcards.GiftCardsService/TransferGiftCard',
      ($0.TransferGiftCardRequest value) => value.writeToBuffer(),
      $0.TransferGiftCardResponse.fromBuffer);
  static final _$getGiftCardBrands = $grpc.ClientMethod<$0.GetGiftCardBrandsRequest, $0.GetGiftCardBrandsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardBrands',
      ($0.GetGiftCardBrandsRequest value) => value.writeToBuffer(),
      $0.GetGiftCardBrandsResponse.fromBuffer);
  static final _$getGiftCardHistory = $grpc.ClientMethod<$0.GetGiftCardHistoryRequest, $0.GetGiftCardHistoryResponse>(
      '/giftcards.GiftCardsService/GetGiftCardHistory',
      ($0.GetGiftCardHistoryRequest value) => value.writeToBuffer(),
      $0.GetGiftCardHistoryResponse.fromBuffer);
  static final _$getSellableCards = $grpc.ClientMethod<$0.GetSellableCardsRequest, $0.GetSellableCardsResponse>(
      '/giftcards.GiftCardsService/GetSellableCards',
      ($0.GetSellableCardsRequest value) => value.writeToBuffer(),
      $0.GetSellableCardsResponse.fromBuffer);
  static final _$getSellProvider = $grpc.ClientMethod<$0.GetSellProviderRequest, $0.GetSellProviderResponse>(
      '/giftcards.GiftCardsService/GetSellProvider',
      ($0.GetSellProviderRequest value) => value.writeToBuffer(),
      $0.GetSellProviderResponse.fromBuffer);
  static final _$updateFeatureFlag = $grpc.ClientMethod<$0.UpdateFeatureFlagRequest, $0.UpdateFeatureFlagResponse>(
      '/giftcards.GiftCardsService/UpdateFeatureFlag',
      ($0.UpdateFeatureFlagRequest value) => value.writeToBuffer(),
      $0.UpdateFeatureFlagResponse.fromBuffer);
  static final _$getPayoutMethods = $grpc.ClientMethod<$0.GetPayoutMethodsRequest, $0.GetPayoutMethodsResponse>(
      '/giftcards.GiftCardsService/GetPayoutMethods',
      ($0.GetPayoutMethodsRequest value) => value.writeToBuffer(),
      $0.GetPayoutMethodsResponse.fromBuffer);
  static final _$getSellRate = $grpc.ClientMethod<$0.GetSellRateRequest, $0.GetSellRateResponse>(
      '/giftcards.GiftCardsService/GetSellRate',
      ($0.GetSellRateRequest value) => value.writeToBuffer(),
      $0.GetSellRateResponse.fromBuffer);
  static final _$uploadSellImage = $grpc.ClientMethod<$0.UploadSellImageRequest, $0.UploadSellImageResponse>(
      '/giftcards.GiftCardsService/UploadSellImage',
      ($0.UploadSellImageRequest value) => value.writeToBuffer(),
      $0.UploadSellImageResponse.fromBuffer);
  static final _$extractCardDetails = $grpc.ClientMethod<$0.ExtractCardDetailsRequest, $0.ExtractCardDetailsResponse>(
      '/giftcards.GiftCardsService/ExtractCardDetails',
      ($0.ExtractCardDetailsRequest value) => value.writeToBuffer(),
      $0.ExtractCardDetailsResponse.fromBuffer);
  static final _$sellGiftCard = $grpc.ClientMethod<$0.SellGiftCardRequest, $0.SellGiftCardResponse>(
      '/giftcards.GiftCardsService/SellGiftCard',
      ($0.SellGiftCardRequest value) => value.writeToBuffer(),
      $0.SellGiftCardResponse.fromBuffer);
  static final _$getSellStatus = $grpc.ClientMethod<$0.GetSellStatusRequest, $0.GetSellStatusResponse>(
      '/giftcards.GiftCardsService/GetSellStatus',
      ($0.GetSellStatusRequest value) => value.writeToBuffer(),
      $0.GetSellStatusResponse.fromBuffer);
  static final _$getMySales = $grpc.ClientMethod<$0.GetMySalesRequest, $0.GetMySalesResponse>(
      '/giftcards.GiftCardsService/GetMySales',
      ($0.GetMySalesRequest value) => value.writeToBuffer(),
      $0.GetMySalesResponse.fromBuffer);
  static final _$adminListPendingSales = $grpc.ClientMethod<$0.AdminListPendingSalesRequest, $0.AdminListPendingSalesResponse>(
      '/giftcards.GiftCardsService/AdminListPendingSales',
      ($0.AdminListPendingSalesRequest value) => value.writeToBuffer(),
      $0.AdminListPendingSalesResponse.fromBuffer);
  static final _$adminListBuyTransactions = $grpc.ClientMethod<$0.AdminListBuyTransactionsRequest, $0.AdminListBuyTransactionsResponse>(
      '/giftcards.GiftCardsService/AdminListBuyTransactions',
      ($0.AdminListBuyTransactionsRequest value) => value.writeToBuffer(),
      $0.AdminListBuyTransactionsResponse.fromBuffer);
  static final _$adminGetSaleDetail = $grpc.ClientMethod<$0.AdminGetSaleDetailRequest, $0.AdminGetSaleDetailResponse>(
      '/giftcards.GiftCardsService/AdminGetSaleDetail',
      ($0.AdminGetSaleDetailRequest value) => value.writeToBuffer(),
      $0.AdminGetSaleDetailResponse.fromBuffer);
  static final _$adminApproveSale = $grpc.ClientMethod<$0.AdminApproveSaleRequest, $0.AdminApproveSaleResponse>(
      '/giftcards.GiftCardsService/AdminApproveSale',
      ($0.AdminApproveSaleRequest value) => value.writeToBuffer(),
      $0.AdminApproveSaleResponse.fromBuffer);
  static final _$adminProcessPayout = $grpc.ClientMethod<$0.AdminProcessPayoutRequest, $0.AdminProcessPayoutResponse>(
      '/giftcards.GiftCardsService/AdminProcessPayout',
      ($0.AdminProcessPayoutRequest value) => value.writeToBuffer(),
      $0.AdminProcessPayoutResponse.fromBuffer);
  static final _$adminRejectSale = $grpc.ClientMethod<$0.AdminRejectSaleRequest, $0.AdminRejectSaleResponse>(
      '/giftcards.GiftCardsService/AdminRejectSale',
      ($0.AdminRejectSaleRequest value) => value.writeToBuffer(),
      $0.AdminRejectSaleResponse.fromBuffer);
  static final _$adminListSellRates = $grpc.ClientMethod<$0.AdminListSellRatesRequest, $0.AdminListSellRatesResponse>(
      '/giftcards.GiftCardsService/AdminListSellRates',
      ($0.AdminListSellRatesRequest value) => value.writeToBuffer(),
      $0.AdminListSellRatesResponse.fromBuffer);
  static final _$adminCreateSellRate = $grpc.ClientMethod<$0.AdminCreateSellRateRequest, $0.AdminCreateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminCreateSellRate',
      ($0.AdminCreateSellRateRequest value) => value.writeToBuffer(),
      $0.AdminCreateSellRateResponse.fromBuffer);
  static final _$adminUpdateSellRate = $grpc.ClientMethod<$0.AdminUpdateSellRateRequest, $0.AdminUpdateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminUpdateSellRate',
      ($0.AdminUpdateSellRateRequest value) => value.writeToBuffer(),
      $0.AdminUpdateSellRateResponse.fromBuffer);
  static final _$adminToggleSellRate = $grpc.ClientMethod<$0.AdminToggleSellRateRequest, $0.AdminToggleSellRateResponse>(
      '/giftcards.GiftCardsService/AdminToggleSellRate',
      ($0.AdminToggleSellRateRequest value) => value.writeToBuffer(),
      $0.AdminToggleSellRateResponse.fromBuffer);
  static final _$getSupportedCountries = $grpc.ClientMethod<$0.GetSupportedCountriesRequest, $0.GetSupportedCountriesResponse>(
      '/giftcards.GiftCardsService/GetSupportedCountries',
      ($0.GetSupportedCountriesRequest value) => value.writeToBuffer(),
      $0.GetSupportedCountriesResponse.fromBuffer);
  static final _$getGiftCardsAnalytics = $grpc.ClientMethod<$0.GetGiftCardsAnalyticsRequest, $0.GetGiftCardsAnalyticsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardsAnalytics',
      ($0.GetGiftCardsAnalyticsRequest value) => value.writeToBuffer(),
      $0.GetGiftCardsAnalyticsResponse.fromBuffer);
  static final _$getReconciliationOverview = $grpc.ClientMethod<$0.GetReconciliationOverviewRequest, $0.GetReconciliationOverviewResponse>(
      '/giftcards.GiftCardsService/GetReconciliationOverview',
      ($0.GetReconciliationOverviewRequest value) => value.writeToBuffer(),
      $0.GetReconciliationOverviewResponse.fromBuffer);
  static final _$getOrphanedTransactions = $grpc.ClientMethod<$0.GetOrphanedTransactionsRequest, $0.GetOrphanedTransactionsResponse>(
      '/giftcards.GiftCardsService/GetOrphanedTransactions',
      ($0.GetOrphanedTransactionsRequest value) => value.writeToBuffer(),
      $0.GetOrphanedTransactionsResponse.fromBuffer);
  static final _$resolveOrphanedTransaction = $grpc.ClientMethod<$0.ResolveOrphanedTransactionRequest, $0.ResolveOrphanedTransactionResponse>(
      '/giftcards.GiftCardsService/ResolveOrphanedTransaction',
      ($0.ResolveOrphanedTransactionRequest value) => value.writeToBuffer(),
      $0.ResolveOrphanedTransactionResponse.fromBuffer);
  static final _$getPendingVerifications = $grpc.ClientMethod<$0.GetPendingVerificationsRequest, $0.GetPendingVerificationsResponse>(
      '/giftcards.GiftCardsService/GetPendingVerifications',
      ($0.GetPendingVerificationsRequest value) => value.writeToBuffer(),
      $0.GetPendingVerificationsResponse.fromBuffer);
  static final _$getEscalatedItems = $grpc.ClientMethod<$0.GetEscalatedItemsRequest, $0.GetEscalatedItemsResponse>(
      '/giftcards.GiftCardsService/GetEscalatedItems',
      ($0.GetEscalatedItemsRequest value) => value.writeToBuffer(),
      $0.GetEscalatedItemsResponse.fromBuffer);
  static final _$resolveEscalatedItem = $grpc.ClientMethod<$0.ResolveEscalatedItemRequest, $0.ResolveEscalatedItemResponse>(
      '/giftcards.GiftCardsService/ResolveEscalatedItem',
      ($0.ResolveEscalatedItemRequest value) => value.writeToBuffer(),
      $0.ResolveEscalatedItemResponse.fromBuffer);
  static final _$getReconciliationHistory = $grpc.ClientMethod<$0.GetReconciliationHistoryRequest, $0.GetReconciliationHistoryResponse>(
      '/giftcards.GiftCardsService/GetReconciliationHistory',
      ($0.GetReconciliationHistoryRequest value) => value.writeToBuffer(),
      $0.GetReconciliationHistoryResponse.fromBuffer);
  static final _$lookupUser = $grpc.ClientMethod<$0.LookupUserRequest, $0.LookupUserResponse>(
      '/giftcards.GiftCardsService/LookupUser',
      ($0.LookupUserRequest value) => value.writeToBuffer(),
      $0.LookupUserResponse.fromBuffer);
  static final _$getUserDetails = $grpc.ClientMethod<$0.GetUserDetailsRequest, $0.GetUserDetailsResponse>(
      '/giftcards.GiftCardsService/GetUserDetails',
      ($0.GetUserDetailsRequest value) => value.writeToBuffer(),
      $0.GetUserDetailsResponse.fromBuffer);
  static final _$searchGiftCardTransaction = $grpc.ClientMethod<$0.SearchGiftCardTransactionRequest, $0.SearchGiftCardTransactionResponse>(
      '/giftcards.GiftCardsService/SearchGiftCardTransaction',
      ($0.SearchGiftCardTransactionRequest value) => value.writeToBuffer(),
      $0.SearchGiftCardTransactionResponse.fromBuffer);
  static final _$performManualOperation = $grpc.ClientMethod<$0.PerformManualOperationRequest, $0.PerformManualOperationResponse>(
      '/giftcards.GiftCardsService/PerformManualOperation',
      ($0.PerformManualOperationRequest value) => value.writeToBuffer(),
      $0.PerformManualOperationResponse.fromBuffer);
  static final _$getGiftCardAuditLog = $grpc.ClientMethod<$0.GetGiftCardAuditLogRequest, $0.GetGiftCardAuditLogResponse>(
      '/giftcards.GiftCardsService/GetGiftCardAuditLog',
      ($0.GetGiftCardAuditLogRequest value) => value.writeToBuffer(),
      $0.GetGiftCardAuditLogResponse.fromBuffer);
  static final _$listSystemSettings = $grpc.ClientMethod<$0.ListSystemSettingsRequest, $0.ListSystemSettingsResponse>(
      '/giftcards.GiftCardsService/ListSystemSettings',
      ($0.ListSystemSettingsRequest value) => value.writeToBuffer(),
      $0.ListSystemSettingsResponse.fromBuffer);
  static final _$updateSystemSetting = $grpc.ClientMethod<$0.UpdateSystemSettingRequest, $0.UpdateSystemSettingResponse>(
      '/giftcards.GiftCardsService/UpdateSystemSetting',
      ($0.UpdateSystemSettingRequest value) => value.writeToBuffer(),
      $0.UpdateSystemSettingResponse.fromBuffer);
}

@$pb.GrpcServiceName('giftcards.GiftCardsService')
abstract class GiftCardsServiceBase extends $grpc.Service {
  $core.String get $name => 'giftcards.GiftCardsService';

  GiftCardsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BuyGiftCardRequest, $0.BuyGiftCardResponse>(
        'BuyGiftCard',
        buyGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyGiftCardRequest.fromBuffer(value),
        ($0.BuyGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRedeemCodeRequest, $0.GetRedeemCodeResponse>(
        'GetRedeemCode',
        getRedeemCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRedeemCodeRequest.fromBuffer(value),
        ($0.GetRedeemCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardsRequest, $0.GetGiftCardsResponse>(
        'GetGiftCards',
        getGiftCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardsRequest.fromBuffer(value),
        ($0.GetGiftCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardRequest, $0.GetGiftCardResponse>(
        'GetGiftCard',
        getGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardRequest.fromBuffer(value),
        ($0.GetGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferGiftCardRequest, $0.TransferGiftCardResponse>(
        'TransferGiftCard',
        transferGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TransferGiftCardRequest.fromBuffer(value),
        ($0.TransferGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardBrandsRequest, $0.GetGiftCardBrandsResponse>(
        'GetGiftCardBrands',
        getGiftCardBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardBrandsRequest.fromBuffer(value),
        ($0.GetGiftCardBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardHistoryRequest, $0.GetGiftCardHistoryResponse>(
        'GetGiftCardHistory',
        getGiftCardHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardHistoryRequest.fromBuffer(value),
        ($0.GetGiftCardHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSellableCardsRequest, $0.GetSellableCardsResponse>(
        'GetSellableCards',
        getSellableCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSellableCardsRequest.fromBuffer(value),
        ($0.GetSellableCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSellProviderRequest, $0.GetSellProviderResponse>(
        'GetSellProvider',
        getSellProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSellProviderRequest.fromBuffer(value),
        ($0.GetSellProviderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFeatureFlagRequest, $0.UpdateFeatureFlagResponse>(
        'UpdateFeatureFlag',
        updateFeatureFlag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateFeatureFlagRequest.fromBuffer(value),
        ($0.UpdateFeatureFlagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPayoutMethodsRequest, $0.GetPayoutMethodsResponse>(
        'GetPayoutMethods',
        getPayoutMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPayoutMethodsRequest.fromBuffer(value),
        ($0.GetPayoutMethodsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSellRateRequest, $0.GetSellRateResponse>(
        'GetSellRate',
        getSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSellRateRequest.fromBuffer(value),
        ($0.GetSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadSellImageRequest, $0.UploadSellImageResponse>(
        'UploadSellImage',
        uploadSellImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadSellImageRequest.fromBuffer(value),
        ($0.UploadSellImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExtractCardDetailsRequest, $0.ExtractCardDetailsResponse>(
        'ExtractCardDetails',
        extractCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExtractCardDetailsRequest.fromBuffer(value),
        ($0.ExtractCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SellGiftCardRequest, $0.SellGiftCardResponse>(
        'SellGiftCard',
        sellGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SellGiftCardRequest.fromBuffer(value),
        ($0.SellGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSellStatusRequest, $0.GetSellStatusResponse>(
        'GetSellStatus',
        getSellStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSellStatusRequest.fromBuffer(value),
        ($0.GetSellStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMySalesRequest, $0.GetMySalesResponse>(
        'GetMySales',
        getMySales_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMySalesRequest.fromBuffer(value),
        ($0.GetMySalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListPendingSalesRequest, $0.AdminListPendingSalesResponse>(
        'AdminListPendingSales',
        adminListPendingSales_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminListPendingSalesRequest.fromBuffer(value),
        ($0.AdminListPendingSalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListBuyTransactionsRequest, $0.AdminListBuyTransactionsResponse>(
        'AdminListBuyTransactions',
        adminListBuyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminListBuyTransactionsRequest.fromBuffer(value),
        ($0.AdminListBuyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetSaleDetailRequest, $0.AdminGetSaleDetailResponse>(
        'AdminGetSaleDetail',
        adminGetSaleDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetSaleDetailRequest.fromBuffer(value),
        ($0.AdminGetSaleDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminApproveSaleRequest, $0.AdminApproveSaleResponse>(
        'AdminApproveSale',
        adminApproveSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminApproveSaleRequest.fromBuffer(value),
        ($0.AdminApproveSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminProcessPayoutRequest, $0.AdminProcessPayoutResponse>(
        'AdminProcessPayout',
        adminProcessPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminProcessPayoutRequest.fromBuffer(value),
        ($0.AdminProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminRejectSaleRequest, $0.AdminRejectSaleResponse>(
        'AdminRejectSale',
        adminRejectSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminRejectSaleRequest.fromBuffer(value),
        ($0.AdminRejectSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListSellRatesRequest, $0.AdminListSellRatesResponse>(
        'AdminListSellRates',
        adminListSellRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminListSellRatesRequest.fromBuffer(value),
        ($0.AdminListSellRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminCreateSellRateRequest, $0.AdminCreateSellRateResponse>(
        'AdminCreateSellRate',
        adminCreateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminCreateSellRateRequest.fromBuffer(value),
        ($0.AdminCreateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpdateSellRateRequest, $0.AdminUpdateSellRateResponse>(
        'AdminUpdateSellRate',
        adminUpdateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminUpdateSellRateRequest.fromBuffer(value),
        ($0.AdminUpdateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminToggleSellRateRequest, $0.AdminToggleSellRateResponse>(
        'AdminToggleSellRate',
        adminToggleSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminToggleSellRateRequest.fromBuffer(value),
        ($0.AdminToggleSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCountriesRequest, $0.GetSupportedCountriesResponse>(
        'GetSupportedCountries',
        getSupportedCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSupportedCountriesRequest.fromBuffer(value),
        ($0.GetSupportedCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardsAnalyticsRequest, $0.GetGiftCardsAnalyticsResponse>(
        'GetGiftCardsAnalytics',
        getGiftCardsAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardsAnalyticsRequest.fromBuffer(value),
        ($0.GetGiftCardsAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReconciliationOverviewRequest, $0.GetReconciliationOverviewResponse>(
        'GetReconciliationOverview',
        getReconciliationOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetReconciliationOverviewRequest.fromBuffer(value),
        ($0.GetReconciliationOverviewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOrphanedTransactionsRequest, $0.GetOrphanedTransactionsResponse>(
        'GetOrphanedTransactions',
        getOrphanedTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOrphanedTransactionsRequest.fromBuffer(value),
        ($0.GetOrphanedTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveOrphanedTransactionRequest, $0.ResolveOrphanedTransactionResponse>(
        'ResolveOrphanedTransaction',
        resolveOrphanedTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ResolveOrphanedTransactionRequest.fromBuffer(value),
        ($0.ResolveOrphanedTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPendingVerificationsRequest, $0.GetPendingVerificationsResponse>(
        'GetPendingVerifications',
        getPendingVerifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPendingVerificationsRequest.fromBuffer(value),
        ($0.GetPendingVerificationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEscalatedItemsRequest, $0.GetEscalatedItemsResponse>(
        'GetEscalatedItems',
        getEscalatedItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetEscalatedItemsRequest.fromBuffer(value),
        ($0.GetEscalatedItemsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveEscalatedItemRequest, $0.ResolveEscalatedItemResponse>(
        'ResolveEscalatedItem',
        resolveEscalatedItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ResolveEscalatedItemRequest.fromBuffer(value),
        ($0.ResolveEscalatedItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReconciliationHistoryRequest, $0.GetReconciliationHistoryResponse>(
        'GetReconciliationHistory',
        getReconciliationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetReconciliationHistoryRequest.fromBuffer(value),
        ($0.GetReconciliationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LookupUserRequest, $0.LookupUserResponse>(
        'LookupUser',
        lookupUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LookupUserRequest.fromBuffer(value),
        ($0.LookupUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserDetailsRequest, $0.GetUserDetailsResponse>(
        'GetUserDetails',
        getUserDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserDetailsRequest.fromBuffer(value),
        ($0.GetUserDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchGiftCardTransactionRequest, $0.SearchGiftCardTransactionResponse>(
        'SearchGiftCardTransaction',
        searchGiftCardTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchGiftCardTransactionRequest.fromBuffer(value),
        ($0.SearchGiftCardTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PerformManualOperationRequest, $0.PerformManualOperationResponse>(
        'PerformManualOperation',
        performManualOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PerformManualOperationRequest.fromBuffer(value),
        ($0.PerformManualOperationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardAuditLogRequest, $0.GetGiftCardAuditLogResponse>(
        'GetGiftCardAuditLog',
        getGiftCardAuditLog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardAuditLogRequest.fromBuffer(value),
        ($0.GetGiftCardAuditLogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSystemSettingsRequest, $0.ListSystemSettingsResponse>(
        'ListSystemSettings',
        listSystemSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListSystemSettingsRequest.fromBuffer(value),
        ($0.ListSystemSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSystemSettingRequest, $0.UpdateSystemSettingResponse>(
        'UpdateSystemSetting',
        updateSystemSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateSystemSettingRequest.fromBuffer(value),
        ($0.UpdateSystemSettingResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.BuyGiftCardResponse> buyGiftCard_Pre($grpc.ServiceCall $call, $async.Future<$0.BuyGiftCardRequest> $request) async {
    return buyGiftCard($call, await $request);
  }

  $async.Future<$0.BuyGiftCardResponse> buyGiftCard($grpc.ServiceCall call, $0.BuyGiftCardRequest request);

  $async.Future<$0.GetRedeemCodeResponse> getRedeemCode_Pre($grpc.ServiceCall $call, $async.Future<$0.GetRedeemCodeRequest> $request) async {
    return getRedeemCode($call, await $request);
  }

  $async.Future<$0.GetRedeemCodeResponse> getRedeemCode($grpc.ServiceCall call, $0.GetRedeemCodeRequest request);

  $async.Future<$0.GetGiftCardsResponse> getGiftCards_Pre($grpc.ServiceCall $call, $async.Future<$0.GetGiftCardsRequest> $request) async {
    return getGiftCards($call, await $request);
  }

  $async.Future<$0.GetGiftCardsResponse> getGiftCards($grpc.ServiceCall call, $0.GetGiftCardsRequest request);

  $async.Future<$0.GetGiftCardResponse> getGiftCard_Pre($grpc.ServiceCall $call, $async.Future<$0.GetGiftCardRequest> $request) async {
    return getGiftCard($call, await $request);
  }

  $async.Future<$0.GetGiftCardResponse> getGiftCard($grpc.ServiceCall call, $0.GetGiftCardRequest request);

  $async.Future<$0.TransferGiftCardResponse> transferGiftCard_Pre($grpc.ServiceCall $call, $async.Future<$0.TransferGiftCardRequest> $request) async {
    return transferGiftCard($call, await $request);
  }

  $async.Future<$0.TransferGiftCardResponse> transferGiftCard($grpc.ServiceCall call, $0.TransferGiftCardRequest request);

  $async.Future<$0.GetGiftCardBrandsResponse> getGiftCardBrands_Pre($grpc.ServiceCall $call, $async.Future<$0.GetGiftCardBrandsRequest> $request) async {
    return getGiftCardBrands($call, await $request);
  }

  $async.Future<$0.GetGiftCardBrandsResponse> getGiftCardBrands($grpc.ServiceCall call, $0.GetGiftCardBrandsRequest request);

  $async.Future<$0.GetGiftCardHistoryResponse> getGiftCardHistory_Pre($grpc.ServiceCall $call, $async.Future<$0.GetGiftCardHistoryRequest> $request) async {
    return getGiftCardHistory($call, await $request);
  }

  $async.Future<$0.GetGiftCardHistoryResponse> getGiftCardHistory($grpc.ServiceCall call, $0.GetGiftCardHistoryRequest request);

  $async.Future<$0.GetSellableCardsResponse> getSellableCards_Pre($grpc.ServiceCall $call, $async.Future<$0.GetSellableCardsRequest> $request) async {
    return getSellableCards($call, await $request);
  }

  $async.Future<$0.GetSellableCardsResponse> getSellableCards($grpc.ServiceCall call, $0.GetSellableCardsRequest request);

  $async.Future<$0.GetSellProviderResponse> getSellProvider_Pre($grpc.ServiceCall $call, $async.Future<$0.GetSellProviderRequest> $request) async {
    return getSellProvider($call, await $request);
  }

  $async.Future<$0.GetSellProviderResponse> getSellProvider($grpc.ServiceCall call, $0.GetSellProviderRequest request);

  $async.Future<$0.UpdateFeatureFlagResponse> updateFeatureFlag_Pre($grpc.ServiceCall $call, $async.Future<$0.UpdateFeatureFlagRequest> $request) async {
    return updateFeatureFlag($call, await $request);
  }

  $async.Future<$0.UpdateFeatureFlagResponse> updateFeatureFlag($grpc.ServiceCall call, $0.UpdateFeatureFlagRequest request);

  $async.Future<$0.GetPayoutMethodsResponse> getPayoutMethods_Pre($grpc.ServiceCall $call, $async.Future<$0.GetPayoutMethodsRequest> $request) async {
    return getPayoutMethods($call, await $request);
  }

  $async.Future<$0.GetPayoutMethodsResponse> getPayoutMethods($grpc.ServiceCall call, $0.GetPayoutMethodsRequest request);

  $async.Future<$0.GetSellRateResponse> getSellRate_Pre($grpc.ServiceCall $call, $async.Future<$0.GetSellRateRequest> $request) async {
    return getSellRate($call, await $request);
  }

  $async.Future<$0.GetSellRateResponse> getSellRate($grpc.ServiceCall call, $0.GetSellRateRequest request);

  $async.Future<$0.UploadSellImageResponse> uploadSellImage_Pre($grpc.ServiceCall $call, $async.Future<$0.UploadSellImageRequest> $request) async {
    return uploadSellImage($call, await $request);
  }

  $async.Future<$0.UploadSellImageResponse> uploadSellImage($grpc.ServiceCall call, $0.UploadSellImageRequest request);

  $async.Future<$0.ExtractCardDetailsResponse> extractCardDetails_Pre($grpc.ServiceCall $call, $async.Future<$0.ExtractCardDetailsRequest> $request) async {
    return extractCardDetails($call, await $request);
  }

  $async.Future<$0.ExtractCardDetailsResponse> extractCardDetails($grpc.ServiceCall call, $0.ExtractCardDetailsRequest request);

  $async.Future<$0.SellGiftCardResponse> sellGiftCard_Pre($grpc.ServiceCall $call, $async.Future<$0.SellGiftCardRequest> $request) async {
    return sellGiftCard($call, await $request);
  }

  $async.Future<$0.SellGiftCardResponse> sellGiftCard($grpc.ServiceCall call, $0.SellGiftCardRequest request);

  $async.Future<$0.GetSellStatusResponse> getSellStatus_Pre($grpc.ServiceCall $call, $async.Future<$0.GetSellStatusRequest> $request) async {
    return getSellStatus($call, await $request);
  }

  $async.Future<$0.GetSellStatusResponse> getSellStatus($grpc.ServiceCall call, $0.GetSellStatusRequest request);

  $async.Future<$0.GetMySalesResponse> getMySales_Pre($grpc.ServiceCall $call, $async.Future<$0.GetMySalesRequest> $request) async {
    return getMySales($call, await $request);
  }

  $async.Future<$0.GetMySalesResponse> getMySales($grpc.ServiceCall call, $0.GetMySalesRequest request);

  $async.Future<$0.AdminListPendingSalesResponse> adminListPendingSales_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminListPendingSalesRequest> $request) async {
    return adminListPendingSales($call, await $request);
  }

  $async.Future<$0.AdminListPendingSalesResponse> adminListPendingSales($grpc.ServiceCall call, $0.AdminListPendingSalesRequest request);

  $async.Future<$0.AdminListBuyTransactionsResponse> adminListBuyTransactions_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminListBuyTransactionsRequest> $request) async {
    return adminListBuyTransactions($call, await $request);
  }

  $async.Future<$0.AdminListBuyTransactionsResponse> adminListBuyTransactions($grpc.ServiceCall call, $0.AdminListBuyTransactionsRequest request);

  $async.Future<$0.AdminGetSaleDetailResponse> adminGetSaleDetail_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminGetSaleDetailRequest> $request) async {
    return adminGetSaleDetail($call, await $request);
  }

  $async.Future<$0.AdminGetSaleDetailResponse> adminGetSaleDetail($grpc.ServiceCall call, $0.AdminGetSaleDetailRequest request);

  $async.Future<$0.AdminApproveSaleResponse> adminApproveSale_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminApproveSaleRequest> $request) async {
    return adminApproveSale($call, await $request);
  }

  $async.Future<$0.AdminApproveSaleResponse> adminApproveSale($grpc.ServiceCall call, $0.AdminApproveSaleRequest request);

  $async.Future<$0.AdminProcessPayoutResponse> adminProcessPayout_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminProcessPayoutRequest> $request) async {
    return adminProcessPayout($call, await $request);
  }

  $async.Future<$0.AdminProcessPayoutResponse> adminProcessPayout($grpc.ServiceCall call, $0.AdminProcessPayoutRequest request);

  $async.Future<$0.AdminRejectSaleResponse> adminRejectSale_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminRejectSaleRequest> $request) async {
    return adminRejectSale($call, await $request);
  }

  $async.Future<$0.AdminRejectSaleResponse> adminRejectSale($grpc.ServiceCall call, $0.AdminRejectSaleRequest request);

  $async.Future<$0.AdminListSellRatesResponse> adminListSellRates_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminListSellRatesRequest> $request) async {
    return adminListSellRates($call, await $request);
  }

  $async.Future<$0.AdminListSellRatesResponse> adminListSellRates($grpc.ServiceCall call, $0.AdminListSellRatesRequest request);

  $async.Future<$0.AdminCreateSellRateResponse> adminCreateSellRate_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminCreateSellRateRequest> $request) async {
    return adminCreateSellRate($call, await $request);
  }

  $async.Future<$0.AdminCreateSellRateResponse> adminCreateSellRate($grpc.ServiceCall call, $0.AdminCreateSellRateRequest request);

  $async.Future<$0.AdminUpdateSellRateResponse> adminUpdateSellRate_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminUpdateSellRateRequest> $request) async {
    return adminUpdateSellRate($call, await $request);
  }

  $async.Future<$0.AdminUpdateSellRateResponse> adminUpdateSellRate($grpc.ServiceCall call, $0.AdminUpdateSellRateRequest request);

  $async.Future<$0.AdminToggleSellRateResponse> adminToggleSellRate_Pre($grpc.ServiceCall $call, $async.Future<$0.AdminToggleSellRateRequest> $request) async {
    return adminToggleSellRate($call, await $request);
  }

  $async.Future<$0.AdminToggleSellRateResponse> adminToggleSellRate($grpc.ServiceCall call, $0.AdminToggleSellRateRequest request);

  $async.Future<$0.GetSupportedCountriesResponse> getSupportedCountries_Pre($grpc.ServiceCall $call, $async.Future<$0.GetSupportedCountriesRequest> $request) async {
    return getSupportedCountries($call, await $request);
  }

  $async.Future<$0.GetSupportedCountriesResponse> getSupportedCountries($grpc.ServiceCall call, $0.GetSupportedCountriesRequest request);

  $async.Future<$0.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics_Pre($grpc.ServiceCall $call, $async.Future<$0.GetGiftCardsAnalyticsRequest> $request) async {
    return getGiftCardsAnalytics($call, await $request);
  }

  $async.Future<$0.GetGiftCardsAnalyticsResponse> getGiftCardsAnalytics($grpc.ServiceCall call, $0.GetGiftCardsAnalyticsRequest request);

  $async.Future<$0.GetReconciliationOverviewResponse> getReconciliationOverview_Pre($grpc.ServiceCall $call, $async.Future<$0.GetReconciliationOverviewRequest> $request) async {
    return getReconciliationOverview($call, await $request);
  }

  $async.Future<$0.GetReconciliationOverviewResponse> getReconciliationOverview($grpc.ServiceCall call, $0.GetReconciliationOverviewRequest request);

  $async.Future<$0.GetOrphanedTransactionsResponse> getOrphanedTransactions_Pre($grpc.ServiceCall $call, $async.Future<$0.GetOrphanedTransactionsRequest> $request) async {
    return getOrphanedTransactions($call, await $request);
  }

  $async.Future<$0.GetOrphanedTransactionsResponse> getOrphanedTransactions($grpc.ServiceCall call, $0.GetOrphanedTransactionsRequest request);

  $async.Future<$0.ResolveOrphanedTransactionResponse> resolveOrphanedTransaction_Pre($grpc.ServiceCall $call, $async.Future<$0.ResolveOrphanedTransactionRequest> $request) async {
    return resolveOrphanedTransaction($call, await $request);
  }

  $async.Future<$0.ResolveOrphanedTransactionResponse> resolveOrphanedTransaction($grpc.ServiceCall call, $0.ResolveOrphanedTransactionRequest request);

  $async.Future<$0.GetPendingVerificationsResponse> getPendingVerifications_Pre($grpc.ServiceCall $call, $async.Future<$0.GetPendingVerificationsRequest> $request) async {
    return getPendingVerifications($call, await $request);
  }

  $async.Future<$0.GetPendingVerificationsResponse> getPendingVerifications($grpc.ServiceCall call, $0.GetPendingVerificationsRequest request);

  $async.Future<$0.GetEscalatedItemsResponse> getEscalatedItems_Pre($grpc.ServiceCall $call, $async.Future<$0.GetEscalatedItemsRequest> $request) async {
    return getEscalatedItems($call, await $request);
  }

  $async.Future<$0.GetEscalatedItemsResponse> getEscalatedItems($grpc.ServiceCall call, $0.GetEscalatedItemsRequest request);

  $async.Future<$0.ResolveEscalatedItemResponse> resolveEscalatedItem_Pre($grpc.ServiceCall $call, $async.Future<$0.ResolveEscalatedItemRequest> $request) async {
    return resolveEscalatedItem($call, await $request);
  }

  $async.Future<$0.ResolveEscalatedItemResponse> resolveEscalatedItem($grpc.ServiceCall call, $0.ResolveEscalatedItemRequest request);

  $async.Future<$0.GetReconciliationHistoryResponse> getReconciliationHistory_Pre($grpc.ServiceCall $call, $async.Future<$0.GetReconciliationHistoryRequest> $request) async {
    return getReconciliationHistory($call, await $request);
  }

  $async.Future<$0.GetReconciliationHistoryResponse> getReconciliationHistory($grpc.ServiceCall call, $0.GetReconciliationHistoryRequest request);

  $async.Future<$0.LookupUserResponse> lookupUser_Pre($grpc.ServiceCall $call, $async.Future<$0.LookupUserRequest> $request) async {
    return lookupUser($call, await $request);
  }

  $async.Future<$0.LookupUserResponse> lookupUser($grpc.ServiceCall call, $0.LookupUserRequest request);

  $async.Future<$0.GetUserDetailsResponse> getUserDetails_Pre($grpc.ServiceCall $call, $async.Future<$0.GetUserDetailsRequest> $request) async {
    return getUserDetails($call, await $request);
  }

  $async.Future<$0.GetUserDetailsResponse> getUserDetails($grpc.ServiceCall call, $0.GetUserDetailsRequest request);

  $async.Future<$0.SearchGiftCardTransactionResponse> searchGiftCardTransaction_Pre($grpc.ServiceCall $call, $async.Future<$0.SearchGiftCardTransactionRequest> $request) async {
    return searchGiftCardTransaction($call, await $request);
  }

  $async.Future<$0.SearchGiftCardTransactionResponse> searchGiftCardTransaction($grpc.ServiceCall call, $0.SearchGiftCardTransactionRequest request);

  $async.Future<$0.PerformManualOperationResponse> performManualOperation_Pre($grpc.ServiceCall $call, $async.Future<$0.PerformManualOperationRequest> $request) async {
    return performManualOperation($call, await $request);
  }

  $async.Future<$0.PerformManualOperationResponse> performManualOperation($grpc.ServiceCall call, $0.PerformManualOperationRequest request);

  $async.Future<$0.GetGiftCardAuditLogResponse> getGiftCardAuditLog_Pre($grpc.ServiceCall $call, $async.Future<$0.GetGiftCardAuditLogRequest> $request) async {
    return getGiftCardAuditLog($call, await $request);
  }

  $async.Future<$0.GetGiftCardAuditLogResponse> getGiftCardAuditLog($grpc.ServiceCall call, $0.GetGiftCardAuditLogRequest request);

  $async.Future<$0.ListSystemSettingsResponse> listSystemSettings_Pre($grpc.ServiceCall $call, $async.Future<$0.ListSystemSettingsRequest> $request) async {
    return listSystemSettings($call, await $request);
  }

  $async.Future<$0.ListSystemSettingsResponse> listSystemSettings($grpc.ServiceCall call, $0.ListSystemSettingsRequest request);

  $async.Future<$0.UpdateSystemSettingResponse> updateSystemSetting_Pre($grpc.ServiceCall $call, $async.Future<$0.UpdateSystemSettingRequest> $request) async {
    return updateSystemSetting($call, await $request);
  }

  $async.Future<$0.UpdateSystemSettingResponse> updateSystemSetting($grpc.ServiceCall call, $0.UpdateSystemSettingRequest request);

}
