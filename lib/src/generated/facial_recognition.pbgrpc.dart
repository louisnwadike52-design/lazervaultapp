///
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'facial_recognition.pb.dart' as $11;
export 'facial_recognition.pb.dart';

class FacialRecognitionServiceClient extends $grpc.Client {
  static final _$registerFace =
      $grpc.ClientMethod<$11.RegisterFaceRequest, $11.RegisterFaceResponse>(
          '/pb.FacialRecognitionService/RegisterFace',
          ($11.RegisterFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.RegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$11.VerifyFaceRequest, $11.VerifyFaceResponse>(
          '/pb.FacialRecognitionService/VerifyFace',
          ($11.VerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.VerifyFaceResponse.fromBuffer(value));
  static final _$healthCheck =
      $grpc.ClientMethod<$11.HealthCheckRequest, $11.HealthCheckResponse>(
          '/pb.FacialRecognitionService/HealthCheck',
          ($11.HealthCheckRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.HealthCheckResponse.fromBuffer(value));

  FacialRecognitionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$11.RegisterFaceResponse> registerFace(
      $11.RegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$11.VerifyFaceResponse> verifyFace(
      $11.VerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$11.HealthCheckResponse> healthCheck(
      $11.HealthCheckRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }
}

abstract class FacialRecognitionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.FacialRecognitionService';

  FacialRecognitionServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$11.RegisterFaceRequest, $11.RegisterFaceResponse>(
            'RegisterFace',
            registerFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $11.RegisterFaceRequest.fromBuffer(value),
            ($11.RegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$11.VerifyFaceRequest, $11.VerifyFaceResponse>(
            'VerifyFace',
            verifyFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $11.VerifyFaceRequest.fromBuffer(value),
            ($11.VerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$11.HealthCheckRequest, $11.HealthCheckResponse>(
            'HealthCheck',
            healthCheck_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $11.HealthCheckRequest.fromBuffer(value),
            ($11.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$11.RegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.RegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$11.VerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call,
      $async.Future<$11.VerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$11.HealthCheckResponse> healthCheck_Pre($grpc.ServiceCall call,
      $async.Future<$11.HealthCheckRequest> request) async {
    return healthCheck(call, await request);
  }

  $async.Future<$11.RegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $11.RegisterFaceRequest request);
  $async.Future<$11.VerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $11.VerifyFaceRequest request);
  $async.Future<$11.HealthCheckResponse> healthCheck(
      $grpc.ServiceCall call, $11.HealthCheckRequest request);
}
