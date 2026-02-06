//
//  Generated code. Do not modify.
//  source: autosave.proto
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

import 'autosave.pb.dart' as $6;

export 'autosave.pb.dart';

@$pb.GrpcServiceName('pb.AutoSaveService')
class AutoSaveServiceClient extends $grpc.Client {
  static final _$createAutoSaveRule = $grpc.ClientMethod<$6.CreateAutoSaveRuleRequest, $6.CreateAutoSaveRuleResponse>(
      '/pb.AutoSaveService/CreateAutoSaveRule',
      ($6.CreateAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.CreateAutoSaveRuleResponse.fromBuffer(value));
  static final _$getAutoSaveRules = $grpc.ClientMethod<$6.GetAutoSaveRulesRequest, $6.GetAutoSaveRulesResponse>(
      '/pb.AutoSaveService/GetAutoSaveRules',
      ($6.GetAutoSaveRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetAutoSaveRulesResponse.fromBuffer(value));
  static final _$updateAutoSaveRule = $grpc.ClientMethod<$6.UpdateAutoSaveRuleRequest, $6.UpdateAutoSaveRuleResponse>(
      '/pb.AutoSaveService/UpdateAutoSaveRule',
      ($6.UpdateAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.UpdateAutoSaveRuleResponse.fromBuffer(value));
  static final _$toggleAutoSaveRule = $grpc.ClientMethod<$6.ToggleAutoSaveRuleRequest, $6.ToggleAutoSaveRuleResponse>(
      '/pb.AutoSaveService/ToggleAutoSaveRule',
      ($6.ToggleAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.ToggleAutoSaveRuleResponse.fromBuffer(value));
  static final _$deleteAutoSaveRule = $grpc.ClientMethod<$6.DeleteAutoSaveRuleRequest, $6.DeleteAutoSaveRuleResponse>(
      '/pb.AutoSaveService/DeleteAutoSaveRule',
      ($6.DeleteAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.DeleteAutoSaveRuleResponse.fromBuffer(value));
  static final _$getAutoSaveTransactions = $grpc.ClientMethod<$6.GetAutoSaveTransactionsRequest, $6.GetAutoSaveTransactionsResponse>(
      '/pb.AutoSaveService/GetAutoSaveTransactions',
      ($6.GetAutoSaveTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetAutoSaveTransactionsResponse.fromBuffer(value));
  static final _$getAutoSaveStatistics = $grpc.ClientMethod<$6.GetAutoSaveStatisticsRequest, $6.GetAutoSaveStatisticsResponse>(
      '/pb.AutoSaveService/GetAutoSaveStatistics',
      ($6.GetAutoSaveStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetAutoSaveStatisticsResponse.fromBuffer(value));
  static final _$triggerAutoSave = $grpc.ClientMethod<$6.TriggerAutoSaveRequest, $6.TriggerAutoSaveResponse>(
      '/pb.AutoSaveService/TriggerAutoSave',
      ($6.TriggerAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.TriggerAutoSaveResponse.fromBuffer(value));

  AutoSaveServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$6.CreateAutoSaveRuleResponse> createAutoSaveRule($6.CreateAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetAutoSaveRulesResponse> getAutoSaveRules($6.GetAutoSaveRulesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveRules, request, options: options);
  }

  $grpc.ResponseFuture<$6.UpdateAutoSaveRuleResponse> updateAutoSaveRule($6.UpdateAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$6.ToggleAutoSaveRuleResponse> toggleAutoSaveRule($6.ToggleAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$6.DeleteAutoSaveRuleResponse> deleteAutoSaveRule($6.DeleteAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetAutoSaveTransactionsResponse> getAutoSaveTransactions($6.GetAutoSaveTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetAutoSaveStatisticsResponse> getAutoSaveStatistics($6.GetAutoSaveStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$6.TriggerAutoSaveResponse> triggerAutoSave($6.TriggerAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoSave, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.AutoSaveService')
abstract class AutoSaveServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AutoSaveService';

  AutoSaveServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.CreateAutoSaveRuleRequest, $6.CreateAutoSaveRuleResponse>(
        'CreateAutoSaveRule',
        createAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.CreateAutoSaveRuleRequest.fromBuffer(value),
        ($6.CreateAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetAutoSaveRulesRequest, $6.GetAutoSaveRulesResponse>(
        'GetAutoSaveRules',
        getAutoSaveRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetAutoSaveRulesRequest.fromBuffer(value),
        ($6.GetAutoSaveRulesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.UpdateAutoSaveRuleRequest, $6.UpdateAutoSaveRuleResponse>(
        'UpdateAutoSaveRule',
        updateAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.UpdateAutoSaveRuleRequest.fromBuffer(value),
        ($6.UpdateAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.ToggleAutoSaveRuleRequest, $6.ToggleAutoSaveRuleResponse>(
        'ToggleAutoSaveRule',
        toggleAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.ToggleAutoSaveRuleRequest.fromBuffer(value),
        ($6.ToggleAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.DeleteAutoSaveRuleRequest, $6.DeleteAutoSaveRuleResponse>(
        'DeleteAutoSaveRule',
        deleteAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.DeleteAutoSaveRuleRequest.fromBuffer(value),
        ($6.DeleteAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetAutoSaveTransactionsRequest, $6.GetAutoSaveTransactionsResponse>(
        'GetAutoSaveTransactions',
        getAutoSaveTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetAutoSaveTransactionsRequest.fromBuffer(value),
        ($6.GetAutoSaveTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetAutoSaveStatisticsRequest, $6.GetAutoSaveStatisticsResponse>(
        'GetAutoSaveStatistics',
        getAutoSaveStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetAutoSaveStatisticsRequest.fromBuffer(value),
        ($6.GetAutoSaveStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.TriggerAutoSaveRequest, $6.TriggerAutoSaveResponse>(
        'TriggerAutoSave',
        triggerAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.TriggerAutoSaveRequest.fromBuffer(value),
        ($6.TriggerAutoSaveResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.CreateAutoSaveRuleResponse> createAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$6.CreateAutoSaveRuleRequest> request) async {
    return createAutoSaveRule(call, await request);
  }

  $async.Future<$6.GetAutoSaveRulesResponse> getAutoSaveRules_Pre($grpc.ServiceCall call, $async.Future<$6.GetAutoSaveRulesRequest> request) async {
    return getAutoSaveRules(call, await request);
  }

  $async.Future<$6.UpdateAutoSaveRuleResponse> updateAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$6.UpdateAutoSaveRuleRequest> request) async {
    return updateAutoSaveRule(call, await request);
  }

  $async.Future<$6.ToggleAutoSaveRuleResponse> toggleAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$6.ToggleAutoSaveRuleRequest> request) async {
    return toggleAutoSaveRule(call, await request);
  }

  $async.Future<$6.DeleteAutoSaveRuleResponse> deleteAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$6.DeleteAutoSaveRuleRequest> request) async {
    return deleteAutoSaveRule(call, await request);
  }

  $async.Future<$6.GetAutoSaveTransactionsResponse> getAutoSaveTransactions_Pre($grpc.ServiceCall call, $async.Future<$6.GetAutoSaveTransactionsRequest> request) async {
    return getAutoSaveTransactions(call, await request);
  }

  $async.Future<$6.GetAutoSaveStatisticsResponse> getAutoSaveStatistics_Pre($grpc.ServiceCall call, $async.Future<$6.GetAutoSaveStatisticsRequest> request) async {
    return getAutoSaveStatistics(call, await request);
  }

  $async.Future<$6.TriggerAutoSaveResponse> triggerAutoSave_Pre($grpc.ServiceCall call, $async.Future<$6.TriggerAutoSaveRequest> request) async {
    return triggerAutoSave(call, await request);
  }

  $async.Future<$6.CreateAutoSaveRuleResponse> createAutoSaveRule($grpc.ServiceCall call, $6.CreateAutoSaveRuleRequest request);
  $async.Future<$6.GetAutoSaveRulesResponse> getAutoSaveRules($grpc.ServiceCall call, $6.GetAutoSaveRulesRequest request);
  $async.Future<$6.UpdateAutoSaveRuleResponse> updateAutoSaveRule($grpc.ServiceCall call, $6.UpdateAutoSaveRuleRequest request);
  $async.Future<$6.ToggleAutoSaveRuleResponse> toggleAutoSaveRule($grpc.ServiceCall call, $6.ToggleAutoSaveRuleRequest request);
  $async.Future<$6.DeleteAutoSaveRuleResponse> deleteAutoSaveRule($grpc.ServiceCall call, $6.DeleteAutoSaveRuleRequest request);
  $async.Future<$6.GetAutoSaveTransactionsResponse> getAutoSaveTransactions($grpc.ServiceCall call, $6.GetAutoSaveTransactionsRequest request);
  $async.Future<$6.GetAutoSaveStatisticsResponse> getAutoSaveStatistics($grpc.ServiceCall call, $6.GetAutoSaveStatisticsRequest request);
  $async.Future<$6.TriggerAutoSaveResponse> triggerAutoSave($grpc.ServiceCall call, $6.TriggerAutoSaveRequest request);
}
