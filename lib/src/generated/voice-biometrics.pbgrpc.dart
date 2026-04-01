///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice-biometrics.pb.dart' as $0;
export 'voice-biometrics.pb.dart';

class VoiceBiometricsServiceClient extends $grpc.Client {
  static final _$enrollVoice =
      $grpc.ClientMethod<$0.EnrollVoiceRequest, $0.EnrollVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/EnrollVoice',
          ($0.EnrollVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.EnrollVoiceResponse.fromBuffer(value));
  static final _$verifyVoice =
      $grpc.ClientMethod<$0.VerifyVoiceRequest, $0.VerifyVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoice',
          ($0.VerifyVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyVoiceResponse.fromBuffer(value));
  static final _$verifyVoiceStream =
      $grpc.ClientMethod<$0.VoiceAudioChunk, $0.VerifyVoiceStreamResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoiceStream',
          ($0.VoiceAudioChunk value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyVoiceStreamResponse.fromBuffer(value));
  static final _$checkEnrollmentStatus = $grpc.ClientMethod<
          $0.CheckEnrollmentStatusRequest, $0.CheckEnrollmentStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/CheckEnrollmentStatus',
      ($0.CheckEnrollmentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CheckEnrollmentStatusResponse.fromBuffer(value));
  static final _$deleteVoiceEnrollment = $grpc.ClientMethod<
          $0.DeleteVoiceEnrollmentRequest, $0.DeleteVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/DeleteVoiceEnrollment',
      ($0.DeleteVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteVoiceEnrollmentResponse.fromBuffer(value));
  static final _$updateVoiceEnrollment = $grpc.ClientMethod<
          $0.UpdateVoiceEnrollmentRequest, $0.UpdateVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateVoiceEnrollment',
      ($0.UpdateVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getVoiceEnrollment = $grpc.ClientMethod<
          $0.GetVoiceEnrollmentRequest, $0.GetVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetVoiceEnrollment',
      ($0.GetVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getCustomVoiceStatus = $grpc.ClientMethod<
          $0.GetCustomVoiceStatusRequest, $0.GetCustomVoiceStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetCustomVoiceStatus',
      ($0.GetCustomVoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCustomVoiceStatusResponse.fromBuffer(value));
  static final _$setCustomVoiceEnabled = $grpc.ClientMethod<
          $0.SetCustomVoiceEnabledRequest, $0.SetCustomVoiceEnabledResponse>(
      '/voicebiometrics.VoiceBiometricsService/SetCustomVoiceEnabled',
      ($0.SetCustomVoiceEnabledRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SetCustomVoiceEnabledResponse.fromBuffer(value));
  static final _$retriggerVoiceCloning = $grpc.ClientMethod<
          $0.RetriggerVoiceCloningRequest, $0.RetriggerVoiceCloningResponse>(
      '/voicebiometrics.VoiceBiometricsService/RetriggerVoiceCloning',
      ($0.RetriggerVoiceCloningRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RetriggerVoiceCloningResponse.fromBuffer(value));
  static final _$updateCloningStatus = $grpc.ClientMethod<
          $0.UpdateCloningStatusRequest, $0.UpdateCloningStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateCloningStatus',
      ($0.UpdateCloningStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateCloningStatusResponse.fromBuffer(value));

  VoiceBiometricsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.EnrollVoiceResponse> enrollVoice(
      $0.EnrollVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enrollVoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyVoiceResponse> verifyVoice(
      $0.VerifyVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyVoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyVoiceStreamResponse> verifyVoiceStream(
      $async.Stream<$0.VoiceAudioChunk> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$verifyVoiceStream, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $0.CheckEnrollmentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEnrollmentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $0.DeleteVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $0.UpdateVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $0.GetVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $0.GetCustomVoiceStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomVoiceStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $0.SetCustomVoiceEnabledRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setCustomVoiceEnabled, request, options: options);
  }

  $grpc.ResponseFuture<$0.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $0.RetriggerVoiceCloningRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retriggerVoiceCloning, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCloningStatusResponse> updateCloningStatus(
      $0.UpdateCloningStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCloningStatus, request, options: options);
  }
}

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

  $async.Future<$0.EnrollVoiceResponse> enrollVoice_Pre($grpc.ServiceCall call,
      $async.Future<$0.EnrollVoiceRequest> request) async {
    return enrollVoice(call, await request);
  }

  $async.Future<$0.VerifyVoiceResponse> verifyVoice_Pre($grpc.ServiceCall call,
      $async.Future<$0.VerifyVoiceRequest> request) async {
    return verifyVoice(call, await request);
  }

  $async.Future<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CheckEnrollmentStatusRequest> request) async {
    return checkEnrollmentStatus(call, await request);
  }

  $async.Future<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteVoiceEnrollmentRequest> request) async {
    return deleteVoiceEnrollment(call, await request);
  }

  $async.Future<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateVoiceEnrollmentRequest> request) async {
    return updateVoiceEnrollment(call, await request);
  }

  $async.Future<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetVoiceEnrollmentRequest> request) async {
    return getVoiceEnrollment(call, await request);
  }

  $async.Future<$0.GetCustomVoiceStatusResponse> getCustomVoiceStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCustomVoiceStatusRequest> request) async {
    return getCustomVoiceStatus(call, await request);
  }

  $async.Future<$0.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetCustomVoiceEnabledRequest> request) async {
    return setCustomVoiceEnabled(call, await request);
  }

  $async.Future<$0.RetriggerVoiceCloningResponse> retriggerVoiceCloning_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RetriggerVoiceCloningRequest> request) async {
    return retriggerVoiceCloning(call, await request);
  }

  $async.Future<$0.UpdateCloningStatusResponse> updateCloningStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateCloningStatusRequest> request) async {
    return updateCloningStatus(call, await request);
  }

  $async.Future<$0.EnrollVoiceResponse> enrollVoice(
      $grpc.ServiceCall call, $0.EnrollVoiceRequest request);
  $async.Future<$0.VerifyVoiceResponse> verifyVoice(
      $grpc.ServiceCall call, $0.VerifyVoiceRequest request);
  $async.Future<$0.VerifyVoiceStreamResponse> verifyVoiceStream(
      $grpc.ServiceCall call, $async.Stream<$0.VoiceAudioChunk> request);
  $async.Future<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $grpc.ServiceCall call, $0.CheckEnrollmentStatusRequest request);
  $async.Future<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $grpc.ServiceCall call, $0.DeleteVoiceEnrollmentRequest request);
  $async.Future<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $grpc.ServiceCall call, $0.UpdateVoiceEnrollmentRequest request);
  $async.Future<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $grpc.ServiceCall call, $0.GetVoiceEnrollmentRequest request);
  $async.Future<$0.GetCustomVoiceStatusResponse> getCustomVoiceStatus(
      $grpc.ServiceCall call, $0.GetCustomVoiceStatusRequest request);
  $async.Future<$0.SetCustomVoiceEnabledResponse> setCustomVoiceEnabled(
      $grpc.ServiceCall call, $0.SetCustomVoiceEnabledRequest request);
  $async.Future<$0.RetriggerVoiceCloningResponse> retriggerVoiceCloning(
      $grpc.ServiceCall call, $0.RetriggerVoiceCloningRequest request);
  $async.Future<$0.UpdateCloningStatusResponse> updateCloningStatus(
      $grpc.ServiceCall call, $0.UpdateCloningStatusRequest request);
}
