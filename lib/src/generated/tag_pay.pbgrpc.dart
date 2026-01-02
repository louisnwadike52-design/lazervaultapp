///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tag_pay.pb.dart' as $26;
export 'tag_pay.pb.dart';

class TagPayServiceClient extends $grpc.Client {
  static final _$createTagPay =
      $grpc.ClientMethod<$26.CreateTagPayRequest, $26.CreateTagPayResponse>(
          '/pb.TagPayService/CreateTagPay',
          ($26.CreateTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.CreateTagPayResponse.fromBuffer(value));
  static final _$getTagPay =
      $grpc.ClientMethod<$26.GetTagPayRequest, $26.GetTagPayResponse>(
          '/pb.TagPayService/GetTagPay',
          ($26.GetTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.GetTagPayResponse.fromBuffer(value));
  static final _$checkTagPayAvailability = $grpc.ClientMethod<
          $26.CheckTagPayAvailabilityRequest,
          $26.CheckTagPayAvailabilityResponse>(
      '/pb.TagPayService/CheckTagPayAvailability',
      ($26.CheckTagPayAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.CheckTagPayAvailabilityResponse.fromBuffer(value));
  static final _$searchTagPay =
      $grpc.ClientMethod<$26.SearchTagPayRequest, $26.SearchTagPayResponse>(
          '/pb.TagPayService/SearchTagPay',
          ($26.SearchTagPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.SearchTagPayResponse.fromBuffer(value));
  static final _$sendMoneyTagPay = $grpc.ClientMethod<
          $26.SendMoneyTagPayRequest, $26.SendMoneyTagPayResponse>(
      '/pb.TagPayService/SendMoneyTagPay',
      ($26.SendMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.SendMoneyTagPayResponse.fromBuffer(value));
  static final _$requestMoneyTagPay = $grpc.ClientMethod<
          $26.RequestMoneyTagPayRequest, $26.RequestMoneyTagPayResponse>(
      '/pb.TagPayService/RequestMoneyTagPay',
      ($26.RequestMoneyTagPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.RequestMoneyTagPayResponse.fromBuffer(value));
  static final _$getTagPayTransactions = $grpc.ClientMethod<
          $26.GetTagPayTransactionsRequest, $26.GetTagPayTransactionsResponse>(
      '/pb.TagPayService/GetTagPayTransactions',
      ($26.GetTagPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetTagPayTransactionsResponse.fromBuffer(value));
  static final _$acceptMoneyRequest = $grpc.ClientMethod<
          $26.AcceptMoneyRequestRequest, $26.AcceptMoneyRequestResponse>(
      '/pb.TagPayService/AcceptMoneyRequest',
      ($26.AcceptMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.AcceptMoneyRequestResponse.fromBuffer(value));
  static final _$declineMoneyRequest = $grpc.ClientMethod<
          $26.DeclineMoneyRequestRequest, $26.DeclineMoneyRequestResponse>(
      '/pb.TagPayService/DeclineMoneyRequest',
      ($26.DeclineMoneyRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.DeclineMoneyRequestResponse.fromBuffer(value));
  static final _$getPendingMoneyRequests = $grpc.ClientMethod<
          $26.GetPendingMoneyRequestsRequest,
          $26.GetPendingMoneyRequestsResponse>(
      '/pb.TagPayService/GetPendingMoneyRequests',
      ($26.GetPendingMoneyRequestsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetPendingMoneyRequestsResponse.fromBuffer(value));
  static final _$createTag =
      $grpc.ClientMethod<$26.CreateTagRequest, $26.CreateTagResponse>(
          '/pb.TagPayService/CreateTag',
          ($26.CreateTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.CreateTagResponse.fromBuffer(value));
  static final _$getMyTags =
      $grpc.ClientMethod<$26.GetMyTagsRequest, $26.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyTags',
          ($26.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyOutgoingTags =
      $grpc.ClientMethod<$26.GetMyTagsRequest, $26.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyOutgoingTags',
          ($26.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.GetMyTagsResponse.fromBuffer(value));
  static final _$getMyIncomingTags =
      $grpc.ClientMethod<$26.GetMyTagsRequest, $26.GetMyTagsResponse>(
          '/pb.TagPayService/GetMyIncomingTags',
          ($26.GetMyTagsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.GetMyTagsResponse.fromBuffer(value));
  static final _$payTag =
      $grpc.ClientMethod<$26.PayTagRequest, $26.PayTagResponse>(
          '/pb.TagPayService/PayTag',
          ($26.PayTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.PayTagResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$26.SearchUsersForTagRequest,
          $26.SearchUsersForTagResponse>(
      '/pb.TagPayService/SearchUsers',
      ($26.SearchUsersForTagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.SearchUsersForTagResponse.fromBuffer(value));

  TagPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$26.CreateTagPayResponse> createTagPay(
      $26.CreateTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetTagPayResponse> getTagPay(
      $26.GetTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$26.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability($26.CheckTagPayAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkTagPayAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.SearchTagPayResponse> searchTagPay(
      $26.SearchTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$26.SendMoneyTagPayResponse> sendMoneyTagPay(
      $26.SendMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$26.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $26.RequestMoneyTagPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestMoneyTagPay, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetTagPayTransactionsResponse> getTagPayTransactions(
      $26.GetTagPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTagPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$26.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $26.AcceptMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$26.DeclineMoneyRequestResponse> declineMoneyRequest(
      $26.DeclineMoneyRequestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineMoneyRequest, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests($26.GetPendingMoneyRequestsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingMoneyRequests, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.CreateTagResponse> createTag(
      $26.CreateTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetMyTagsResponse> getMyTags(
      $26.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyTags, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetMyTagsResponse> getMyOutgoingTags(
      $26.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOutgoingTags, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetMyTagsResponse> getMyIncomingTags(
      $26.GetMyTagsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingTags, request, options: options);
  }

  $grpc.ResponseFuture<$26.PayTagResponse> payTag($26.PayTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payTag, request, options: options);
  }

  $grpc.ResponseFuture<$26.SearchUsersForTagResponse> searchUsers(
      $26.SearchUsersForTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }
}

abstract class TagPayServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TagPayService';

  TagPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$26.CreateTagPayRequest, $26.CreateTagPayResponse>(
            'CreateTagPay',
            createTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.CreateTagPayRequest.fromBuffer(value),
            ($26.CreateTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetTagPayRequest, $26.GetTagPayResponse>(
        'GetTagPay',
        getTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetTagPayRequest.fromBuffer(value),
        ($26.GetTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CheckTagPayAvailabilityRequest,
            $26.CheckTagPayAvailabilityResponse>(
        'CheckTagPayAvailability',
        checkTagPayAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.CheckTagPayAvailabilityRequest.fromBuffer(value),
        ($26.CheckTagPayAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$26.SearchTagPayRequest, $26.SearchTagPayResponse>(
            'SearchTagPay',
            searchTagPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.SearchTagPayRequest.fromBuffer(value),
            ($26.SearchTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.SendMoneyTagPayRequest,
            $26.SendMoneyTagPayResponse>(
        'SendMoneyTagPay',
        sendMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.SendMoneyTagPayRequest.fromBuffer(value),
        ($26.SendMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.RequestMoneyTagPayRequest,
            $26.RequestMoneyTagPayResponse>(
        'RequestMoneyTagPay',
        requestMoneyTagPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.RequestMoneyTagPayRequest.fromBuffer(value),
        ($26.RequestMoneyTagPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetTagPayTransactionsRequest,
            $26.GetTagPayTransactionsResponse>(
        'GetTagPayTransactions',
        getTagPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetTagPayTransactionsRequest.fromBuffer(value),
        ($26.GetTagPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.AcceptMoneyRequestRequest,
            $26.AcceptMoneyRequestResponse>(
        'AcceptMoneyRequest',
        acceptMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.AcceptMoneyRequestRequest.fromBuffer(value),
        ($26.AcceptMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.DeclineMoneyRequestRequest,
            $26.DeclineMoneyRequestResponse>(
        'DeclineMoneyRequest',
        declineMoneyRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.DeclineMoneyRequestRequest.fromBuffer(value),
        ($26.DeclineMoneyRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetPendingMoneyRequestsRequest,
            $26.GetPendingMoneyRequestsResponse>(
        'GetPendingMoneyRequests',
        getPendingMoneyRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetPendingMoneyRequestsRequest.fromBuffer(value),
        ($26.GetPendingMoneyRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CreateTagRequest, $26.CreateTagResponse>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.CreateTagRequest.fromBuffer(value),
        ($26.CreateTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetMyTagsRequest, $26.GetMyTagsResponse>(
        'GetMyTags',
        getMyTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetMyTagsRequest.fromBuffer(value),
        ($26.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetMyTagsRequest, $26.GetMyTagsResponse>(
        'GetMyOutgoingTags',
        getMyOutgoingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetMyTagsRequest.fromBuffer(value),
        ($26.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetMyTagsRequest, $26.GetMyTagsResponse>(
        'GetMyIncomingTags',
        getMyIncomingTags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.GetMyTagsRequest.fromBuffer(value),
        ($26.GetMyTagsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.PayTagRequest, $26.PayTagResponse>(
        'PayTag',
        payTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.PayTagRequest.fromBuffer(value),
        ($26.PayTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.SearchUsersForTagRequest,
            $26.SearchUsersForTagResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.SearchUsersForTagRequest.fromBuffer(value),
        ($26.SearchUsersForTagResponse value) => value.writeToBuffer()));
  }

  $async.Future<$26.CreateTagPayResponse> createTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.CreateTagPayRequest> request) async {
    return createTagPay(call, await request);
  }

  $async.Future<$26.GetTagPayResponse> getTagPay_Pre($grpc.ServiceCall call,
      $async.Future<$26.GetTagPayRequest> request) async {
    return getTagPay(call, await request);
  }

  $async.Future<$26.CheckTagPayAvailabilityResponse>
      checkTagPayAvailability_Pre($grpc.ServiceCall call,
          $async.Future<$26.CheckTagPayAvailabilityRequest> request) async {
    return checkTagPayAvailability(call, await request);
  }

  $async.Future<$26.SearchTagPayResponse> searchTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.SearchTagPayRequest> request) async {
    return searchTagPay(call, await request);
  }

  $async.Future<$26.SendMoneyTagPayResponse> sendMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.SendMoneyTagPayRequest> request) async {
    return sendMoneyTagPay(call, await request);
  }

  $async.Future<$26.RequestMoneyTagPayResponse> requestMoneyTagPay_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.RequestMoneyTagPayRequest> request) async {
    return requestMoneyTagPay(call, await request);
  }

  $async.Future<$26.GetTagPayTransactionsResponse> getTagPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetTagPayTransactionsRequest> request) async {
    return getTagPayTransactions(call, await request);
  }

  $async.Future<$26.AcceptMoneyRequestResponse> acceptMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.AcceptMoneyRequestRequest> request) async {
    return acceptMoneyRequest(call, await request);
  }

  $async.Future<$26.DeclineMoneyRequestResponse> declineMoneyRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.DeclineMoneyRequestRequest> request) async {
    return declineMoneyRequest(call, await request);
  }

  $async.Future<$26.GetPendingMoneyRequestsResponse>
      getPendingMoneyRequests_Pre($grpc.ServiceCall call,
          $async.Future<$26.GetPendingMoneyRequestsRequest> request) async {
    return getPendingMoneyRequests(call, await request);
  }

  $async.Future<$26.CreateTagResponse> createTag_Pre($grpc.ServiceCall call,
      $async.Future<$26.CreateTagRequest> request) async {
    return createTag(call, await request);
  }

  $async.Future<$26.GetMyTagsResponse> getMyTags_Pre($grpc.ServiceCall call,
      $async.Future<$26.GetMyTagsRequest> request) async {
    return getMyTags(call, await request);
  }

  $async.Future<$26.GetMyTagsResponse> getMyOutgoingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetMyTagsRequest> request) async {
    return getMyOutgoingTags(call, await request);
  }

  $async.Future<$26.GetMyTagsResponse> getMyIncomingTags_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetMyTagsRequest> request) async {
    return getMyIncomingTags(call, await request);
  }

  $async.Future<$26.PayTagResponse> payTag_Pre(
      $grpc.ServiceCall call, $async.Future<$26.PayTagRequest> request) async {
    return payTag(call, await request);
  }

  $async.Future<$26.SearchUsersForTagResponse> searchUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.SearchUsersForTagRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$26.CreateTagPayResponse> createTagPay(
      $grpc.ServiceCall call, $26.CreateTagPayRequest request);
  $async.Future<$26.GetTagPayResponse> getTagPay(
      $grpc.ServiceCall call, $26.GetTagPayRequest request);
  $async.Future<$26.CheckTagPayAvailabilityResponse> checkTagPayAvailability(
      $grpc.ServiceCall call, $26.CheckTagPayAvailabilityRequest request);
  $async.Future<$26.SearchTagPayResponse> searchTagPay(
      $grpc.ServiceCall call, $26.SearchTagPayRequest request);
  $async.Future<$26.SendMoneyTagPayResponse> sendMoneyTagPay(
      $grpc.ServiceCall call, $26.SendMoneyTagPayRequest request);
  $async.Future<$26.RequestMoneyTagPayResponse> requestMoneyTagPay(
      $grpc.ServiceCall call, $26.RequestMoneyTagPayRequest request);
  $async.Future<$26.GetTagPayTransactionsResponse> getTagPayTransactions(
      $grpc.ServiceCall call, $26.GetTagPayTransactionsRequest request);
  $async.Future<$26.AcceptMoneyRequestResponse> acceptMoneyRequest(
      $grpc.ServiceCall call, $26.AcceptMoneyRequestRequest request);
  $async.Future<$26.DeclineMoneyRequestResponse> declineMoneyRequest(
      $grpc.ServiceCall call, $26.DeclineMoneyRequestRequest request);
  $async.Future<$26.GetPendingMoneyRequestsResponse> getPendingMoneyRequests(
      $grpc.ServiceCall call, $26.GetPendingMoneyRequestsRequest request);
  $async.Future<$26.CreateTagResponse> createTag(
      $grpc.ServiceCall call, $26.CreateTagRequest request);
  $async.Future<$26.GetMyTagsResponse> getMyTags(
      $grpc.ServiceCall call, $26.GetMyTagsRequest request);
  $async.Future<$26.GetMyTagsResponse> getMyOutgoingTags(
      $grpc.ServiceCall call, $26.GetMyTagsRequest request);
  $async.Future<$26.GetMyTagsResponse> getMyIncomingTags(
      $grpc.ServiceCall call, $26.GetMyTagsRequest request);
  $async.Future<$26.PayTagResponse> payTag(
      $grpc.ServiceCall call, $26.PayTagRequest request);
  $async.Future<$26.SearchUsersForTagResponse> searchUsers(
      $grpc.ServiceCall call, $26.SearchUsersForTagRequest request);
}
