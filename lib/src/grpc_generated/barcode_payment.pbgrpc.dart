///
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'barcode_payment.pb.dart' as $0;
export 'barcode_payment.pb.dart';

class BarcodePaymentServiceClient extends $grpc.Client {
  static final _$generateBarcode =
      $grpc.ClientMethod<$0.GenerateBarcodeRequest, $0.GenerateBarcodeResponse>(
          '/barcode_payment.BarcodePaymentService/GenerateBarcode',
          ($0.GenerateBarcodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GenerateBarcodeResponse.fromBuffer(value));
  static final _$getBarcodeDetails = $grpc.ClientMethod<
          $0.GetBarcodeDetailsRequest, $0.GetBarcodeDetailsResponse>(
      '/barcode_payment.BarcodePaymentService/GetBarcodeDetails',
      ($0.GetBarcodeDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBarcodeDetailsResponse.fromBuffer(value));
  static final _$processBarcodePayment = $grpc.ClientMethod<
          $0.ProcessBarcodePaymentRequest, $0.ProcessBarcodePaymentResponse>(
      '/barcode_payment.BarcodePaymentService/ProcessBarcodePayment',
      ($0.ProcessBarcodePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ProcessBarcodePaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedBarcodes = $grpc.ClientMethod<
          $0.GetMyGeneratedBarcodesRequest, $0.GetMyGeneratedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyGeneratedBarcodes',
      ($0.GetMyGeneratedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyGeneratedBarcodesResponse.fromBuffer(value));
  static final _$getMyScannedBarcodes = $grpc.ClientMethod<
          $0.GetMyScannedBarcodesRequest, $0.GetMyScannedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyScannedBarcodes',
      ($0.GetMyScannedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyScannedBarcodesResponse.fromBuffer(value));
  static final _$cancelBarcode =
      $grpc.ClientMethod<$0.CancelBarcodeRequest, $0.CancelBarcodeResponse>(
          '/barcode_payment.BarcodePaymentService/CancelBarcode',
          ($0.CancelBarcodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelBarcodeResponse.fromBuffer(value));

  BarcodePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GenerateBarcodeResponse> generateBarcode(
      $0.GenerateBarcodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateBarcode, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBarcodeDetailsResponse> getBarcodeDetails(
      $0.GetBarcodeDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBarcodeDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessBarcodePaymentResponse> processBarcodePayment(
      $0.ProcessBarcodePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processBarcodePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyGeneratedBarcodesResponse>
      getMyGeneratedBarcodes($0.GetMyGeneratedBarcodesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedBarcodes, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyScannedBarcodesResponse> getMyScannedBarcodes(
      $0.GetMyScannedBarcodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyScannedBarcodes, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelBarcodeResponse> cancelBarcode(
      $0.CancelBarcodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelBarcode, request, options: options);
  }
}

abstract class BarcodePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'barcode_payment.BarcodePaymentService';

  BarcodePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GenerateBarcodeRequest,
            $0.GenerateBarcodeResponse>(
        'GenerateBarcode',
        generateBarcode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateBarcodeRequest.fromBuffer(value),
        ($0.GenerateBarcodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBarcodeDetailsRequest,
            $0.GetBarcodeDetailsResponse>(
        'GetBarcodeDetails',
        getBarcodeDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBarcodeDetailsRequest.fromBuffer(value),
        ($0.GetBarcodeDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessBarcodePaymentRequest,
            $0.ProcessBarcodePaymentResponse>(
        'ProcessBarcodePayment',
        processBarcodePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessBarcodePaymentRequest.fromBuffer(value),
        ($0.ProcessBarcodePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyGeneratedBarcodesRequest,
            $0.GetMyGeneratedBarcodesResponse>(
        'GetMyGeneratedBarcodes',
        getMyGeneratedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyGeneratedBarcodesRequest.fromBuffer(value),
        ($0.GetMyGeneratedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyScannedBarcodesRequest,
            $0.GetMyScannedBarcodesResponse>(
        'GetMyScannedBarcodes',
        getMyScannedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyScannedBarcodesRequest.fromBuffer(value),
        ($0.GetMyScannedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CancelBarcodeRequest, $0.CancelBarcodeResponse>(
            'CancelBarcode',
            cancelBarcode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CancelBarcodeRequest.fromBuffer(value),
            ($0.CancelBarcodeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GenerateBarcodeResponse> generateBarcode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateBarcodeRequest> request) async {
    return generateBarcode(call, await request);
  }

  $async.Future<$0.GetBarcodeDetailsResponse> getBarcodeDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBarcodeDetailsRequest> request) async {
    return getBarcodeDetails(call, await request);
  }

  $async.Future<$0.ProcessBarcodePaymentResponse> processBarcodePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ProcessBarcodePaymentRequest> request) async {
    return processBarcodePayment(call, await request);
  }

  $async.Future<$0.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyGeneratedBarcodesRequest> request) async {
    return getMyGeneratedBarcodes(call, await request);
  }

  $async.Future<$0.GetMyScannedBarcodesResponse> getMyScannedBarcodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyScannedBarcodesRequest> request) async {
    return getMyScannedBarcodes(call, await request);
  }

  $async.Future<$0.CancelBarcodeResponse> cancelBarcode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelBarcodeRequest> request) async {
    return cancelBarcode(call, await request);
  }

  $async.Future<$0.GenerateBarcodeResponse> generateBarcode(
      $grpc.ServiceCall call, $0.GenerateBarcodeRequest request);
  $async.Future<$0.GetBarcodeDetailsResponse> getBarcodeDetails(
      $grpc.ServiceCall call, $0.GetBarcodeDetailsRequest request);
  $async.Future<$0.ProcessBarcodePaymentResponse> processBarcodePayment(
      $grpc.ServiceCall call, $0.ProcessBarcodePaymentRequest request);
  $async.Future<$0.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes(
      $grpc.ServiceCall call, $0.GetMyGeneratedBarcodesRequest request);
  $async.Future<$0.GetMyScannedBarcodesResponse> getMyScannedBarcodes(
      $grpc.ServiceCall call, $0.GetMyScannedBarcodesRequest request);
  $async.Future<$0.CancelBarcodeResponse> cancelBarcode(
      $grpc.ServiceCall call, $0.CancelBarcodeRequest request);
}
