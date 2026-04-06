///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice-biometrics.pb.dart' as $43;
export 'voice-biometrics.pb.dart';

class VoiceBiometricsServiceClient extends $grpc.Client {
  static final _$enrollVoice =
      $grpc.ClientMethod<$43.EnrollVoiceRequest, $43.EnrollVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/EnrollVoice',
          ($43.EnrollVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.EnrollVoiceResponse.fromBuffer(value));
  static final _$verifyVoice =
      $grpc.ClientMethod<$43.VerifyVoiceRequest, $43.VerifyVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoice',
          ($43.VerifyVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.VerifyVoiceResponse.fromBuffer(value));
  static final _$verifyVoiceStream =
      $grpc.ClientMethod<$43.VoiceAudioChunk, $43.VerifyVoiceStreamResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoiceStream',
          ($43.VoiceAudioChunk value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.VerifyVoiceStreamResponse.fromBuffer(value));
  static final _$checkEnrollmentStatus = $grpc.ClientMethod<
          $43.CheckEnrollmentStatusRequest, $43.CheckEnrollmentStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/CheckEnrollmentStatus',
      ($43.CheckEnrollmentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CheckEnrollmentStatusResponse.fromBuffer(value));
  static final _$deleteVoiceEnrollment = $grpc.ClientMethod<
          $43.DeleteVoiceEnrollmentRequest, $43.DeleteVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/DeleteVoiceEnrollment',
      ($43.DeleteVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteVoiceEnrollmentResponse.fromBuffer(value));
  static final _$updateVoiceEnrollment = $grpc.ClientMethod<
          $43.UpdateVoiceEnrollmentRequest, $43.UpdateVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateVoiceEnrollment',
      ($43.UpdateVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getVoiceEnrollment = $grpc.ClientMethod<
          $43.GetVoiceEnrollmentRequest, $43.GetVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetVoiceEnrollment',
      ($43.GetVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getCustomVoiceStatus = $grpc.ClientMethod<
          $43.GetCustomVoiceStatusRequest, $43.GetCustomVoiceStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetCustomVoiceStatus',
      ($43.GetCustomVoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetCustomVoiceStatusResponse.fromBuffer(value));
  static final _$setCustomVoiceEnabled = $grpc.ClientMethod<
          $43.SetCustomVoiceEnabledRequest, $43.SetCustomVoiceEnabledResponse>(
      '/voicebiometrics.VoiceBiometricsService/SetCustomVoiceEnabled',
      ($43.SetCustomVoiceEnabledRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SetCustomVoiceEnabledResponse.fromBuffer(value));
  static final _$retriggerVoiceCloning = $grpc.ClientMethod<
          $43.RetriggerVoiceCloningRequest, $43.RetriggerVoiceCloningResponse>(
      '/voicebiometrics.VoiceBiometricsService/RetriggerVoiceCloning',
      ($43.RetriggerVoiceCloningRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.RetriggerVoiceCloningResponse.fromBuffer(value));
  static final _$updateCloningStatus = $grpc.ClientMethod<
          $43.UpdateCloningStatusRequest, $43.UpdateCloningStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateCloningStatus',
      ($43.UpdateCloningStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateCloningStatusResponse.fromBuffer(value));

  VoiceBiometricsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$43.EnrollVoiceResponse> enrollVoice(
      $43.EnrollVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enrollVoice, request, options: options);
  }

  $grpc.ResponseFuture<$43.VerifyVoiceResponse> verifyVoice(
      $43.VerifyVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyVoice, request, options: options);
  }

  $grpc.ResponseFuture<$43.VerifyVoiceStreamResponse> verifyVoiceStream(
      $async.Stream<$43.VoiceAudioChunk> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$verifyVoiceStream, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$43.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $43.CheckEnrollmentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEnrollmentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$43.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $43.DeleteVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $43.UpdateVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $43.GetVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $43.GetCustomVoiceStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomVoiceStatus, request, options: options);
  }

  $grpc.ResponseFuture<$43.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $43.SetCustomVoiceEnabledRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setCustomVoiceEnabled, request, options: options);
  }

  $grpc.ResponseFuture<$43.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $43.RetriggerVoiceCloningRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retriggerVoiceCloning, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateCloningStatusResponse> updateCloningStatus(
      $43.UpdateCloningStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCloningStatus, request, options: options);
  }
}

abstract class VoiceBiometricsServiceBase extends $grpc.Service {
  $core.String get $name => 'voicebiometrics.VoiceBiometricsService';

  VoiceBiometricsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$43.EnrollVoiceRequest, $43.EnrollVoiceResponse>(
            'EnrollVoice',
            enrollVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.EnrollVoiceRequest.fromBuffer(value),
            ($43.EnrollVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.VerifyVoiceRequest, $43.VerifyVoiceResponse>(
            'VerifyVoice',
            verifyVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.VerifyVoiceRequest.fromBuffer(value),
            ($43.VerifyVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.VoiceAudioChunk, $43.VerifyVoiceStreamResponse>(
            'VerifyVoiceStream',
            verifyVoiceStream,
            true,
            false,
            ($core.List<$core.int> value) =>
                $43.VoiceAudioChunk.fromBuffer(value),
            ($43.VerifyVoiceStreamResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CheckEnrollmentStatusRequest,
            $43.CheckEnrollmentStatusResponse>(
        'CheckEnrollmentStatus',
        checkEnrollmentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CheckEnrollmentStatusRequest.fromBuffer(value),
        ($43.CheckEnrollmentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteVoiceEnrollmentRequest,
            $43.DeleteVoiceEnrollmentResponse>(
        'DeleteVoiceEnrollment',
        deleteVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteVoiceEnrollmentRequest.fromBuffer(value),
        ($43.DeleteVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateVoiceEnrollmentRequest,
            $43.UpdateVoiceEnrollmentResponse>(
        'UpdateVoiceEnrollment',
        updateVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateVoiceEnrollmentRequest.fromBuffer(value),
        ($43.UpdateVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetVoiceEnrollmentRequest,
            $43.GetVoiceEnrollmentResponse>(
        'GetVoiceEnrollment',
        getVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetVoiceEnrollmentRequest.fromBuffer(value),
        ($43.GetVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetCustomVoiceStatusRequest,
            $43.GetCustomVoiceStatusResponse>(
        'GetCustomVoiceStatus',
        getCustomVoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetCustomVoiceStatusRequest.fromBuffer(value),
        ($43.GetCustomVoiceStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SetCustomVoiceEnabledRequest,
            $43.SetCustomVoiceEnabledResponse>(
        'SetCustomVoiceEnabled',
        setCustomVoiceEnabled_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SetCustomVoiceEnabledRequest.fromBuffer(value),
        ($43.SetCustomVoiceEnabledResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.RetriggerVoiceCloningRequest,
            $43.RetriggerVoiceCloningResponse>(
        'RetriggerVoiceCloning',
        retriggerVoiceCloning_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.RetriggerVoiceCloningRequest.fromBuffer(value),
        ($43.RetriggerVoiceCloningResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateCloningStatusRequest,
            $43.UpdateCloningStatusResponse>(
        'UpdateCloningStatus',
        updateCloningStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateCloningStatusRequest.fromBuffer(value),
        ($43.UpdateCloningStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$43.EnrollVoiceResponse> enrollVoice_Pre($grpc.ServiceCall call,
      $async.Future<$43.EnrollVoiceRequest> request) async {
    return enrollVoice(call, await request);
  }

  $async.Future<$43.VerifyVoiceResponse> verifyVoice_Pre($grpc.ServiceCall call,
      $async.Future<$43.VerifyVoiceRequest> request) async {
    return verifyVoice(call, await request);
  }

  $async.Future<$43.CheckEnrollmentStatusResponse> checkEnrollmentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CheckEnrollmentStatusRequest> request) async {
    return checkEnrollmentStatus(call, await request);
  }

  $async.Future<$43.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteVoiceEnrollmentRequest> request) async {
    return deleteVoiceEnrollment(call, await request);
  }

  $async.Future<$43.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateVoiceEnrollmentRequest> request) async {
    return updateVoiceEnrollment(call, await request);
  }

  $async.Future<$43.GetVoiceEnrollmentResponse> getVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetVoiceEnrollmentRequest> request) async {
    return getVoiceEnrollment(call, await request);
  }

  $async.Future<$43.GetCustomVoiceStatusResponse> getCustomVoiceStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetCustomVoiceStatusRequest> request) async {
    return getCustomVoiceStatus(call, await request);
  }

  $async.Future<$43.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.SetCustomVoiceEnabledRequest> request) async {
    return setCustomVoiceEnabled(call, await request);
  }

  $async.Future<$43.RetriggerVoiceCloningResponse> retriggerVoiceCloning_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.RetriggerVoiceCloningRequest> request) async {
    return retriggerVoiceCloning(call, await request);
  }

  $async.Future<$43.UpdateCloningStatusResponse> updateCloningStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateCloningStatusRequest> request) async {
    return updateCloningStatus(call, await request);
  }

  $async.Future<$43.EnrollVoiceResponse> enrollVoice(
      $grpc.ServiceCall call, $43.EnrollVoiceRequest request);
  $async.Future<$43.VerifyVoiceResponse> verifyVoice(
      $grpc.ServiceCall call, $43.VerifyVoiceRequest request);
  $async.Future<$43.VerifyVoiceStreamResponse> verifyVoiceStream(
      $grpc.ServiceCall call, $async.Stream<$43.VoiceAudioChunk> request);
  $async.Future<$43.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $grpc.ServiceCall call, $43.CheckEnrollmentStatusRequest request);
  $async.Future<$43.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $grpc.ServiceCall call, $43.DeleteVoiceEnrollmentRequest request);
  $async.Future<$43.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $grpc.ServiceCall call, $43.UpdateVoiceEnrollmentRequest request);
  $async.Future<$43.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $grpc.ServiceCall call, $43.GetVoiceEnrollmentRequest request);
  $async.Future<$43.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $grpc.ServiceCall call, $43.GetCustomVoiceStatusRequest request);
  $async.Future<$43.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $grpc.ServiceCall call, $43.SetCustomVoiceEnabledRequest request);
  $async.Future<$43.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $grpc.ServiceCall call, $43.RetriggerVoiceCloningRequest request);
  $async.Future<$43.UpdateCloningStatusResponse> updateCloningStatus(
      $grpc.ServiceCall call, $43.UpdateCloningStatusRequest request);
}
