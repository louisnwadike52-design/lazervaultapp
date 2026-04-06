///
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ai_scan.pb.dart' as $1;
export 'ai_scan.pb.dart';

class AiScanServiceClient extends $grpc.Client {
  static final _$startScanSession = $grpc.ClientMethod<
          $1.StartScanSessionRequest, $1.StartScanSessionResponse>(
      '/pb.AiScanService/StartScanSession',
      ($1.StartScanSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.StartScanSessionResponse.fromBuffer(value));
  static final _$processImage =
      $grpc.ClientMethod<$1.ProcessImageRequest, $1.ProcessImageResponse>(
          '/pb.AiScanService/ProcessImage',
          ($1.ProcessImageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProcessImageResponse.fromBuffer(value));
  static final _$sendChatMessage =
      $grpc.ClientMethod<$1.SendChatMessageRequest, $1.SendChatMessageResponse>(
          '/pb.AiScanService/SendChatMessage',
          ($1.SendChatMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SendChatMessageResponse.fromBuffer(value));
  static final _$generatePaymentInstruction = $grpc.ClientMethod<
          $1.GeneratePaymentInstructionRequest,
          $1.GeneratePaymentInstructionResponse>(
      '/pb.AiScanService/GeneratePaymentInstruction',
      ($1.GeneratePaymentInstructionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GeneratePaymentInstructionResponse.fromBuffer(value));
  static final _$processPayment = $grpc.ClientMethod<
          $1.ScanProcessPaymentRequest, $1.ScanProcessPaymentResponse>(
      '/pb.AiScanService/ProcessPayment',
      ($1.ScanProcessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ScanProcessPaymentResponse.fromBuffer(value));
  static final _$getScanHistory =
      $grpc.ClientMethod<$1.GetScanHistoryRequest, $1.GetScanHistoryResponse>(
          '/pb.AiScanService/GetScanHistory',
          ($1.GetScanHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetScanHistoryResponse.fromBuffer(value));

  AiScanServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.StartScanSessionResponse> startScanSession(
      $1.StartScanSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startScanSession, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProcessImageResponse> processImage(
      $1.ProcessImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processImage, request, options: options);
  }

  $grpc.ResponseFuture<$1.SendChatMessageResponse> sendChatMessage(
      $1.SendChatMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendChatMessage, request, options: options);
  }

  $grpc.ResponseFuture<$1.GeneratePaymentInstructionResponse>
      generatePaymentInstruction($1.GeneratePaymentInstructionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentInstruction, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ScanProcessPaymentResponse> processPayment(
      $1.ScanProcessPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetScanHistoryResponse> getScanHistory(
      $1.GetScanHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getScanHistory, request, options: options);
  }
}

abstract class AiScanServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AiScanService';

  AiScanServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.StartScanSessionRequest,
            $1.StartScanSessionResponse>(
        'StartScanSession',
        startScanSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.StartScanSessionRequest.fromBuffer(value),
        ($1.StartScanSessionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.ProcessImageRequest, $1.ProcessImageResponse>(
            'ProcessImage',
            processImage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.ProcessImageRequest.fromBuffer(value),
            ($1.ProcessImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendChatMessageRequest,
            $1.SendChatMessageResponse>(
        'SendChatMessage',
        sendChatMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SendChatMessageRequest.fromBuffer(value),
        ($1.SendChatMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GeneratePaymentInstructionRequest,
            $1.GeneratePaymentInstructionResponse>(
        'GeneratePaymentInstruction',
        generatePaymentInstruction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GeneratePaymentInstructionRequest.fromBuffer(value),
        ($1.GeneratePaymentInstructionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ScanProcessPaymentRequest,
            $1.ScanProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ScanProcessPaymentRequest.fromBuffer(value),
        ($1.ScanProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetScanHistoryRequest,
            $1.GetScanHistoryResponse>(
        'GetScanHistory',
        getScanHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetScanHistoryRequest.fromBuffer(value),
        ($1.GetScanHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.StartScanSessionResponse> startScanSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.StartScanSessionRequest> request) async {
    return startScanSession(call, await request);
  }

  $async.Future<$1.ProcessImageResponse> processImage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ProcessImageRequest> request) async {
    return processImage(call, await request);
  }

  $async.Future<$1.SendChatMessageResponse> sendChatMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SendChatMessageRequest> request) async {
    return sendChatMessage(call, await request);
  }

  $async.Future<$1.GeneratePaymentInstructionResponse>
      generatePaymentInstruction_Pre($grpc.ServiceCall call,
          $async.Future<$1.GeneratePaymentInstructionRequest> request) async {
    return generatePaymentInstruction(call, await request);
  }

  $async.Future<$1.ScanProcessPaymentResponse> processPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ScanProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$1.GetScanHistoryResponse> getScanHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetScanHistoryRequest> request) async {
    return getScanHistory(call, await request);
  }

  $async.Future<$1.StartScanSessionResponse> startScanSession(
      $grpc.ServiceCall call, $1.StartScanSessionRequest request);
  $async.Future<$1.ProcessImageResponse> processImage(
      $grpc.ServiceCall call, $1.ProcessImageRequest request);
  $async.Future<$1.SendChatMessageResponse> sendChatMessage(
      $grpc.ServiceCall call, $1.SendChatMessageRequest request);
  $async.Future<$1.GeneratePaymentInstructionResponse>
      generatePaymentInstruction(
          $grpc.ServiceCall call, $1.GeneratePaymentInstructionRequest request);
  $async.Future<$1.ScanProcessPaymentResponse> processPayment(
      $grpc.ServiceCall call, $1.ScanProcessPaymentRequest request);
  $async.Future<$1.GetScanHistoryResponse> getScanHistory(
      $grpc.ServiceCall call, $1.GetScanHistoryRequest request);
}
