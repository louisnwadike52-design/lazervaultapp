///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tag_pay.pb.dart' as $19;
export 'tag_pay.pb.dart';

class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay =
      $grpc.ClientMethod<$19.CreateTagPayRequest, $19.CreateTagPayResponse>(
          '/pb.TagPayService/CreateTagPay',
          ($19.CreateTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay =
      $grpc.ClientMethod<$19.GetTagPayRequest, $19.GetTagPayResponse>(
          '/pb.TagPayService/GetTagPay',
          ($19.GetTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<
          $19.CheckTagPayAvailabilityRequest,
          $19.CheckTagPayAvailabilityResponse>(
      '/pb.TagPayService/CheckTagPayAvailability',
      ($19.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay =
      $grpc.ClientMethod<$19.SearchTagPayRequest, $19.SearchTagPayResponse>(
          '/pb.TagPayService/SearchTagPay',
          ($19.SearchTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<
          $19.SendMoneyTagPayRequest, $19.SendMoneyTagPayResponse>(
      '/pb.TagPayService/SendMoneyTagPay',
      ($19.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<
          $19.RequestMoneyTagPayRequest, $19.RequestMoneyTagPayResponse>(
      '/pb.TagPayService/RequestMoneyTagPay',
      ($19.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<
          $19.GetTagPayTransactionsRequest, $19.GetTagPayTransactionsResponse>(
      '/pb.TagPayService/GetTagPayTransactions',
      ($19.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<
          $19.AcceptMoneyRequestRequest, $19.AcceptMoneyRequestResponse>(
      '/pb.TagPayService/AcceptMoneyRequest',
      ($19.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<
          $19.DeclineMoneyRequestRequest, $19.DeclineMoneyRequestResponse>(
      '/pb.TagPayService/DeclineMoneyRequest',
      ($19.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<
          $19.GetPendingMoneyRequestsRequest,
          $19.GetPendingMoneyRequestsResponse>(
      '/pb.TagPayService/GetPendingMoneyRequests',
      ($19.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag =
      $grpc.ClientMethod<$19.CreateTagRequest, $19.CreateTagResponse>(
          '/pb.TagPayService/CreateTag',
          ($19.CreateTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags =
      $grpc.ClientMethod<$19.GetMyTagsRequest, $19.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyTags',
          ($19.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags =
      $grpc.ClientMethod<$19.GetMyTagsRequest, $19.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyOutgoingTags',
          ($19.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags =
      $grpc.ClientMethod<$19.GetMyTagsRequest, $19.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyIncomingTags',
          ($19.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag =
      $grpc.ClientMethod<$19.PayTagRequest, $19.PayTagResponse>(
          '/pb.TagPayService/PayTag',
          ($19.PayTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$19.SearchUsersForTagRequest,
          $19.SearchUsersForTagResponse>(
      '/pb.TagPayService/SearchUsers',
      ($19.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.SearchUsersForTagResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$19.CreateTagPayResponse> createTagPay(
      $19.CreateTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetTagPayResponse> getTagPay(
      $19.GetTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$19.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability($19.CheckTagPayAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.SearchTagPayResponse> searchTagPay(
      $19.SearchTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$19.SendMoneyTagPayResponse> sendMoneyTagPay(
      $19.SendMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$19.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $19.RequestMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetTagPayTransactionsResponse> getTagPayTransactions(
      $19.GetTagPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$19.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $19.AcceptMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$19.DeclineMoneyRequestResponse> declineMoneyRequest(
      $19.DeclineMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests($19.GetPendingMoneyRequestsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.CreateTagResponse> createTag(
      $19.CreateTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetMyTagsResponse> getMyTags(
      $19.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetMyTagsResponse> getMyOutgoingTags(
      $19.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetMyTagsResponse> getMyIncomingTags(
      $19.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$19.PayTagResponse> payTag($19.PayTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$19.SearchUsersForTagResponse> searchUsers(
      $19.SearchUsersForTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }
}

abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TagPayService';

  TagPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$19.CreateTagPayRequest, $19.CreateTagPayResponse>(
            'CreateTagPay',
            createTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.CreateTagPayRequest.fromBuffer(value),
            ($19.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetTagPayRequest, $19.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetTagPayRequest.fromBuffer(value),
        ($19.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CheckTagPayAvailabilityRequest,
            $19.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($19.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.SearchTagPayRequest, $19.SearchTagPayResponse>(
            'SearchTagPay',
            searchTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.SearchTagPayRequest.fromBuffer(value),
            ($19.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.SendMoneyTagPayRequest,
            $19.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.SendMoneyTagPayRequest.fromBuffer(value),
        ($19.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.RequestMoneyTagPayRequest,
            $19.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.RequestMoneyTagPayRequest.fromBuffer(value),
        ($19.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetTagPayTransactionsRequest,
            $19.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetTagPayTransactionsRequest.fromBuffer(value),
        ($19.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.AcceptMoneyRequestRequest,
            $19.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.AcceptMoneyRequestRequest.fromBuffer(value),
        ($19.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeclineMoneyRequestRequest,
            $19.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeclineMoneyRequestRequest.fromBuffer(value),
        ($19.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetPendingMoneyRequestsRequest,
            $19.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($19.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateTagRequest, $19.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.CreateTagRequest.fromBuffer(value),
        ($19.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyTagsRequest, $19.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetMyTagsRequest.fromBuffer(value),
        ($19.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyTagsRequest, $19.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetMyTagsRequest.fromBuffer(value),
        ($19.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyTagsRequest, $19.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetMyTagsRequest.fromBuffer(value),
        ($19.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.PayTagRequest, $19.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.PayTagRequest.fromBuffer(value),
        ($19.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.SearchUsersForTagRequest,
            $19.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.SearchUsersForTagRequest.fromBuffer(value),
        ($19.SearchUsersForTagResponse value) => value.writeToBuffer()));
  }

  $async.Future<$19.CreateTagPayResponse> createTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$19.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$19.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability_Pre($grpc.ServiceCall call,
          $async.Future<$19.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$19.SearchTagPayResponse> searchTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$19.SendMoneyTagPayResponse> sendMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$19.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$19.GetTagPayTransactionsResponse> getTagPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$19.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$19.DeclineMoneyRequestResponse> declineMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$19.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$19.CreateTagResponse> createTag_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$19.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$19.GetMyTagsResponse> getMyOutgoingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$19.GetMyTagsResponse> getMyIncomingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$19.PayTagResponse> payTag_Pre(
      $grpc.ServiceCall call, $async.Future<$19.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$19.SearchUsersForTagResponse> searchUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$19.CreateTagPayResponse> createTagPay(
      $grpc.ServiceCall call, $19.CreateTagPayRequest request);
  $async.Future<$19.GetTagPayResponse> getTagPay(
      $grpc.ServiceCall call, $19.GetTagPayRequest request);
  $async.Future<$19.CheckTagPayAvailabilityResponse> checkTagPayAvailability(
      $grpc.ServiceCall call, $19.CheckTagPayAvailabilityRequest request);
  $async.Future<$19.SearchTagPayResponse> searchTagPay(
      $grpc.ServiceCall call, $19.SearchTagPayRequest request);
  $async.Future<$19.SendMoneyTagPayResponse> sendMoneyTagPay(
      $grpc.ServiceCall call, $19.SendMoneyTagPayRequest request);
  $async.Future<$19.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $grpc.ServiceCall call, $19.RequestMoneyTagPayRequest request);
  $async.Future<$19.GetTagPayTransactionsResponse> getTagPayTransactions(
      $grpc.ServiceCall call, $19.GetTagPayTransactionsRequest request);
  $async.Future<$19.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $grpc.ServiceCall call, $19.AcceptMoneyRequestRequest request);
  $async.Future<$19.DeclineMoneyRequestResponse> declineMoneyRequest(
      $grpc.ServiceCall call, $19.DeclineMoneyRequestRequest request);
  $async.Future<$19.GetPendingMoneyRequestsResponse> getPendingMoneyRequests(
      $grpc.ServiceCall call, $19.GetPendingMoneyRequestsRequest request);
  $async.Future<$19.CreateTagResponse> createTag(
      $grpc.ServiceCall call, $19.CreateTagRequest request);
  $async.Future<$19.GetMyTagsResponse> getMyTags(
      $grpc.ServiceCall call, $19.GetMyTagsRequest request);
  $async.Future<$19.GetMyTagsResponse> getMyOutgoingTags(
      $grpc.ServiceCall call, $19.GetMyTagsRequest request);
  $async.Future<$19.GetMyTagsResponse> getMyIncomingTags(
      $grpc.ServiceCall call, $19.GetMyTagsRequest request);
  $async.Future<$19.PayTagResponse> payTag(
      $grpc.ServiceCall call, $19.PayTagRequest request);
  $async.Future<$19.SearchUsersForTagResponse> searchUsers(
      $grpc.ServiceCall call, $19.SearchUsersForTagRequest request);
}
