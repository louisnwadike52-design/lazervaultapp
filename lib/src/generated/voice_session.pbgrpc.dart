//
//  Generated code. Do not modify.
//  source: voice_session.proto
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

import 'voice_session.pb.dart' as $38;

export 'voice_session.pb.dart';

@$pb.GrpcServiceName('pb.VoiceSessionService')
class VoiceSessionServiceClient extends $grpc.Client {
  static final _$startVoiceSession = $grpc.ClientMethod<$38.StartVoiceSessionRequest, $38.StartVoiceSessionResponse>(
      '/pb.VoiceSessionService/StartVoiceSession',
      ($38.StartVoiceSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $38.StartVoiceSessionResponse.fromBuffer(value));
  static final _$processVoiceNote = $grpc.ClientMethod<$38.ProcessVoiceNoteRequest, $38.ProcessVoiceNoteResponse>(
      '/pb.VoiceSessionService/ProcessVoiceNote',
      ($38.ProcessVoiceNoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $38.ProcessVoiceNoteResponse.fromBuffer(value));

  VoiceSessionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$38.StartVoiceSessionResponse> startVoiceSession($38.StartVoiceSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startVoiceSession, request, options: options);
  }

  $grpc.ResponseFuture<$38.ProcessVoiceNoteResponse> processVoiceNote($38.ProcessVoiceNoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processVoiceNote, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.VoiceSessionService')
abstract class VoiceSessionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.VoiceSessionService';

  VoiceSessionServiceBase() {
    $addMethod($grpc.ServiceMethod<$38.StartVoiceSessionRequest, $38.StartVoiceSessionResponse>(
        'StartVoiceSession',
        startVoiceSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $38.StartVoiceSessionRequest.fromBuffer(value),
        ($38.StartVoiceSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.ProcessVoiceNoteRequest, $38.ProcessVoiceNoteResponse>(
        'ProcessVoiceNote',
        processVoiceNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $38.ProcessVoiceNoteRequest.fromBuffer(value),
        ($38.ProcessVoiceNoteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$38.StartVoiceSessionResponse> startVoiceSession_Pre($grpc.ServiceCall call, $async.Future<$38.StartVoiceSessionRequest> request) async {
    return startVoiceSession(call, await request);
  }

  $async.Future<$38.ProcessVoiceNoteResponse> processVoiceNote_Pre($grpc.ServiceCall call, $async.Future<$38.ProcessVoiceNoteRequest> request) async {
    return processVoiceNote(call, await request);
  }

  $async.Future<$38.StartVoiceSessionResponse> startVoiceSession($grpc.ServiceCall call, $38.StartVoiceSessionRequest request);
  $async.Future<$38.ProcessVoiceNoteResponse> processVoiceNote($grpc.ServiceCall call, $38.ProcessVoiceNoteRequest request);
}
