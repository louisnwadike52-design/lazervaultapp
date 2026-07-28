// This is a generated file - do not edit.
//
// Generated from multi_country.proto.

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

import 'multi_country.pb.dart' as $0;

export 'multi_country.pb.dart';

/// Multi-Country Account Management Service
/// Handles automatic creation of accounts in all supported countries after signup
@$pb.GrpcServiceName('accounts.MultiCountryAccountService')
class MultiCountryAccountServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MultiCountryAccountServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Get all accounts for a user grouped by country/locale
  $grpc.ResponseFuture<$0.GetAccountsByLocaleResponse> getAccountsByLocale(
    $0.GetAccountsByLocaleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountsByLocale, request, options: options);
  }

  /// Create account for a specific locale (manual creation by user)
  $grpc.ResponseFuture<$0.CreateLocaleAccountResponse> createLocaleAccount(
    $0.CreateLocaleAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createLocaleAccount, request, options: options);
  }

  /// Get supported locales for account creation
  $grpc.ResponseFuture<$0.GetSupportedLocalesResponse> getSupportedLocales(
    $0.GetSupportedLocalesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedLocales, request, options: options);
  }

  /// Get user's active locale (preference)
  $grpc.ResponseFuture<$0.GetUserLocaleResponse> getUserLocale(
    $0.GetUserLocaleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserLocale, request, options: options);
  }

  /// Set user's active locale (dashboard switching)
  $grpc.ResponseFuture<$0.SetUserLocaleResponse> setUserLocale(
    $0.SetUserLocaleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setUserLocale, request, options: options);
  }

  /// Trigger background account creation for all locales (internal)
  $grpc.ResponseFuture<$0.TriggerMultiCountryCreationResponse>
      triggerMultiCountryCreation(
    $0.TriggerMultiCountryCreationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$triggerMultiCountryCreation, request,
        options: options);
  }

  /// Get account creation status
  $grpc.ResponseFuture<$0.GetAccountCreationStatusResponse>
      getAccountCreationStatus(
    $0.GetAccountCreationStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountCreationStatus, request,
        options: options);
  }

  // method descriptors

  static final _$getAccountsByLocale = $grpc.ClientMethod<
          $0.GetAccountsByLocaleRequest, $0.GetAccountsByLocaleResponse>(
      '/accounts.MultiCountryAccountService/GetAccountsByLocale',
      ($0.GetAccountsByLocaleRequest value) => value.writeToBuffer(),
      $0.GetAccountsByLocaleResponse.fromBuffer);
  static final _$createLocaleAccount = $grpc.ClientMethod<
          $0.CreateLocaleAccountRequest, $0.CreateLocaleAccountResponse>(
      '/accounts.MultiCountryAccountService/CreateLocaleAccount',
      ($0.CreateLocaleAccountRequest value) => value.writeToBuffer(),
      $0.CreateLocaleAccountResponse.fromBuffer);
  static final _$getSupportedLocales = $grpc.ClientMethod<
          $0.GetSupportedLocalesRequest, $0.GetSupportedLocalesResponse>(
      '/accounts.MultiCountryAccountService/GetSupportedLocales',
      ($0.GetSupportedLocalesRequest value) => value.writeToBuffer(),
      $0.GetSupportedLocalesResponse.fromBuffer);
  static final _$getUserLocale =
      $grpc.ClientMethod<$0.GetUserLocaleRequest, $0.GetUserLocaleResponse>(
          '/accounts.MultiCountryAccountService/GetUserLocale',
          ($0.GetUserLocaleRequest value) => value.writeToBuffer(),
          $0.GetUserLocaleResponse.fromBuffer);
  static final _$setUserLocale =
      $grpc.ClientMethod<$0.SetUserLocaleRequest, $0.SetUserLocaleResponse>(
          '/accounts.MultiCountryAccountService/SetUserLocale',
          ($0.SetUserLocaleRequest value) => value.writeToBuffer(),
          $0.SetUserLocaleResponse.fromBuffer);
  static final _$triggerMultiCountryCreation = $grpc.ClientMethod<
          $0.TriggerMultiCountryCreationRequest,
          $0.TriggerMultiCountryCreationResponse>(
      '/accounts.MultiCountryAccountService/TriggerMultiCountryCreation',
      ($0.TriggerMultiCountryCreationRequest value) => value.writeToBuffer(),
      $0.TriggerMultiCountryCreationResponse.fromBuffer);
  static final _$getAccountCreationStatus = $grpc.ClientMethod<
          $0.GetAccountCreationStatusRequest,
          $0.GetAccountCreationStatusResponse>(
      '/accounts.MultiCountryAccountService/GetAccountCreationStatus',
      ($0.GetAccountCreationStatusRequest value) => value.writeToBuffer(),
      $0.GetAccountCreationStatusResponse.fromBuffer);
}

