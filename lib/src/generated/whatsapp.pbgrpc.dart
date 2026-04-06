///
//  Generated code. Do not modify.
//  source: whatsapp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'whatsapp.pb.dart' as $45;
export 'whatsapp.pb.dart';

class WhatsAppServiceClient extends $grpc.Client {
  static final _$initiateLinking = $grpc.ClientMethod<
          $45.InitiateLinkingRequest, $45.InitiateLinkingResponse>(
      '/whatsapp.WhatsAppService/InitiateLinking',
      ($45.InitiateLinkingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.InitiateLinkingResponse.fromBuffer(value));
  static final _$verifyLinking =
      $grpc.ClientMethod<$45.VerifyLinkingRequest, $45.VerifyLinkingResponse>(
          '/whatsapp.WhatsAppService/VerifyLinking',
          ($45.VerifyLinkingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.VerifyLinkingResponse.fromBuffer(value));
  static final _$unlinkAccount =
      $grpc.ClientMethod<$45.UnlinkAccountRequest, $45.UnlinkAccountResponse>(
          '/whatsapp.WhatsAppService/UnlinkAccount',
          ($45.UnlinkAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.UnlinkAccountResponse.fromBuffer(value));
  static final _$getLinkStatus =
      $grpc.ClientMethod<$45.GetLinkStatusRequest, $45.GetLinkStatusResponse>(
          '/whatsapp.WhatsAppService/GetLinkStatus',
          ($45.GetLinkStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.GetLinkStatusResponse.fromBuffer(value));
  static final _$handleWebhook =
      $grpc.ClientMethod<$45.WebhookRequest, $45.WebhookResponse>(
          '/whatsapp.WhatsAppService/HandleWebhook',
          ($45.WebhookRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.WebhookResponse.fromBuffer(value));
  static final _$verifyWebhook =
      $grpc.ClientMethod<$45.VerifyWebhookRequest, $45.VerifyWebhookResponse>(
          '/whatsapp.WhatsAppService/VerifyWebhook',
          ($45.VerifyWebhookRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.VerifyWebhookResponse.fromBuffer(value));
  static final _$getSession =
      $grpc.ClientMethod<$45.GetSessionRequest, $45.GetSessionResponse>(
          '/whatsapp.WhatsAppService/GetSession',
          ($45.GetSessionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.GetSessionResponse.fromBuffer(value));
  static final _$invalidateSession = $grpc.ClientMethod<
          $45.InvalidateSessionRequest, $45.InvalidateSessionResponse>(
      '/whatsapp.WhatsAppService/InvalidateSession',
      ($45.InvalidateSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.InvalidateSessionResponse.fromBuffer(value));
  static final _$updateSecuritySettings = $grpc.ClientMethod<
          $45.UpdateSecuritySettingsRequest,
          $45.UpdateSecuritySettingsResponse>(
      '/whatsapp.WhatsAppService/UpdateSecuritySettings',
      ($45.UpdateSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.UpdateSecuritySettingsResponse.fromBuffer(value));
  static final _$getSecuritySettings = $grpc.ClientMethod<
          $45.GetSecuritySettingsRequest, $45.GetSecuritySettingsResponse>(
      '/whatsapp.WhatsAppService/GetSecuritySettings',
      ($45.GetSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.GetSecuritySettingsResponse.fromBuffer(value));
  static final _$getAuditLogs =
      $grpc.ClientMethod<$45.GetAuditLogsRequest, $45.GetAuditLogsResponse>(
          '/whatsapp.WhatsAppService/GetAuditLogs',
          ($45.GetAuditLogsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.GetAuditLogsResponse.fromBuffer(value));

  WhatsAppServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$45.InitiateLinkingResponse> initiateLinking(
      $45.InitiateLinkingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateLinking, request, options: options);
  }

  $grpc.ResponseFuture<$45.VerifyLinkingResponse> verifyLinking(
      $45.VerifyLinkingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyLinking, request, options: options);
  }

  $grpc.ResponseFuture<$45.UnlinkAccountResponse> unlinkAccount(
      $45.UnlinkAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlinkAccount, request, options: options);
  }

  $grpc.ResponseFuture<$45.GetLinkStatusResponse> getLinkStatus(
      $45.GetLinkStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLinkStatus, request, options: options);
  }

  $grpc.ResponseFuture<$45.WebhookResponse> handleWebhook(
      $45.WebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$handleWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$45.VerifyWebhookResponse> verifyWebhook(
      $45.VerifyWebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$45.GetSessionResponse> getSession(
      $45.GetSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSession, request, options: options);
  }

  $grpc.ResponseFuture<$45.InvalidateSessionResponse> invalidateSession(
      $45.InvalidateSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$invalidateSession, request, options: options);
  }

  $grpc.ResponseFuture<$45.UpdateSecuritySettingsResponse>
      updateSecuritySettings($45.UpdateSecuritySettingsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSecuritySettings, request,
        options: options);
  }

  $grpc.ResponseFuture<$45.GetSecuritySettingsResponse> getSecuritySettings(
      $45.GetSecuritySettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSecuritySettings, request, options: options);
  }

  $grpc.ResponseFuture<$45.GetAuditLogsResponse> getAuditLogs(
      $45.GetAuditLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAuditLogs, request, options: options);
  }
}

abstract class WhatsAppServiceBase extends $grpc.Service {
  $core.String get $name => 'whatsapp.WhatsAppService';

  WhatsAppServiceBase() {
    $addMethod($grpc.ServiceMethod<$45.InitiateLinkingRequest,
            $45.InitiateLinkingResponse>(
        'InitiateLinking',
        initiateLinking_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.InitiateLinkingRequest.fromBuffer(value),
        ($45.InitiateLinkingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.VerifyLinkingRequest,
            $45.VerifyLinkingResponse>(
        'VerifyLinking',
        verifyLinking_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.VerifyLinkingRequest.fromBuffer(value),
        ($45.VerifyLinkingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.UnlinkAccountRequest,
            $45.UnlinkAccountResponse>(
        'UnlinkAccount',
        unlinkAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.UnlinkAccountRequest.fromBuffer(value),
        ($45.UnlinkAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.GetLinkStatusRequest,
            $45.GetLinkStatusResponse>(
        'GetLinkStatus',
        getLinkStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.GetLinkStatusRequest.fromBuffer(value),
        ($45.GetLinkStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.WebhookRequest, $45.WebhookResponse>(
        'HandleWebhook',
        handleWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $45.WebhookRequest.fromBuffer(value),
        ($45.WebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.VerifyWebhookRequest,
            $45.VerifyWebhookResponse>(
        'VerifyWebhook',
        verifyWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.VerifyWebhookRequest.fromBuffer(value),
        ($45.VerifyWebhookResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.GetSessionRequest, $45.GetSessionResponse>(
            'GetSession',
            getSession_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.GetSessionRequest.fromBuffer(value),
            ($45.GetSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.InvalidateSessionRequest,
            $45.InvalidateSessionResponse>(
        'InvalidateSession',
        invalidateSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.InvalidateSessionRequest.fromBuffer(value),
        ($45.InvalidateSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.UpdateSecuritySettingsRequest,
            $45.UpdateSecuritySettingsResponse>(
        'UpdateSecuritySettings',
        updateSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.UpdateSecuritySettingsRequest.fromBuffer(value),
        ($45.UpdateSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.GetSecuritySettingsRequest,
            $45.GetSecuritySettingsResponse>(
        'GetSecuritySettings',
        getSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.GetSecuritySettingsRequest.fromBuffer(value),
        ($45.GetSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.GetAuditLogsRequest, $45.GetAuditLogsResponse>(
            'GetAuditLogs',
            getAuditLogs_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.GetAuditLogsRequest.fromBuffer(value),
            ($45.GetAuditLogsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$45.InitiateLinkingResponse> initiateLinking_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.InitiateLinkingRequest> request) async {
    return initiateLinking(call, await request);
  }

  $async.Future<$45.VerifyLinkingResponse> verifyLinking_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.VerifyLinkingRequest> request) async {
    return verifyLinking(call, await request);
  }

  $async.Future<$45.UnlinkAccountResponse> unlinkAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.UnlinkAccountRequest> request) async {
    return unlinkAccount(call, await request);
  }

  $async.Future<$45.GetLinkStatusResponse> getLinkStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.GetLinkStatusRequest> request) async {
    return getLinkStatus(call, await request);
  }

  $async.Future<$45.WebhookResponse> handleWebhook_Pre(
      $grpc.ServiceCall call, $async.Future<$45.WebhookRequest> request) async {
    return handleWebhook(call, await request);
  }

  $async.Future<$45.VerifyWebhookResponse> verifyWebhook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.VerifyWebhookRequest> request) async {
    return verifyWebhook(call, await request);
  }

  $async.Future<$45.GetSessionResponse> getSession_Pre($grpc.ServiceCall call,
      $async.Future<$45.GetSessionRequest> request) async {
    return getSession(call, await request);
  }

  $async.Future<$45.InvalidateSessionResponse> invalidateSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.InvalidateSessionRequest> request) async {
    return invalidateSession(call, await request);
  }

  $async.Future<$45.UpdateSecuritySettingsResponse> updateSecuritySettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.UpdateSecuritySettingsRequest> request) async {
    return updateSecuritySettings(call, await request);
  }

  $async.Future<$45.GetSecuritySettingsResponse> getSecuritySettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.GetSecuritySettingsRequest> request) async {
    return getSecuritySettings(call, await request);
  }

  $async.Future<$45.GetAuditLogsResponse> getAuditLogs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.GetAuditLogsRequest> request) async {
    return getAuditLogs(call, await request);
  }

  $async.Future<$45.InitiateLinkingResponse> initiateLinking(
      $grpc.ServiceCall call, $45.InitiateLinkingRequest request);
  $async.Future<$45.VerifyLinkingResponse> verifyLinking(
      $grpc.ServiceCall call, $45.VerifyLinkingRequest request);
  $async.Future<$45.UnlinkAccountResponse> unlinkAccount(
      $grpc.ServiceCall call, $45.UnlinkAccountRequest request);
  $async.Future<$45.GetLinkStatusResponse> getLinkStatus(
      $grpc.ServiceCall call, $45.GetLinkStatusRequest request);
  $async.Future<$45.WebhookResponse> handleWebhook(
      $grpc.ServiceCall call, $45.WebhookRequest request);
  $async.Future<$45.VerifyWebhookResponse> verifyWebhook(
      $grpc.ServiceCall call, $45.VerifyWebhookRequest request);
  $async.Future<$45.GetSessionResponse> getSession(
      $grpc.ServiceCall call, $45.GetSessionRequest request);
  $async.Future<$45.InvalidateSessionResponse> invalidateSession(
      $grpc.ServiceCall call, $45.InvalidateSessionRequest request);
  $async.Future<$45.UpdateSecuritySettingsResponse> updateSecuritySettings(
      $grpc.ServiceCall call, $45.UpdateSecuritySettingsRequest request);
  $async.Future<$45.GetSecuritySettingsResponse> getSecuritySettings(
      $grpc.ServiceCall call, $45.GetSecuritySettingsRequest request);
  $async.Future<$45.GetAuditLogsResponse> getAuditLogs(
      $grpc.ServiceCall call, $45.GetAuditLogsRequest request);
}
