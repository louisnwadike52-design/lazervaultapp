//
//  Generated code. Do not modify.
//  source: chat.proto
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

import 'chat.pb.dart' as $9;

export 'chat.pb.dart';

@$pb.GrpcServiceName('pb.ChatService')
class ChatServiceClient extends $grpc.Client {
  static final _$sendMessage = $grpc.ClientMethod<$9.SendMessageRequest, $9.SendMessageResponse>(
      '/pb.ChatService/SendMessage',
      ($9.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $9.SendMessageResponse.fromBuffer(value));
  static final _$getChatHistory = $grpc.ClientMethod<$9.GetChatHistoryRequest, $9.GetChatHistoryResponse>(
      '/pb.ChatService/GetChatHistory',
      ($9.GetChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $9.GetChatHistoryResponse.fromBuffer(value));
  static final _$streamChatMessages = $grpc.ClientMethod<$9.StreamChatHistoryRequest, $9.ChatMessage>(
      '/pb.ChatService/StreamChatMessages',
      ($9.StreamChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $9.ChatMessage.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$9.SendMessageResponse> sendMessage($9.SendMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$9.GetChatHistoryResponse> getChatHistory($9.GetChatHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatHistory, request, options: options);
  }

  $grpc.ResponseStream<$9.ChatMessage> streamChatMessages($9.StreamChatHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamChatMessages, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('pb.ChatService')
abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$9.SendMessageRequest, $9.SendMessageResponse>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $9.SendMessageRequest.fromBuffer(value),
        ($9.SendMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetChatHistoryRequest, $9.GetChatHistoryResponse>(
        'GetChatHistory',
        getChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $9.GetChatHistoryRequest.fromBuffer(value),
        ($9.GetChatHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.StreamChatHistoryRequest, $9.ChatMessage>(
        'StreamChatMessages',
        streamChatMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $9.StreamChatHistoryRequest.fromBuffer(value),
        ($9.ChatMessage value) => value.writeToBuffer()));
  }

  $async.Future<$9.SendMessageResponse> sendMessage_Pre($grpc.ServiceCall call, $async.Future<$9.SendMessageRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$9.GetChatHistoryResponse> getChatHistory_Pre($grpc.ServiceCall call, $async.Future<$9.GetChatHistoryRequest> request) async {
    return getChatHistory(call, await request);
  }

  $async.Stream<$9.ChatMessage> streamChatMessages_Pre($grpc.ServiceCall call, $async.Future<$9.StreamChatHistoryRequest> request) async* {
    yield* streamChatMessages(call, await request);
  }

  $async.Future<$9.SendMessageResponse> sendMessage($grpc.ServiceCall call, $9.SendMessageRequest request);
  $async.Future<$9.GetChatHistoryResponse> getChatHistory($grpc.ServiceCall call, $9.GetChatHistoryRequest request);
  $async.Stream<$9.ChatMessage> streamChatMessages($grpc.ServiceCall call, $9.StreamChatHistoryRequest request);
}
