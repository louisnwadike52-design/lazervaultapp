// This is a generated file - do not edit.
//
// Generated from bulk-sms.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'bulk-sms.pb.dart' as $0;

export 'bulk-sms.pb.dart';

/// BulkSmsService provides bulk SMS messaging capabilities with multi-provider
/// support (Termii primary, Africa's Talking fallback) and sticky provider routing.
@$pb.GrpcServiceName('bulksms.BulkSmsService')
class BulkSmsServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  BulkSmsServiceClient(super.channel, {super.options, super.interceptors});

  /// Get available SMS providers
  $grpc.ResponseFuture<$0.GetSmsProvidersResponse> getSmsProviders(
    $0.GetSmsProvidersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSmsProviders, request, options: options);
  }

  /// Get available SMS credit packages from the healthy provider
  $grpc.ResponseFuture<$0.GetSmsPackagesResponse> getSmsPackages(
    $0.GetSmsPackagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSmsPackages, request, options: options);
  }

  /// Get user's SMS credit balance
  $grpc.ResponseFuture<$0.GetSmsBalanceResponse> getSmsBalance(
    $0.GetSmsBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSmsBalance, request, options: options);
  }

  /// Purchase SMS credits (requires transaction PIN)
  $grpc.ResponseFuture<$0.PurchaseSmsCreditResponse> purchaseSmsCredits(
    $0.PurchaseSmsCreditRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$purchaseSmsCredits, request, options: options);
  }

  /// Send bulk SMS campaign (requires transaction PIN)
  $grpc.ResponseFuture<$0.SendBulkSmsResponse> sendBulkSms(
    $0.SendBulkSmsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendBulkSms, request, options: options);
  }

  /// Schedule bulk SMS for future delivery
  $grpc.ResponseFuture<$0.ScheduleSmsResponse> scheduleSms(
    $0.ScheduleSmsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$scheduleSms, request, options: options);
  }

  /// Cancel a scheduled SMS campaign
  $grpc.ResponseFuture<$0.CancelScheduledSmsResponse> cancelScheduledSms(
    $0.CancelScheduledSmsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelScheduledSms, request, options: options);
  }

  /// Get campaign delivery status
  $grpc.ResponseFuture<$0.GetSmsCampaignStatusResponse> getSmsCampaignStatus(
    $0.GetSmsCampaignStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSmsCampaignStatus, request, options: options);
  }

  /// Get detailed delivery report for a campaign
  $grpc.ResponseFuture<$0.GetDeliveryReportResponse> getDeliveryReport(
    $0.GetDeliveryReportRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDeliveryReport, request, options: options);
  }

  /// Get SMS campaign history
  $grpc.ResponseFuture<$0.GetSmsHistoryResponse> getSmsHistory(
    $0.GetSmsHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSmsHistory, request, options: options);
  }

  /// Get approved sender IDs for the user
  $grpc.ResponseFuture<$0.GetSenderIdsResponse> getSenderIds(
    $0.GetSenderIdsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSenderIds, request, options: options);
  }

  /// Request a new sender ID registration
  $grpc.ResponseFuture<$0.RequestSenderIdResponse> requestSenderId(
    $0.RequestSenderIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestSenderId, request, options: options);
  }

  // method descriptors

  static final _$getSmsProviders =
      $grpc.ClientMethod<$0.GetSmsProvidersRequest, $0.GetSmsProvidersResponse>(
          '/bulksms.BulkSmsService/GetSmsProviders',
          ($0.GetSmsProvidersRequest value) => value.writeToBuffer(),
          $0.GetSmsProvidersResponse.fromBuffer);
  static final _$getSmsPackages =
      $grpc.ClientMethod<$0.GetSmsPackagesRequest, $0.GetSmsPackagesResponse>(
          '/bulksms.BulkSmsService/GetSmsPackages',
          ($0.GetSmsPackagesRequest value) => value.writeToBuffer(),
          $0.GetSmsPackagesResponse.fromBuffer);
  static final _$getSmsBalance =
      $grpc.ClientMethod<$0.GetSmsBalanceRequest, $0.GetSmsBalanceResponse>(
          '/bulksms.BulkSmsService/GetSmsBalance',
          ($0.GetSmsBalanceRequest value) => value.writeToBuffer(),
          $0.GetSmsBalanceResponse.fromBuffer);
  static final _$purchaseSmsCredits = $grpc.ClientMethod<
          $0.PurchaseSmsCreditRequest, $0.PurchaseSmsCreditResponse>(
      '/bulksms.BulkSmsService/PurchaseSmsCredits',
      ($0.PurchaseSmsCreditRequest value) => value.writeToBuffer(),
      $0.PurchaseSmsCreditResponse.fromBuffer);
  static final _$sendBulkSms =
      $grpc.ClientMethod<$0.SendBulkSmsRequest, $0.SendBulkSmsResponse>(
          '/bulksms.BulkSmsService/SendBulkSms',
          ($0.SendBulkSmsRequest value) => value.writeToBuffer(),
          $0.SendBulkSmsResponse.fromBuffer);
  static final _$scheduleSms =
      $grpc.ClientMethod<$0.ScheduleSmsRequest, $0.ScheduleSmsResponse>(
          '/bulksms.BulkSmsService/ScheduleSms',
          ($0.ScheduleSmsRequest value) => value.writeToBuffer(),
          $0.ScheduleSmsResponse.fromBuffer);
  static final _$cancelScheduledSms = $grpc.ClientMethod<
          $0.CancelScheduledSmsRequest, $0.CancelScheduledSmsResponse>(
      '/bulksms.BulkSmsService/CancelScheduledSms',
      ($0.CancelScheduledSmsRequest value) => value.writeToBuffer(),
      $0.CancelScheduledSmsResponse.fromBuffer);
  static final _$getSmsCampaignStatus = $grpc.ClientMethod<
          $0.GetSmsCampaignStatusRequest, $0.GetSmsCampaignStatusResponse>(
      '/bulksms.BulkSmsService/GetSmsCampaignStatus',
      ($0.GetSmsCampaignStatusRequest value) => value.writeToBuffer(),
      $0.GetSmsCampaignStatusResponse.fromBuffer);
  static final _$getDeliveryReport = $grpc.ClientMethod<
          $0.GetDeliveryReportRequest, $0.GetDeliveryReportResponse>(
      '/bulksms.BulkSmsService/GetDeliveryReport',
      ($0.GetDeliveryReportRequest value) => value.writeToBuffer(),
      $0.GetDeliveryReportResponse.fromBuffer);
  static final _$getSmsHistory =
      $grpc.ClientMethod<$0.GetSmsHistoryRequest, $0.GetSmsHistoryResponse>(
          '/bulksms.BulkSmsService/GetSmsHistory',
          ($0.GetSmsHistoryRequest value) => value.writeToBuffer(),
          $0.GetSmsHistoryResponse.fromBuffer);
  static final _$getSenderIds =
      $grpc.ClientMethod<$0.GetSenderIdsRequest, $0.GetSenderIdsResponse>(
          '/bulksms.BulkSmsService/GetSenderIds',
          ($0.GetSenderIdsRequest value) => value.writeToBuffer(),
          $0.GetSenderIdsResponse.fromBuffer);
  static final _$requestSenderId =
      $grpc.ClientMethod<$0.RequestSenderIdRequest, $0.RequestSenderIdResponse>(
          '/bulksms.BulkSmsService/RequestSenderId',
          ($0.RequestSenderIdRequest value) => value.writeToBuffer(),
          $0.RequestSenderIdResponse.fromBuffer);
}

