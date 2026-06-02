///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $32;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $32.CreateRecipientRequest, $32.CreateRecipientResponse>(
      '/recipient.RecipientService/CreateRecipient',
      ($32.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$32.ListRecipientsRequest, $32.ListRecipientsResponse>(
          '/recipient.RecipientService/ListRecipients',
          ($32.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $32.UpdateRecipientRequest, $32.UpdateRecipientResponse>(
      '/recipient.RecipientService/UpdateRecipient',
      ($32.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $32.DeleteRecipientRequest, $32.DeleteRecipientResponse>(
      '/recipient.RecipientService/DeleteRecipient',
      ($32.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$32.GetRecipientRequest, $32.GetRecipientResponse>(
          '/recipient.RecipientService/GetRecipient',
          ($32.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $32.GetSimilarRecipientsByNameRequest,
          $32.GetSimilarRecipientsByNameResponse>(
      '/recipient.RecipientService/GetSimilarRecipientsByName',
      ($32.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<
          $32.SearchRecipientsByAccountRequest,
          $32.SearchRecipientsByAccountResponse>(
      '/recipient.RecipientService/SearchRecipientsByAccount',
      ($32.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$32.CreateRecipientResponse> createRecipient(
      $32.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$32.ListRecipientsResponse> listRecipients(
      $32.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$32.UpdateRecipientResponse> updateRecipient(
      $32.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$32.DeleteRecipientResponse> deleteRecipient(
      $32.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetRecipientResponse> getRecipient(
      $32.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($32.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }

  $grpc.ResponseFuture<$32.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount($32.SearchRecipientsByAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'recipient.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$32.CreateRecipientRequest,
            $32.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.CreateRecipientRequest.fromBuffer(value),
        ($32.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.ListRecipientsRequest,
            $32.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.ListRecipientsRequest.fromBuffer(value),
        ($32.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.UpdateRecipientRequest,
            $32.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.UpdateRecipientRequest.fromBuffer(value),
        ($32.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.DeleteRecipientRequest,
            $32.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.DeleteRecipientRequest.fromBuffer(value),
        ($32.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$32.GetRecipientRequest, $32.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $32.GetRecipientRequest.fromBuffer(value),
            ($32.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetSimilarRecipientsByNameRequest,
            $32.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($32.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.SearchRecipientsByAccountRequest,
            $32.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($32.SearchRecipientsByAccountResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$32.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$32.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$32.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$32.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$32.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$32.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$32.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$32.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount_Pre($grpc.ServiceCall call,
          $async.Future<$32.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$32.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $32.CreateRecipientRequest request);
  $async.Future<$32.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $32.ListRecipientsRequest request);
  $async.Future<$32.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $32.UpdateRecipientRequest request);
  $async.Future<$32.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $32.DeleteRecipientRequest request);
  $async.Future<$32.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $32.GetRecipientRequest request);
  $async.Future<$32.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $32.GetSimilarRecipientsByNameRequest request);
  $async.Future<$32.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount(
          $grpc.ServiceCall call, $32.SearchRecipientsByAccountRequest request);
}
