//
//  Generated code. Do not modify.
//  source: qr_pay.proto
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

import 'qr_pay.pb.dart' as $0;

export 'qr_pay.pb.dart';

@$pb.GrpcServiceName('qr_pay.QRPayService')
class QRPayServiceClient extends $grpc.Client {
  static final _$generateQR = $grpc.ClientMethod<$0.GenerateQRRequest, $0.GenerateQRResponse>(
      '/qr_pay.QRPayService/GenerateQR',
      ($0.GenerateQRRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateQRResponse.fromBuffer(value));
  static final _$getQRDetails = $grpc.ClientMethod<$0.GetQRDetailsRequest, $0.GetQRDetailsResponse>(
      '/qr_pay.QRPayService/GetQRDetails',
      ($0.GetQRDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetQRDetailsResponse.fromBuffer(value));
  static final _$processQRPayment = $grpc.ClientMethod<$0.ProcessQRPaymentRequest, $0.ProcessQRPaymentResponse>(
      '/qr_pay.QRPayService/ProcessQRPayment',
      ($0.ProcessQRPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ProcessQRPaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedQRCodes = $grpc.ClientMethod<$0.GetMyGeneratedQRCodesRequest, $0.GetMyGeneratedQRCodesResponse>(
      '/qr_pay.QRPayService/GetMyGeneratedQRCodes',
      ($0.GetMyGeneratedQRCodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyGeneratedQRCodesResponse.fromBuffer(value));
  static final _$getMyQRPayments = $grpc.ClientMethod<$0.GetMyQRPaymentsRequest, $0.GetMyQRPaymentsResponse>(
      '/qr_pay.QRPayService/GetMyQRPayments',
      ($0.GetMyQRPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyQRPaymentsResponse.fromBuffer(value));
  static final _$cancelQR = $grpc.ClientMethod<$0.CancelQRRequest, $0.CancelQRResponse>(
      '/qr_pay.QRPayService/CancelQR',
      ($0.CancelQRRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelQRResponse.fromBuffer(value));
  static final _$getQRTransactionReceipt = $grpc.ClientMethod<$0.GetQRTransactionReceiptRequest, $0.GetQRTransactionReceiptResponse>(
      '/qr_pay.QRPayService/GetQRTransactionReceipt',
      ($0.GetQRTransactionReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetQRTransactionReceiptResponse.fromBuffer(value));

  QRPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GenerateQRResponse> generateQR($0.GenerateQRRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateQR, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetQRDetailsResponse> getQRDetails($0.GetQRDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQRDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessQRPaymentResponse> processQRPayment($0.ProcessQRPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processQRPayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes($0.GetMyGeneratedQRCodesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedQRCodes, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyQRPaymentsResponse> getMyQRPayments($0.GetMyQRPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyQRPayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelQRResponse> cancelQR($0.CancelQRRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelQR, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetQRTransactionReceiptResponse> getQRTransactionReceipt($0.GetQRTransactionReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQRTransactionReceipt, request, options: options);
  }
}

@$pb.GrpcServiceName('qr_pay.QRPayService')
abstract class QRPayServiceBase extends $grpc.Service {
  $core.String get $name => 'qr_pay.QRPayService';

  QRPayServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GenerateQRRequest, $0.GenerateQRResponse>(
        'GenerateQR',
        generateQR_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GenerateQRRequest.fromBuffer(value),
        ($0.GenerateQRResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetQRDetailsRequest, $0.GetQRDetailsResponse>(
        'GetQRDetails',
        getQRDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetQRDetailsRequest.fromBuffer(value),
        ($0.GetQRDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessQRPaymentRequest, $0.ProcessQRPaymentResponse>(
        'ProcessQRPayment',
        processQRPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProcessQRPaymentRequest.fromBuffer(value),
        ($0.ProcessQRPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyGeneratedQRCodesRequest, $0.GetMyGeneratedQRCodesResponse>(
        'GetMyGeneratedQRCodes',
        getMyGeneratedQRCodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyGeneratedQRCodesRequest.fromBuffer(value),
        ($0.GetMyGeneratedQRCodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyQRPaymentsRequest, $0.GetMyQRPaymentsResponse>(
        'GetMyQRPayments',
        getMyQRPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyQRPaymentsRequest.fromBuffer(value),
        ($0.GetMyQRPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelQRRequest, $0.CancelQRResponse>(
        'CancelQR',
        cancelQR_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelQRRequest.fromBuffer(value),
        ($0.CancelQRResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetQRTransactionReceiptRequest, $0.GetQRTransactionReceiptResponse>(
        'GetQRTransactionReceipt',
        getQRTransactionReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetQRTransactionReceiptRequest.fromBuffer(value),
        ($0.GetQRTransactionReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GenerateQRResponse> generateQR_Pre($grpc.ServiceCall call, $async.Future<$0.GenerateQRRequest> request) async {
    return generateQR(call, await request);
  }

  $async.Future<$0.GetQRDetailsResponse> getQRDetails_Pre($grpc.ServiceCall call, $async.Future<$0.GetQRDetailsRequest> request) async {
    return getQRDetails(call, await request);
  }

  $async.Future<$0.ProcessQRPaymentResponse> processQRPayment_Pre($grpc.ServiceCall call, $async.Future<$0.ProcessQRPaymentRequest> request) async {
    return processQRPayment(call, await request);
  }

  $async.Future<$0.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyGeneratedQRCodesRequest> request) async {
    return getMyGeneratedQRCodes(call, await request);
  }

  $async.Future<$0.GetMyQRPaymentsResponse> getMyQRPayments_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyQRPaymentsRequest> request) async {
    return getMyQRPayments(call, await request);
  }

  $async.Future<$0.CancelQRResponse> cancelQR_Pre($grpc.ServiceCall call, $async.Future<$0.CancelQRRequest> request) async {
    return cancelQR(call, await request);
  }

  $async.Future<$0.GetQRTransactionReceiptResponse> getQRTransactionReceipt_Pre($grpc.ServiceCall call, $async.Future<$0.GetQRTransactionReceiptRequest> request) async {
    return getQRTransactionReceipt(call, await request);
  }

  $async.Future<$0.GenerateQRResponse> generateQR($grpc.ServiceCall call, $0.GenerateQRRequest request);
  $async.Future<$0.GetQRDetailsResponse> getQRDetails($grpc.ServiceCall call, $0.GetQRDetailsRequest request);
  $async.Future<$0.ProcessQRPaymentResponse> processQRPayment($grpc.ServiceCall call, $0.ProcessQRPaymentRequest request);
  $async.Future<$0.GetMyGeneratedQRCodesResponse> getMyGeneratedQRCodes($grpc.ServiceCall call, $0.GetMyGeneratedQRCodesRequest request);
  $async.Future<$0.GetMyQRPaymentsResponse> getMyQRPayments($grpc.ServiceCall call, $0.GetMyQRPaymentsRequest request);
  $async.Future<$0.CancelQRResponse> cancelQR($grpc.ServiceCall call, $0.CancelQRRequest request);
  $async.Future<$0.GetQRTransactionReceiptResponse> getQRTransactionReceipt($grpc.ServiceCall call, $0.GetQRTransactionReceiptRequest request);
}
