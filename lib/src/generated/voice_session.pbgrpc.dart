///
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice_session.pb.dart' as $32;
export 'voice_session.pb.dart';

class VoiceSessionServiceClient extends $grpc.Client {
  static final _$startVoiceSession = $grpc.ClientMethod<
          $32.StartVoiceSessionRequest, $32.StartVoiceSessionResponse>(
      '/pb.VoiceSessionService/StartVoiceSession',
      ($32.StartVoiceSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.StartVoiceSessionResponse.fromBuffer(value));
  static final _$processVoiceNote = $grpc.ClientMethod<
          $32.ProcessVoiceNoteRequest, $32.ProcessVoiceNoteResponse>(
      '/pb.VoiceSessionService/ProcessVoiceNote',
      ($32.ProcessVoiceNoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.ProcessVoiceNoteResponse.fromBuffer(value));

  VoiceSessionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$32.StartVoiceSessionResponse> startVoiceSession(
      $32.StartVoiceSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startVoiceSession, request, options: options);
  }

  $grpc.ResponseFuture<$32.ProcessVoiceNoteResponse> processVoiceNote(
      $32.ProcessVoiceNoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processVoiceNote, request, options: options);
  }
}

abstract class VoiceSessionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.VoiceSessionService';

  VoiceSessionServiceBase() {
    $addMethod($grpc.ServiceMethod<$32.StartVoiceSessionRequest,
            $32.StartVoiceSessionResponse>(
        'StartVoiceSession',
        startVoiceSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.StartVoiceSessionRequest.fromBuffer(value),
        ($32.StartVoiceSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.ProcessVoiceNoteRequest,
            $32.ProcessVoiceNoteResponse>(
        'ProcessVoiceNote',
        processVoiceNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.ProcessVoiceNoteRequest.fromBuffer(value),
        ($32.ProcessVoiceNoteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$32.StartVoiceSessionResponse> startVoiceSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.StartVoiceSessionRequest> request) async {
    return startVoiceSession(call, await request);
  }

  $async.Future<$32.ProcessVoiceNoteResponse> processVoiceNote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.ProcessVoiceNoteRequest> request) async {
    return processVoiceNote(call, await request);
  }

  $async.Future<$32.StartVoiceSessionResponse> startVoiceSession(
      $grpc.ServiceCall call, $32.StartVoiceSessionRequest request);
  $async.Future<$32.ProcessVoiceNoteResponse> processVoiceNote(
      $grpc.ServiceCall call, $32.ProcessVoiceNoteRequest request);
}
