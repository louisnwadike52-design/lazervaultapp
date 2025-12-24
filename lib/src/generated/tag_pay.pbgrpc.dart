///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tag_pay.pb.dart' as $20;
export 'tag_pay.pb.dart';

class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay =
      $grpc.ClientMethod<$20.CreateTagPayRequest, $20.CreateTagPayResponse>(
          '/pb.TagPayService/CreateTagPay',
          ($20.CreateTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay =
      $grpc.ClientMethod<$20.GetTagPayRequest, $20.GetTagPayResponse>(
          '/pb.TagPayService/GetTagPay',
          ($20.GetTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<
          $20.CheckTagPayAvailabilityRequest,
          $20.CheckTagPayAvailabilityResponse>(
      '/pb.TagPayService/CheckTagPayAvailability',
      ($20.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay =
      $grpc.ClientMethod<$20.SearchTagPayRequest, $20.SearchTagPayResponse>(
          '/pb.TagPayService/SearchTagPay',
          ($20.SearchTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<
          $20.SendMoneyTagPayRequest, $20.SendMoneyTagPayResponse>(
      '/pb.TagPayService/SendMoneyTagPay',
      ($20.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<
          $20.RequestMoneyTagPayRequest, $20.RequestMoneyTagPayResponse>(
      '/pb.TagPayService/RequestMoneyTagPay',
      ($20.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<
          $20.GetTagPayTransactionsRequest, $20.GetTagPayTransactionsResponse>(
      '/pb.TagPayService/GetTagPayTransactions',
      ($20.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<
          $20.AcceptMoneyRequestRequest, $20.AcceptMoneyRequestResponse>(
      '/pb.TagPayService/AcceptMoneyRequest',
      ($20.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<
          $20.DeclineMoneyRequestRequest, $20.DeclineMoneyRequestResponse>(
      '/pb.TagPayService/DeclineMoneyRequest',
      ($20.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<
          $20.GetPendingMoneyRequestsRequest,
          $20.GetPendingMoneyRequestsResponse>(
      '/pb.TagPayService/GetPendingMoneyRequests',
      ($20.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag =
      $grpc.ClientMethod<$20.CreateTagRequest, $20.CreateTagResponse>(
          '/pb.TagPayService/CreateTag',
          ($20.CreateTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags =
      $grpc.ClientMethod<$20.GetMyTagsRequest, $20.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyTags',
          ($20.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags =
      $grpc.ClientMethod<$20.GetMyTagsRequest, $20.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyOutgoingTags',
          ($20.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags =
      $grpc.ClientMethod<$20.GetMyTagsRequest, $20.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyIncomingTags',
          ($20.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag =
      $grpc.ClientMethod<$20.PayTagRequest, $20.PayTagResponse>(
          '/pb.TagPayService/PayTag',
          ($20.PayTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$20.SearchUsersForTagRequest,
          $20.SearchUsersForTagResponse>(
      '/pb.TagPayService/SearchUsers',
      ($20.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.SearchUsersForTagResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$20.CreateTagPayResponse> createTagPay(
      $20.CreateTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetTagPayResponse> getTagPay(
      $20.GetTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$20.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability($20.CheckTagPayAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.SearchTagPayResponse> searchTagPay(
      $20.SearchTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$20.SendMoneyTagPayResponse> sendMoneyTagPay(
      $20.SendMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$20.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $20.RequestMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetTagPayTransactionsResponse> getTagPayTransactions(
      $20.GetTagPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$20.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $20.AcceptMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$20.DeclineMoneyRequestResponse> declineMoneyRequest(
      $20.DeclineMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests($20.GetPendingMoneyRequestsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.CreateTagResponse> createTag(
      $20.CreateTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetMyTagsResponse> getMyTags(
      $20.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetMyTagsResponse> getMyOutgoingTags(
      $20.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetMyTagsResponse> getMyIncomingTags(
      $20.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$20.PayTagResponse> payTag($20.PayTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$20.SearchUsersForTagResponse> searchUsers(
      $20.SearchUsersForTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }
}

abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TagPayService';

  TagPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$20.CreateTagPayRequest, $20.CreateTagPayResponse>(
            'CreateTagPay',
            createTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.CreateTagPayRequest.fromBuffer(value),
            ($20.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetTagPayRequest, $20.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetTagPayRequest.fromBuffer(value),
        ($20.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.CheckTagPayAvailabilityRequest,
            $20.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($20.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$20.SearchTagPayRequest, $20.SearchTagPayResponse>(
            'SearchTagPay',
            searchTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $20.SearchTagPayRequest.fromBuffer(value),
            ($20.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.SendMoneyTagPayRequest,
            $20.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.SendMoneyTagPayRequest.fromBuffer(value),
        ($20.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.RequestMoneyTagPayRequest,
            $20.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.RequestMoneyTagPayRequest.fromBuffer(value),
        ($20.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetTagPayTransactionsRequest,
            $20.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetTagPayTransactionsRequest.fromBuffer(value),
        ($20.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AcceptMoneyRequestRequest,
            $20.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AcceptMoneyRequestRequest.fromBuffer(value),
        ($20.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.DeclineMoneyRequestRequest,
            $20.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.DeclineMoneyRequestRequest.fromBuffer(value),
        ($20.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetPendingMoneyRequestsRequest,
            $20.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($20.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.CreateTagRequest, $20.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.CreateTagRequest.fromBuffer(value),
        ($20.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetMyTagsRequest, $20.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetMyTagsRequest.fromBuffer(value),
        ($20.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetMyTagsRequest, $20.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetMyTagsRequest.fromBuffer(value),
        ($20.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetMyTagsRequest, $20.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.GetMyTagsRequest.fromBuffer(value),
        ($20.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.PayTagRequest, $20.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $20.PayTagRequest.fromBuffer(value),
        ($20.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.SearchUsersForTagRequest,
            $20.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.SearchUsersForTagRequest.fromBuffer(value),
        ($20.SearchUsersForTagResponse value) => value.writeToBuffer()));
  }

  $async.Future<$20.CreateTagPayResponse> createTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$20.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$20.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability_Pre($grpc.ServiceCall call,
          $async.Future<$20.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$20.SearchTagPayResponse> searchTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$20.SendMoneyTagPayResponse> sendMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$20.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$20.GetTagPayTransactionsResponse> getTagPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$20.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$20.DeclineMoneyRequestResponse> declineMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$20.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests_Pre($grpc.ServiceCall call,
          $async.Future<$20.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$20.CreateTagResponse> createTag_Pre($grpc.ServiceCall call,
      $async.Future<$20.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$20.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$20.GetMyTagsResponse> getMyOutgoingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$20.GetMyTagsResponse> getMyIncomingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$20.PayTagResponse> payTag_Pre(
      $grpc.ServiceCall call, $async.Future<$20.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$20.SearchUsersForTagResponse> searchUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$20.CreateTagPayResponse> createTagPay(
      $grpc.ServiceCall call, $20.CreateTagPayRequest request);
  $async.Future<$20.GetTagPayResponse> getTagPay(
      $grpc.ServiceCall call, $20.GetTagPayRequest request);
  $async.Future<$20.CheckTagPayAvailabilityResponse> checkTagPayAvailability(
      $grpc.ServiceCall call, $20.CheckTagPayAvailabilityRequest request);
  $async.Future<$20.SearchTagPayResponse> searchTagPay(
      $grpc.ServiceCall call, $20.SearchTagPayRequest request);
  $async.Future<$20.SendMoneyTagPayResponse> sendMoneyTagPay(
      $grpc.ServiceCall call, $20.SendMoneyTagPayRequest request);
  $async.Future<$20.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $grpc.ServiceCall call, $20.RequestMoneyTagPayRequest request);
  $async.Future<$20.GetTagPayTransactionsResponse> getTagPayTransactions(
      $grpc.ServiceCall call, $20.GetTagPayTransactionsRequest request);
  $async.Future<$20.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $grpc.ServiceCall call, $20.AcceptMoneyRequestRequest request);
  $async.Future<$20.DeclineMoneyRequestResponse> declineMoneyRequest(
      $grpc.ServiceCall call, $20.DeclineMoneyRequestRequest request);
  $async.Future<$20.GetPendingMoneyRequestsResponse> getPendingMoneyRequests(
      $grpc.ServiceCall call, $20.GetPendingMoneyRequestsRequest request);
  $async.Future<$20.CreateTagResponse> createTag(
      $grpc.ServiceCall call, $20.CreateTagRequest request);
  $async.Future<$20.GetMyTagsResponse> getMyTags(
      $grpc.ServiceCall call, $20.GetMyTagsRequest request);
  $async.Future<$20.GetMyTagsResponse> getMyOutgoingTags(
      $grpc.ServiceCall call, $20.GetMyTagsRequest request);
  $async.Future<$20.GetMyTagsResponse> getMyIncomingTags(
      $grpc.ServiceCall call, $20.GetMyTagsRequest request);
  $async.Future<$20.PayTagResponse> payTag(
      $grpc.ServiceCall call, $20.PayTagRequest request);
  $async.Future<$20.SearchUsersForTagResponse> searchUsers(
      $grpc.ServiceCall call, $20.SearchUsersForTagRequest request);
}
