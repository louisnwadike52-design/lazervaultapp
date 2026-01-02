///
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'barcode_payment.pb.dart' as $6;
export 'barcode_payment.pb.dart';

class BarcodePaymentServiceClient extends $grpc.Client {
  static final _$generateBarcode =
      $grpc.ClientMethod<$6.GenerateBarcodeRequest, $6.GenerateBarcodeResponse>(
          '/barcode_payment.BarcodePaymentService/GenerateBarcode',
          ($6.GenerateBarcodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $6.GenerateBarcodeResponse.fromBuffer(value));
  static final _$getBarcodeDetails = $grpc.ClientMethod<
          $6.GetBarcodeDetailsRequest, $6.GetBarcodeDetailsResponse>(
      '/barcode_payment.BarcodePaymentService/GetBarcodeDetails',
      ($6.GetBarcodeDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $6.GetBarcodeDetailsResponse.fromBuffer(value));
  static final _$processBarcodePayment = $grpc.ClientMethod<
          $6.ProcessBarcodePaymentRequest, $6.ProcessBarcodePaymentResponse>(
      '/barcode_payment.BarcodePaymentService/ProcessBarcodePayment',
      ($6.ProcessBarcodePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $6.ProcessBarcodePaymentResponse.fromBuffer(value));
  static final _$getMyGeneratedBarcodes = $grpc.ClientMethod<
          $6.GetMyGeneratedBarcodesRequest, $6.GetMyGeneratedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyGeneratedBarcodes',
      ($6.GetMyGeneratedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $6.GetMyGeneratedBarcodesResponse.fromBuffer(value));
  static final _$getMyScannedBarcodes = $grpc.ClientMethod<
          $6.GetMyScannedBarcodesRequest, $6.GetMyScannedBarcodesResponse>(
      '/barcode_payment.BarcodePaymentService/GetMyScannedBarcodes',
      ($6.GetMyScannedBarcodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $6.GetMyScannedBarcodesResponse.fromBuffer(value));
  static final _$cancelBarcode =
      $grpc.ClientMethod<$6.CancelBarcodeRequest, $6.CancelBarcodeResponse>(
          '/barcode_payment.BarcodePaymentService/CancelBarcode',
          ($6.CancelBarcodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $6.CancelBarcodeResponse.fromBuffer(value));

  BarcodePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$6.GenerateBarcodeResponse> generateBarcode(
      $6.GenerateBarcodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateBarcode, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetBarcodeDetailsResponse> getBarcodeDetails(
      $6.GetBarcodeDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBarcodeDetails, request, options: options);
  }

  $grpc.ResponseFuture<$6.ProcessBarcodePaymentResponse> processBarcodePayment(
      $6.ProcessBarcodePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processBarcodePayment, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetMyGeneratedBarcodesResponse>
      getMyGeneratedBarcodes($6.GetMyGeneratedBarcodesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyGeneratedBarcodes, request,
        options: options);
  }

  $grpc.ResponseFuture<$6.GetMyScannedBarcodesResponse> getMyScannedBarcodes(
      $6.GetMyScannedBarcodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyScannedBarcodes, request, options: options);
  }

  $grpc.ResponseFuture<$6.CancelBarcodeResponse> cancelBarcode(
      $6.CancelBarcodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelBarcode, request, options: options);
  }
}

abstract class BarcodePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'barcode_payment.BarcodePaymentService';

  BarcodePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.GenerateBarcodeRequest,
            $6.GenerateBarcodeResponse>(
        'GenerateBarcode',
        generateBarcode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.GenerateBarcodeRequest.fromBuffer(value),
        ($6.GenerateBarcodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetBarcodeDetailsRequest,
            $6.GetBarcodeDetailsResponse>(
        'GetBarcodeDetails',
        getBarcodeDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.GetBarcodeDetailsRequest.fromBuffer(value),
        ($6.GetBarcodeDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.ProcessBarcodePaymentRequest,
            $6.ProcessBarcodePaymentResponse>(
        'ProcessBarcodePayment',
        processBarcodePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.ProcessBarcodePaymentRequest.fromBuffer(value),
        ($6.ProcessBarcodePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetMyGeneratedBarcodesRequest,
            $6.GetMyGeneratedBarcodesResponse>(
        'GetMyGeneratedBarcodes',
        getMyGeneratedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.GetMyGeneratedBarcodesRequest.fromBuffer(value),
        ($6.GetMyGeneratedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetMyScannedBarcodesRequest,
            $6.GetMyScannedBarcodesResponse>(
        'GetMyScannedBarcodes',
        getMyScannedBarcodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.GetMyScannedBarcodesRequest.fromBuffer(value),
        ($6.GetMyScannedBarcodesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$6.CancelBarcodeRequest, $6.CancelBarcodeResponse>(
            'CancelBarcode',
            cancelBarcode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $6.CancelBarcodeRequest.fromBuffer(value),
            ($6.CancelBarcodeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.GenerateBarcodeResponse> generateBarcode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.GenerateBarcodeRequest> request) async {
    return generateBarcode(call, await request);
  }

  $async.Future<$6.GetBarcodeDetailsResponse> getBarcodeDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.GetBarcodeDetailsRequest> request) async {
    return getBarcodeDetails(call, await request);
  }

  $async.Future<$6.ProcessBarcodePaymentResponse> processBarcodePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.ProcessBarcodePaymentRequest> request) async {
    return processBarcodePayment(call, await request);
  }

  $async.Future<$6.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.GetMyGeneratedBarcodesRequest> request) async {
    return getMyGeneratedBarcodes(call, await request);
  }

  $async.Future<$6.GetMyScannedBarcodesResponse> getMyScannedBarcodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.GetMyScannedBarcodesRequest> request) async {
    return getMyScannedBarcodes(call, await request);
  }

  $async.Future<$6.CancelBarcodeResponse> cancelBarcode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.CancelBarcodeRequest> request) async {
    return cancelBarcode(call, await request);
  }

  $async.Future<$6.GenerateBarcodeResponse> generateBarcode(
      $grpc.ServiceCall call, $6.GenerateBarcodeRequest request);
  $async.Future<$6.GetBarcodeDetailsResponse> getBarcodeDetails(
      $grpc.ServiceCall call, $6.GetBarcodeDetailsRequest request);
  $async.Future<$6.ProcessBarcodePaymentResponse> processBarcodePayment(
      $grpc.ServiceCall call, $6.ProcessBarcodePaymentRequest request);
  $async.Future<$6.GetMyGeneratedBarcodesResponse> getMyGeneratedBarcodes(
      $grpc.ServiceCall call, $6.GetMyGeneratedBarcodesRequest request);
  $async.Future<$6.GetMyScannedBarcodesResponse> getMyScannedBarcodes(
      $grpc.ServiceCall call, $6.GetMyScannedBarcodesRequest request);
  $async.Future<$6.CancelBarcodeResponse> cancelBarcode(
      $grpc.ServiceCall call, $6.CancelBarcodeRequest request);
}
