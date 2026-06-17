///
//  Generated code. Do not modify.
//  source: multi_country.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'multi_country.pb.dart' as $1;
export 'multi_country.pb.dart';

class MultiCountryAccountServiceClient extends $grpc.Client {
  static final _$getAccountsByLocale = $grpc.ClientMethod<
          $1.GetAccountsByLocaleRequest, $1.GetAccountsByLocaleResponse>(
      '/accounts.MultiCountryAccountService/GetAccountsByLocale',
      ($1.GetAccountsByLocaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAccountsByLocaleResponse.fromBuffer(value));
  static final _$createLocaleAccount = $grpc.ClientMethod<
          $1.CreateLocaleAccountRequest, $1.CreateLocaleAccountResponse>(
      '/accounts.MultiCountryAccountService/CreateLocaleAccount',
      ($1.CreateLocaleAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateLocaleAccountResponse.fromBuffer(value));
  static final _$getSupportedLocales = $grpc.ClientMethod<
          $1.GetSupportedLocalesRequest, $1.GetSupportedLocalesResponse>(
      '/accounts.MultiCountryAccountService/GetSupportedLocales',
      ($1.GetSupportedLocalesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetSupportedLocalesResponse.fromBuffer(value));
  static final _$getUserLocale =
      $grpc.ClientMethod<$1.GetUserLocaleRequest, $1.GetUserLocaleResponse>(
          '/accounts.MultiCountryAccountService/GetUserLocale',
          ($1.GetUserLocaleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetUserLocaleResponse.fromBuffer(value));
  static final _$setUserLocale =
      $grpc.ClientMethod<$1.SetUserLocaleRequest, $1.SetUserLocaleResponse>(
          '/accounts.MultiCountryAccountService/SetUserLocale',
          ($1.SetUserLocaleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SetUserLocaleResponse.fromBuffer(value));
  static final _$triggerMultiCountryCreation = $grpc.ClientMethod<
          $1.TriggerMultiCountryCreationRequest,
          $1.TriggerMultiCountryCreationResponse>(
      '/accounts.MultiCountryAccountService/TriggerMultiCountryCreation',
      ($1.TriggerMultiCountryCreationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.TriggerMultiCountryCreationResponse.fromBuffer(value));
  static final _$getAccountCreationStatus = $grpc.ClientMethod<
          $1.GetAccountCreationStatusRequest,
          $1.GetAccountCreationStatusResponse>(
      '/accounts.MultiCountryAccountService/GetAccountCreationStatus',
      ($1.GetAccountCreationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAccountCreationStatusResponse.fromBuffer(value));

  MultiCountryAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.GetAccountsByLocaleResponse> getAccountsByLocale(
      $1.GetAccountsByLocaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountsByLocale, request, options: options);
  }

  $grpc.ResponseFuture<$1.CreateLocaleAccountResponse> createLocaleAccount(
      $1.CreateLocaleAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLocaleAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetSupportedLocalesResponse> getSupportedLocales(
      $1.GetSupportedLocalesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedLocales, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserLocaleResponse> getUserLocale(
      $1.GetUserLocaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserLocale, request, options: options);
  }

  $grpc.ResponseFuture<$1.SetUserLocaleResponse> setUserLocale(
      $1.SetUserLocaleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setUserLocale, request, options: options);
  }

  $grpc.ResponseFuture<$1.TriggerMultiCountryCreationResponse>
      triggerMultiCountryCreation($1.TriggerMultiCountryCreationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerMultiCountryCreation, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAccountCreationStatusResponse>
      getAccountCreationStatus($1.GetAccountCreationStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountCreationStatus, request,
        options: options);
  }
}

abstract class MultiCountryAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.MultiCountryAccountService';

  MultiCountryAccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetAccountsByLocaleRequest,
            $1.GetAccountsByLocaleResponse>(
        'GetAccountsByLocale',
        getAccountsByLocale_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAccountsByLocaleRequest.fromBuffer(value),
        ($1.GetAccountsByLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateLocaleAccountRequest,
            $1.CreateLocaleAccountResponse>(
        'CreateLocaleAccount',
        createLocaleAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateLocaleAccountRequest.fromBuffer(value),
        ($1.CreateLocaleAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetSupportedLocalesRequest,
            $1.GetSupportedLocalesResponse>(
        'GetSupportedLocales',
        getSupportedLocales_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetSupportedLocalesRequest.fromBuffer(value),
        ($1.GetSupportedLocalesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetUserLocaleRequest, $1.GetUserLocaleResponse>(
            'GetUserLocale',
            getUserLocale_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetUserLocaleRequest.fromBuffer(value),
            ($1.GetUserLocaleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.SetUserLocaleRequest, $1.SetUserLocaleResponse>(
            'SetUserLocale',
            setUserLocale_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.SetUserLocaleRequest.fromBuffer(value),
            ($1.SetUserLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.TriggerMultiCountryCreationRequest,
            $1.TriggerMultiCountryCreationResponse>(
        'TriggerMultiCountryCreation',
        triggerMultiCountryCreation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.TriggerMultiCountryCreationRequest.fromBuffer(value),
        ($1.TriggerMultiCountryCreationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAccountCreationStatusRequest,
            $1.GetAccountCreationStatusResponse>(
        'GetAccountCreationStatus',
        getAccountCreationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAccountCreationStatusRequest.fromBuffer(value),
        ($1.GetAccountCreationStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetAccountsByLocaleResponse> getAccountsByLocale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAccountsByLocaleRequest> request) async {
    return getAccountsByLocale(call, await request);
  }

  $async.Future<$1.CreateLocaleAccountResponse> createLocaleAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateLocaleAccountRequest> request) async {
    return createLocaleAccount(call, await request);
  }

  $async.Future<$1.GetSupportedLocalesResponse> getSupportedLocales_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetSupportedLocalesRequest> request) async {
    return getSupportedLocales(call, await request);
  }

  $async.Future<$1.GetUserLocaleResponse> getUserLocale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetUserLocaleRequest> request) async {
    return getUserLocale(call, await request);
  }

  $async.Future<$1.SetUserLocaleResponse> setUserLocale_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SetUserLocaleRequest> request) async {
    return setUserLocale(call, await request);
  }

  $async.Future<$1.TriggerMultiCountryCreationResponse>
      triggerMultiCountryCreation_Pre($grpc.ServiceCall call,
          $async.Future<$1.TriggerMultiCountryCreationRequest> request) async {
    return triggerMultiCountryCreation(call, await request);
  }

  $async.Future<$1.GetAccountCreationStatusResponse>
      getAccountCreationStatus_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetAccountCreationStatusRequest> request) async {
    return getAccountCreationStatus(call, await request);
  }

  $async.Future<$1.GetAccountsByLocaleResponse> getAccountsByLocale(
      $grpc.ServiceCall call, $1.GetAccountsByLocaleRequest request);
  $async.Future<$1.CreateLocaleAccountResponse> createLocaleAccount(
      $grpc.ServiceCall call, $1.CreateLocaleAccountRequest request);
  $async.Future<$1.GetSupportedLocalesResponse> getSupportedLocales(
      $grpc.ServiceCall call, $1.GetSupportedLocalesRequest request);
  $async.Future<$1.GetUserLocaleResponse> getUserLocale(
      $grpc.ServiceCall call, $1.GetUserLocaleRequest request);
  $async.Future<$1.SetUserLocaleResponse> setUserLocale(
      $grpc.ServiceCall call, $1.SetUserLocaleRequest request);
  $async.Future<$1.TriggerMultiCountryCreationResponse>
      triggerMultiCountryCreation($grpc.ServiceCall call,
          $1.TriggerMultiCountryCreationRequest request);
  $async.Future<$1.GetAccountCreationStatusResponse> getAccountCreationStatus(
      $grpc.ServiceCall call, $1.GetAccountCreationStatusRequest request);
}
