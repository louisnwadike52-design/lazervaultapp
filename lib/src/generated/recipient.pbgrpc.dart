//
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'recipient.pb.dart' as $10;

export 'recipient.pb.dart';

@$pb.GrpcServiceName('pb.RecipientService')
class RecipientServiceClient extends $grpc.Client {
  static final _$createRecipient = $grpc.ClientMethod<$10.CreateRecipientRequest, $10.CreateRecipientResponse>(
      '/pb.RecipientService/CreateRecipient',
      ($10.CreateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.CreateRecipientResponse.fromBuffer(value));
  static final _$listRecipients = $grpc.ClientMethod<$10.ListRecipientsRequest, $10.ListRecipientsResponse>(
      '/pb.RecipientService/ListRecipients',
      ($10.ListRecipientsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.ListRecipientsResponse.fromBuffer(value));
  static final _$updateRecipient = $grpc.ClientMethod<$10.UpdateRecipientRequest, $10.UpdateRecipientResponse>(
      '/pb.RecipientService/UpdateRecipient',
      ($10.UpdateRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.UpdateRecipientResponse.fromBuffer(value));
  static final _$deleteRecipient = $grpc.ClientMethod<$10.DeleteRecipientRequest, $10.DeleteRecipientResponse>(
      '/pb.RecipientService/DeleteRecipient',
      ($10.DeleteRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.DeleteRecipientResponse.fromBuffer(value));
  static final _$getRecipient = $grpc.ClientMethod<$10.GetRecipientRequest, $10.GetRecipientResponse>(
      '/pb.RecipientService/GetRecipient',
      ($10.GetRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.GetRecipientResponse.fromBuffer(value));

  RecipientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$10.CreateRecipientResponse> createRecipient($10.CreateRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$10.ListRecipientsResponse> listRecipients($10.ListRecipientsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$10.UpdateRecipientResponse> updateRecipient($10.UpdateRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$10.DeleteRecipientResponse> deleteRecipient($10.DeleteRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetRecipientResponse> getRecipient($10.GetRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipient, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.RecipientService')
abstract class RecipientServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RecipientService';

  RecipientServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.CreateRecipientRequest, $10.CreateRecipientResponse>(
        'CreateRecipient',
        createRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.CreateRecipientRequest.fromBuffer(value),
        ($10.CreateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.ListRecipientsRequest, $10.ListRecipientsResponse>(
        'ListRecipients',
        listRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.ListRecipientsRequest.fromBuffer(value),
        ($10.ListRecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateRecipientRequest, $10.UpdateRecipientResponse>(
        'UpdateRecipient',
        updateRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.UpdateRecipientRequest.fromBuffer(value),
        ($10.UpdateRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteRecipientRequest, $10.DeleteRecipientResponse>(
        'DeleteRecipient',
        deleteRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.DeleteRecipientRequest.fromBuffer(value),
        ($10.DeleteRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetRecipientRequest, $10.GetRecipientResponse>(
        'GetRecipient',
        getRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.GetRecipientRequest.fromBuffer(value),
        ($10.GetRecipientResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.CreateRecipientResponse> createRecipient_Pre($grpc.ServiceCall $call, $async.Future<$10.CreateRecipientRequest> $request) async {
    return createRecipient($call, await $request);
  }

  $async.Future<$10.ListRecipientsResponse> listRecipients_Pre($grpc.ServiceCall $call, $async.Future<$10.ListRecipientsRequest> $request) async {
    return listRecipients($call, await $request);
  }

  $async.Future<$10.UpdateRecipientResponse> updateRecipient_Pre($grpc.ServiceCall $call, $async.Future<$10.UpdateRecipientRequest> $request) async {
    return updateRecipient($call, await $request);
  }

  $async.Future<$10.DeleteRecipientResponse> deleteRecipient_Pre($grpc.ServiceCall $call, $async.Future<$10.DeleteRecipientRequest> $request) async {
    return deleteRecipient($call, await $request);
  }

  $async.Future<$10.GetRecipientResponse> getRecipient_Pre($grpc.ServiceCall $call, $async.Future<$10.GetRecipientRequest> $request) async {
    return getRecipient($call, await $request);
  }

  $async.Future<$10.CreateRecipientResponse> createRecipient($grpc.ServiceCall call, $10.CreateRecipientRequest request);
  $async.Future<$10.ListRecipientsResponse> listRecipients($grpc.ServiceCall call, $10.ListRecipientsRequest request);
  $async.Future<$10.UpdateRecipientResponse> updateRecipient($grpc.ServiceCall call, $10.UpdateRecipientRequest request);
  $async.Future<$10.DeleteRecipientResponse> deleteRecipient($grpc.ServiceCall call, $10.DeleteRecipientRequest request);
  $async.Future<$10.GetRecipientResponse> getRecipient($grpc.ServiceCall call, $10.GetRecipientRequest request);
}
