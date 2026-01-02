///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice.pb.dart' as $19;
export 'invoice.pb.dart';

class InvoiceServiceClient extends $grpc.Client {
  static final _$getInvoices =
      $grpc.ClientMethod<$19.GetInvoicesRequest, $19.GetInvoicesResponse>(
          '/pb.InvoiceService/GetInvoices',
          ($19.GetInvoicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetInvoicesResponse.fromBuffer(value));
  static final _$getInvoiceById =
      $grpc.ClientMethod<$19.GetInvoiceByIdRequest, $19.GetInvoiceByIdResponse>(
          '/pb.InvoiceService/GetInvoiceById',
          ($19.GetInvoiceByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetInvoiceByIdResponse.fromBuffer(value));
  static final _$createInvoice =
      $grpc.ClientMethod<$19.CreateInvoiceRequest, $19.CreateInvoiceResponse>(
          '/pb.InvoiceService/CreateInvoice',
          ($19.CreateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.CreateInvoiceResponse.fromBuffer(value));
  static final _$updateInvoice =
      $grpc.ClientMethod<$19.UpdateInvoiceRequest, $19.UpdateInvoiceResponse>(
          '/pb.InvoiceService/UpdateInvoice',
          ($19.UpdateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.UpdateInvoiceResponse.fromBuffer(value));
  static final _$deleteInvoice =
      $grpc.ClientMethod<$19.DeleteInvoiceRequest, $19.DeleteInvoiceResponse>(
          '/pb.InvoiceService/DeleteInvoice',
          ($19.DeleteInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.DeleteInvoiceResponse.fromBuffer(value));
  static final _$getInvoicesByStatus = $grpc.ClientMethod<
          $19.GetInvoicesByStatusRequest, $19.GetInvoicesByStatusResponse>(
      '/pb.InvoiceService/GetInvoicesByStatus',
      ($19.GetInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInvoicesByStatusResponse.fromBuffer(value));
  static final _$markInvoiceAsPaid = $grpc.ClientMethod<
          $19.MarkInvoiceAsPaidRequest, $19.MarkInvoiceAsPaidResponse>(
      '/pb.InvoiceService/MarkInvoiceAsPaid',
      ($19.MarkInvoiceAsPaidRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.MarkInvoiceAsPaidResponse.fromBuffer(value));
  static final _$sendInvoice =
      $grpc.ClientMethod<$19.SendInvoiceRequest, $19.SendInvoiceResponse>(
          '/pb.InvoiceService/SendInvoice',
          ($19.SendInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.SendInvoiceResponse.fromBuffer(value));
  static final _$tagUsersToInvoice = $grpc.ClientMethod<
          $19.TagUsersToInvoiceRequest, $19.TagUsersToInvoiceResponse>(
      '/pb.InvoiceService/TagUsersToInvoice',
      ($19.TagUsersToInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.TagUsersToInvoiceResponse.fromBuffer(value));
  static final _$searchInvoiceUsers = $grpc.ClientMethod<
          $19.SearchInvoiceUsersRequest, $19.SearchInvoiceUsersResponse>(
      '/pb.InvoiceService/SearchInvoiceUsers',
      ($19.SearchInvoiceUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.SearchInvoiceUsersResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$19.GetInvoicesResponse> getInvoices(
      $19.GetInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInvoiceByIdResponse> getInvoiceById(
      $19.GetInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$19.CreateInvoiceResponse> createInvoice(
      $19.CreateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateInvoiceResponse> updateInvoice(
      $19.UpdateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$19.DeleteInvoiceResponse> deleteInvoice(
      $19.DeleteInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $19.GetInvoicesByStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicesByStatus, request, options: options);
  }

  $grpc.ResponseFuture<$19.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $19.MarkInvoiceAsPaidRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInvoiceAsPaid, request, options: options);
  }

  $grpc.ResponseFuture<$19.SendInvoiceResponse> sendInvoice(
      $19.SendInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$19.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $19.TagUsersToInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$tagUsersToInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$19.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $19.SearchInvoiceUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInvoiceUsers, request, options: options);
  }
}

abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoiceService';

  InvoiceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$19.GetInvoicesRequest, $19.GetInvoicesResponse>(
            'GetInvoices',
            getInvoices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.GetInvoicesRequest.fromBuffer(value),
            ($19.GetInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInvoiceByIdRequest,
            $19.GetInvoiceByIdResponse>(
        'GetInvoiceById',
        getInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInvoiceByIdRequest.fromBuffer(value),
        ($19.GetInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateInvoiceRequest,
            $19.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateInvoiceRequest.fromBuffer(value),
        ($19.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateInvoiceRequest,
            $19.UpdateInvoiceResponse>(
        'UpdateInvoice',
        updateInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateInvoiceRequest.fromBuffer(value),
        ($19.UpdateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteInvoiceRequest,
            $19.DeleteInvoiceResponse>(
        'DeleteInvoice',
        deleteInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteInvoiceRequest.fromBuffer(value),
        ($19.DeleteInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInvoicesByStatusRequest,
            $19.GetInvoicesByStatusResponse>(
        'GetInvoicesByStatus',
        getInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInvoicesByStatusRequest.fromBuffer(value),
        ($19.GetInvoicesByStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.MarkInvoiceAsPaidRequest,
            $19.MarkInvoiceAsPaidResponse>(
        'MarkInvoiceAsPaid',
        markInvoiceAsPaid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.MarkInvoiceAsPaidRequest.fromBuffer(value),
        ($19.MarkInvoiceAsPaidResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.SendInvoiceRequest, $19.SendInvoiceResponse>(
            'SendInvoice',
            sendInvoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.SendInvoiceRequest.fromBuffer(value),
            ($19.SendInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.TagUsersToInvoiceRequest,
            $19.TagUsersToInvoiceResponse>(
        'TagUsersToInvoice',
        tagUsersToInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.TagUsersToInvoiceRequest.fromBuffer(value),
        ($19.TagUsersToInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.SearchInvoiceUsersRequest,
            $19.SearchInvoiceUsersResponse>(
        'SearchInvoiceUsers',
        searchInvoiceUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.SearchInvoiceUsersRequest.fromBuffer(value),
        ($19.SearchInvoiceUsersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$19.GetInvoicesResponse> getInvoices_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetInvoicesRequest> request) async {
    return getInvoices(call, await request);
  }

  $async.Future<$19.GetInvoiceByIdResponse> getInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInvoiceByIdRequest> request) async {
    return getInvoiceById(call, await request);
  }

  $async.Future<$19.CreateInvoiceResponse> createInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$19.UpdateInvoiceResponse> updateInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateInvoiceRequest> request) async {
    return updateInvoice(call, await request);
  }

  $async.Future<$19.DeleteInvoiceResponse> deleteInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.DeleteInvoiceRequest> request) async {
    return deleteInvoice(call, await request);
  }

  $async.Future<$19.GetInvoicesByStatusResponse> getInvoicesByStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInvoicesByStatusRequest> request) async {
    return getInvoicesByStatus(call, await request);
  }

  $async.Future<$19.MarkInvoiceAsPaidResponse> markInvoiceAsPaid_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.MarkInvoiceAsPaidRequest> request) async {
    return markInvoiceAsPaid(call, await request);
  }

  $async.Future<$19.SendInvoiceResponse> sendInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$19.SendInvoiceRequest> request) async {
    return sendInvoice(call, await request);
  }

  $async.Future<$19.TagUsersToInvoiceResponse> tagUsersToInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.TagUsersToInvoiceRequest> request) async {
    return tagUsersToInvoice(call, await request);
  }

  $async.Future<$19.SearchInvoiceUsersResponse> searchInvoiceUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.SearchInvoiceUsersRequest> request) async {
    return searchInvoiceUsers(call, await request);
  }

  $async.Future<$19.GetInvoicesResponse> getInvoices(
      $grpc.ServiceCall call, $19.GetInvoicesRequest request);
  $async.Future<$19.GetInvoiceByIdResponse> getInvoiceById(
      $grpc.ServiceCall call, $19.GetInvoiceByIdRequest request);
  $async.Future<$19.CreateInvoiceResponse> createInvoice(
      $grpc.ServiceCall call, $19.CreateInvoiceRequest request);
  $async.Future<$19.UpdateInvoiceResponse> updateInvoice(
      $grpc.ServiceCall call, $19.UpdateInvoiceRequest request);
  $async.Future<$19.DeleteInvoiceResponse> deleteInvoice(
      $grpc.ServiceCall call, $19.DeleteInvoiceRequest request);
  $async.Future<$19.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $grpc.ServiceCall call, $19.GetInvoicesByStatusRequest request);
  $async.Future<$19.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $grpc.ServiceCall call, $19.MarkInvoiceAsPaidRequest request);
  $async.Future<$19.SendInvoiceResponse> sendInvoice(
      $grpc.ServiceCall call, $19.SendInvoiceRequest request);
  $async.Future<$19.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $grpc.ServiceCall call, $19.TagUsersToInvoiceRequest request);
  $async.Future<$19.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $grpc.ServiceCall call, $19.SearchInvoiceUsersRequest request);
}
