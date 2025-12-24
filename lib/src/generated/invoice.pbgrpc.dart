///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice.pb.dart' as $16;
export 'invoice.pb.dart';

class InvoiceServiceClient extends $grpc.Client {
  static final _$getInvoices =
      $grpc.ClientMethod<$16.GetInvoicesRequest, $16.GetInvoicesResponse>(
          '/pb.InvoiceService/GetInvoices',
          ($16.GetInvoicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.GetInvoicesResponse.fromBuffer(value));
  static final _$getInvoiceById =
      $grpc.ClientMethod<$16.GetInvoiceByIdRequest, $16.GetInvoiceByIdResponse>(
          '/pb.InvoiceService/GetInvoiceById',
          ($16.GetInvoiceByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.GetInvoiceByIdResponse.fromBuffer(value));
  static final _$createInvoice =
      $grpc.ClientMethod<$16.CreateInvoiceRequest, $16.CreateInvoiceResponse>(
          '/pb.InvoiceService/CreateInvoice',
          ($16.CreateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.CreateInvoiceResponse.fromBuffer(value));
  static final _$updateInvoice =
      $grpc.ClientMethod<$16.UpdateInvoiceRequest, $16.UpdateInvoiceResponse>(
          '/pb.InvoiceService/UpdateInvoice',
          ($16.UpdateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.UpdateInvoiceResponse.fromBuffer(value));
  static final _$deleteInvoice =
      $grpc.ClientMethod<$16.DeleteInvoiceRequest, $16.DeleteInvoiceResponse>(
          '/pb.InvoiceService/DeleteInvoice',
          ($16.DeleteInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.DeleteInvoiceResponse.fromBuffer(value));
  static final _$getInvoicesByStatus = $grpc.ClientMethod<
          $16.GetInvoicesByStatusRequest, $16.GetInvoicesByStatusResponse>(
      '/pb.InvoiceService/GetInvoicesByStatus',
      ($16.GetInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetInvoicesByStatusResponse.fromBuffer(value));
  static final _$markInvoiceAsPaid = $grpc.ClientMethod<
          $16.MarkInvoiceAsPaidRequest, $16.MarkInvoiceAsPaidResponse>(
      '/pb.InvoiceService/MarkInvoiceAsPaid',
      ($16.MarkInvoiceAsPaidRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.MarkInvoiceAsPaidResponse.fromBuffer(value));
  static final _$sendInvoice =
      $grpc.ClientMethod<$16.SendInvoiceRequest, $16.SendInvoiceResponse>(
          '/pb.InvoiceService/SendInvoice',
          ($16.SendInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.SendInvoiceResponse.fromBuffer(value));
  static final _$tagUsersToInvoice = $grpc.ClientMethod<
          $16.TagUsersToInvoiceRequest, $16.TagUsersToInvoiceResponse>(
      '/pb.InvoiceService/TagUsersToInvoice',
      ($16.TagUsersToInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.TagUsersToInvoiceResponse.fromBuffer(value));
  static final _$searchInvoiceUsers = $grpc.ClientMethod<
          $16.SearchInvoiceUsersRequest, $16.SearchInvoiceUsersResponse>(
      '/pb.InvoiceService/SearchInvoiceUsers',
      ($16.SearchInvoiceUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.SearchInvoiceUsersResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$16.GetInvoicesResponse> getInvoices(
      $16.GetInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetInvoiceByIdResponse> getInvoiceById(
      $16.GetInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$16.CreateInvoiceResponse> createInvoice(
      $16.CreateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$16.UpdateInvoiceResponse> updateInvoice(
      $16.UpdateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$16.DeleteInvoiceResponse> deleteInvoice(
      $16.DeleteInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $16.GetInvoicesByStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicesByStatus, request, options: options);
  }

  $grpc.ResponseFuture<$16.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $16.MarkInvoiceAsPaidRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInvoiceAsPaid, request, options: options);
  }

  $grpc.ResponseFuture<$16.SendInvoiceResponse> sendInvoice(
      $16.SendInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$16.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $16.TagUsersToInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$tagUsersToInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$16.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $16.SearchInvoiceUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInvoiceUsers, request, options: options);
  }
}

abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoiceService';

  InvoiceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$16.GetInvoicesRequest, $16.GetInvoicesResponse>(
            'GetInvoices',
            getInvoices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.GetInvoicesRequest.fromBuffer(value),
            ($16.GetInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetInvoiceByIdRequest,
            $16.GetInvoiceByIdResponse>(
        'GetInvoiceById',
        getInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetInvoiceByIdRequest.fromBuffer(value),
        ($16.GetInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.CreateInvoiceRequest,
            $16.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.CreateInvoiceRequest.fromBuffer(value),
        ($16.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.UpdateInvoiceRequest,
            $16.UpdateInvoiceResponse>(
        'UpdateInvoice',
        updateInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.UpdateInvoiceRequest.fromBuffer(value),
        ($16.UpdateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.DeleteInvoiceRequest,
            $16.DeleteInvoiceResponse>(
        'DeleteInvoice',
        deleteInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.DeleteInvoiceRequest.fromBuffer(value),
        ($16.DeleteInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetInvoicesByStatusRequest,
            $16.GetInvoicesByStatusResponse>(
        'GetInvoicesByStatus',
        getInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetInvoicesByStatusRequest.fromBuffer(value),
        ($16.GetInvoicesByStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.MarkInvoiceAsPaidRequest,
            $16.MarkInvoiceAsPaidResponse>(
        'MarkInvoiceAsPaid',
        markInvoiceAsPaid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.MarkInvoiceAsPaidRequest.fromBuffer(value),
        ($16.MarkInvoiceAsPaidResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.SendInvoiceRequest, $16.SendInvoiceResponse>(
            'SendInvoice',
            sendInvoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.SendInvoiceRequest.fromBuffer(value),
            ($16.SendInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.TagUsersToInvoiceRequest,
            $16.TagUsersToInvoiceResponse>(
        'TagUsersToInvoice',
        tagUsersToInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.TagUsersToInvoiceRequest.fromBuffer(value),
        ($16.TagUsersToInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.SearchInvoiceUsersRequest,
            $16.SearchInvoiceUsersResponse>(
        'SearchInvoiceUsers',
        searchInvoiceUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.SearchInvoiceUsersRequest.fromBuffer(value),
        ($16.SearchInvoiceUsersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$16.GetInvoicesResponse> getInvoices_Pre($grpc.ServiceCall call,
      $async.Future<$16.GetInvoicesRequest> request) async {
    return getInvoices(call, await request);
  }

  $async.Future<$16.GetInvoiceByIdResponse> getInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetInvoiceByIdRequest> request) async {
    return getInvoiceById(call, await request);
  }

  $async.Future<$16.CreateInvoiceResponse> createInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$16.UpdateInvoiceResponse> updateInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.UpdateInvoiceRequest> request) async {
    return updateInvoice(call, await request);
  }

  $async.Future<$16.DeleteInvoiceResponse> deleteInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.DeleteInvoiceRequest> request) async {
    return deleteInvoice(call, await request);
  }

  $async.Future<$16.GetInvoicesByStatusResponse> getInvoicesByStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetInvoicesByStatusRequest> request) async {
    return getInvoicesByStatus(call, await request);
  }

  $async.Future<$16.MarkInvoiceAsPaidResponse> markInvoiceAsPaid_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.MarkInvoiceAsPaidRequest> request) async {
    return markInvoiceAsPaid(call, await request);
  }

  $async.Future<$16.SendInvoiceResponse> sendInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$16.SendInvoiceRequest> request) async {
    return sendInvoice(call, await request);
  }

  $async.Future<$16.TagUsersToInvoiceResponse> tagUsersToInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.TagUsersToInvoiceRequest> request) async {
    return tagUsersToInvoice(call, await request);
  }

  $async.Future<$16.SearchInvoiceUsersResponse> searchInvoiceUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.SearchInvoiceUsersRequest> request) async {
    return searchInvoiceUsers(call, await request);
  }

  $async.Future<$16.GetInvoicesResponse> getInvoices(
      $grpc.ServiceCall call, $16.GetInvoicesRequest request);
  $async.Future<$16.GetInvoiceByIdResponse> getInvoiceById(
      $grpc.ServiceCall call, $16.GetInvoiceByIdRequest request);
  $async.Future<$16.CreateInvoiceResponse> createInvoice(
      $grpc.ServiceCall call, $16.CreateInvoiceRequest request);
  $async.Future<$16.UpdateInvoiceResponse> updateInvoice(
      $grpc.ServiceCall call, $16.UpdateInvoiceRequest request);
  $async.Future<$16.DeleteInvoiceResponse> deleteInvoice(
      $grpc.ServiceCall call, $16.DeleteInvoiceRequest request);
  $async.Future<$16.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $grpc.ServiceCall call, $16.GetInvoicesByStatusRequest request);
  $async.Future<$16.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $grpc.ServiceCall call, $16.MarkInvoiceAsPaidRequest request);
  $async.Future<$16.SendInvoiceResponse> sendInvoice(
      $grpc.ServiceCall call, $16.SendInvoiceRequest request);
  $async.Future<$16.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $grpc.ServiceCall call, $16.TagUsersToInvoiceRequest request);
  $async.Future<$16.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $grpc.ServiceCall call, $16.SearchInvoiceUsersRequest request);
}
