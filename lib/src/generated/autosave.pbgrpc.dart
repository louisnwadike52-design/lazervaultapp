///
//  Generated code. Do not modify.
//  source: autosave.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'autosave.pb.dart' as $5;
export 'autosave.pb.dart';

class AutoSaveServiceClient extends $grpc.Client {
  static final _$createAutoSaveRule = $grpc.ClientMethod<
          $5.CreateAutoSaveRuleRequest, $5.CreateAutoSaveRuleResponse>(
      '/pb.AutoSaveService/CreateAutoSaveRule',
      ($5.CreateAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.CreateAutoSaveRuleResponse.fromBuffer(value));
  static final _$getAutoSaveRules = $grpc.ClientMethod<
          $5.GetAutoSaveRulesRequest, $5.GetAutoSaveRulesResponse>(
      '/pb.AutoSaveService/GetAutoSaveRules',
      ($5.GetAutoSaveRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.GetAutoSaveRulesResponse.fromBuffer(value));
  static final _$updateAutoSaveRule = $grpc.ClientMethod<
          $5.UpdateAutoSaveRuleRequest, $5.UpdateAutoSaveRuleResponse>(
      '/pb.AutoSaveService/UpdateAutoSaveRule',
      ($5.UpdateAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.UpdateAutoSaveRuleResponse.fromBuffer(value));
  static final _$toggleAutoSaveRule = $grpc.ClientMethod<
          $5.ToggleAutoSaveRuleRequest, $5.ToggleAutoSaveRuleResponse>(
      '/pb.AutoSaveService/ToggleAutoSaveRule',
      ($5.ToggleAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.ToggleAutoSaveRuleResponse.fromBuffer(value));
  static final _$deleteAutoSaveRule = $grpc.ClientMethod<
          $5.DeleteAutoSaveRuleRequest, $5.DeleteAutoSaveRuleResponse>(
      '/pb.AutoSaveService/DeleteAutoSaveRule',
      ($5.DeleteAutoSaveRuleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.DeleteAutoSaveRuleResponse.fromBuffer(value));
  static final _$getAutoSaveTransactions = $grpc.ClientMethod<
          $5.GetAutoSaveTransactionsRequest,
          $5.GetAutoSaveTransactionsResponse>(
      '/pb.AutoSaveService/GetAutoSaveTransactions',
      ($5.GetAutoSaveTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.GetAutoSaveTransactionsResponse.fromBuffer(value));
  static final _$getAutoSaveStatistics = $grpc.ClientMethod<
          $5.GetAutoSaveStatisticsRequest, $5.GetAutoSaveStatisticsResponse>(
      '/pb.AutoSaveService/GetAutoSaveStatistics',
      ($5.GetAutoSaveStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.GetAutoSaveStatisticsResponse.fromBuffer(value));
  static final _$triggerAutoSave =
      $grpc.ClientMethod<$5.TriggerAutoSaveRequest, $5.TriggerAutoSaveResponse>(
          '/pb.AutoSaveService/TriggerAutoSave',
          ($5.TriggerAutoSaveRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.TriggerAutoSaveResponse.fromBuffer(value));

  AutoSaveServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.CreateAutoSaveRuleResponse> createAutoSaveRule(
      $5.CreateAutoSaveRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$5.GetAutoSaveRulesResponse> getAutoSaveRules(
      $5.GetAutoSaveRulesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveRules, request, options: options);
  }

  $grpc.ResponseFuture<$5.UpdateAutoSaveRuleResponse> updateAutoSaveRule(
      $5.UpdateAutoSaveRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$5.ToggleAutoSaveRuleResponse> toggleAutoSaveRule(
      $5.ToggleAutoSaveRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$5.DeleteAutoSaveRuleResponse> deleteAutoSaveRule(
      $5.DeleteAutoSaveRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$5.GetAutoSaveTransactionsResponse>
      getAutoSaveTransactions($5.GetAutoSaveTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$5.GetAutoSaveStatisticsResponse> getAutoSaveStatistics(
      $5.GetAutoSaveStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$5.TriggerAutoSaveResponse> triggerAutoSave(
      $5.TriggerAutoSaveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoSave, request, options: options);
  }
}

abstract class AutoSaveServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AutoSaveService';

  AutoSaveServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.CreateAutoSaveRuleRequest,
            $5.CreateAutoSaveRuleResponse>(
        'CreateAutoSaveRule',
        createAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.CreateAutoSaveRuleRequest.fromBuffer(value),
        ($5.CreateAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetAutoSaveRulesRequest,
            $5.GetAutoSaveRulesResponse>(
        'GetAutoSaveRules',
        getAutoSaveRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.GetAutoSaveRulesRequest.fromBuffer(value),
        ($5.GetAutoSaveRulesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.UpdateAutoSaveRuleRequest,
            $5.UpdateAutoSaveRuleResponse>(
        'UpdateAutoSaveRule',
        updateAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.UpdateAutoSaveRuleRequest.fromBuffer(value),
        ($5.UpdateAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ToggleAutoSaveRuleRequest,
            $5.ToggleAutoSaveRuleResponse>(
        'ToggleAutoSaveRule',
        toggleAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.ToggleAutoSaveRuleRequest.fromBuffer(value),
        ($5.ToggleAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.DeleteAutoSaveRuleRequest,
            $5.DeleteAutoSaveRuleResponse>(
        'DeleteAutoSaveRule',
        deleteAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.DeleteAutoSaveRuleRequest.fromBuffer(value),
        ($5.DeleteAutoSaveRuleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetAutoSaveTransactionsRequest,
            $5.GetAutoSaveTransactionsResponse>(
        'GetAutoSaveTransactions',
        getAutoSaveTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.GetAutoSaveTransactionsRequest.fromBuffer(value),
        ($5.GetAutoSaveTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetAutoSaveStatisticsRequest,
            $5.GetAutoSaveStatisticsResponse>(
        'GetAutoSaveStatistics',
        getAutoSaveStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.GetAutoSaveStatisticsRequest.fromBuffer(value),
        ($5.GetAutoSaveStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.TriggerAutoSaveRequest,
            $5.TriggerAutoSaveResponse>(
        'TriggerAutoSave',
        triggerAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.TriggerAutoSaveRequest.fromBuffer(value),
        ($5.TriggerAutoSaveResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.CreateAutoSaveRuleResponse> createAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.CreateAutoSaveRuleRequest> request) async {
    return createAutoSaveRule(call, await request);
  }

  $async.Future<$5.GetAutoSaveRulesResponse> getAutoSaveRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.GetAutoSaveRulesRequest> request) async {
    return getAutoSaveRules(call, await request);
  }

  $async.Future<$5.UpdateAutoSaveRuleResponse> updateAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.UpdateAutoSaveRuleRequest> request) async {
    return updateAutoSaveRule(call, await request);
  }

  $async.Future<$5.ToggleAutoSaveRuleResponse> toggleAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.ToggleAutoSaveRuleRequest> request) async {
    return toggleAutoSaveRule(call, await request);
  }

  $async.Future<$5.DeleteAutoSaveRuleResponse> deleteAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.DeleteAutoSaveRuleRequest> request) async {
    return deleteAutoSaveRule(call, await request);
  }

  $async.Future<$5.GetAutoSaveTransactionsResponse> getAutoSaveTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.GetAutoSaveTransactionsRequest> request) async {
    return getAutoSaveTransactions(call, await request);
  }

  $async.Future<$5.GetAutoSaveStatisticsResponse> getAutoSaveStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.GetAutoSaveStatisticsRequest> request) async {
    return getAutoSaveStatistics(call, await request);
  }

  $async.Future<$5.TriggerAutoSaveResponse> triggerAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.TriggerAutoSaveRequest> request) async {
    return triggerAutoSave(call, await request);
  }

  $async.Future<$5.CreateAutoSaveRuleResponse> createAutoSaveRule(
      $grpc.ServiceCall call, $5.CreateAutoSaveRuleRequest request);
  $async.Future<$5.GetAutoSaveRulesResponse> getAutoSaveRules(
      $grpc.ServiceCall call, $5.GetAutoSaveRulesRequest request);
  $async.Future<$5.UpdateAutoSaveRuleResponse> updateAutoSaveRule(
      $grpc.ServiceCall call, $5.UpdateAutoSaveRuleRequest request);
  $async.Future<$5.ToggleAutoSaveRuleResponse> toggleAutoSaveRule(
      $grpc.ServiceCall call, $5.ToggleAutoSaveRuleRequest request);
  $async.Future<$5.DeleteAutoSaveRuleResponse> deleteAutoSaveRule(
      $grpc.ServiceCall call, $5.DeleteAutoSaveRuleRequest request);
  $async.Future<$5.GetAutoSaveTransactionsResponse> getAutoSaveTransactions(
      $grpc.ServiceCall call, $5.GetAutoSaveTransactionsRequest request);
  $async.Future<$5.GetAutoSaveStatisticsResponse> getAutoSaveStatistics(
      $grpc.ServiceCall call, $5.GetAutoSaveStatisticsRequest request);
  $async.Future<$5.TriggerAutoSaveResponse> triggerAutoSave(
      $grpc.ServiceCall call, $5.TriggerAutoSaveRequest request);
}
