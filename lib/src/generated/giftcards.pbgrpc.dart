//
//  Generated code. Do not modify.
//  source: giftcards.proto
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

import 'giftcards.pb.dart' as $0;

export 'giftcards.pb.dart';

@$pb.GrpcServiceName('giftcards.GiftCardsService')
class GiftCardsServiceClient extends $grpc.Client {
  static final _$buyGiftCard = $grpc.ClientMethod<$0.BuyGiftCardRequest, $0.BuyGiftCardResponse>(
      '/giftcards.GiftCardsService/BuyGiftCard',
      ($0.BuyGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BuyGiftCardResponse.fromBuffer(value));
  static final _$redeemGiftCard = $grpc.ClientMethod<$0.RedeemGiftCardRequest, $0.RedeemGiftCardResponse>(
      '/giftcards.GiftCardsService/RedeemGiftCard',
      ($0.RedeemGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RedeemGiftCardResponse.fromBuffer(value));
  static final _$getGiftCards = $grpc.ClientMethod<$0.GetGiftCardsRequest, $0.GetGiftCardsResponse>(
      '/giftcards.GiftCardsService/GetGiftCards',
      ($0.GetGiftCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGiftCardsResponse.fromBuffer(value));
  static final _$getGiftCard = $grpc.ClientMethod<$0.GetGiftCardRequest, $0.GetGiftCardResponse>(
      '/giftcards.GiftCardsService/GetGiftCard',
      ($0.GetGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGiftCardResponse.fromBuffer(value));
  static final _$transferGiftCard = $grpc.ClientMethod<$0.TransferGiftCardRequest, $0.TransferGiftCardResponse>(
      '/giftcards.GiftCardsService/TransferGiftCard',
      ($0.TransferGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TransferGiftCardResponse.fromBuffer(value));
  static final _$getGiftCardBalance = $grpc.ClientMethod<$0.GetGiftCardBalanceRequest, $0.GetGiftCardBalanceResponse>(
      '/giftcards.GiftCardsService/GetGiftCardBalance',
      ($0.GetGiftCardBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGiftCardBalanceResponse.fromBuffer(value));
  static final _$getGiftCardBrands = $grpc.ClientMethod<$0.GetGiftCardBrandsRequest, $0.GetGiftCardBrandsResponse>(
      '/giftcards.GiftCardsService/GetGiftCardBrands',
      ($0.GetGiftCardBrandsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGiftCardBrandsResponse.fromBuffer(value));
  static final _$getGiftCardHistory = $grpc.ClientMethod<$0.GetGiftCardHistoryRequest, $0.GetGiftCardHistoryResponse>(
      '/giftcards.GiftCardsService/GetGiftCardHistory',
      ($0.GetGiftCardHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGiftCardHistoryResponse.fromBuffer(value));
  static final _$getSellableCards = $grpc.ClientMethod<$0.GetSellableCardsRequest, $0.GetSellableCardsResponse>(
      '/giftcards.GiftCardsService/GetSellableCards',
      ($0.GetSellableCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSellableCardsResponse.fromBuffer(value));
  static final _$getSellRate = $grpc.ClientMethod<$0.GetSellRateRequest, $0.GetSellRateResponse>(
      '/giftcards.GiftCardsService/GetSellRate',
      ($0.GetSellRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSellRateResponse.fromBuffer(value));
  static final _$sellGiftCard = $grpc.ClientMethod<$0.SellGiftCardRequest, $0.SellGiftCardResponse>(
      '/giftcards.GiftCardsService/SellGiftCard',
      ($0.SellGiftCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SellGiftCardResponse.fromBuffer(value));
  static final _$getSellStatus = $grpc.ClientMethod<$0.GetSellStatusRequest, $0.GetSellStatusResponse>(
      '/giftcards.GiftCardsService/GetSellStatus',
      ($0.GetSellStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSellStatusResponse.fromBuffer(value));
  static final _$getMySales = $grpc.ClientMethod<$0.GetMySalesRequest, $0.GetMySalesResponse>(
      '/giftcards.GiftCardsService/GetMySales',
      ($0.GetMySalesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMySalesResponse.fromBuffer(value));

  GiftCardsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.BuyGiftCardResponse> buyGiftCard($0.BuyGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.RedeemGiftCardResponse> redeemGiftCard($0.RedeemGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$redeemGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGiftCardsResponse> getGiftCards($0.GetGiftCardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCards, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGiftCardResponse> getGiftCard($0.GetGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransferGiftCardResponse> transferGiftCard($0.TransferGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGiftCardBalanceResponse> getGiftCardBalance($0.GetGiftCardBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGiftCardBrandsResponse> getGiftCardBrands($0.GetGiftCardBrandsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardBrands, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGiftCardHistoryResponse> getGiftCardHistory($0.GetGiftCardHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGiftCardHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSellableCardsResponse> getSellableCards($0.GetSellableCardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellableCards, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSellRateResponse> getSellRate($0.GetSellRateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellRate, request, options: options);
  }

  $grpc.ResponseFuture<$0.SellGiftCardResponse> sellGiftCard($0.SellGiftCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellGiftCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSellStatusResponse> getSellStatus($0.GetSellStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSellStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMySalesResponse> getMySales($0.GetMySalesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMySales, request, options: options);
  }
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
    $addMethod($grpc.ServiceMethod<$0.RedeemGiftCardRequest, $0.RedeemGiftCardResponse>(
        'RedeemGiftCard',
        redeemGiftCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RedeemGiftCardRequest.fromBuffer(value),
        ($0.RedeemGiftCardResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.GetGiftCardBalanceRequest, $0.GetGiftCardBalanceResponse>(
        'GetGiftCardBalance',
        getGiftCardBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGiftCardBalanceRequest.fromBuffer(value),
        ($0.GetGiftCardBalanceResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.GetSellRateRequest, $0.GetSellRateResponse>(
        'GetSellRate',
        getSellRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSellRateRequest.fromBuffer(value),
        ($0.GetSellRateResponse value) => value.writeToBuffer()));
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
  }

  $async.Future<$0.BuyGiftCardResponse> buyGiftCard_Pre($grpc.ServiceCall call, $async.Future<$0.BuyGiftCardRequest> request) async {
    return buyGiftCard(call, await request);
  }

  $async.Future<$0.RedeemGiftCardResponse> redeemGiftCard_Pre($grpc.ServiceCall call, $async.Future<$0.RedeemGiftCardRequest> request) async {
    return redeemGiftCard(call, await request);
  }

  $async.Future<$0.GetGiftCardsResponse> getGiftCards_Pre($grpc.ServiceCall call, $async.Future<$0.GetGiftCardsRequest> request) async {
    return getGiftCards(call, await request);
  }

  $async.Future<$0.GetGiftCardResponse> getGiftCard_Pre($grpc.ServiceCall call, $async.Future<$0.GetGiftCardRequest> request) async {
    return getGiftCard(call, await request);
  }

  $async.Future<$0.TransferGiftCardResponse> transferGiftCard_Pre($grpc.ServiceCall call, $async.Future<$0.TransferGiftCardRequest> request) async {
    return transferGiftCard(call, await request);
  }

  $async.Future<$0.GetGiftCardBalanceResponse> getGiftCardBalance_Pre($grpc.ServiceCall call, $async.Future<$0.GetGiftCardBalanceRequest> request) async {
    return getGiftCardBalance(call, await request);
  }

  $async.Future<$0.GetGiftCardBrandsResponse> getGiftCardBrands_Pre($grpc.ServiceCall call, $async.Future<$0.GetGiftCardBrandsRequest> request) async {
    return getGiftCardBrands(call, await request);
  }

  $async.Future<$0.GetGiftCardHistoryResponse> getGiftCardHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetGiftCardHistoryRequest> request) async {
    return getGiftCardHistory(call, await request);
  }

  $async.Future<$0.GetSellableCardsResponse> getSellableCards_Pre($grpc.ServiceCall call, $async.Future<$0.GetSellableCardsRequest> request) async {
    return getSellableCards(call, await request);
  }

  $async.Future<$0.GetSellRateResponse> getSellRate_Pre($grpc.ServiceCall call, $async.Future<$0.GetSellRateRequest> request) async {
    return getSellRate(call, await request);
  }

  $async.Future<$0.SellGiftCardResponse> sellGiftCard_Pre($grpc.ServiceCall call, $async.Future<$0.SellGiftCardRequest> request) async {
    return sellGiftCard(call, await request);
  }

  $async.Future<$0.GetSellStatusResponse> getSellStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetSellStatusRequest> request) async {
    return getSellStatus(call, await request);
  }

  $async.Future<$0.GetMySalesResponse> getMySales_Pre($grpc.ServiceCall call, $async.Future<$0.GetMySalesRequest> request) async {
    return getMySales(call, await request);
  }

  $async.Future<$0.BuyGiftCardResponse> buyGiftCard($grpc.ServiceCall call, $0.BuyGiftCardRequest request);
  $async.Future<$0.RedeemGiftCardResponse> redeemGiftCard($grpc.ServiceCall call, $0.RedeemGiftCardRequest request);
  $async.Future<$0.GetGiftCardsResponse> getGiftCards($grpc.ServiceCall call, $0.GetGiftCardsRequest request);
  $async.Future<$0.GetGiftCardResponse> getGiftCard($grpc.ServiceCall call, $0.GetGiftCardRequest request);
  $async.Future<$0.TransferGiftCardResponse> transferGiftCard($grpc.ServiceCall call, $0.TransferGiftCardRequest request);
  $async.Future<$0.GetGiftCardBalanceResponse> getGiftCardBalance($grpc.ServiceCall call, $0.GetGiftCardBalanceRequest request);
  $async.Future<$0.GetGiftCardBrandsResponse> getGiftCardBrands($grpc.ServiceCall call, $0.GetGiftCardBrandsRequest request);
  $async.Future<$0.GetGiftCardHistoryResponse> getGiftCardHistory($grpc.ServiceCall call, $0.GetGiftCardHistoryRequest request);
  $async.Future<$0.GetSellableCardsResponse> getSellableCards($grpc.ServiceCall call, $0.GetSellableCardsRequest request);
  $async.Future<$0.GetSellRateResponse> getSellRate($grpc.ServiceCall call, $0.GetSellRateRequest request);
  $async.Future<$0.SellGiftCardResponse> sellGiftCard($grpc.ServiceCall call, $0.SellGiftCardRequest request);
  $async.Future<$0.GetSellStatusResponse> getSellStatus($grpc.ServiceCall call, $0.GetSellStatusRequest request);
  $async.Future<$0.GetMySalesResponse> getMySales($grpc.ServiceCall call, $0.GetMySalesRequest request);
}
