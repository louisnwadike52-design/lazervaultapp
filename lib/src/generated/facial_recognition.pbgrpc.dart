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

import 'facial_recognition.pb.dart' as $0;

export 'facial_recognition.pb.dart';

@$pb.GrpcServiceName('pb.FacialRecognitionService')
class FacialRecognitionServiceClient extends $grpc.Client {
  static final _$registerFace = $grpc.ClientMethod<$0.RegisterFaceRequest, $0.RegisterFaceResponse>(
      '/pb.FacialRecognitionService/RegisterFace',
      ($0.RegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace = $grpc.ClientMethod<$0.VerifyFaceRequest, $0.VerifyFaceResponse>(
      '/pb.FacialRecognitionService/VerifyFace',
      ($0.VerifyFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyFaceResponse.fromBuffer(value));
  static final _$healthCheck = $grpc.ClientMethod<$0.HealthCheckRequest, $0.HealthCheckResponse>(
      '/pb.FacialRecognitionService/HealthCheck',
      ($0.HealthCheckRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HealthCheckResponse.fromBuffer(value));

  FacialRecognitionServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.RegisterFaceResponse> registerFace($0.RegisterFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyFaceResponse> verifyFace($0.VerifyFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$0.HealthCheckResponse> healthCheck($0.HealthCheckRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.FacialRecognitionService')
abstract class FacialRecognitionServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.FacialRecognitionService';

  FacialRecognitionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterFaceRequest, $0.RegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterFaceRequest.fromBuffer(value),
        ($0.RegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyFaceRequest, $0.VerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyFaceRequest.fromBuffer(value),
        ($0.VerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HealthCheckRequest, $0.HealthCheckResponse>(
        'HealthCheck',
        healthCheck_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HealthCheckRequest.fromBuffer(value),
        ($0.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RegisterFaceResponse> registerFace_Pre($grpc.ServiceCall call, $async.Future<$0.RegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$0.VerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$0.HealthCheckResponse> healthCheck_Pre($grpc.ServiceCall call, $async.Future<$0.HealthCheckRequest> request) async {
    return healthCheck(call, await request);
  }

  $async.Future<$0.RegisterFaceResponse> registerFace($grpc.ServiceCall call, $0.RegisterFaceRequest request);
  $async.Future<$0.VerifyFaceResponse> verifyFace($grpc.ServiceCall call, $0.VerifyFaceRequest request);
  $async.Future<$0.HealthCheckResponse> healthCheck($grpc.ServiceCall call, $0.HealthCheckRequest request);
}
