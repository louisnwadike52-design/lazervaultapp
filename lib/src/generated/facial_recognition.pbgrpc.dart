///
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'facial_recognition.pb.dart' as $13;
export 'facial_recognition.pb.dart';

class FacialRecognitionServiceClient extends $grpc.Client {
  static final _$registerFace =
      $grpc.ClientMethod<$13.RegisterFaceRequest, $13.RegisterFaceResponse>(
          '/pb.FacialRecognitionService/RegisterFace',
          ($13.RegisterFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.RegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$13.VerifyFaceRequest, $13.VerifyFaceResponse>(
          '/pb.FacialRecognitionService/VerifyFace',
          ($13.VerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.VerifyFaceResponse.fromBuffer(value));
  static final _$healthCheck =
      $grpc.ClientMethod<$13.HealthCheckRequest, $13.HealthCheckResponse>(
          '/pb.FacialRecognitionService/HealthCheck',
          ($13.HealthCheckRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.HealthCheckResponse.fromBuffer(value));

  FacialRecognitionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$13.RegisterFaceResponse> registerFace(
      $13.RegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$13.VerifyFaceResponse> verifyFace(
      $13.VerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$13.HealthCheckResponse> healthCheck(
      $13.HealthCheckRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }
}

abstract class FacialRecognitionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.FacialRecognitionService';

  FacialRecognitionServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$13.RegisterFaceRequest, $13.RegisterFaceResponse>(
            'RegisterFace',
            registerFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.RegisterFaceRequest.fromBuffer(value),
            ($13.RegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.VerifyFaceRequest, $13.VerifyFaceResponse>(
            'VerifyFace',
            verifyFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.VerifyFaceRequest.fromBuffer(value),
            ($13.VerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.HealthCheckRequest, $13.HealthCheckResponse>(
            'HealthCheck',
            healthCheck_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.HealthCheckRequest.fromBuffer(value),
            ($13.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.RegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.RegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$13.VerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call,
      $async.Future<$13.VerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$13.HealthCheckResponse> healthCheck_Pre($grpc.ServiceCall call,
      $async.Future<$13.HealthCheckRequest> request) async {
    return healthCheck(call, await request);
  }

  $async.Future<$13.RegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $13.RegisterFaceRequest request);
  $async.Future<$13.VerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $13.VerifyFaceRequest request);
  $async.Future<$13.HealthCheckResponse> healthCheck(
      $grpc.ServiceCall call, $13.HealthCheckRequest request);
}
