//
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'account_card.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;

export 'account_card.pb.dart';

@$pb.GrpcServiceName('pb.AccountCardService')
class AccountCardServiceClient extends $grpc.Client {
  static final _$addAccountCard = $grpc.ClientMethod<$0.AddAccountCardRequest, $0.AddAccountCardResponse>(
      '/pb.AccountCardService/AddAccountCard',
      ($0.AddAccountCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddAccountCardResponse.fromBuffer(value));
  static final _$getAccountCards = $grpc.ClientMethod<$0.GetAccountCardsRequest, $0.GetAccountCardsResponse>(
      '/pb.AccountCardService/GetAccountCards',
      ($0.GetAccountCardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAccountCardsResponse.fromBuffer(value));
  static final _$updateAccountCardDefaultStatus = $grpc.ClientMethod<$0.UpdateAccountCardDefaultStatusRequest, $0.UpdateAccountCardDefaultStatusResponse>(
      '/pb.AccountCardService/UpdateAccountCardDefaultStatus',
      ($0.UpdateAccountCardDefaultStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateAccountCardDefaultStatusResponse.fromBuffer(value));
  static final _$deleteAccountCard = $grpc.ClientMethod<$0.DeleteAccountCardRequest, $1.Empty>(
      '/pb.AccountCardService/DeleteAccountCard',
      ($0.DeleteAccountCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  AccountCardServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.AddAccountCardResponse> addAccountCard($0.AddAccountCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addAccountCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountCardsResponse> getAccountCards($0.GetAccountCardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountCards, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAccountCardDefaultStatusResponse> updateAccountCardDefaultStatus($0.UpdateAccountCardDefaultStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAccountCardDefaultStatus, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteAccountCard($0.DeleteAccountCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAccountCard, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.AccountCardService')
abstract class AccountCardServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AccountCardService';

  AccountCardServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AddAccountCardRequest, $0.AddAccountCardResponse>(
        'AddAccountCard',
        addAccountCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddAccountCardRequest.fromBuffer(value),
        ($0.AddAccountCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountCardsRequest, $0.GetAccountCardsResponse>(
        'GetAccountCards',
        getAccountCards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAccountCardsRequest.fromBuffer(value),
        ($0.GetAccountCardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAccountCardDefaultStatusRequest, $0.UpdateAccountCardDefaultStatusResponse>(
        'UpdateAccountCardDefaultStatus',
        updateAccountCardDefaultStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateAccountCardDefaultStatusRequest.fromBuffer(value),
        ($0.UpdateAccountCardDefaultStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAccountCardRequest, $1.Empty>(
        'DeleteAccountCard',
        deleteAccountCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteAccountCardRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.AddAccountCardResponse> addAccountCard_Pre($grpc.ServiceCall $call, $async.Future<$0.AddAccountCardRequest> $request) async {
    return addAccountCard($call, await $request);
  }

  $async.Future<$0.GetAccountCardsResponse> getAccountCards_Pre($grpc.ServiceCall $call, $async.Future<$0.GetAccountCardsRequest> $request) async {
    return getAccountCards($call, await $request);
  }

  $async.Future<$0.UpdateAccountCardDefaultStatusResponse> updateAccountCardDefaultStatus_Pre($grpc.ServiceCall $call, $async.Future<$0.UpdateAccountCardDefaultStatusRequest> $request) async {
    return updateAccountCardDefaultStatus($call, await $request);
  }

  $async.Future<$1.Empty> deleteAccountCard_Pre($grpc.ServiceCall $call, $async.Future<$0.DeleteAccountCardRequest> $request) async {
    return deleteAccountCard($call, await $request);
  }

  $async.Future<$0.AddAccountCardResponse> addAccountCard($grpc.ServiceCall call, $0.AddAccountCardRequest request);
  $async.Future<$0.GetAccountCardsResponse> getAccountCards($grpc.ServiceCall call, $0.GetAccountCardsRequest request);
  $async.Future<$0.UpdateAccountCardDefaultStatusResponse> updateAccountCardDefaultStatus($grpc.ServiceCall call, $0.UpdateAccountCardDefaultStatusRequest request);
  $async.Future<$1.Empty> deleteAccountCard($grpc.ServiceCall call, $0.DeleteAccountCardRequest request);
}
