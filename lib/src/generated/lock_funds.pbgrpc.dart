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

import 'lock_funds.pb.dart' as $0;

export 'lock_funds.pb.dart';

@$pb.GrpcServiceName('pb.LockFundsService')
class LockFundsServiceClient extends $grpc.Client {
  static final _$createLockFund = $grpc.ClientMethod<$0.CreateLockFundRequest, $0.CreateLockFundResponse>(
      '/pb.LockFundsService/CreateLockFund',
      ($0.CreateLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateLockFundResponse.fromBuffer(value));
  static final _$getLockFunds = $grpc.ClientMethod<$0.GetLockFundsRequest, $0.GetLockFundsResponse>(
      '/pb.LockFundsService/GetLockFunds',
      ($0.GetLockFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLockFundsResponse.fromBuffer(value));
  static final _$getLockFund = $grpc.ClientMethod<$0.GetLockFundRequest, $0.GetLockFundResponse>(
      '/pb.LockFundsService/GetLockFund',
      ($0.GetLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLockFundResponse.fromBuffer(value));
  static final _$unlockFund = $grpc.ClientMethod<$0.UnlockFundRequest, $0.UnlockFundResponse>(
      '/pb.LockFundsService/UnlockFund',
      ($0.UnlockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnlockFundResponse.fromBuffer(value));
  static final _$getLockTransactions = $grpc.ClientMethod<$0.GetLockTransactionsRequest, $0.GetLockTransactionsResponse>(
      '/pb.LockFundsService/GetLockTransactions',
      ($0.GetLockTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLockTransactionsResponse.fromBuffer(value));
  static final _$calculateInterest = $grpc.ClientMethod<$0.CalculateInterestRequest, $0.CalculateInterestResponse>(
      '/pb.LockFundsService/CalculateInterest',
      ($0.CalculateInterestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CalculateInterestResponse.fromBuffer(value));
  static final _$renewLockFund = $grpc.ClientMethod<$0.RenewLockFundRequest, $0.RenewLockFundResponse>(
      '/pb.LockFundsService/RenewLockFund',
      ($0.RenewLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RenewLockFundResponse.fromBuffer(value));
  static final _$cancelLockFund = $grpc.ClientMethod<$0.CancelLockFundRequest, $0.CancelLockFundResponse>(
      '/pb.LockFundsService/CancelLockFund',
      ($0.CancelLockFundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelLockFundResponse.fromBuffer(value));

  LockFundsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateLockFundResponse> createLockFund($0.CreateLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLockFundsResponse> getLockFunds($0.GetLockFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLockFundResponse> getLockFund($0.GetLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnlockFundResponse> unlockFund($0.UnlockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLockTransactionsResponse> getLockTransactions($0.GetLockTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.CalculateInterestResponse> calculateInterest($0.CalculateInterestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateInterest, request, options: options);
  }

  $grpc.ResponseFuture<$0.RenewLockFundResponse> renewLockFund($0.RenewLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renewLockFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelLockFundResponse> cancelLockFund($0.CancelLockFundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelLockFund, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.LockFundsService')
abstract class LockFundsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.LockFundsService';

  LockFundsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateLockFundRequest, $0.CreateLockFundResponse>(
        'CreateLockFund',
        createLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateLockFundRequest.fromBuffer(value),
        ($0.CreateLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLockFundsRequest, $0.GetLockFundsResponse>(
        'GetLockFunds',
        getLockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLockFundsRequest.fromBuffer(value),
        ($0.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLockFundRequest, $0.GetLockFundResponse>(
        'GetLockFund',
        getLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLockFundRequest.fromBuffer(value),
        ($0.GetLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlockFundRequest, $0.UnlockFundResponse>(
        'UnlockFund',
        unlockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnlockFundRequest.fromBuffer(value),
        ($0.UnlockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLockTransactionsRequest, $0.GetLockTransactionsResponse>(
        'GetLockTransactions',
        getLockTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLockTransactionsRequest.fromBuffer(value),
        ($0.GetLockTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CalculateInterestRequest, $0.CalculateInterestResponse>(
        'CalculateInterest',
        calculateInterest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CalculateInterestRequest.fromBuffer(value),
        ($0.CalculateInterestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RenewLockFundRequest, $0.RenewLockFundResponse>(
        'RenewLockFund',
        renewLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RenewLockFundRequest.fromBuffer(value),
        ($0.RenewLockFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelLockFundRequest, $0.CancelLockFundResponse>(
        'CancelLockFund',
        cancelLockFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelLockFundRequest.fromBuffer(value),
        ($0.CancelLockFundResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateLockFundResponse> createLockFund_Pre($grpc.ServiceCall call, $async.Future<$0.CreateLockFundRequest> request) async {
    return createLockFund(call, await request);
  }

  $async.Future<$0.GetLockFundsResponse> getLockFunds_Pre($grpc.ServiceCall call, $async.Future<$0.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$0.GetLockFundResponse> getLockFund_Pre($grpc.ServiceCall call, $async.Future<$0.GetLockFundRequest> request) async {
    return getLockFund(call, await request);
  }

  $async.Future<$0.UnlockFundResponse> unlockFund_Pre($grpc.ServiceCall call, $async.Future<$0.UnlockFundRequest> request) async {
    return unlockFund(call, await request);
  }

  $async.Future<$0.GetLockTransactionsResponse> getLockTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetLockTransactionsRequest> request) async {
    return getLockTransactions(call, await request);
  }

  $async.Future<$0.CalculateInterestResponse> calculateInterest_Pre($grpc.ServiceCall call, $async.Future<$0.CalculateInterestRequest> request) async {
    return calculateInterest(call, await request);
  }

  $async.Future<$0.RenewLockFundResponse> renewLockFund_Pre($grpc.ServiceCall call, $async.Future<$0.RenewLockFundRequest> request) async {
    return renewLockFund(call, await request);
  }

  $async.Future<$0.CancelLockFundResponse> cancelLockFund_Pre($grpc.ServiceCall call, $async.Future<$0.CancelLockFundRequest> request) async {
    return cancelLockFund(call, await request);
  }

  $async.Future<$0.CreateLockFundResponse> createLockFund($grpc.ServiceCall call, $0.CreateLockFundRequest request);
  $async.Future<$0.GetLockFundsResponse> getLockFunds($grpc.ServiceCall call, $0.GetLockFundsRequest request);
  $async.Future<$0.GetLockFundResponse> getLockFund($grpc.ServiceCall call, $0.GetLockFundRequest request);
  $async.Future<$0.UnlockFundResponse> unlockFund($grpc.ServiceCall call, $0.UnlockFundRequest request);
  $async.Future<$0.GetLockTransactionsResponse> getLockTransactions($grpc.ServiceCall call, $0.GetLockTransactionsRequest request);
  $async.Future<$0.CalculateInterestResponse> calculateInterest($grpc.ServiceCall call, $0.CalculateInterestRequest request);
  $async.Future<$0.RenewLockFundResponse> renewLockFund($grpc.ServiceCall call, $0.RenewLockFundRequest request);
  $async.Future<$0.CancelLockFundResponse> cancelLockFund($grpc.ServiceCall call, $0.CancelLockFundRequest request);
}
