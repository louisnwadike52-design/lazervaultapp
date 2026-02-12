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

import 'recipient.pb.dart' as $0;

export 'recipient.pb.dart';

@$pb.GrpcServiceName('pb.RecipientService')
class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<$0.CreateRecipientRequest, $0.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($0.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients = $grpc.ClientMethod<$0.ListRecipientsRequest, $0.ListRecipientsResponse>(
      '/pb.RecipientService/ListRecipients',
      ($0.ListRecipientsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<$0.UpdateRecipientRequest, $0.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($0.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<$0.DeleteRecipientRequest, $0.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($0.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient = $grpc.ClientMethod<$0.GetRecipientRequest, $0.GetRecipientResponse>(
      '/pb.RecipientService/GetRecipient',
      ($0.GetRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetRecipientResponse.fromBuffer(value));
  static final _$getSimilarRecipientsByName = $grpc.ClientMethod<$0.GetSimilarRecipientsByNameRequest, $0.GetSimilarRecipientsByNameResponse>(
      '/pb.RecipientService/GetSimilarRecipientsByName',
      ($0.GetSimilarRecipientsByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSimilarRecipientsByNameResponse.fromBuffer(value));
  static final _$searchRecipientsByAccount = $grpc.ClientMethod<$0.SearchRecipientsByAccountRequest, $0.SearchRecipientsByAccountResponse>(
      '/pb.RecipientService/SearchRecipientsByAccount',
      ($0.SearchRecipientsByAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchRecipientsByAccountResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateRecipientResponse> createRecipient($0.CreateRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListRecipientsResponse> listRecipients($0.ListRecipientsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateRecipientResponse> updateRecipient($0.UpdateRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteRecipientResponse> deleteRecipient($0.DeleteRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRecipientResponse> getRecipient($0.GetRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSimilarRecipientsByNameResponse> getSimilarRecipientsByName($0.GetSimilarRecipientsByNameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSimilarRecipientsByName, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchRecipientsByAccountResponse> searchRecipientsByAccount($0.SearchRecipientsByAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipientsByAccount, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.RecipientService')
abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateRecipientRequest, $0.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateRecipientRequest.fromBuffer(value),
        ($0.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListRecipientsRequest, $0.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListRecipientsRequest.fromBuffer(value),
        ($0.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateRecipientRequest, $0.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateRecipientRequest.fromBuffer(value),
        ($0.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRecipientRequest, $0.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteRecipientRequest.fromBuffer(value),
        ($0.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecipientRequest, $0.GetRecipientResponse>(
        'GetRecipient',
        getRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRecipientRequest.fromBuffer(value),
        ($0.GetRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSimilarRecipientsByNameRequest, $0.GetSimilarRecipientsByNameResponse>(
        'GetSimilarRecipientsByName',
        getSimilarRecipientsByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSimilarRecipientsByNameRequest.fromBuffer(value),
        ($0.GetSimilarRecipientsByNameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchRecipientsByAccountRequest, $0.SearchRecipientsByAccountResponse>(
        'SearchRecipientsByAccount',
        searchRecipientsByAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRecipientsByAccountRequest.fromBuffer(value),
        ($0.SearchRecipientsByAccountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateRecipientResponse> createRecipient_Pre($grpc.ServiceCall call, $async.Future<$0.CreateRecipientRequest> request) async {
    return createRecipient(call, await request);
  }

  $async.Future<$0.ListRecipientsResponse> listRecipients_Pre($grpc.ServiceCall call, $async.Future<$0.ListRecipientsRequest> request) async {
    return listRecipients(call, await request);
  }

  $async.Future<$0.UpdateRecipientResponse> updateRecipient_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateRecipientRequest> request) async {
    return updateRecipient(call, await request);
  }

  $async.Future<$0.DeleteRecipientResponse> deleteRecipient_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteRecipientRequest> request) async {
    return deleteRecipient(call, await request);
  }

  $async.Future<$0.GetRecipientResponse> getRecipient_Pre($grpc.ServiceCall call, $async.Future<$0.GetRecipientRequest> request) async {
    return getRecipient(call, await request);
  }

  $async.Future<$0.GetSimilarRecipientsByNameResponse> getSimilarRecipientsByName_Pre($grpc.ServiceCall call, $async.Future<$0.GetSimilarRecipientsByNameRequest> request) async {
    return getSimilarRecipientsByName(call, await request);
  }

  $async.Future<$0.SearchRecipientsByAccountResponse> searchRecipientsByAccount_Pre($grpc.ServiceCall call, $async.Future<$0.SearchRecipientsByAccountRequest> request) async {
    return searchRecipientsByAccount(call, await request);
  }

  $async.Future<$0.CreateRecipientResponse> createRecipient($grpc.ServiceCall call, $0.CreateRecipientRequest request);
  $async.Future<$0.ListRecipientsResponse> listRecipients($grpc.ServiceCall call, $0.ListRecipientsRequest request);
  $async.Future<$0.UpdateRecipientResponse> updateRecipient($grpc.ServiceCall call, $0.UpdateRecipientRequest request);
  $async.Future<$0.DeleteRecipientResponse> deleteRecipient($grpc.ServiceCall call, $0.DeleteRecipientRequest request);
  $async.Future<$0.GetRecipientResponse> getRecipient($grpc.ServiceCall call, $0.GetRecipientRequest request);
  $async.Future<$0.GetSimilarRecipientsByNameResponse> getSimilarRecipientsByName($grpc.ServiceCall call, $0.GetSimilarRecipientsByNameRequest request);
  $async.Future<$0.SearchRecipientsByAccountResponse> searchRecipientsByAccount($grpc.ServiceCall call, $0.SearchRecipientsByAccountRequest request);
}
