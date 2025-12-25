///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tag_pay.pb.dart' as $21;
export 'tag_pay.pb.dart';

class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay =
      $grpc.ClientMethod<$21.CreateTagPayRequest, $21.CreateTagPayResponse>(
          '/pb.TagPayService/CreateTagPay',
          ($21.CreateTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay =
      $grpc.ClientMethod<$21.GetTagPayRequest, $21.GetTagPayResponse>(
          '/pb.TagPayService/GetTagPay',
          ($21.GetTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<
          $21.CheckTagPayAvailabilityRequest,
          $21.CheckTagPayAvailabilityResponse>(
      '/pb.TagPayService/CheckTagPayAvailability',
      ($21.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay =
      $grpc.ClientMethod<$21.SearchTagPayRequest, $21.SearchTagPayResponse>(
          '/pb.TagPayService/SearchTagPay',
          ($21.SearchTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<
          $21.SendMoneyTagPayRequest, $21.SendMoneyTagPayResponse>(
      '/pb.TagPayService/SendMoneyTagPay',
      ($21.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<
          $21.RequestMoneyTagPayRequest, $21.RequestMoneyTagPayResponse>(
      '/pb.TagPayService/RequestMoneyTagPay',
      ($21.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<
          $21.GetTagPayTransactionsRequest, $21.GetTagPayTransactionsResponse>(
      '/pb.TagPayService/GetTagPayTransactions',
      ($21.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<
          $21.AcceptMoneyRequestRequest, $21.AcceptMoneyRequestResponse>(
      '/pb.TagPayService/AcceptMoneyRequest',
      ($21.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<
          $21.DeclineMoneyRequestRequest, $21.DeclineMoneyRequestResponse>(
      '/pb.TagPayService/DeclineMoneyRequest',
      ($21.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<
          $21.GetPendingMoneyRequestsRequest,
          $21.GetPendingMoneyRequestsResponse>(
      '/pb.TagPayService/GetPendingMoneyRequests',
      ($21.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag =
      $grpc.ClientMethod<$21.CreateTagRequest, $21.CreateTagResponse>(
          '/pb.TagPayService/CreateTag',
          ($21.CreateTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags =
      $grpc.ClientMethod<$21.GetMyTagsRequest, $21.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyTags',
          ($21.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags =
      $grpc.ClientMethod<$21.GetMyTagsRequest, $21.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyOutgoingTags',
          ($21.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags =
      $grpc.ClientMethod<$21.GetMyTagsRequest, $21.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyIncomingTags',
          ($21.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag =
      $grpc.ClientMethod<$21.PayTagRequest, $21.PayTagResponse>(
          '/pb.TagPayService/PayTag',
          ($21.PayTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$21.SearchUsersForTagRequest,
          $21.SearchUsersForTagResponse>(
      '/pb.TagPayService/SearchUsers',
      ($21.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.SearchUsersForTagResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$21.CreateTagPayResponse> createTagPay(
      $21.CreateTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetTagPayResponse> getTagPay(
      $21.GetTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$21.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability($21.CheckTagPayAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.SearchTagPayResponse> searchTagPay(
      $21.SearchTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$21.SendMoneyTagPayResponse> sendMoneyTagPay(
      $21.SendMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$21.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $21.RequestMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetTagPayTransactionsResponse> getTagPayTransactions(
      $21.GetTagPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$21.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $21.AcceptMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$21.DeclineMoneyRequestResponse> declineMoneyRequest(
      $21.DeclineMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests($21.GetPendingMoneyRequestsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.CreateTagResponse> createTag(
      $21.CreateTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetMyTagsResponse> getMyTags(
      $21.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetMyTagsResponse> getMyOutgoingTags(
      $21.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetMyTagsResponse> getMyIncomingTags(
      $21.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$21.PayTagResponse> payTag($21.PayTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$21.SearchUsersForTagResponse> searchUsers(
      $21.SearchUsersForTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }
}

abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TagPayService';

  TagPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$21.CreateTagPayRequest, $21.CreateTagPayResponse>(
            'CreateTagPay',
            createTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.CreateTagPayRequest.fromBuffer(value),
            ($21.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetTagPayRequest, $21.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetTagPayRequest.fromBuffer(value),
        ($21.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.CheckTagPayAvailabilityRequest,
            $21.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($21.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.SearchTagPayRequest, $21.SearchTagPayResponse>(
            'SearchTagPay',
            searchTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.SearchTagPayRequest.fromBuffer(value),
            ($21.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.SendMoneyTagPayRequest,
            $21.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.SendMoneyTagPayRequest.fromBuffer(value),
        ($21.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.RequestMoneyTagPayRequest,
            $21.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.RequestMoneyTagPayRequest.fromBuffer(value),
        ($21.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetTagPayTransactionsRequest,
            $21.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetTagPayTransactionsRequest.fromBuffer(value),
        ($21.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AcceptMoneyRequestRequest,
            $21.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.AcceptMoneyRequestRequest.fromBuffer(value),
        ($21.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.DeclineMoneyRequestRequest,
            $21.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.DeclineMoneyRequestRequest.fromBuffer(value),
        ($21.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPendingMoneyRequestsRequest,
            $21.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($21.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.CreateTagRequest, $21.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.CreateTagRequest.fromBuffer(value),
        ($21.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetMyTagsRequest, $21.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetMyTagsRequest.fromBuffer(value),
        ($21.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetMyTagsRequest, $21.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetMyTagsRequest.fromBuffer(value),
        ($21.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetMyTagsRequest, $21.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetMyTagsRequest.fromBuffer(value),
        ($21.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.PayTagRequest, $21.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.PayTagRequest.fromBuffer(value),
        ($21.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.SearchUsersForTagRequest,
            $21.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.SearchUsersForTagRequest.fromBuffer(value),
        ($21.SearchUsersForTagResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.CreateTagPayResponse> createTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$21.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call,
      $async.Future<$21.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$21.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability_Pre($grpc.ServiceCall call,
          $async.Future<$21.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$21.SearchTagPayResponse> searchTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$21.SendMoneyTagPayResponse> sendMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$21.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$21.GetTagPayTransactionsResponse> getTagPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$21.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$21.DeclineMoneyRequestResponse> declineMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$21.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$21.CreateTagResponse> createTag_Pre($grpc.ServiceCall call,
      $async.Future<$21.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$21.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call,
      $async.Future<$21.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$21.GetMyTagsResponse> getMyOutgoingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$21.GetMyTagsResponse> getMyIncomingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$21.PayTagResponse> payTag_Pre(
      $grpc.ServiceCall call, $async.Future<$21.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$21.SearchUsersForTagResponse> searchUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$21.CreateTagPayResponse> createTagPay(
      $grpc.ServiceCall call, $21.CreateTagPayRequest request);
  $async.Future<$21.GetTagPayResponse> getTagPay(
      $grpc.ServiceCall call, $21.GetTagPayRequest request);
  $async.Future<$21.CheckTagPayAvailabilityResponse> checkTagPayAvailability(
      $grpc.ServiceCall call, $21.CheckTagPayAvailabilityRequest request);
  $async.Future<$21.SearchTagPayResponse> searchTagPay(
      $grpc.ServiceCall call, $21.SearchTagPayRequest request);
  $async.Future<$21.SendMoneyTagPayResponse> sendMoneyTagPay(
      $grpc.ServiceCall call, $21.SendMoneyTagPayRequest request);
  $async.Future<$21.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $grpc.ServiceCall call, $21.RequestMoneyTagPayRequest request);
  $async.Future<$21.GetTagPayTransactionsResponse> getTagPayTransactions(
      $grpc.ServiceCall call, $21.GetTagPayTransactionsRequest request);
  $async.Future<$21.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $grpc.ServiceCall call, $21.AcceptMoneyRequestRequest request);
  $async.Future<$21.DeclineMoneyRequestResponse> declineMoneyRequest(
      $grpc.ServiceCall call, $21.DeclineMoneyRequestRequest request);
  $async.Future<$21.GetPendingMoneyRequestsResponse> getPendingMoneyRequests(
      $grpc.ServiceCall call, $21.GetPendingMoneyRequestsRequest request);
  $async.Future<$21.CreateTagResponse> createTag(
      $grpc.ServiceCall call, $21.CreateTagRequest request);
  $async.Future<$21.GetMyTagsResponse> getMyTags(
      $grpc.ServiceCall call, $21.GetMyTagsRequest request);
  $async.Future<$21.GetMyTagsResponse> getMyOutgoingTags(
      $grpc.ServiceCall call, $21.GetMyTagsRequest request);
  $async.Future<$21.GetMyTagsResponse> getMyIncomingTags(
      $grpc.ServiceCall call, $21.GetMyTagsRequest request);
  $async.Future<$21.PayTagResponse> payTag(
      $grpc.ServiceCall call, $21.PayTagRequest request);
  $async.Future<$21.SearchUsersForTagResponse> searchUsers(
      $grpc.ServiceCall call, $21.SearchUsersForTagRequest request);
}
