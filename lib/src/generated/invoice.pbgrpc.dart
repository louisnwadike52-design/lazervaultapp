///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice.pb.dart' as $15;
export 'invoice.pb.dart';

class InvoiceServiceClient extends $grpc.Client {
  static final _$getInvoices =
      $grpc.ClientMethod<$15.GetInvoicesRequest, $15.GetInvoicesResponse>(
          '/pb.InvoiceService/GetInvoices',
          ($15.GetInvoicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.GetInvoicesResponse.fromBuffer(value));
  static final _$getInvoiceById =
      $grpc.ClientMethod<$15.GetInvoiceByIdRequest, $15.GetInvoiceByIdResponse>(
          '/pb.InvoiceService/GetInvoiceById',
          ($15.GetInvoiceByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.GetInvoiceByIdResponse.fromBuffer(value));
  static final _$createInvoice =
      $grpc.ClientMethod<$15.CreateInvoiceRequest, $15.CreateInvoiceResponse>(
          '/pb.InvoiceService/CreateInvoice',
          ($15.CreateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.CreateInvoiceResponse.fromBuffer(value));
  static final _$updateInvoice =
      $grpc.ClientMethod<$15.UpdateInvoiceRequest, $15.UpdateInvoiceResponse>(
          '/pb.InvoiceService/UpdateInvoice',
          ($15.UpdateInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.UpdateInvoiceResponse.fromBuffer(value));
  static final _$deleteInvoice =
      $grpc.ClientMethod<$15.DeleteInvoiceRequest, $15.DeleteInvoiceResponse>(
          '/pb.InvoiceService/DeleteInvoice',
          ($15.DeleteInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.DeleteInvoiceResponse.fromBuffer(value));
  static final _$getInvoicesByStatus = $grpc.ClientMethod<
          $15.GetInvoicesByStatusRequest, $15.GetInvoicesByStatusResponse>(
      '/pb.InvoiceService/GetInvoicesByStatus',
      ($15.GetInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetInvoicesByStatusResponse.fromBuffer(value));
  static final _$markInvoiceAsPaid = $grpc.ClientMethod<
          $15.MarkInvoiceAsPaidRequest, $15.MarkInvoiceAsPaidResponse>(
      '/pb.InvoiceService/MarkInvoiceAsPaid',
      ($15.MarkInvoiceAsPaidRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.MarkInvoiceAsPaidResponse.fromBuffer(value));
  static final _$sendInvoice =
      $grpc.ClientMethod<$15.SendInvoiceRequest, $15.SendInvoiceResponse>(
          '/pb.InvoiceService/SendInvoice',
          ($15.SendInvoiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.SendInvoiceResponse.fromBuffer(value));
  static final _$tagUsersToInvoice = $grpc.ClientMethod<
          $15.TagUsersToInvoiceRequest, $15.TagUsersToInvoiceResponse>(
      '/pb.InvoiceService/TagUsersToInvoice',
      ($15.TagUsersToInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.TagUsersToInvoiceResponse.fromBuffer(value));
  static final _$searchInvoiceUsers = $grpc.ClientMethod<
          $15.SearchInvoiceUsersRequest, $15.SearchInvoiceUsersResponse>(
      '/pb.InvoiceService/SearchInvoiceUsers',
      ($15.SearchInvoiceUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.SearchInvoiceUsersResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$15.GetInvoicesResponse> getInvoices(
      $15.GetInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetInvoiceByIdResponse> getInvoiceById(
      $15.GetInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$15.CreateInvoiceResponse> createInvoice(
      $15.CreateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdateInvoiceResponse> updateInvoice(
      $15.UpdateInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$15.DeleteInvoiceResponse> deleteInvoice(
      $15.DeleteInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $15.GetInvoicesByStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicesByStatus, request, options: options);
  }

  $grpc.ResponseFuture<$15.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $15.MarkInvoiceAsPaidRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInvoiceAsPaid, request, options: options);
  }

  $grpc.ResponseFuture<$15.SendInvoiceResponse> sendInvoice(
      $15.SendInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$15.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $15.TagUsersToInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$tagUsersToInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$15.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $15.SearchInvoiceUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInvoiceUsers, request, options: options);
  }
}

abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoiceService';

  InvoiceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$15.GetInvoicesRequest, $15.GetInvoicesResponse>(
            'GetInvoices',
            getInvoices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.GetInvoicesRequest.fromBuffer(value),
            ($15.GetInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetInvoiceByIdRequest,
            $15.GetInvoiceByIdResponse>(
        'GetInvoiceById',
        getInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetInvoiceByIdRequest.fromBuffer(value),
        ($15.GetInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.CreateInvoiceRequest,
            $15.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.CreateInvoiceRequest.fromBuffer(value),
        ($15.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateInvoiceRequest,
            $15.UpdateInvoiceResponse>(
        'UpdateInvoice',
        updateInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.UpdateInvoiceRequest.fromBuffer(value),
        ($15.UpdateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.DeleteInvoiceRequest,
            $15.DeleteInvoiceResponse>(
        'DeleteInvoice',
        deleteInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.DeleteInvoiceRequest.fromBuffer(value),
        ($15.DeleteInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetInvoicesByStatusRequest,
            $15.GetInvoicesByStatusResponse>(
        'GetInvoicesByStatus',
        getInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetInvoicesByStatusRequest.fromBuffer(value),
        ($15.GetInvoicesByStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.MarkInvoiceAsPaidRequest,
            $15.MarkInvoiceAsPaidResponse>(
        'MarkInvoiceAsPaid',
        markInvoiceAsPaid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.MarkInvoiceAsPaidRequest.fromBuffer(value),
        ($15.MarkInvoiceAsPaidResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$15.SendInvoiceRequest, $15.SendInvoiceResponse>(
            'SendInvoice',
            sendInvoice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.SendInvoiceRequest.fromBuffer(value),
            ($15.SendInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.TagUsersToInvoiceRequest,
            $15.TagUsersToInvoiceResponse>(
        'TagUsersToInvoice',
        tagUsersToInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.TagUsersToInvoiceRequest.fromBuffer(value),
        ($15.TagUsersToInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.SearchInvoiceUsersRequest,
            $15.SearchInvoiceUsersResponse>(
        'SearchInvoiceUsers',
        searchInvoiceUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.SearchInvoiceUsersRequest.fromBuffer(value),
        ($15.SearchInvoiceUsersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$15.GetInvoicesResponse> getInvoices_Pre($grpc.ServiceCall call,
      $async.Future<$15.GetInvoicesRequest> request) async {
    return getInvoices(call, await request);
  }

  $async.Future<$15.GetInvoiceByIdResponse> getInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetInvoiceByIdRequest> request) async {
    return getInvoiceById(call, await request);
  }

  $async.Future<$15.CreateInvoiceResponse> createInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$15.UpdateInvoiceResponse> updateInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.UpdateInvoiceRequest> request) async {
    return updateInvoice(call, await request);
  }

  $async.Future<$15.DeleteInvoiceResponse> deleteInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.DeleteInvoiceRequest> request) async {
    return deleteInvoice(call, await request);
  }

  $async.Future<$15.GetInvoicesByStatusResponse> getInvoicesByStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetInvoicesByStatusRequest> request) async {
    return getInvoicesByStatus(call, await request);
  }

  $async.Future<$15.MarkInvoiceAsPaidResponse> markInvoiceAsPaid_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.MarkInvoiceAsPaidRequest> request) async {
    return markInvoiceAsPaid(call, await request);
  }

  $async.Future<$15.SendInvoiceResponse> sendInvoice_Pre($grpc.ServiceCall call,
      $async.Future<$15.SendInvoiceRequest> request) async {
    return sendInvoice(call, await request);
  }

  $async.Future<$15.TagUsersToInvoiceResponse> tagUsersToInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.TagUsersToInvoiceRequest> request) async {
    return tagUsersToInvoice(call, await request);
  }

  $async.Future<$15.SearchInvoiceUsersResponse> searchInvoiceUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.SearchInvoiceUsersRequest> request) async {
    return searchInvoiceUsers(call, await request);
  }

  $async.Future<$15.GetInvoicesResponse> getInvoices(
      $grpc.ServiceCall call, $15.GetInvoicesRequest request);
  $async.Future<$15.GetInvoiceByIdResponse> getInvoiceById(
      $grpc.ServiceCall call, $15.GetInvoiceByIdRequest request);
  $async.Future<$15.CreateInvoiceResponse> createInvoice(
      $grpc.ServiceCall call, $15.CreateInvoiceRequest request);
  $async.Future<$15.UpdateInvoiceResponse> updateInvoice(
      $grpc.ServiceCall call, $15.UpdateInvoiceRequest request);
  $async.Future<$15.DeleteInvoiceResponse> deleteInvoice(
      $grpc.ServiceCall call, $15.DeleteInvoiceRequest request);
  $async.Future<$15.GetInvoicesByStatusResponse> getInvoicesByStatus(
      $grpc.ServiceCall call, $15.GetInvoicesByStatusRequest request);
  $async.Future<$15.MarkInvoiceAsPaidResponse> markInvoiceAsPaid(
      $grpc.ServiceCall call, $15.MarkInvoiceAsPaidRequest request);
  $async.Future<$15.SendInvoiceResponse> sendInvoice(
      $grpc.ServiceCall call, $15.SendInvoiceRequest request);
  $async.Future<$15.TagUsersToInvoiceResponse> tagUsersToInvoice(
      $grpc.ServiceCall call, $15.TagUsersToInvoiceRequest request);
  $async.Future<$15.SearchInvoiceUsersResponse> searchInvoiceUsers(
      $grpc.ServiceCall call, $15.SearchInvoiceUsersRequest request);
}
