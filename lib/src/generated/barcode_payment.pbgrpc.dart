///
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'barcode_payment.pb.dart' as $7;
export 'barcode_payment.pb.dart';

class BarcodePaymentServiceClient extends $grpc.Client {
  static final _$generateBarcode =
      $grpc.ClientMethod<$7.GenerateBarcodeRequest, $7.GenerateBarcodeResponse>(
          '/barcode_payment.BarcodePaymentService/GenerateBarcode',
          ($7.GenerateBarcodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GenerateBarcodeResponse.fromBuffer(value));
  static final _$getBarcodeDetails = $grpc.ClientMethod<
          $7.GetBarcodeDetailsRequest, $7.GetBarcodeDetailsResponse>(
      '/barcode_payment.BarcodePaymentService/GetBarcodeDetails',
      ($7.GetBarcodeDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.GetBarcodeDetailsResponse.fromBuffer(value));
  static final _$processBarcodePayment = $grpc.ClientMethod<
          $7.ProcessBarcodePaymentRequest, $7.ProcessBarcodePaymentResponse>(
      '/barcode_payment.BarcodePaymentService/ProcessBarcodePayment',
      ($7.ProcessBarcodePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.ProcessBarcodePaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedBarcodes = $grpc.ClientMethod<
          $7.GetMyGeneratedBarcodesRequest, $7.GetMyGeneratedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyGeneratedBarcodes',
      ($7.GetMyGeneratedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.GetMyGeneratedBarcodesResponse.fromBuffer(value));
  static final _$getMyScannedBarcodes = $grpc.ClientMethod<
          $7.GetMyScannedBarcodesRequest, $7.GetMyScannedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyScannedBarcodes',
      ($7.GetMyScannedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.GetMyScannedBarcodesResponse.fromBuffer(value));
  static final _$cancelBarcode =
      $grpc.ClientMethod<$7.CancelBarcodeRequest, $7.CancelBarcodeResponse>(
          '/barcode_payment.BarcodePaymentService/CancelBarcode',
          ($7.CancelBarcodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.CancelBarcodeResponse.fromBuffer(value));

  BarcodePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$7.GenerateBarcodeResponse> generateBarcode(
      $7.GenerateBarcodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateBarcode, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetBarcodeDetailsResponse> getBarcodeDetails(
      $7.GetBarcodeDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBarcodeDetails, request, options: options);
  }

  $grpc.ResponseFuture<$7.ProcessBarcodePaymentResponse> processBarcodePayment(
      $7.ProcessBarcodePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processBarcodePayment, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetMyGeneratedBarcodesResponse>
      getMyGeneratedBarcodes($7.GetMyGeneratedBarcodesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedBarcodes, request,
        options: options);
  }

  $grpc.ResponseFuture<$7.GetMyScannedBarcodesResponse> getMyScannedBarcodes(
      $7.GetMyScannedBarcodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyScannedBarcodes, request, options: options);
  }

  $grpc.ResponseFuture<$7.CancelBarcodeResponse> cancelBarcode(
      $7.CancelBarcodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelBarcode, request, options: options);
  }
}

abstract class BarcodePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'barcode_payment.BarcodePaymentService';

  BarcodePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.GenerateBarcodeRequest,
            $7.GenerateBarcodeResponse>(
        'GenerateBarcode',
        generateBarcode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GenerateBarcodeRequest.fromBuffer(value),
        ($7.GenerateBarcodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetBarcodeDetailsRequest,
            $7.GetBarcodeDetailsResponse>(
        'GetBarcodeDetails',
        getBarcodeDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetBarcodeDetailsRequest.fromBuffer(value),
        ($7.GetBarcodeDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.ProcessBarcodePaymentRequest,
            $7.ProcessBarcodePaymentResponse>(
        'ProcessBarcodePayment',
        processBarcodePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.ProcessBarcodePaymentRequest.fromBuffer(value),
        ($7.ProcessBarcodePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetMyGeneratedBarcodesRequest,
            $7.GetMyGeneratedBarcodesResponse>(
        'GetMyGeneratedBarcodes',
        getMyGeneratedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetMyGeneratedBarcodesRequest.fromBuffer(value),
        ($7.GetMyGeneratedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetMyScannedBarcodesRequest,
            $7.GetMyScannedBarcodesResponse>(
        'GetMyScannedBarcodes',
        getMyScannedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetMyScannedBarcodesRequest.fromBuffer(value),
        ($7.GetMyScannedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.CancelBarcodeRequest, $7.CancelBarcodeResponse>(
            'CancelBarcode',
            cancelBarcode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.CancelBarcodeRequest.fromBuffer(value),
            ($7.CancelBarcodeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.GenerateBarcodeResponse> generateBarcode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GenerateBarcodeRequest> request) async {
    return generateBarcode(call, await request);
  }

  $async.Future<$7.GetBarcodeDetailsResponse> getBarcodeDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetBarcodeDetailsRequest> request) async {
    return getBarcodeDetails(call, await request);
  }

  $async.Future<$7.ProcessBarcodePaymentResponse> processBarcodePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.ProcessBarcodePaymentRequest> request) async {
    return processBarcodePayment(call, await request);
  }

  $async.Future<$7.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetMyGeneratedBarcodesRequest> request) async {
    return getMyGeneratedBarcodes(call, await request);
  }

  $async.Future<$7.GetMyScannedBarcodesResponse> getMyScannedBarcodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetMyScannedBarcodesRequest> request) async {
    return getMyScannedBarcodes(call, await request);
  }

  $async.Future<$7.CancelBarcodeResponse> cancelBarcode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.CancelBarcodeRequest> request) async {
    return cancelBarcode(call, await request);
  }

  $async.Future<$7.GenerateBarcodeResponse> generateBarcode(
      $grpc.ServiceCall call, $7.GenerateBarcodeRequest request);
  $async.Future<$7.GetBarcodeDetailsResponse> getBarcodeDetails(
      $grpc.ServiceCall call, $7.GetBarcodeDetailsRequest request);
  $async.Future<$7.ProcessBarcodePaymentResponse> processBarcodePayment(
      $grpc.ServiceCall call, $7.ProcessBarcodePaymentRequest request);
  $async.Future<$7.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes(
      $grpc.ServiceCall call, $7.GetMyGeneratedBarcodesRequest request);
  $async.Future<$7.GetMyScannedBarcodesResponse> getMyScannedBarcodes(
      $grpc.ServiceCall call, $7.GetMyScannedBarcodesRequest request);
  $async.Future<$7.CancelBarcodeResponse> cancelBarcode(
      $grpc.ServiceCall call, $7.CancelBarcodeRequest request);
}
