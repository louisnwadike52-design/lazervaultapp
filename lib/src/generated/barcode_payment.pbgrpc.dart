//
//  Generated code. Do not modify.
//  source: barcode_payment.proto
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

import 'barcode_payment.pb.dart' as $8;

export 'barcode_payment.pb.dart';

@$pb.GrpcServiceName('barcode_payment.BarcodePaymentService')
class BarcodePaymentServiceClient extends $grpc.Client {
  static final _$generateBarcode = $grpc.ClientMethod<$8.GenerateBarcodeRequest, $8.GenerateBarcodeResponse>(
      '/barcode_payment.BarcodePaymentService/GenerateBarcode',
      ($8.GenerateBarcodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GenerateBarcodeResponse.fromBuffer(value));
  static final _$getBarcodeDetails = $grpc.ClientMethod<$8.GetBarcodeDetailsRequest, $8.GetBarcodeDetailsResponse>(
      '/barcode_payment.BarcodePaymentService/GetBarcodeDetails',
      ($8.GetBarcodeDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GetBarcodeDetailsResponse.fromBuffer(value));
  static final _$processBarcodePayment = $grpc.ClientMethod<$8.ProcessBarcodePaymentRequest, $8.ProcessBarcodePaymentResponse>(
      '/barcode_payment.BarcodePaymentService/ProcessBarcodePayment',
      ($8.ProcessBarcodePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.ProcessBarcodePaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedBarcodes = $grpc.ClientMethod<$8.GetMyGeneratedBarcodesRequest, $8.GetMyGeneratedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyGeneratedBarcodes',
      ($8.GetMyGeneratedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GetMyGeneratedBarcodesResponse.fromBuffer(value));
  static final _$getMyScannedBarcodes = $grpc.ClientMethod<$8.GetMyScannedBarcodesRequest, $8.GetMyScannedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyScannedBarcodes',
      ($8.GetMyScannedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GetMyScannedBarcodesResponse.fromBuffer(value));
  static final _$cancelBarcode = $grpc.ClientMethod<$8.CancelBarcodeRequest, $8.CancelBarcodeResponse>(
      '/barcode_payment.BarcodePaymentService/CancelBarcode',
      ($8.CancelBarcodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.CancelBarcodeResponse.fromBuffer(value));

  BarcodePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$8.GenerateBarcodeResponse> generateBarcode($8.GenerateBarcodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateBarcode, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetBarcodeDetailsResponse> getBarcodeDetails($8.GetBarcodeDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBarcodeDetails, request, options: options);
  }

  $grpc.ResponseFuture<$8.ProcessBarcodePaymentResponse> processBarcodePayment($8.ProcessBarcodePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processBarcodePayment, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes($8.GetMyGeneratedBarcodesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedBarcodes, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetMyScannedBarcodesResponse> getMyScannedBarcodes($8.GetMyScannedBarcodesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyScannedBarcodes, request, options: options);
  }

  $grpc.ResponseFuture<$8.CancelBarcodeResponse> cancelBarcode($8.CancelBarcodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelBarcode, request, options: options);
  }
}

@$pb.GrpcServiceName('barcode_payment.BarcodePaymentService')
abstract class BarcodePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'barcode_payment.BarcodePaymentService';

  BarcodePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.GenerateBarcodeRequest, $8.GenerateBarcodeResponse>(
        'GenerateBarcode',
        generateBarcode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GenerateBarcodeRequest.fromBuffer(value),
        ($8.GenerateBarcodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.GetBarcodeDetailsRequest, $8.GetBarcodeDetailsResponse>(
        'GetBarcodeDetails',
        getBarcodeDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GetBarcodeDetailsRequest.fromBuffer(value),
        ($8.GetBarcodeDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.ProcessBarcodePaymentRequest, $8.ProcessBarcodePaymentResponse>(
        'ProcessBarcodePayment',
        processBarcodePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.ProcessBarcodePaymentRequest.fromBuffer(value),
        ($8.ProcessBarcodePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.GetMyGeneratedBarcodesRequest, $8.GetMyGeneratedBarcodesResponse>(
        'GetMyGeneratedBarcodes',
        getMyGeneratedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GetMyGeneratedBarcodesRequest.fromBuffer(value),
        ($8.GetMyGeneratedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.GetMyScannedBarcodesRequest, $8.GetMyScannedBarcodesResponse>(
        'GetMyScannedBarcodes',
        getMyScannedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GetMyScannedBarcodesRequest.fromBuffer(value),
        ($8.GetMyScannedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.CancelBarcodeRequest, $8.CancelBarcodeResponse>(
        'CancelBarcode',
        cancelBarcode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.CancelBarcodeRequest.fromBuffer(value),
        ($8.CancelBarcodeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$8.GenerateBarcodeResponse> generateBarcode_Pre($grpc.ServiceCall call, $async.Future<$8.GenerateBarcodeRequest> request) async {
    return generateBarcode(call, await request);
  }

  $async.Future<$8.GetBarcodeDetailsResponse> getBarcodeDetails_Pre($grpc.ServiceCall call, $async.Future<$8.GetBarcodeDetailsRequest> request) async {
    return getBarcodeDetails(call, await request);
  }

  $async.Future<$8.ProcessBarcodePaymentResponse> processBarcodePayment_Pre($grpc.ServiceCall call, $async.Future<$8.ProcessBarcodePaymentRequest> request) async {
    return processBarcodePayment(call, await request);
  }

  $async.Future<$8.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes_Pre($grpc.ServiceCall call, $async.Future<$8.GetMyGeneratedBarcodesRequest> request) async {
    return getMyGeneratedBarcodes(call, await request);
  }

  $async.Future<$8.GetMyScannedBarcodesResponse> getMyScannedBarcodes_Pre($grpc.ServiceCall call, $async.Future<$8.GetMyScannedBarcodesRequest> request) async {
    return getMyScannedBarcodes(call, await request);
  }

  $async.Future<$8.CancelBarcodeResponse> cancelBarcode_Pre($grpc.ServiceCall call, $async.Future<$8.CancelBarcodeRequest> request) async {
    return cancelBarcode(call, await request);
  }

  $async.Future<$8.GenerateBarcodeResponse> generateBarcode($grpc.ServiceCall call, $8.GenerateBarcodeRequest request);
  $async.Future<$8.GetBarcodeDetailsResponse> getBarcodeDetails($grpc.ServiceCall call, $8.GetBarcodeDetailsRequest request);
  $async.Future<$8.ProcessBarcodePaymentResponse> processBarcodePayment($grpc.ServiceCall call, $8.ProcessBarcodePaymentRequest request);
  $async.Future<$8.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes($grpc.ServiceCall call, $8.GetMyGeneratedBarcodesRequest request);
  $async.Future<$8.GetMyScannedBarcodesResponse> getMyScannedBarcodes($grpc.ServiceCall call, $8.GetMyScannedBarcodesRequest request);
  $async.Future<$8.CancelBarcodeResponse> cancelBarcode($grpc.ServiceCall call, $8.CancelBarcodeRequest request);
}
