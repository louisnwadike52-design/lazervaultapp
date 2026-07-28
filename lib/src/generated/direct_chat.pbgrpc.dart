// This is a generated file - do not edit.
//
// Generated from direct_chat.proto.

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

import 'direct_chat.pb.dart' as $0;

export 'direct_chat.pb.dart';

@$pb.GrpcServiceName('directchat.DirectChatService')
class DirectChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DirectChatServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.SendDirectMessageResponse> sendDirectMessage(
    $0.SendDirectMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendDirectMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDirectChatHistoryResponse> getDirectChatHistory(
    $0.GetDirectChatHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDirectChatHistory, request, options: options);
  }

  // method descriptors

  static final _$sendDirectMessage = $grpc.ClientMethod<
          $0.SendDirectMessageRequest, $0.SendDirectMessageResponse>(
      '/directchat.DirectChatService/SendDirectMessage',
      ($0.SendDirectMessageRequest value) => value.writeToBuffer(),
      $0.SendDirectMessageResponse.fromBuffer);
  static final _$getDirectChatHistory = $grpc.ClientMethod<
          $0.GetDirectChatHistoryRequest, $0.GetDirectChatHistoryResponse>(
      '/directchat.DirectChatService/GetDirectChatHistory',
      ($0.GetDirectChatHistoryRequest value) => value.writeToBuffer(),
      $0.GetDirectChatHistoryResponse.fromBuffer);
}

@$pb.GrpcServiceName('directchat.DirectChatService')
abstract class DirectChatServiceBase extends $grpc.Service {
  $core.String get $name => 'directchat.DirectChatService';

  DirectChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SendDirectMessageRequest,
            $0.SendDirectMessageResponse>(
        'SendDirectMessage',
        sendDirectMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendDirectMessageRequest.fromBuffer(value),
        ($0.SendDirectMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDirectChatHistoryRequest,
            $0.GetDirectChatHistoryResponse>(
        'GetDirectChatHistory',
        getDirectChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDirectChatHistoryRequest.fromBuffer(value),
        ($0.GetDirectChatHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendDirectMessageResponse> sendDirectMessage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SendDirectMessageRequest> $request) async {
    return sendDirectMessage($call, await $request);
  }

  $async.Future<$0.SendDirectMessageResponse> sendDirectMessage(
      $grpc.ServiceCall call, $0.SendDirectMessageRequest request);

  $async.Future<$0.GetDirectChatHistoryResponse> getDirectChatHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDirectChatHistoryRequest> $request) async {
    return getDirectChatHistory($call, await $request);
  }

  $async.Future<$0.GetDirectChatHistoryResponse> getDirectChatHistory(
      $grpc.ServiceCall call, $0.GetDirectChatHistoryRequest request);
}
