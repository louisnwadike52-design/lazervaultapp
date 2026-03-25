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
  $grpc.ResponseFuture<$0.BuyGiftCardResponse> buyGiftCard(
    $0.BuyGiftCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$buyGiftCard, request, options: options);
  }

  /// Get the merchant redeem code for a purchased gift card (fetches from Reloadly)
  $grpc.ResponseFuture<$0.GetRedeemCodeResponse> getRedeemCode(
    $0.GetRedeemCodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRedeemCode, request, options: options);
  }

  /// Get user's gift cards
  $grpc.ResponseFuture<$0.GetGiftCardsResponse> getGiftCards(
    $0.GetGiftCardsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGiftCards, request, options: options);
  }

  /// Get specific gift card details
  $grpc.ResponseFuture<$0.GetGiftCardResponse> getGiftCard(
    $0.GetGiftCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGiftCard, request, options: options);
  }

  /// Transfer gift card to another user
  $grpc.ResponseFuture<$0.TransferGiftCardResponse> transferGiftCard(
    $0.TransferGiftCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$transferGiftCard, request, options: options);
  }

  /// Get available gift card brands/merchants
  $grpc.ResponseFuture<$0.GetGiftCardBrandsResponse> getGiftCardBrands(
    $0.GetGiftCardBrandsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGiftCardBrands, request, options: options);
  }

  /// Get gift card transaction history
  $grpc.ResponseFuture<$0.GetGiftCardHistoryResponse> getGiftCardHistory(
    $0.GetGiftCardHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGiftCardHistory, request, options: options);
  }

  /// Get card types available for selling
  $grpc.ResponseFuture<$0.GetSellableCardsResponse> getSellableCards(
    $0.GetSellableCardsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSellableCards, request, options: options);
  }

  /// Get current sell rate for a card type + denomination
  $grpc.ResponseFuture<$0.GetSellRateResponse> getSellRate(
    $0.GetSellRateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSellRate, request, options: options);
  }

  /// Upload a gift card image for selling
  $grpc.ResponseFuture<$0.UploadSellImageResponse> uploadSellImage(
    $0.UploadSellImageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadSellImage, request, options: options);
  }

  /// Extract gift card details from uploaded images using LLM OCR
  $grpc.ResponseFuture<$0.ExtractCardDetailsResponse> extractCardDetails(
    $0.ExtractCardDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$extractCardDetails, request, options: options);
  }

  /// Submit a gift card for sale (goes to pending_review for admin approval)
  $grpc.ResponseFuture<$0.SellGiftCardResponse> sellGiftCard(
    $0.SellGiftCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  /// Get status of a sell transaction
  $grpc.ResponseFuture<$0.GetSellStatusResponse> getSellStatus(
    $0.GetSellStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSellStatus, request, options: options);
  }

  /// Get user's sell transactions
  $grpc.ResponseFuture<$0.GetMySalesResponse> getMySales(
    $0.GetMySalesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMySales, request, options: options);
  }

  /// List sell requests pending admin review
  $grpc.ResponseFuture<$0.AdminListPendingSalesResponse> adminListPendingSales(
    $0.AdminListPendingSalesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListPendingSales, request, options: options);
  }

  /// Get full sell request details for admin review (includes images)
  $grpc.ResponseFuture<$0.AdminGetSaleDetailResponse> adminGetSaleDetail(
    $0.AdminGetSaleDetailRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminGetSaleDetail, request, options: options);
  }

  /// Approve a sell request (credits user account, optionally submits to provider)
  $grpc.ResponseFuture<$0.AdminApproveSaleResponse> adminApproveSale(
    $0.AdminApproveSaleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminApproveSale, request, options: options);
  }

  /// Reject a sell request with reason
  $grpc.ResponseFuture<$0.AdminRejectSaleResponse> adminRejectSale(
    $0.AdminRejectSaleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminRejectSale, request, options: options);
  }

  /// List all sell rate configurations
  $grpc.ResponseFuture<$0.AdminListSellRatesResponse> adminListSellRates(
    $0.AdminListSellRatesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListSellRates, request, options: options);
  }

  /// Create a new sell rate configuration
  $grpc.ResponseFuture<$0.AdminCreateSellRateResponse> adminCreateSellRate(
    $0.AdminCreateSellRateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminCreateSellRate, request, options: options);
  }

  /// Update an existing sell rate configuration
  $grpc.ResponseFuture<$0.AdminUpdateSellRateResponse> adminUpdateSellRate(
    $0.AdminUpdateSellRateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminUpdateSellRate, request, options: options);
  }

  /// Toggle active/inactive status for a sell rate
  $grpc.ResponseFuture<$0.AdminToggleSellRateResponse> adminToggleSellRate(
    $0.AdminToggleSellRateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminToggleSellRate, request, options: options);
  }

  /// Get supported countries for gift cards (from Reloadly)
  $grpc.ResponseFuture<$0.GetSupportedCountriesResponse> getSupportedCountries(
    $0.GetSupportedCountriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedCountries, request, options: options);
  }

  // method descriptors

  static final _$buyGiftCard =
      $grpc.ClientMethod<$0.BuyGiftCardRequest, $0.BuyGiftCardResponse>(
          '/giftcards.GiftCardsService/BuyGiftCard',
          ($0.BuyGiftCardRequest value) => value.writeToBuffer(),
          $0.BuyGiftCardResponse.fromBuffer);
  static final _$getRedeemCode =
      $grpc.ClientMethod<$0.GetRedeemCodeRequest, $0.GetRedeemCodeResponse>(
          '/giftcards.GiftCardsService/GetRedeemCode',
          ($0.GetRedeemCodeRequest value) => value.writeToBuffer(),
          $0.GetRedeemCodeResponse.fromBuffer);
  static final _$getGiftCards =
      $grpc.ClientMethod<$0.GetGiftCardsRequest, $0.GetGiftCardsResponse>(
          '/giftcards.GiftCardsService/GetGiftCards',
          ($0.GetGiftCardsRequest value) => value.writeToBuffer(),
          $0.GetGiftCardsResponse.fromBuffer);
  static final _$getGiftCard =
      $grpc.ClientMethod<$0.GetGiftCardRequest, $0.GetGiftCardResponse>(
          '/giftcards.GiftCardsService/GetGiftCard',
          ($0.GetGiftCardRequest value) => value.writeToBuffer(),
          $0.GetGiftCardResponse.fromBuffer);
  static final _$transferGiftCard = $grpc.ClientMethod<
          $0.TransferGiftCardRequest, $0.TransferGiftCardResponse>(
      '/giftcards.GiftCardsService/TransferGiftCard',
      ($0.TransferGiftCardRequest value) => value.writeToBuffer(),
      $0.TransferGiftCardResponse.fromBuffer);
  static final _$getGiftCardBrands = $grpc.ClientMethod<
          $0.GetGiftCardBrandsRequest, $0.GetGiftCardBrandsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardBrands',
      ($0.GetGiftCardBrandsRequest value) => value.writeToBuffer(),
      $0.GetGiftCardBrandsResponse.fromBuffer);
  static final _$getGiftCardHistory = $grpc.ClientMethod<
          $0.GetGiftCardHistoryRequest, $0.GetGiftCardHistoryResponse>(
      '/giftcards.GiftCardsService/GetGiftCardHistory',
      ($0.GetGiftCardHistoryRequest value) => value.writeToBuffer(),
      $0.GetGiftCardHistoryResponse.fromBuffer);
  static final _$getSellableCards = $grpc.ClientMethod<
          $0.GetSellableCardsRequest, $0.GetSellableCardsResponse>(
      '/giftcards.GiftCardsService/GetSellableCards',
      ($0.GetSellableCardsRequest value) => value.writeToBuffer(),
      $0.GetSellableCardsResponse.fromBuffer);
  static final _$getSellRate =
      $grpc.ClientMethod<$0.GetSellRateRequest, $0.GetSellRateResponse>(
          '/giftcards.GiftCardsService/GetSellRate',
          ($0.GetSellRateRequest value) => value.writeToBuffer(),
          $0.GetSellRateResponse.fromBuffer);
  static final _$uploadSellImage =
      $grpc.ClientMethod<$0.UploadSellImageRequest, $0.UploadSellImageResponse>(
          '/giftcards.GiftCardsService/UploadSellImage',
          ($0.UploadSellImageRequest value) => value.writeToBuffer(),
          $0.UploadSellImageResponse.fromBuffer);
  static final _$extractCardDetails = $grpc.ClientMethod<
          $0.ExtractCardDetailsRequest, $0.ExtractCardDetailsResponse>(
      '/giftcards.GiftCardsService/ExtractCardDetails',
      ($0.ExtractCardDetailsRequest value) => value.writeToBuffer(),
      $0.ExtractCardDetailsResponse.fromBuffer);
  static final _$sellGiftCard =
      $grpc.ClientMethod<$0.SellGiftCardRequest, $0.SellGiftCardResponse>(
          '/giftcards.GiftCardsService/SellGiftCard',
          ($0.SellGiftCardRequest value) => value.writeToBuffer(),
          $0.SellGiftCardResponse.fromBuffer);
  static final _$getSellStatus =
      $grpc.ClientMethod<$0.GetSellStatusRequest, $0.GetSellStatusResponse>(
          '/giftcards.GiftCardsService/GetSellStatus',
          ($0.GetSellStatusRequest value) => value.writeToBuffer(),
          $0.GetSellStatusResponse.fromBuffer);
  static final _$getMySales =
      $grpc.ClientMethod<$0.GetMySalesRequest, $0.GetMySalesResponse>(
          '/giftcards.GiftCardsService/GetMySales',
          ($0.GetMySalesRequest value) => value.writeToBuffer(),
          $0.GetMySalesResponse.fromBuffer);
  static final _$adminListPendingSales = $grpc.ClientMethod<
          $0.AdminListPendingSalesRequest, $0.AdminListPendingSalesResponse>(
      '/giftcards.GiftCardsService/AdminListPendingSales',
      ($0.AdminListPendingSalesRequest value) => value.writeToBuffer(),
      $0.AdminListPendingSalesResponse.fromBuffer);
  static final _$adminGetSaleDetail = $grpc.ClientMethod<
          $0.AdminGetSaleDetailRequest, $0.AdminGetSaleDetailResponse>(
      '/giftcards.GiftCardsService/AdminGetSaleDetail',
      ($0.AdminGetSaleDetailRequest value) => value.writeToBuffer(),
      $0.AdminGetSaleDetailResponse.fromBuffer);
  static final _$adminApproveSale = $grpc.ClientMethod<
          $0.AdminApproveSaleRequest, $0.AdminApproveSaleResponse>(
      '/giftcards.GiftCardsService/AdminApproveSale',
      ($0.AdminApproveSaleRequest value) => value.writeToBuffer(),
      $0.AdminApproveSaleResponse.fromBuffer);
  static final _$adminRejectSale =
      $grpc.ClientMethod<$0.AdminRejectSaleRequest, $0.AdminRejectSaleResponse>(
          '/giftcards.GiftCardsService/AdminRejectSale',
          ($0.AdminRejectSaleRequest value) => value.writeToBuffer(),
          $0.AdminRejectSaleResponse.fromBuffer);
  static final _$adminListSellRates = $grpc.ClientMethod<
          $0.AdminListSellRatesRequest, $0.AdminListSellRatesResponse>(
      '/giftcards.GiftCardsService/AdminListSellRates',
      ($0.AdminListSellRatesRequest value) => value.writeToBuffer(),
      $0.AdminListSellRatesResponse.fromBuffer);
  static final _$adminCreateSellRate = $grpc.ClientMethod<
          $0.AdminCreateSellRateRequest, $0.AdminCreateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminCreateSellRate',
      ($0.AdminCreateSellRateRequest value) => value.writeToBuffer(),
      $0.AdminCreateSellRateResponse.fromBuffer);
  static final _$adminUpdateSellRate = $grpc.ClientMethod<
          $0.AdminUpdateSellRateRequest, $0.AdminUpdateSellRateResponse>(
      '/giftcards.GiftCardsService/AdminUpdateSellRate',
      ($0.AdminUpdateSellRateRequest value) => value.writeToBuffer(),
      $0.AdminUpdateSellRateResponse.fromBuffer);
  static final _$adminToggleSellRate = $grpc.ClientMethod<
          $0.AdminToggleSellRateRequest, $0.AdminToggleSellRateResponse>(
      '/giftcards.GiftCardsService/AdminToggleSellRate',
      ($0.AdminToggleSellRateRequest value) => value.writeToBuffer(),
      $0.AdminToggleSellRateResponse.fromBuffer);
  static final _$getSupportedCountries = $grpc.ClientMethod<
          $0.GetSupportedCountriesRequest, $0.GetSupportedCountriesResponse>(
      '/giftcards.GiftCardsService/GetSupportedCountries',
      ($0.GetSupportedCountriesRequest value) => value.writeToBuffer(),
      $0.GetSupportedCountriesResponse.fromBuffer);
}

