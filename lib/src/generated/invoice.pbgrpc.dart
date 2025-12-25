///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice.pb.dart' as $17;
export 'invoice.pb.dart';

class InvoiceServiceClient extends $grpc.Client {
  static final _$getInvoices =
      $grpc.ClientMethod<$17.GetInvoicesRequest, $17.GetInvoicesResponse>(
          '/pb.InvoiceService/GetInvoices',
          ($17.GetInvoicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetInvoicesResponse.fromBuffer(value));
  static final _$getInvoiceById =
      $grpc.ClientMethod<$17.GetInvoiceByIdRequest, $17.GetInvoiceByIdResponse>(
          '/pb.InvoiceService/GetInvoiceById',
          ($17.GetInvoiceByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetInvoiceByIdResponse.fromBuffer(value));
  static final _$createInvoice =
      $grpc.ClientMethod<$17.CreateInvoiceRequest, $17.CreateInvoiceResponse>(
          '/pb.InvoiceService/CreateInvoice',
          ($17.CreateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.CreateInvoiceResponse.fromBuffer(value));
  static final _$updateInvoice =
      $grpc.ClientMethod<$17.UpdateInvoiceRequest, $17.UpdateInvoiceResponse>(
          '/pb.InvoiceService/UpdateInvoice',
          ($17.UpdateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.UpdateInvoiceResponse.fromBuffer(value));
  static final _$deleteInvoice =
      $grpc.ClientMethod<$17.DeleteInvoiceRequest, $17.DeleteInvoiceResponse>(
          '/pb.InvoiceService/DeleteInvoice',
          ($17.DeleteInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.DeleteInvoiceResponse.fromBuffer(value));
  static final _$getInvoicesByStatus = $grpc.ClientMethod<
          $17.GetInvoicesByStatusRequest, $17.GetInvoicesByStatusResponse>(
      '/pb.InvoiceService/GetInvoicesByStatus',
      ($17.GetInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetInvoicesByStatusResponse.fromBuffer(value));
  static final _$markInvoiceAsPaid = $grpc.ClientMethod<
          $17.MarkInvoiceAsPaidRequest, $17.MarkInvoiceAsPaidResponse>(
      '/pb.InvoiceService/MarkInvoiceAsPaid',
      ($17.MarkInvoiceAsPaidRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.MarkInvoiceAsPaidResponse.fromBuffer(value));
  static final _$sendInvoice =
      $grpc.ClientMethod<$17.SendInvoiceRequest, $17.SendInvoiceResponse>(
          '/pb.InvoiceService/SendInvoice',
          ($17.SendInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.SendInvoiceResponse.fromBuffer(value));
  static final _$tagUsersToInvoice = $grpc.ClientMethod<
          $17.TagUsersToInvoiceRequest, $17.TagUsersToInvoiceResponse>(
      '/pb.InvoiceService/TagUsersToInvoice',
      ($17.TagUsersToInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.TagUsersToInvoiceResponse.fromBuffer(value));
  static final _$searchInvoiceUsers = $grpc.ClientMethod<
          $17.SearchInvoiceUsersRequest, $17.SearchInvoiceUsersResponse>(
      '/pb.InvoiceService/SearchInvoiceUsers',
      ($17.SearchInvoiceUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.SearchInvoiceUsersResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$17.GetInvoicesResponse> getInvoices(
      $17.GetInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetInvoiceByIdResponse> getInvoiceById(
      $17.GetInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateInvoiceResponse> createInvoice(
      $17.CreateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateInvoiceResponse> updateInvoice(
      $17.UpdateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$17.DeleteInvoiceResponse> deleteInvoice(
      $17.DeleteInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $17.GetInvoicesByStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicesByStatus, request, options: options);
  }

  $grpc.ResponseFuture<$17.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $17.MarkInvoiceAsPaidRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInvoiceAsPaid, request, options: options);
  }

  $grpc.ResponseFuture<$17.SendInvoiceResponse> sendInvoice(
      $17.SendInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$17.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $17.TagUsersToInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$tagUsersToInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$17.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $17.SearchInvoiceUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInvoiceUsers, request, options: options);
  }
}

abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoiceService';

  InvoiceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$17.GetInvoicesRequest, $17.GetInvoicesResponse>(
            'GetInvoices',
            getInvoices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.GetInvoicesRequest.fromBuffer(value),
            ($17.GetInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetInvoiceByIdRequest,
            $17.GetInvoiceByIdResponse>(
        'GetInvoiceById',
        getInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetInvoiceByIdRequest.fromBuffer(value),
        ($17.GetInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateInvoiceRequest,
            $17.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateInvoiceRequest.fromBuffer(value),
        ($17.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdateInvoiceRequest,
            $17.UpdateInvoiceResponse>(
        'UpdateInvoice',
        updateInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdateInvoiceRequest.fromBuffer(value),
        ($17.UpdateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.DeleteInvoiceRequest,
            $17.DeleteInvoiceResponse>(
        'DeleteInvoice',
        deleteInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.DeleteInvoiceRequest.fromBuffer(value),
        ($17.DeleteInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetInvoicesByStatusRequest,
            $17.GetInvoicesByStatusResponse>(
        'GetInvoicesByStatus',
        getInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetInvoicesByStatusRequest.fromBuffer(value),
        ($17.GetInvoicesByStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.MarkInvoiceAsPaidRequest,
            $17.MarkInvoiceAsPaidResponse>(
        'MarkInvoiceAsPaid',
        markInvoiceAsPaid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.MarkInvoiceAsPaidRequest.fromBuffer(value),
        ($17.MarkInvoiceAsPaidResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.SendInvoiceRequest, $17.SendInvoiceResponse>(
            'SendInvoice',
            sendInvoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.SendInvoiceRequest.fromBuffer(value),
            ($17.SendInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.TagUsersToInvoiceRequest,
            $17.TagUsersToInvoiceResponse>(
        'TagUsersToInvoice',
        tagUsersToInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.TagUsersToInvoiceRequest.fromBuffer(value),
        ($17.TagUsersToInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.SearchInvoiceUsersRequest,
            $17.SearchInvoiceUsersResponse>(
        'SearchInvoiceUsers',
        searchInvoiceUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.SearchInvoiceUsersRequest.fromBuffer(value),
        ($17.SearchInvoiceUsersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$17.GetInvoicesResponse> getInvoices_Pre($grpc.ServiceCall call,
      $async.Future<$17.GetInvoicesRequest> request) async {
    return getInvoices(call, await request);
  }

  $async.Future<$17.GetInvoiceByIdResponse> getInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetInvoiceByIdRequest> request) async {
    return getInvoiceById(call, await request);
  }

  $async.Future<$17.CreateInvoiceResponse> createInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$17.UpdateInvoiceResponse> updateInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdateInvoiceRequest> request) async {
    return updateInvoice(call, await request);
  }

  $async.Future<$17.DeleteInvoiceResponse> deleteInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.DeleteInvoiceRequest> request) async {
    return deleteInvoice(call, await request);
  }

  $async.Future<$17.GetInvoicesByStatusResponse> getInvoicesByStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetInvoicesByStatusRequest> request) async {
    return getInvoicesByStatus(call, await request);
  }

  $async.Future<$17.MarkInvoiceAsPaidResponse> markInvoiceAsPaid_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.MarkInvoiceAsPaidRequest> request) async {
    return markInvoiceAsPaid(call, await request);
  }

  $async.Future<$17.SendInvoiceResponse> sendInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$17.SendInvoiceRequest> request) async {
    return sendInvoice(call, await request);
  }

  $async.Future<$17.TagUsersToInvoiceResponse> tagUsersToInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.TagUsersToInvoiceRequest> request) async {
    return tagUsersToInvoice(call, await request);
  }

  $async.Future<$17.SearchInvoiceUsersResponse> searchInvoiceUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.SearchInvoiceUsersRequest> request) async {
    return searchInvoiceUsers(call, await request);
  }

  $async.Future<$17.GetInvoicesResponse> getInvoices(
      $grpc.ServiceCall call, $17.GetInvoicesRequest request);
  $async.Future<$17.GetInvoiceByIdResponse> getInvoiceById(
      $grpc.ServiceCall call, $17.GetInvoiceByIdRequest request);
  $async.Future<$17.CreateInvoiceResponse> createInvoice(
      $grpc.ServiceCall call, $17.CreateInvoiceRequest request);
  $async.Future<$17.UpdateInvoiceResponse> updateInvoice(
      $grpc.ServiceCall call, $17.UpdateInvoiceRequest request);
  $async.Future<$17.DeleteInvoiceResponse> deleteInvoice(
      $grpc.ServiceCall call, $17.DeleteInvoiceRequest request);
  $async.Future<$17.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $grpc.ServiceCall call, $17.GetInvoicesByStatusRequest request);
  $async.Future<$17.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $grpc.ServiceCall call, $17.MarkInvoiceAsPaidRequest request);
  $async.Future<$17.SendInvoiceResponse> sendInvoice(
      $grpc.ServiceCall call, $17.SendInvoiceRequest request);
  $async.Future<$17.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $grpc.ServiceCall call, $17.TagUsersToInvoiceRequest request);
  $async.Future<$17.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $grpc.ServiceCall call, $17.SearchInvoiceUsersRequest request);
}
