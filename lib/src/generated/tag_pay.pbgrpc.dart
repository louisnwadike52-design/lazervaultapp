//
//  Generated code. Do not modify.
//  source: tag_pay.proto
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

import 'tag_pay.pb.dart' as $32;

export 'tag_pay.pb.dart';

@$pb.GrpcServiceName('pb.TagPayService')
class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay = $grpc.ClientMethod<$32.CreateTagPayRequest, $32.CreateTagPayResponse>(
      '/pb.TagPayService/CreateTagPay',
      ($32.CreateTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay = $grpc.ClientMethod<$32.GetTagPayRequest, $32.GetTagPayResponse>(
      '/pb.TagPayService/GetTagPay',
      ($32.GetTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<$32.CheckTagPayAvailabilityRequest, $32.CheckTagPayAvailabilityResponse>(
      '/pb.TagPayService/CheckTagPayAvailability',
      ($32.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay = $grpc.ClientMethod<$32.SearchTagPayRequest, $32.SearchTagPayResponse>(
      '/pb.TagPayService/SearchTagPay',
      ($32.SearchTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<$32.SendMoneyTagPayRequest, $32.SendMoneyTagPayResponse>(
      '/pb.TagPayService/SendMoneyTagPay',
      ($32.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<$32.RequestMoneyTagPayRequest, $32.RequestMoneyTagPayResponse>(
      '/pb.TagPayService/RequestMoneyTagPay',
      ($32.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<$32.GetTagPayTransactionsRequest, $32.GetTagPayTransactionsResponse>(
      '/pb.TagPayService/GetTagPayTransactions',
      ($32.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<$32.AcceptMoneyRequestRequest, $32.AcceptMoneyRequestResponse>(
      '/pb.TagPayService/AcceptMoneyRequest',
      ($32.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<$32.DeclineMoneyRequestRequest, $32.DeclineMoneyRequestResponse>(
      '/pb.TagPayService/DeclineMoneyRequest',
      ($32.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<$32.GetPendingMoneyRequestsRequest, $32.GetPendingMoneyRequestsResponse>(
      '/pb.TagPayService/GetPendingMoneyRequests',
      ($32.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag = $grpc.ClientMethod<$32.CreateTagRequest, $32.CreateTagResponse>(
      '/pb.TagPayService/CreateTag',
      ($32.CreateTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags = $grpc.ClientMethod<$32.GetMyTagsRequest, $32.GetMyTagsResponse>(
      '/pb.TagPayService/GetMyTags',
      ($32.GetMyTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags = $grpc.ClientMethod<$32.GetMyTagsRequest, $32.GetMyTagsResponse>(
      '/pb.TagPayService/GetMyOutgoingTags',
      ($32.GetMyTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags = $grpc.ClientMethod<$32.GetMyTagsRequest, $32.GetMyTagsResponse>(
      '/pb.TagPayService/GetMyIncomingTags',
      ($32.GetMyTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag = $grpc.ClientMethod<$32.PayTagRequest, $32.PayTagResponse>(
      '/pb.TagPayService/PayTag',
      ($32.PayTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$32.SearchUsersForTagRequest, $32.SearchUsersForTagResponse>(
      '/pb.TagPayService/SearchUsers',
      ($32.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.SearchUsersForTagResponse.fromBuffer(value));
  static final _$batchCreateTags = $grpc.ClientMethod<$32.BatchCreateTagsRequest, $32.BatchCreateTagsResponse>(
      '/pb.TagPayService/BatchCreateTags',
      ($32.BatchCreateTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $32.BatchCreateTagsResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$32.CreateTagPayResponse> createTagPay($32.CreateTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetTagPayResponse> getTagPay($32.GetTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$32.CheckTagPayAvailabilityResponse> checkTagPayAvailability($32.CheckTagPayAvailabilityRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request, options: options);
  }

  $grpc.ResponseFuture<$32.SearchTagPayResponse> searchTagPay($32.SearchTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$32.SendMoneyTagPayResponse> sendMoneyTagPay($32.SendMoneyTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$32.RequestMoneyTagPayResponse> requestMoneyTagPay($32.RequestMoneyTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetTagPayTransactionsResponse> getTagPayTransactions($32.GetTagPayTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$32.AcceptMoneyRequestResponse> acceptMoneyRequest($32.AcceptMoneyRequestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$32.DeclineMoneyRequestResponse> declineMoneyRequest($32.DeclineMoneyRequestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetPendingMoneyRequestsResponse> getPendingMoneyRequests($32.GetPendingMoneyRequestsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request, options: options);
  }

  $grpc.ResponseFuture<$32.CreateTagResponse> createTag($32.CreateTagRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyTagsResponse> getMyTags($32.GetMyTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyTagsResponse> getMyOutgoingTags($32.GetMyTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyTagsResponse> getMyIncomingTags($32.GetMyTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$32.PayTagResponse> payTag($32.PayTagRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$32.SearchUsersForTagResponse> searchUsers($32.SearchUsersForTagRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$32.BatchCreateTagsResponse> batchCreateTags($32.BatchCreateTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchCreateTags, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TagPayService')
abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TagPayService';

  TagPayServiceBase() {
    $addMethod($grpc.ServiceMethod<$32.CreateTagPayRequest, $32.CreateTagPayResponse>(
        'CreateTagPay',
        createTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.CreateTagPayRequest.fromBuffer(value),
        ($32.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetTagPayRequest, $32.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.GetTagPayRequest.fromBuffer(value),
        ($32.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.CheckTagPayAvailabilityRequest, $32.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($32.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.SearchTagPayRequest, $32.SearchTagPayResponse>(
        'SearchTagPay',
        searchTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.SearchTagPayRequest.fromBuffer(value),
        ($32.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.SendMoneyTagPayRequest, $32.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.SendMoneyTagPayRequest.fromBuffer(value),
        ($32.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.RequestMoneyTagPayRequest, $32.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.RequestMoneyTagPayRequest.fromBuffer(value),
        ($32.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetTagPayTransactionsRequest, $32.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.GetTagPayTransactionsRequest.fromBuffer(value),
        ($32.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.AcceptMoneyRequestRequest, $32.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.AcceptMoneyRequestRequest.fromBuffer(value),
        ($32.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.DeclineMoneyRequestRequest, $32.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.DeclineMoneyRequestRequest.fromBuffer(value),
        ($32.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetPendingMoneyRequestsRequest, $32.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($32.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.CreateTagRequest, $32.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.CreateTagRequest.fromBuffer(value),
        ($32.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyTagsRequest, $32.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.GetMyTagsRequest.fromBuffer(value),
        ($32.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyTagsRequest, $32.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.GetMyTagsRequest.fromBuffer(value),
        ($32.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyTagsRequest, $32.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.GetMyTagsRequest.fromBuffer(value),
        ($32.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.PayTagRequest, $32.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.PayTagRequest.fromBuffer(value),
        ($32.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.SearchUsersForTagRequest, $32.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.SearchUsersForTagRequest.fromBuffer(value),
        ($32.SearchUsersForTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.BatchCreateTagsRequest, $32.BatchCreateTagsResponse>(
        'BatchCreateTags',
        batchCreateTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $32.BatchCreateTagsRequest.fromBuffer(value),
        ($32.BatchCreateTagsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$32.CreateTagPayResponse> createTagPay_Pre($grpc.ServiceCall call, $async.Future<$32.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$32.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call, $async.Future<$32.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$32.CheckTagPayAvailabilityResponse> checkTagPayAvailability_Pre($grpc.ServiceCall call, $async.Future<$32.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$32.SearchTagPayResponse> searchTagPay_Pre($grpc.ServiceCall call, $async.Future<$32.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$32.SendMoneyTagPayResponse> sendMoneyTagPay_Pre($grpc.ServiceCall call, $async.Future<$32.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$32.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre($grpc.ServiceCall call, $async.Future<$32.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$32.GetTagPayTransactionsResponse> getTagPayTransactions_Pre($grpc.ServiceCall call, $async.Future<$32.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$32.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre($grpc.ServiceCall call, $async.Future<$32.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$32.DeclineMoneyRequestResponse> declineMoneyRequest_Pre($grpc.ServiceCall call, $async.Future<$32.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$32.GetPendingMoneyRequestsResponse> getPendingMoneyRequests_Pre($grpc.ServiceCall call, $async.Future<$32.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$32.CreateTagResponse> createTag_Pre($grpc.ServiceCall call, $async.Future<$32.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$32.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call, $async.Future<$32.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$32.GetMyTagsResponse> getMyOutgoingTags_Pre($grpc.ServiceCall call, $async.Future<$32.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$32.GetMyTagsResponse> getMyIncomingTags_Pre($grpc.ServiceCall call, $async.Future<$32.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$32.PayTagResponse> payTag_Pre($grpc.ServiceCall call, $async.Future<$32.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$32.SearchUsersForTagResponse> searchUsers_Pre($grpc.ServiceCall call, $async.Future<$32.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$32.BatchCreateTagsResponse> batchCreateTags_Pre($grpc.ServiceCall call, $async.Future<$32.BatchCreateTagsRequest> request) async {
    return batchCreateTags(call, await request);
  }

  $async.Future<$32.CreateTagPayResponse> createTagPay($grpc.ServiceCall call, $32.CreateTagPayRequest request);
  $async.Future<$32.GetTagPayResponse> getTagPay($grpc.ServiceCall call, $32.GetTagPayRequest request);
  $async.Future<$32.CheckTagPayAvailabilityResponse> checkTagPayAvailability($grpc.ServiceCall call, $32.CheckTagPayAvailabilityRequest request);
  $async.Future<$32.SearchTagPayResponse> searchTagPay($grpc.ServiceCall call, $32.SearchTagPayRequest request);
  $async.Future<$32.SendMoneyTagPayResponse> sendMoneyTagPay($grpc.ServiceCall call, $32.SendMoneyTagPayRequest request);
  $async.Future<$32.RequestMoneyTagPayResponse> requestMoneyTagPay($grpc.ServiceCall call, $32.RequestMoneyTagPayRequest request);
  $async.Future<$32.GetTagPayTransactionsResponse> getTagPayTransactions($grpc.ServiceCall call, $32.GetTagPayTransactionsRequest request);
  $async.Future<$32.AcceptMoneyRequestResponse> acceptMoneyRequest($grpc.ServiceCall call, $32.AcceptMoneyRequestRequest request);
  $async.Future<$32.DeclineMoneyRequestResponse> declineMoneyRequest($grpc.ServiceCall call, $32.DeclineMoneyRequestRequest request);
  $async.Future<$32.GetPendingMoneyRequestsResponse> getPendingMoneyRequests($grpc.ServiceCall call, $32.GetPendingMoneyRequestsRequest request);
  $async.Future<$32.CreateTagResponse> createTag($grpc.ServiceCall call, $32.CreateTagRequest request);
  $async.Future<$32.GetMyTagsResponse> getMyTags($grpc.ServiceCall call, $32.GetMyTagsRequest request);
  $async.Future<$32.GetMyTagsResponse> getMyOutgoingTags($grpc.ServiceCall call, $32.GetMyTagsRequest request);
  $async.Future<$32.GetMyTagsResponse> getMyIncomingTags($grpc.ServiceCall call, $32.GetMyTagsRequest request);
  $async.Future<$32.PayTagResponse> payTag($grpc.ServiceCall call, $32.PayTagRequest request);
  $async.Future<$32.SearchUsersForTagResponse> searchUsers($grpc.ServiceCall call, $32.SearchUsersForTagRequest request);
  $async.Future<$32.BatchCreateTagsResponse> batchCreateTags($grpc.ServiceCall call, $32.BatchCreateTagsRequest request);
}
