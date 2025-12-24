///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $7;
export 'chat.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$sendMessage =
      $grpc.ClientMethod<$7.SendMessageRequest, $7.SendMessageResponse>(
          '/pb.ChatService/SendMessage',
          ($7.SendMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.SendMessageResponse.fromBuffer(value));
  static final _$getChatHistory =
      $grpc.ClientMethod<$7.GetChatHistoryRequest, $7.GetChatHistoryResponse>(
          '/pb.ChatService/GetChatHistory',
          ($7.GetChatHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GetChatHistoryResponse.fromBuffer(value));
  static final _$streamChatMessages =
      $grpc.ClientMethod<$7.StreamChatHistoryRequest, $7.ChatMessage>(
          '/pb.ChatService/StreamChatMessages',
          ($7.StreamChatHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.ChatMessage.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$7.SendMessageResponse> sendMessage(
      $7.SendMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetChatHistoryResponse> getChatHistory(
      $7.GetChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatHistory, request, options: options);
  }

  $grpc.ResponseStream<$7.ChatMessage> streamChatMessages(
      $7.StreamChatHistoryRequest request,
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
        $grpc.ServiceMethod<$7.SendMessageRequest, $7.SendMessageResponse>(
            'SendMessage',
            sendMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.SendMessageRequest.fromBuffer(value),
            ($7.SendMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetChatHistoryRequest,
            $7.GetChatHistoryResponse>(
        'GetChatHistory',
        getChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetChatHistoryRequest.fromBuffer(value),
        ($7.GetChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.StreamChatHistoryRequest, $7.ChatMessage>(
        'StreamChatMessages',
        streamChatMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $7.StreamChatHistoryRequest.fromBuffer(value),
        ($7.ChatMessage value) => value.writeToBuffer()));
  }

  $async.Future<$7.SendMessageResponse> sendMessage_Pre($grpc.ServiceCall call,
      $async.Future<$7.SendMessageRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$7.GetChatHistoryResponse> getChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetChatHistoryRequest> request) async {
    return getChatHistory(call, await request);
  }

  $async.Stream<$7.ChatMessage> streamChatMessages_Pre($grpc.ServiceCall call,
      $async.Future<$7.StreamChatHistoryRequest> request) async* {
    yield* streamChatMessages(call, await request);
  }

  $async.Future<$7.SendMessageResponse> sendMessage(
      $grpc.ServiceCall call, $7.SendMessageRequest request);
  $async.Future<$7.GetChatHistoryResponse> getChatHistory(
      $grpc.ServiceCall call, $7.GetChatHistoryRequest request);
  $async.Stream<$7.ChatMessage> streamChatMessages(
      $grpc.ServiceCall call, $7.StreamChatHistoryRequest request);
}