@$pb.GrpcServiceName('bulksms.BulkSmsService')
abstract class BulkSmsServiceBase extends $grpc.Service {
  $core.String get $name => 'bulksms.BulkSmsService';

  BulkSmsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetSmsProvidersRequest,
            $0.GetSmsProvidersResponse>(
        'GetSmsProviders',
        getSmsProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSmsProvidersRequest.fromBuffer(value),
        ($0.GetSmsProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSmsPackagesRequest,
            $0.GetSmsPackagesResponse>(
        'GetSmsPackages',
        getSmsPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSmsPackagesRequest.fromBuffer(value),
        ($0.GetSmsPackagesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetSmsBalanceRequest, $0.GetSmsBalanceResponse>(
            'GetSmsBalance',
            getSmsBalance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetSmsBalanceRequest.fromBuffer(value),
            ($0.GetSmsBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PurchaseSmsCreditRequest,
            $0.PurchaseSmsCreditResponse>(
        'PurchaseSmsCredits',
        purchaseSmsCredits_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PurchaseSmsCreditRequest.fromBuffer(value),
        ($0.PurchaseSmsCreditResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SendBulkSmsRequest, $0.SendBulkSmsResponse>(
            'SendBulkSms',
            sendBulkSms_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SendBulkSmsRequest.fromBuffer(value),
            ($0.SendBulkSmsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ScheduleSmsRequest, $0.ScheduleSmsResponse>(
            'ScheduleSms',
            scheduleSms_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ScheduleSmsRequest.fromBuffer(value),
            ($0.ScheduleSmsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelScheduledSmsRequest,
            $0.CancelScheduledSmsResponse>(
        'CancelScheduledSms',
        cancelScheduledSms_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelScheduledSmsRequest.fromBuffer(value),
        ($0.CancelScheduledSmsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSmsCampaignStatusRequest,
            $0.GetSmsCampaignStatusResponse>(
        'GetSmsCampaignStatus',
        getSmsCampaignStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSmsCampaignStatusRequest.fromBuffer(value),
        ($0.GetSmsCampaignStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDeliveryReportRequest,
            $0.GetDeliveryReportResponse>(
        'GetDeliveryReport',
        getDeliveryReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDeliveryReportRequest.fromBuffer(value),
        ($0.GetDeliveryReportResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetSmsHistoryRequest, $0.GetSmsHistoryResponse>(
            'GetSmsHistory',
            getSmsHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetSmsHistoryRequest.fromBuffer(value),
            ($0.GetSmsHistoryResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetSenderIdsRequest, $0.GetSenderIdsResponse>(
            'GetSenderIds',
            getSenderIds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetSenderIdsRequest.fromBuffer(value),
            ($0.GetSenderIdsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestSenderIdRequest,
            $0.RequestSenderIdResponse>(
        'RequestSenderId',
        requestSenderId_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestSenderIdRequest.fromBuffer(value),
        ($0.RequestSenderIdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetSmsProvidersResponse> getSmsProviders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSmsProvidersRequest> $request) async {
    return getSmsProviders($call, await $request);
  }

  $async.Future<$0.GetSmsProvidersResponse> getSmsProviders(
      $grpc.ServiceCall call, $0.GetSmsProvidersRequest request);

  $async.Future<$0.GetSmsPackagesResponse> getSmsPackages_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSmsPackagesRequest> $request) async {
    return getSmsPackages($call, await $request);
  }

  $async.Future<$0.GetSmsPackagesResponse> getSmsPackages(
      $grpc.ServiceCall call, $0.GetSmsPackagesRequest request);

  $async.Future<$0.GetSmsBalanceResponse> getSmsBalance_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSmsBalanceRequest> $request) async {
    return getSmsBalance($call, await $request);
  }

  $async.Future<$0.GetSmsBalanceResponse> getSmsBalance(
      $grpc.ServiceCall call, $0.GetSmsBalanceRequest request);

  $async.Future<$0.PurchaseSmsCreditResponse> purchaseSmsCredits_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PurchaseSmsCreditRequest> $request) async {
    return purchaseSmsCredits($call, await $request);
  }

  $async.Future<$0.PurchaseSmsCreditResponse> purchaseSmsCredits(
      $grpc.ServiceCall call, $0.PurchaseSmsCreditRequest request);

  $async.Future<$0.SendBulkSmsResponse> sendBulkSms_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SendBulkSmsRequest> $request) async {
    return sendBulkSms($call, await $request);
  }

  $async.Future<$0.SendBulkSmsResponse> sendBulkSms(
      $grpc.ServiceCall call, $0.SendBulkSmsRequest request);

  $async.Future<$0.ScheduleSmsResponse> scheduleSms_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ScheduleSmsRequest> $request) async {
    return scheduleSms($call, await $request);
  }

  $async.Future<$0.ScheduleSmsResponse> scheduleSms(
      $grpc.ServiceCall call, $0.ScheduleSmsRequest request);

  $async.Future<$0.CancelScheduledSmsResponse> cancelScheduledSms_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelScheduledSmsRequest> $request) async {
    return cancelScheduledSms($call, await $request);
  }

  $async.Future<$0.CancelScheduledSmsResponse> cancelScheduledSms(
      $grpc.ServiceCall call, $0.CancelScheduledSmsRequest request);

  $async.Future<$0.GetSmsCampaignStatusResponse> getSmsCampaignStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSmsCampaignStatusRequest> $request) async {
    return getSmsCampaignStatus($call, await $request);
  }

  $async.Future<$0.GetSmsCampaignStatusResponse> getSmsCampaignStatus(
      $grpc.ServiceCall call, $0.GetSmsCampaignStatusRequest request);

  $async.Future<$0.GetDeliveryReportResponse> getDeliveryReport_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDeliveryReportRequest> $request) async {
    return getDeliveryReport($call, await $request);
  }

  $async.Future<$0.GetDeliveryReportResponse> getDeliveryReport(
      $grpc.ServiceCall call, $0.GetDeliveryReportRequest request);

  $async.Future<$0.GetSmsHistoryResponse> getSmsHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSmsHistoryRequest> $request) async {
    return getSmsHistory($call, await $request);
  }

  $async.Future<$0.GetSmsHistoryResponse> getSmsHistory(
      $grpc.ServiceCall call, $0.GetSmsHistoryRequest request);

  $async.Future<$0.GetSenderIdsResponse> getSenderIds_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSenderIdsRequest> $request) async {
    return getSenderIds($call, await $request);
  }

  $async.Future<$0.GetSenderIdsResponse> getSenderIds(
      $grpc.ServiceCall call, $0.GetSenderIdsRequest request);

  $async.Future<$0.RequestSenderIdResponse> requestSenderId_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestSenderIdRequest> $request) async {
    return requestSenderId($call, await $request);
  }

  $async.Future<$0.RequestSenderIdResponse> requestSenderId(
      $grpc.ServiceCall call, $0.RequestSenderIdRequest request);
}
