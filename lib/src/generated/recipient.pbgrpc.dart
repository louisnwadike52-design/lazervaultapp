///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $17;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $17.CreateRecipientRequest, $17.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($17.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$17.ListRecipientsRequest, $17.ListRecipientsResponse>(
          '/pb.RecipientService/ListRecipients',
          ($17.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $17.UpdateRecipientRequest, $17.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($17.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $17.DeleteRecipientRequest, $17.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($17.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$17.GetRecipientRequest, $17.GetRecipientResponse>(
          '/pb.RecipientService/GetRecipient',
          ($17.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $17.GetSimilarRecipientsByNameRequest,
          $17.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($17.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<
          $17.SearchRecipientsByAccountRequest,
          $17.SearchRecipientsByAccountResponse>(
      '/pb.RecipientService/SearchRecipientsByAccount',
      ($17.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$17.CreateRecipientResponse> createRecipient(
      $17.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$17.ListRecipientsResponse> listRecipients(
      $17.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateRecipientResponse> updateRecipient(
      $17.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$17.DeleteRecipientResponse> deleteRecipient(
      $17.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetRecipientResponse> getRecipient(
      $17.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($17.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount($17.SearchRecipientsByAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$17.CreateRecipientRequest,
            $17.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateRecipientRequest.fromBuffer(value),
        ($17.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.ListRecipientsRequest,
            $17.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.ListRecipientsRequest.fromBuffer(value),
        ($17.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdateRecipientRequest,
            $17.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdateRecipientRequest.fromBuffer(value),
        ($17.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.DeleteRecipientRequest,
            $17.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.DeleteRecipientRequest.fromBuffer(value),
        ($17.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.GetRecipientRequest, $17.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.GetRecipientRequest.fromBuffer(value),
            ($17.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetSimilarRecipientsByNameRequest,
            $17.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($17.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.SearchRecipientsByAccountRequest,
            $17.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($17.SearchRecipientsByAccountResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$17.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$17.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$17.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$17.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$17.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$17.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$17.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$17.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount_Pre($grpc.ServiceCall call,
          $async.Future<$17.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$17.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $17.CreateRecipientRequest request);
  $async.Future<$17.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $17.ListRecipientsRequest request);
  $async.Future<$17.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $17.UpdateRecipientRequest request);
  $async.Future<$17.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $17.DeleteRecipientRequest request);
  $async.Future<$17.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $17.GetRecipientRequest request);
  $async.Future<$17.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $17.GetSimilarRecipientsByNameRequest request);
  $async.Future<$17.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount(
          $grpc.ServiceCall call, $17.SearchRecipientsByAccountRequest request);
}
