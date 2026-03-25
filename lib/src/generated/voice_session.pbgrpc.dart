// This is a generated file - do not edit.
//
// Generated from voice_session.proto.

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

import 'voice_session.pb.dart' as $0;

export 'voice_session.pb.dart';

@$pb.GrpcServiceName('pb.VoiceSessionService')
class VoiceSessionServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  VoiceSessionServiceClient(super.channel, {super.options, super.interceptors});

  /// Starts a new voice session by creating a LiveKit room,
  /// generating a token for the client, and dispatching an agent.
  $grpc.ResponseFuture<$0.StartVoiceSessionResponse> startVoiceSession(
    $0.StartVoiceSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$startVoiceSession, request, options: options);
  }

  /// Processes a voice note and returns AI response with transcription
  $grpc.ResponseFuture<$0.ProcessVoiceNoteResponse> processVoiceNote(
    $0.ProcessVoiceNoteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processVoiceNote, request, options: options);
  }

  // method descriptors

  static final _$startVoiceSession = $grpc.ClientMethod<
          $0.StartVoiceSessionRequest, $0.StartVoiceSessionResponse>(
      '/pb.VoiceSessionService/StartVoiceSession',
      ($0.StartVoiceSessionRequest value) => value.writeToBuffer(),
      $0.StartVoiceSessionResponse.fromBuffer);
  static final _$processVoiceNote = $grpc.ClientMethod<
          $0.ProcessVoiceNoteRequest, $0.ProcessVoiceNoteResponse>(
      '/pb.VoiceSessionService/ProcessVoiceNote',
      ($0.ProcessVoiceNoteRequest value) => value.writeToBuffer(),
      $0.ProcessVoiceNoteResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.VoiceSessionService')
abstract class VoiceSessionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.VoiceSessionService';

  VoiceSessionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StartVoiceSessionRequest,
            $0.StartVoiceSessionResponse>(
        'StartVoiceSession',
        startVoiceSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.StartVoiceSessionRequest.fromBuffer(value),
        ($0.StartVoiceSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessVoiceNoteRequest,
            $0.ProcessVoiceNoteResponse>(
        'ProcessVoiceNote',
        processVoiceNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessVoiceNoteRequest.fromBuffer(value),
        ($0.ProcessVoiceNoteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.StartVoiceSessionResponse> startVoiceSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.StartVoiceSessionRequest> $request) async {
    return startVoiceSession($call, await $request);
  }

  $async.Future<$0.StartVoiceSessionResponse> startVoiceSession(
      $grpc.ServiceCall call, $0.StartVoiceSessionRequest request);

  $async.Future<$0.ProcessVoiceNoteResponse> processVoiceNote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ProcessVoiceNoteRequest> $request) async {
    return processVoiceNote($call, await $request);
  }

  $async.Future<$0.ProcessVoiceNoteResponse> processVoiceNote(
      $grpc.ServiceCall call, $0.ProcessVoiceNoteRequest request);
}
