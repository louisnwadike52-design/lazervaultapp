// This is a generated file - do not edit.
//
// Generated from account.proto.

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

import 'account.pb.dart' as $0;

export 'account.pb.dart';

/// The AccountService provides methods for managing user accounts.
/// NOTE: This service is for card settings features. For dashboard accounts (GetUserAccounts),
/// use accounts.AccountsService from accounts.proto instead.
@$pb.GrpcServiceName('pb.AccountService')
class AccountServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AccountServiceClient(super.channel, {super.options, super.interceptors});

  /// Creates a new account for the authenticated user.
  $grpc.ResponseFuture<$0.CreateAccountResponse> createAccount(
    $0.CreateAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  /// Renamed from ListUserAccounts
  $grpc.ResponseFuture<$0.GetUserAccountsResponse> getUserAccounts(
    $0.GetUserAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountDetailsResponse> getAccountDetails(
    $0.GetAccountDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAccountStatusResponse> updateAccountStatus(
    $0.UpdateAccountStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateAccountStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSecuritySettingsResponse>
      updateSecuritySettings(
    $0.UpdateSecuritySettingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateSecuritySettings, request,
        options: options);
  }

  // method descriptors

  static final _$createAccount =
      $grpc.ClientMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
          '/pb.AccountService/CreateAccount',
          ($0.CreateAccountRequest value) => value.writeToBuffer(),
          $0.CreateAccountResponse.fromBuffer);
  static final _$getUserAccounts =
      $grpc.ClientMethod<$0.GetUserAccountsRequest, $0.GetUserAccountsResponse>(
          '/pb.AccountService/GetUserAccounts',
          ($0.GetUserAccountsRequest value) => value.writeToBuffer(),
          $0.GetUserAccountsResponse.fromBuffer);
  static final _$getAccountDetails = $grpc.ClientMethod<
          $0.GetAccountDetailsRequest, $0.GetAccountDetailsResponse>(
      '/pb.AccountService/GetAccountDetails',
      ($0.GetAccountDetailsRequest value) => value.writeToBuffer(),
      $0.GetAccountDetailsResponse.fromBuffer);
  static final _$updateAccountStatus = $grpc.ClientMethod<
          $0.UpdateAccountStatusRequest, $0.UpdateAccountStatusResponse>(
      '/pb.AccountService/UpdateAccountStatus',
      ($0.UpdateAccountStatusRequest value) => value.writeToBuffer(),
      $0.UpdateAccountStatusResponse.fromBuffer);
  static final _$updateSecuritySettings = $grpc.ClientMethod<
          $0.UpdateSecuritySettingsRequest, $0.UpdateSecuritySettingsResponse>(
      '/pb.AccountService/UpdateSecuritySettings',
      ($0.UpdateSecuritySettingsRequest value) => value.writeToBuffer(),
      $0.UpdateSecuritySettingsResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.AccountService')
abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AccountService';

  AccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
            'CreateAccount',
            createAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateAccountRequest.fromBuffer(value),
            ($0.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserAccountsRequest,
            $0.GetUserAccountsResponse>(
        'GetUserAccounts',
        getUserAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserAccountsRequest.fromBuffer(value),
        ($0.GetUserAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountDetailsRequest,
            $0.GetAccountDetailsResponse>(
        'GetAccountDetails',
        getAccountDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountDetailsRequest.fromBuffer(value),
        ($0.GetAccountDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAccountStatusRequest,
            $0.UpdateAccountStatusResponse>(
        'UpdateAccountStatus',
        updateAccountStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAccountStatusRequest.fromBuffer(value),
        ($0.UpdateAccountStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSecuritySettingsRequest,
            $0.UpdateSecuritySettingsResponse>(
        'UpdateSecuritySettings',
        updateSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateSecuritySettingsRequest.fromBuffer(value),
        ($0.UpdateSecuritySettingsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateAccountResponse> createAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateAccountRequest> $request) async {
    return createAccount($call, await $request);
  }

  $async.Future<$0.CreateAccountResponse> createAccount(
      $grpc.ServiceCall call, $0.CreateAccountRequest request);

  $async.Future<$0.GetUserAccountsResponse> getUserAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserAccountsRequest> $request) async {
    return getUserAccounts($call, await $request);
  }

  $async.Future<$0.GetUserAccountsResponse> getUserAccounts(
      $grpc.ServiceCall call, $0.GetUserAccountsRequest request);

  $async.Future<$0.GetAccountDetailsResponse> getAccountDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountDetailsRequest> $request) async {
    return getAccountDetails($call, await $request);
  }

  $async.Future<$0.GetAccountDetailsResponse> getAccountDetails(
      $grpc.ServiceCall call, $0.GetAccountDetailsRequest request);

  $async.Future<$0.UpdateAccountStatusResponse> updateAccountStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateAccountStatusRequest> $request) async {
    return updateAccountStatus($call, await $request);
  }

  $async.Future<$0.UpdateAccountStatusResponse> updateAccountStatus(
      $grpc.ServiceCall call, $0.UpdateAccountStatusRequest request);

  $async.Future<$0.UpdateSecuritySettingsResponse> updateSecuritySettings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateSecuritySettingsRequest> $request) async {
    return updateSecuritySettings($call, await $request);
  }

  $async.Future<$0.UpdateSecuritySettingsResponse> updateSecuritySettings(
      $grpc.ServiceCall call, $0.UpdateSecuritySettingsRequest request);
}
