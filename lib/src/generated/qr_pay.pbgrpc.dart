///
//  Generated code. Do not modify.
//  source: qr_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'qr_pay.pb.dart' as $31;
export 'qr_pay.pb.dart';

class QRPayServiceClient extends $grpc.Client {
  static final _$generateQR =
      $grpc.ClientMethod<$31.GenerateQRRequest, $31.GenerateQRResponse>(
          '/qr_pay.QRPayService/GenerateQR',
          ($31.GenerateQRRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.GenerateQRResponse.fromBuffer(value));
  static final _$getQRDetails =
      $grpc.ClientMethod<$31.GetQRDetailsRequest, $31.GetQRDetailsResponse>(
          '/qr_pay.QRPayService/GetQRDetails',
          ($31.GetQRDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.GetQRDetailsResponse.fromBuffer(value));
  static final _$processQRPayment = $grpc.ClientMethod<
          $31.ProcessQRPaymentRequest, $31.ProcessQRPaymentResponse>(
      '/qr_pay.QRPayService/ProcessQRPayment',
      ($31.ProcessQRPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.ProcessQRPaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedQRCodes = $grpc.ClientMethod<
          $31.GetMyGeneratedQRCodesRequest, $31.GetMyGeneratedQRCodesResponse>(
      '/qr_pay.QRPayService/GetMyGeneratedQRCodes',
      ($31.GetMyGeneratedQRCodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.GetMyGeneratedQRCodesResponse.fromBuffer(value));
  static final _$getMyQRPayments = $grpc.ClientMethod<
          $31.GetMyQRPaymentsRequest, $31.GetMyQRPaymentsResponse>(
      '/qr_pay.QRPayService/GetMyQRPayments',
      ($31.GetMyQRPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.GetMyQRPaymentsResponse.fromBuffer(value));
  static final _$cancelQR =
      $grpc.ClientMethod<$31.CancelQRRequest, $31.CancelQRResponse>(
          '/qr_pay.QRPayService/CancelQR',
          ($31.CancelQRRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.CancelQRResponse.fromBuffer(value));
  static final _$getQRTransactionReceipt = $grpc.ClientMethod<
          $31.GetQRTransactionReceiptRequest,
          $31.GetQRTransactionReceiptResponse>(
      '/qr_pay.QRPayService/GetQRTransactionReceipt',
      ($31.GetQRTransactionReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.GetQRTransactionReceiptResponse.fromBuffer(value));

  QRPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$31.GenerateQRResponse> generateQR(
      $31.GenerateQRRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateQR, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetQRDetailsResponse> getQRDetails(
      $31.GetQRDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQRDetails, request, options: options);
  }

  $grpc.ResponseFuture<$31.ProcessQRPaymentResponse> processQRPayment(
      $31.ProcessQRPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processQRPayment, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes(
      $31.GetMyGeneratedQRCodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedQRCodes, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetMyQRPaymentsResponse> getMyQRPayments(
      $31.GetMyQRPaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyQRPayments, request, options: options);
  }

  $grpc.ResponseFuture<$31.CancelQRResponse> cancelQR(
      $31.CancelQRRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelQR, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetQRTransactionReceiptResponse>
      getQRTransactionReceipt($31.GetQRTransactionReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQRTransactionReceipt, request,
        options: options);
  }
}

abstract class QRPayServiceBase extends $grpc.Service {
  $core.String get $name => 'qr_pay.QRPayService';

  QRPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$31.GenerateQRRequest, $31.GenerateQRResponse>(
            'GenerateQR',
            generateQR_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $31.GenerateQRRequest.fromBuffer(value),
            ($31.GenerateQRResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$31.GetQRDetailsRequest, $31.GetQRDetailsResponse>(
            'GetQRDetails',
            getQRDetails_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $31.GetQRDetailsRequest.fromBuffer(value),
            ($31.GetQRDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.ProcessQRPaymentRequest,
            $31.ProcessQRPaymentResponse>(
        'ProcessQRPayment',
        processQRPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.ProcessQRPaymentRequest.fromBuffer(value),
        ($31.ProcessQRPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetMyGeneratedQRCodesRequest,
            $31.GetMyGeneratedQRCodesResponse>(
        'GetMyGeneratedQRCodes',
        getMyGeneratedQRCodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetMyGeneratedQRCodesRequest.fromBuffer(value),
        ($31.GetMyGeneratedQRCodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetMyQRPaymentsRequest,
            $31.GetMyQRPaymentsResponse>(
        'GetMyQRPayments',
        getMyQRPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetMyQRPaymentsRequest.fromBuffer(value),
        ($31.GetMyQRPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.CancelQRRequest, $31.CancelQRResponse>(
        'CancelQR',
        cancelQR_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.CancelQRRequest.fromBuffer(value),
        ($31.CancelQRResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetQRTransactionReceiptRequest,
            $31.GetQRTransactionReceiptResponse>(
        'GetQRTransactionReceipt',
        getQRTransactionReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetQRTransactionReceiptRequest.fromBuffer(value),
        ($31.GetQRTransactionReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$31.GenerateQRResponse> generateQR_Pre($grpc.ServiceCall call,
      $async.Future<$31.GenerateQRRequest> request) async {
    return generateQR(call, await request);
  }

  $async.Future<$31.GetQRDetailsResponse> getQRDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetQRDetailsRequest> request) async {
    return getQRDetails(call, await request);
  }

  $async.Future<$31.ProcessQRPaymentResponse> processQRPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.ProcessQRPaymentRequest> request) async {
    return processQRPayment(call, await request);
  }

  $async.Future<$31.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetMyGeneratedQRCodesRequest> request) async {
    return getMyGeneratedQRCodes(call, await request);
  }

  $async.Future<$31.GetMyQRPaymentsResponse> getMyQRPayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetMyQRPaymentsRequest> request) async {
    return getMyQRPayments(call, await request);
  }

  $async.Future<$31.CancelQRResponse> cancelQR_Pre($grpc.ServiceCall call,
      $async.Future<$31.CancelQRRequest> request) async {
    return cancelQR(call, await request);
  }

  $async.Future<$31.GetQRTransactionReceiptResponse>
      getQRTransactionReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$31.GetQRTransactionReceiptRequest> request) async {
    return getQRTransactionReceipt(call, await request);
  }

  $async.Future<$31.GenerateQRResponse> generateQR(
      $grpc.ServiceCall call, $31.GenerateQRRequest request);
  $async.Future<$31.GetQRDetailsResponse> getQRDetails(
      $grpc.ServiceCall call, $31.GetQRDetailsRequest request);
  $async.Future<$31.ProcessQRPaymentResponse> processQRPayment(
      $grpc.ServiceCall call, $31.ProcessQRPaymentRequest request);
  $async.Future<$31.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes(
      $grpc.ServiceCall call, $31.GetMyGeneratedQRCodesRequest request);
  $async.Future<$31.GetMyQRPaymentsResponse> getMyQRPayments(
      $grpc.ServiceCall call, $31.GetMyQRPaymentsRequest request);
  $async.Future<$31.CancelQRResponse> cancelQR(
      $grpc.ServiceCall call, $31.CancelQRRequest request);
  $async.Future<$31.GetQRTransactionReceiptResponse> getQRTransactionReceipt(
      $grpc.ServiceCall call, $31.GetQRTransactionReceiptRequest request);
}
