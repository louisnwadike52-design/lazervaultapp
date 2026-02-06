//
//  Generated code. Do not modify.
//  source: giftcard.proto
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

import 'giftcard.pb.dart' as $20;

export 'giftcard.pb.dart';

@$pb.GrpcServiceName('giftcard.GiftCardService')
class GiftCardServiceClient extends $grpc.Client {
  static final _$getBrands = $grpc.ClientMethod<$20.GetBrandsRequest, $20.GetBrandsResponse>(
      '/giftcard.GiftCardService/GetBrands',
      ($20.GetBrandsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetBrandsResponse.fromBuffer(value));
  static final _$getBrandById = $grpc.ClientMethod<$20.GetBrandByIdRequest, $20.GetBrandByIdResponse>(
      '/giftcard.GiftCardService/GetBrandById',
      ($20.GetBrandByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetBrandByIdResponse.fromBuffer(value));
  static final _$searchBrands = $grpc.ClientMethod<$20.SearchBrandsRequest, $20.SearchBrandsResponse>(
      '/giftcard.GiftCardService/SearchBrands',
      ($20.SearchBrandsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.SearchBrandsResponse.fromBuffer(value));
  static final _$getUserGiftCards = $grpc.ClientMethod<$20.GetUserGiftCardsRequest, $20.GetUserGiftCardsResponse>(
      '/giftcard.GiftCardService/GetUserGiftCards',
      ($20.GetUserGiftCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetUserGiftCardsResponse.fromBuffer(value));
  static final _$getGiftCardById = $grpc.ClientMethod<$20.GetGiftCardByIdRequest, $20.GetGiftCardByIdResponse>(
      '/giftcard.GiftCardService/GetGiftCardById',
      ($20.GetGiftCardByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetGiftCardByIdResponse.fromBuffer(value));
  static final _$purchaseGiftCard = $grpc.ClientMethod<$20.PurchaseGiftCardRequest, $20.PurchaseGiftCardResponse>(
      '/giftcard.GiftCardService/PurchaseGiftCard',
      ($20.PurchaseGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.PurchaseGiftCardResponse.fromBuffer(value));
  static final _$validatePurchase = $grpc.ClientMethod<$20.ValidatePurchaseRequest, $20.ValidatePurchaseResponse>(
      '/giftcard.GiftCardService/ValidatePurchase',
      ($20.ValidatePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.ValidatePurchaseResponse.fromBuffer(value));
  static final _$validateCode = $grpc.ClientMethod<$20.ValidateCodeRequest, $20.ValidateCodeResponse>(
      '/giftcard.GiftCardService/ValidateCode',
      ($20.ValidateCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.ValidateCodeResponse.fromBuffer(value));
  static final _$redeemGiftCard = $grpc.ClientMethod<$20.RedeemGiftCardRequest, $20.RedeemGiftCardResponse>(
      '/giftcard.GiftCardService/RedeemGiftCard',
      ($20.RedeemGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.RedeemGiftCardResponse.fromBuffer(value));
  static final _$checkBalance = $grpc.ClientMethod<$20.CheckBalanceRequest, $20.CheckBalanceResponse>(
      '/giftcard.GiftCardService/CheckBalance',
      ($20.CheckBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.CheckBalanceResponse.fromBuffer(value));
  static final _$transferGiftCard = $grpc.ClientMethod<$20.TransferGiftCardRequest, $20.TransferGiftCardResponse>(
      '/giftcard.GiftCardService/TransferGiftCard',
      ($20.TransferGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.TransferGiftCardResponse.fromBuffer(value));
  static final _$sellGiftCard = $grpc.ClientMethod<$20.SellGiftCardRequest, $20.SellGiftCardResponse>(
      '/giftcard.GiftCardService/SellGiftCard',
      ($20.SellGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.SellGiftCardResponse.fromBuffer(value));
  static final _$getResellableCards = $grpc.ClientMethod<$20.GetResellableCardsRequest, $20.GetResellableCardsResponse>(
      '/giftcard.GiftCardService/GetResellableCards',
      ($20.GetResellableCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetResellableCardsResponse.fromBuffer(value));
  static final _$getTransactions = $grpc.ClientMethod<$20.GetTransactionsRequest, $20.GetTransactionsResponse>(
      '/giftcard.GiftCardService/GetTransactions',
      ($20.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetTransactionsResponse.fromBuffer(value));
  static final _$getTransactionById = $grpc.ClientMethod<$20.GetTransactionByIdRequest, $20.GetTransactionByIdResponse>(
      '/giftcard.GiftCardService/GetTransactionById',
      ($20.GetTransactionByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetTransactionByIdResponse.fromBuffer(value));
  static final _$getStatistics = $grpc.ClientMethod<$20.GetStatisticsRequest, $20.GetStatisticsResponse>(
      '/giftcard.GiftCardService/GetStatistics',
      ($20.GetStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $20.GetStatisticsResponse.fromBuffer(value));

  GiftCardServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$20.GetBrandsResponse> getBrands($20.GetBrandsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBrands, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetBrandByIdResponse> getBrandById($20.GetBrandByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBrandById, request, options: options);
  }

  $grpc.ResponseFuture<$20.SearchBrandsResponse> searchBrands($20.SearchBrandsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchBrands, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetUserGiftCardsResponse> getUserGiftCards($20.GetUserGiftCardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserGiftCards, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetGiftCardByIdResponse> getGiftCardById($20.GetGiftCardByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardById, request, options: options);
  }

  $grpc.ResponseFuture<$20.PurchaseGiftCardResponse> purchaseGiftCard($20.PurchaseGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.ValidatePurchaseResponse> validatePurchase($20.ValidatePurchaseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validatePurchase, request, options: options);
  }

  $grpc.ResponseFuture<$20.ValidateCodeResponse> validateCode($20.ValidateCodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCode, request, options: options);
  }

  $grpc.ResponseFuture<$20.RedeemGiftCardResponse> redeemGiftCard($20.RedeemGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$redeemGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.CheckBalanceResponse> checkBalance($20.CheckBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkBalance, request, options: options);
  }

  $grpc.ResponseFuture<$20.TransferGiftCardResponse> transferGiftCard($20.TransferGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.SellGiftCardResponse> sellGiftCard($20.SellGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetResellableCardsResponse> getResellableCards($20.GetResellableCardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getResellableCards, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetTransactionsResponse> getTransactions($20.GetTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetTransactionByIdResponse> getTransactionById($20.GetTransactionByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionById, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetStatisticsResponse> getStatistics($20.GetStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }
}

@$pb.GrpcServiceName('giftcard.GiftCardService')
abstract class GiftCardServiceBase extends $grpc.Service {
  $core.String get $name => 'giftcard.GiftCardService';

  GiftCardServiceBase() {
    $addMethod($grpc.ServiceMethod<$20.GetBrandsRequest, $20.GetBrandsResponse>(
        'GetBrands',
        getBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetBrandsRequest.fromBuffer(value),
        ($20.GetBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetBrandByIdRequest, $20.GetBrandByIdResponse>(
        'GetBrandById',
        getBrandById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetBrandByIdRequest.fromBuffer(value),
        ($20.GetBrandByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.SearchBrandsRequest, $20.SearchBrandsResponse>(
        'SearchBrands',
        searchBrands_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.SearchBrandsRequest.fromBuffer(value),
        ($20.SearchBrandsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetUserGiftCardsRequest, $20.GetUserGiftCardsResponse>(
        'GetUserGiftCards',
        getUserGiftCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetUserGiftCardsRequest.fromBuffer(value),
        ($20.GetUserGiftCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetGiftCardByIdRequest, $20.GetGiftCardByIdResponse>(
        'GetGiftCardById',
        getGiftCardById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetGiftCardByIdRequest.fromBuffer(value),
        ($20.GetGiftCardByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.PurchaseGiftCardRequest, $20.PurchaseGiftCardResponse>(
        'PurchaseGiftCard',
        purchaseGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.PurchaseGiftCardRequest.fromBuffer(value),
        ($20.PurchaseGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ValidatePurchaseRequest, $20.ValidatePurchaseResponse>(
        'ValidatePurchase',
        validatePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.ValidatePurchaseRequest.fromBuffer(value),
        ($20.ValidatePurchaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ValidateCodeRequest, $20.ValidateCodeResponse>(
        'ValidateCode',
        validateCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.ValidateCodeRequest.fromBuffer(value),
        ($20.ValidateCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.RedeemGiftCardRequest, $20.RedeemGiftCardResponse>(
        'RedeemGiftCard',
        redeemGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.RedeemGiftCardRequest.fromBuffer(value),
        ($20.RedeemGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.CheckBalanceRequest, $20.CheckBalanceResponse>(
        'CheckBalance',
        checkBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.CheckBalanceRequest.fromBuffer(value),
        ($20.CheckBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.TransferGiftCardRequest, $20.TransferGiftCardResponse>(
        'TransferGiftCard',
        transferGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.TransferGiftCardRequest.fromBuffer(value),
        ($20.TransferGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.SellGiftCardRequest, $20.SellGiftCardResponse>(
        'SellGiftCard',
        sellGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.SellGiftCardRequest.fromBuffer(value),
        ($20.SellGiftCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetResellableCardsRequest, $20.GetResellableCardsResponse>(
        'GetResellableCards',
        getResellableCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetResellableCardsRequest.fromBuffer(value),
        ($20.GetResellableCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetTransactionsRequest, $20.GetTransactionsResponse>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetTransactionsRequest.fromBuffer(value),
        ($20.GetTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetTransactionByIdRequest, $20.GetTransactionByIdResponse>(
        'GetTransactionById',
        getTransactionById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetTransactionByIdRequest.fromBuffer(value),
        ($20.GetTransactionByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetStatisticsRequest, $20.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetStatisticsRequest.fromBuffer(value),
        ($20.GetStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$20.GetBrandsResponse> getBrands_Pre($grpc.ServiceCall call, $async.Future<$20.GetBrandsRequest> request) async {
    return getBrands(call, await request);
  }

  $async.Future<$20.GetBrandByIdResponse> getBrandById_Pre($grpc.ServiceCall call, $async.Future<$20.GetBrandByIdRequest> request) async {
    return getBrandById(call, await request);
  }

  $async.Future<$20.SearchBrandsResponse> searchBrands_Pre($grpc.ServiceCall call, $async.Future<$20.SearchBrandsRequest> request) async {
    return searchBrands(call, await request);
  }

  $async.Future<$20.GetUserGiftCardsResponse> getUserGiftCards_Pre($grpc.ServiceCall call, $async.Future<$20.GetUserGiftCardsRequest> request) async {
    return getUserGiftCards(call, await request);
  }

  $async.Future<$20.GetGiftCardByIdResponse> getGiftCardById_Pre($grpc.ServiceCall call, $async.Future<$20.GetGiftCardByIdRequest> request) async {
    return getGiftCardById(call, await request);
  }

  $async.Future<$20.PurchaseGiftCardResponse> purchaseGiftCard_Pre($grpc.ServiceCall call, $async.Future<$20.PurchaseGiftCardRequest> request) async {
    return purchaseGiftCard(call, await request);
  }

  $async.Future<$20.ValidatePurchaseResponse> validatePurchase_Pre($grpc.ServiceCall call, $async.Future<$20.ValidatePurchaseRequest> request) async {
    return validatePurchase(call, await request);
  }

  $async.Future<$20.ValidateCodeResponse> validateCode_Pre($grpc.ServiceCall call, $async.Future<$20.ValidateCodeRequest> request) async {
    return validateCode(call, await request);
  }

  $async.Future<$20.RedeemGiftCardResponse> redeemGiftCard_Pre($grpc.ServiceCall call, $async.Future<$20.RedeemGiftCardRequest> request) async {
    return redeemGiftCard(call, await request);
  }

  $async.Future<$20.CheckBalanceResponse> checkBalance_Pre($grpc.ServiceCall call, $async.Future<$20.CheckBalanceRequest> request) async {
    return checkBalance(call, await request);
  }

  $async.Future<$20.TransferGiftCardResponse> transferGiftCard_Pre($grpc.ServiceCall call, $async.Future<$20.TransferGiftCardRequest> request) async {
    return transferGiftCard(call, await request);
  }

  $async.Future<$20.SellGiftCardResponse> sellGiftCard_Pre($grpc.ServiceCall call, $async.Future<$20.SellGiftCardRequest> request) async {
    return sellGiftCard(call, await request);
  }

  $async.Future<$20.GetResellableCardsResponse> getResellableCards_Pre($grpc.ServiceCall call, $async.Future<$20.GetResellableCardsRequest> request) async {
    return getResellableCards(call, await request);
  }

  $async.Future<$20.GetTransactionsResponse> getTransactions_Pre($grpc.ServiceCall call, $async.Future<$20.GetTransactionsRequest> request) async {
    return getTransactions(call, await request);
  }

  $async.Future<$20.GetTransactionByIdResponse> getTransactionById_Pre($grpc.ServiceCall call, $async.Future<$20.GetTransactionByIdRequest> request) async {
    return getTransactionById(call, await request);
  }

  $async.Future<$20.GetStatisticsResponse> getStatistics_Pre($grpc.ServiceCall call, $async.Future<$20.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$20.GetBrandsResponse> getBrands($grpc.ServiceCall call, $20.GetBrandsRequest request);
  $async.Future<$20.GetBrandByIdResponse> getBrandById($grpc.ServiceCall call, $20.GetBrandByIdRequest request);
  $async.Future<$20.SearchBrandsResponse> searchBrands($grpc.ServiceCall call, $20.SearchBrandsRequest request);
  $async.Future<$20.GetUserGiftCardsResponse> getUserGiftCards($grpc.ServiceCall call, $20.GetUserGiftCardsRequest request);
  $async.Future<$20.GetGiftCardByIdResponse> getGiftCardById($grpc.ServiceCall call, $20.GetGiftCardByIdRequest request);
  $async.Future<$20.PurchaseGiftCardResponse> purchaseGiftCard($grpc.ServiceCall call, $20.PurchaseGiftCardRequest request);
  $async.Future<$20.ValidatePurchaseResponse> validatePurchase($grpc.ServiceCall call, $20.ValidatePurchaseRequest request);
  $async.Future<$20.ValidateCodeResponse> validateCode($grpc.ServiceCall call, $20.ValidateCodeRequest request);
  $async.Future<$20.RedeemGiftCardResponse> redeemGiftCard($grpc.ServiceCall call, $20.RedeemGiftCardRequest request);
  $async.Future<$20.CheckBalanceResponse> checkBalance($grpc.ServiceCall call, $20.CheckBalanceRequest request);
  $async.Future<$20.TransferGiftCardResponse> transferGiftCard($grpc.ServiceCall call, $20.TransferGiftCardRequest request);
  $async.Future<$20.SellGiftCardResponse> sellGiftCard($grpc.ServiceCall call, $20.SellGiftCardRequest request);
  $async.Future<$20.GetResellableCardsResponse> getResellableCards($grpc.ServiceCall call, $20.GetResellableCardsRequest request);
  $async.Future<$20.GetTransactionsResponse> getTransactions($grpc.ServiceCall call, $20.GetTransactionsRequest request);
  $async.Future<$20.GetTransactionByIdResponse> getTransactionById($grpc.ServiceCall call, $20.GetTransactionByIdRequest request);
  $async.Future<$20.GetStatisticsResponse> getStatistics($grpc.ServiceCall call, $20.GetStatisticsRequest request);
}
