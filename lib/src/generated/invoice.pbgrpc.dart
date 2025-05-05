//
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'invoice.pb.dart' as $9;

export 'invoice.pb.dart';

@$pb.GrpcServiceName('pb.InvoiceService')
class InvoiceServiceClient extends $grpc.Client {
  static final _$createInvoice = $grpc.ClientMethod<$9.CreateInvoiceRequest, $9.CreateInvoiceResponse>(
      '/pb.InvoiceService/CreateInvoice',
      ($9.CreateInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $9.CreateInvoiceResponse.fromBuffer(value));
  static final _$getInvoice = $grpc.ClientMethod<$9.GetInvoiceRequest, $9.Invoice>(
      '/pb.InvoiceService/GetInvoice',
      ($9.GetInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $9.Invoice.fromBuffer(value));
  static final _$listInvoices = $grpc.ClientMethod<$9.ListInvoicesRequest, $9.ListInvoicesResponse>(
      '/pb.InvoiceService/ListInvoices',
      ($9.ListInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $9.ListInvoicesResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$9.CreateInvoiceResponse> createInvoice($9.CreateInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$9.Invoice> getInvoice($9.GetInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$9.ListInvoicesResponse> listInvoices($9.ListInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInvoices, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.InvoiceService')
abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoiceService';

  InvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$9.CreateInvoiceRequest, $9.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $9.CreateInvoiceRequest.fromBuffer(value),
        ($9.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetInvoiceRequest, $9.Invoice>(
        'GetInvoice',
        getInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $9.GetInvoiceRequest.fromBuffer(value),
        ($9.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.ListInvoicesRequest, $9.ListInvoicesResponse>(
        'ListInvoices',
        listInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $9.ListInvoicesRequest.fromBuffer(value),
        ($9.ListInvoicesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$9.CreateInvoiceResponse> createInvoice_Pre($grpc.ServiceCall $call, $async.Future<$9.CreateInvoiceRequest> $request) async {
    return createInvoice($call, await $request);
  }

  $async.Future<$9.Invoice> getInvoice_Pre($grpc.ServiceCall $call, $async.Future<$9.GetInvoiceRequest> $request) async {
    return getInvoice($call, await $request);
  }

  $async.Future<$9.ListInvoicesResponse> listInvoices_Pre($grpc.ServiceCall $call, $async.Future<$9.ListInvoicesRequest> $request) async {
    return listInvoices($call, await $request);
  }

  $async.Future<$9.CreateInvoiceResponse> createInvoice($grpc.ServiceCall call, $9.CreateInvoiceRequest request);
  $async.Future<$9.Invoice> getInvoice($grpc.ServiceCall call, $9.GetInvoiceRequest request);
  $async.Future<$9.ListInvoicesResponse> listInvoices($grpc.ServiceCall call, $9.ListInvoicesRequest request);
}
