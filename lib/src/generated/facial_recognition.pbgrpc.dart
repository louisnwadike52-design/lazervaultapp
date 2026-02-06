//
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'facial_recognition.pb.dart' as $17;

export 'facial_recognition.pb.dart';

@$pb.GrpcServiceName('pb.FacialRecognitionService')
class FacialRecognitionServiceClient extends $grpc.Client {
  static final _$registerFace = $grpc.ClientMethod<$17.RegisterFaceRequest, $17.RegisterFaceResponse>(
      '/pb.FacialRecognitionService/RegisterFace',
      ($17.RegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $17.RegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace = $grpc.ClientMethod<$17.VerifyFaceRequest, $17.VerifyFaceResponse>(
      '/pb.FacialRecognitionService/VerifyFace',
      ($17.VerifyFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $17.VerifyFaceResponse.fromBuffer(value));
  static final _$healthCheck = $grpc.ClientMethod<$17.HealthCheckRequest, $17.HealthCheckResponse>(
      '/pb.FacialRecognitionService/HealthCheck',
      ($17.HealthCheckRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $17.HealthCheckResponse.fromBuffer(value));

  FacialRecognitionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$17.RegisterFaceResponse> registerFace($17.RegisterFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$17.VerifyFaceResponse> verifyFace($17.VerifyFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$17.HealthCheckResponse> healthCheck($17.HealthCheckRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.FacialRecognitionService')
abstract class FacialRecognitionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.FacialRecognitionService';

  FacialRecognitionServiceBase() {
    $addMethod($grpc.ServiceMethod<$17.RegisterFaceRequest, $17.RegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $17.RegisterFaceRequest.fromBuffer(value),
        ($17.RegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.VerifyFaceRequest, $17.VerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $17.VerifyFaceRequest.fromBuffer(value),
        ($17.VerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.HealthCheckRequest, $17.HealthCheckResponse>(
        'HealthCheck',
        healthCheck_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $17.HealthCheckRequest.fromBuffer(value),
        ($17.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$17.RegisterFaceResponse> registerFace_Pre($grpc.ServiceCall call, $async.Future<$17.RegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$17.VerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call, $async.Future<$17.VerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$17.HealthCheckResponse> healthCheck_Pre($grpc.ServiceCall call, $async.Future<$17.HealthCheckRequest> request) async {
    return healthCheck(call, await request);
  }

  $async.Future<$17.RegisterFaceResponse> registerFace($grpc.ServiceCall call, $17.RegisterFaceRequest request);
  $async.Future<$17.VerifyFaceResponse> verifyFace($grpc.ServiceCall call, $17.VerifyFaceRequest request);
  $async.Future<$17.HealthCheckResponse> healthCheck($grpc.ServiceCall call, $17.HealthCheckRequest request);
}
