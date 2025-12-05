///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $11;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $11.CreateRecipientRequest, $11.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($11.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$11.ListRecipientsRequest, $11.ListRecipientsResponse>(
          '/pb.RecipientService/ListRecipients',
          ($11.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $11.UpdateRecipientRequest, $11.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($11.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $11.DeleteRecipientRequest, $11.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($11.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$11.GetRecipientRequest, $11.GetRecipientResponse>(
          '/pb.RecipientService/GetRecipient',
          ($11.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $11.GetSimilarRecipientsByNameRequest,
          $11.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($11.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetSimilarRecipientsByNameResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$11.CreateRecipientResponse> createRecipient(
      $11.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$11.ListRecipientsResponse> listRecipients(
      $11.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$11.UpdateRecipientResponse> updateRecipient(
      $11.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$11.DeleteRecipientResponse> deleteRecipient(
      $11.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetRecipientResponse> getRecipient(
      $11.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($11.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$11.CreateRecipientRequest,
            $11.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.CreateRecipientRequest.fromBuffer(value),
        ($11.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.ListRecipientsRequest,
            $11.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.ListRecipientsRequest.fromBuffer(value),
        ($11.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.UpdateRecipientRequest,
            $11.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.UpdateRecipientRequest.fromBuffer(value),
        ($11.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.DeleteRecipientRequest,
            $11.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.DeleteRecipientRequest.fromBuffer(value),
        ($11.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$11.GetRecipientRequest, $11.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $11.GetRecipientRequest.fromBuffer(value),
            ($11.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetSimilarRecipientsByNameRequest,
            $11.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($11.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$11.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$11.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$11.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$11.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$11.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$11.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$11.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$11.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $11.CreateRecipientRequest request);
  $async.Future<$11.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $11.ListRecipientsRequest request);
  $async.Future<$11.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $11.UpdateRecipientRequest request);
  $async.Future<$11.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $11.DeleteRecipientRequest request);
  $async.Future<$11.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $11.GetRecipientRequest request);
  $async.Future<$11.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $11.GetSimilarRecipientsByNameRequest request);
}
