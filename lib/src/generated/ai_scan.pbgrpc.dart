//
//  Generated code. Do not modify.
//  source: ai_scan.proto
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

import 'ai_scan.pb.dart' as $0;

export 'ai_scan.pb.dart';

@$pb.GrpcServiceName('ai_scan.AiScanService')
class AiScanServiceClient extends $grpc.Client {
  static final _$startScanSession = $grpc.ClientMethod<$0.StartScanSessionRequest, $0.StartScanSessionResponse>(
      '/ai_scan.AiScanService/StartScanSession',
      ($0.StartScanSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.StartScanSessionResponse.fromBuffer(value));
  static final _$processImage = $grpc.ClientMethod<$0.ProcessImageRequest, $0.ProcessImageResponse>(
      '/ai_scan.AiScanService/ProcessImage',
      ($0.ProcessImageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ProcessImageResponse.fromBuffer(value));
  static final _$sendChatMessage = $grpc.ClientMethod<$0.SendChatMessageRequest, $0.SendChatMessageResponse>(
      '/ai_scan.AiScanService/SendChatMessage',
      ($0.SendChatMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendChatMessageResponse.fromBuffer(value));
  static final _$generatePaymentInstruction = $grpc.ClientMethod<$0.GeneratePaymentInstructionRequest, $0.GeneratePaymentInstructionResponse>(
      '/ai_scan.AiScanService/GeneratePaymentInstruction',
      ($0.GeneratePaymentInstructionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GeneratePaymentInstructionResponse.fromBuffer(value));
  static final _$processPayment = $grpc.ClientMethod<$0.ScanProcessPaymentRequest, $0.ScanProcessPaymentResponse>(
      '/ai_scan.AiScanService/ProcessPayment',
      ($0.ScanProcessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ScanProcessPaymentResponse.fromBuffer(value));
  static final _$getScanHistory = $grpc.ClientMethod<$0.GetScanHistoryRequest, $0.GetScanHistoryResponse>(
      '/ai_scan.AiScanService/GetScanHistory',
      ($0.GetScanHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetScanHistoryResponse.fromBuffer(value));

  AiScanServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.StartScanSessionResponse> startScanSession($0.StartScanSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startScanSession, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessImageResponse> processImage($0.ProcessImageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processImage, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendChatMessageResponse> sendChatMessage($0.SendChatMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendChatMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GeneratePaymentInstructionResponse> generatePaymentInstruction($0.GeneratePaymentInstructionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentInstruction, request, options: options);
  }

  $grpc.ResponseFuture<$0.ScanProcessPaymentResponse> processPayment($0.ScanProcessPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetScanHistoryResponse> getScanHistory($0.GetScanHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getScanHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('ai_scan.AiScanService')
abstract class AiScanServiceBase extends $grpc.Service {
  $core.String get $name => 'ai_scan.AiScanService';

  AiScanServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StartScanSessionRequest, $0.StartScanSessionResponse>(
        'StartScanSession',
        startScanSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StartScanSessionRequest.fromBuffer(value),
        ($0.StartScanSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessImageRequest, $0.ProcessImageResponse>(
        'ProcessImage',
        processImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProcessImageRequest.fromBuffer(value),
        ($0.ProcessImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendChatMessageRequest, $0.SendChatMessageResponse>(
        'SendChatMessage',
        sendChatMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendChatMessageRequest.fromBuffer(value),
        ($0.SendChatMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GeneratePaymentInstructionRequest, $0.GeneratePaymentInstructionResponse>(
        'GeneratePaymentInstruction',
        generatePaymentInstruction_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GeneratePaymentInstructionRequest.fromBuffer(value),
        ($0.GeneratePaymentInstructionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ScanProcessPaymentRequest, $0.ScanProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ScanProcessPaymentRequest.fromBuffer(value),
        ($0.ScanProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetScanHistoryRequest, $0.GetScanHistoryResponse>(
        'GetScanHistory',
        getScanHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetScanHistoryRequest.fromBuffer(value),
        ($0.GetScanHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.StartScanSessionResponse> startScanSession_Pre($grpc.ServiceCall call, $async.Future<$0.StartScanSessionRequest> request) async {
    return startScanSession(call, await request);
  }

  $async.Future<$0.ProcessImageResponse> processImage_Pre($grpc.ServiceCall call, $async.Future<$0.ProcessImageRequest> request) async {
    return processImage(call, await request);
  }

  $async.Future<$0.SendChatMessageResponse> sendChatMessage_Pre($grpc.ServiceCall call, $async.Future<$0.SendChatMessageRequest> request) async {
    return sendChatMessage(call, await request);
  }

  $async.Future<$0.GeneratePaymentInstructionResponse> generatePaymentInstruction_Pre($grpc.ServiceCall call, $async.Future<$0.GeneratePaymentInstructionRequest> request) async {
    return generatePaymentInstruction(call, await request);
  }

  $async.Future<$0.ScanProcessPaymentResponse> processPayment_Pre($grpc.ServiceCall call, $async.Future<$0.ScanProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$0.GetScanHistoryResponse> getScanHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetScanHistoryRequest> request) async {
    return getScanHistory(call, await request);
  }

  $async.Future<$0.StartScanSessionResponse> startScanSession($grpc.ServiceCall call, $0.StartScanSessionRequest request);
  $async.Future<$0.ProcessImageResponse> processImage($grpc.ServiceCall call, $0.ProcessImageRequest request);
  $async.Future<$0.SendChatMessageResponse> sendChatMessage($grpc.ServiceCall call, $0.SendChatMessageRequest request);
  $async.Future<$0.GeneratePaymentInstructionResponse> generatePaymentInstruction($grpc.ServiceCall call, $0.GeneratePaymentInstructionRequest request);
  $async.Future<$0.ScanProcessPaymentResponse> processPayment($grpc.ServiceCall call, $0.ScanProcessPaymentRequest request);
  $async.Future<$0.GetScanHistoryResponse> getScanHistory($grpc.ServiceCall call, $0.GetScanHistoryRequest request);
}
