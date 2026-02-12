//
//  Generated code. Do not modify.
//  source: referral.proto
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

import 'referral.pb.dart' as $0;

export 'referral.pb.dart';

@$pb.GrpcServiceName('pb.ReferralService')
class ReferralServiceClient extends $grpc.Client {
  static final _$validateReferralCode = $grpc.ClientMethod<$0.ValidateReferralCodeRequest, $0.ValidateReferralCodeResponse>(
      '/pb.ReferralService/ValidateReferralCode',
      ($0.ValidateReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ValidateReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralCode = $grpc.ClientMethod<$0.GetMyReferralCodeRequest, $0.GetMyReferralCodeResponse>(
      '/pb.ReferralService/GetMyReferralCode',
      ($0.GetMyReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralStats = $grpc.ClientMethod<$0.GetMyReferralStatsRequest, $0.GetMyReferralStatsResponse>(
      '/pb.ReferralService/GetMyReferralStats',
      ($0.GetMyReferralStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyReferralStatsResponse.fromBuffer(value));
  static final _$getMyReferrals = $grpc.ClientMethod<$0.GetMyReferralsRequest, $0.GetMyReferralsResponse>(
      '/pb.ReferralService/GetMyReferrals',
      ($0.GetMyReferralsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyReferralsResponse.fromBuffer(value));
  static final _$getReferralLeaderboard = $grpc.ClientMethod<$0.GetReferralLeaderboardRequest, $0.GetReferralLeaderboardResponse>(
      '/pb.ReferralService/GetReferralLeaderboard',
      ($0.GetReferralLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetReferralLeaderboardResponse.fromBuffer(value));
  static final _$getCountryRewardConfig = $grpc.ClientMethod<$0.GetCountryRewardConfigRequest, $0.GetCountryRewardConfigResponse>(
      '/pb.ReferralService/GetCountryRewardConfig',
      ($0.GetCountryRewardConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCountryRewardConfigResponse.fromBuffer(value));
  static final _$recordReferral = $grpc.ClientMethod<$0.RecordReferralRequest, $0.RecordReferralResponse>(
      '/pb.ReferralService/RecordReferral',
      ($0.RecordReferralRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RecordReferralResponse.fromBuffer(value));
  static final _$creditReferralRewards = $grpc.ClientMethod<$0.CreditReferralRewardsRequest, $0.CreditReferralRewardsResponse>(
      '/pb.ReferralService/CreditReferralRewards',
      ($0.CreditReferralRewardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreditReferralRewardsResponse.fromBuffer(value));

  ReferralServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ValidateReferralCodeResponse> validateReferralCode($0.ValidateReferralCodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyReferralCodeResponse> getMyReferralCode($0.GetMyReferralCodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyReferralStatsResponse> getMyReferralStats($0.GetMyReferralStatsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralStats, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyReferralsResponse> getMyReferrals($0.GetMyReferralsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferrals, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetReferralLeaderboardResponse> getReferralLeaderboard($0.GetReferralLeaderboardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReferralLeaderboard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCountryRewardConfigResponse> getCountryRewardConfig($0.GetCountryRewardConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRewardConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecordReferralResponse> recordReferral($0.RecordReferralRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordReferral, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreditReferralRewardsResponse> creditReferralRewards($0.CreditReferralRewardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditReferralRewards, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.ReferralService')
abstract class ReferralServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ReferralService';

  ReferralServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ValidateReferralCodeRequest, $0.ValidateReferralCodeResponse>(
        'ValidateReferralCode',
        validateReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidateReferralCodeRequest.fromBuffer(value),
        ($0.ValidateReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyReferralCodeRequest, $0.GetMyReferralCodeResponse>(
        'GetMyReferralCode',
        getMyReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyReferralCodeRequest.fromBuffer(value),
        ($0.GetMyReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyReferralStatsRequest, $0.GetMyReferralStatsResponse>(
        'GetMyReferralStats',
        getMyReferralStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyReferralStatsRequest.fromBuffer(value),
        ($0.GetMyReferralStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyReferralsRequest, $0.GetMyReferralsResponse>(
        'GetMyReferrals',
        getMyReferrals_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyReferralsRequest.fromBuffer(value),
        ($0.GetMyReferralsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReferralLeaderboardRequest, $0.GetReferralLeaderboardResponse>(
        'GetReferralLeaderboard',
        getReferralLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetReferralLeaderboardRequest.fromBuffer(value),
        ($0.GetReferralLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCountryRewardConfigRequest, $0.GetCountryRewardConfigResponse>(
        'GetCountryRewardConfig',
        getCountryRewardConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCountryRewardConfigRequest.fromBuffer(value),
        ($0.GetCountryRewardConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecordReferralRequest, $0.RecordReferralResponse>(
        'RecordReferral',
        recordReferral_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RecordReferralRequest.fromBuffer(value),
        ($0.RecordReferralResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreditReferralRewardsRequest, $0.CreditReferralRewardsResponse>(
        'CreditReferralRewards',
        creditReferralRewards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreditReferralRewardsRequest.fromBuffer(value),
        ($0.CreditReferralRewardsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ValidateReferralCodeResponse> validateReferralCode_Pre($grpc.ServiceCall call, $async.Future<$0.ValidateReferralCodeRequest> request) async {
    return validateReferralCode(call, await request);
  }

  $async.Future<$0.GetMyReferralCodeResponse> getMyReferralCode_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyReferralCodeRequest> request) async {
    return getMyReferralCode(call, await request);
  }

  $async.Future<$0.GetMyReferralStatsResponse> getMyReferralStats_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyReferralStatsRequest> request) async {
    return getMyReferralStats(call, await request);
  }

  $async.Future<$0.GetMyReferralsResponse> getMyReferrals_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyReferralsRequest> request) async {
    return getMyReferrals(call, await request);
  }

  $async.Future<$0.GetReferralLeaderboardResponse> getReferralLeaderboard_Pre($grpc.ServiceCall call, $async.Future<$0.GetReferralLeaderboardRequest> request) async {
    return getReferralLeaderboard(call, await request);
  }

  $async.Future<$0.GetCountryRewardConfigResponse> getCountryRewardConfig_Pre($grpc.ServiceCall call, $async.Future<$0.GetCountryRewardConfigRequest> request) async {
    return getCountryRewardConfig(call, await request);
  }

  $async.Future<$0.RecordReferralResponse> recordReferral_Pre($grpc.ServiceCall call, $async.Future<$0.RecordReferralRequest> request) async {
    return recordReferral(call, await request);
  }

  $async.Future<$0.CreditReferralRewardsResponse> creditReferralRewards_Pre($grpc.ServiceCall call, $async.Future<$0.CreditReferralRewardsRequest> request) async {
    return creditReferralRewards(call, await request);
  }

  $async.Future<$0.ValidateReferralCodeResponse> validateReferralCode($grpc.ServiceCall call, $0.ValidateReferralCodeRequest request);
  $async.Future<$0.GetMyReferralCodeResponse> getMyReferralCode($grpc.ServiceCall call, $0.GetMyReferralCodeRequest request);
  $async.Future<$0.GetMyReferralStatsResponse> getMyReferralStats($grpc.ServiceCall call, $0.GetMyReferralStatsRequest request);
  $async.Future<$0.GetMyReferralsResponse> getMyReferrals($grpc.ServiceCall call, $0.GetMyReferralsRequest request);
  $async.Future<$0.GetReferralLeaderboardResponse> getReferralLeaderboard($grpc.ServiceCall call, $0.GetReferralLeaderboardRequest request);
  $async.Future<$0.GetCountryRewardConfigResponse> getCountryRewardConfig($grpc.ServiceCall call, $0.GetCountryRewardConfigRequest request);
  $async.Future<$0.RecordReferralResponse> recordReferral($grpc.ServiceCall call, $0.RecordReferralRequest request);
  $async.Future<$0.CreditReferralRewardsResponse> creditReferralRewards($grpc.ServiceCall call, $0.CreditReferralRewardsRequest request);
}
