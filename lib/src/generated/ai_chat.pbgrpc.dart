///
//  Generated code. Do not modify.
//  source: ai_chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ai_chat.pb.dart' as $3;
export 'ai_chat.pb.dart';

class AIChatServiceClient extends $grpc.Client {
  static final _$processChat =
      $grpc.ClientMethod<$3.ProcessChatRequest, $3.ProcessChatResponse>(
          '/pb.AIChatService/ProcessChat',
          ($3.ProcessChatRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.ProcessChatResponse.fromBuffer(value));
  static final _$indexChatHistory = $grpc.ClientMethod<
          $3.IndexChatHistoryRequest, $3.IndexChatHistoryResponse>(
      '/pb.AIChatService/IndexChatHistory',
      ($3.IndexChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.IndexChatHistoryResponse.fromBuffer(value));
  static final _$indexTransactionFile = $grpc.ClientMethod<
          $3.IndexTransactionFileRequest, $3.IndexTransactionFileResponse>(
      '/pb.AIChatService/IndexTransactionFile',
      ($3.IndexTransactionFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.IndexTransactionFileResponse.fromBuffer(value));
  static final _$getAIChatHistory = $grpc.ClientMethod<
          $3.GetAIChatHistoryRequest, $3.GetAIChatHistoryResponse>(
      '/pb.AIChatService/GetAIChatHistory',
      ($3.GetAIChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.GetAIChatHistoryResponse.fromBuffer(value));

  AIChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.ProcessChatResponse> processChat(
      $3.ProcessChatRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processChat, request, options: options);
  }

  $grpc.ResponseFuture<$3.IndexChatHistoryResponse> indexChatHistory(
      $3.IndexChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$indexChatHistory, request, options: options);
  }

  $grpc.ResponseFuture<$3.IndexTransactionFileResponse> indexTransactionFile(
      $3.IndexTransactionFileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$indexTransactionFile, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetAIChatHistoryResponse> getAIChatHistory(
      $3.GetAIChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIChatHistory, request, options: options);
  }
}

abstract class AIChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AIChatService';

  AIChatServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$3.ProcessChatRequest, $3.ProcessChatResponse>(
            'ProcessChat',
            processChat_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.ProcessChatRequest.fromBuffer(value),
            ($3.ProcessChatResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.IndexChatHistoryRequest,
            $3.IndexChatHistoryResponse>(
        'IndexChatHistory',
        indexChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.IndexChatHistoryRequest.fromBuffer(value),
        ($3.IndexChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.IndexTransactionFileRequest,
            $3.IndexTransactionFileResponse>(
        'IndexTransactionFile',
        indexTransactionFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.IndexTransactionFileRequest.fromBuffer(value),
        ($3.IndexTransactionFileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetAIChatHistoryRequest,
            $3.GetAIChatHistoryResponse>(
        'GetAIChatHistory',
        getAIChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.GetAIChatHistoryRequest.fromBuffer(value),
        ($3.GetAIChatHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.ProcessChatResponse> processChat_Pre($grpc.ServiceCall call,
      $async.Future<$3.ProcessChatRequest> request) async {
    return processChat(call, await request);
  }

  $async.Future<$3.IndexChatHistoryResponse> indexChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.IndexChatHistoryRequest> request) async {
    return indexChatHistory(call, await request);
  }

  $async.Future<$3.IndexTransactionFileResponse> indexTransactionFile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.IndexTransactionFileRequest> request) async {
    return indexTransactionFile(call, await request);
  }

  $async.Future<$3.GetAIChatHistoryResponse> getAIChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.GetAIChatHistoryRequest> request) async {
    return getAIChatHistory(call, await request);
  }

  $async.Future<$3.ProcessChatResponse> processChat(
      $grpc.ServiceCall call, $3.ProcessChatRequest request);
  $async.Future<$3.IndexChatHistoryResponse> indexChatHistory(
      $grpc.ServiceCall call, $3.IndexChatHistoryRequest request);
  $async.Future<$3.IndexTransactionFileResponse> indexTransactionFile(
      $grpc.ServiceCall call, $3.IndexTransactionFileRequest request);
  $async.Future<$3.GetAIChatHistoryResponse> getAIChatHistory(
      $grpc.ServiceCall call, $3.GetAIChatHistoryRequest request);
}
