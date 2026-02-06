//
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'recipient.pb.dart' as $28;

export 'recipient.pb.dart';

@$pb.GrpcServiceName('pb.RecipientService')
class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<$28.CreateRecipientRequest, $28.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($28.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients = $grpc.ClientMethod<$28.ListRecipientsRequest, $28.ListRecipientsResponse>(
      '/pb.RecipientService/ListRecipients',
      ($28.ListRecipientsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<$28.UpdateRecipientRequest, $28.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($28.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<$28.DeleteRecipientRequest, $28.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($28.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient = $grpc.ClientMethod<$28.GetRecipientRequest, $28.GetRecipientResponse>(
      '/pb.RecipientService/GetRecipient',
      ($28.GetRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<$28.GetSimilarRecipientsByNameRequest, $28.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($28.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<$28.SearchRecipientsByAccountRequest, $28.SearchRecipientsByAccountResponse>(
      '/pb.RecipientService/SearchRecipientsByAccount',
      ($28.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $28.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$28.CreateRecipientResponse> createRecipient($28.CreateRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$28.ListRecipientsResponse> listRecipients($28.ListRecipientsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$28.UpdateRecipientResponse> updateRecipient($28.UpdateRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$28.DeleteRecipientResponse> deleteRecipient($28.DeleteRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetRecipientResponse> getRecipient($28.GetRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetSimilarRecipientsByNameResponse> getSimilarRecipientsByName($28.GetSimilarRecipientsByNameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request, options: options);
  }

  $grpc.ResponseFuture<$28.SearchRecipientsByAccountResponse> searchRecipientsByAccount($28.SearchRecipientsByAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.RecipientService')
abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$28.CreateRecipientRequest, $28.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.CreateRecipientRequest.fromBuffer(value),
        ($28.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ListRecipientsRequest, $28.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.ListRecipientsRequest.fromBuffer(value),
        ($28.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.UpdateRecipientRequest, $28.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.UpdateRecipientRequest.fromBuffer(value),
        ($28.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.DeleteRecipientRequest, $28.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.DeleteRecipientRequest.fromBuffer(value),
        ($28.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetRecipientRequest, $28.GetRecipientResponse>(
        'GetRecipient',
        getRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.GetRecipientRequest.fromBuffer(value),
        ($28.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetSimilarRecipientsByNameRequest, $28.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($28.GetSimilarRecipientsByNameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.SearchRecipientsByAccountRequest, $28.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($28.SearchRecipientsByAccountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$28.CreateRecipientResponse> createRecipient_Pre($grpc.ServiceCall call, $async.Future<$28.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$28.ListRecipientsResponse> listRecipients_Pre($grpc.ServiceCall call, $async.Future<$28.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$28.UpdateRecipientResponse> updateRecipient_Pre($grpc.ServiceCall call, $async.Future<$28.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$28.DeleteRecipientResponse> deleteRecipient_Pre($grpc.ServiceCall call, $async.Future<$28.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$28.GetRecipientResponse> getRecipient_Pre($grpc.ServiceCall call, $async.Future<$28.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$28.GetSimilarRecipientsByNameResponse> getSimilarRecipientsByName_Pre($grpc.ServiceCall call, $async.Future<$28.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$28.SearchRecipientsByAccountResponse> searchRecipientsByAccount_Pre($grpc.ServiceCall call, $async.Future<$28.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$28.CreateRecipientResponse> createRecipient($grpc.ServiceCall call, $28.CreateRecipientRequest request);
  $async.Future<$28.ListRecipientsResponse> listRecipients($grpc.ServiceCall call, $28.ListRecipientsRequest request);
  $async.Future<$28.UpdateRecipientResponse> updateRecipient($grpc.ServiceCall call, $28.UpdateRecipientRequest request);
  $async.Future<$28.DeleteRecipientResponse> deleteRecipient($grpc.ServiceCall call, $28.DeleteRecipientRequest request);
  $async.Future<$28.GetRecipientResponse> getRecipient($grpc.ServiceCall call, $28.GetRecipientRequest request);
  $async.Future<$28.GetSimilarRecipientsByNameResponse> getSimilarRecipientsByName($grpc.ServiceCall call, $28.GetSimilarRecipientsByNameRequest request);
  $async.Future<$28.SearchRecipientsByAccountResponse> searchRecipientsByAccount($grpc.ServiceCall call, $28.SearchRecipientsByAccountRequest request);
}
