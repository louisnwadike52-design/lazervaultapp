///
//  Generated code. Do not modify.
//  source: qr_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'qr_pay.pb.dart' as $30;
export 'qr_pay.pb.dart';

class QRPayServiceClient extends $grpc.Client {
  static final _$generateQR =
      $grpc.ClientMethod<$30.GenerateQRRequest, $30.GenerateQRResponse>(
          '/qr_pay.QRPayService/GenerateQR',
          ($30.GenerateQRRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.GenerateQRResponse.fromBuffer(value));
  static final _$getQRDetails =
      $grpc.ClientMethod<$30.GetQRDetailsRequest, $30.GetQRDetailsResponse>(
          '/qr_pay.QRPayService/GetQRDetails',
          ($30.GetQRDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.GetQRDetailsResponse.fromBuffer(value));
  static final _$processQRPayment = $grpc.ClientMethod<
          $30.ProcessQRPaymentRequest, $30.ProcessQRPaymentResponse>(
      '/qr_pay.QRPayService/ProcessQRPayment',
      ($30.ProcessQRPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.ProcessQRPaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedQRCodes = $grpc.ClientMethod<
          $30.GetMyGeneratedQRCodesRequest, $30.GetMyGeneratedQRCodesResponse>(
      '/qr_pay.QRPayService/GetMyGeneratedQRCodes',
      ($30.GetMyGeneratedQRCodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetMyGeneratedQRCodesResponse.fromBuffer(value));
  static final _$getMyQRPayments = $grpc.ClientMethod<
          $30.GetMyQRPaymentsRequest, $30.GetMyQRPaymentsResponse>(
      '/qr_pay.QRPayService/GetMyQRPayments',
      ($30.GetMyQRPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetMyQRPaymentsResponse.fromBuffer(value));
  static final _$cancelQR =
      $grpc.ClientMethod<$30.CancelQRRequest, $30.CancelQRResponse>(
          '/qr_pay.QRPayService/CancelQR',
          ($30.CancelQRRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.CancelQRResponse.fromBuffer(value));
  static final _$getQRTransactionReceipt = $grpc.ClientMethod<
          $30.GetQRTransactionReceiptRequest,
          $30.GetQRTransactionReceiptResponse>(
      '/qr_pay.QRPayService/GetQRTransactionReceipt',
      ($30.GetQRTransactionReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetQRTransactionReceiptResponse.fromBuffer(value));

  QRPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$30.GenerateQRResponse> generateQR(
      $30.GenerateQRRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateQR, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetQRDetailsResponse> getQRDetails(
      $30.GetQRDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQRDetails, request, options: options);
  }

  $grpc.ResponseFuture<$30.ProcessQRPaymentResponse> processQRPayment(
      $30.ProcessQRPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processQRPayment, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes(
      $30.GetMyGeneratedQRCodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedQRCodes, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetMyQRPaymentsResponse> getMyQRPayments(
      $30.GetMyQRPaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyQRPayments, request, options: options);
  }

  $grpc.ResponseFuture<$30.CancelQRResponse> cancelQR(
      $30.CancelQRRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelQR, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetQRTransactionReceiptResponse>
      getQRTransactionReceipt($30.GetQRTransactionReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQRTransactionReceipt, request,
        options: options);
  }
}

abstract class QRPayServiceBase extends $grpc.Service {
  $core.String get $name => 'qr_pay.QRPayService';

  QRPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$30.GenerateQRRequest, $30.GenerateQRResponse>(
            'GenerateQR',
            generateQR_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $30.GenerateQRRequest.fromBuffer(value),
            ($30.GenerateQRResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$30.GetQRDetailsRequest, $30.GetQRDetailsResponse>(
            'GetQRDetails',
            getQRDetails_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $30.GetQRDetailsRequest.fromBuffer(value),
            ($30.GetQRDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.ProcessQRPaymentRequest,
            $30.ProcessQRPaymentResponse>(
        'ProcessQRPayment',
        processQRPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.ProcessQRPaymentRequest.fromBuffer(value),
        ($30.ProcessQRPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetMyGeneratedQRCodesRequest,
            $30.GetMyGeneratedQRCodesResponse>(
        'GetMyGeneratedQRCodes',
        getMyGeneratedQRCodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetMyGeneratedQRCodesRequest.fromBuffer(value),
        ($30.GetMyGeneratedQRCodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetMyQRPaymentsRequest,
            $30.GetMyQRPaymentsResponse>(
        'GetMyQRPayments',
        getMyQRPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetMyQRPaymentsRequest.fromBuffer(value),
        ($30.GetMyQRPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CancelQRRequest, $30.CancelQRResponse>(
        'CancelQR',
        cancelQR_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CancelQRRequest.fromBuffer(value),
        ($30.CancelQRResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetQRTransactionReceiptRequest,
            $30.GetQRTransactionReceiptResponse>(
        'GetQRTransactionReceipt',
        getQRTransactionReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetQRTransactionReceiptRequest.fromBuffer(value),
        ($30.GetQRTransactionReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$30.GenerateQRResponse> generateQR_Pre($grpc.ServiceCall call,
      $async.Future<$30.GenerateQRRequest> request) async {
    return generateQR(call, await request);
  }

  $async.Future<$30.GetQRDetailsResponse> getQRDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetQRDetailsRequest> request) async {
    return getQRDetails(call, await request);
  }

  $async.Future<$30.ProcessQRPaymentResponse> processQRPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.ProcessQRPaymentRequest> request) async {
    return processQRPayment(call, await request);
  }

  $async.Future<$30.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetMyGeneratedQRCodesRequest> request) async {
    return getMyGeneratedQRCodes(call, await request);
  }

  $async.Future<$30.GetMyQRPaymentsResponse> getMyQRPayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetMyQRPaymentsRequest> request) async {
    return getMyQRPayments(call, await request);
  }

  $async.Future<$30.CancelQRResponse> cancelQR_Pre($grpc.ServiceCall call,
      $async.Future<$30.CancelQRRequest> request) async {
    return cancelQR(call, await request);
  }

  $async.Future<$30.GetQRTransactionReceiptResponse>
      getQRTransactionReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$30.GetQRTransactionReceiptRequest> request) async {
    return getQRTransactionReceipt(call, await request);
  }

  $async.Future<$30.GenerateQRResponse> generateQR(
      $grpc.ServiceCall call, $30.GenerateQRRequest request);
  $async.Future<$30.GetQRDetailsResponse> getQRDetails(
      $grpc.ServiceCall call, $30.GetQRDetailsRequest request);
  $async.Future<$30.ProcessQRPaymentResponse> processQRPayment(
      $grpc.ServiceCall call, $30.ProcessQRPaymentRequest request);
  $async.Future<$30.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes(
      $grpc.ServiceCall call, $30.GetMyGeneratedQRCodesRequest request);
  $async.Future<$30.GetMyQRPaymentsResponse> getMyQRPayments(
      $grpc.ServiceCall call, $30.GetMyQRPaymentsRequest request);
  $async.Future<$30.CancelQRResponse> cancelQR(
      $grpc.ServiceCall call, $30.CancelQRRequest request);
  $async.Future<$30.GetQRTransactionReceiptResponse> getQRTransactionReceipt(
      $grpc.ServiceCall call, $30.GetQRTransactionReceiptRequest request);
}
