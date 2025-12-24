///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $16;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $16.CreateRecipientRequest, $16.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($16.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$16.ListRecipientsRequest, $16.ListRecipientsResponse>(
          '/pb.RecipientService/ListRecipients',
          ($16.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $16.UpdateRecipientRequest, $16.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($16.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $16.DeleteRecipientRequest, $16.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($16.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$16.GetRecipientRequest, $16.GetRecipientResponse>(
          '/pb.RecipientService/GetRecipient',
          ($16.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $16.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $16.GetSimilarRecipientsByNameRequest,
          $16.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($16.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<
          $16.SearchRecipientsByAccountRequest,
          $16.SearchRecipientsByAccountResponse>(
      '/pb.RecipientService/SearchRecipientsByAccount',
      ($16.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$16.CreateRecipientResponse> createRecipient(
      $16.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$16.ListRecipientsResponse> listRecipients(
      $16.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$16.UpdateRecipientResponse> updateRecipient(
      $16.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$16.DeleteRecipientResponse> deleteRecipient(
      $16.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetRecipientResponse> getRecipient(
      $16.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($16.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount($16.SearchRecipientsByAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$16.CreateRecipientRequest,
            $16.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.CreateRecipientRequest.fromBuffer(value),
        ($16.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ListRecipientsRequest,
            $16.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ListRecipientsRequest.fromBuffer(value),
        ($16.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.UpdateRecipientRequest,
            $16.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.UpdateRecipientRequest.fromBuffer(value),
        ($16.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.DeleteRecipientRequest,
            $16.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.DeleteRecipientRequest.fromBuffer(value),
        ($16.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$16.GetRecipientRequest, $16.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $16.GetRecipientRequest.fromBuffer(value),
            ($16.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetSimilarRecipientsByNameRequest,
            $16.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($16.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.SearchRecipientsByAccountRequest,
            $16.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($16.SearchRecipientsByAccountResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$16.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$16.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$16.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$16.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$16.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$16.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$16.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$16.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount_Pre($grpc.ServiceCall call,
          $async.Future<$16.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$16.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $16.CreateRecipientRequest request);
  $async.Future<$16.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $16.ListRecipientsRequest request);
  $async.Future<$16.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $16.UpdateRecipientRequest request);
  $async.Future<$16.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $16.DeleteRecipientRequest request);
  $async.Future<$16.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $16.GetRecipientRequest request);
  $async.Future<$16.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $16.GetSimilarRecipientsByNameRequest request);
  $async.Future<$16.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount(
          $grpc.ServiceCall call, $16.SearchRecipientsByAccountRequest request);
}
