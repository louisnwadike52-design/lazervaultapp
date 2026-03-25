// This is a generated file - do not edit.
//
// Generated from account_card.proto.

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

import 'account_card.pb.dart' as $0;

export 'account_card.pb.dart';

/// AccountCard Service Definition
@$pb.GrpcServiceName('pb.AccountCardService')
class AccountCardServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AccountCardServiceClient(super.channel, {super.options, super.interceptors});

  /// Create a new virtual card
  $grpc.ResponseFuture<$0.CreateVirtualCardResponse> createVirtualCard(
    $0.CreateVirtualCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createVirtualCard, request, options: options);
  }

  /// Create a new disposable card
  $grpc.ResponseFuture<$0.CreateDisposableCardResponse> createDisposableCard(
    $0.CreateDisposableCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createDisposableCard, request, options: options);
  }

  /// Get all cards for the authenticated user
  $grpc.ResponseFuture<$0.GetUserCardsResponse> getUserCards(
    $0.GetUserCardsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserCards, request, options: options);
  }

  /// Get detailed information about a specific card
  $grpc.ResponseFuture<$0.GetCardDetailsResponse> getCardDetails(
    $0.GetCardDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCardDetails, request, options: options);
  }

  /// Freeze a card
  $grpc.ResponseFuture<$0.FreezeCardResponse> freezeCard(
    $0.FreezeCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$freezeCard, request, options: options);
  }

  /// Unfreeze a card
  $grpc.ResponseFuture<$0.UnfreezeCardResponse> unfreezeCard(
    $0.UnfreezeCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unfreezeCard, request, options: options);
  }

  /// Cancel a card permanently
  $grpc.ResponseFuture<$0.CancelCardResponse> cancelCard(
    $0.CancelCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelCard, request, options: options);
  }

  /// Update card nickname
  $grpc.ResponseFuture<$0.UpdateCardNicknameResponse> updateCardNickname(
    $0.UpdateCardNicknameRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateCardNickname, request, options: options);
  }

  /// Update spending limit for disposable cards
  $grpc.ResponseFuture<$0.UpdateCardSpendingLimitResponse>
      updateCardSpendingLimit(
    $0.UpdateCardSpendingLimitRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateCardSpendingLimit, request,
        options: options);
  }

  /// Get card transactions
  $grpc.ResponseFuture<$0.GetCardTransactionsResponse> getCardTransactions(
    $0.GetCardTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCardTransactions, request, options: options);
  }

  /// Set default card
  $grpc.ResponseFuture<$0.SetDefaultCardResponse> setDefaultCard(
    $0.SetDefaultCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setDefaultCard, request, options: options);
  }

  /// Request a physical card
  $grpc.ResponseFuture<$0.RequestPhysicalCardResponse> requestPhysicalCard(
    $0.RequestPhysicalCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestPhysicalCard, request, options: options);
  }

  /// Set card PIN
  $grpc.ResponseFuture<$0.SetCardPINResponse> setCardPIN(
    $0.SetCardPINRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setCardPIN, request, options: options);
  }

  /// Reveal card PIN
  $grpc.ResponseFuture<$0.RevealCardPINResponse> revealCardPIN(
    $0.RevealCardPINRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$revealCardPIN, request, options: options);
  }

  /// Reveal full card details (number, CVV, PIN)
  $grpc.ResponseFuture<$0.RevealFullCardDetailsResponse> revealFullCardDetails(
    $0.RevealFullCardDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$revealFullCardDetails, request, options: options);
  }

  /// Fund a card
  $grpc.ResponseFuture<$0.FundCardResponse> fundCard(
    $0.FundCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$fundCard, request, options: options);
  }

  /// Withdraw from a card
  $grpc.ResponseFuture<$0.WithdrawFromCardResponse> withdrawFromCard(
    $0.WithdrawFromCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawFromCard, request, options: options);
  }

  // method descriptors

  static final _$createVirtualCard = $grpc.ClientMethod<
          $0.CreateVirtualCardRequest, $0.CreateVirtualCardResponse>(
      '/pb.AccountCardService/CreateVirtualCard',
      ($0.CreateVirtualCardRequest value) => value.writeToBuffer(),
      $0.CreateVirtualCardResponse.fromBuffer);
  static final _$createDisposableCard = $grpc.ClientMethod<
          $0.CreateDisposableCardRequest, $0.CreateDisposableCardResponse>(
      '/pb.AccountCardService/CreateDisposableCard',
      ($0.CreateDisposableCardRequest value) => value.writeToBuffer(),
      $0.CreateDisposableCardResponse.fromBuffer);
  static final _$getUserCards =
      $grpc.ClientMethod<$0.GetUserCardsRequest, $0.GetUserCardsResponse>(
          '/pb.AccountCardService/GetUserCards',
          ($0.GetUserCardsRequest value) => value.writeToBuffer(),
          $0.GetUserCardsResponse.fromBuffer);
  static final _$getCardDetails =
      $grpc.ClientMethod<$0.GetCardDetailsRequest, $0.GetCardDetailsResponse>(
          '/pb.AccountCardService/GetCardDetails',
          ($0.GetCardDetailsRequest value) => value.writeToBuffer(),
          $0.GetCardDetailsResponse.fromBuffer);
  static final _$freezeCard =
      $grpc.ClientMethod<$0.FreezeCardRequest, $0.FreezeCardResponse>(
          '/pb.AccountCardService/FreezeCard',
          ($0.FreezeCardRequest value) => value.writeToBuffer(),
          $0.FreezeCardResponse.fromBuffer);
  static final _$unfreezeCard =
      $grpc.ClientMethod<$0.UnfreezeCardRequest, $0.UnfreezeCardResponse>(
          '/pb.AccountCardService/UnfreezeCard',
          ($0.UnfreezeCardRequest value) => value.writeToBuffer(),
          $0.UnfreezeCardResponse.fromBuffer);
  static final _$cancelCard =
      $grpc.ClientMethod<$0.CancelCardRequest, $0.CancelCardResponse>(
          '/pb.AccountCardService/CancelCard',
          ($0.CancelCardRequest value) => value.writeToBuffer(),
          $0.CancelCardResponse.fromBuffer);
  static final _$updateCardNickname = $grpc.ClientMethod<
          $0.UpdateCardNicknameRequest, $0.UpdateCardNicknameResponse>(
      '/pb.AccountCardService/UpdateCardNickname',
      ($0.UpdateCardNicknameRequest value) => value.writeToBuffer(),
      $0.UpdateCardNicknameResponse.fromBuffer);
  static final _$updateCardSpendingLimit = $grpc.ClientMethod<
          $0.UpdateCardSpendingLimitRequest,
          $0.UpdateCardSpendingLimitResponse>(
      '/pb.AccountCardService/UpdateCardSpendingLimit',
      ($0.UpdateCardSpendingLimitRequest value) => value.writeToBuffer(),
      $0.UpdateCardSpendingLimitResponse.fromBuffer);
  static final _$getCardTransactions = $grpc.ClientMethod<
          $0.GetCardTransactionsRequest, $0.GetCardTransactionsResponse>(
      '/pb.AccountCardService/GetCardTransactions',
      ($0.GetCardTransactionsRequest value) => value.writeToBuffer(),
      $0.GetCardTransactionsResponse.fromBuffer);
  static final _$setDefaultCard =
      $grpc.ClientMethod<$0.SetDefaultCardRequest, $0.SetDefaultCardResponse>(
          '/pb.AccountCardService/SetDefaultCard',
          ($0.SetDefaultCardRequest value) => value.writeToBuffer(),
          $0.SetDefaultCardResponse.fromBuffer);
  static final _$requestPhysicalCard = $grpc.ClientMethod<
          $0.RequestPhysicalCardRequest, $0.RequestPhysicalCardResponse>(
      '/pb.AccountCardService/RequestPhysicalCard',
      ($0.RequestPhysicalCardRequest value) => value.writeToBuffer(),
      $0.RequestPhysicalCardResponse.fromBuffer);
  static final _$setCardPIN =
      $grpc.ClientMethod<$0.SetCardPINRequest, $0.SetCardPINResponse>(
          '/pb.AccountCardService/SetCardPIN',
          ($0.SetCardPINRequest value) => value.writeToBuffer(),
          $0.SetCardPINResponse.fromBuffer);
  static final _$revealCardPIN =
      $grpc.ClientMethod<$0.RevealCardPINRequest, $0.RevealCardPINResponse>(
          '/pb.AccountCardService/RevealCardPIN',
          ($0.RevealCardPINRequest value) => value.writeToBuffer(),
          $0.RevealCardPINResponse.fromBuffer);
  static final _$revealFullCardDetails = $grpc.ClientMethod<
          $0.RevealFullCardDetailsRequest, $0.RevealFullCardDetailsResponse>(
      '/pb.AccountCardService/RevealFullCardDetails',
      ($0.RevealFullCardDetailsRequest value) => value.writeToBuffer(),
      $0.RevealFullCardDetailsResponse.fromBuffer);
  static final _$fundCard =
      $grpc.ClientMethod<$0.FundCardRequest, $0.FundCardResponse>(
          '/pb.AccountCardService/FundCard',
          ($0.FundCardRequest value) => value.writeToBuffer(),
          $0.FundCardResponse.fromBuffer);
  static final _$withdrawFromCard = $grpc.ClientMethod<
          $0.WithdrawFromCardRequest, $0.WithdrawFromCardResponse>(
      '/pb.AccountCardService/WithdrawFromCard',
      ($0.WithdrawFromCardRequest value) => value.writeToBuffer(),
      $0.WithdrawFromCardResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.AccountCardService')
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
    $addMethod($grpc.ServiceMethod<$0.RequestPhysicalCardRequest,
            $0.RequestPhysicalCardResponse>(
        'RequestPhysicalCard',
        requestPhysicalCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestPhysicalCardRequest.fromBuffer(value),
        ($0.RequestPhysicalCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetCardPINRequest, $0.SetCardPINResponse>(
        'SetCardPIN',
        setCardPIN_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetCardPINRequest.fromBuffer(value),
        ($0.SetCardPINResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RevealCardPINRequest, $0.RevealCardPINResponse>(
            'RevealCardPIN',
            revealCardPIN_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RevealCardPINRequest.fromBuffer(value),
            ($0.RevealCardPINResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RevealFullCardDetailsRequest,
            $0.RevealFullCardDetailsResponse>(
        'RevealFullCardDetails',
        revealFullCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RevealFullCardDetailsRequest.fromBuffer(value),
        ($0.RevealFullCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FundCardRequest, $0.FundCardResponse>(
        'FundCard',
        fundCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FundCardRequest.fromBuffer(value),
        ($0.FundCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromCardRequest,
            $0.WithdrawFromCardResponse>(
        'WithdrawFromCard',
        withdrawFromCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawFromCardRequest.fromBuffer(value),
        ($0.WithdrawFromCardResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateVirtualCardResponse> createVirtualCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateVirtualCardRequest> $request) async {
    return createVirtualCard($call, await $request);
  }

  $async.Future<$0.CreateVirtualCardResponse> createVirtualCard(
      $grpc.ServiceCall call, $0.CreateVirtualCardRequest request);

  $async.Future<$0.CreateDisposableCardResponse> createDisposableCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateDisposableCardRequest> $request) async {
    return createDisposableCard($call, await $request);
  }

  $async.Future<$0.CreateDisposableCardResponse> createDisposableCard(
      $grpc.ServiceCall call, $0.CreateDisposableCardRequest request);

  $async.Future<$0.GetUserCardsResponse> getUserCards_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserCardsRequest> $request) async {
    return getUserCards($call, await $request);
  }

  $async.Future<$0.GetUserCardsResponse> getUserCards(
      $grpc.ServiceCall call, $0.GetUserCardsRequest request);

  $async.Future<$0.GetCardDetailsResponse> getCardDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetCardDetailsRequest> $request) async {
    return getCardDetails($call, await $request);
  }

  $async.Future<$0.GetCardDetailsResponse> getCardDetails(
      $grpc.ServiceCall call, $0.GetCardDetailsRequest request);

  $async.Future<$0.FreezeCardResponse> freezeCard_Pre($grpc.ServiceCall $call,
      $async.Future<$0.FreezeCardRequest> $request) async {
    return freezeCard($call, await $request);
  }

  $async.Future<$0.FreezeCardResponse> freezeCard(
      $grpc.ServiceCall call, $0.FreezeCardRequest request);

  $async.Future<$0.UnfreezeCardResponse> unfreezeCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UnfreezeCardRequest> $request) async {
    return unfreezeCard($call, await $request);
  }

  $async.Future<$0.UnfreezeCardResponse> unfreezeCard(
      $grpc.ServiceCall call, $0.UnfreezeCardRequest request);

  $async.Future<$0.CancelCardResponse> cancelCard_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CancelCardRequest> $request) async {
    return cancelCard($call, await $request);
  }

  $async.Future<$0.CancelCardResponse> cancelCard(
      $grpc.ServiceCall call, $0.CancelCardRequest request);

  $async.Future<$0.UpdateCardNicknameResponse> updateCardNickname_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateCardNicknameRequest> $request) async {
    return updateCardNickname($call, await $request);
  }

  $async.Future<$0.UpdateCardNicknameResponse> updateCardNickname(
      $grpc.ServiceCall call, $0.UpdateCardNicknameRequest request);

  $async.Future<$0.UpdateCardSpendingLimitResponse> updateCardSpendingLimit_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateCardSpendingLimitRequest> $request) async {
    return updateCardSpendingLimit($call, await $request);
  }

  $async.Future<$0.UpdateCardSpendingLimitResponse> updateCardSpendingLimit(
      $grpc.ServiceCall call, $0.UpdateCardSpendingLimitRequest request);

  $async.Future<$0.GetCardTransactionsResponse> getCardTransactions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetCardTransactionsRequest> $request) async {
    return getCardTransactions($call, await $request);
  }

  $async.Future<$0.GetCardTransactionsResponse> getCardTransactions(
      $grpc.ServiceCall call, $0.GetCardTransactionsRequest request);

  $async.Future<$0.SetDefaultCardResponse> setDefaultCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetDefaultCardRequest> $request) async {
    return setDefaultCard($call, await $request);
  }

  $async.Future<$0.SetDefaultCardResponse> setDefaultCard(
      $grpc.ServiceCall call, $0.SetDefaultCardRequest request);

  $async.Future<$0.RequestPhysicalCardResponse> requestPhysicalCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestPhysicalCardRequest> $request) async {
    return requestPhysicalCard($call, await $request);
  }

  $async.Future<$0.RequestPhysicalCardResponse> requestPhysicalCard(
      $grpc.ServiceCall call, $0.RequestPhysicalCardRequest request);

  $async.Future<$0.SetCardPINResponse> setCardPIN_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SetCardPINRequest> $request) async {
    return setCardPIN($call, await $request);
  }

  $async.Future<$0.SetCardPINResponse> setCardPIN(
      $grpc.ServiceCall call, $0.SetCardPINRequest request);

  $async.Future<$0.RevealCardPINResponse> revealCardPIN_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RevealCardPINRequest> $request) async {
    return revealCardPIN($call, await $request);
  }

  $async.Future<$0.RevealCardPINResponse> revealCardPIN(
      $grpc.ServiceCall call, $0.RevealCardPINRequest request);

  $async.Future<$0.RevealFullCardDetailsResponse> revealFullCardDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RevealFullCardDetailsRequest> $request) async {
    return revealFullCardDetails($call, await $request);
  }

  $async.Future<$0.RevealFullCardDetailsResponse> revealFullCardDetails(
      $grpc.ServiceCall call, $0.RevealFullCardDetailsRequest request);

  $async.Future<$0.FundCardResponse> fundCard_Pre($grpc.ServiceCall $call,
      $async.Future<$0.FundCardRequest> $request) async {
    return fundCard($call, await $request);
  }

  $async.Future<$0.FundCardResponse> fundCard(
      $grpc.ServiceCall call, $0.FundCardRequest request);

  $async.Future<$0.WithdrawFromCardResponse> withdrawFromCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.WithdrawFromCardRequest> $request) async {
    return withdrawFromCard($call, await $request);
  }

  $async.Future<$0.WithdrawFromCardResponse> withdrawFromCard(
      $grpc.ServiceCall call, $0.WithdrawFromCardRequest request);
}
