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
  static final _$transferGiftCard = $grpc.ClientMethod<
          $20.TransferGiftCardRequest, $20.TransferGiftCardResponse>(
      '/giftcards.GiftCardsService/TransferGiftCard',
      ($20.TransferGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.TransferGiftCardResponse.fromBuffer(value));
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
  static final _$getSellRate =
      $grpc.ClientMethod<$20.GetSellRateRequest, $20.GetSellRateResponse>(
          '/giftcards.GiftCardsService/GetSellRate',
          ($20.GetSellRateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetSellRateResponse.fromBuffer(value));
  static final _$getSellProvider = $grpc.ClientMethod<
          $20.GetSellProviderRequest, $20.GetSellProviderResponse>(
      '/giftcards.GiftCardsService/GetSellProvider',
      ($20.GetSellProviderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetSellProviderResponse.fromBuffer(value));
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
  static final _$adminRejectSale = $grpc.ClientMethod<
          $20.AdminRejectSaleRequest, $20.AdminRejectSaleResponse>(
      '/giftcards.GiftCardsService/AdminRejectSale',
      ($20.AdminRejectSaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AdminRejectSaleResponse.fromBuffer(value));
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

  $grpc.ResponseFuture<$20.TransferGiftCardResponse> transferGiftCard(
      $20.TransferGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferGiftCard, request, options: options);
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

  $grpc.ResponseFuture<$20.GetSellRateResponse> getSellRate(
      $20.GetSellRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSellProviderResponse> getSellProvider(
      $20.GetSellProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellProvider, request, options: options);
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

  $grpc.ResponseFuture<$20.AdminRejectSaleResponse> adminRejectSale(
      $20.AdminRejectSaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRejectSale, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$20.TransferGiftCardRequest,
            $20.TransferGiftCardResponse>(
        'TransferGiftCard',
        transferGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.TransferGiftCardRequest.fromBuffer(value),
        ($20.TransferGiftCardResponse value) => value.writeToBuffer()));
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
    $addMethod(
        $grpc.ServiceMethod<$20.GetSellRateRequest, $20.GetSellRateResponse>(
            'GetSellRate',
            getSellRate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetSellRateRequest.fromBuffer(value),
            ($20.GetSellRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSellProviderRequest,
            $20.GetSellProviderResponse>(
        'GetSellProvider',
        getSellProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSellProviderRequest.fromBuffer(value),
        ($20.GetSellProviderResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$20.AdminRejectSaleRequest,
            $20.AdminRejectSaleResponse>(
        'AdminRejectSale',
        adminRejectSale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AdminRejectSaleRequest.fromBuffer(value),
        ($20.AdminRejectSaleResponse value) => value.writeToBuffer()));
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

  $async.Future<$20.TransferGiftCardResponse> transferGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.TransferGiftCardRequest> request) async {
    return transferGiftCard(call, await request);
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

  $async.Future<$20.GetSellRateResponse> getSellRate_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetSellRateRequest> request) async {
    return getSellRate(call, await request);
  }

  $async.Future<$20.GetSellProviderResponse> getSellProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSellProviderRequest> request) async {
    return getSellProvider(call, await request);
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

  $async.Future<$20.AdminRejectSaleResponse> adminRejectSale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AdminRejectSaleRequest> request) async {
    return adminRejectSale(call, await request);
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

  $async.Future<$20.BuyGiftCardResponse> buyGiftCard(
      $grpc.ServiceCall call, $20.BuyGiftCardRequest request);
  $async.Future<$20.GetRedeemCodeResponse> getRedeemCode(
      $grpc.ServiceCall call, $20.GetRedeemCodeRequest request);
  $async.Future<$20.GetGiftCardsResponse> getGiftCards(
      $grpc.ServiceCall call, $20.GetGiftCardsRequest request);
  $async.Future<$20.GetGiftCardResponse> getGiftCard(
      $grpc.ServiceCall call, $20.GetGiftCardRequest request);
  $async.Future<$20.TransferGiftCardResponse> transferGiftCard(
      $grpc.ServiceCall call, $20.TransferGiftCardRequest request);
  $async.Future<$20.GetGiftCardBrandsResponse> getGiftCardBrands(
      $grpc.ServiceCall call, $20.GetGiftCardBrandsRequest request);
  $async.Future<$20.GetGiftCardHistoryResponse> getGiftCardHistory(
      $grpc.ServiceCall call, $20.GetGiftCardHistoryRequest request);
  $async.Future<$20.GetSellableCardsResponse> getSellableCards(
      $grpc.ServiceCall call, $20.GetSellableCardsRequest request);
  $async.Future<$20.GetSellRateResponse> getSellRate(
      $grpc.ServiceCall call, $20.GetSellRateRequest request);
  $async.Future<$20.GetSellProviderResponse> getSellProvider(
      $grpc.ServiceCall call, $20.GetSellProviderRequest request);
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
  $async.Future<$20.AdminGetSaleDetailResponse> adminGetSaleDetail(
      $grpc.ServiceCall call, $20.AdminGetSaleDetailRequest request);
  $async.Future<$20.AdminApproveSaleResponse> adminApproveSale(
      $grpc.ServiceCall call, $20.AdminApproveSaleRequest request);
  $async.Future<$20.AdminRejectSaleResponse> adminRejectSale(
      $grpc.ServiceCall call, $20.AdminRejectSaleRequest request);
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
}
