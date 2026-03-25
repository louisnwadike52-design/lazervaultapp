// This is a generated file - do not edit.
//
// Generated from voice-biometrics.proto.

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

import 'voice-biometrics.pb.dart' as $0;

export 'voice-biometrics.pb.dart';

/// Voice Biometrics Service - Speaker recognition and verification
@$pb.GrpcServiceName('voicebiometrics.VoiceBiometricsService')
class VoiceBiometricsServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  VoiceBiometricsServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Enroll a new voice for a user
  $grpc.ResponseFuture<$0.EnrollVoiceResponse> enrollVoice(
    $0.EnrollVoiceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$enrollVoice, request, options: options);
  }

  /// Verify a voice sample matches the enrolled user
  $grpc.ResponseFuture<$0.VerifyVoiceResponse> verifyVoice(
    $0.VerifyVoiceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyVoice, request, options: options);
  }

  /// Stream-based voice verification for real-time checking
  /// Client streams audio chunks, server returns verification result when confident
  $grpc.ResponseFuture<$0.VerifyVoiceStreamResponse> verifyVoiceStream(
    $async.Stream<$0.VoiceAudioChunk> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$verifyVoiceStream, request, options: options)
        .single;
  }

  /// Check if user has enrolled their voice
  $grpc.ResponseFuture<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
    $0.CheckEnrollmentStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkEnrollmentStatus, request, options: options);
  }

  /// Delete user's voice enrollment
  $grpc.ResponseFuture<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
    $0.DeleteVoiceEnrollmentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteVoiceEnrollment, request, options: options);
  }

  /// Update voice enrollment with additional samples
  $grpc.ResponseFuture<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
    $0.UpdateVoiceEnrollmentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateVoiceEnrollment, request, options: options);
  }

  /// Get voice enrollment details
  $grpc.ResponseFuture<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment(
    $0.GetVoiceEnrollmentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVoiceEnrollment, request, options: options);
  }

  /// Get custom voice cloning status for a user
  $grpc.ResponseFuture<$0.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
    $0.GetCustomVoiceStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCustomVoiceStatus, request, options: options);
  }

  /// Enable or disable custom voice for a user
  $grpc.ResponseFuture<$0.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
    $0.SetCustomVoiceEnabledRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setCustomVoiceEnabled, request, options: options);
  }

  /// Re-trigger voice cloning if previous attempt failed
  $grpc.ResponseFuture<$0.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
    $0.RetriggerVoiceCloningRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$retriggerVoiceCloning, request, options: options);
  }

  /// Update voice cloning status (called by voice-agent-gateway after cloning)
  $grpc.ResponseFuture<$0.UpdateCloningStatusResponse> updateCloningStatus(
    $0.UpdateCloningStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateCloningStatus, request, options: options);
  }

  // method descriptors

  static final _$enrollVoice =
      $grpc.ClientMethod<$0.EnrollVoiceRequest, $0.EnrollVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/EnrollVoice',
          ($0.EnrollVoiceRequest value) => value.writeToBuffer(),
          $0.EnrollVoiceResponse.fromBuffer);
  static final _$verifyVoice =
      $grpc.ClientMethod<$0.VerifyVoiceRequest, $0.VerifyVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoice',
          ($0.VerifyVoiceRequest value) => value.writeToBuffer(),
          $0.VerifyVoiceResponse.fromBuffer);
  static final _$verifyVoiceStream =
      $grpc.ClientMethod<$0.VoiceAudioChunk, $0.VerifyVoiceStreamResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoiceStream',
          ($0.VoiceAudioChunk value) => value.writeToBuffer(),
          $0.VerifyVoiceStreamResponse.fromBuffer);
  static final _$checkEnrollmentStatus = $grpc.ClientMethod<
          $0.CheckEnrollmentStatusRequest, $0.CheckEnrollmentStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/CheckEnrollmentStatus',
      ($0.CheckEnrollmentStatusRequest value) => value.writeToBuffer(),
      $0.CheckEnrollmentStatusResponse.fromBuffer);
  static final _$deleteVoiceEnrollment = $grpc.ClientMethod<
          $0.DeleteVoiceEnrollmentRequest, $0.DeleteVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/DeleteVoiceEnrollment',
      ($0.DeleteVoiceEnrollmentRequest value) => value.writeToBuffer(),
      $0.DeleteVoiceEnrollmentResponse.fromBuffer);
  static final _$updateVoiceEnrollment = $grpc.ClientMethod<
          $0.UpdateVoiceEnrollmentRequest, $0.UpdateVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateVoiceEnrollment',
      ($0.UpdateVoiceEnrollmentRequest value) => value.writeToBuffer(),
      $0.UpdateVoiceEnrollmentResponse.fromBuffer);
  static final _$getVoiceEnrollment = $grpc.ClientMethod<
          $0.GetVoiceEnrollmentRequest, $0.GetVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetVoiceEnrollment',
      ($0.GetVoiceEnrollmentRequest value) => value.writeToBuffer(),
      $0.GetVoiceEnrollmentResponse.fromBuffer);
  static final _$getCustomVoiceStatus = $grpc.ClientMethod<
          $0.GetCustomVoiceStatusRequest, $0.GetCustomVoiceStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetCustomVoiceStatus',
      ($0.GetCustomVoiceStatusRequest value) => value.writeToBuffer(),
      $0.GetCustomVoiceStatusResponse.fromBuffer);
  static final _$setCustomVoiceEnabled = $grpc.ClientMethod<
          $0.SetCustomVoiceEnabledRequest, $0.SetCustomVoiceEnabledResponse>(
      '/voicebiometrics.VoiceBiometricsService/SetCustomVoiceEnabled',
      ($0.SetCustomVoiceEnabledRequest value) => value.writeToBuffer(),
      $0.SetCustomVoiceEnabledResponse.fromBuffer);
  static final _$retriggerVoiceCloning = $grpc.ClientMethod<
          $0.RetriggerVoiceCloningRequest, $0.RetriggerVoiceCloningResponse>(
      '/voicebiometrics.VoiceBiometricsService/RetriggerVoiceCloning',
      ($0.RetriggerVoiceCloningRequest value) => value.writeToBuffer(),
      $0.RetriggerVoiceCloningResponse.fromBuffer);
  static final _$updateCloningStatus = $grpc.ClientMethod<
          $0.UpdateCloningStatusRequest, $0.UpdateCloningStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateCloningStatus',
      ($0.UpdateCloningStatusRequest value) => value.writeToBuffer(),
      $0.UpdateCloningStatusResponse.fromBuffer);
}

