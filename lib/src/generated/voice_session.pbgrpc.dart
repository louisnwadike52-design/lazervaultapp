//
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'voice_session.pb.dart' as $14;

export 'voice_session.pb.dart';

@$pb.GrpcServiceName('pb.VoiceSessionService')
class VoiceSessionServiceClient extends $grpc.Client {
  static final _$startVoiceSession = $grpc.ClientMethod<$14.StartVoiceSessionRequest, $14.StartVoiceSessionResponse>(
      '/pb.VoiceSessionService/StartVoiceSession',
      ($14.StartVoiceSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $14.StartVoiceSessionResponse.fromBuffer(value));

  VoiceSessionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$14.StartVoiceSessionResponse> startVoiceSession($14.StartVoiceSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startVoiceSession, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.VoiceSessionService')
abstract class VoiceSessionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.VoiceSessionService';

  VoiceSessionServiceBase() {
    $addMethod($grpc.ServiceMethod<$14.StartVoiceSessionRequest, $14.StartVoiceSessionResponse>(
        'StartVoiceSession',
        startVoiceSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.StartVoiceSessionRequest.fromBuffer(value),
        ($14.StartVoiceSessionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.StartVoiceSessionResponse> startVoiceSession_Pre($grpc.ServiceCall $call, $async.Future<$14.StartVoiceSessionRequest> $request) async {
    return startVoiceSession($call, await $request);
  }

  $async.Future<$14.StartVoiceSessionResponse> startVoiceSession($grpc.ServiceCall call, $14.StartVoiceSessionRequest request);
}
