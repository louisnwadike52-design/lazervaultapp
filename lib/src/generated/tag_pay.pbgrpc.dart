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

import 'tag_pay.pb.dart' as $0;

export 'tag_pay.pb.dart';

@$pb.GrpcServiceName('pb.TagPayService')
class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay = $grpc.ClientMethod<$0.CreateTagPayRequest, $0.CreateTagPayResponse>(
      '/pb.TagPayService/CreateTagPay',
      ($0.CreateTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay = $grpc.ClientMethod<$0.GetTagPayRequest, $0.GetTagPayResponse>(
      '/pb.TagPayService/GetTagPay',
      ($0.GetTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<$0.CheckTagPayAvailabilityRequest, $0.CheckTagPayAvailabilityResponse>(
      '/pb.TagPayService/CheckTagPayAvailability',
      ($0.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay = $grpc.ClientMethod<$0.SearchTagPayRequest, $0.SearchTagPayResponse>(
      '/pb.TagPayService/SearchTagPay',
      ($0.SearchTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<$0.SendMoneyTagPayRequest, $0.SendMoneyTagPayResponse>(
      '/pb.TagPayService/SendMoneyTagPay',
      ($0.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<$0.RequestMoneyTagPayRequest, $0.RequestMoneyTagPayResponse>(
      '/pb.TagPayService/RequestMoneyTagPay',
      ($0.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<$0.GetTagPayTransactionsRequest, $0.GetTagPayTransactionsResponse>(
      '/pb.TagPayService/GetTagPayTransactions',
      ($0.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<$0.AcceptMoneyRequestRequest, $0.AcceptMoneyRequestResponse>(
      '/pb.TagPayService/AcceptMoneyRequest',
      ($0.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<$0.DeclineMoneyRequestRequest, $0.DeclineMoneyRequestResponse>(
      '/pb.TagPayService/DeclineMoneyRequest',
      ($0.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<$0.GetPendingMoneyRequestsRequest, $0.GetPendingMoneyRequestsResponse>(
      '/pb.TagPayService/GetPendingMoneyRequests',
      ($0.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag = $grpc.ClientMethod<$0.CreateTagRequest, $0.CreateTagResponse>(
      '/pb.TagPayService/CreateTag',
      ($0.CreateTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags = $grpc.ClientMethod<$0.GetMyTagsRequest, $0.GetMyTagsResponse>(
      '/pb.TagPayService/GetMyTags',
      ($0.GetMyTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags = $grpc.ClientMethod<$0.GetMyTagsRequest, $0.GetMyTagsResponse>(
      '/pb.TagPayService/GetMyOutgoingTags',
      ($0.GetMyTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags = $grpc.ClientMethod<$0.GetMyTagsRequest, $0.GetMyTagsResponse>(
      '/pb.TagPayService/GetMyIncomingTags',
      ($0.GetMyTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag = $grpc.ClientMethod<$0.PayTagRequest, $0.PayTagResponse>(
      '/pb.TagPayService/PayTag',
      ($0.PayTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$0.SearchUsersForTagRequest, $0.SearchUsersForTagResponse>(
      '/pb.TagPayService/SearchUsers',
      ($0.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchUsersForTagResponse.fromBuffer(value));
  static final _$batchCreateTags = $grpc.ClientMethod<$0.BatchCreateTagsRequest, $0.BatchCreateTagsResponse>(
      '/pb.TagPayService/BatchCreateTags',
      ($0.BatchCreateTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BatchCreateTagsResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateTagPayResponse> createTagPay($0.CreateTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTagPayResponse> getTagPay($0.GetTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckTagPayAvailabilityResponse> checkTagPayAvailability($0.CheckTagPayAvailabilityRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchTagPayResponse> searchTagPay($0.SearchTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendMoneyTagPayResponse> sendMoneyTagPay($0.SendMoneyTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestMoneyTagPayResponse> requestMoneyTagPay($0.RequestMoneyTagPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTagPayTransactionsResponse> getTagPayTransactions($0.GetTagPayTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.AcceptMoneyRequestResponse> acceptMoneyRequest($0.AcceptMoneyRequestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeclineMoneyRequestResponse> declineMoneyRequest($0.DeclineMoneyRequestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPendingMoneyRequestsResponse> getPendingMoneyRequests($0.GetPendingMoneyRequestsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateTagResponse> createTag($0.CreateTagRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyTagsResponse> getMyTags($0.GetMyTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyTagsResponse> getMyOutgoingTags($0.GetMyTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyTagsResponse> getMyIncomingTags($0.GetMyTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayTagResponse> payTag($0.PayTagRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchUsersForTagResponse> searchUsers($0.SearchUsersForTagRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchCreateTagsResponse> batchCreateTags($0.BatchCreateTagsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchCreateTags, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TagPayService')
abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TagPayService';

  TagPayServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateTagPayRequest, $0.CreateTagPayResponse>(
        'CreateTagPay',
        createTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateTagPayRequest.fromBuffer(value),
        ($0.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTagPayRequest, $0.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTagPayRequest.fromBuffer(value),
        ($0.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckTagPayAvailabilityRequest, $0.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($0.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchTagPayRequest, $0.SearchTagPayResponse>(
        'SearchTagPay',
        searchTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchTagPayRequest.fromBuffer(value),
        ($0.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendMoneyTagPayRequest, $0.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendMoneyTagPayRequest.fromBuffer(value),
        ($0.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestMoneyTagPayRequest, $0.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestMoneyTagPayRequest.fromBuffer(value),
        ($0.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTagPayTransactionsRequest, $0.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTagPayTransactionsRequest.fromBuffer(value),
        ($0.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AcceptMoneyRequestRequest, $0.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AcceptMoneyRequestRequest.fromBuffer(value),
        ($0.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeclineMoneyRequestRequest, $0.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeclineMoneyRequestRequest.fromBuffer(value),
        ($0.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPendingMoneyRequestsRequest, $0.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($0.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateTagRequest, $0.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateTagRequest.fromBuffer(value),
        ($0.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyTagsRequest, $0.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyTagsRequest.fromBuffer(value),
        ($0.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyTagsRequest, $0.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyTagsRequest.fromBuffer(value),
        ($0.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyTagsRequest, $0.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyTagsRequest.fromBuffer(value),
        ($0.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayTagRequest, $0.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayTagRequest.fromBuffer(value),
        ($0.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchUsersForTagRequest, $0.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchUsersForTagRequest.fromBuffer(value),
        ($0.SearchUsersForTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchCreateTagsRequest, $0.BatchCreateTagsResponse>(
        'BatchCreateTags',
        batchCreateTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BatchCreateTagsRequest.fromBuffer(value),
        ($0.BatchCreateTagsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateTagPayResponse> createTagPay_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$0.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call, $async.Future<$0.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$0.CheckTagPayAvailabilityResponse> checkTagPayAvailability_Pre($grpc.ServiceCall call, $async.Future<$0.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$0.SearchTagPayResponse> searchTagPay_Pre($grpc.ServiceCall call, $async.Future<$0.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$0.SendMoneyTagPayResponse> sendMoneyTagPay_Pre($grpc.ServiceCall call, $async.Future<$0.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$0.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre($grpc.ServiceCall call, $async.Future<$0.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$0.GetTagPayTransactionsResponse> getTagPayTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$0.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre($grpc.ServiceCall call, $async.Future<$0.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$0.DeclineMoneyRequestResponse> declineMoneyRequest_Pre($grpc.ServiceCall call, $async.Future<$0.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$0.GetPendingMoneyRequestsResponse> getPendingMoneyRequests_Pre($grpc.ServiceCall call, $async.Future<$0.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$0.CreateTagResponse> createTag_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$0.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$0.GetMyTagsResponse> getMyOutgoingTags_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$0.GetMyTagsResponse> getMyIncomingTags_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$0.PayTagResponse> payTag_Pre($grpc.ServiceCall call, $async.Future<$0.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$0.SearchUsersForTagResponse> searchUsers_Pre($grpc.ServiceCall call, $async.Future<$0.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$0.BatchCreateTagsResponse> batchCreateTags_Pre($grpc.ServiceCall call, $async.Future<$0.BatchCreateTagsRequest> request) async {
    return batchCreateTags(call, await request);
  }

  $async.Future<$0.CreateTagPayResponse> createTagPay($grpc.ServiceCall call, $0.CreateTagPayRequest request);
  $async.Future<$0.GetTagPayResponse> getTagPay($grpc.ServiceCall call, $0.GetTagPayRequest request);
  $async.Future<$0.CheckTagPayAvailabilityResponse> checkTagPayAvailability($grpc.ServiceCall call, $0.CheckTagPayAvailabilityRequest request);
  $async.Future<$0.SearchTagPayResponse> searchTagPay($grpc.ServiceCall call, $0.SearchTagPayRequest request);
  $async.Future<$0.SendMoneyTagPayResponse> sendMoneyTagPay($grpc.ServiceCall call, $0.SendMoneyTagPayRequest request);
  $async.Future<$0.RequestMoneyTagPayResponse> requestMoneyTagPay($grpc.ServiceCall call, $0.RequestMoneyTagPayRequest request);
  $async.Future<$0.GetTagPayTransactionsResponse> getTagPayTransactions($grpc.ServiceCall call, $0.GetTagPayTransactionsRequest request);
  $async.Future<$0.AcceptMoneyRequestResponse> acceptMoneyRequest($grpc.ServiceCall call, $0.AcceptMoneyRequestRequest request);
  $async.Future<$0.DeclineMoneyRequestResponse> declineMoneyRequest($grpc.ServiceCall call, $0.DeclineMoneyRequestRequest request);
  $async.Future<$0.GetPendingMoneyRequestsResponse> getPendingMoneyRequests($grpc.ServiceCall call, $0.GetPendingMoneyRequestsRequest request);
  $async.Future<$0.CreateTagResponse> createTag($grpc.ServiceCall call, $0.CreateTagRequest request);
  $async.Future<$0.GetMyTagsResponse> getMyTags($grpc.ServiceCall call, $0.GetMyTagsRequest request);
  $async.Future<$0.GetMyTagsResponse> getMyOutgoingTags($grpc.ServiceCall call, $0.GetMyTagsRequest request);
  $async.Future<$0.GetMyTagsResponse> getMyIncomingTags($grpc.ServiceCall call, $0.GetMyTagsRequest request);
  $async.Future<$0.PayTagResponse> payTag($grpc.ServiceCall call, $0.PayTagRequest request);
  $async.Future<$0.SearchUsersForTagResponse> searchUsers($grpc.ServiceCall call, $0.SearchUsersForTagRequest request);
  $async.Future<$0.BatchCreateTagsResponse> batchCreateTags($grpc.ServiceCall call, $0.BatchCreateTagsRequest request);
}
