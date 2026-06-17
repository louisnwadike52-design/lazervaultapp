///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tag_pay.pb.dart' as $37;
export 'tag_pay.pb.dart';

class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay =
      $grpc.ClientMethod<$37.CreateTagPayRequest, $37.CreateTagPayResponse>(
          '/tag_pay.TagPayService/CreateTagPay',
          ($37.CreateTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay =
      $grpc.ClientMethod<$37.GetTagPayRequest, $37.GetTagPayResponse>(
          '/tag_pay.TagPayService/GetTagPay',
          ($37.GetTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<
          $37.CheckTagPayAvailabilityRequest,
          $37.CheckTagPayAvailabilityResponse>(
      '/tag_pay.TagPayService/CheckTagPayAvailability',
      ($37.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay =
      $grpc.ClientMethod<$37.SearchTagPayRequest, $37.SearchTagPayResponse>(
          '/tag_pay.TagPayService/SearchTagPay',
          ($37.SearchTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<
          $37.SendMoneyTagPayRequest, $37.SendMoneyTagPayResponse>(
      '/tag_pay.TagPayService/SendMoneyTagPay',
      ($37.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<
          $37.RequestMoneyTagPayRequest, $37.RequestMoneyTagPayResponse>(
      '/tag_pay.TagPayService/RequestMoneyTagPay',
      ($37.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<
          $37.GetTagPayTransactionsRequest, $37.GetTagPayTransactionsResponse>(
      '/tag_pay.TagPayService/GetTagPayTransactions',
      ($37.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<
          $37.AcceptMoneyRequestRequest, $37.AcceptMoneyRequestResponse>(
      '/tag_pay.TagPayService/AcceptMoneyRequest',
      ($37.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<
          $37.DeclineMoneyRequestRequest, $37.DeclineMoneyRequestResponse>(
      '/tag_pay.TagPayService/DeclineMoneyRequest',
      ($37.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<
          $37.GetPendingMoneyRequestsRequest,
          $37.GetPendingMoneyRequestsResponse>(
      '/tag_pay.TagPayService/GetPendingMoneyRequests',
      ($37.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag =
      $grpc.ClientMethod<$37.CreateTagRequest, $37.CreateTagResponse>(
          '/tag_pay.TagPayService/CreateTag',
          ($37.CreateTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags =
      $grpc.ClientMethod<$37.GetMyTagsRequest, $37.GetMyTagsResponse>(
          '/tag_pay.TagPayService/GetMyTags',
          ($37.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags =
      $grpc.ClientMethod<$37.GetMyTagsRequest, $37.GetMyTagsResponse>(
          '/tag_pay.TagPayService/GetMyOutgoingTags',
          ($37.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags =
      $grpc.ClientMethod<$37.GetMyTagsRequest, $37.GetMyTagsResponse>(
          '/tag_pay.TagPayService/GetMyIncomingTags',
          ($37.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag =
      $grpc.ClientMethod<$37.PayTagRequest, $37.PayTagResponse>(
          '/tag_pay.TagPayService/PayTag',
          ($37.PayTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$37.SearchUsersForTagRequest,
          $37.SearchUsersForTagResponse>(
      '/tag_pay.TagPayService/SearchUsers',
      ($37.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.SearchUsersForTagResponse.fromBuffer(value));
  static final _$batchCreateTags = $grpc.ClientMethod<
          $37.BatchCreateTagsRequest, $37.BatchCreateTagsResponse>(
      '/tag_pay.TagPayService/BatchCreateTags',
      ($37.BatchCreateTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.BatchCreateTagsResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$37.CreateTagPayResponse> createTagPay(
      $37.CreateTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetTagPayResponse> getTagPay(
      $37.GetTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$37.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability($37.CheckTagPayAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.SearchTagPayResponse> searchTagPay(
      $37.SearchTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$37.SendMoneyTagPayResponse> sendMoneyTagPay(
      $37.SendMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$37.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $37.RequestMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetTagPayTransactionsResponse> getTagPayTransactions(
      $37.GetTagPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$37.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $37.AcceptMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$37.DeclineMoneyRequestResponse> declineMoneyRequest(
      $37.DeclineMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests($37.GetPendingMoneyRequestsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.CreateTagResponse> createTag(
      $37.CreateTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetMyTagsResponse> getMyTags(
      $37.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetMyTagsResponse> getMyOutgoingTags(
      $37.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetMyTagsResponse> getMyIncomingTags(
      $37.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$37.PayTagResponse> payTag($37.PayTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$37.SearchUsersForTagResponse> searchUsers(
      $37.SearchUsersForTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$37.BatchCreateTagsResponse> batchCreateTags(
      $37.BatchCreateTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchCreateTags, request, options: options);
  }
}

abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'tag_pay.TagPayService';

  TagPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$37.CreateTagPayRequest, $37.CreateTagPayResponse>(
            'CreateTagPay',
            createTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $37.CreateTagPayRequest.fromBuffer(value),
            ($37.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetTagPayRequest, $37.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetTagPayRequest.fromBuffer(value),
        ($37.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.CheckTagPayAvailabilityRequest,
            $37.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($37.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$37.SearchTagPayRequest, $37.SearchTagPayResponse>(
            'SearchTagPay',
            searchTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $37.SearchTagPayRequest.fromBuffer(value),
            ($37.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.SendMoneyTagPayRequest,
            $37.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.SendMoneyTagPayRequest.fromBuffer(value),
        ($37.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.RequestMoneyTagPayRequest,
            $37.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.RequestMoneyTagPayRequest.fromBuffer(value),
        ($37.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetTagPayTransactionsRequest,
            $37.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetTagPayTransactionsRequest.fromBuffer(value),
        ($37.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.AcceptMoneyRequestRequest,
            $37.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.AcceptMoneyRequestRequest.fromBuffer(value),
        ($37.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.DeclineMoneyRequestRequest,
            $37.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.DeclineMoneyRequestRequest.fromBuffer(value),
        ($37.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetPendingMoneyRequestsRequest,
            $37.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($37.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.CreateTagRequest, $37.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.CreateTagRequest.fromBuffer(value),
        ($37.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetMyTagsRequest, $37.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetMyTagsRequest.fromBuffer(value),
        ($37.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetMyTagsRequest, $37.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetMyTagsRequest.fromBuffer(value),
        ($37.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetMyTagsRequest, $37.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetMyTagsRequest.fromBuffer(value),
        ($37.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.PayTagRequest, $37.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.PayTagRequest.fromBuffer(value),
        ($37.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.SearchUsersForTagRequest,
            $37.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.SearchUsersForTagRequest.fromBuffer(value),
        ($37.SearchUsersForTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.BatchCreateTagsRequest,
            $37.BatchCreateTagsResponse>(
        'BatchCreateTags',
        batchCreateTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.BatchCreateTagsRequest.fromBuffer(value),
        ($37.BatchCreateTagsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$37.CreateTagPayResponse> createTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$37.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call,
      $async.Future<$37.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$37.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability_Pre($grpc.ServiceCall call,
          $async.Future<$37.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$37.SearchTagPayResponse> searchTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$37.SendMoneyTagPayResponse> sendMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$37.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$37.GetTagPayTransactionsResponse> getTagPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$37.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$37.DeclineMoneyRequestResponse> declineMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$37.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests_Pre($grpc.ServiceCall call,
          $async.Future<$37.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$37.CreateTagResponse> createTag_Pre($grpc.ServiceCall call,
      $async.Future<$37.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$37.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call,
      $async.Future<$37.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$37.GetMyTagsResponse> getMyOutgoingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$37.GetMyTagsResponse> getMyIncomingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$37.PayTagResponse> payTag_Pre(
      $grpc.ServiceCall call, $async.Future<$37.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$37.SearchUsersForTagResponse> searchUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$37.BatchCreateTagsResponse> batchCreateTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.BatchCreateTagsRequest> request) async {
    return batchCreateTags(call, await request);
  }

  $async.Future<$37.CreateTagPayResponse> createTagPay(
      $grpc.ServiceCall call, $37.CreateTagPayRequest request);
  $async.Future<$37.GetTagPayResponse> getTagPay(
      $grpc.ServiceCall call, $37.GetTagPayRequest request);
  $async.Future<$37.CheckTagPayAvailabilityResponse> checkTagPayAvailability(
      $grpc.ServiceCall call, $37.CheckTagPayAvailabilityRequest request);
  $async.Future<$37.SearchTagPayResponse> searchTagPay(
      $grpc.ServiceCall call, $37.SearchTagPayRequest request);
  $async.Future<$37.SendMoneyTagPayResponse> sendMoneyTagPay(
      $grpc.ServiceCall call, $37.SendMoneyTagPayRequest request);
  $async.Future<$37.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $grpc.ServiceCall call, $37.RequestMoneyTagPayRequest request);
  $async.Future<$37.GetTagPayTransactionsResponse> getTagPayTransactions(
      $grpc.ServiceCall call, $37.GetTagPayTransactionsRequest request);
  $async.Future<$37.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $grpc.ServiceCall call, $37.AcceptMoneyRequestRequest request);
  $async.Future<$37.DeclineMoneyRequestResponse> declineMoneyRequest(
      $grpc.ServiceCall call, $37.DeclineMoneyRequestRequest request);
  $async.Future<$37.GetPendingMoneyRequestsResponse> getPendingMoneyRequests(
      $grpc.ServiceCall call, $37.GetPendingMoneyRequestsRequest request);
  $async.Future<$37.CreateTagResponse> createTag(
      $grpc.ServiceCall call, $37.CreateTagRequest request);
  $async.Future<$37.GetMyTagsResponse> getMyTags(
      $grpc.ServiceCall call, $37.GetMyTagsRequest request);
  $async.Future<$37.GetMyTagsResponse> getMyOutgoingTags(
      $grpc.ServiceCall call, $37.GetMyTagsRequest request);
  $async.Future<$37.GetMyTagsResponse> getMyIncomingTags(
      $grpc.ServiceCall call, $37.GetMyTagsRequest request);
  $async.Future<$37.PayTagResponse> payTag(
      $grpc.ServiceCall call, $37.PayTagRequest request);
  $async.Future<$37.SearchUsersForTagResponse> searchUsers(
      $grpc.ServiceCall call, $37.SearchUsersForTagRequest request);
  $async.Future<$37.BatchCreateTagsResponse> batchCreateTags(
      $grpc.ServiceCall call, $37.BatchCreateTagsRequest request);
}
