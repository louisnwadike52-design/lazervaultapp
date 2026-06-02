///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice-biometrics.pb.dart' as $44;
export 'voice-biometrics.pb.dart';

class VoiceBiometricsServiceClient extends $grpc.Client {
  static final _$enrollVoice =
      $grpc.ClientMethod<$44.EnrollVoiceRequest, $44.EnrollVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/EnrollVoice',
          ($44.EnrollVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $44.EnrollVoiceResponse.fromBuffer(value));
  static final _$verifyVoice =
      $grpc.ClientMethod<$44.VerifyVoiceRequest, $44.VerifyVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoice',
          ($44.VerifyVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $44.VerifyVoiceResponse.fromBuffer(value));
  static final _$verifyVoiceStream =
      $grpc.ClientMethod<$44.VoiceAudioChunk, $44.VerifyVoiceStreamResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoiceStream',
          ($44.VoiceAudioChunk value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $44.VerifyVoiceStreamResponse.fromBuffer(value));
  static final _$checkEnrollmentStatus = $grpc.ClientMethod<
          $44.CheckEnrollmentStatusRequest, $44.CheckEnrollmentStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/CheckEnrollmentStatus',
      ($44.CheckEnrollmentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.CheckEnrollmentStatusResponse.fromBuffer(value));
  static final _$deleteVoiceEnrollment = $grpc.ClientMethod<
          $44.DeleteVoiceEnrollmentRequest, $44.DeleteVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/DeleteVoiceEnrollment',
      ($44.DeleteVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.DeleteVoiceEnrollmentResponse.fromBuffer(value));
  static final _$updateVoiceEnrollment = $grpc.ClientMethod<
          $44.UpdateVoiceEnrollmentRequest, $44.UpdateVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateVoiceEnrollment',
      ($44.UpdateVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.UpdateVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getVoiceEnrollment = $grpc.ClientMethod<
          $44.GetVoiceEnrollmentRequest, $44.GetVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetVoiceEnrollment',
      ($44.GetVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.GetVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getCustomVoiceStatus = $grpc.ClientMethod<
          $44.GetCustomVoiceStatusRequest, $44.GetCustomVoiceStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetCustomVoiceStatus',
      ($44.GetCustomVoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.GetCustomVoiceStatusResponse.fromBuffer(value));
  static final _$setCustomVoiceEnabled = $grpc.ClientMethod<
          $44.SetCustomVoiceEnabledRequest, $44.SetCustomVoiceEnabledResponse>(
      '/voicebiometrics.VoiceBiometricsService/SetCustomVoiceEnabled',
      ($44.SetCustomVoiceEnabledRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.SetCustomVoiceEnabledResponse.fromBuffer(value));
  static final _$retriggerVoiceCloning = $grpc.ClientMethod<
          $44.RetriggerVoiceCloningRequest, $44.RetriggerVoiceCloningResponse>(
      '/voicebiometrics.VoiceBiometricsService/RetriggerVoiceCloning',
      ($44.RetriggerVoiceCloningRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.RetriggerVoiceCloningResponse.fromBuffer(value));
  static final _$updateCloningStatus = $grpc.ClientMethod<
          $44.UpdateCloningStatusRequest, $44.UpdateCloningStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateCloningStatus',
      ($44.UpdateCloningStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.UpdateCloningStatusResponse.fromBuffer(value));

  VoiceBiometricsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$44.EnrollVoiceResponse> enrollVoice(
      $44.EnrollVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enrollVoice, request, options: options);
  }

  $grpc.ResponseFuture<$44.VerifyVoiceResponse> verifyVoice(
      $44.VerifyVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyVoice, request, options: options);
  }

  $grpc.ResponseFuture<$44.VerifyVoiceStreamResponse> verifyVoiceStream(
      $async.Stream<$44.VoiceAudioChunk> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$verifyVoiceStream, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$44.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $44.CheckEnrollmentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEnrollmentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$44.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $44.DeleteVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$44.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $44.UpdateVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$44.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $44.GetVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$44.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $44.GetCustomVoiceStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomVoiceStatus, request, options: options);
  }

  $grpc.ResponseFuture<$44.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $44.SetCustomVoiceEnabledRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setCustomVoiceEnabled, request, options: options);
  }

  $grpc.ResponseFuture<$44.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $44.RetriggerVoiceCloningRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retriggerVoiceCloning, request, options: options);
  }

  $grpc.ResponseFuture<$44.UpdateCloningStatusResponse> updateCloningStatus(
      $44.UpdateCloningStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCloningStatus, request, options: options);
  }
}

abstract class VoiceBiometricsServiceBase extends $grpc.Service {
  $core.String get $name => 'voicebiometrics.VoiceBiometricsService';

  VoiceBiometricsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$44.EnrollVoiceRequest, $44.EnrollVoiceResponse>(
            'EnrollVoice',
            enrollVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $44.EnrollVoiceRequest.fromBuffer(value),
            ($44.EnrollVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$44.VerifyVoiceRequest, $44.VerifyVoiceResponse>(
            'VerifyVoice',
            verifyVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $44.VerifyVoiceRequest.fromBuffer(value),
            ($44.VerifyVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$44.VoiceAudioChunk, $44.VerifyVoiceStreamResponse>(
            'VerifyVoiceStream',
            verifyVoiceStream,
            true,
            false,
            ($core.List<$core.int> value) =>
                $44.VoiceAudioChunk.fromBuffer(value),
            ($44.VerifyVoiceStreamResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.CheckEnrollmentStatusRequest,
            $44.CheckEnrollmentStatusResponse>(
        'CheckEnrollmentStatus',
        checkEnrollmentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.CheckEnrollmentStatusRequest.fromBuffer(value),
        ($44.CheckEnrollmentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.DeleteVoiceEnrollmentRequest,
            $44.DeleteVoiceEnrollmentResponse>(
        'DeleteVoiceEnrollment',
        deleteVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.DeleteVoiceEnrollmentRequest.fromBuffer(value),
        ($44.DeleteVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.UpdateVoiceEnrollmentRequest,
            $44.UpdateVoiceEnrollmentResponse>(
        'UpdateVoiceEnrollment',
        updateVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.UpdateVoiceEnrollmentRequest.fromBuffer(value),
        ($44.UpdateVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.GetVoiceEnrollmentRequest,
            $44.GetVoiceEnrollmentResponse>(
        'GetVoiceEnrollment',
        getVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.GetVoiceEnrollmentRequest.fromBuffer(value),
        ($44.GetVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.GetCustomVoiceStatusRequest,
            $44.GetCustomVoiceStatusResponse>(
        'GetCustomVoiceStatus',
        getCustomVoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.GetCustomVoiceStatusRequest.fromBuffer(value),
        ($44.GetCustomVoiceStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.SetCustomVoiceEnabledRequest,
            $44.SetCustomVoiceEnabledResponse>(
        'SetCustomVoiceEnabled',
        setCustomVoiceEnabled_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.SetCustomVoiceEnabledRequest.fromBuffer(value),
        ($44.SetCustomVoiceEnabledResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.RetriggerVoiceCloningRequest,
            $44.RetriggerVoiceCloningResponse>(
        'RetriggerVoiceCloning',
        retriggerVoiceCloning_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.RetriggerVoiceCloningRequest.fromBuffer(value),
        ($44.RetriggerVoiceCloningResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.UpdateCloningStatusRequest,
            $44.UpdateCloningStatusResponse>(
        'UpdateCloningStatus',
        updateCloningStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.UpdateCloningStatusRequest.fromBuffer(value),
        ($44.UpdateCloningStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$44.EnrollVoiceResponse> enrollVoice_Pre($grpc.ServiceCall call,
      $async.Future<$44.EnrollVoiceRequest> request) async {
    return enrollVoice(call, await request);
  }

  $async.Future<$44.VerifyVoiceResponse> verifyVoice_Pre($grpc.ServiceCall call,
      $async.Future<$44.VerifyVoiceRequest> request) async {
    return verifyVoice(call, await request);
  }

  $async.Future<$44.CheckEnrollmentStatusResponse> checkEnrollmentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.CheckEnrollmentStatusRequest> request) async {
    return checkEnrollmentStatus(call, await request);
  }

  $async.Future<$44.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.DeleteVoiceEnrollmentRequest> request) async {
    return deleteVoiceEnrollment(call, await request);
  }

  $async.Future<$44.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.UpdateVoiceEnrollmentRequest> request) async {
    return updateVoiceEnrollment(call, await request);
  }

  $async.Future<$44.GetVoiceEnrollmentResponse> getVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.GetVoiceEnrollmentRequest> request) async {
    return getVoiceEnrollment(call, await request);
  }

  $async.Future<$44.GetCustomVoiceStatusResponse> getCustomVoiceStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.GetCustomVoiceStatusRequest> request) async {
    return getCustomVoiceStatus(call, await request);
  }

  $async.Future<$44.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.SetCustomVoiceEnabledRequest> request) async {
    return setCustomVoiceEnabled(call, await request);
  }

  $async.Future<$44.RetriggerVoiceCloningResponse> retriggerVoiceCloning_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.RetriggerVoiceCloningRequest> request) async {
    return retriggerVoiceCloning(call, await request);
  }

  $async.Future<$44.UpdateCloningStatusResponse> updateCloningStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.UpdateCloningStatusRequest> request) async {
    return updateCloningStatus(call, await request);
  }

  $async.Future<$44.EnrollVoiceResponse> enrollVoice(
      $grpc.ServiceCall call, $44.EnrollVoiceRequest request);
  $async.Future<$44.VerifyVoiceResponse> verifyVoice(
      $grpc.ServiceCall call, $44.VerifyVoiceRequest request);
  $async.Future<$44.VerifyVoiceStreamResponse> verifyVoiceStream(
      $grpc.ServiceCall call, $async.Stream<$44.VoiceAudioChunk> request);
  $async.Future<$44.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $grpc.ServiceCall call, $44.CheckEnrollmentStatusRequest request);
  $async.Future<$44.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $grpc.ServiceCall call, $44.DeleteVoiceEnrollmentRequest request);
  $async.Future<$44.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $grpc.ServiceCall call, $44.UpdateVoiceEnrollmentRequest request);
  $async.Future<$44.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $grpc.ServiceCall call, $44.GetVoiceEnrollmentRequest request);
  $async.Future<$44.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $grpc.ServiceCall call, $44.GetCustomVoiceStatusRequest request);
  $async.Future<$44.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $grpc.ServiceCall call, $44.SetCustomVoiceEnabledRequest request);
  $async.Future<$44.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $grpc.ServiceCall call, $44.RetriggerVoiceCloningRequest request);
  $async.Future<$44.UpdateCloningStatusResponse> updateCloningStatus(
      $grpc.ServiceCall call, $44.UpdateCloningStatusRequest request);
}
