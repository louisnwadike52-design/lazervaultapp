///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $31;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $31.CreateRecipientRequest, $31.CreateRecipientResponse>(
      '/recipient.RecipientService/CreateRecipient',
      ($31.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$31.ListRecipientsRequest, $31.ListRecipientsResponse>(
          '/recipient.RecipientService/ListRecipients',
          ($31.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $31.UpdateRecipientRequest, $31.UpdateRecipientResponse>(
      '/recipient.RecipientService/UpdateRecipient',
      ($31.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $31.DeleteRecipientRequest, $31.DeleteRecipientResponse>(
      '/recipient.RecipientService/DeleteRecipient',
      ($31.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$31.GetRecipientRequest, $31.GetRecipientResponse>(
          '/recipient.RecipientService/GetRecipient',
          ($31.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $31.GetSimilarRecipientsByNameRequest,
          $31.GetSimilarRecipientsByNameResponse>(
      '/recipient.RecipientService/GetSimilarRecipientsByName',
      ($31.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<
          $31.SearchRecipientsByAccountRequest,
          $31.SearchRecipientsByAccountResponse>(
      '/recipient.RecipientService/SearchRecipientsByAccount',
      ($31.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$31.CreateRecipientResponse> createRecipient(
      $31.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$31.ListRecipientsResponse> listRecipients(
      $31.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$31.UpdateRecipientResponse> updateRecipient(
      $31.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$31.DeleteRecipientResponse> deleteRecipient(
      $31.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetRecipientResponse> getRecipient(
      $31.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($31.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }

  $grpc.ResponseFuture<$31.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount($31.SearchRecipientsByAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'recipient.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$31.CreateRecipientRequest,
            $31.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.CreateRecipientRequest.fromBuffer(value),
        ($31.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.ListRecipientsRequest,
            $31.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.ListRecipientsRequest.fromBuffer(value),
        ($31.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdateRecipientRequest,
            $31.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UpdateRecipientRequest.fromBuffer(value),
        ($31.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.DeleteRecipientRequest,
            $31.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.DeleteRecipientRequest.fromBuffer(value),
        ($31.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$31.GetRecipientRequest, $31.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $31.GetRecipientRequest.fromBuffer(value),
            ($31.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetSimilarRecipientsByNameRequest,
            $31.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($31.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.SearchRecipientsByAccountRequest,
            $31.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($31.SearchRecipientsByAccountResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$31.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$31.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$31.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$31.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$31.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$31.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$31.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$31.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount_Pre($grpc.ServiceCall call,
          $async.Future<$31.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$31.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $31.CreateRecipientRequest request);
  $async.Future<$31.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $31.ListRecipientsRequest request);
  $async.Future<$31.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $31.UpdateRecipientRequest request);
  $async.Future<$31.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $31.DeleteRecipientRequest request);
  $async.Future<$31.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $31.GetRecipientRequest request);
  $async.Future<$31.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $31.GetSimilarRecipientsByNameRequest request);
  $async.Future<$31.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount(
          $grpc.ServiceCall call, $31.SearchRecipientsByAccountRequest request);
}
