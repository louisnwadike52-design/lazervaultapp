///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $5;
export 'chat.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$sendMessage =
      $grpc.ClientMethod<$5.SendMessageRequest, $5.SendMessageResponse>(
          '/pb.ChatService/SendMessage',
          ($5.SendMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.SendMessageResponse.fromBuffer(value));
  static final _$getChatHistory =
      $grpc.ClientMethod<$5.GetChatHistoryRequest, $5.GetChatHistoryResponse>(
          '/pb.ChatService/GetChatHistory',
          ($5.GetChatHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.GetChatHistoryResponse.fromBuffer(value));
  static final _$streamChatMessages =
      $grpc.ClientMethod<$5.StreamChatHistoryRequest, $5.ChatMessage>(
          '/pb.ChatService/StreamChatMessages',
          ($5.StreamChatHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.ChatMessage.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.SendMessageResponse> sendMessage(
      $5.SendMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$5.GetChatHistoryResponse> getChatHistory(
      $5.GetChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatHistory, request, options: options);
  }

  $grpc.ResponseStream<$5.ChatMessage> streamChatMessages(
      $5.StreamChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$streamChatMessages, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ChatService';

  ChatServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$5.SendMessageRequest, $5.SendMessageResponse>(
            'SendMessage',
            sendMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.SendMessageRequest.fromBuffer(value),
            ($5.SendMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetChatHistoryRequest,
            $5.GetChatHistoryResponse>(
        'GetChatHistory',
        getChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.GetChatHistoryRequest.fromBuffer(value),
        ($5.GetChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.StreamChatHistoryRequest, $5.ChatMessage>(
        'StreamChatMessages',
        streamChatMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $5.StreamChatHistoryRequest.fromBuffer(value),
        ($5.ChatMessage value) => value.writeToBuffer()));
  }

  $async.Future<$5.SendMessageResponse> sendMessage_Pre($grpc.ServiceCall call,
      $async.Future<$5.SendMessageRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$5.GetChatHistoryResponse> getChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.GetChatHistoryRequest> request) async {
    return getChatHistory(call, await request);
  }

  $async.Stream<$5.ChatMessage> streamChatMessages_Pre($grpc.ServiceCall call,
      $async.Future<$5.StreamChatHistoryRequest> request) async* {
    yield* streamChatMessages(call, await request);
  }

  $async.Future<$5.SendMessageResponse> sendMessage(
      $grpc.ServiceCall call, $5.SendMessageRequest request);
  $async.Future<$5.GetChatHistoryResponse> getChatHistory(
      $grpc.ServiceCall call, $5.GetChatHistoryRequest request);
  $async.Stream<$5.ChatMessage> streamChatMessages(
      $grpc.ServiceCall call, $5.StreamChatHistoryRequest request);
}
