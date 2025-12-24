///
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ai_scan.pb.dart' as $4;
export 'ai_scan.pb.dart';

class AiScanServiceClient extends $grpc.Client {
  static final _$startScanSession = $grpc.ClientMethod<
          $4.StartScanSessionRequest, $4.StartScanSessionResponse>(
      '/ai_scan.AiScanService/StartScanSession',
      ($4.StartScanSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.StartScanSessionResponse.fromBuffer(value));
  static final _$processImage =
      $grpc.ClientMethod<$4.ProcessImageRequest, $4.ProcessImageResponse>(
          '/ai_scan.AiScanService/ProcessImage',
          ($4.ProcessImageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ProcessImageResponse.fromBuffer(value));
  static final _$sendChatMessage =
      $grpc.ClientMethod<$4.SendChatMessageRequest, $4.SendChatMessageResponse>(
          '/ai_scan.AiScanService/SendChatMessage',
          ($4.SendChatMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.SendChatMessageResponse.fromBuffer(value));
  static final _$generatePaymentInstruction = $grpc.ClientMethod<
          $4.GeneratePaymentInstructionRequest,
          $4.GeneratePaymentInstructionResponse>(
      '/ai_scan.AiScanService/GeneratePaymentInstruction',
      ($4.GeneratePaymentInstructionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.GeneratePaymentInstructionResponse.fromBuffer(value));
  static final _$processPayment =
      $grpc.ClientMethod<$4.ProcessPaymentRequest, $4.ProcessPaymentResponse>(
          '/ai_scan.AiScanService/ProcessPayment',
          ($4.ProcessPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ProcessPaymentResponse.fromBuffer(value));
  static final _$getScanHistory =
      $grpc.ClientMethod<$4.GetScanHistoryRequest, $4.GetScanHistoryResponse>(
          '/ai_scan.AiScanService/GetScanHistory',
          ($4.GetScanHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.GetScanHistoryResponse.fromBuffer(value));

  AiScanServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.StartScanSessionResponse> startScanSession(
      $4.StartScanSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startScanSession, request, options: options);
  }

  $grpc.ResponseFuture<$4.ProcessImageResponse> processImage(
      $4.ProcessImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processImage, request, options: options);
  }

  $grpc.ResponseFuture<$4.SendChatMessageResponse> sendChatMessage(
      $4.SendChatMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendChatMessage, request, options: options);
  }

  $grpc.ResponseFuture<$4.GeneratePaymentInstructionResponse>
      generatePaymentInstruction($4.GeneratePaymentInstructionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentInstruction, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.ProcessPaymentResponse> processPayment(
      $4.ProcessPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetScanHistoryResponse> getScanHistory(
      $4.GetScanHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getScanHistory, request, options: options);
  }
}

abstract class AiScanServiceBase extends $grpc.Service {
  $core.String get $name => 'ai_scan.AiScanService';

  AiScanServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.StartScanSessionRequest,
            $4.StartScanSessionResponse>(
        'StartScanSession',
        startScanSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.StartScanSessionRequest.fromBuffer(value),
        ($4.StartScanSessionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.ProcessImageRequest, $4.ProcessImageResponse>(
            'ProcessImage',
            processImage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.ProcessImageRequest.fromBuffer(value),
            ($4.ProcessImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SendChatMessageRequest,
            $4.SendChatMessageResponse>(
        'SendChatMessage',
        sendChatMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.SendChatMessageRequest.fromBuffer(value),
        ($4.SendChatMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GeneratePaymentInstructionRequest,
            $4.GeneratePaymentInstructionResponse>(
        'GeneratePaymentInstruction',
        generatePaymentInstruction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.GeneratePaymentInstructionRequest.fromBuffer(value),
        ($4.GeneratePaymentInstructionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ProcessPaymentRequest,
            $4.ProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ProcessPaymentRequest.fromBuffer(value),
        ($4.ProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetScanHistoryRequest,
            $4.GetScanHistoryResponse>(
        'GetScanHistory',
        getScanHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.GetScanHistoryRequest.fromBuffer(value),
        ($4.GetScanHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.StartScanSessionResponse> startScanSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.StartScanSessionRequest> request) async {
    return startScanSession(call, await request);
  }

  $async.Future<$4.ProcessImageResponse> processImage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ProcessImageRequest> request) async {
    return processImage(call, await request);
  }

  $async.Future<$4.SendChatMessageResponse> sendChatMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.SendChatMessageRequest> request) async {
    return sendChatMessage(call, await request);
  }

  $async.Future<$4.GeneratePaymentInstructionResponse>
      generatePaymentInstruction_Pre($grpc.ServiceCall call,
          $async.Future<$4.GeneratePaymentInstructionRequest> request) async {
    return generatePaymentInstruction(call, await request);
  }

  $async.Future<$4.ProcessPaymentResponse> processPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$4.GetScanHistoryResponse> getScanHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.GetScanHistoryRequest> request) async {
    return getScanHistory(call, await request);
  }

  $async.Future<$4.StartScanSessionResponse> startScanSession(
      $grpc.ServiceCall call, $4.StartScanSessionRequest request);
  $async.Future<$4.ProcessImageResponse> processImage(
      $grpc.ServiceCall call, $4.ProcessImageRequest request);
  $async.Future<$4.SendChatMessageResponse> sendChatMessage(
      $grpc.ServiceCall call, $4.SendChatMessageRequest request);
  $async.Future<$4.GeneratePaymentInstructionResponse>
      generatePaymentInstruction(
          $grpc.ServiceCall call, $4.GeneratePaymentInstructionRequest request);
  $async.Future<$4.ProcessPaymentResponse> processPayment(
      $grpc.ServiceCall call, $4.ProcessPaymentRequest request);
  $async.Future<$4.GetScanHistoryResponse> getScanHistory(
      $grpc.ServiceCall call, $4.GetScanHistoryRequest request);
}
