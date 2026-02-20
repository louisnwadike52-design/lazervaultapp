//
//  Generated code. Do not modify.
//  source: multi_country.proto
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

import 'multi_country.pb.dart' as $3;

export 'multi_country.pb.dart';

@$pb.GrpcServiceName('accounts.MultiCountryAccountService')
class MultiCountryAccountServiceClient extends $grpc.Client {
  static final _$getAccountsByLocale = $grpc.ClientMethod<$3.GetAccountsByLocaleRequest, $3.GetAccountsByLocaleResponse>(
      '/accounts.MultiCountryAccountService/GetAccountsByLocale',
      ($3.GetAccountsByLocaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetAccountsByLocaleResponse.fromBuffer(value));
  static final _$createLocaleAccount = $grpc.ClientMethod<$3.CreateLocaleAccountRequest, $3.CreateLocaleAccountResponse>(
      '/accounts.MultiCountryAccountService/CreateLocaleAccount',
      ($3.CreateLocaleAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.CreateLocaleAccountResponse.fromBuffer(value));
  static final _$getSupportedLocales = $grpc.ClientMethod<$3.GetSupportedLocalesRequest, $3.GetSupportedLocalesResponse>(
      '/accounts.MultiCountryAccountService/GetSupportedLocales',
      ($3.GetSupportedLocalesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetSupportedLocalesResponse.fromBuffer(value));
  static final _$getUserLocale = $grpc.ClientMethod<$3.GetUserLocaleRequest, $3.GetUserLocaleResponse>(
      '/accounts.MultiCountryAccountService/GetUserLocale',
      ($3.GetUserLocaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetUserLocaleResponse.fromBuffer(value));
  static final _$setUserLocale = $grpc.ClientMethod<$3.SetUserLocaleRequest, $3.SetUserLocaleResponse>(
      '/accounts.MultiCountryAccountService/SetUserLocale',
      ($3.SetUserLocaleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.SetUserLocaleResponse.fromBuffer(value));
  static final _$triggerMultiCountryCreation = $grpc.ClientMethod<$3.TriggerMultiCountryCreationRequest, $3.TriggerMultiCountryCreationResponse>(
      '/accounts.MultiCountryAccountService/TriggerMultiCountryCreation',
      ($3.TriggerMultiCountryCreationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.TriggerMultiCountryCreationResponse.fromBuffer(value));
  static final _$getAccountCreationStatus = $grpc.ClientMethod<$3.GetAccountCreationStatusRequest, $3.GetAccountCreationStatusResponse>(
      '/accounts.MultiCountryAccountService/GetAccountCreationStatus',
      ($3.GetAccountCreationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetAccountCreationStatusResponse.fromBuffer(value));

  MultiCountryAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$3.GetAccountsByLocaleResponse> getAccountsByLocale($3.GetAccountsByLocaleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountsByLocale, request, options: options);
  }

  $grpc.ResponseFuture<$3.CreateLocaleAccountResponse> createLocaleAccount($3.CreateLocaleAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLocaleAccount, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetSupportedLocalesResponse> getSupportedLocales($3.GetSupportedLocalesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedLocales, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetUserLocaleResponse> getUserLocale($3.GetUserLocaleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserLocale, request, options: options);
  }

  $grpc.ResponseFuture<$3.SetUserLocaleResponse> setUserLocale($3.SetUserLocaleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setUserLocale, request, options: options);
  }

  $grpc.ResponseFuture<$3.TriggerMultiCountryCreationResponse> triggerMultiCountryCreation($3.TriggerMultiCountryCreationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerMultiCountryCreation, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetAccountCreationStatusResponse> getAccountCreationStatus($3.GetAccountCreationStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountCreationStatus, request, options: options);
  }
}

@$pb.GrpcServiceName('accounts.MultiCountryAccountService')
abstract class MultiCountryAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.MultiCountryAccountService';

  MultiCountryAccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.GetAccountsByLocaleRequest, $3.GetAccountsByLocaleResponse>(
        'GetAccountsByLocale',
        getAccountsByLocale_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetAccountsByLocaleRequest.fromBuffer(value),
        ($3.GetAccountsByLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CreateLocaleAccountRequest, $3.CreateLocaleAccountResponse>(
        'CreateLocaleAccount',
        createLocaleAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.CreateLocaleAccountRequest.fromBuffer(value),
        ($3.CreateLocaleAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetSupportedLocalesRequest, $3.GetSupportedLocalesResponse>(
        'GetSupportedLocales',
        getSupportedLocales_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetSupportedLocalesRequest.fromBuffer(value),
        ($3.GetSupportedLocalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetUserLocaleRequest, $3.GetUserLocaleResponse>(
        'GetUserLocale',
        getUserLocale_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetUserLocaleRequest.fromBuffer(value),
        ($3.GetUserLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.SetUserLocaleRequest, $3.SetUserLocaleResponse>(
        'SetUserLocale',
        setUserLocale_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.SetUserLocaleRequest.fromBuffer(value),
        ($3.SetUserLocaleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.TriggerMultiCountryCreationRequest, $3.TriggerMultiCountryCreationResponse>(
        'TriggerMultiCountryCreation',
        triggerMultiCountryCreation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.TriggerMultiCountryCreationRequest.fromBuffer(value),
        ($3.TriggerMultiCountryCreationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetAccountCreationStatusRequest, $3.GetAccountCreationStatusResponse>(
        'GetAccountCreationStatus',
        getAccountCreationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetAccountCreationStatusRequest.fromBuffer(value),
        ($3.GetAccountCreationStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.GetAccountsByLocaleResponse> getAccountsByLocale_Pre($grpc.ServiceCall call, $async.Future<$3.GetAccountsByLocaleRequest> request) async {
    return getAccountsByLocale(call, await request);
  }

  $async.Future<$3.CreateLocaleAccountResponse> createLocaleAccount_Pre($grpc.ServiceCall call, $async.Future<$3.CreateLocaleAccountRequest> request) async {
    return createLocaleAccount(call, await request);
  }

  $async.Future<$3.GetSupportedLocalesResponse> getSupportedLocales_Pre($grpc.ServiceCall call, $async.Future<$3.GetSupportedLocalesRequest> request) async {
    return getSupportedLocales(call, await request);
  }

  $async.Future<$3.GetUserLocaleResponse> getUserLocale_Pre($grpc.ServiceCall call, $async.Future<$3.GetUserLocaleRequest> request) async {
    return getUserLocale(call, await request);
  }

  $async.Future<$3.SetUserLocaleResponse> setUserLocale_Pre($grpc.ServiceCall call, $async.Future<$3.SetUserLocaleRequest> request) async {
    return setUserLocale(call, await request);
  }

  $async.Future<$3.TriggerMultiCountryCreationResponse> triggerMultiCountryCreation_Pre($grpc.ServiceCall call, $async.Future<$3.TriggerMultiCountryCreationRequest> request) async {
    return triggerMultiCountryCreation(call, await request);
  }

  $async.Future<$3.GetAccountCreationStatusResponse> getAccountCreationStatus_Pre($grpc.ServiceCall call, $async.Future<$3.GetAccountCreationStatusRequest> request) async {
    return getAccountCreationStatus(call, await request);
  }

  $async.Future<$3.GetAccountsByLocaleResponse> getAccountsByLocale($grpc.ServiceCall call, $3.GetAccountsByLocaleRequest request);
  $async.Future<$3.CreateLocaleAccountResponse> createLocaleAccount($grpc.ServiceCall call, $3.CreateLocaleAccountRequest request);
  $async.Future<$3.GetSupportedLocalesResponse> getSupportedLocales($grpc.ServiceCall call, $3.GetSupportedLocalesRequest request);
  $async.Future<$3.GetUserLocaleResponse> getUserLocale($grpc.ServiceCall call, $3.GetUserLocaleRequest request);
  $async.Future<$3.SetUserLocaleResponse> setUserLocale($grpc.ServiceCall call, $3.SetUserLocaleRequest request);
  $async.Future<$3.TriggerMultiCountryCreationResponse> triggerMultiCountryCreation($grpc.ServiceCall call, $3.TriggerMultiCountryCreationRequest request);
  $async.Future<$3.GetAccountCreationStatusResponse> getAccountCreationStatus($grpc.ServiceCall call, $3.GetAccountCreationStatusRequest request);
}
