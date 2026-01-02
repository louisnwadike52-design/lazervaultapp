///
//  Generated code. Do not modify.
//  source: giftcard.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'giftcard.pb.dart' as $16;
export 'giftcard.pb.dart';

class GiftCardServiceClient extends $grpc.Client {
  static final _$getBrands =
      $grpc.ClientMethod<$16.GetBrandsRequest, $16.GetBrandsResponse>(
          '/giftcard.GiftCardService/GetBrands',
          ($16.GetBrandsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.GetBrandsResponse.fromBuffer(value));
  static final _$getBrandById =
      $grpc.ClientMethod<$16.GetBrandByIdRequest, $16.GetBrandByIdResponse>(
          '/giftcard.GiftCardService/GetBrandById',
          ($16.GetBrandByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.GetBrandByIdResponse.fromBuffer(value));
  static final _$searchBrands =
      $grpc.ClientMethod<$16.SearchBrandsRequest, $16.SearchBrandsResponse>(
          '/giftcard.GiftCardService/SearchBrands',
          ($16.SearchBrandsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.SearchBrandsResponse.fromBuffer(value));
  static final _$getUserGiftCards = $grpc.ClientMethod<
          $16.GetUserGiftCardsRequest, $16.GetUserGiftCardsResponse>(
      '/giftcard.GiftCardService/GetUserGiftCards',
      ($16.GetUserGiftCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetUserGiftCardsResponse.fromBuffer(value));
  static final _$getGiftCardById = $grpc.ClientMethod<
          $16.GetGiftCardByIdRequest, $16.GetGiftCardByIdResponse>(
      '/giftcard.GiftCardService/GetGiftCardById',
      ($16.GetGiftCardByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetGiftCardByIdResponse.fromBuffer(value));
  static final _$purchaseGiftCard = $grpc.ClientMethod<
          $16.PurchaseGiftCardRequest, $16.PurchaseGiftCardResponse>(
      '/giftcard.GiftCardService/PurchaseGiftCard',
      ($16.PurchaseGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.PurchaseGiftCardResponse.fromBuffer(value));
  static final _$validatePurchase = $grpc.ClientMethod<
          $16.ValidatePurchaseRequest, $16.ValidatePurchaseResponse>(
      '/giftcard.GiftCardService/ValidatePurchase',
      ($16.ValidatePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ValidatePurchaseResponse.fromBuffer(value));
  static final _$validateCode =
      $grpc.ClientMethod<$16.ValidateCodeRequest, $16.ValidateCodeResponse>(
          '/giftcard.GiftCardService/ValidateCode',
          ($16.ValidateCodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.ValidateCodeResponse.fromBuffer(value));
  static final _$redeemGiftCard =
      $grpc.ClientMethod<$16.RedeemGiftCardRequest, $16.RedeemGiftCardResponse>(
          '/giftcard.GiftCardService/RedeemGiftCard',
          ($16.RedeemGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.RedeemGiftCardResponse.fromBuffer(value));
  static final _$checkBalance =
      $grpc.ClientMethod<$16.CheckBalanceRequest, $16.CheckBalanceResponse>(
          '/giftcard.GiftCardService/CheckBalance',
          ($16.CheckBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.CheckBalanceResponse.fromBuffer(value));
  static final _$transferGiftCard = $grpc.ClientMethod<
          $16.TransferGiftCardRequest, $16.TransferGiftCardResponse>(
      '/giftcard.GiftCardService/TransferGiftCard',
      ($16.TransferGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.TransferGiftCardResponse.fromBuffer(value));
  static final _$sellGiftCard =
      $grpc.ClientMethod<$16.SellGiftCardRequest, $16.SellGiftCardResponse>(
          '/giftcard.GiftCardService/SellGiftCard',
          ($16.SellGiftCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.SellGiftCardResponse.fromBuffer(value));
  static final _$getResellableCards = $grpc.ClientMethod<
          $16.GetResellableCardsRequest, $16.GetResellableCardsResponse>(
      '/giftcard.GiftCardService/GetResellableCards',
      ($16.GetResellableCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetResellableCardsResponse.fromBuffer(value));
  static final _$getTransactions = $grpc.ClientMethod<
          $16.GetTransactionsRequest, $16.GetTransactionsResponse>(
      '/giftcard.GiftCardService/GetTransactions',
      ($16.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetTransactionsResponse.fromBuffer(value));
  static final _$getTransactionById = $grpc.ClientMethod<
          $16.GetTransactionByIdRequest, $16.GetTransactionByIdResponse>(
      '/giftcard.GiftCardService/GetTransactionById',
      ($16.GetTransactionByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetTransactionByIdResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$16.GetStatisticsRequest, $16.GetStatisticsResponse>(
          '/giftcard.GiftCardService/GetStatistics',
          ($16.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.GetStatisticsResponse.fromBuffer(value));

  GiftCardServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$16.GetBrandsResponse> getBrands(
      $16.GetBrandsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBrands, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetBrandByIdResponse> getBrandById(
      $16.GetBrandByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBrandById, request, options: options);
  }

  $grpc.ResponseFuture<$16.SearchBrandsResponse> searchBrands(
      $16.SearchBrandsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchBrands, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetUserGiftCardsResponse> getUserGiftCards(
      $16.GetUserGiftCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserGiftCards, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetGiftCardByIdResponse> getGiftCardById(
      $16.GetGiftCardByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardById, request, options: options);
  }

  $grpc.ResponseFuture<$16.PurchaseGiftCardResponse> purchaseGiftCard(
      $16.PurchaseGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$16.ValidatePurchaseResponse> validatePurchase(
      $16.ValidatePurchaseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validatePurchase, request, options: options);
  }

  $grpc.ResponseFuture<$16.ValidateCodeResponse> validateCode(
      $16.ValidateCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCode, request, options: options);
  }

  $grpc.ResponseFuture<$16.RedeemGiftCardResponse> redeemGiftCard(
      $16.RedeemGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$redeemGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$16.CheckBalanceResponse> checkBalance(
      $16.CheckBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkBalance, request, options: options);
  }

  $grpc.ResponseFuture<$16.TransferGiftCardResponse> transferGiftCard(
      $16.TransferGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$16.SellGiftCardResponse> sellGiftCard(
      $16.SellGiftCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetResellableCardsResponse> getResellableCards(
      $16.GetResellableCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getResellableCards, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetTransactionsResponse> getTransactions(
      $16.GetTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetTransactionByIdResponse> getTransactionById(
      $16.GetTransactionByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionById, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetStatisticsResponse> getStatistics(
      $16.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }
}

abstract class GiftCardServiceBase extends $grpc.Service {
  $core.String get $name => 'giftcard.GiftCardService';

  GiftCardServiceBase() {
    $addMethod($grpc.ServiceMethod<$16.GetBrandsRequest, $16.GetBrandsResponse>(
        'GetBrands',
        getBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $16.GetBrandsRequest.fromBuffer(value),
        ($16.GetBrandsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.GetBrandByIdRequest, $16.GetBrandByIdResponse>(
            'GetBrandById',
            getBrandById_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.GetBrandByIdRequest.fromBuffer(value),
            ($16.GetBrandByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.SearchBrandsRequest, $16.SearchBrandsResponse>(
            'SearchBrands',
            searchBrands_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.SearchBrandsRequest.fromBuffer(value),
            ($16.SearchBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetUserGiftCardsRequest,
            $16.GetUserGiftCardsResponse>(
        'GetUserGiftCards',
        getUserGiftCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetUserGiftCardsRequest.fromBuffer(value),
        ($16.GetUserGiftCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetGiftCardByIdRequest,
            $16.GetGiftCardByIdResponse>(
        'GetGiftCardById',
        getGiftCardById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetGiftCardByIdRequest.fromBuffer(value),
        ($16.GetGiftCardByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.PurchaseGiftCardRequest,
            $16.PurchaseGiftCardResponse>(
        'PurchaseGiftCard',
        purchaseGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.PurchaseGiftCardRequest.fromBuffer(value),
        ($16.PurchaseGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ValidatePurchaseRequest,
            $16.ValidatePurchaseResponse>(
        'ValidatePurchase',
        validatePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ValidatePurchaseRequest.fromBuffer(value),
        ($16.ValidatePurchaseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.ValidateCodeRequest, $16.ValidateCodeResponse>(
            'ValidateCode',
            validateCode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.ValidateCodeRequest.fromBuffer(value),
            ($16.ValidateCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.RedeemGiftCardRequest,
            $16.RedeemGiftCardResponse>(
        'RedeemGiftCard',
        redeemGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.RedeemGiftCardRequest.fromBuffer(value),
        ($16.RedeemGiftCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.CheckBalanceRequest, $16.CheckBalanceResponse>(
            'CheckBalance',
            checkBalance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.CheckBalanceRequest.fromBuffer(value),
            ($16.CheckBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.TransferGiftCardRequest,
            $16.TransferGiftCardResponse>(
        'TransferGiftCard',
        transferGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.TransferGiftCardRequest.fromBuffer(value),
        ($16.TransferGiftCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.SellGiftCardRequest, $16.SellGiftCardResponse>(
            'SellGiftCard',
            sellGiftCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.SellGiftCardRequest.fromBuffer(value),
            ($16.SellGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetResellableCardsRequest,
            $16.GetResellableCardsResponse>(
        'GetResellableCards',
        getResellableCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetResellableCardsRequest.fromBuffer(value),
        ($16.GetResellableCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetTransactionsRequest,
            $16.GetTransactionsResponse>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetTransactionsRequest.fromBuffer(value),
        ($16.GetTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetTransactionByIdRequest,
            $16.GetTransactionByIdResponse>(
        'GetTransactionById',
        getTransactionById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetTransactionByIdRequest.fromBuffer(value),
        ($16.GetTransactionByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetStatisticsRequest,
            $16.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetStatisticsRequest.fromBuffer(value),
        ($16.GetStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$16.GetBrandsResponse> getBrands_Pre($grpc.ServiceCall call,
      $async.Future<$16.GetBrandsRequest> request) async {
    return getBrands(call, await request);
  }

  $async.Future<$16.GetBrandByIdResponse> getBrandById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetBrandByIdRequest> request) async {
    return getBrandById(call, await request);
  }

  $async.Future<$16.SearchBrandsResponse> searchBrands_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.SearchBrandsRequest> request) async {
    return searchBrands(call, await request);
  }

  $async.Future<$16.GetUserGiftCardsResponse> getUserGiftCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetUserGiftCardsRequest> request) async {
    return getUserGiftCards(call, await request);
  }

  $async.Future<$16.GetGiftCardByIdResponse> getGiftCardById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetGiftCardByIdRequest> request) async {
    return getGiftCardById(call, await request);
  }

  $async.Future<$16.PurchaseGiftCardResponse> purchaseGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.PurchaseGiftCardRequest> request) async {
    return purchaseGiftCard(call, await request);
  }

  $async.Future<$16.ValidatePurchaseResponse> validatePurchase_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ValidatePurchaseRequest> request) async {
    return validatePurchase(call, await request);
  }

  $async.Future<$16.ValidateCodeResponse> validateCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ValidateCodeRequest> request) async {
    return validateCode(call, await request);
  }

  $async.Future<$16.RedeemGiftCardResponse> redeemGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.RedeemGiftCardRequest> request) async {
    return redeemGiftCard(call, await request);
  }

  $async.Future<$16.CheckBalanceResponse> checkBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.CheckBalanceRequest> request) async {
    return checkBalance(call, await request);
  }

  $async.Future<$16.TransferGiftCardResponse> transferGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.TransferGiftCardRequest> request) async {
    return transferGiftCard(call, await request);
  }

  $async.Future<$16.SellGiftCardResponse> sellGiftCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.SellGiftCardRequest> request) async {
    return sellGiftCard(call, await request);
  }

  $async.Future<$16.GetResellableCardsResponse> getResellableCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetResellableCardsRequest> request) async {
    return getResellableCards(call, await request);
  }

  $async.Future<$16.GetTransactionsResponse> getTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetTransactionsRequest> request) async {
    return getTransactions(call, await request);
  }

  $async.Future<$16.GetTransactionByIdResponse> getTransactionById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetTransactionByIdRequest> request) async {
    return getTransactionById(call, await request);
  }

  $async.Future<$16.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$16.GetBrandsResponse> getBrands(
      $grpc.ServiceCall call, $16.GetBrandsRequest request);
  $async.Future<$16.GetBrandByIdResponse> getBrandById(
      $grpc.ServiceCall call, $16.GetBrandByIdRequest request);
  $async.Future<$16.SearchBrandsResponse> searchBrands(
      $grpc.ServiceCall call, $16.SearchBrandsRequest request);
  $async.Future<$16.GetUserGiftCardsResponse> getUserGiftCards(
      $grpc.ServiceCall call, $16.GetUserGiftCardsRequest request);
  $async.Future<$16.GetGiftCardByIdResponse> getGiftCardById(
      $grpc.ServiceCall call, $16.GetGiftCardByIdRequest request);
  $async.Future<$16.PurchaseGiftCardResponse> purchaseGiftCard(
      $grpc.ServiceCall call, $16.PurchaseGiftCardRequest request);
  $async.Future<$16.ValidatePurchaseResponse> validatePurchase(
      $grpc.ServiceCall call, $16.ValidatePurchaseRequest request);
  $async.Future<$16.ValidateCodeResponse> validateCode(
      $grpc.ServiceCall call, $16.ValidateCodeRequest request);
  $async.Future<$16.RedeemGiftCardResponse> redeemGiftCard(
      $grpc.ServiceCall call, $16.RedeemGiftCardRequest request);
  $async.Future<$16.CheckBalanceResponse> checkBalance(
      $grpc.ServiceCall call, $16.CheckBalanceRequest request);
  $async.Future<$16.TransferGiftCardResponse> transferGiftCard(
      $grpc.ServiceCall call, $16.TransferGiftCardRequest request);
  $async.Future<$16.SellGiftCardResponse> sellGiftCard(
      $grpc.ServiceCall call, $16.SellGiftCardRequest request);
  $async.Future<$16.GetResellableCardsResponse> getResellableCards(
      $grpc.ServiceCall call, $16.GetResellableCardsRequest request);
  $async.Future<$16.GetTransactionsResponse> getTransactions(
      $grpc.ServiceCall call, $16.GetTransactionsRequest request);
  $async.Future<$16.GetTransactionByIdResponse> getTransactionById(
      $grpc.ServiceCall call, $16.GetTransactionByIdRequest request);
  $async.Future<$16.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $16.GetStatisticsRequest request);
}
