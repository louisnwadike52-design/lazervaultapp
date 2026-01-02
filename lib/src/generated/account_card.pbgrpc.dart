///
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_card.pb.dart' as $0;
export 'account_card.pb.dart';

class AccountCardServiceClient extends $grpc.Client {
  static final _$createVirtualCard = $grpc.ClientMethod<
          $0.CreateVirtualCardRequest, $0.CreateVirtualCardResponse>(
      '/pb.AccountCardService/CreateVirtualCard',
      ($0.CreateVirtualCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateVirtualCardResponse.fromBuffer(value));
  static final _$createDisposableCard = $grpc.ClientMethod<
          $0.CreateDisposableCardRequest, $0.CreateDisposableCardResponse>(
      '/pb.AccountCardService/CreateDisposableCard',
      ($0.CreateDisposableCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateDisposableCardResponse.fromBuffer(value));
  static final _$getUserCards =
      $grpc.ClientMethod<$0.GetUserCardsRequest, $0.GetUserCardsResponse>(
          '/pb.AccountCardService/GetUserCards',
          ($0.GetUserCardsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetUserCardsResponse.fromBuffer(value));
  static final _$getCardDetails =
      $grpc.ClientMethod<$0.GetCardDetailsRequest, $0.GetCardDetailsResponse>(
          '/pb.AccountCardService/GetCardDetails',
          ($0.GetCardDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCardDetailsResponse.fromBuffer(value));
  static final _$freezeCard =
      $grpc.ClientMethod<$0.FreezeCardRequest, $0.FreezeCardResponse>(
          '/pb.AccountCardService/FreezeCard',
          ($0.FreezeCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FreezeCardResponse.fromBuffer(value));
  static final _$unfreezeCard =
      $grpc.ClientMethod<$0.UnfreezeCardRequest, $0.UnfreezeCardResponse>(
          '/pb.AccountCardService/UnfreezeCard',
          ($0.UnfreezeCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UnfreezeCardResponse.fromBuffer(value));
  static final _$cancelCard =
      $grpc.ClientMethod<$0.CancelCardRequest, $0.CancelCardResponse>(
          '/pb.AccountCardService/CancelCard',
          ($0.CancelCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelCardResponse.fromBuffer(value));
  static final _$updateCardNickname = $grpc.ClientMethod<
          $0.UpdateCardNicknameRequest, $0.UpdateCardNicknameResponse>(
      '/pb.AccountCardService/UpdateCardNickname',
      ($0.UpdateCardNicknameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateCardNicknameResponse.fromBuffer(value));
  static final _$updateCardSpendingLimit = $grpc.ClientMethod<
          $0.UpdateCardSpendingLimitRequest,
          $0.UpdateCardSpendingLimitResponse>(
      '/pb.AccountCardService/UpdateCardSpendingLimit',
      ($0.UpdateCardSpendingLimitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateCardSpendingLimitResponse.fromBuffer(value));
  static final _$getCardTransactions = $grpc.ClientMethod<
          $0.GetCardTransactionsRequest, $0.GetCardTransactionsResponse>(
      '/pb.AccountCardService/GetCardTransactions',
      ($0.GetCardTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCardTransactionsResponse.fromBuffer(value));
  static final _$setDefaultCard =
      $grpc.ClientMethod<$0.SetDefaultCardRequest, $0.SetDefaultCardResponse>(
          '/pb.AccountCardService/SetDefaultCard',
          ($0.SetDefaultCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SetDefaultCardResponse.fromBuffer(value));

  AccountCardServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateVirtualCardResponse> createVirtualCard(
      $0.CreateVirtualCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVirtualCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateDisposableCardResponse> createDisposableCard(
      $0.CreateDisposableCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDisposableCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCardsResponse> getUserCards(
      $0.GetUserCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCards, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCardDetailsResponse> getCardDetails(
      $0.GetCardDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCardDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.FreezeCardResponse> freezeCard(
      $0.FreezeCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnfreezeCardResponse> unfreezeCard(
      $0.UnfreezeCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelCardResponse> cancelCard(
      $0.CancelCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCardNicknameResponse> updateCardNickname(
      $0.UpdateCardNicknameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCardNickname, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCardSpendingLimitResponse>
      updateCardSpendingLimit($0.UpdateCardSpendingLimitRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCardSpendingLimit, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetCardTransactionsResponse> getCardTransactions(
      $0.GetCardTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCardTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetDefaultCardResponse> setDefaultCard(
      $0.SetDefaultCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setDefaultCard, request, options: options);
  }
}

abstract class AccountCardServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AccountCardService';

  AccountCardServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateVirtualCardRequest,
            $0.CreateVirtualCardResponse>(
        'CreateVirtualCard',
        createVirtualCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateVirtualCardRequest.fromBuffer(value),
        ($0.CreateVirtualCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateDisposableCardRequest,
            $0.CreateDisposableCardResponse>(
        'CreateDisposableCard',
        createDisposableCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateDisposableCardRequest.fromBuffer(value),
        ($0.CreateDisposableCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserCardsRequest, $0.GetUserCardsResponse>(
            'GetUserCards',
            getUserCards_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserCardsRequest.fromBuffer(value),
            ($0.GetUserCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCardDetailsRequest,
            $0.GetCardDetailsResponse>(
        'GetCardDetails',
        getCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCardDetailsRequest.fromBuffer(value),
        ($0.GetCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FreezeCardRequest, $0.FreezeCardResponse>(
        'FreezeCard',
        freezeCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FreezeCardRequest.fromBuffer(value),
        ($0.FreezeCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UnfreezeCardRequest, $0.UnfreezeCardResponse>(
            'UnfreezeCard',
            unfreezeCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UnfreezeCardRequest.fromBuffer(value),
            ($0.UnfreezeCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelCardRequest, $0.CancelCardResponse>(
        'CancelCard',
        cancelCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelCardRequest.fromBuffer(value),
        ($0.CancelCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCardNicknameRequest,
            $0.UpdateCardNicknameResponse>(
        'UpdateCardNickname',
        updateCardNickname_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCardNicknameRequest.fromBuffer(value),
        ($0.UpdateCardNicknameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCardSpendingLimitRequest,
            $0.UpdateCardSpendingLimitResponse>(
        'UpdateCardSpendingLimit',
        updateCardSpendingLimit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCardSpendingLimitRequest.fromBuffer(value),
        ($0.UpdateCardSpendingLimitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCardTransactionsRequest,
            $0.GetCardTransactionsResponse>(
        'GetCardTransactions',
        getCardTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCardTransactionsRequest.fromBuffer(value),
        ($0.GetCardTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetDefaultCardRequest,
            $0.SetDefaultCardResponse>(
        'SetDefaultCard',
        setDefaultCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetDefaultCardRequest.fromBuffer(value),
        ($0.SetDefaultCardResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateVirtualCardResponse> createVirtualCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateVirtualCardRequest> request) async {
    return createVirtualCard(call, await request);
  }

  $async.Future<$0.CreateDisposableCardResponse> createDisposableCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateDisposableCardRequest> request) async {
    return createDisposableCard(call, await request);
  }

  $async.Future<$0.GetUserCardsResponse> getUserCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserCardsRequest> request) async {
    return getUserCards(call, await request);
  }

  $async.Future<$0.GetCardDetailsResponse> getCardDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCardDetailsRequest> request) async {
    return getCardDetails(call, await request);
  }

  $async.Future<$0.FreezeCardResponse> freezeCard_Pre($grpc.ServiceCall call,
      $async.Future<$0.FreezeCardRequest> request) async {
    return freezeCard(call, await request);
  }

  $async.Future<$0.UnfreezeCardResponse> unfreezeCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UnfreezeCardRequest> request) async {
    return unfreezeCard(call, await request);
  }

  $async.Future<$0.CancelCardResponse> cancelCard_Pre($grpc.ServiceCall call,
      $async.Future<$0.CancelCardRequest> request) async {
    return cancelCard(call, await request);
  }

  $async.Future<$0.UpdateCardNicknameResponse> updateCardNickname_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateCardNicknameRequest> request) async {
    return updateCardNickname(call, await request);
  }

  $async.Future<$0.UpdateCardSpendingLimitResponse> updateCardSpendingLimit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateCardSpendingLimitRequest> request) async {
    return updateCardSpendingLimit(call, await request);
  }

  $async.Future<$0.GetCardTransactionsResponse> getCardTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCardTransactionsRequest> request) async {
    return getCardTransactions(call, await request);
  }

  $async.Future<$0.SetDefaultCardResponse> setDefaultCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetDefaultCardRequest> request) async {
    return setDefaultCard(call, await request);
  }

  $async.Future<$0.CreateVirtualCardResponse> createVirtualCard(
      $grpc.ServiceCall call, $0.CreateVirtualCardRequest request);
  $async.Future<$0.CreateDisposableCardResponse> createDisposableCard(
      $grpc.ServiceCall call, $0.CreateDisposableCardRequest request);
  $async.Future<$0.GetUserCardsResponse> getUserCards(
      $grpc.ServiceCall call, $0.GetUserCardsRequest request);
  $async.Future<$0.GetCardDetailsResponse> getCardDetails(
      $grpc.ServiceCall call, $0.GetCardDetailsRequest request);
  $async.Future<$0.FreezeCardResponse> freezeCard(
      $grpc.ServiceCall call, $0.FreezeCardRequest request);
  $async.Future<$0.UnfreezeCardResponse> unfreezeCard(
      $grpc.ServiceCall call, $0.UnfreezeCardRequest request);
  $async.Future<$0.CancelCardResponse> cancelCard(
      $grpc.ServiceCall call, $0.CancelCardRequest request);
  $async.Future<$0.UpdateCardNicknameResponse> updateCardNickname(
      $grpc.ServiceCall call, $0.UpdateCardNicknameRequest request);
  $async.Future<$0.UpdateCardSpendingLimitResponse> updateCardSpendingLimit(
      $grpc.ServiceCall call, $0.UpdateCardSpendingLimitRequest request);
  $async.Future<$0.GetCardTransactionsResponse> getCardTransactions(
      $grpc.ServiceCall call, $0.GetCardTransactionsRequest request);
  $async.Future<$0.SetDefaultCardResponse> setDefaultCard(
      $grpc.ServiceCall call, $0.SetDefaultCardRequest request);
}
