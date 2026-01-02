///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipient.pb.dart' as $22;
export 'recipient.pb.dart';

class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<
          $22.CreateRecipientRequest, $22.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($22.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients =
      $grpc.ClientMethod<$22.ListRecipientsRequest, $22.ListRecipientsResponse>(
          '/pb.RecipientService/ListRecipients',
          ($22.ListRecipientsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<
          $22.UpdateRecipientRequest, $22.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($22.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<
          $22.DeleteRecipientRequest, $22.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($22.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient =
      $grpc.ClientMethod<$22.GetRecipientRequest, $22.GetRecipientResponse>(
          '/pb.RecipientService/GetRecipient',
          ($22.GetRecipientRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<
          $22.GetSimilarRecipientsByNameRequest,
          $22.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($22.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<
          $22.SearchRecipientsByAccountRequest,
          $22.SearchRecipientsByAccountResponse>(
      '/pb.RecipientService/SearchRecipientsByAccount',
      ($22.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$22.CreateRecipientResponse> createRecipient(
      $22.CreateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListRecipientsResponse> listRecipients(
      $22.ListRecipientsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateRecipientResponse> updateRecipient(
      $22.UpdateRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$22.DeleteRecipientResponse> deleteRecipient(
      $22.DeleteRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetRecipientResponse> getRecipient(
      $22.GetRecipientRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($22.GetSimilarRecipientsByNameRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount($22.SearchRecipientsByAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request,
        options: options);
  }
}

abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$22.CreateRecipientRequest,
            $22.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.CreateRecipientRequest.fromBuffer(value),
        ($22.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListRecipientsRequest,
            $22.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListRecipientsRequest.fromBuffer(value),
        ($22.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateRecipientRequest,
            $22.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateRecipientRequest.fromBuffer(value),
        ($22.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.DeleteRecipientRequest,
            $22.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.DeleteRecipientRequest.fromBuffer(value),
        ($22.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.GetRecipientRequest, $22.GetRecipientResponse>(
            'GetRecipient',
            getRecipient_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.GetRecipientRequest.fromBuffer(value),
            ($22.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetSimilarRecipientsByNameRequest,
            $22.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($22.GetSimilarRecipientsByNameResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.SearchRecipientsByAccountRequest,
            $22.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($22.SearchRecipientsByAccountResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$22.CreateRecipientResponse> createRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$22.ListRecipientsResponse> listRecipients_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$22.UpdateRecipientResponse> updateRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$22.DeleteRecipientResponse> deleteRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$22.GetRecipientResponse> getRecipient_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$22.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$22.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount_Pre($grpc.ServiceCall call,
          $async.Future<$22.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$22.CreateRecipientResponse> createRecipient(
      $grpc.ServiceCall call, $22.CreateRecipientRequest request);
  $async.Future<$22.ListRecipientsResponse> listRecipients(
      $grpc.ServiceCall call, $22.ListRecipientsRequest request);
  $async.Future<$22.UpdateRecipientResponse> updateRecipient(
      $grpc.ServiceCall call, $22.UpdateRecipientRequest request);
  $async.Future<$22.DeleteRecipientResponse> deleteRecipient(
      $grpc.ServiceCall call, $22.DeleteRecipientRequest request);
  $async.Future<$22.GetRecipientResponse> getRecipient(
      $grpc.ServiceCall call, $22.GetRecipientRequest request);
  $async.Future<$22.GetSimilarRecipientsByNameResponse>
      getSimilarRecipientsByName($grpc.ServiceCall call,
          $22.GetSimilarRecipientsByNameRequest request);
  $async.Future<$22.SearchRecipientsByAccountResponse>
      searchRecipientsByAccount(
          $grpc.ServiceCall call, $22.SearchRecipientsByAccountRequest request);
}
