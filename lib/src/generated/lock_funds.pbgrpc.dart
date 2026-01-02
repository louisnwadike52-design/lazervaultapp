///
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'lock_funds.pb.dart' as $20;
export 'lock_funds.pb.dart';

class LockFundsServiceClient extends $grpc.Client {
  static final _$createLockFund =
      $grpc.ClientMethod<$20.CreateLockFundRequest, $20.CreateLockFundResponse>(
          '/pb.LockFundsService/CreateLockFund',
          ($20.CreateLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.CreateLockFundResponse.fromBuffer(value));
  static final _$getLockFunds =
      $grpc.ClientMethod<$20.GetLockFundsRequest, $20.GetLockFundsResponse>(
          '/pb.LockFundsService/GetLockFunds',
          ($20.GetLockFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetLockFundsResponse.fromBuffer(value));
  static final _$getLockFund =
      $grpc.ClientMethod<$20.GetLockFundRequest, $20.GetLockFundResponse>(
          '/pb.LockFundsService/GetLockFund',
          ($20.GetLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetLockFundResponse.fromBuffer(value));
  static final _$unlockFund =
      $grpc.ClientMethod<$20.UnlockFundRequest, $20.UnlockFundResponse>(
          '/pb.LockFundsService/UnlockFund',
          ($20.UnlockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.UnlockFundResponse.fromBuffer(value));
  static final _$getLockTransactions = $grpc.ClientMethod<
          $20.GetLockTransactionsRequest, $20.GetLockTransactionsResponse>(
      '/pb.LockFundsService/GetLockTransactions',
      ($20.GetLockTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetLockTransactionsResponse.fromBuffer(value));
  static final _$calculateInterest = $grpc.ClientMethod<
          $20.CalculateInterestRequest, $20.CalculateInterestResponse>(
      '/pb.LockFundsService/CalculateInterest',
      ($20.CalculateInterestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.CalculateInterestResponse.fromBuffer(value));
  static final _$renewLockFund =
      $grpc.ClientMethod<$20.RenewLockFundRequest, $20.RenewLockFundResponse>(
          '/pb.LockFundsService/RenewLockFund',
          ($20.RenewLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.RenewLockFundResponse.fromBuffer(value));
  static final _$cancelLockFund =
      $grpc.ClientMethod<$20.CancelLockFundRequest, $20.CancelLockFundResponse>(
          '/pb.LockFundsService/CancelLockFund',
          ($20.CancelLockFundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.CancelLockFundResponse.fromBuffer(value));

  LockFundsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$20.CreateLockFundResponse> createLockFund(
      $20.CreateLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetLockFundsResponse> getLockFunds(
      $20.GetLockFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetLockFundResponse> getLockFund(
      $20.GetLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$20.UnlockFundResponse> unlockFund(
      $20.UnlockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFund, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetLockTransactionsResponse> getLockTransactions(
      $20.GetLockTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$20.CalculateInterestResponse> calculateInterest(
      $20.CalculateInterestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateInterest, request, options: options);
  }

  $grpc.ResponseFuture<$20.RenewLockFundResponse> renewLockFund(
      $20.RenewLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renewLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$20.CancelLockFundResponse> cancelLockFund(
      $20.CancelLockFundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelLockFund, request, options: options);
  }
}

abstract class LockFundsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.LockFundsService';

  LockFundsServiceBase() {
    $addMethod($grpc.ServiceMethod<$20.CreateLockFundRequest,
            $20.CreateLockFundResponse>(
        'CreateLockFund',
        createLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.CreateLockFundRequest.fromBuffer(value),
        ($20.CreateLockFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.GetLockFundsRequest, $20.GetLockFundsResponse>(
            'GetLockFunds',
            getLockFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetLockFundsRequest.fromBuffer(value),
            ($20.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.GetLockFundRequest, $20.GetLockFundResponse>(
            'GetLockFund',
            getLockFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.GetLockFundRequest.fromBuffer(value),
            ($20.GetLockFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.UnlockFundRequest, $20.UnlockFundResponse>(
            'UnlockFund',
            unlockFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.UnlockFundRequest.fromBuffer(value),
            ($20.UnlockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetLockTransactionsRequest,
            $20.GetLockTransactionsResponse>(
        'GetLockTransactions',
        getLockTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetLockTransactionsRequest.fromBuffer(value),
        ($20.GetLockTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.CalculateInterestRequest,
            $20.CalculateInterestResponse>(
        'CalculateInterest',
        calculateInterest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.CalculateInterestRequest.fromBuffer(value),
        ($20.CalculateInterestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.RenewLockFundRequest,
            $20.RenewLockFundResponse>(
        'RenewLockFund',
        renewLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.RenewLockFundRequest.fromBuffer(value),
        ($20.RenewLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.CancelLockFundRequest,
            $20.CancelLockFundResponse>(
        'CancelLockFund',
        cancelLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.CancelLockFundRequest.fromBuffer(value),
        ($20.CancelLockFundResponse value) => value.writeToBuffer()));
  }

  $async.Future<$20.CreateLockFundResponse> createLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.CreateLockFundRequest> request) async {
    return createLockFund(call, await request);
  }

  $async.Future<$20.GetLockFundsResponse> getLockFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$20.GetLockFundResponse> getLockFund_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetLockFundRequest> request) async {
    return getLockFund(call, await request);
  }

  $async.Future<$20.UnlockFundResponse> unlockFund_Pre($grpc.ServiceCall call,
      $async.Future<$20.UnlockFundRequest> request) async {
    return unlockFund(call, await request);
  }

  $async.Future<$20.GetLockTransactionsResponse> getLockTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetLockTransactionsRequest> request) async {
    return getLockTransactions(call, await request);
  }

  $async.Future<$20.CalculateInterestResponse> calculateInterest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.CalculateInterestRequest> request) async {
    return calculateInterest(call, await request);
  }

  $async.Future<$20.RenewLockFundResponse> renewLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.RenewLockFundRequest> request) async {
    return renewLockFund(call, await request);
  }

  $async.Future<$20.CancelLockFundResponse> cancelLockFund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.CancelLockFundRequest> request) async {
    return cancelLockFund(call, await request);
  }

  $async.Future<$20.CreateLockFundResponse> createLockFund(
      $grpc.ServiceCall call, $20.CreateLockFundRequest request);
  $async.Future<$20.GetLockFundsResponse> getLockFunds(
      $grpc.ServiceCall call, $20.GetLockFundsRequest request);
  $async.Future<$20.GetLockFundResponse> getLockFund(
      $grpc.ServiceCall call, $20.GetLockFundRequest request);
  $async.Future<$20.UnlockFundResponse> unlockFund(
      $grpc.ServiceCall call, $20.UnlockFundRequest request);
  $async.Future<$20.GetLockTransactionsResponse> getLockTransactions(
      $grpc.ServiceCall call, $20.GetLockTransactionsRequest request);
  $async.Future<$20.CalculateInterestResponse> calculateInterest(
      $grpc.ServiceCall call, $20.CalculateInterestRequest request);
  $async.Future<$20.RenewLockFundResponse> renewLockFund(
      $grpc.ServiceCall call, $20.RenewLockFundRequest request);
  $async.Future<$20.CancelLockFundResponse> cancelLockFund(
      $grpc.ServiceCall call, $20.CancelLockFundRequest request);
}
