///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $18;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $18.CreateRecipientRequest, $18.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($18.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$18.ListRecipientsRequest, $18.ListRecipientsResponse>(
          '/pb.RecipientService/ListRecipients',
          ($18.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $18.UpdateRecipientRequest, $18.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($18.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $18.DeleteRecipientRequest, $18.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($18.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$18.GetRecipientRequest, $18.GetRecipientResponse>(
          '/pb.RecipientService/GetRecipient',
          ($18.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $18.GetSimilarRecipientsByNameRequest,
          $18.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($18.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<
          $18.SearchRecipientsByAccountRequest,
          $18.SearchRecipientsByAccountResponse>(
      '/pb.RecipientService/SearchRecipientsByAccount',
      ($18.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$18.CreateRecipientResponse> createRecipient(
      $18.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$18.ListRecipientsResponse> listRecipients(
      $18.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateRecipientResponse> updateRecipient(
      $18.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$18.DeleteRecipientResponse> deleteRecipient(
      $18.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetRecipientResponse> getRecipient(
      $18.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($18.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount($18.SearchRecipientsByAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$18.CreateRecipientRequest,
            $18.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateRecipientRequest.fromBuffer(value),
        ($18.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ListRecipientsRequest,
            $18.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ListRecipientsRequest.fromBuffer(value),
        ($18.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateRecipientRequest,
            $18.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateRecipientRequest.fromBuffer(value),
        ($18.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.DeleteRecipientRequest,
            $18.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.DeleteRecipientRequest.fromBuffer(value),
        ($18.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$18.GetRecipientRequest, $18.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $18.GetRecipientRequest.fromBuffer(value),
            ($18.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetSimilarRecipientsByNameRequest,
            $18.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($18.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.SearchRecipientsByAccountRequest,
            $18.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($18.SearchRecipientsByAccountResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$18.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$18.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$18.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$18.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$18.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$18.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$18.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$18.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount_Pre($grpc.ServiceCall call,
          $async.Future<$18.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$18.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $18.CreateRecipientRequest request);
  $async.Future<$18.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $18.ListRecipientsRequest request);
  $async.Future<$18.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $18.UpdateRecipientRequest request);
  $async.Future<$18.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $18.DeleteRecipientRequest request);
  $async.Future<$18.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $18.GetRecipientRequest request);
  $async.Future<$18.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $18.GetSimilarRecipientsByNameRequest request);
  $async.Future<$18.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount(
          $grpc.ServiceCall call, $18.SearchRecipientsByAccountRequest request);
}
