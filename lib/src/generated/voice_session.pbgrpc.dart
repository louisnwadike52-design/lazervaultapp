///
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice_session.pb.dart' as $23;
export 'voice_session.pb.dart';

class VoiceSessionServiceClient extends $grpc.Client {
  static final _$startVoiceSession = $grpc.ClientMethod<
          $23.StartVoiceSessionRequest, $23.StartVoiceSessionResponse>(
      '/pb.VoiceSessionService/StartVoiceSession',
      ($23.StartVoiceSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.StartVoiceSessionResponse.fromBuffer(value));

  VoiceSessionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$23.StartVoiceSessionResponse> startVoiceSession(
      $23.StartVoiceSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startVoiceSession, request, options: options);
  }
}

abstract class VoiceSessionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.VoiceSessionService';

  VoiceSessionServiceBase() {
    $addMethod($grpc.ServiceMethod<$23.StartVoiceSessionRequest,
            $23.StartVoiceSessionResponse>(
        'StartVoiceSession',
        startVoiceSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.StartVoiceSessionRequest.fromBuffer(value),
        ($23.StartVoiceSessionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.StartVoiceSessionResponse> startVoiceSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.StartVoiceSessionRequest> request) async {
    return startVoiceSession(call, await request);
  }

  $async.Future<$23.StartVoiceSessionResponse> startVoiceSession(
      $grpc.ServiceCall call, $23.StartVoiceSessionRequest request);
}
