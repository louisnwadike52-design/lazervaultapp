///
//  Generated code. Do not modify.
//  source: bulk-sms.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'bulk-sms.pb.dart' as $0;
export 'bulk-sms.pb.dart';

class BulkSmsServiceClient extends $grpc.Client {
  static final _$getSmsProviders =
      $grpc.ClientMethod<$0.GetSmsProvidersRequest, $0.GetSmsProvidersResponse>(
          '/bulksms.BulkSmsService/GetSmsProviders',
          ($0.GetSmsProvidersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSmsProvidersResponse.fromBuffer(value));
  static final _$getSmsPackages =
      $grpc.ClientMethod<$0.GetSmsPackagesRequest, $0.GetSmsPackagesResponse>(
          '/bulksms.BulkSmsService/GetSmsPackages',
          ($0.GetSmsPackagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSmsPackagesResponse.fromBuffer(value));
  static final _$getSmsBalance =
      $grpc.ClientMethod<$0.GetSmsBalanceRequest, $0.GetSmsBalanceResponse>(
          '/bulksms.BulkSmsService/GetSmsBalance',
          ($0.GetSmsBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSmsBalanceResponse.fromBuffer(value));
  static final _$purchaseSmsCredits = $grpc.ClientMethod<
          $0.PurchaseSmsCreditRequest, $0.PurchaseSmsCreditResponse>(
      '/bulksms.BulkSmsService/PurchaseSmsCredits',
      ($0.PurchaseSmsCreditRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PurchaseSmsCreditResponse.fromBuffer(value));
  static final _$sendBulkSms =
      $grpc.ClientMethod<$0.SendBulkSmsRequest, $0.SendBulkSmsResponse>(
          '/bulksms.BulkSmsService/SendBulkSms',
          ($0.SendBulkSmsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SendBulkSmsResponse.fromBuffer(value));
  static final _$scheduleSms =
      $grpc.ClientMethod<$0.ScheduleSmsRequest, $0.ScheduleSmsResponse>(
          '/bulksms.BulkSmsService/ScheduleSms',
          ($0.ScheduleSmsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ScheduleSmsResponse.fromBuffer(value));
  static final _$cancelScheduledSms = $grpc.ClientMethod<
          $0.CancelScheduledSmsRequest, $0.CancelScheduledSmsResponse>(
      '/bulksms.BulkSmsService/CancelScheduledSms',
      ($0.CancelScheduledSmsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CancelScheduledSmsResponse.fromBuffer(value));
  static final _$getSmsCampaignStatus = $grpc.ClientMethod<
          $0.GetSmsCampaignStatusRequest, $0.GetSmsCampaignStatusResponse>(
      '/bulksms.BulkSmsService/GetSmsCampaignStatus',
      ($0.GetSmsCampaignStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSmsCampaignStatusResponse.fromBuffer(value));
  static final _$getDeliveryReport = $grpc.ClientMethod<
          $0.GetDeliveryReportRequest, $0.GetDeliveryReportResponse>(
      '/bulksms.BulkSmsService/GetDeliveryReport',
      ($0.GetDeliveryReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetDeliveryReportResponse.fromBuffer(value));
  static final _$getSmsHistory =
      $grpc.ClientMethod<$0.GetSmsHistoryRequest, $0.GetSmsHistoryResponse>(
          '/bulksms.BulkSmsService/GetSmsHistory',
          ($0.GetSmsHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSmsHistoryResponse.fromBuffer(value));
  static final _$getSenderIds =
      $grpc.ClientMethod<$0.GetSenderIdsRequest, $0.GetSenderIdsResponse>(
          '/bulksms.BulkSmsService/GetSenderIds',
          ($0.GetSenderIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSenderIdsResponse.fromBuffer(value));
  static final _$requestSenderId =
      $grpc.ClientMethod<$0.RequestSenderIdRequest, $0.RequestSenderIdResponse>(
          '/bulksms.BulkSmsService/RequestSenderId',
          ($0.RequestSenderIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RequestSenderIdResponse.fromBuffer(value));
  static final _$createRecipientGroup = $grpc.ClientMethod<
          $0.CreateRecipientGroupRequest, $0.RecipientGroupResponse>(
      '/bulksms.BulkSmsService/CreateRecipientGroup',
      ($0.CreateRecipientGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RecipientGroupResponse.fromBuffer(value));
  static final _$listRecipientGroups = $grpc.ClientMethod<
          $0.ListRecipientGroupsRequest, $0.ListRecipientGroupsResponse>(
      '/bulksms.BulkSmsService/ListRecipientGroups',
      ($0.ListRecipientGroupsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListRecipientGroupsResponse.fromBuffer(value));
  static final _$getRecipientGroup = $grpc.ClientMethod<
          $0.GetRecipientGroupRequest, $0.RecipientGroupResponse>(
      '/bulksms.BulkSmsService/GetRecipientGroup',
      ($0.GetRecipientGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RecipientGroupResponse.fromBuffer(value));
  static final _$updateRecipientGroup = $grpc.ClientMethod<
          $0.UpdateRecipientGroupRequest, $0.RecipientGroupResponse>(
      '/bulksms.BulkSmsService/UpdateRecipientGroup',
      ($0.UpdateRecipientGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RecipientGroupResponse.fromBuffer(value));
  static final _$deleteRecipientGroup = $grpc.ClientMethod<
          $0.DeleteRecipientGroupRequest, $0.DeleteRecipientGroupResponse>(
      '/bulksms.BulkSmsService/DeleteRecipientGroup',
      ($0.DeleteRecipientGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteRecipientGroupResponse.fromBuffer(value));
  static final _$listPendingSenderIds = $grpc.ClientMethod<
          $0.ListPendingSenderIdsRequest, $0.GetSenderIdsResponse>(
      '/bulksms.BulkSmsService/ListPendingSenderIds',
      ($0.ListPendingSenderIdsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSenderIdsResponse.fromBuffer(value));
  static final _$approveSenderId =
      $grpc.ClientMethod<$0.ApproveSenderIdRequest, $0.RequestSenderIdResponse>(
          '/bulksms.BulkSmsService/ApproveSenderId',
          ($0.ApproveSenderIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RequestSenderIdResponse.fromBuffer(value));
  static final _$rejectSenderId =
      $grpc.ClientMethod<$0.RejectSenderIdRequest, $0.RequestSenderIdResponse>(
          '/bulksms.BulkSmsService/RejectSenderId',
          ($0.RejectSenderIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RequestSenderIdResponse.fromBuffer(value));

  BulkSmsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetSmsProvidersResponse> getSmsProviders(
      $0.GetSmsProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSmsPackagesResponse> getSmsPackages(
      $0.GetSmsPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsPackages, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSmsBalanceResponse> getSmsBalance(
      $0.GetSmsBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.PurchaseSmsCreditResponse> purchaseSmsCredits(
      $0.PurchaseSmsCreditRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseSmsCredits, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendBulkSmsResponse> sendBulkSms(
      $0.SendBulkSmsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendBulkSms, request, options: options);
  }

  $grpc.ResponseFuture<$0.ScheduleSmsResponse> scheduleSms(
      $0.ScheduleSmsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scheduleSms, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelScheduledSmsResponse> cancelScheduledSms(
      $0.CancelScheduledSmsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelScheduledSms, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSmsCampaignStatusResponse> getSmsCampaignStatus(
      $0.GetSmsCampaignStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsCampaignStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDeliveryReportResponse> getDeliveryReport(
      $0.GetDeliveryReportRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDeliveryReport, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSmsHistoryResponse> getSmsHistory(
      $0.GetSmsHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSmsHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSenderIdsResponse> getSenderIds(
      $0.GetSenderIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSenderIds, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestSenderIdResponse> requestSenderId(
      $0.RequestSenderIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestSenderId, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecipientGroupResponse> createRecipientGroup(
      $0.CreateRecipientGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipientGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListRecipientGroupsResponse> listRecipientGroups(
      $0.ListRecipientGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRecipientGroups, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecipientGroupResponse> getRecipientGroup(
      $0.GetRecipientGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecipientGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecipientGroupResponse> updateRecipientGroup(
      $0.UpdateRecipientGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipientGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteRecipientGroupResponse> deleteRecipientGroup(
      $0.DeleteRecipientGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipientGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSenderIdsResponse> listPendingSenderIds(
      $0.ListPendingSenderIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPendingSenderIds, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestSenderIdResponse> approveSenderId(
      $0.ApproveSenderIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveSenderId, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestSenderIdResponse> rejectSenderId(
      $0.RejectSenderIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$rejectSenderId, request, options: options);
  }
}

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
    $addMethod($grpc.ServiceMethod<$0.CreateRecipientGroupRequest,
            $0.RecipientGroupResponse>(
        'CreateRecipientGroup',
        createRecipientGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateRecipientGroupRequest.fromBuffer(value),
        ($0.RecipientGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListRecipientGroupsRequest,
            $0.ListRecipientGroupsResponse>(
        'ListRecipientGroups',
        listRecipientGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListRecipientGroupsRequest.fromBuffer(value),
        ($0.ListRecipientGroupsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecipientGroupRequest,
            $0.RecipientGroupResponse>(
        'GetRecipientGroup',
        getRecipientGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecipientGroupRequest.fromBuffer(value),
        ($0.RecipientGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateRecipientGroupRequest,
            $0.RecipientGroupResponse>(
        'UpdateRecipientGroup',
        updateRecipientGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateRecipientGroupRequest.fromBuffer(value),
        ($0.RecipientGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRecipientGroupRequest,
            $0.DeleteRecipientGroupResponse>(
        'DeleteRecipientGroup',
        deleteRecipientGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteRecipientGroupRequest.fromBuffer(value),
        ($0.DeleteRecipientGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListPendingSenderIdsRequest,
            $0.GetSenderIdsResponse>(
        'ListPendingSenderIds',
        listPendingSenderIds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListPendingSenderIdsRequest.fromBuffer(value),
        ($0.GetSenderIdsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ApproveSenderIdRequest,
            $0.RequestSenderIdResponse>(
        'ApproveSenderId',
        approveSenderId_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ApproveSenderIdRequest.fromBuffer(value),
        ($0.RequestSenderIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RejectSenderIdRequest,
            $0.RequestSenderIdResponse>(
        'RejectSenderId',
        rejectSenderId_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RejectSenderIdRequest.fromBuffer(value),
        ($0.RequestSenderIdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetSmsProvidersResponse> getSmsProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSmsProvidersRequest> request) async {
    return getSmsProviders(call, await request);
  }

  $async.Future<$0.GetSmsPackagesResponse> getSmsPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSmsPackagesRequest> request) async {
    return getSmsPackages(call, await request);
  }

  $async.Future<$0.GetSmsBalanceResponse> getSmsBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSmsBalanceRequest> request) async {
    return getSmsBalance(call, await request);
  }

  $async.Future<$0.PurchaseSmsCreditResponse> purchaseSmsCredits_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PurchaseSmsCreditRequest> request) async {
    return purchaseSmsCredits(call, await request);
  }

  $async.Future<$0.SendBulkSmsResponse> sendBulkSms_Pre($grpc.ServiceCall call,
      $async.Future<$0.SendBulkSmsRequest> request) async {
    return sendBulkSms(call, await request);
  }

  $async.Future<$0.ScheduleSmsResponse> scheduleSms_Pre($grpc.ServiceCall call,
      $async.Future<$0.ScheduleSmsRequest> request) async {
    return scheduleSms(call, await request);
  }

  $async.Future<$0.CancelScheduledSmsResponse> cancelScheduledSms_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelScheduledSmsRequest> request) async {
    return cancelScheduledSms(call, await request);
  }

  $async.Future<$0.GetSmsCampaignStatusResponse> getSmsCampaignStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSmsCampaignStatusRequest> request) async {
    return getSmsCampaignStatus(call, await request);
  }

  $async.Future<$0.GetDeliveryReportResponse> getDeliveryReport_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDeliveryReportRequest> request) async {
    return getDeliveryReport(call, await request);
  }

  $async.Future<$0.GetSmsHistoryResponse> getSmsHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSmsHistoryRequest> request) async {
    return getSmsHistory(call, await request);
  }

  $async.Future<$0.GetSenderIdsResponse> getSenderIds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSenderIdsRequest> request) async {
    return getSenderIds(call, await request);
  }

  $async.Future<$0.RequestSenderIdResponse> requestSenderId_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RequestSenderIdRequest> request) async {
    return requestSenderId(call, await request);
  }

  $async.Future<$0.RecipientGroupResponse> createRecipientGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateRecipientGroupRequest> request) async {
    return createRecipientGroup(call, await request);
  }

  $async.Future<$0.ListRecipientGroupsResponse> listRecipientGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListRecipientGroupsRequest> request) async {
    return listRecipientGroups(call, await request);
  }

  $async.Future<$0.RecipientGroupResponse> getRecipientGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetRecipientGroupRequest> request) async {
    return getRecipientGroup(call, await request);
  }

  $async.Future<$0.RecipientGroupResponse> updateRecipientGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateRecipientGroupRequest> request) async {
    return updateRecipientGroup(call, await request);
  }

  $async.Future<$0.DeleteRecipientGroupResponse> deleteRecipientGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteRecipientGroupRequest> request) async {
    return deleteRecipientGroup(call, await request);
  }

  $async.Future<$0.GetSenderIdsResponse> listPendingSenderIds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListPendingSenderIdsRequest> request) async {
    return listPendingSenderIds(call, await request);
  }

  $async.Future<$0.RequestSenderIdResponse> approveSenderId_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ApproveSenderIdRequest> request) async {
    return approveSenderId(call, await request);
  }

  $async.Future<$0.RequestSenderIdResponse> rejectSenderId_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RejectSenderIdRequest> request) async {
    return rejectSenderId(call, await request);
  }

  $async.Future<$0.GetSmsProvidersResponse> getSmsProviders(
      $grpc.ServiceCall call, $0.GetSmsProvidersRequest request);
  $async.Future<$0.GetSmsPackagesResponse> getSmsPackages(
      $grpc.ServiceCall call, $0.GetSmsPackagesRequest request);
  $async.Future<$0.GetSmsBalanceResponse> getSmsBalance(
      $grpc.ServiceCall call, $0.GetSmsBalanceRequest request);
  $async.Future<$0.PurchaseSmsCreditResponse> purchaseSmsCredits(
      $grpc.ServiceCall call, $0.PurchaseSmsCreditRequest request);
  $async.Future<$0.SendBulkSmsResponse> sendBulkSms(
      $grpc.ServiceCall call, $0.SendBulkSmsRequest request);
  $async.Future<$0.ScheduleSmsResponse> scheduleSms(
      $grpc.ServiceCall call, $0.ScheduleSmsRequest request);
  $async.Future<$0.CancelScheduledSmsResponse> cancelScheduledSms(
      $grpc.ServiceCall call, $0.CancelScheduledSmsRequest request);
  $async.Future<$0.GetSmsCampaignStatusResponse> getSmsCampaignStatus(
      $grpc.ServiceCall call, $0.GetSmsCampaignStatusRequest request);
  $async.Future<$0.GetDeliveryReportResponse> getDeliveryReport(
      $grpc.ServiceCall call, $0.GetDeliveryReportRequest request);
  $async.Future<$0.GetSmsHistoryResponse> getSmsHistory(
      $grpc.ServiceCall call, $0.GetSmsHistoryRequest request);
  $async.Future<$0.GetSenderIdsResponse> getSenderIds(
      $grpc.ServiceCall call, $0.GetSenderIdsRequest request);
  $async.Future<$0.RequestSenderIdResponse> requestSenderId(
      $grpc.ServiceCall call, $0.RequestSenderIdRequest request);
  $async.Future<$0.RecipientGroupResponse> createRecipientGroup(
      $grpc.ServiceCall call, $0.CreateRecipientGroupRequest request);
  $async.Future<$0.ListRecipientGroupsResponse> listRecipientGroups(
      $grpc.ServiceCall call, $0.ListRecipientGroupsRequest request);
  $async.Future<$0.RecipientGroupResponse> getRecipientGroup(
      $grpc.ServiceCall call, $0.GetRecipientGroupRequest request);
  $async.Future<$0.RecipientGroupResponse> updateRecipientGroup(
      $grpc.ServiceCall call, $0.UpdateRecipientGroupRequest request);
  $async.Future<$0.DeleteRecipientGroupResponse> deleteRecipientGroup(
      $grpc.ServiceCall call, $0.DeleteRecipientGroupRequest request);
  $async.Future<$0.GetSenderIdsResponse> listPendingSenderIds(
      $grpc.ServiceCall call, $0.ListPendingSenderIdsRequest request);
  $async.Future<$0.RequestSenderIdResponse> approveSenderId(
      $grpc.ServiceCall call, $0.ApproveSenderIdRequest request);
  $async.Future<$0.RequestSenderIdResponse> rejectSenderId(
      $grpc.ServiceCall call, $0.RejectSenderIdRequest request);
}
