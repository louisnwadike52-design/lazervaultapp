//
//  Generated code. Do not modify.
//  source: lock_funds.proto
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

import 'lock_funds.pb.dart' as $26;

export 'lock_funds.pb.dart';

@$pb.GrpcServiceName('pb.LockFundsService')
class LockFundsServiceClient extends $grpc.Client {
  static final _$createLockFund = $grpc.ClientMethod<$26.CreateLockFundRequest, $26.CreateLockFundResponse>(
      '/pb.LockFundsService/CreateLockFund',
      ($26.CreateLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.CreateLockFundResponse.fromBuffer(value));
  static final _$getLockFunds = $grpc.ClientMethod<$26.GetLockFundsRequest, $26.GetLockFundsResponse>(
      '/pb.LockFundsService/GetLockFunds',
      ($26.GetLockFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.GetLockFundsResponse.fromBuffer(value));
  static final _$getLockFund = $grpc.ClientMethod<$26.GetLockFundRequest, $26.GetLockFundResponse>(
      '/pb.LockFundsService/GetLockFund',
      ($26.GetLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.GetLockFundResponse.fromBuffer(value));
  static final _$unlockFund = $grpc.ClientMethod<$26.UnlockFundRequest, $26.UnlockFundResponse>(
      '/pb.LockFundsService/UnlockFund',
      ($26.UnlockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.UnlockFundResponse.fromBuffer(value));
  static final _$getLockTransactions = $grpc.ClientMethod<$26.GetLockTransactionsRequest, $26.GetLockTransactionsResponse>(
      '/pb.LockFundsService/GetLockTransactions',
      ($26.GetLockTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.GetLockTransactionsResponse.fromBuffer(value));
  static final _$calculateInterest = $grpc.ClientMethod<$26.CalculateInterestRequest, $26.CalculateInterestResponse>(
      '/pb.LockFundsService/CalculateInterest',
      ($26.CalculateInterestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.CalculateInterestResponse.fromBuffer(value));
  static final _$renewLockFund = $grpc.ClientMethod<$26.RenewLockFundRequest, $26.RenewLockFundResponse>(
      '/pb.LockFundsService/RenewLockFund',
      ($26.RenewLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.RenewLockFundResponse.fromBuffer(value));
  static final _$cancelLockFund = $grpc.ClientMethod<$26.CancelLockFundRequest, $26.CancelLockFundResponse>(
      '/pb.LockFundsService/CancelLockFund',
      ($26.CancelLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $26.CancelLockFundResponse.fromBuffer(value));

  LockFundsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$26.CreateLockFundResponse> createLockFund($26.CreateLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetLockFundsResponse> getLockFunds($26.GetLockFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetLockFundResponse> getLockFund($26.GetLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$26.UnlockFundResponse> unlockFund($26.UnlockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFund, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetLockTransactionsResponse> getLockTransactions($26.GetLockTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$26.CalculateInterestResponse> calculateInterest($26.CalculateInterestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateInterest, request, options: options);
  }

  $grpc.ResponseFuture<$26.RenewLockFundResponse> renewLockFund($26.RenewLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renewLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$26.CancelLockFundResponse> cancelLockFund($26.CancelLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelLockFund, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.LockFundsService')
abstract class LockFundsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.LockFundsService';

  LockFundsServiceBase() {
    $addMethod($grpc.ServiceMethod<$26.CreateLockFundRequest, $26.CreateLockFundResponse>(
        'CreateLockFund',
        createLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.CreateLockFundRequest.fromBuffer(value),
        ($26.CreateLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetLockFundsRequest, $26.GetLockFundsResponse>(
        'GetLockFunds',
        getLockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetLockFundsRequest.fromBuffer(value),
        ($26.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetLockFundRequest, $26.GetLockFundResponse>(
        'GetLockFund',
        getLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetLockFundRequest.fromBuffer(value),
        ($26.GetLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.UnlockFundRequest, $26.UnlockFundResponse>(
        'UnlockFund',
        unlockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.UnlockFundRequest.fromBuffer(value),
        ($26.UnlockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetLockTransactionsRequest, $26.GetLockTransactionsResponse>(
        'GetLockTransactions',
        getLockTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetLockTransactionsRequest.fromBuffer(value),
        ($26.GetLockTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CalculateInterestRequest, $26.CalculateInterestResponse>(
        'CalculateInterest',
        calculateInterest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.CalculateInterestRequest.fromBuffer(value),
        ($26.CalculateInterestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.RenewLockFundRequest, $26.RenewLockFundResponse>(
        'RenewLockFund',
        renewLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.RenewLockFundRequest.fromBuffer(value),
        ($26.RenewLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CancelLockFundRequest, $26.CancelLockFundResponse>(
        'CancelLockFund',
        cancelLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.CancelLockFundRequest.fromBuffer(value),
        ($26.CancelLockFundResponse value) => value.writeToBuffer()));
  }

  $async.Future<$26.CreateLockFundResponse> createLockFund_Pre($grpc.ServiceCall call, $async.Future<$26.CreateLockFundRequest> request) async {
    return createLockFund(call, await request);
  }

  $async.Future<$26.GetLockFundsResponse> getLockFunds_Pre($grpc.ServiceCall call, $async.Future<$26.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$26.GetLockFundResponse> getLockFund_Pre($grpc.ServiceCall call, $async.Future<$26.GetLockFundRequest> request) async {
    return getLockFund(call, await request);
  }

  $async.Future<$26.UnlockFundResponse> unlockFund_Pre($grpc.ServiceCall call, $async.Future<$26.UnlockFundRequest> request) async {
    return unlockFund(call, await request);
  }

  $async.Future<$26.GetLockTransactionsResponse> getLockTransactions_Pre($grpc.ServiceCall call, $async.Future<$26.GetLockTransactionsRequest> request) async {
    return getLockTransactions(call, await request);
  }

  $async.Future<$26.CalculateInterestResponse> calculateInterest_Pre($grpc.ServiceCall call, $async.Future<$26.CalculateInterestRequest> request) async {
    return calculateInterest(call, await request);
  }

  $async.Future<$26.RenewLockFundResponse> renewLockFund_Pre($grpc.ServiceCall call, $async.Future<$26.RenewLockFundRequest> request) async {
    return renewLockFund(call, await request);
  }

  $async.Future<$26.CancelLockFundResponse> cancelLockFund_Pre($grpc.ServiceCall call, $async.Future<$26.CancelLockFundRequest> request) async {
    return cancelLockFund(call, await request);
  }

  $async.Future<$26.CreateLockFundResponse> createLockFund($grpc.ServiceCall call, $26.CreateLockFundRequest request);
  $async.Future<$26.GetLockFundsResponse> getLockFunds($grpc.ServiceCall call, $26.GetLockFundsRequest request);
  $async.Future<$26.GetLockFundResponse> getLockFund($grpc.ServiceCall call, $26.GetLockFundRequest request);
  $async.Future<$26.UnlockFundResponse> unlockFund($grpc.ServiceCall call, $26.UnlockFundRequest request);
  $async.Future<$26.GetLockTransactionsResponse> getLockTransactions($grpc.ServiceCall call, $26.GetLockTransactionsRequest request);
  $async.Future<$26.CalculateInterestResponse> calculateInterest($grpc.ServiceCall call, $26.CalculateInterestRequest request);
  $async.Future<$26.RenewLockFundResponse> renewLockFund($grpc.ServiceCall call, $26.RenewLockFundRequest request);
  $async.Future<$26.CancelLockFundResponse> cancelLockFund($grpc.ServiceCall call, $26.CancelLockFundRequest request);
}
