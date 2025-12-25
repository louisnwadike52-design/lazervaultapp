///
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice_session.pb.dart' as $26;
export 'voice_session.pb.dart';

class VoiceSessionServiceClient extends $grpc.Client {
  static final _$startVoiceSession = $grpc.ClientMethod<
          $26.StartVoiceSessionRequest, $26.StartVoiceSessionResponse>(
      '/pb.VoiceSessionService/StartVoiceSession',
      ($26.StartVoiceSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.StartVoiceSessionResponse.fromBuffer(value));

  VoiceSessionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$26.StartVoiceSessionResponse> startVoiceSession(
      $26.StartVoiceSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startVoiceSession, request, options: options);
  }
}

abstract class VoiceSessionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.VoiceSessionService';

  VoiceSessionServiceBase() {
    $addMethod($grpc.ServiceMethod<$26.StartVoiceSessionRequest,
            $26.StartVoiceSessionResponse>(
        'StartVoiceSession',
        startVoiceSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.StartVoiceSessionRequest.fromBuffer(value),
        ($26.StartVoiceSessionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$26.StartVoiceSessionResponse> startVoiceSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.StartVoiceSessionRequest> request) async {
    return startVoiceSession(call, await request);
  }

  $async.Future<$26.StartVoiceSessionResponse> startVoiceSession(
      $grpc.ServiceCall call, $26.StartVoiceSessionRequest request);
}
