///
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_card.pb.dart' as $1;
export 'account_card.pb.dart';

class AccountCardServiceClient extends $grpc.Client {
  static final _$createVirtualCard = $grpc.ClientMethod<
          $1.CreateVirtualCardRequest, $1.CreateVirtualCardResponse>(
      '/accounts.AccountCardService/CreateVirtualCard',
      ($1.CreateVirtualCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateVirtualCardResponse.fromBuffer(value));
  static final _$createDisposableCard = $grpc.ClientMethod<
          $1.CreateDisposableCardRequest, $1.CreateDisposableCardResponse>(
      '/accounts.AccountCardService/CreateDisposableCard',
      ($1.CreateDisposableCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateDisposableCardResponse.fromBuffer(value));
  static final _$getUserCards =
      $grpc.ClientMethod<$1.GetUserCardsRequest, $1.GetUserCardsResponse>(
          '/accounts.AccountCardService/GetUserCards',
          ($1.GetUserCardsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetUserCardsResponse.fromBuffer(value));
  static final _$getCardDetails =
      $grpc.ClientMethod<$1.GetCardDetailsRequest, $1.GetCardDetailsResponse>(
          '/accounts.AccountCardService/GetCardDetails',
          ($1.GetCardDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetCardDetailsResponse.fromBuffer(value));
  static final _$freezeCard =
      $grpc.ClientMethod<$1.FreezeCardRequest, $1.FreezeCardResponse>(
          '/accounts.AccountCardService/FreezeCard',
          ($1.FreezeCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.FreezeCardResponse.fromBuffer(value));
  static final _$unfreezeCard =
      $grpc.ClientMethod<$1.UnfreezeCardRequest, $1.UnfreezeCardResponse>(
          '/accounts.AccountCardService/UnfreezeCard',
          ($1.UnfreezeCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.UnfreezeCardResponse.fromBuffer(value));
  static final _$cancelCard =
      $grpc.ClientMethod<$1.CancelCardRequest, $1.CancelCardResponse>(
          '/accounts.AccountCardService/CancelCard',
          ($1.CancelCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CancelCardResponse.fromBuffer(value));
  static final _$updateCardNickname = $grpc.ClientMethod<
          $1.UpdateCardNicknameRequest, $1.UpdateCardNicknameResponse>(
      '/accounts.AccountCardService/UpdateCardNickname',
      ($1.UpdateCardNicknameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateCardNicknameResponse.fromBuffer(value));
  static final _$updateCardSpendingLimit = $grpc.ClientMethod<
          $1.UpdateCardSpendingLimitRequest,
          $1.UpdateCardSpendingLimitResponse>(
      '/accounts.AccountCardService/UpdateCardSpendingLimit',
      ($1.UpdateCardSpendingLimitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateCardSpendingLimitResponse.fromBuffer(value));
  static final _$getCardTransactions = $grpc.ClientMethod<
          $1.GetCardTransactionsRequest, $1.GetCardTransactionsResponse>(
      '/accounts.AccountCardService/GetCardTransactions',
      ($1.GetCardTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCardTransactionsResponse.fromBuffer(value));
  static final _$setDefaultCard =
      $grpc.ClientMethod<$1.SetDefaultCardRequest, $1.SetDefaultCardResponse>(
          '/accounts.AccountCardService/SetDefaultCard',
          ($1.SetDefaultCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SetDefaultCardResponse.fromBuffer(value));
  static final _$requestPhysicalCard = $grpc.ClientMethod<
          $1.RequestPhysicalCardRequest, $1.RequestPhysicalCardResponse>(
      '/accounts.AccountCardService/RequestPhysicalCard',
      ($1.RequestPhysicalCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RequestPhysicalCardResponse.fromBuffer(value));
  static final _$setCardPIN =
      $grpc.ClientMethod<$1.SetCardPINRequest, $1.SetCardPINResponse>(
          '/accounts.AccountCardService/SetCardPIN',
          ($1.SetCardPINRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SetCardPINResponse.fromBuffer(value));
  static final _$revealCardPIN =
      $grpc.ClientMethod<$1.RevealCardPINRequest, $1.RevealCardPINResponse>(
          '/accounts.AccountCardService/RevealCardPIN',
          ($1.RevealCardPINRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.RevealCardPINResponse.fromBuffer(value));
  static final _$revealFullCardDetails = $grpc.ClientMethod<
          $1.RevealFullCardDetailsRequest, $1.RevealFullCardDetailsResponse>(
      '/accounts.AccountCardService/RevealFullCardDetails',
      ($1.RevealFullCardDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RevealFullCardDetailsResponse.fromBuffer(value));
  static final _$fundCard =
      $grpc.ClientMethod<$1.FundCardRequest, $1.FundCardResponse>(
          '/accounts.AccountCardService/FundCard',
          ($1.FundCardRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.FundCardResponse.fromBuffer(value));
  static final _$withdrawFromCard = $grpc.ClientMethod<
          $1.WithdrawFromCardRequest, $1.WithdrawFromCardResponse>(
      '/accounts.AccountCardService/WithdrawFromCard',
      ($1.WithdrawFromCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.WithdrawFromCardResponse.fromBuffer(value));

  AccountCardServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.CreateVirtualCardResponse> createVirtualCard(
      $1.CreateVirtualCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVirtualCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.CreateDisposableCardResponse> createDisposableCard(
      $1.CreateDisposableCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDisposableCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserCardsResponse> getUserCards(
      $1.GetUserCardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCards, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCardDetailsResponse> getCardDetails(
      $1.GetCardDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCardDetails, request, options: options);
  }

  $grpc.ResponseFuture<$1.FreezeCardResponse> freezeCard(
      $1.FreezeCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.UnfreezeCardResponse> unfreezeCard(
      $1.UnfreezeCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.CancelCardResponse> cancelCard(
      $1.CancelCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateCardNicknameResponse> updateCardNickname(
      $1.UpdateCardNicknameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCardNickname, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateCardSpendingLimitResponse>
      updateCardSpendingLimit($1.UpdateCardSpendingLimitRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCardSpendingLimit, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetCardTransactionsResponse> getCardTransactions(
      $1.GetCardTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCardTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$1.SetDefaultCardResponse> setDefaultCard(
      $1.SetDefaultCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setDefaultCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.RequestPhysicalCardResponse> requestPhysicalCard(
      $1.RequestPhysicalCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPhysicalCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.SetCardPINResponse> setCardPIN(
      $1.SetCardPINRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setCardPIN, request, options: options);
  }

  $grpc.ResponseFuture<$1.RevealCardPINResponse> revealCardPIN(
      $1.RevealCardPINRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$revealCardPIN, request, options: options);
  }

  $grpc.ResponseFuture<$1.RevealFullCardDetailsResponse> revealFullCardDetails(
      $1.RevealFullCardDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$revealFullCardDetails, request, options: options);
  }

  $grpc.ResponseFuture<$1.FundCardResponse> fundCard($1.FundCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fundCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.WithdrawFromCardResponse> withdrawFromCard(
      $1.WithdrawFromCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCard, request, options: options);
  }
}

abstract class AccountCardServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.AccountCardService';

  AccountCardServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.CreateVirtualCardRequest,
            $1.CreateVirtualCardResponse>(
        'CreateVirtualCard',
        createVirtualCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateVirtualCardRequest.fromBuffer(value),
        ($1.CreateVirtualCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateDisposableCardRequest,
            $1.CreateDisposableCardResponse>(
        'CreateDisposableCard',
        createDisposableCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateDisposableCardRequest.fromBuffer(value),
        ($1.CreateDisposableCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetUserCardsRequest, $1.GetUserCardsResponse>(
            'GetUserCards',
            getUserCards_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetUserCardsRequest.fromBuffer(value),
            ($1.GetUserCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCardDetailsRequest,
            $1.GetCardDetailsResponse>(
        'GetCardDetails',
        getCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCardDetailsRequest.fromBuffer(value),
        ($1.GetCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FreezeCardRequest, $1.FreezeCardResponse>(
        'FreezeCard',
        freezeCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FreezeCardRequest.fromBuffer(value),
        ($1.FreezeCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.UnfreezeCardRequest, $1.UnfreezeCardResponse>(
            'UnfreezeCard',
            unfreezeCard_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.UnfreezeCardRequest.fromBuffer(value),
            ($1.UnfreezeCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CancelCardRequest, $1.CancelCardResponse>(
        'CancelCard',
        cancelCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CancelCardRequest.fromBuffer(value),
        ($1.CancelCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCardNicknameRequest,
            $1.UpdateCardNicknameResponse>(
        'UpdateCardNickname',
        updateCardNickname_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCardNicknameRequest.fromBuffer(value),
        ($1.UpdateCardNicknameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCardSpendingLimitRequest,
            $1.UpdateCardSpendingLimitResponse>(
        'UpdateCardSpendingLimit',
        updateCardSpendingLimit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCardSpendingLimitRequest.fromBuffer(value),
        ($1.UpdateCardSpendingLimitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCardTransactionsRequest,
            $1.GetCardTransactionsResponse>(
        'GetCardTransactions',
        getCardTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCardTransactionsRequest.fromBuffer(value),
        ($1.GetCardTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SetDefaultCardRequest,
            $1.SetDefaultCardResponse>(
        'SetDefaultCard',
        setDefaultCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SetDefaultCardRequest.fromBuffer(value),
        ($1.SetDefaultCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RequestPhysicalCardRequest,
            $1.RequestPhysicalCardResponse>(
        'RequestPhysicalCard',
        requestPhysicalCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RequestPhysicalCardRequest.fromBuffer(value),
        ($1.RequestPhysicalCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SetCardPINRequest, $1.SetCardPINResponse>(
        'SetCardPIN',
        setCardPIN_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SetCardPINRequest.fromBuffer(value),
        ($1.SetCardPINResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.RevealCardPINRequest, $1.RevealCardPINResponse>(
            'RevealCardPIN',
            revealCardPIN_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.RevealCardPINRequest.fromBuffer(value),
            ($1.RevealCardPINResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RevealFullCardDetailsRequest,
            $1.RevealFullCardDetailsResponse>(
        'RevealFullCardDetails',
        revealFullCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RevealFullCardDetailsRequest.fromBuffer(value),
        ($1.RevealFullCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FundCardRequest, $1.FundCardResponse>(
        'FundCard',
        fundCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FundCardRequest.fromBuffer(value),
        ($1.FundCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.WithdrawFromCardRequest,
            $1.WithdrawFromCardResponse>(
        'WithdrawFromCard',
        withdrawFromCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.WithdrawFromCardRequest.fromBuffer(value),
        ($1.WithdrawFromCardResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.CreateVirtualCardResponse> createVirtualCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateVirtualCardRequest> request) async {
    return createVirtualCard(call, await request);
  }

  $async.Future<$1.CreateDisposableCardResponse> createDisposableCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateDisposableCardRequest> request) async {
    return createDisposableCard(call, await request);
  }

  $async.Future<$1.GetUserCardsResponse> getUserCards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetUserCardsRequest> request) async {
    return getUserCards(call, await request);
  }

  $async.Future<$1.GetCardDetailsResponse> getCardDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCardDetailsRequest> request) async {
    return getCardDetails(call, await request);
  }

  $async.Future<$1.FreezeCardResponse> freezeCard_Pre($grpc.ServiceCall call,
      $async.Future<$1.FreezeCardRequest> request) async {
    return freezeCard(call, await request);
  }

  $async.Future<$1.UnfreezeCardResponse> unfreezeCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UnfreezeCardRequest> request) async {
    return unfreezeCard(call, await request);
  }

  $async.Future<$1.CancelCardResponse> cancelCard_Pre($grpc.ServiceCall call,
      $async.Future<$1.CancelCardRequest> request) async {
    return cancelCard(call, await request);
  }

  $async.Future<$1.UpdateCardNicknameResponse> updateCardNickname_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateCardNicknameRequest> request) async {
    return updateCardNickname(call, await request);
  }

  $async.Future<$1.UpdateCardSpendingLimitResponse> updateCardSpendingLimit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateCardSpendingLimitRequest> request) async {
    return updateCardSpendingLimit(call, await request);
  }

  $async.Future<$1.GetCardTransactionsResponse> getCardTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCardTransactionsRequest> request) async {
    return getCardTransactions(call, await request);
  }

  $async.Future<$1.SetDefaultCardResponse> setDefaultCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SetDefaultCardRequest> request) async {
    return setDefaultCard(call, await request);
  }

  $async.Future<$1.RequestPhysicalCardResponse> requestPhysicalCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RequestPhysicalCardRequest> request) async {
    return requestPhysicalCard(call, await request);
  }

  $async.Future<$1.SetCardPINResponse> setCardPIN_Pre($grpc.ServiceCall call,
      $async.Future<$1.SetCardPINRequest> request) async {
    return setCardPIN(call, await request);
  }

  $async.Future<$1.RevealCardPINResponse> revealCardPIN_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RevealCardPINRequest> request) async {
    return revealCardPIN(call, await request);
  }

  $async.Future<$1.RevealFullCardDetailsResponse> revealFullCardDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RevealFullCardDetailsRequest> request) async {
    return revealFullCardDetails(call, await request);
  }

  $async.Future<$1.FundCardResponse> fundCard_Pre(
      $grpc.ServiceCall call, $async.Future<$1.FundCardRequest> request) async {
    return fundCard(call, await request);
  }

  $async.Future<$1.WithdrawFromCardResponse> withdrawFromCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.WithdrawFromCardRequest> request) async {
    return withdrawFromCard(call, await request);
  }

  $async.Future<$1.CreateVirtualCardResponse> createVirtualCard(
      $grpc.ServiceCall call, $1.CreateVirtualCardRequest request);
  $async.Future<$1.CreateDisposableCardResponse> createDisposableCard(
      $grpc.ServiceCall call, $1.CreateDisposableCardRequest request);
  $async.Future<$1.GetUserCardsResponse> getUserCards(
      $grpc.ServiceCall call, $1.GetUserCardsRequest request);
  $async.Future<$1.GetCardDetailsResponse> getCardDetails(
      $grpc.ServiceCall call, $1.GetCardDetailsRequest request);
  $async.Future<$1.FreezeCardResponse> freezeCard(
      $grpc.ServiceCall call, $1.FreezeCardRequest request);
  $async.Future<$1.UnfreezeCardResponse> unfreezeCard(
      $grpc.ServiceCall call, $1.UnfreezeCardRequest request);
  $async.Future<$1.CancelCardResponse> cancelCard(
      $grpc.ServiceCall call, $1.CancelCardRequest request);
  $async.Future<$1.UpdateCardNicknameResponse> updateCardNickname(
      $grpc.ServiceCall call, $1.UpdateCardNicknameRequest request);
  $async.Future<$1.UpdateCardSpendingLimitResponse> updateCardSpendingLimit(
      $grpc.ServiceCall call, $1.UpdateCardSpendingLimitRequest request);
  $async.Future<$1.GetCardTransactionsResponse> getCardTransactions(
      $grpc.ServiceCall call, $1.GetCardTransactionsRequest request);
  $async.Future<$1.SetDefaultCardResponse> setDefaultCard(
      $grpc.ServiceCall call, $1.SetDefaultCardRequest request);
  $async.Future<$1.RequestPhysicalCardResponse> requestPhysicalCard(
      $grpc.ServiceCall call, $1.RequestPhysicalCardRequest request);
  $async.Future<$1.SetCardPINResponse> setCardPIN(
      $grpc.ServiceCall call, $1.SetCardPINRequest request);
  $async.Future<$1.RevealCardPINResponse> revealCardPIN(
      $grpc.ServiceCall call, $1.RevealCardPINRequest request);
  $async.Future<$1.RevealFullCardDetailsResponse> revealFullCardDetails(
      $grpc.ServiceCall call, $1.RevealFullCardDetailsRequest request);
  $async.Future<$1.FundCardResponse> fundCard(
      $grpc.ServiceCall call, $1.FundCardRequest request);
  $async.Future<$1.WithdrawFromCardResponse> withdrawFromCard(
      $grpc.ServiceCall call, $1.WithdrawFromCardRequest request);
}
