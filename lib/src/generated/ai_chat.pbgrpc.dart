///
//  Generated code. Do not modify.
//  source: ai_chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ai_chat.pb.dart' as $2;
export 'ai_chat.pb.dart';

class AIChatServiceClient extends $grpc.Client {
  static final _$processChat =
      $grpc.ClientMethod<$2.ProcessChatRequest, $2.ProcessChatResponse>(
          '/pb.AIChatService/ProcessChat',
          ($2.ProcessChatRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ProcessChatResponse.fromBuffer(value));
  static final _$indexChatHistory = $grpc.ClientMethod<
          $2.IndexChatHistoryRequest, $2.IndexChatHistoryResponse>(
      '/pb.AIChatService/IndexChatHistory',
      ($2.IndexChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.IndexChatHistoryResponse.fromBuffer(value));
  static final _$indexTransactionFile = $grpc.ClientMethod<
          $2.IndexTransactionFileRequest, $2.IndexTransactionFileResponse>(
      '/pb.AIChatService/IndexTransactionFile',
      ($2.IndexTransactionFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.IndexTransactionFileResponse.fromBuffer(value));
  static final _$getAIChatHistory = $grpc.ClientMethod<
          $2.GetAIChatHistoryRequest, $2.GetAIChatHistoryResponse>(
      '/pb.AIChatService/GetAIChatHistory',
      ($2.GetAIChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.GetAIChatHistoryResponse.fromBuffer(value));

  AIChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ProcessChatResponse> processChat(
      $2.ProcessChatRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processChat, request, options: options);
  }

  $grpc.ResponseFuture<$2.IndexChatHistoryResponse> indexChatHistory(
      $2.IndexChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$indexChatHistory, request, options: options);
  }

  $grpc.ResponseFuture<$2.IndexTransactionFileResponse> indexTransactionFile(
      $2.IndexTransactionFileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$indexTransactionFile, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetAIChatHistoryResponse> getAIChatHistory(
      $2.GetAIChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIChatHistory, request, options: options);
  }
}

abstract class AIChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AIChatService';

  AIChatServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.ProcessChatRequest, $2.ProcessChatResponse>(
            'ProcessChat',
            processChat_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.ProcessChatRequest.fromBuffer(value),
            ($2.ProcessChatResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IndexChatHistoryRequest,
            $2.IndexChatHistoryResponse>(
        'IndexChatHistory',
        indexChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.IndexChatHistoryRequest.fromBuffer(value),
        ($2.IndexChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IndexTransactionFileRequest,
            $2.IndexTransactionFileResponse>(
        'IndexTransactionFile',
        indexTransactionFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.IndexTransactionFileRequest.fromBuffer(value),
        ($2.IndexTransactionFileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetAIChatHistoryRequest,
            $2.GetAIChatHistoryResponse>(
        'GetAIChatHistory',
        getAIChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetAIChatHistoryRequest.fromBuffer(value),
        ($2.GetAIChatHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.ProcessChatResponse> processChat_Pre($grpc.ServiceCall call,
      $async.Future<$2.ProcessChatRequest> request) async {
    return processChat(call, await request);
  }

  $async.Future<$2.IndexChatHistoryResponse> indexChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.IndexChatHistoryRequest> request) async {
    return indexChatHistory(call, await request);
  }

  $async.Future<$2.IndexTransactionFileResponse> indexTransactionFile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.IndexTransactionFileRequest> request) async {
    return indexTransactionFile(call, await request);
  }

  $async.Future<$2.GetAIChatHistoryResponse> getAIChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.GetAIChatHistoryRequest> request) async {
    return getAIChatHistory(call, await request);
  }

  $async.Future<$2.ProcessChatResponse> processChat(
      $grpc.ServiceCall call, $2.ProcessChatRequest request);
  $async.Future<$2.IndexChatHistoryResponse> indexChatHistory(
      $grpc.ServiceCall call, $2.IndexChatHistoryRequest request);
  $async.Future<$2.IndexTransactionFileResponse> indexTransactionFile(
      $grpc.ServiceCall call, $2.IndexTransactionFileRequest request);
  $async.Future<$2.GetAIChatHistoryResponse> getAIChatHistory(
      $grpc.ServiceCall call, $2.GetAIChatHistoryRequest request);
}