@$pb.GrpcServiceName('accounts.MultiCountryAccountService')
abstract class MultiCountryAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.MultiCountryAccountService';

  MultiCountryAccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetAccountsByLocaleRequest,
            $0.GetAccountsByLocaleResponse>(
        'GetAccountsByLocale',
        getAccountsByLocale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountsByLocaleRequest.fromBuffer(value),
        ($0.GetAccountsByLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateLocaleAccountRequest,
            $0.CreateLocaleAccountResponse>(
        'CreateLocaleAccount',
        createLocaleAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateLocaleAccountRequest.fromBuffer(value),
        ($0.CreateLocaleAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedLocalesRequest,
            $0.GetSupportedLocalesResponse>(
        'GetSupportedLocales',
        getSupportedLocales_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedLocalesRequest.fromBuffer(value),
        ($0.GetSupportedLocalesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserLocaleRequest, $0.GetUserLocaleResponse>(
            'GetUserLocale',
            getUserLocale_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserLocaleRequest.fromBuffer(value),
            ($0.GetUserLocaleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SetUserLocaleRequest, $0.SetUserLocaleResponse>(
            'SetUserLocale',
            setUserLocale_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SetUserLocaleRequest.fromBuffer(value),
            ($0.SetUserLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerMultiCountryCreationRequest,
            $0.TriggerMultiCountryCreationResponse>(
        'TriggerMultiCountryCreation',
        triggerMultiCountryCreation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TriggerMultiCountryCreationRequest.fromBuffer(value),
        ($0.TriggerMultiCountryCreationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountCreationStatusRequest,
            $0.GetAccountCreationStatusResponse>(
        'GetAccountCreationStatus',
        getAccountCreationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountCreationStatusRequest.fromBuffer(value),
        ($0.GetAccountCreationStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetAccountsByLocaleResponse> getAccountsByLocale_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountsByLocaleRequest> $request) async {
    return getAccountsByLocale($call, await $request);
  }

  $async.Future<$0.GetAccountsByLocaleResponse> getAccountsByLocale(
      $grpc.ServiceCall call, $0.GetAccountsByLocaleRequest request);

  $async.Future<$0.CreateLocaleAccountResponse> createLocaleAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateLocaleAccountRequest> $request) async {
    return createLocaleAccount($call, await $request);
  }

  $async.Future<$0.CreateLocaleAccountResponse> createLocaleAccount(
      $grpc.ServiceCall call, $0.CreateLocaleAccountRequest request);

  $async.Future<$0.GetSupportedLocalesResponse> getSupportedLocales_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedLocalesRequest> $request) async {
    return getSupportedLocales($call, await $request);
  }

  $async.Future<$0.GetSupportedLocalesResponse> getSupportedLocales(
      $grpc.ServiceCall call, $0.GetSupportedLocalesRequest request);

  $async.Future<$0.GetUserLocaleResponse> getUserLocale_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserLocaleRequest> $request) async {
    return getUserLocale($call, await $request);
  }

  $async.Future<$0.GetUserLocaleResponse> getUserLocale(
      $grpc.ServiceCall call, $0.GetUserLocaleRequest request);

  $async.Future<$0.SetUserLocaleResponse> setUserLocale_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetUserLocaleRequest> $request) async {
    return setUserLocale($call, await $request);
  }

  $async.Future<$0.SetUserLocaleResponse> setUserLocale(
      $grpc.ServiceCall call, $0.SetUserLocaleRequest request);

  $async.Future<$0.TriggerMultiCountryCreationResponse>
      triggerMultiCountryCreation_Pre($grpc.ServiceCall $call,
          $async.Future<$0.TriggerMultiCountryCreationRequest> $request) async {
    return triggerMultiCountryCreation($call, await $request);
  }

  $async.Future<$0.TriggerMultiCountryCreationResponse>
      triggerMultiCountryCreation($grpc.ServiceCall call,
          $0.TriggerMultiCountryCreationRequest request);

  $async.Future<$0.GetAccountCreationStatusResponse>
      getAccountCreationStatus_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetAccountCreationStatusRequest> $request) async {
    return getAccountCreationStatus($call, await $request);
  }

  $async.Future<$0.GetAccountCreationStatusResponse> getAccountCreationStatus(
      $grpc.ServiceCall call, $0.GetAccountCreationStatusRequest request);
}
