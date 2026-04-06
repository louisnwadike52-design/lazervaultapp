///
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'lock_funds.pb.dart' as $27;
export 'lock_funds.pb.dart';

class LockFundsServiceClient extends $grpc.Client {
  static final _$createLockFund =
      $grpc.ClientMethod<$27.CreateLockFundRequest, $27.CreateLockFundResponse>(
          '/pb.LockFundsService/CreateLockFund',
          ($27.CreateLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.CreateLockFundResponse.fromBuffer(value));
  static final _$getLockFunds =
      $grpc.ClientMethod<$27.GetLockFundsRequest, $27.GetLockFundsResponse>(
          '/pb.LockFundsService/GetLockFunds',
          ($27.GetLockFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.GetLockFundsResponse.fromBuffer(value));
  static final _$getLockFund =
      $grpc.ClientMethod<$27.GetLockFundRequest, $27.GetLockFundResponse>(
          '/pb.LockFundsService/GetLockFund',
          ($27.GetLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.GetLockFundResponse.fromBuffer(value));
  static final _$unlockFund =
      $grpc.ClientMethod<$27.UnlockFundRequest, $27.UnlockFundResponse>(
          '/pb.LockFundsService/UnlockFund',
          ($27.UnlockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.UnlockFundResponse.fromBuffer(value));
  static final _$topUpLockFund =
      $grpc.ClientMethod<$27.TopUpLockFundRequest, $27.TopUpLockFundResponse>(
          '/pb.LockFundsService/TopUpLockFund',
          ($27.TopUpLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.TopUpLockFundResponse.fromBuffer(value));
  static final _$getLockTransactions = $grpc.ClientMethod<
          $27.GetLockTransactionsRequest, $27.GetLockTransactionsResponse>(
      '/pb.LockFundsService/GetLockTransactions',
      ($27.GetLockTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetLockTransactionsResponse.fromBuffer(value));
  static final _$calculateInterest = $grpc.ClientMethod<
          $27.CalculateInterestRequest, $27.CalculateInterestResponse>(
      '/pb.LockFundsService/CalculateInterest',
      ($27.CalculateInterestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.CalculateInterestResponse.fromBuffer(value));
  static final _$renewLockFund =
      $grpc.ClientMethod<$27.RenewLockFundRequest, $27.RenewLockFundResponse>(
          '/pb.LockFundsService/RenewLockFund',
          ($27.RenewLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.RenewLockFundResponse.fromBuffer(value));
  static final _$cancelLockFund =
      $grpc.ClientMethod<$27.CancelLockFundRequest, $27.CancelLockFundResponse>(
          '/pb.LockFundsService/CancelLockFund',
          ($27.CancelLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.CancelLockFundResponse.fromBuffer(value));
  static final _$getPiggyVaultConfigs = $grpc.ClientMethod<
          $27.GetPiggyVaultConfigsRequest, $27.GetPiggyVaultConfigsResponse>(
      '/pb.LockFundsService/GetPiggyVaultConfigs',
      ($27.GetPiggyVaultConfigsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetPiggyVaultConfigsResponse.fromBuffer(value));
  static final _$createLockFundAutoSave = $grpc.ClientMethod<
          $27.CreateLockFundAutoSaveRequest,
          $27.CreateLockFundAutoSaveResponse>(
      '/pb.LockFundsService/CreateLockFundAutoSave',
      ($27.CreateLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.CreateLockFundAutoSaveResponse.fromBuffer(value));
  static final _$getLockFundAutoSave = $grpc.ClientMethod<
          $27.GetLockFundAutoSaveRequest, $27.GetLockFundAutoSaveResponse>(
      '/pb.LockFundsService/GetLockFundAutoSave',
      ($27.GetLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetLockFundAutoSaveResponse.fromBuffer(value));
  static final _$updateLockFundAutoSave = $grpc.ClientMethod<
          $27.UpdateLockFundAutoSaveRequest,
          $27.UpdateLockFundAutoSaveResponse>(
      '/pb.LockFundsService/UpdateLockFundAutoSave',
      ($27.UpdateLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.UpdateLockFundAutoSaveResponse.fromBuffer(value));
  static final _$deleteLockFundAutoSave = $grpc.ClientMethod<
          $27.DeleteLockFundAutoSaveRequest,
          $27.DeleteLockFundAutoSaveResponse>(
      '/pb.LockFundsService/DeleteLockFundAutoSave',
      ($27.DeleteLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.DeleteLockFundAutoSaveResponse.fromBuffer(value));

  LockFundsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$27.CreateLockFundResponse> createLockFund(
      $27.CreateLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetLockFundsResponse> getLockFunds(
      $27.GetLockFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetLockFundResponse> getLockFund(
      $27.GetLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$27.UnlockFundResponse> unlockFund(
      $27.UnlockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFund, request, options: options);
  }

  $grpc.ResponseFuture<$27.TopUpLockFundResponse> topUpLockFund(
      $27.TopUpLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$topUpLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetLockTransactionsResponse> getLockTransactions(
      $27.GetLockTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$27.CalculateInterestResponse> calculateInterest(
      $27.CalculateInterestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateInterest, request, options: options);
  }

  $grpc.ResponseFuture<$27.RenewLockFundResponse> renewLockFund(
      $27.RenewLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renewLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$27.CancelLockFundResponse> cancelLockFund(
      $27.CancelLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetPiggyVaultConfigsResponse> getPiggyVaultConfigs(
      $27.GetPiggyVaultConfigsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPiggyVaultConfigs, request, options: options);
  }

  $grpc.ResponseFuture<$27.CreateLockFundAutoSaveResponse>
      createLockFundAutoSave($27.CreateLockFundAutoSaveRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFundAutoSave, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.GetLockFundAutoSaveResponse> getLockFundAutoSave(
      $27.GetLockFundAutoSaveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFundAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$27.UpdateLockFundAutoSaveResponse>
      updateLockFundAutoSave($27.UpdateLockFundAutoSaveRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLockFundAutoSave, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.DeleteLockFundAutoSaveResponse>
      deleteLockFundAutoSave($27.DeleteLockFundAutoSaveRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLockFundAutoSave, request,
        options: options);
  }
}

abstract class LockFundsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.LockFundsService';

  LockFundsServiceBase() {
    $addMethod($grpc.ServiceMethod<$27.CreateLockFundRequest,
            $27.CreateLockFundResponse>(
        'CreateLockFund',
        createLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.CreateLockFundRequest.fromBuffer(value),
        ($27.CreateLockFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$27.GetLockFundsRequest, $27.GetLockFundsResponse>(
            'GetLockFunds',
            getLockFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $27.GetLockFundsRequest.fromBuffer(value),
            ($27.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$27.GetLockFundRequest, $27.GetLockFundResponse>(
            'GetLockFund',
            getLockFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $27.GetLockFundRequest.fromBuffer(value),
            ($27.GetLockFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$27.UnlockFundRequest, $27.UnlockFundResponse>(
            'UnlockFund',
            unlockFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $27.UnlockFundRequest.fromBuffer(value),
            ($27.UnlockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.TopUpLockFundRequest,
            $27.TopUpLockFundResponse>(
        'TopUpLockFund',
        topUpLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.TopUpLockFundRequest.fromBuffer(value),
        ($27.TopUpLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetLockTransactionsRequest,
            $27.GetLockTransactionsResponse>(
        'GetLockTransactions',
        getLockTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetLockTransactionsRequest.fromBuffer(value),
        ($27.GetLockTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.CalculateInterestRequest,
            $27.CalculateInterestResponse>(
        'CalculateInterest',
        calculateInterest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.CalculateInterestRequest.fromBuffer(value),
        ($27.CalculateInterestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.RenewLockFundRequest,
            $27.RenewLockFundResponse>(
        'RenewLockFund',
        renewLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.RenewLockFundRequest.fromBuffer(value),
        ($27.RenewLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.CancelLockFundRequest,
            $27.CancelLockFundResponse>(
        'CancelLockFund',
        cancelLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.CancelLockFundRequest.fromBuffer(value),
        ($27.CancelLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetPiggyVaultConfigsRequest,
            $27.GetPiggyVaultConfigsResponse>(
        'GetPiggyVaultConfigs',
        getPiggyVaultConfigs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetPiggyVaultConfigsRequest.fromBuffer(value),
        ($27.GetPiggyVaultConfigsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.CreateLockFundAutoSaveRequest,
            $27.CreateLockFundAutoSaveResponse>(
        'CreateLockFundAutoSave',
        createLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.CreateLockFundAutoSaveRequest.fromBuffer(value),
        ($27.CreateLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetLockFundAutoSaveRequest,
            $27.GetLockFundAutoSaveResponse>(
        'GetLockFundAutoSave',
        getLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetLockFundAutoSaveRequest.fromBuffer(value),
        ($27.GetLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.UpdateLockFundAutoSaveRequest,
            $27.UpdateLockFundAutoSaveResponse>(
        'UpdateLockFundAutoSave',
        updateLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.UpdateLockFundAutoSaveRequest.fromBuffer(value),
        ($27.UpdateLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.DeleteLockFundAutoSaveRequest,
            $27.DeleteLockFundAutoSaveResponse>(
        'DeleteLockFundAutoSave',
        deleteLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.DeleteLockFundAutoSaveRequest.fromBuffer(value),
        ($27.DeleteLockFundAutoSaveResponse value) => value.writeToBuffer()));
  }

  $async.Future<$27.CreateLockFundResponse> createLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.CreateLockFundRequest> request) async {
    return createLockFund(call, await request);
  }

  $async.Future<$27.GetLockFundsResponse> getLockFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$27.GetLockFundResponse> getLockFund_Pre($grpc.ServiceCall call,
      $async.Future<$27.GetLockFundRequest> request) async {
    return getLockFund(call, await request);
  }

  $async.Future<$27.UnlockFundResponse> unlockFund_Pre($grpc.ServiceCall call,
      $async.Future<$27.UnlockFundRequest> request) async {
    return unlockFund(call, await request);
  }

  $async.Future<$27.TopUpLockFundResponse> topUpLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.TopUpLockFundRequest> request) async {
    return topUpLockFund(call, await request);
  }

  $async.Future<$27.GetLockTransactionsResponse> getLockTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetLockTransactionsRequest> request) async {
    return getLockTransactions(call, await request);
  }

  $async.Future<$27.CalculateInterestResponse> calculateInterest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.CalculateInterestRequest> request) async {
    return calculateInterest(call, await request);
  }

  $async.Future<$27.RenewLockFundResponse> renewLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.RenewLockFundRequest> request) async {
    return renewLockFund(call, await request);
  }

  $async.Future<$27.CancelLockFundResponse> cancelLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.CancelLockFundRequest> request) async {
    return cancelLockFund(call, await request);
  }

  $async.Future<$27.GetPiggyVaultConfigsResponse> getPiggyVaultConfigs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetPiggyVaultConfigsRequest> request) async {
    return getPiggyVaultConfigs(call, await request);
  }

  $async.Future<$27.CreateLockFundAutoSaveResponse> createLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.CreateLockFundAutoSaveRequest> request) async {
    return createLockFundAutoSave(call, await request);
  }

  $async.Future<$27.GetLockFundAutoSaveResponse> getLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetLockFundAutoSaveRequest> request) async {
    return getLockFundAutoSave(call, await request);
  }

  $async.Future<$27.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.UpdateLockFundAutoSaveRequest> request) async {
    return updateLockFundAutoSave(call, await request);
  }

  $async.Future<$27.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.DeleteLockFundAutoSaveRequest> request) async {
    return deleteLockFundAutoSave(call, await request);
  }

  $async.Future<$27.CreateLockFundResponse> createLockFund(
      $grpc.ServiceCall call, $27.CreateLockFundRequest request);
  $async.Future<$27.GetLockFundsResponse> getLockFunds(
      $grpc.ServiceCall call, $27.GetLockFundsRequest request);
  $async.Future<$27.GetLockFundResponse> getLockFund(
      $grpc.ServiceCall call, $27.GetLockFundRequest request);
  $async.Future<$27.UnlockFundResponse> unlockFund(
      $grpc.ServiceCall call, $27.UnlockFundRequest request);
  $async.Future<$27.TopUpLockFundResponse> topUpLockFund(
      $grpc.ServiceCall call, $27.TopUpLockFundRequest request);
  $async.Future<$27.GetLockTransactionsResponse> getLockTransactions(
      $grpc.ServiceCall call, $27.GetLockTransactionsRequest request);
  $async.Future<$27.CalculateInterestResponse> calculateInterest(
      $grpc.ServiceCall call, $27.CalculateInterestRequest request);
  $async.Future<$27.RenewLockFundResponse> renewLockFund(
      $grpc.ServiceCall call, $27.RenewLockFundRequest request);
  $async.Future<$27.CancelLockFundResponse> cancelLockFund(
      $grpc.ServiceCall call, $27.CancelLockFundRequest request);
  $async.Future<$27.GetPiggyVaultConfigsResponse> getPiggyVaultConfigs(
      $grpc.ServiceCall call, $27.GetPiggyVaultConfigsRequest request);
  $async.Future<$27.CreateLockFundAutoSaveResponse> createLockFundAutoSave(
      $grpc.ServiceCall call, $27.CreateLockFundAutoSaveRequest request);
  $async.Future<$27.GetLockFundAutoSaveResponse> getLockFundAutoSave(
      $grpc.ServiceCall call, $27.GetLockFundAutoSaveRequest request);
  $async.Future<$27.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave(
      $grpc.ServiceCall call, $27.UpdateLockFundAutoSaveRequest request);
  $async.Future<$27.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave(
      $grpc.ServiceCall call, $27.DeleteLockFundAutoSaveRequest request);
}
