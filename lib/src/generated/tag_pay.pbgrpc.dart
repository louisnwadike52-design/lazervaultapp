///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tag_pay.pb.dart' as $36;
export 'tag_pay.pb.dart';

class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay =
      $grpc.ClientMethod<$36.CreateTagPayRequest, $36.CreateTagPayResponse>(
          '/tag_pay.TagPayService/CreateTagPay',
          ($36.CreateTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay =
      $grpc.ClientMethod<$36.GetTagPayRequest, $36.GetTagPayResponse>(
          '/tag_pay.TagPayService/GetTagPay',
          ($36.GetTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<
          $36.CheckTagPayAvailabilityRequest,
          $36.CheckTagPayAvailabilityResponse>(
      '/tag_pay.TagPayService/CheckTagPayAvailability',
      ($36.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay =
      $grpc.ClientMethod<$36.SearchTagPayRequest, $36.SearchTagPayResponse>(
          '/tag_pay.TagPayService/SearchTagPay',
          ($36.SearchTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<
          $36.SendMoneyTagPayRequest, $36.SendMoneyTagPayResponse>(
      '/tag_pay.TagPayService/SendMoneyTagPay',
      ($36.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<
          $36.RequestMoneyTagPayRequest, $36.RequestMoneyTagPayResponse>(
      '/tag_pay.TagPayService/RequestMoneyTagPay',
      ($36.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<
          $36.GetTagPayTransactionsRequest, $36.GetTagPayTransactionsResponse>(
      '/tag_pay.TagPayService/GetTagPayTransactions',
      ($36.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<
          $36.AcceptMoneyRequestRequest, $36.AcceptMoneyRequestResponse>(
      '/tag_pay.TagPayService/AcceptMoneyRequest',
      ($36.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<
          $36.DeclineMoneyRequestRequest, $36.DeclineMoneyRequestResponse>(
      '/tag_pay.TagPayService/DeclineMoneyRequest',
      ($36.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<
          $36.GetPendingMoneyRequestsRequest,
          $36.GetPendingMoneyRequestsResponse>(
      '/tag_pay.TagPayService/GetPendingMoneyRequests',
      ($36.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag =
      $grpc.ClientMethod<$36.CreateTagRequest, $36.CreateTagResponse>(
          '/tag_pay.TagPayService/CreateTag',
          ($36.CreateTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags =
      $grpc.ClientMethod<$36.GetMyTagsRequest, $36.GetMyTagsResponse>(
          '/tag_pay.TagPayService/GetMyTags',
          ($36.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags =
      $grpc.ClientMethod<$36.GetMyTagsRequest, $36.GetMyTagsResponse>(
          '/tag_pay.TagPayService/GetMyOutgoingTags',
          ($36.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags =
      $grpc.ClientMethod<$36.GetMyTagsRequest, $36.GetMyTagsResponse>(
          '/tag_pay.TagPayService/GetMyIncomingTags',
          ($36.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag =
      $grpc.ClientMethod<$36.PayTagRequest, $36.PayTagResponse>(
          '/tag_pay.TagPayService/PayTag',
          ($36.PayTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$36.SearchUsersForTagRequest,
          $36.SearchUsersForTagResponse>(
      '/tag_pay.TagPayService/SearchUsers',
      ($36.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.SearchUsersForTagResponse.fromBuffer(value));
  static final _$batchCreateTags = $grpc.ClientMethod<
          $36.BatchCreateTagsRequest, $36.BatchCreateTagsResponse>(
      '/tag_pay.TagPayService/BatchCreateTags',
      ($36.BatchCreateTagsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.BatchCreateTagsResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$36.CreateTagPayResponse> createTagPay(
      $36.CreateTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetTagPayResponse> getTagPay(
      $36.GetTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$36.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability($36.CheckTagPayAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$36.SearchTagPayResponse> searchTagPay(
      $36.SearchTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$36.SendMoneyTagPayResponse> sendMoneyTagPay(
      $36.SendMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$36.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $36.RequestMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetTagPayTransactionsResponse> getTagPayTransactions(
      $36.GetTagPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$36.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $36.AcceptMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$36.DeclineMoneyRequestResponse> declineMoneyRequest(
      $36.DeclineMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests($36.GetPendingMoneyRequestsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request,
        options: options);
  }

  $grpc.ResponseFuture<$36.CreateTagResponse> createTag(
      $36.CreateTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetMyTagsResponse> getMyTags(
      $36.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetMyTagsResponse> getMyOutgoingTags(
      $36.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetMyTagsResponse> getMyIncomingTags(
      $36.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$36.PayTagResponse> payTag($36.PayTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$36.SearchUsersForTagResponse> searchUsers(
      $36.SearchUsersForTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$36.BatchCreateTagsResponse> batchCreateTags(
      $36.BatchCreateTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchCreateTags, request, options: options);
  }
}

abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'tag_pay.TagPayService';

  TagPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$36.CreateTagPayRequest, $36.CreateTagPayResponse>(
            'CreateTagPay',
            createTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $36.CreateTagPayRequest.fromBuffer(value),
            ($36.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetTagPayRequest, $36.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $36.GetTagPayRequest.fromBuffer(value),
        ($36.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.CheckTagPayAvailabilityRequest,
            $36.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($36.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$36.SearchTagPayRequest, $36.SearchTagPayResponse>(
            'SearchTagPay',
            searchTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $36.SearchTagPayRequest.fromBuffer(value),
            ($36.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.SendMoneyTagPayRequest,
            $36.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.SendMoneyTagPayRequest.fromBuffer(value),
        ($36.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.RequestMoneyTagPayRequest,
            $36.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.RequestMoneyTagPayRequest.fromBuffer(value),
        ($36.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetTagPayTransactionsRequest,
            $36.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.GetTagPayTransactionsRequest.fromBuffer(value),
        ($36.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.AcceptMoneyRequestRequest,
            $36.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.AcceptMoneyRequestRequest.fromBuffer(value),
        ($36.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.DeclineMoneyRequestRequest,
            $36.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.DeclineMoneyRequestRequest.fromBuffer(value),
        ($36.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetPendingMoneyRequestsRequest,
            $36.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($36.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.CreateTagRequest, $36.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $36.CreateTagRequest.fromBuffer(value),
        ($36.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetMyTagsRequest, $36.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $36.GetMyTagsRequest.fromBuffer(value),
        ($36.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetMyTagsRequest, $36.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $36.GetMyTagsRequest.fromBuffer(value),
        ($36.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetMyTagsRequest, $36.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $36.GetMyTagsRequest.fromBuffer(value),
        ($36.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.PayTagRequest, $36.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $36.PayTagRequest.fromBuffer(value),
        ($36.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.SearchUsersForTagRequest,
            $36.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.SearchUsersForTagRequest.fromBuffer(value),
        ($36.SearchUsersForTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.BatchCreateTagsRequest,
            $36.BatchCreateTagsResponse>(
        'BatchCreateTags',
        batchCreateTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.BatchCreateTagsRequest.fromBuffer(value),
        ($36.BatchCreateTagsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$36.CreateTagPayResponse> createTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$36.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call,
      $async.Future<$36.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$36.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability_Pre($grpc.ServiceCall call,
          $async.Future<$36.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$36.SearchTagPayResponse> searchTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$36.SendMoneyTagPayResponse> sendMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$36.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$36.GetTagPayTransactionsResponse> getTagPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$36.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$36.DeclineMoneyRequestResponse> declineMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$36.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests_Pre($grpc.ServiceCall call,
          $async.Future<$36.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$36.CreateTagResponse> createTag_Pre($grpc.ServiceCall call,
      $async.Future<$36.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$36.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call,
      $async.Future<$36.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$36.GetMyTagsResponse> getMyOutgoingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$36.GetMyTagsResponse> getMyIncomingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$36.PayTagResponse> payTag_Pre(
      $grpc.ServiceCall call, $async.Future<$36.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$36.SearchUsersForTagResponse> searchUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$36.BatchCreateTagsResponse> batchCreateTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.BatchCreateTagsRequest> request) async {
    return batchCreateTags(call, await request);
  }

  $async.Future<$36.CreateTagPayResponse> createTagPay(
      $grpc.ServiceCall call, $36.CreateTagPayRequest request);
  $async.Future<$36.GetTagPayResponse> getTagPay(
      $grpc.ServiceCall call, $36.GetTagPayRequest request);
  $async.Future<$36.CheckTagPayAvailabilityResponse> checkTagPayAvailability(
      $grpc.ServiceCall call, $36.CheckTagPayAvailabilityRequest request);
  $async.Future<$36.SearchTagPayResponse> searchTagPay(
      $grpc.ServiceCall call, $36.SearchTagPayRequest request);
  $async.Future<$36.SendMoneyTagPayResponse> sendMoneyTagPay(
      $grpc.ServiceCall call, $36.SendMoneyTagPayRequest request);
  $async.Future<$36.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $grpc.ServiceCall call, $36.RequestMoneyTagPayRequest request);
  $async.Future<$36.GetTagPayTransactionsResponse> getTagPayTransactions(
      $grpc.ServiceCall call, $36.GetTagPayTransactionsRequest request);
  $async.Future<$36.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $grpc.ServiceCall call, $36.AcceptMoneyRequestRequest request);
  $async.Future<$36.DeclineMoneyRequestResponse> declineMoneyRequest(
      $grpc.ServiceCall call, $36.DeclineMoneyRequestRequest request);
  $async.Future<$36.GetPendingMoneyRequestsResponse> getPendingMoneyRequests(
      $grpc.ServiceCall call, $36.GetPendingMoneyRequestsRequest request);
  $async.Future<$36.CreateTagResponse> createTag(
      $grpc.ServiceCall call, $36.CreateTagRequest request);
  $async.Future<$36.GetMyTagsResponse> getMyTags(
      $grpc.ServiceCall call, $36.GetMyTagsRequest request);
  $async.Future<$36.GetMyTagsResponse> getMyOutgoingTags(
      $grpc.ServiceCall call, $36.GetMyTagsRequest request);
  $async.Future<$36.GetMyTagsResponse> getMyIncomingTags(
      $grpc.ServiceCall call, $36.GetMyTagsRequest request);
  $async.Future<$36.PayTagResponse> payTag(
      $grpc.ServiceCall call, $36.PayTagRequest request);
  $async.Future<$36.SearchUsersForTagResponse> searchUsers(
      $grpc.ServiceCall call, $36.SearchUsersForTagRequest request);
  $async.Future<$36.BatchCreateTagsResponse> batchCreateTags(
      $grpc.ServiceCall call, $36.BatchCreateTagsRequest request);
}
