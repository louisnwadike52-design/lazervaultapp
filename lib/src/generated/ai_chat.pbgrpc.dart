// This is a generated file - do not edit.
//
// Generated from ai_chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ai_chat.pb.dart' as $0;

export 'ai_chat.pb.dart';

/// Service definition for AI chat interactions
@$pb.GrpcServiceName('pb.AIChatService')
class AIChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AIChatServiceClient(super.channel, {super.options, super.interceptors});

  /// Processes a user's query using an external AI chatbot, leveraging user context.
  $grpc.ResponseFuture<$0.ProcessChatResponse> processChat(
    $0.ProcessChatRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processChat, request, options: options);
  }

  /// Triggers indexing for the authenticated user's chat history file.
  $grpc.ResponseFuture<$0.IndexChatHistoryResponse> indexChatHistory(
    $0.IndexChatHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$indexChatHistory, request, options: options);
  }

  /// Triggers indexing for the authenticated user's transaction file.
  $grpc.ResponseFuture<$0.IndexTransactionFileResponse> indexTransactionFile(
    $0.IndexTransactionFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$indexTransactionFile, request, options: options);
  }

  /// Retrieves the AI chat history for the authenticated user.
  $grpc.ResponseFuture<$0.GetAIChatHistoryResponse> getAIChatHistory(
    $0.GetAIChatHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAIChatHistory, request, options: options);
  }

  // method descriptors

  static final _$processChat =
      $grpc.ClientMethod<$0.ProcessChatRequest, $0.ProcessChatResponse>(
          '/pb.AIChatService/ProcessChat',
          ($0.ProcessChatRequest value) => value.writeToBuffer(),
          $0.ProcessChatResponse.fromBuffer);
  static final _$indexChatHistory = $grpc.ClientMethod<
          $0.IndexChatHistoryRequest, $0.IndexChatHistoryResponse>(
      '/pb.AIChatService/IndexChatHistory',
      ($0.IndexChatHistoryRequest value) => value.writeToBuffer(),
      $0.IndexChatHistoryResponse.fromBuffer);
  static final _$indexTransactionFile = $grpc.ClientMethod<
          $0.IndexTransactionFileRequest, $0.IndexTransactionFileResponse>(
      '/pb.AIChatService/IndexTransactionFile',
      ($0.IndexTransactionFileRequest value) => value.writeToBuffer(),
      $0.IndexTransactionFileResponse.fromBuffer);
  static final _$getAIChatHistory = $grpc.ClientMethod<
          $0.GetAIChatHistoryRequest, $0.GetAIChatHistoryResponse>(
      '/pb.AIChatService/GetAIChatHistory',
      ($0.GetAIChatHistoryRequest value) => value.writeToBuffer(),
      $0.GetAIChatHistoryResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.AIChatService')
abstract class AIChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AIChatService';

  AIChatServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.ProcessChatRequest, $0.ProcessChatResponse>(
            'ProcessChat',
            processChat_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ProcessChatRequest.fromBuffer(value),
            ($0.ProcessChatResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.IndexChatHistoryRequest,
            $0.IndexChatHistoryResponse>(
        'IndexChatHistory',
        indexChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.IndexChatHistoryRequest.fromBuffer(value),
        ($0.IndexChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.IndexTransactionFileRequest,
            $0.IndexTransactionFileResponse>(
        'IndexTransactionFile',
        indexTransactionFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.IndexTransactionFileRequest.fromBuffer(value),
        ($0.IndexTransactionFileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAIChatHistoryRequest,
            $0.GetAIChatHistoryResponse>(
        'GetAIChatHistory',
        getAIChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAIChatHistoryRequest.fromBuffer(value),
        ($0.GetAIChatHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ProcessChatResponse> processChat_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ProcessChatRequest> $request) async {
    return processChat($call, await $request);
  }

  $async.Future<$0.ProcessChatResponse> processChat(
      $grpc.ServiceCall call, $0.ProcessChatRequest request);

  $async.Future<$0.IndexChatHistoryResponse> indexChatHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.IndexChatHistoryRequest> $request) async {
    return indexChatHistory($call, await $request);
  }

  $async.Future<$0.IndexChatHistoryResponse> indexChatHistory(
      $grpc.ServiceCall call, $0.IndexChatHistoryRequest request);

  $async.Future<$0.IndexTransactionFileResponse> indexTransactionFile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.IndexTransactionFileRequest> $request) async {
    return indexTransactionFile($call, await $request);
  }

  $async.Future<$0.IndexTransactionFileResponse> indexTransactionFile(
      $grpc.ServiceCall call, $0.IndexTransactionFileRequest request);

  $async.Future<$0.GetAIChatHistoryResponse> getAIChatHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAIChatHistoryRequest> $request) async {
    return getAIChatHistory($call, await $request);
  }

  $async.Future<$0.GetAIChatHistoryResponse> getAIChatHistory(
      $grpc.ServiceCall call, $0.GetAIChatHistoryRequest request);
}