@$pb.GrpcServiceName('voicebiometrics.VoiceBiometricsService')
abstract class VoiceBiometricsServiceBase extends $grpc.Service {
  $core.String get $name => 'voicebiometrics.VoiceBiometricsService';

  VoiceBiometricsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.EnrollVoiceRequest, $0.EnrollVoiceResponse>(
            'EnrollVoice',
            enrollVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.EnrollVoiceRequest.fromBuffer(value),
            ($0.EnrollVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VerifyVoiceRequest, $0.VerifyVoiceResponse>(
            'VerifyVoice',
            verifyVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VerifyVoiceRequest.fromBuffer(value),
            ($0.VerifyVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VoiceAudioChunk, $0.VerifyVoiceStreamResponse>(
            'VerifyVoiceStream',
            verifyVoiceStream,
            true,
            false,
            ($core.List<$core.int> value) =>
                $0.VoiceAudioChunk.fromBuffer(value),
            ($0.VerifyVoiceStreamResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckEnrollmentStatusRequest,
            $0.CheckEnrollmentStatusResponse>(
        'CheckEnrollmentStatus',
        checkEnrollmentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CheckEnrollmentStatusRequest.fromBuffer(value),
        ($0.CheckEnrollmentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteVoiceEnrollmentRequest,
            $0.DeleteVoiceEnrollmentResponse>(
        'DeleteVoiceEnrollment',
        deleteVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteVoiceEnrollmentRequest.fromBuffer(value),
        ($0.DeleteVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateVoiceEnrollmentRequest,
            $0.UpdateVoiceEnrollmentResponse>(
        'UpdateVoiceEnrollment',
        updateVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateVoiceEnrollmentRequest.fromBuffer(value),
        ($0.UpdateVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVoiceEnrollmentRequest,
            $0.GetVoiceEnrollmentResponse>(
        'GetVoiceEnrollment',
        getVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVoiceEnrollmentRequest.fromBuffer(value),
        ($0.GetVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCustomVoiceStatusRequest,
            $0.GetCustomVoiceStatusResponse>(
        'GetCustomVoiceStatus',
        getCustomVoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCustomVoiceStatusRequest.fromBuffer(value),
        ($0.GetCustomVoiceStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetCustomVoiceEnabledRequest,
            $0.SetCustomVoiceEnabledResponse>(
        'SetCustomVoiceEnabled',
        setCustomVoiceEnabled_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetCustomVoiceEnabledRequest.fromBuffer(value),
        ($0.SetCustomVoiceEnabledResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RetriggerVoiceCloningRequest,
            $0.RetriggerVoiceCloningResponse>(
        'RetriggerVoiceCloning',
        retriggerVoiceCloning_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RetriggerVoiceCloningRequest.fromBuffer(value),
        ($0.RetriggerVoiceCloningResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCloningStatusRequest,
            $0.UpdateCloningStatusResponse>(
        'UpdateCloningStatus',
        updateCloningStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCloningStatusRequest.fromBuffer(value),
        ($0.UpdateCloningStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.EnrollVoiceResponse> enrollVoice_Pre($grpc.ServiceCall $call,
      $async.Future<$0.EnrollVoiceRequest> $request) async {
    return enrollVoice($call, await $request);
  }

  $async.Future<$0.EnrollVoiceResponse> enrollVoice(
      $grpc.ServiceCall call, $0.EnrollVoiceRequest request);

  $async.Future<$0.VerifyVoiceResponse> verifyVoice_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyVoiceRequest> $request) async {
    return verifyVoice($call, await $request);
  }

  $async.Future<$0.VerifyVoiceResponse> verifyVoice(
      $grpc.ServiceCall call, $0.VerifyVoiceRequest request);

  $async.Future<$0.VerifyVoiceStreamResponse> verifyVoiceStream(
      $grpc.ServiceCall call, $async.Stream<$0.VoiceAudioChunk> request);

  $async.Future<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckEnrollmentStatusRequest> $request) async {
    return checkEnrollmentStatus($call, await $request);
  }

  $async.Future<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $grpc.ServiceCall call, $0.CheckEnrollmentStatusRequest request);

  $async.Future<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeleteVoiceEnrollmentRequest> $request) async {
    return deleteVoiceEnrollment($call, await $request);
  }

  $async.Future<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $grpc.ServiceCall call, $0.DeleteVoiceEnrollmentRequest request);

  $async.Future<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateVoiceEnrollmentRequest> $request) async {
    return updateVoiceEnrollment($call, await $request);
  }

  $async.Future<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $grpc.ServiceCall call, $0.UpdateVoiceEnrollmentRequest request);

  $async.Future<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVoiceEnrollmentRequest> $request) async {
    return getVoiceEnrollment($call, await $request);
  }

  $async.Future<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $grpc.ServiceCall call, $0.GetVoiceEnrollmentRequest request);

  $async.Future<$0.GetCustomVoiceStatusResponse> getCustomVoiceStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetCustomVoiceStatusRequest> $request) async {
    return getCustomVoiceStatus($call, await $request);
  }

  $async.Future<$0.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $grpc.ServiceCall call, $0.GetCustomVoiceStatusRequest request);

  $async.Future<$0.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetCustomVoiceEnabledRequest> $request) async {
    return setCustomVoiceEnabled($call, await $request);
  }

  $async.Future<$0.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $grpc.ServiceCall call, $0.SetCustomVoiceEnabledRequest request);

  $async.Future<$0.RetriggerVoiceCloningResponse> retriggerVoiceCloning_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RetriggerVoiceCloningRequest> $request) async {
    return retriggerVoiceCloning($call, await $request);
  }

  $async.Future<$0.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $grpc.ServiceCall call, $0.RetriggerVoiceCloningRequest request);

  $async.Future<$0.UpdateCloningStatusResponse> updateCloningStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateCloningStatusRequest> $request) async {
    return updateCloningStatus($call, await $request);
  }

  $async.Future<$0.UpdateCloningStatusResponse> updateCloningStatus(
      $grpc.ServiceCall call, $0.UpdateCloningStatusRequest request);
}
