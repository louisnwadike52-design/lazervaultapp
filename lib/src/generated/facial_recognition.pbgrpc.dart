///
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'facial_recognition.pb.dart' as $14;
export 'facial_recognition.pb.dart';

class FacialRecognitionServiceClient extends $grpc.Client {
  static final _$registerFace =
      $grpc.ClientMethod<$14.RegisterFaceRequest, $14.RegisterFaceResponse>(
          '/pb.FacialRecognitionService/RegisterFace',
          ($14.RegisterFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.RegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$14.VerifyFaceRequest, $14.VerifyFaceResponse>(
          '/pb.FacialRecognitionService/VerifyFace',
          ($14.VerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.VerifyFaceResponse.fromBuffer(value));
  static final _$healthCheck =
      $grpc.ClientMethod<$14.HealthCheckRequest, $14.HealthCheckResponse>(
          '/pb.FacialRecognitionService/HealthCheck',
          ($14.HealthCheckRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.HealthCheckResponse.fromBuffer(value));

  FacialRecognitionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$14.RegisterFaceResponse> registerFace(
      $14.RegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$14.VerifyFaceResponse> verifyFace(
      $14.VerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$14.HealthCheckResponse> healthCheck(
      $14.HealthCheckRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }
}

abstract class FacialRecognitionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.FacialRecognitionService';

  FacialRecognitionServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$14.RegisterFaceRequest, $14.RegisterFaceResponse>(
            'RegisterFace',
            registerFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.RegisterFaceRequest.fromBuffer(value),
            ($14.RegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.VerifyFaceRequest, $14.VerifyFaceResponse>(
            'VerifyFace',
            verifyFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.VerifyFaceRequest.fromBuffer(value),
            ($14.VerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.HealthCheckRequest, $14.HealthCheckResponse>(
            'HealthCheck',
            healthCheck_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.HealthCheckRequest.fromBuffer(value),
            ($14.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.RegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.RegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$14.VerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call,
      $async.Future<$14.VerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$14.HealthCheckResponse> healthCheck_Pre($grpc.ServiceCall call,
      $async.Future<$14.HealthCheckRequest> request) async {
    return healthCheck(call, await request);
  }

  $async.Future<$14.RegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $14.RegisterFaceRequest request);
  $async.Future<$14.VerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $14.VerifyFaceRequest request);
  $async.Future<$14.HealthCheckResponse> healthCheck(
      $grpc.ServiceCall call, $14.HealthCheckRequest request);
}