@$pb.GrpcServiceName('giftcards.GiftCardsService')
abstract class GiftCardsServiceBase extends $grpc.Service {
  $core.String get $name => 'giftcards.GiftCardsService';

  GiftCardsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.BuyGiftCardRequest, $0.BuyGiftCardResponse>(
            'BuyGiftCard',
            buyGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BuyGiftCardRequest.fromBuffer(value),
            ($0.BuyGiftCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetRedeemCodeRequest, $0.GetRedeemCodeResponse>(
            'GetRedeemCode',
            getRedeemCode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetRedeemCodeRequest.fromBuffer(value),
            ($0.GetRedeemCodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetGiftCardsRequest, $0.GetGiftCardsResponse>(
            'GetGiftCards',
            getGiftCards_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetGiftCardsRequest.fromBuffer(value),
            ($0.GetGiftCardsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetGiftCardRequest, $0.GetGiftCardResponse>(
            'GetGiftCard',
            getGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetGiftCardRequest.fromBuffer(value),
            ($0.GetGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferGiftCardRequest,
            $0.TransferGiftCardResponse>(
        'TransferGiftCard',
        transferGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TransferGiftCardRequest.fromBuffer(value),
        ($0.TransferGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardBrandsRequest,
            $0.GetGiftCardBrandsResponse>(
        'GetGiftCardBrands',
        getGiftCardBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGiftCardBrandsRequest.fromBuffer(value),
        ($0.GetGiftCardBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardHistoryRequest,
            $0.GetGiftCardHistoryResponse>(
        'GetGiftCardHistory',
        getGiftCardHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGiftCardHistoryRequest.fromBuffer(value),
        ($0.GetGiftCardHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSellableCardsRequest,
            $0.GetSellableCardsResponse>(
        'GetSellableCards',
        getSellableCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSellableCardsRequest.fromBuffer(value),
        ($0.GetSellableCardsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetSellRateRequest, $0.GetSellRateResponse>(
            'GetSellRate',
            getSellRate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetSellRateRequest.fromBuffer(value),
            ($0.GetSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadSellImageRequest,
            $0.UploadSellImageResponse>(
        'UploadSellImage',
        uploadSellImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UploadSellImageRequest.fromBuffer(value),
        ($0.UploadSellImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExtractCardDetailsRequest,
            $0.ExtractCardDetailsResponse>(
        'ExtractCardDetails',
        extractCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ExtractCardDetailsRequest.fromBuffer(value),
        ($0.ExtractCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SellGiftCardRequest, $0.SellGiftCardResponse>(
            'SellGiftCard',
            sellGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SellGiftCardRequest.fromBuffer(value),
            ($0.SellGiftCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetSellStatusRequest, $0.GetSellStatusResponse>(
            'GetSellStatus',
            getSellStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetSellStatusRequest.fromBuffer(value),
            ($0.GetSellStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMySalesRequest, $0.GetMySalesResponse>(
        'GetMySales',
        getMySales_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMySalesRequest.fromBuffer(value),
        ($0.GetMySalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListPendingSalesRequest,
            $0.AdminListPendingSalesResponse>(
        'AdminListPendingSales',
        adminListPendingSales_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListPendingSalesRequest.fromBuffer(value),
        ($0.AdminListPendingSalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetSaleDetailRequest,
            $0.AdminGetSaleDetailResponse>(
        'AdminGetSaleDetail',
        adminGetSaleDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetSaleDetailRequest.fromBuffer(value),
        ($0.AdminGetSaleDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminApproveSaleRequest,
            $0.AdminApproveSaleResponse>(
        'AdminApproveSale',
        adminApproveSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminApproveSaleRequest.fromBuffer(value),
        ($0.AdminApproveSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminRejectSaleRequest,
            $0.AdminRejectSaleResponse>(
        'AdminRejectSale',
        adminRejectSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminRejectSaleRequest.fromBuffer(value),
        ($0.AdminRejectSaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListSellRatesRequest,
            $0.AdminListSellRatesResponse>(
        'AdminListSellRates',
        adminListSellRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListSellRatesRequest.fromBuffer(value),
        ($0.AdminListSellRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminCreateSellRateRequest,
            $0.AdminCreateSellRateResponse>(
        'AdminCreateSellRate',
        adminCreateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminCreateSellRateRequest.fromBuffer(value),
        ($0.AdminCreateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpdateSellRateRequest,
            $0.AdminUpdateSellRateResponse>(
        'AdminUpdateSellRate',
        adminUpdateSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUpdateSellRateRequest.fromBuffer(value),
        ($0.AdminUpdateSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminToggleSellRateRequest,
            $0.AdminToggleSellRateResponse>(
        'AdminToggleSellRate',
        adminToggleSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminToggleSellRateRequest.fromBuffer(value),
        ($0.AdminToggleSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCountriesRequest,
            $0.GetSupportedCountriesResponse>(
        'GetSupportedCountries',
        getSupportedCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedCountriesRequest.fromBuffer(value),
        ($0.GetSupportedCountriesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.BuyGiftCardResponse> buyGiftCard_Pre($grpc.ServiceCall $call,
      $async.Future<$0.BuyGiftCardRequest> $request) async {
    return buyGiftCard($call, await $request);
  }

  $async.Future<$0.BuyGiftCardResponse> buyGiftCard(
      $grpc.ServiceCall call, $0.BuyGiftCardRequest request);

  $async.Future<$0.GetRedeemCodeResponse> getRedeemCode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetRedeemCodeRequest> $request) async {
    return getRedeemCode($call, await $request);
  }

  $async.Future<$0.GetRedeemCodeResponse> getRedeemCode(
      $grpc.ServiceCall call, $0.GetRedeemCodeRequest request);

  $async.Future<$0.GetGiftCardsResponse> getGiftCards_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetGiftCardsRequest> $request) async {
    return getGiftCards($call, await $request);
  }

  $async.Future<$0.GetGiftCardsResponse> getGiftCards(
      $grpc.ServiceCall call, $0.GetGiftCardsRequest request);

  $async.Future<$0.GetGiftCardResponse> getGiftCard_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetGiftCardRequest> $request) async {
    return getGiftCard($call, await $request);
  }

  $async.Future<$0.GetGiftCardResponse> getGiftCard(
      $grpc.ServiceCall call, $0.GetGiftCardRequest request);

  $async.Future<$0.TransferGiftCardResponse> transferGiftCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.TransferGiftCardRequest> $request) async {
    return transferGiftCard($call, await $request);
  }

  $async.Future<$0.TransferGiftCardResponse> transferGiftCard(
      $grpc.ServiceCall call, $0.TransferGiftCardRequest request);

  $async.Future<$0.GetGiftCardBrandsResponse> getGiftCardBrands_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetGiftCardBrandsRequest> $request) async {
    return getGiftCardBrands($call, await $request);
  }

  $async.Future<$0.GetGiftCardBrandsResponse> getGiftCardBrands(
      $grpc.ServiceCall call, $0.GetGiftCardBrandsRequest request);

  $async.Future<$0.GetGiftCardHistoryResponse> getGiftCardHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetGiftCardHistoryRequest> $request) async {
    return getGiftCardHistory($call, await $request);
  }

  $async.Future<$0.GetGiftCardHistoryResponse> getGiftCardHistory(
      $grpc.ServiceCall call, $0.GetGiftCardHistoryRequest request);

  $async.Future<$0.GetSellableCardsResponse> getSellableCards_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSellableCardsRequest> $request) async {
    return getSellableCards($call, await $request);
  }

  $async.Future<$0.GetSellableCardsResponse> getSellableCards(
      $grpc.ServiceCall call, $0.GetSellableCardsRequest request);

  $async.Future<$0.GetSellRateResponse> getSellRate_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetSellRateRequest> $request) async {
    return getSellRate($call, await $request);
  }

  $async.Future<$0.GetSellRateResponse> getSellRate(
      $grpc.ServiceCall call, $0.GetSellRateRequest request);

  $async.Future<$0.UploadSellImageResponse> uploadSellImage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UploadSellImageRequest> $request) async {
    return uploadSellImage($call, await $request);
  }

  $async.Future<$0.UploadSellImageResponse> uploadSellImage(
      $grpc.ServiceCall call, $0.UploadSellImageRequest request);

  $async.Future<$0.ExtractCardDetailsResponse> extractCardDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ExtractCardDetailsRequest> $request) async {
    return extractCardDetails($call, await $request);
  }

  $async.Future<$0.ExtractCardDetailsResponse> extractCardDetails(
      $grpc.ServiceCall call, $0.ExtractCardDetailsRequest request);

  $async.Future<$0.SellGiftCardResponse> sellGiftCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SellGiftCardRequest> $request) async {
    return sellGiftCard($call, await $request);
  }

  $async.Future<$0.SellGiftCardResponse> sellGiftCard(
      $grpc.ServiceCall call, $0.SellGiftCardRequest request);

  $async.Future<$0.GetSellStatusResponse> getSellStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSellStatusRequest> $request) async {
    return getSellStatus($call, await $request);
  }

  $async.Future<$0.GetSellStatusResponse> getSellStatus(
      $grpc.ServiceCall call, $0.GetSellStatusRequest request);

  $async.Future<$0.GetMySalesResponse> getMySales_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetMySalesRequest> $request) async {
    return getMySales($call, await $request);
  }

  $async.Future<$0.GetMySalesResponse> getMySales(
      $grpc.ServiceCall call, $0.GetMySalesRequest request);

  $async.Future<$0.AdminListPendingSalesResponse> adminListPendingSales_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminListPendingSalesRequest> $request) async {
    return adminListPendingSales($call, await $request);
  }

  $async.Future<$0.AdminListPendingSalesResponse> adminListPendingSales(
      $grpc.ServiceCall call, $0.AdminListPendingSalesRequest request);

  $async.Future<$0.AdminGetSaleDetailResponse> adminGetSaleDetail_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminGetSaleDetailRequest> $request) async {
    return adminGetSaleDetail($call, await $request);
  }

  $async.Future<$0.AdminGetSaleDetailResponse> adminGetSaleDetail(
      $grpc.ServiceCall call, $0.AdminGetSaleDetailRequest request);

  $async.Future<$0.AdminApproveSaleResponse> adminApproveSale_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminApproveSaleRequest> $request) async {
    return adminApproveSale($call, await $request);
  }

  $async.Future<$0.AdminApproveSaleResponse> adminApproveSale(
      $grpc.ServiceCall call, $0.AdminApproveSaleRequest request);

  $async.Future<$0.AdminRejectSaleResponse> adminRejectSale_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminRejectSaleRequest> $request) async {
    return adminRejectSale($call, await $request);
  }

  $async.Future<$0.AdminRejectSaleResponse> adminRejectSale(
      $grpc.ServiceCall call, $0.AdminRejectSaleRequest request);

  $async.Future<$0.AdminListSellRatesResponse> adminListSellRates_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminListSellRatesRequest> $request) async {
    return adminListSellRates($call, await $request);
  }

  $async.Future<$0.AdminListSellRatesResponse> adminListSellRates(
      $grpc.ServiceCall call, $0.AdminListSellRatesRequest request);

  $async.Future<$0.AdminCreateSellRateResponse> adminCreateSellRate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminCreateSellRateRequest> $request) async {
    return adminCreateSellRate($call, await $request);
  }

  $async.Future<$0.AdminCreateSellRateResponse> adminCreateSellRate(
      $grpc.ServiceCall call, $0.AdminCreateSellRateRequest request);

  $async.Future<$0.AdminUpdateSellRateResponse> adminUpdateSellRate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminUpdateSellRateRequest> $request) async {
    return adminUpdateSellRate($call, await $request);
  }

  $async.Future<$0.AdminUpdateSellRateResponse> adminUpdateSellRate(
      $grpc.ServiceCall call, $0.AdminUpdateSellRateRequest request);

  $async.Future<$0.AdminToggleSellRateResponse> adminToggleSellRate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminToggleSellRateRequest> $request) async {
    return adminToggleSellRate($call, await $request);
  }

  $async.Future<$0.AdminToggleSellRateResponse> adminToggleSellRate(
      $grpc.ServiceCall call, $0.AdminToggleSellRateRequest request);

  $async.Future<$0.GetSupportedCountriesResponse> getSupportedCountries_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedCountriesRequest> $request) async {
    return getSupportedCountries($call, await $request);
  }

  $async.Future<$0.GetSupportedCountriesResponse> getSupportedCountries(
      $grpc.ServiceCall call, $0.GetSupportedCountriesRequest request);
}
