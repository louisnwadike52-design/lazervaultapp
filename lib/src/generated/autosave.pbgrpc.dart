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

import 'autosave.pb.dart' as $0;

export 'autosave.pb.dart';

@$pb.GrpcServiceName('pb.AutoSaveService')
class AutoSaveServiceClient extends $grpc.Client {
  static final _$createAutoSaveRule = $grpc.ClientMethod<$0.CreateAutoSaveRuleRequest, $0.CreateAutoSaveRuleResponse>(
      '/pb.AutoSaveService/CreateAutoSaveRule',
      ($0.CreateAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateAutoSaveRuleResponse.fromBuffer(value));
  static final _$getAutoSaveRules = $grpc.ClientMethod<$0.GetAutoSaveRulesRequest, $0.GetAutoSaveRulesResponse>(
      '/pb.AutoSaveService/GetAutoSaveRules',
      ($0.GetAutoSaveRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAutoSaveRulesResponse.fromBuffer(value));
  static final _$updateAutoSaveRule = $grpc.ClientMethod<$0.UpdateAutoSaveRuleRequest, $0.UpdateAutoSaveRuleResponse>(
      '/pb.AutoSaveService/UpdateAutoSaveRule',
      ($0.UpdateAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateAutoSaveRuleResponse.fromBuffer(value));
  static final _$toggleAutoSaveRule = $grpc.ClientMethod<$0.ToggleAutoSaveRuleRequest, $0.ToggleAutoSaveRuleResponse>(
      '/pb.AutoSaveService/ToggleAutoSaveRule',
      ($0.ToggleAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ToggleAutoSaveRuleResponse.fromBuffer(value));
  static final _$deleteAutoSaveRule = $grpc.ClientMethod<$0.DeleteAutoSaveRuleRequest, $0.DeleteAutoSaveRuleResponse>(
      '/pb.AutoSaveService/DeleteAutoSaveRule',
      ($0.DeleteAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteAutoSaveRuleResponse.fromBuffer(value));
  static final _$getAutoSaveTransactions = $grpc.ClientMethod<$0.GetAutoSaveTransactionsRequest, $0.GetAutoSaveTransactionsResponse>(
      '/pb.AutoSaveService/GetAutoSaveTransactions',
      ($0.GetAutoSaveTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAutoSaveTransactionsResponse.fromBuffer(value));
  static final _$getAutoSaveStatistics = $grpc.ClientMethod<$0.GetAutoSaveStatisticsRequest, $0.GetAutoSaveStatisticsResponse>(
      '/pb.AutoSaveService/GetAutoSaveStatistics',
      ($0.GetAutoSaveStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAutoSaveStatisticsResponse.fromBuffer(value));
  static final _$triggerAutoSave = $grpc.ClientMethod<$0.TriggerAutoSaveRequest, $0.TriggerAutoSaveResponse>(
      '/pb.AutoSaveService/TriggerAutoSave',
      ($0.TriggerAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TriggerAutoSaveResponse.fromBuffer(value));

  AutoSaveServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateAutoSaveRuleResponse> createAutoSaveRule($0.CreateAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSaveRulesResponse> getAutoSaveRules($0.GetAutoSaveRulesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveRules, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoSaveRuleResponse> updateAutoSaveRule($0.UpdateAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.ToggleAutoSaveRuleResponse> toggleAutoSaveRule($0.ToggleAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAutoSaveRuleResponse> deleteAutoSaveRule($0.DeleteAutoSaveRuleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSaveTransactionsResponse> getAutoSaveTransactions($0.GetAutoSaveTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSaveStatisticsResponse> getAutoSaveStatistics($0.GetAutoSaveStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.TriggerAutoSaveResponse> triggerAutoSave($0.TriggerAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoSave, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.AutoSaveService')
abstract class AutoSaveServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AutoSaveService';

  AutoSaveServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateAutoSaveRuleRequest, $0.CreateAutoSaveRuleResponse>(
        'CreateAutoSaveRule',
        createAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateAutoSaveRuleRequest.fromBuffer(value),
        ($0.CreateAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSaveRulesRequest, $0.GetAutoSaveRulesResponse>(
        'GetAutoSaveRules',
        getAutoSaveRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAutoSaveRulesRequest.fromBuffer(value),
        ($0.GetAutoSaveRulesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoSaveRuleRequest, $0.UpdateAutoSaveRuleResponse>(
        'UpdateAutoSaveRule',
        updateAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateAutoSaveRuleRequest.fromBuffer(value),
        ($0.UpdateAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ToggleAutoSaveRuleRequest, $0.ToggleAutoSaveRuleResponse>(
        'ToggleAutoSaveRule',
        toggleAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ToggleAutoSaveRuleRequest.fromBuffer(value),
        ($0.ToggleAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAutoSaveRuleRequest, $0.DeleteAutoSaveRuleResponse>(
        'DeleteAutoSaveRule',
        deleteAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteAutoSaveRuleRequest.fromBuffer(value),
        ($0.DeleteAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSaveTransactionsRequest, $0.GetAutoSaveTransactionsResponse>(
        'GetAutoSaveTransactions',
        getAutoSaveTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAutoSaveTransactionsRequest.fromBuffer(value),
        ($0.GetAutoSaveTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSaveStatisticsRequest, $0.GetAutoSaveStatisticsResponse>(
        'GetAutoSaveStatistics',
        getAutoSaveStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAutoSaveStatisticsRequest.fromBuffer(value),
        ($0.GetAutoSaveStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerAutoSaveRequest, $0.TriggerAutoSaveResponse>(
        'TriggerAutoSave',
        triggerAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TriggerAutoSaveRequest.fromBuffer(value),
        ($0.TriggerAutoSaveResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateAutoSaveRuleResponse> createAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$0.CreateAutoSaveRuleRequest> request) async {
    return createAutoSaveRule(call, await request);
  }

  $async.Future<$0.GetAutoSaveRulesResponse> getAutoSaveRules_Pre($grpc.ServiceCall call, $async.Future<$0.GetAutoSaveRulesRequest> request) async {
    return getAutoSaveRules(call, await request);
  }

  $async.Future<$0.UpdateAutoSaveRuleResponse> updateAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateAutoSaveRuleRequest> request) async {
    return updateAutoSaveRule(call, await request);
  }

  $async.Future<$0.ToggleAutoSaveRuleResponse> toggleAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$0.ToggleAutoSaveRuleRequest> request) async {
    return toggleAutoSaveRule(call, await request);
  }

  $async.Future<$0.DeleteAutoSaveRuleResponse> deleteAutoSaveRule_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteAutoSaveRuleRequest> request) async {
    return deleteAutoSaveRule(call, await request);
  }

  $async.Future<$0.GetAutoSaveTransactionsResponse> getAutoSaveTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetAutoSaveTransactionsRequest> request) async {
    return getAutoSaveTransactions(call, await request);
  }

  $async.Future<$0.GetAutoSaveStatisticsResponse> getAutoSaveStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetAutoSaveStatisticsRequest> request) async {
    return getAutoSaveStatistics(call, await request);
  }

  $async.Future<$0.TriggerAutoSaveResponse> triggerAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.TriggerAutoSaveRequest> request) async {
    return triggerAutoSave(call, await request);
  }

  $async.Future<$0.CreateAutoSaveRuleResponse> createAutoSaveRule($grpc.ServiceCall call, $0.CreateAutoSaveRuleRequest request);
  $async.Future<$0.GetAutoSaveRulesResponse> getAutoSaveRules($grpc.ServiceCall call, $0.GetAutoSaveRulesRequest request);
  $async.Future<$0.UpdateAutoSaveRuleResponse> updateAutoSaveRule($grpc.ServiceCall call, $0.UpdateAutoSaveRuleRequest request);
  $async.Future<$0.ToggleAutoSaveRuleResponse> toggleAutoSaveRule($grpc.ServiceCall call, $0.ToggleAutoSaveRuleRequest request);
  $async.Future<$0.DeleteAutoSaveRuleResponse> deleteAutoSaveRule($grpc.ServiceCall call, $0.DeleteAutoSaveRuleRequest request);
  $async.Future<$0.GetAutoSaveTransactionsResponse> getAutoSaveTransactions($grpc.ServiceCall call, $0.GetAutoSaveTransactionsRequest request);
  $async.Future<$0.GetAutoSaveStatisticsResponse> getAutoSaveStatistics($grpc.ServiceCall call, $0.GetAutoSaveStatisticsRequest request);
  $async.Future<$0.TriggerAutoSaveResponse> triggerAutoSave($grpc.ServiceCall call, $0.TriggerAutoSaveRequest request);
}
