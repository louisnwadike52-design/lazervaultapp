///
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ai_scan.pb.dart' as $3;
export 'ai_scan.pb.dart';

class AiScanServiceClient extends $grpc.Client {
  static final _$startScanSession = $grpc.ClientMethod<
          $3.StartScanSessionRequest, $3.StartScanSessionResponse>(
      '/ai_scan.AiScanService/StartScanSession',
      ($3.StartScanSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.StartScanSessionResponse.fromBuffer(value));
  static final _$processImage =
      $grpc.ClientMethod<$3.ProcessImageRequest, $3.ProcessImageResponse>(
          '/ai_scan.AiScanService/ProcessImage',
          ($3.ProcessImageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.ProcessImageResponse.fromBuffer(value));
  static final _$sendChatMessage =
      $grpc.ClientMethod<$3.SendChatMessageRequest, $3.SendChatMessageResponse>(
          '/ai_scan.AiScanService/SendChatMessage',
          ($3.SendChatMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.SendChatMessageResponse.fromBuffer(value));
  static final _$generatePaymentInstruction = $grpc.ClientMethod<
          $3.GeneratePaymentInstructionRequest,
          $3.GeneratePaymentInstructionResponse>(
      '/ai_scan.AiScanService/GeneratePaymentInstruction',
      ($3.GeneratePaymentInstructionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.GeneratePaymentInstructionResponse.fromBuffer(value));
  static final _$processPayment = $grpc.ClientMethod<
          $3.ScanProcessPaymentRequest, $3.ScanProcessPaymentResponse>(
      '/ai_scan.AiScanService/ProcessPayment',
      ($3.ScanProcessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.ScanProcessPaymentResponse.fromBuffer(value));
  static final _$getScanHistory =
      $grpc.ClientMethod<$3.GetScanHistoryRequest, $3.GetScanHistoryResponse>(
          '/ai_scan.AiScanService/GetScanHistory',
          ($3.GetScanHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.GetScanHistoryResponse.fromBuffer(value));

  AiScanServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.StartScanSessionResponse> startScanSession(
      $3.StartScanSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startScanSession, request, options: options);
  }

  $grpc.ResponseFuture<$3.ProcessImageResponse> processImage(
      $3.ProcessImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processImage, request, options: options);
  }

  $grpc.ResponseFuture<$3.SendChatMessageResponse> sendChatMessage(
      $3.SendChatMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendChatMessage, request, options: options);
  }

  $grpc.ResponseFuture<$3.GeneratePaymentInstructionResponse>
      generatePaymentInstruction($3.GeneratePaymentInstructionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentInstruction, request,
        options: options);
  }

  $grpc.ResponseFuture<$3.ScanProcessPaymentResponse> processPayment(
      $3.ScanProcessPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetScanHistoryResponse> getScanHistory(
      $3.GetScanHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getScanHistory, request, options: options);
  }
}

abstract class AiScanServiceBase extends $grpc.Service {
  $core.String get $name => 'ai_scan.AiScanService';

  AiScanServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.StartScanSessionRequest,
            $3.StartScanSessionResponse>(
        'StartScanSession',
        startScanSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.StartScanSessionRequest.fromBuffer(value),
        ($3.StartScanSessionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.ProcessImageRequest, $3.ProcessImageResponse>(
            'ProcessImage',
            processImage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.ProcessImageRequest.fromBuffer(value),
            ($3.ProcessImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.SendChatMessageRequest,
            $3.SendChatMessageResponse>(
        'SendChatMessage',
        sendChatMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.SendChatMessageRequest.fromBuffer(value),
        ($3.SendChatMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GeneratePaymentInstructionRequest,
            $3.GeneratePaymentInstructionResponse>(
        'GeneratePaymentInstruction',
        generatePaymentInstruction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.GeneratePaymentInstructionRequest.fromBuffer(value),
        ($3.GeneratePaymentInstructionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ScanProcessPaymentRequest,
            $3.ScanProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.ScanProcessPaymentRequest.fromBuffer(value),
        ($3.ScanProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetScanHistoryRequest,
            $3.GetScanHistoryResponse>(
        'GetScanHistory',
        getScanHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.GetScanHistoryRequest.fromBuffer(value),
        ($3.GetScanHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.StartScanSessionResponse> startScanSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.StartScanSessionRequest> request) async {
    return startScanSession(call, await request);
  }

  $async.Future<$3.ProcessImageResponse> processImage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.ProcessImageRequest> request) async {
    return processImage(call, await request);
  }

  $async.Future<$3.SendChatMessageResponse> sendChatMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.SendChatMessageRequest> request) async {
    return sendChatMessage(call, await request);
  }

  $async.Future<$3.GeneratePaymentInstructionResponse>
      generatePaymentInstruction_Pre($grpc.ServiceCall call,
          $async.Future<$3.GeneratePaymentInstructionRequest> request) async {
    return generatePaymentInstruction(call, await request);
  }

  $async.Future<$3.ScanProcessPaymentResponse> processPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.ScanProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$3.GetScanHistoryResponse> getScanHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.GetScanHistoryRequest> request) async {
    return getScanHistory(call, await request);
  }

  $async.Future<$3.StartScanSessionResponse> startScanSession(
      $grpc.ServiceCall call, $3.StartScanSessionRequest request);
  $async.Future<$3.ProcessImageResponse> processImage(
      $grpc.ServiceCall call, $3.ProcessImageRequest request);
  $async.Future<$3.SendChatMessageResponse> sendChatMessage(
      $grpc.ServiceCall call, $3.SendChatMessageRequest request);
  $async.Future<$3.GeneratePaymentInstructionResponse>
      generatePaymentInstruction(
          $grpc.ServiceCall call, $3.GeneratePaymentInstructionRequest request);
  $async.Future<$3.ScanProcessPaymentResponse> processPayment(
      $grpc.ServiceCall call, $3.ScanProcessPaymentRequest request);
  $async.Future<$3.GetScanHistoryResponse> getScanHistory(
      $grpc.ServiceCall call, $3.GetScanHistoryRequest request);
}
