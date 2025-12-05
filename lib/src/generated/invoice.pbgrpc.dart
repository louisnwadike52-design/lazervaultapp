///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice.pb.dart' as $10;
export 'invoice.pb.dart';

class InvoiceServiceClient extends $grpc.Client {
  static final _$createInvoice =
      $grpc.ClientMethod<$10.CreateInvoiceRequest, $10.CreateInvoiceResponse>(
          '/pb.InvoiceService/CreateInvoice',
          ($10.CreateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.CreateInvoiceResponse.fromBuffer(value));
  static final _$getInvoice =
      $grpc.ClientMethod<$10.GetInvoiceRequest, $10.Invoice>(
          '/pb.InvoiceService/GetInvoice',
          ($10.GetInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $10.Invoice.fromBuffer(value));
  static final _$listInvoices =
      $grpc.ClientMethod<$10.ListInvoicesRequest, $10.ListInvoicesResponse>(
          '/pb.InvoiceService/ListInvoices',
          ($10.ListInvoicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.ListInvoicesResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.CreateInvoiceResponse> createInvoice(
      $10.CreateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$10.Invoice> getInvoice($10.GetInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$10.ListInvoicesResponse> listInvoices(
      $10.ListInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInvoices, request, options: options);
  }
}

abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoiceService';

  InvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.CreateInvoiceRequest,
            $10.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CreateInvoiceRequest.fromBuffer(value),
        ($10.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetInvoiceRequest, $10.Invoice>(
        'GetInvoice',
        getInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetInvoiceRequest.fromBuffer(value),
        ($10.Invoice value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.ListInvoicesRequest, $10.ListInvoicesResponse>(
            'ListInvoices',
            listInvoices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.ListInvoicesRequest.fromBuffer(value),
            ($10.ListInvoicesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.CreateInvoiceResponse> createInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$10.Invoice> getInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetInvoiceRequest> request) async {
    return getInvoice(call, await request);
  }

  $async.Future<$10.ListInvoicesResponse> listInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListInvoicesRequest> request) async {
    return listInvoices(call, await request);
  }

  $async.Future<$10.CreateInvoiceResponse> createInvoice(
      $grpc.ServiceCall call, $10.CreateInvoiceRequest request);
  $async.Future<$10.Invoice> getInvoice(
      $grpc.ServiceCall call, $10.GetInvoiceRequest request);
  $async.Future<$10.ListInvoicesResponse> listInvoices(
      $grpc.ServiceCall call, $10.ListInvoicesRequest request);
}
