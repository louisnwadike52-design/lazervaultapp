///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'voice-biometrics.pb.dart' as $33;
export 'voice-biometrics.pb.dart';

class VoiceBiometricsServiceClient extends $grpc.Client {
  static final _$enrollVoice =
      $grpc.ClientMethod<$33.EnrollVoiceRequest, $33.EnrollVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/EnrollVoice',
          ($33.EnrollVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.EnrollVoiceResponse.fromBuffer(value));
  static final _$verifyVoice =
      $grpc.ClientMethod<$33.VerifyVoiceRequest, $33.VerifyVoiceResponse>(
          '/voicebiometrics.VoiceBiometricsService/VerifyVoice',
          ($33.VerifyVoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.VerifyVoiceResponse.fromBuffer(value));
  static final _$checkEnrollmentStatus = $grpc.ClientMethod<
          $33.CheckEnrollmentStatusRequest, $33.CheckEnrollmentStatusResponse>(
      '/voicebiometrics.VoiceBiometricsService/CheckEnrollmentStatus',
      ($33.CheckEnrollmentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.CheckEnrollmentStatusResponse.fromBuffer(value));
  static final _$deleteVoiceEnrollment = $grpc.ClientMethod<
          $33.DeleteVoiceEnrollmentRequest, $33.DeleteVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/DeleteVoiceEnrollment',
      ($33.DeleteVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.DeleteVoiceEnrollmentResponse.fromBuffer(value));
  static final _$updateVoiceEnrollment = $grpc.ClientMethod<
          $33.UpdateVoiceEnrollmentRequest, $33.UpdateVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/UpdateVoiceEnrollment',
      ($33.UpdateVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.UpdateVoiceEnrollmentResponse.fromBuffer(value));
  static final _$getVoiceEnrollment = $grpc.ClientMethod<
          $33.GetVoiceEnrollmentRequest, $33.GetVoiceEnrollmentResponse>(
      '/voicebiometrics.VoiceBiometricsService/GetVoiceEnrollment',
      ($33.GetVoiceEnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetVoiceEnrollmentResponse.fromBuffer(value));

  VoiceBiometricsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.EnrollVoiceResponse> enrollVoice(
      $33.EnrollVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enrollVoice, request, options: options);
  }

  $grpc.ResponseFuture<$33.VerifyVoiceResponse> verifyVoice(
      $33.VerifyVoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyVoice, request, options: options);
  }

  $grpc.ResponseFuture<$33.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $33.CheckEnrollmentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEnrollmentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$33.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $33.DeleteVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$33.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $33.UpdateVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVoiceEnrollment, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $33.GetVoiceEnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVoiceEnrollment, request, options: options);
  }
}

abstract class VoiceBiometricsServiceBase extends $grpc.Service {
  $core.String get $name => 'voicebiometrics.VoiceBiometricsService';

  VoiceBiometricsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$33.EnrollVoiceRequest, $33.EnrollVoiceResponse>(
            'EnrollVoice',
            enrollVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.EnrollVoiceRequest.fromBuffer(value),
            ($33.EnrollVoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$33.VerifyVoiceRequest, $33.VerifyVoiceResponse>(
            'VerifyVoice',
            verifyVoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.VerifyVoiceRequest.fromBuffer(value),
            ($33.VerifyVoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.CheckEnrollmentStatusRequest,
            $33.CheckEnrollmentStatusResponse>(
        'CheckEnrollmentStatus',
        checkEnrollmentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.CheckEnrollmentStatusRequest.fromBuffer(value),
        ($33.CheckEnrollmentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.DeleteVoiceEnrollmentRequest,
            $33.DeleteVoiceEnrollmentResponse>(
        'DeleteVoiceEnrollment',
        deleteVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.DeleteVoiceEnrollmentRequest.fromBuffer(value),
        ($33.DeleteVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.UpdateVoiceEnrollmentRequest,
            $33.UpdateVoiceEnrollmentResponse>(
        'UpdateVoiceEnrollment',
        updateVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.UpdateVoiceEnrollmentRequest.fromBuffer(value),
        ($33.UpdateVoiceEnrollmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetVoiceEnrollmentRequest,
            $33.GetVoiceEnrollmentResponse>(
        'GetVoiceEnrollment',
        getVoiceEnrollment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetVoiceEnrollmentRequest.fromBuffer(value),
        ($33.GetVoiceEnrollmentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.EnrollVoiceResponse> enrollVoice_Pre($grpc.ServiceCall call,
      $async.Future<$33.EnrollVoiceRequest> request) async {
    return enrollVoice(call, await request);
  }

  $async.Future<$33.VerifyVoiceResponse> verifyVoice_Pre($grpc.ServiceCall call,
      $async.Future<$33.VerifyVoiceRequest> request) async {
    return verifyVoice(call, await request);
  }

  $async.Future<$33.CheckEnrollmentStatusResponse> checkEnrollmentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.CheckEnrollmentStatusRequest> request) async {
    return checkEnrollmentStatus(call, await request);
  }

  $async.Future<$33.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.DeleteVoiceEnrollmentRequest> request) async {
    return deleteVoiceEnrollment(call, await request);
  }

  $async.Future<$33.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.UpdateVoiceEnrollmentRequest> request) async {
    return updateVoiceEnrollment(call, await request);
  }

  $async.Future<$33.GetVoiceEnrollmentResponse> getVoiceEnrollment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetVoiceEnrollmentRequest> request) async {
    return getVoiceEnrollment(call, await request);
  }

  $async.Future<$33.EnrollVoiceResponse> enrollVoice(
      $grpc.ServiceCall call, $33.EnrollVoiceRequest request);
  $async.Future<$33.VerifyVoiceResponse> verifyVoice(
      $grpc.ServiceCall call, $33.VerifyVoiceRequest request);
  $async.Future<$33.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $grpc.ServiceCall call, $33.CheckEnrollmentStatusRequest request);
  $async.Future<$33.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $grpc.ServiceCall call, $33.DeleteVoiceEnrollmentRequest request);
  $async.Future<$33.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $grpc.ServiceCall call, $33.UpdateVoiceEnrollmentRequest request);
  $async.Future<$33.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $grpc.ServiceCall call, $33.GetVoiceEnrollmentRequest request);
}
