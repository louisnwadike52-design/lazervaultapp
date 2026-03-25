// This is a generated file - do not edit.
//
// Generated from chat.proto.

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

import 'chat.pb.dart' as $0;

export 'chat.pb.dart';

/// Service definition for chat operations
@$pb.GrpcServiceName('pb.ChatService')
class ChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ChatServiceClient(super.channel, {super.options, super.interceptors});

  /// Send a new chat message
  $grpc.ResponseFuture<$0.SendMessageResponse> sendMessage(
    $0.SendMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  /// Get the chat history with another user (paginated)
  $grpc.ResponseFuture<$0.GetChatHistoryResponse> getChatHistory(
    $0.GetChatHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getChatHistory, request, options: options);
  }

  /// Stream new chat messages in real-time
  $grpc.ResponseStream<$0.ChatMessage> streamChatMessages(
    $0.StreamChatHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamChatMessages, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$sendMessage =
      $grpc.ClientMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
          '/pb.ChatService/SendMessage',
          ($0.SendMessageRequest value) => value.writeToBuffer(),
          $0.SendMessageResponse.fromBuffer);
  static final _$getChatHistory =
      $grpc.ClientMethod<$0.GetChatHistoryRequest, $0.GetChatHistoryResponse>(
          '/pb.ChatService/GetChatHistory',
          ($0.GetChatHistoryRequest value) => value.writeToBuffer(),
          $0.GetChatHistoryResponse.fromBuffer);
  static final _$streamChatMessages =
      $grpc.ClientMethod<$0.StreamChatHistoryRequest, $0.ChatMessage>(
          '/pb.ChatService/StreamChatMessages',
          ($0.StreamChatHistoryRequest value) => value.writeToBuffer(),
          $0.ChatMessage.fromBuffer);
}

@$pb.GrpcServiceName('pb.ChatService')
abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ChatService';

  ChatServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
            'SendMessage',
            sendMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SendMessageRequest.fromBuffer(value),
            ($0.SendMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetChatHistoryRequest,
            $0.GetChatHistoryResponse>(
        'GetChatHistory',
        getChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetChatHistoryRequest.fromBuffer(value),
        ($0.GetChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StreamChatHistoryRequest, $0.ChatMessage>(
        'StreamChatMessages',
        streamChatMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.StreamChatHistoryRequest.fromBuffer(value),
        ($0.ChatMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendMessageResponse> sendMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SendMessageRequest> $request) async {
    return sendMessage($call, await $request);
  }

  $async.Future<$0.SendMessageResponse> sendMessage(
      $grpc.ServiceCall call, $0.SendMessageRequest request);

  $async.Future<$0.GetChatHistoryResponse> getChatHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetChatHistoryRequest> $request) async {
    return getChatHistory($call, await $request);
  }

  $async.Future<$0.GetChatHistoryResponse> getChatHistory(
      $grpc.ServiceCall call, $0.GetChatHistoryRequest request);

  $async.Stream<$0.ChatMessage> streamChatMessages_Pre($grpc.ServiceCall $call,
      $async.Future<$0.StreamChatHistoryRequest> $request) async* {
    yield* streamChatMessages($call, await $request);
  }

  $async.Stream<$0.ChatMessage> streamChatMessages(
      $grpc.ServiceCall call, $0.StreamChatHistoryRequest request);
}
