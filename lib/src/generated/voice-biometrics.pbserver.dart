// This is a generated file - do not edit.
//
// Generated from voice-biometrics.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'voice-biometrics.pb.dart' as $0;
import 'voice-biometrics.pbjson.dart';

export 'voice-biometrics.pb.dart';

abstract class VoiceBiometricsServiceBase extends $pb.GeneratedService {
  $async.Future<$0.EnrollVoiceResponse> enrollVoice(
      $pb.ServerContext ctx, $0.EnrollVoiceRequest request);
  $async.Future<$0.VerifyVoiceResponse> verifyVoice(
      $pb.ServerContext ctx, $0.VerifyVoiceRequest request);
  $async.Future<$0.CheckEnrollmentStatusResponse> checkEnrollmentStatus(
      $pb.ServerContext ctx, $0.CheckEnrollmentStatusRequest request);
  $async.Future<$0.DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment(
      $pb.ServerContext ctx, $0.DeleteVoiceEnrollmentRequest request);
  $async.Future<$0.UpdateVoiceEnrollmentResponse> updateVoiceEnrollment(
      $pb.ServerContext ctx, $0.UpdateVoiceEnrollmentRequest request);
  $async.Future<$0.GetVoiceEnrollmentResponse> getVoiceEnrollment(
      $pb.ServerContext ctx, $0.GetVoiceEnrollmentRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'EnrollVoice':
        return $0.EnrollVoiceRequest();
      case 'VerifyVoice':
        return $0.VerifyVoiceRequest();
      case 'CheckEnrollmentStatus':
        return $0.CheckEnrollmentStatusRequest();
      case 'DeleteVoiceEnrollment':
        return $0.DeleteVoiceEnrollmentRequest();
      case 'UpdateVoiceEnrollment':
        return $0.UpdateVoiceEnrollmentRequest();
      case 'GetVoiceEnrollment':
        return $0.GetVoiceEnrollmentRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'EnrollVoice':
        return enrollVoice(ctx, request as $0.EnrollVoiceRequest);
      case 'VerifyVoice':
        return verifyVoice(ctx, request as $0.VerifyVoiceRequest);
      case 'CheckEnrollmentStatus':
        return checkEnrollmentStatus(
            ctx, request as $0.CheckEnrollmentStatusRequest);
      case 'DeleteVoiceEnrollment':
        return deleteVoiceEnrollment(
            ctx, request as $0.DeleteVoiceEnrollmentRequest);
      case 'UpdateVoiceEnrollment':
        return updateVoiceEnrollment(
            ctx, request as $0.UpdateVoiceEnrollmentRequest);
      case 'GetVoiceEnrollment':
        return getVoiceEnrollment(ctx, request as $0.GetVoiceEnrollmentRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      VoiceBiometricsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => VoiceBiometricsServiceBase$messageJson;
}
