///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice.pb.dart' as $0;
export 'invoice.pb.dart';

class InvoiceServiceClient extends $grpc.Client {
  static final _$createInvoice =
      $grpc.ClientMethod<$0.CreateInvoiceRequest, $0.CreateInvoiceResponse>(
          '/invoice.InvoiceService/CreateInvoice',
          ($0.CreateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateInvoiceResponse.fromBuffer(value));
  static final _$getInvoices =
      $grpc.ClientMethod<$0.GetInvoicesRequest, $0.GetInvoicesResponse>(
          '/invoice.InvoiceService/GetInvoices',
          ($0.GetInvoicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetInvoicesResponse.fromBuffer(value));
  static final _$getInvoice =
      $grpc.ClientMethod<$0.GetInvoiceRequest, $0.GetInvoiceResponse>(
          '/invoice.InvoiceService/GetInvoice',
          ($0.GetInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetInvoiceResponse.fromBuffer(value));
  static final _$payInvoice =
      $grpc.ClientMethod<$0.PayInvoiceRequest, $0.PayInvoiceResponse>(
          '/invoice.InvoiceService/PayInvoice',
          ($0.PayInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayInvoiceResponse.fromBuffer(value));
  static final _$cancelInvoice =
      $grpc.ClientMethod<$0.CancelInvoiceRequest, $0.CancelInvoiceResponse>(
          '/invoice.InvoiceService/CancelInvoice',
          ($0.CancelInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelInvoiceResponse.fromBuffer(value));
  static final _$sendInvoiceReminder = $grpc.ClientMethod<
          $0.SendInvoiceReminderRequest, $0.SendInvoiceReminderResponse>(
      '/invoice.InvoiceService/SendInvoiceReminder',
      ($0.SendInvoiceReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SendInvoiceReminderResponse.fromBuffer(value));
  static final _$updateInvoiceStatus = $grpc.ClientMethod<
          $0.UpdateInvoiceStatusRequest, $0.UpdateInvoiceStatusResponse>(
      '/invoice.InvoiceService/UpdateInvoiceStatus',
      ($0.UpdateInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInvoiceStatusResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateInvoiceResponse> createInvoice(
      $0.CreateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicesResponse> getInvoices(
      $0.GetInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoiceResponse> getInvoice(
      $0.GetInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayInvoiceResponse> payInvoice(
      $0.PayInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelInvoiceResponse> cancelInvoice(
      $0.CancelInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendInvoiceReminderResponse> sendInvoiceReminder(
      $0.SendInvoiceReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoiceReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInvoiceStatusResponse> updateInvoiceStatus(
      $0.UpdateInvoiceStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoiceStatus, request, options: options);
  }
}

abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'invoice.InvoiceService';

  InvoiceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.CreateInvoiceRequest, $0.CreateInvoiceResponse>(
            'CreateInvoice',
            createInvoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateInvoiceRequest.fromBuffer(value),
            ($0.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetInvoicesRequest, $0.GetInvoicesResponse>(
            'GetInvoices',
            getInvoices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetInvoicesRequest.fromBuffer(value),
            ($0.GetInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoiceRequest, $0.GetInvoiceResponse>(
        'GetInvoice',
        getInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoiceRequest.fromBuffer(value),
        ($0.GetInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayInvoiceRequest, $0.PayInvoiceResponse>(
        'PayInvoice',
        payInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayInvoiceRequest.fromBuffer(value),
        ($0.PayInvoiceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CancelInvoiceRequest, $0.CancelInvoiceResponse>(
            'CancelInvoice',
            cancelInvoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CancelInvoiceRequest.fromBuffer(value),
            ($0.CancelInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendInvoiceReminderRequest,
            $0.SendInvoiceReminderResponse>(
        'SendInvoiceReminder',
        sendInvoiceReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendInvoiceReminderRequest.fromBuffer(value),
        ($0.SendInvoiceReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInvoiceStatusRequest,
            $0.UpdateInvoiceStatusResponse>(
        'UpdateInvoiceStatus',
        updateInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInvoiceStatusRequest.fromBuffer(value),
        ($0.UpdateInvoiceStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateInvoiceResponse> createInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$0.GetInvoicesResponse> getInvoices_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetInvoicesRequest> request) async {
    return getInvoices(call, await request);
  }

  $async.Future<$0.GetInvoiceResponse> getInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetInvoiceRequest> request) async {
    return getInvoice(call, await request);
  }

  $async.Future<$0.PayInvoiceResponse> payInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$0.PayInvoiceRequest> request) async {
    return payInvoice(call, await request);
  }

  $async.Future<$0.CancelInvoiceResponse> cancelInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelInvoiceRequest> request) async {
    return cancelInvoice(call, await request);
  }

  $async.Future<$0.SendInvoiceReminderResponse> sendInvoiceReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SendInvoiceReminderRequest> request) async {
    return sendInvoiceReminder(call, await request);
  }

  $async.Future<$0.UpdateInvoiceStatusResponse> updateInvoiceStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateInvoiceStatusRequest> request) async {
    return updateInvoiceStatus(call, await request);
  }

  $async.Future<$0.CreateInvoiceResponse> createInvoice(
      $grpc.ServiceCall call, $0.CreateInvoiceRequest request);
  $async.Future<$0.GetInvoicesResponse> getInvoices(
      $grpc.ServiceCall call, $0.GetInvoicesRequest request);
  $async.Future<$0.GetInvoiceResponse> getInvoice(
      $grpc.ServiceCall call, $0.GetInvoiceRequest request);
  $async.Future<$0.PayInvoiceResponse> payInvoice(
      $grpc.ServiceCall call, $0.PayInvoiceRequest request);
  $async.Future<$0.CancelInvoiceResponse> cancelInvoice(
      $grpc.ServiceCall call, $0.CancelInvoiceRequest request);
  $async.Future<$0.SendInvoiceReminderResponse> sendInvoiceReminder(
      $grpc.ServiceCall call, $0.SendInvoiceReminderRequest request);
  $async.Future<$0.UpdateInvoiceStatusResponse> updateInvoiceStatus(
      $grpc.ServiceCall call, $0.UpdateInvoiceStatusRequest request);
}
