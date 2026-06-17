///
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'lock_funds.pb.dart' as $28;
export 'lock_funds.pb.dart';

class LockFundsServiceClient extends $grpc.Client {
  static final _$createLockFund =
      $grpc.ClientMethod<$28.CreateLockFundRequest, $28.CreateLockFundResponse>(
          '/pb.LockFundsService/CreateLockFund',
          ($28.CreateLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.CreateLockFundResponse.fromBuffer(value));
  static final _$getLockFunds =
      $grpc.ClientMethod<$28.GetLockFundsRequest, $28.GetLockFundsResponse>(
          '/pb.LockFundsService/GetLockFunds',
          ($28.GetLockFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.GetLockFundsResponse.fromBuffer(value));
  static final _$getLockFund =
      $grpc.ClientMethod<$28.GetLockFundRequest, $28.GetLockFundResponse>(
          '/pb.LockFundsService/GetLockFund',
          ($28.GetLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.GetLockFundResponse.fromBuffer(value));
  static final _$unlockFund =
      $grpc.ClientMethod<$28.UnlockFundRequest, $28.UnlockFundResponse>(
          '/pb.LockFundsService/UnlockFund',
          ($28.UnlockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.UnlockFundResponse.fromBuffer(value));
  static final _$topUpLockFund =
      $grpc.ClientMethod<$28.TopUpLockFundRequest, $28.TopUpLockFundResponse>(
          '/pb.LockFundsService/TopUpLockFund',
          ($28.TopUpLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.TopUpLockFundResponse.fromBuffer(value));
  static final _$getLockTransactions = $grpc.ClientMethod<
          $28.GetLockTransactionsRequest, $28.GetLockTransactionsResponse>(
      '/pb.LockFundsService/GetLockTransactions',
      ($28.GetLockTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetLockTransactionsResponse.fromBuffer(value));
  static final _$calculateInterest = $grpc.ClientMethod<
          $28.CalculateInterestRequest, $28.CalculateInterestResponse>(
      '/pb.LockFundsService/CalculateInterest',
      ($28.CalculateInterestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.CalculateInterestResponse.fromBuffer(value));
  static final _$renewLockFund =
      $grpc.ClientMethod<$28.RenewLockFundRequest, $28.RenewLockFundResponse>(
          '/pb.LockFundsService/RenewLockFund',
          ($28.RenewLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.RenewLockFundResponse.fromBuffer(value));
  static final _$cancelLockFund =
      $grpc.ClientMethod<$28.CancelLockFundRequest, $28.CancelLockFundResponse>(
          '/pb.LockFundsService/CancelLockFund',
          ($28.CancelLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.CancelLockFundResponse.fromBuffer(value));
  static final _$getPiggyVaultConfigs = $grpc.ClientMethod<
          $28.GetPiggyVaultConfigsRequest, $28.GetPiggyVaultConfigsResponse>(
      '/pb.LockFundsService/GetPiggyVaultConfigs',
      ($28.GetPiggyVaultConfigsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetPiggyVaultConfigsResponse.fromBuffer(value));
  static final _$createLockFundAutoSave = $grpc.ClientMethod<
          $28.CreateLockFundAutoSaveRequest,
          $28.CreateLockFundAutoSaveResponse>(
      '/pb.LockFundsService/CreateLockFundAutoSave',
      ($28.CreateLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.CreateLockFundAutoSaveResponse.fromBuffer(value));
  static final _$getLockFundAutoSave = $grpc.ClientMethod<
          $28.GetLockFundAutoSaveRequest, $28.GetLockFundAutoSaveResponse>(
      '/pb.LockFundsService/GetLockFundAutoSave',
      ($28.GetLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetLockFundAutoSaveResponse.fromBuffer(value));
  static final _$updateLockFundAutoSave = $grpc.ClientMethod<
          $28.UpdateLockFundAutoSaveRequest,
          $28.UpdateLockFundAutoSaveResponse>(
      '/pb.LockFundsService/UpdateLockFundAutoSave',
      ($28.UpdateLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.UpdateLockFundAutoSaveResponse.fromBuffer(value));
  static final _$deleteLockFundAutoSave = $grpc.ClientMethod<
          $28.DeleteLockFundAutoSaveRequest,
          $28.DeleteLockFundAutoSaveResponse>(
      '/pb.LockFundsService/DeleteLockFundAutoSave',
      ($28.DeleteLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.DeleteLockFundAutoSaveResponse.fromBuffer(value));

  LockFundsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$28.CreateLockFundResponse> createLockFund(
      $28.CreateLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetLockFundsResponse> getLockFunds(
      $28.GetLockFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetLockFundResponse> getLockFund(
      $28.GetLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$28.UnlockFundResponse> unlockFund(
      $28.UnlockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFund, request, options: options);
  }

  $grpc.ResponseFuture<$28.TopUpLockFundResponse> topUpLockFund(
      $28.TopUpLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$topUpLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetLockTransactionsResponse> getLockTransactions(
      $28.GetLockTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$28.CalculateInterestResponse> calculateInterest(
      $28.CalculateInterestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateInterest, request, options: options);
  }

  $grpc.ResponseFuture<$28.RenewLockFundResponse> renewLockFund(
      $28.RenewLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renewLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$28.CancelLockFundResponse> cancelLockFund(
      $28.CancelLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetPiggyVaultConfigsResponse> getPiggyVaultConfigs(
      $28.GetPiggyVaultConfigsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPiggyVaultConfigs, request, options: options);
  }

  $grpc.ResponseFuture<$28.CreateLockFundAutoSaveResponse>
      createLockFundAutoSave($28.CreateLockFundAutoSaveRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFundAutoSave, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetLockFundAutoSaveResponse> getLockFundAutoSave(
      $28.GetLockFundAutoSaveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFundAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$28.UpdateLockFundAutoSaveResponse>
      updateLockFundAutoSave($28.UpdateLockFundAutoSaveRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLockFundAutoSave, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.DeleteLockFundAutoSaveResponse>
      deleteLockFundAutoSave($28.DeleteLockFundAutoSaveRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLockFundAutoSave, request,
        options: options);
  }
}

abstract class LockFundsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.LockFundsService';

  LockFundsServiceBase() {
    $addMethod($grpc.ServiceMethod<$28.CreateLockFundRequest,
            $28.CreateLockFundResponse>(
        'CreateLockFund',
        createLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CreateLockFundRequest.fromBuffer(value),
        ($28.CreateLockFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.GetLockFundsRequest, $28.GetLockFundsResponse>(
            'GetLockFunds',
            getLockFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.GetLockFundsRequest.fromBuffer(value),
            ($28.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.GetLockFundRequest, $28.GetLockFundResponse>(
            'GetLockFund',
            getLockFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.GetLockFundRequest.fromBuffer(value),
            ($28.GetLockFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.UnlockFundRequest, $28.UnlockFundResponse>(
            'UnlockFund',
            unlockFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.UnlockFundRequest.fromBuffer(value),
            ($28.UnlockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.TopUpLockFundRequest,
            $28.TopUpLockFundResponse>(
        'TopUpLockFund',
        topUpLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.TopUpLockFundRequest.fromBuffer(value),
        ($28.TopUpLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetLockTransactionsRequest,
            $28.GetLockTransactionsResponse>(
        'GetLockTransactions',
        getLockTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetLockTransactionsRequest.fromBuffer(value),
        ($28.GetLockTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.CalculateInterestRequest,
            $28.CalculateInterestResponse>(
        'CalculateInterest',
        calculateInterest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CalculateInterestRequest.fromBuffer(value),
        ($28.CalculateInterestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.RenewLockFundRequest,
            $28.RenewLockFundResponse>(
        'RenewLockFund',
        renewLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.RenewLockFundRequest.fromBuffer(value),
        ($28.RenewLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.CancelLockFundRequest,
            $28.CancelLockFundResponse>(
        'CancelLockFund',
        cancelLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CancelLockFundRequest.fromBuffer(value),
        ($28.CancelLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetPiggyVaultConfigsRequest,
            $28.GetPiggyVaultConfigsResponse>(
        'GetPiggyVaultConfigs',
        getPiggyVaultConfigs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetPiggyVaultConfigsRequest.fromBuffer(value),
        ($28.GetPiggyVaultConfigsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.CreateLockFundAutoSaveRequest,
            $28.CreateLockFundAutoSaveResponse>(
        'CreateLockFundAutoSave',
        createLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CreateLockFundAutoSaveRequest.fromBuffer(value),
        ($28.CreateLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetLockFundAutoSaveRequest,
            $28.GetLockFundAutoSaveResponse>(
        'GetLockFundAutoSave',
        getLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetLockFundAutoSaveRequest.fromBuffer(value),
        ($28.GetLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.UpdateLockFundAutoSaveRequest,
            $28.UpdateLockFundAutoSaveResponse>(
        'UpdateLockFundAutoSave',
        updateLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.UpdateLockFundAutoSaveRequest.fromBuffer(value),
        ($28.UpdateLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.DeleteLockFundAutoSaveRequest,
            $28.DeleteLockFundAutoSaveResponse>(
        'DeleteLockFundAutoSave',
        deleteLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.DeleteLockFundAutoSaveRequest.fromBuffer(value),
        ($28.DeleteLockFundAutoSaveResponse value) => value.writeToBuffer()));
  }

  $async.Future<$28.CreateLockFundResponse> createLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.CreateLockFundRequest> request) async {
    return createLockFund(call, await request);
  }

  $async.Future<$28.GetLockFundsResponse> getLockFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$28.GetLockFundResponse> getLockFund_Pre($grpc.ServiceCall call,
      $async.Future<$28.GetLockFundRequest> request) async {
    return getLockFund(call, await request);
  }

  $async.Future<$28.UnlockFundResponse> unlockFund_Pre($grpc.ServiceCall call,
      $async.Future<$28.UnlockFundRequest> request) async {
    return unlockFund(call, await request);
  }

  $async.Future<$28.TopUpLockFundResponse> topUpLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.TopUpLockFundRequest> request) async {
    return topUpLockFund(call, await request);
  }

  $async.Future<$28.GetLockTransactionsResponse> getLockTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetLockTransactionsRequest> request) async {
    return getLockTransactions(call, await request);
  }

  $async.Future<$28.CalculateInterestResponse> calculateInterest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.CalculateInterestRequest> request) async {
    return calculateInterest(call, await request);
  }

  $async.Future<$28.RenewLockFundResponse> renewLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.RenewLockFundRequest> request) async {
    return renewLockFund(call, await request);
  }

  $async.Future<$28.CancelLockFundResponse> cancelLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.CancelLockFundRequest> request) async {
    return cancelLockFund(call, await request);
  }

  $async.Future<$28.GetPiggyVaultConfigsResponse> getPiggyVaultConfigs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetPiggyVaultConfigsRequest> request) async {
    return getPiggyVaultConfigs(call, await request);
  }

  $async.Future<$28.CreateLockFundAutoSaveResponse> createLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.CreateLockFundAutoSaveRequest> request) async {
    return createLockFundAutoSave(call, await request);
  }

  $async.Future<$28.GetLockFundAutoSaveResponse> getLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetLockFundAutoSaveRequest> request) async {
    return getLockFundAutoSave(call, await request);
  }

  $async.Future<$28.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.UpdateLockFundAutoSaveRequest> request) async {
    return updateLockFundAutoSave(call, await request);
  }

  $async.Future<$28.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.DeleteLockFundAutoSaveRequest> request) async {
    return deleteLockFundAutoSave(call, await request);
  }

  $async.Future<$28.CreateLockFundResponse> createLockFund(
      $grpc.ServiceCall call, $28.CreateLockFundRequest request);
  $async.Future<$28.GetLockFundsResponse> getLockFunds(
      $grpc.ServiceCall call, $28.GetLockFundsRequest request);
  $async.Future<$28.GetLockFundResponse> getLockFund(
      $grpc.ServiceCall call, $28.GetLockFundRequest request);
  $async.Future<$28.UnlockFundResponse> unlockFund(
      $grpc.ServiceCall call, $28.UnlockFundRequest request);
  $async.Future<$28.TopUpLockFundResponse> topUpLockFund(
      $grpc.ServiceCall call, $28.TopUpLockFundRequest request);
  $async.Future<$28.GetLockTransactionsResponse> getLockTransactions(
      $grpc.ServiceCall call, $28.GetLockTransactionsRequest request);
  $async.Future<$28.CalculateInterestResponse> calculateInterest(
      $grpc.ServiceCall call, $28.CalculateInterestRequest request);
  $async.Future<$28.RenewLockFundResponse> renewLockFund(
      $grpc.ServiceCall call, $28.RenewLockFundRequest request);
  $async.Future<$28.CancelLockFundResponse> cancelLockFund(
      $grpc.ServiceCall call, $28.CancelLockFundRequest request);
  $async.Future<$28.GetPiggyVaultConfigsResponse> getPiggyVaultConfigs(
      $grpc.ServiceCall call, $28.GetPiggyVaultConfigsRequest request);
  $async.Future<$28.CreateLockFundAutoSaveResponse> createLockFundAutoSave(
      $grpc.ServiceCall call, $28.CreateLockFundAutoSaveRequest request);
  $async.Future<$28.GetLockFundAutoSaveResponse> getLockFundAutoSave(
      $grpc.ServiceCall call, $28.GetLockFundAutoSaveRequest request);
  $async.Future<$28.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave(
      $grpc.ServiceCall call, $28.UpdateLockFundAutoSaveRequest request);
  $async.Future<$28.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave(
      $grpc.ServiceCall call, $28.DeleteLockFundAutoSaveRequest request);
}
