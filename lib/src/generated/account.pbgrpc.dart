//
//  Generated code. Do not modify.
//  source: account.proto
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

import 'account.pb.dart' as $2;

export 'account.pb.dart';

@$pb.GrpcServiceName('pb.AccountService')
class AccountServiceClient extends $grpc.Client {
  static final _$createAccount = $grpc.ClientMethod<$2.CreateAccountRequest, $2.CreateAccountResponse>(
      '/pb.AccountService/CreateAccount',
      ($2.CreateAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.CreateAccountResponse.fromBuffer(value));
  static final _$getUserAccounts = $grpc.ClientMethod<$2.GetUserAccountsRequest, $2.GetUserAccountsResponse>(
      '/pb.AccountService/GetUserAccounts',
      ($2.GetUserAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetUserAccountsResponse.fromBuffer(value));
  static final _$getAccountDetails = $grpc.ClientMethod<$2.GetAccountDetailsRequest, $2.GetAccountDetailsResponse>(
      '/pb.AccountService/GetAccountDetails',
      ($2.GetAccountDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetAccountDetailsResponse.fromBuffer(value));
  static final _$updateAccountStatus = $grpc.ClientMethod<$2.UpdateAccountStatusRequest, $2.UpdateAccountStatusResponse>(
      '/pb.AccountService/UpdateAccountStatus',
      ($2.UpdateAccountStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UpdateAccountStatusResponse.fromBuffer(value));
  static final _$updateSecuritySettings = $grpc.ClientMethod<$2.UpdateSecuritySettingsRequest, $2.UpdateSecuritySettingsResponse>(
      '/pb.AccountService/UpdateSecuritySettings',
      ($2.UpdateSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UpdateSecuritySettingsResponse.fromBuffer(value));

  AccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.CreateAccountResponse> createAccount($2.CreateAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetUserAccountsResponse> getUserAccounts($2.GetUserAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetAccountDetailsResponse> getAccountDetails($2.GetAccountDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountDetails, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateAccountStatusResponse> updateAccountStatus($2.UpdateAccountStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAccountStatus, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateSecuritySettingsResponse> updateSecuritySettings($2.UpdateSecuritySettingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSecuritySettings, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.AccountService')
abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AccountService';

  AccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateAccountRequest, $2.CreateAccountResponse>(
        'CreateAccount',
        createAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateAccountRequest.fromBuffer(value),
        ($2.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetUserAccountsRequest, $2.GetUserAccountsResponse>(
        'GetUserAccounts',
        getUserAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetUserAccountsRequest.fromBuffer(value),
        ($2.GetUserAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetAccountDetailsRequest, $2.GetAccountDetailsResponse>(
        'GetAccountDetails',
        getAccountDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetAccountDetailsRequest.fromBuffer(value),
        ($2.GetAccountDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateAccountStatusRequest, $2.UpdateAccountStatusResponse>(
        'UpdateAccountStatus',
        updateAccountStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpdateAccountStatusRequest.fromBuffer(value),
        ($2.UpdateAccountStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateSecuritySettingsRequest, $2.UpdateSecuritySettingsResponse>(
        'UpdateSecuritySettings',
        updateSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpdateSecuritySettingsRequest.fromBuffer(value),
        ($2.UpdateSecuritySettingsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.CreateAccountResponse> createAccount_Pre($grpc.ServiceCall $call, $async.Future<$2.CreateAccountRequest> $request) async {
    return createAccount($call, await $request);
  }

  $async.Future<$2.GetUserAccountsResponse> getUserAccounts_Pre($grpc.ServiceCall $call, $async.Future<$2.GetUserAccountsRequest> $request) async {
    return getUserAccounts($call, await $request);
  }

  $async.Future<$2.GetAccountDetailsResponse> getAccountDetails_Pre($grpc.ServiceCall $call, $async.Future<$2.GetAccountDetailsRequest> $request) async {
    return getAccountDetails($call, await $request);
  }

  $async.Future<$2.UpdateAccountStatusResponse> updateAccountStatus_Pre($grpc.ServiceCall $call, $async.Future<$2.UpdateAccountStatusRequest> $request) async {
    return updateAccountStatus($call, await $request);
  }

  $async.Future<$2.UpdateSecuritySettingsResponse> updateSecuritySettings_Pre($grpc.ServiceCall $call, $async.Future<$2.UpdateSecuritySettingsRequest> $request) async {
    return updateSecuritySettings($call, await $request);
  }

  $async.Future<$2.CreateAccountResponse> createAccount($grpc.ServiceCall call, $2.CreateAccountRequest request);
  $async.Future<$2.GetUserAccountsResponse> getUserAccounts($grpc.ServiceCall call, $2.GetUserAccountsRequest request);
  $async.Future<$2.GetAccountDetailsResponse> getAccountDetails($grpc.ServiceCall call, $2.GetAccountDetailsRequest request);
  $async.Future<$2.UpdateAccountStatusResponse> updateAccountStatus($grpc.ServiceCall call, $2.UpdateAccountStatusRequest request);
  $async.Future<$2.UpdateSecuritySettingsResponse> updateSecuritySettings($grpc.ServiceCall call, $2.UpdateSecuritySettingsRequest request);
}
