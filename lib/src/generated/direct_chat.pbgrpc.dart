///
//  Generated code. Do not modify.
//  source: direct_chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'direct_chat.pb.dart' as $14;
export 'direct_chat.pb.dart';

class DirectChatServiceClient extends $grpc.Client {
  static final _$sendDirectMessage = $grpc.ClientMethod<
          $14.SendDirectMessageRequest, $14.SendDirectMessageResponse>(
      '/directchat.DirectChatService/SendDirectMessage',
      ($14.SendDirectMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.SendDirectMessageResponse.fromBuffer(value));
  static final _$getDirectChatHistory = $grpc.ClientMethod<
          $14.GetDirectChatHistoryRequest, $14.GetDirectChatHistoryResponse>(
      '/directchat.DirectChatService/GetDirectChatHistory',
      ($14.GetDirectChatHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetDirectChatHistoryResponse.fromBuffer(value));

  DirectChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$14.SendDirectMessageResponse> sendDirectMessage(
      $14.SendDirectMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendDirectMessage, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetDirectChatHistoryResponse> getDirectChatHistory(
      $14.GetDirectChatHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDirectChatHistory, request, options: options);
  }
}

abstract class DirectChatServiceBase extends $grpc.Service {
  $core.String get $name => 'directchat.DirectChatService';

  DirectChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$14.SendDirectMessageRequest,
            $14.SendDirectMessageResponse>(
        'SendDirectMessage',
        sendDirectMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.SendDirectMessageRequest.fromBuffer(value),
        ($14.SendDirectMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetDirectChatHistoryRequest,
            $14.GetDirectChatHistoryResponse>(
        'GetDirectChatHistory',
        getDirectChatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetDirectChatHistoryRequest.fromBuffer(value),
        ($14.GetDirectChatHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.SendDirectMessageResponse> sendDirectMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.SendDirectMessageRequest> request) async {
    return sendDirectMessage(call, await request);
  }

  $async.Future<$14.GetDirectChatHistoryResponse> getDirectChatHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GetDirectChatHistoryRequest> request) async {
    return getDirectChatHistory(call, await request);
  }

  $async.Future<$14.SendDirectMessageResponse> sendDirectMessage(
      $grpc.ServiceCall call, $14.SendDirectMessageRequest request);
  $async.Future<$14.GetDirectChatHistoryResponse> getDirectChatHistory(
      $grpc.ServiceCall call, $14.GetDirectChatHistoryRequest request);
}
