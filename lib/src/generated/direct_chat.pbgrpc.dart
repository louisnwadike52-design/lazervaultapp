//
//  Generated code. Do not modify.
//  source: direct_chat.proto
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

import 'direct_chat.pb.dart' as $0;

export 'direct_chat.pb.dart';

@$pb.GrpcServiceName('directchat.DirectChatService')
class DirectChatServiceClient extends $grpc.Client {
  static final _$sendDirectMessage = $grpc.ClientMethod<$0.SendDirectMessageRequest, $0.SendDirectMessageResponse>(
      '/directchat.DirectChatService/SendDirectMessage',
      ($0.SendDirectMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendDirectMessageResponse.fromBuffer(value));
  static final _$getDirectChatHistory = $grpc.ClientMethod<$0.GetDirectChatHistoryRequest, $0.GetDirectChatHistoryResponse>(
      '/directchat.DirectChatService/GetDirectChatHistory',
      ($0.GetDirectChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetDirectChatHistoryResponse.fromBuffer(value));

  DirectChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SendDirectMessageResponse> sendDirectMessage($0.SendDirectMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendDirectMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDirectChatHistoryResponse> getDirectChatHistory($0.GetDirectChatHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDirectChatHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('directchat.DirectChatService')
abstract class DirectChatServiceBase extends $grpc.Service {
  $core.String get $name => 'directchat.DirectChatService';

  DirectChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SendDirectMessageRequest, $0.SendDirectMessageResponse>(
        'SendDirectMessage',
        sendDirectMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendDirectMessageRequest.fromBuffer(value),
        ($0.SendDirectMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDirectChatHistoryRequest, $0.GetDirectChatHistoryResponse>(
        'GetDirectChatHistory',
        getDirectChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDirectChatHistoryRequest.fromBuffer(value),
        ($0.GetDirectChatHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendDirectMessageResponse> sendDirectMessage_Pre($grpc.ServiceCall call, $async.Future<$0.SendDirectMessageRequest> request) async {
    return sendDirectMessage(call, await request);
  }

  $async.Future<$0.GetDirectChatHistoryResponse> getDirectChatHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetDirectChatHistoryRequest> request) async {
    return getDirectChatHistory(call, await request);
  }

  $async.Future<$0.SendDirectMessageResponse> sendDirectMessage($grpc.ServiceCall call, $0.SendDirectMessageRequest request);
  $async.Future<$0.GetDirectChatHistoryResponse> getDirectChatHistory($grpc.ServiceCall call, $0.GetDirectChatHistoryRequest request);
}
