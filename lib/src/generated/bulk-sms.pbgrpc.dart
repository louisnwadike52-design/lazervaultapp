///
//  Generated code. Do not modify.
//  source: bulk-sms.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'bulk-sms.pb.dart' as $7;
export 'bulk-sms.pb.dart';

class BulkSmsServiceClient extends $grpc.Client {
  static final _$getSmsProviders =
      $grpc.ClientMethod<$7.GetSmsProvidersRequest, $7.GetSmsProvidersResponse>(
          '/bulksms.BulkSmsService/GetSmsProviders',
          ($7.GetSmsProvidersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GetSmsProvidersResponse.fromBuffer(value));
  static final _$getSmsPackages =
      $grpc.ClientMethod<$7.GetSmsPackagesRequest, $7.GetSmsPackagesResponse>(
          '/bulksms.BulkSmsService/GetSmsPackages',
          ($7.GetSmsPackagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GetSmsPackagesResponse.fromBuffer(value));
  static final _$getSmsBalance =
      $grpc.ClientMethod<$7.GetSmsBalanceRequest, $7.GetSmsBalanceResponse>(
          '/bulksms.BulkSmsService/GetSmsBalance',
          ($7.GetSmsBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GetSmsBalanceResponse.fromBuffer(value));
  static final _$purchaseSmsCredits = $grpc.ClientMethod<
          $7.PurchaseSmsCreditRequest, $7.PurchaseSmsCreditResponse>(
      '/bulksms.BulkSmsService/PurchaseSmsCredits',
      ($7.PurchaseSmsCreditRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.PurchaseSmsCreditResponse.fromBuffer(value));
  static final _$sendBulkSms =
      $grpc.ClientMethod<$7.SendBulkSmsRequest, $7.SendBulkSmsResponse>(
          '/bulksms.BulkSmsService/SendBulkSms',
          ($7.SendBulkSmsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.SendBulkSmsResponse.fromBuffer(value));
  static final _$scheduleSms =
      $grpc.ClientMethod<$7.ScheduleSmsRequest, $7.ScheduleSmsResponse>(
          '/bulksms.BulkSmsService/ScheduleSms',
          ($7.ScheduleSmsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.ScheduleSmsResponse.fromBuffer(value));
  static final _$cancelScheduledSms = $grpc.ClientMethod<
          $7.CancelScheduledSmsRequest, $7.CancelScheduledSmsResponse>(
      '/bulksms.BulkSmsService/CancelScheduledSms',
      ($7.CancelScheduledSmsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.CancelScheduledSmsResponse.fromBuffer(value));
  static final _$getSmsCampaignStatus = $grpc.ClientMethod<
          $7.GetSmsCampaignStatusRequest, $7.GetSmsCampaignStatusResponse>(
      '/bulksms.BulkSmsService/GetSmsCampaignStatus',
      ($7.GetSmsCampaignStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.GetSmsCampaignStatusResponse.fromBuffer(value));
  static final _$getDeliveryReport = $grpc.ClientMethod<
          $7.GetDeliveryReportRequest, $7.GetDeliveryReportResponse>(
      '/bulksms.BulkSmsService/GetDeliveryReport',
      ($7.GetDeliveryReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.GetDeliveryReportResponse.fromBuffer(value));
  static final _$getSmsHistory =
      $grpc.ClientMethod<$7.GetSmsHistoryRequest, $7.GetSmsHistoryResponse>(
          '/bulksms.BulkSmsService/GetSmsHistory',
          ($7.GetSmsHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GetSmsHistoryResponse.fromBuffer(value));
  static final _$getSenderIds =
      $grpc.ClientMethod<$7.GetSenderIdsRequest, $7.GetSenderIdsResponse>(
          '/bulksms.BulkSmsService/GetSenderIds',
          ($7.GetSenderIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.GetSenderIdsResponse.fromBuffer(value));
  static final _$requestSenderId =
      $grpc.ClientMethod<$7.RequestSenderIdRequest, $7.RequestSenderIdResponse>(
          '/bulksms.BulkSmsService/RequestSenderId',
          ($7.RequestSenderIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.RequestSenderIdResponse.fromBuffer(value));

  BulkSmsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$7.GetSmsProvidersResponse> getSmsProviders(
      $7.GetSmsProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsProviders, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetSmsPackagesResponse> getSmsPackages(
      $7.GetSmsPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsPackages, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetSmsBalanceResponse> getSmsBalance(
      $7.GetSmsBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsBalance, request, options: options);
  }

  $grpc.ResponseFuture<$7.PurchaseSmsCreditResponse> purchaseSmsCredits(
      $7.PurchaseSmsCreditRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseSmsCredits, request, options: options);
  }

  $grpc.ResponseFuture<$7.SendBulkSmsResponse> sendBulkSms(
      $7.SendBulkSmsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendBulkSms, request, options: options);
  }

  $grpc.ResponseFuture<$7.ScheduleSmsResponse> scheduleSms(
      $7.ScheduleSmsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scheduleSms, request, options: options);
  }

  $grpc.ResponseFuture<$7.CancelScheduledSmsResponse> cancelScheduledSms(
      $7.CancelScheduledSmsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelScheduledSms, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetSmsCampaignStatusResponse> getSmsCampaignStatus(
      $7.GetSmsCampaignStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsCampaignStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetDeliveryReportResponse> getDeliveryReport(
      $7.GetDeliveryReportRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDeliveryReport, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetSmsHistoryResponse> getSmsHistory(
      $7.GetSmsHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsHistory, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetSenderIdsResponse> getSenderIds(
      $7.GetSenderIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSenderIds, request, options: options);
  }

  $grpc.ResponseFuture<$7.RequestSenderIdResponse> requestSenderId(
      $7.RequestSenderIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestSenderId, request, options: options);
  }
}

abstract class BulkSmsServiceBase extends $grpc.Service {
  $core.String get $name => 'bulksms.BulkSmsService';

  BulkSmsServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.GetSmsProvidersRequest,
            $7.GetSmsProvidersResponse>(
        'GetSmsProviders',
        getSmsProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetSmsProvidersRequest.fromBuffer(value),
        ($7.GetSmsProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetSmsPackagesRequest,
            $7.GetSmsPackagesResponse>(
        'GetSmsPackages',
        getSmsPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetSmsPackagesRequest.fromBuffer(value),
        ($7.GetSmsPackagesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.GetSmsBalanceRequest, $7.GetSmsBalanceResponse>(
            'GetSmsBalance',
            getSmsBalance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.GetSmsBalanceRequest.fromBuffer(value),
            ($7.GetSmsBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.PurchaseSmsCreditRequest,
            $7.PurchaseSmsCreditResponse>(
        'PurchaseSmsCredits',
        purchaseSmsCredits_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.PurchaseSmsCreditRequest.fromBuffer(value),
        ($7.PurchaseSmsCreditResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.SendBulkSmsRequest, $7.SendBulkSmsResponse>(
            'SendBulkSms',
            sendBulkSms_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.SendBulkSmsRequest.fromBuffer(value),
            ($7.SendBulkSmsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.ScheduleSmsRequest, $7.ScheduleSmsResponse>(
            'ScheduleSms',
            scheduleSms_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.ScheduleSmsRequest.fromBuffer(value),
            ($7.ScheduleSmsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CancelScheduledSmsRequest,
            $7.CancelScheduledSmsResponse>(
        'CancelScheduledSms',
        cancelScheduledSms_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.CancelScheduledSmsRequest.fromBuffer(value),
        ($7.CancelScheduledSmsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetSmsCampaignStatusRequest,
            $7.GetSmsCampaignStatusResponse>(
        'GetSmsCampaignStatus',
        getSmsCampaignStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetSmsCampaignStatusRequest.fromBuffer(value),
        ($7.GetSmsCampaignStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetDeliveryReportRequest,
            $7.GetDeliveryReportResponse>(
        'GetDeliveryReport',
        getDeliveryReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetDeliveryReportRequest.fromBuffer(value),
        ($7.GetDeliveryReportResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.GetSmsHistoryRequest, $7.GetSmsHistoryResponse>(
            'GetSmsHistory',
            getSmsHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.GetSmsHistoryRequest.fromBuffer(value),
            ($7.GetSmsHistoryResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.GetSenderIdsRequest, $7.GetSenderIdsResponse>(
            'GetSenderIds',
            getSenderIds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $7.GetSenderIdsRequest.fromBuffer(value),
            ($7.GetSenderIdsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.RequestSenderIdRequest,
            $7.RequestSenderIdResponse>(
        'RequestSenderId',
        requestSenderId_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.RequestSenderIdRequest.fromBuffer(value),
        ($7.RequestSenderIdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.GetSmsProvidersResponse> getSmsProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetSmsProvidersRequest> request) async {
    return getSmsProviders(call, await request);
  }

  $async.Future<$7.GetSmsPackagesResponse> getSmsPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetSmsPackagesRequest> request) async {
    return getSmsPackages(call, await request);
  }

  $async.Future<$7.GetSmsBalanceResponse> getSmsBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetSmsBalanceRequest> request) async {
    return getSmsBalance(call, await request);
  }

  $async.Future<$7.PurchaseSmsCreditResponse> purchaseSmsCredits_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.PurchaseSmsCreditRequest> request) async {
    return purchaseSmsCredits(call, await request);
  }

  $async.Future<$7.SendBulkSmsResponse> sendBulkSms_Pre($grpc.ServiceCall call,
      $async.Future<$7.SendBulkSmsRequest> request) async {
    return sendBulkSms(call, await request);
  }

  $async.Future<$7.ScheduleSmsResponse> scheduleSms_Pre($grpc.ServiceCall call,
      $async.Future<$7.ScheduleSmsRequest> request) async {
    return scheduleSms(call, await request);
  }

  $async.Future<$7.CancelScheduledSmsResponse> cancelScheduledSms_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.CancelScheduledSmsRequest> request) async {
    return cancelScheduledSms(call, await request);
  }

  $async.Future<$7.GetSmsCampaignStatusResponse> getSmsCampaignStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetSmsCampaignStatusRequest> request) async {
    return getSmsCampaignStatus(call, await request);
  }

  $async.Future<$7.GetDeliveryReportResponse> getDeliveryReport_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetDeliveryReportRequest> request) async {
    return getDeliveryReport(call, await request);
  }

  $async.Future<$7.GetSmsHistoryResponse> getSmsHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetSmsHistoryRequest> request) async {
    return getSmsHistory(call, await request);
  }

  $async.Future<$7.GetSenderIdsResponse> getSenderIds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.GetSenderIdsRequest> request) async {
    return getSenderIds(call, await request);
  }

  $async.Future<$7.RequestSenderIdResponse> requestSenderId_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.RequestSenderIdRequest> request) async {
    return requestSenderId(call, await request);
  }

  $async.Future<$7.GetSmsProvidersResponse> getSmsProviders(
      $grpc.ServiceCall call, $7.GetSmsProvidersRequest request);
  $async.Future<$7.GetSmsPackagesResponse> getSmsPackages(
      $grpc.ServiceCall call, $7.GetSmsPackagesRequest request);
  $async.Future<$7.GetSmsBalanceResponse> getSmsBalance(
      $grpc.ServiceCall call, $7.GetSmsBalanceRequest request);
  $async.Future<$7.PurchaseSmsCreditResponse> purchaseSmsCredits(
      $grpc.ServiceCall call, $7.PurchaseSmsCreditRequest request);
  $async.Future<$7.SendBulkSmsResponse> sendBulkSms(
      $grpc.ServiceCall call, $7.SendBulkSmsRequest request);
  $async.Future<$7.ScheduleSmsResponse> scheduleSms(
      $grpc.ServiceCall call, $7.ScheduleSmsRequest request);
  $async.Future<$7.CancelScheduledSmsResponse> cancelScheduledSms(
      $grpc.ServiceCall call, $7.CancelScheduledSmsRequest request);
  $async.Future<$7.GetSmsCampaignStatusResponse> getSmsCampaignStatus(
      $grpc.ServiceCall call, $7.GetSmsCampaignStatusRequest request);
  $async.Future<$7.GetDeliveryReportResponse> getDeliveryReport(
      $grpc.ServiceCall call, $7.GetDeliveryReportRequest request);
  $async.Future<$7.GetSmsHistoryResponse> getSmsHistory(
      $grpc.ServiceCall call, $7.GetSmsHistoryRequest request);
  $async.Future<$7.GetSenderIdsResponse> getSenderIds(
      $grpc.ServiceCall call, $7.GetSenderIdsRequest request);
  $async.Future<$7.RequestSenderIdResponse> requestSenderId(
      $grpc.ServiceCall call, $7.RequestSenderIdRequest request);
}
