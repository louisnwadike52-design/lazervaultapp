///
//  Generated code. Do not modify.
//  source: whatsapp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'whatsapp.pb.dart' as $46;
export 'whatsapp.pb.dart';

class WhatsAppServiceClient extends $grpc.Client {
  static final _$initiateLinking = $grpc.ClientMethod<
          $46.InitiateLinkingRequest, $46.InitiateLinkingResponse>(
      '/whatsapp.WhatsAppService/InitiateLinking',
      ($46.InitiateLinkingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $46.InitiateLinkingResponse.fromBuffer(value));
  static final _$verifyLinking =
      $grpc.ClientMethod<$46.VerifyLinkingRequest, $46.VerifyLinkingResponse>(
          '/whatsapp.WhatsAppService/VerifyLinking',
          ($46.VerifyLinkingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.VerifyLinkingResponse.fromBuffer(value));
  static final _$unlinkAccount =
      $grpc.ClientMethod<$46.UnlinkAccountRequest, $46.UnlinkAccountResponse>(
          '/whatsapp.WhatsAppService/UnlinkAccount',
          ($46.UnlinkAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.UnlinkAccountResponse.fromBuffer(value));
  static final _$getLinkStatus =
      $grpc.ClientMethod<$46.GetLinkStatusRequest, $46.GetLinkStatusResponse>(
          '/whatsapp.WhatsAppService/GetLinkStatus',
          ($46.GetLinkStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.GetLinkStatusResponse.fromBuffer(value));
  static final _$handleWebhook =
      $grpc.ClientMethod<$46.WebhookRequest, $46.WebhookResponse>(
          '/whatsapp.WhatsAppService/HandleWebhook',
          ($46.WebhookRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.WebhookResponse.fromBuffer(value));
  static final _$verifyWebhook =
      $grpc.ClientMethod<$46.VerifyWebhookRequest, $46.VerifyWebhookResponse>(
          '/whatsapp.WhatsAppService/VerifyWebhook',
          ($46.VerifyWebhookRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.VerifyWebhookResponse.fromBuffer(value));
  static final _$getSession =
      $grpc.ClientMethod<$46.GetSessionRequest, $46.GetSessionResponse>(
          '/whatsapp.WhatsAppService/GetSession',
          ($46.GetSessionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.GetSessionResponse.fromBuffer(value));
  static final _$invalidateSession = $grpc.ClientMethod<
          $46.InvalidateSessionRequest, $46.InvalidateSessionResponse>(
      '/whatsapp.WhatsAppService/InvalidateSession',
      ($46.InvalidateSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $46.InvalidateSessionResponse.fromBuffer(value));
  static final _$updateSecuritySettings = $grpc.ClientMethod<
          $46.UpdateSecuritySettingsRequest,
          $46.UpdateSecuritySettingsResponse>(
      '/whatsapp.WhatsAppService/UpdateSecuritySettings',
      ($46.UpdateSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $46.UpdateSecuritySettingsResponse.fromBuffer(value));
  static final _$getSecuritySettings = $grpc.ClientMethod<
          $46.GetSecuritySettingsRequest, $46.GetSecuritySettingsResponse>(
      '/whatsapp.WhatsAppService/GetSecuritySettings',
      ($46.GetSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $46.GetSecuritySettingsResponse.fromBuffer(value));
  static final _$getAuditLogs =
      $grpc.ClientMethod<$46.GetAuditLogsRequest, $46.GetAuditLogsResponse>(
          '/whatsapp.WhatsAppService/GetAuditLogs',
          ($46.GetAuditLogsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.GetAuditLogsResponse.fromBuffer(value));

  WhatsAppServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$46.InitiateLinkingResponse> initiateLinking(
      $46.InitiateLinkingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateLinking, request, options: options);
  }

  $grpc.ResponseFuture<$46.VerifyLinkingResponse> verifyLinking(
      $46.VerifyLinkingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyLinking, request, options: options);
  }

  $grpc.ResponseFuture<$46.UnlinkAccountResponse> unlinkAccount(
      $46.UnlinkAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlinkAccount, request, options: options);
  }

  $grpc.ResponseFuture<$46.GetLinkStatusResponse> getLinkStatus(
      $46.GetLinkStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLinkStatus, request, options: options);
  }

  $grpc.ResponseFuture<$46.WebhookResponse> handleWebhook(
      $46.WebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$handleWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$46.VerifyWebhookResponse> verifyWebhook(
      $46.VerifyWebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$46.GetSessionResponse> getSession(
      $46.GetSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSession, request, options: options);
  }

  $grpc.ResponseFuture<$46.InvalidateSessionResponse> invalidateSession(
      $46.InvalidateSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$invalidateSession, request, options: options);
  }

  $grpc.ResponseFuture<$46.UpdateSecuritySettingsResponse>
      updateSecuritySettings($46.UpdateSecuritySettingsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSecuritySettings, request,
        options: options);
  }

  $grpc.ResponseFuture<$46.GetSecuritySettingsResponse> getSecuritySettings(
      $46.GetSecuritySettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSecuritySettings, request, options: options);
  }

  $grpc.ResponseFuture<$46.GetAuditLogsResponse> getAuditLogs(
      $46.GetAuditLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAuditLogs, request, options: options);
  }
}

abstract class WhatsAppServiceBase extends $grpc.Service {
  $core.String get $name => 'whatsapp.WhatsAppService';

  WhatsAppServiceBase() {
    $addMethod($grpc.ServiceMethod<$46.InitiateLinkingRequest,
            $46.InitiateLinkingResponse>(
        'InitiateLinking',
        initiateLinking_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.InitiateLinkingRequest.fromBuffer(value),
        ($46.InitiateLinkingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.VerifyLinkingRequest,
            $46.VerifyLinkingResponse>(
        'VerifyLinking',
        verifyLinking_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.VerifyLinkingRequest.fromBuffer(value),
        ($46.VerifyLinkingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.UnlinkAccountRequest,
            $46.UnlinkAccountResponse>(
        'UnlinkAccount',
        unlinkAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.UnlinkAccountRequest.fromBuffer(value),
        ($46.UnlinkAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.GetLinkStatusRequest,
            $46.GetLinkStatusResponse>(
        'GetLinkStatus',
        getLinkStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.GetLinkStatusRequest.fromBuffer(value),
        ($46.GetLinkStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.WebhookRequest, $46.WebhookResponse>(
        'HandleWebhook',
        handleWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $46.WebhookRequest.fromBuffer(value),
        ($46.WebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.VerifyWebhookRequest,
            $46.VerifyWebhookResponse>(
        'VerifyWebhook',
        verifyWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.VerifyWebhookRequest.fromBuffer(value),
        ($46.VerifyWebhookResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$46.GetSessionRequest, $46.GetSessionResponse>(
            'GetSession',
            getSession_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $46.GetSessionRequest.fromBuffer(value),
            ($46.GetSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.InvalidateSessionRequest,
            $46.InvalidateSessionResponse>(
        'InvalidateSession',
        invalidateSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.InvalidateSessionRequest.fromBuffer(value),
        ($46.InvalidateSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.UpdateSecuritySettingsRequest,
            $46.UpdateSecuritySettingsResponse>(
        'UpdateSecuritySettings',
        updateSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.UpdateSecuritySettingsRequest.fromBuffer(value),
        ($46.UpdateSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.GetSecuritySettingsRequest,
            $46.GetSecuritySettingsResponse>(
        'GetSecuritySettings',
        getSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.GetSecuritySettingsRequest.fromBuffer(value),
        ($46.GetSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$46.GetAuditLogsRequest, $46.GetAuditLogsResponse>(
            'GetAuditLogs',
            getAuditLogs_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $46.GetAuditLogsRequest.fromBuffer(value),
            ($46.GetAuditLogsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$46.InitiateLinkingResponse> initiateLinking_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.InitiateLinkingRequest> request) async {
    return initiateLinking(call, await request);
  }

  $async.Future<$46.VerifyLinkingResponse> verifyLinking_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.VerifyLinkingRequest> request) async {
    return verifyLinking(call, await request);
  }

  $async.Future<$46.UnlinkAccountResponse> unlinkAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.UnlinkAccountRequest> request) async {
    return unlinkAccount(call, await request);
  }

  $async.Future<$46.GetLinkStatusResponse> getLinkStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.GetLinkStatusRequest> request) async {
    return getLinkStatus(call, await request);
  }

  $async.Future<$46.WebhookResponse> handleWebhook_Pre(
      $grpc.ServiceCall call, $async.Future<$46.WebhookRequest> request) async {
    return handleWebhook(call, await request);
  }

  $async.Future<$46.VerifyWebhookResponse> verifyWebhook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.VerifyWebhookRequest> request) async {
    return verifyWebhook(call, await request);
  }

  $async.Future<$46.GetSessionResponse> getSession_Pre($grpc.ServiceCall call,
      $async.Future<$46.GetSessionRequest> request) async {
    return getSession(call, await request);
  }

  $async.Future<$46.InvalidateSessionResponse> invalidateSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.InvalidateSessionRequest> request) async {
    return invalidateSession(call, await request);
  }

  $async.Future<$46.UpdateSecuritySettingsResponse> updateSecuritySettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.UpdateSecuritySettingsRequest> request) async {
    return updateSecuritySettings(call, await request);
  }

  $async.Future<$46.GetSecuritySettingsResponse> getSecuritySettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.GetSecuritySettingsRequest> request) async {
    return getSecuritySettings(call, await request);
  }

  $async.Future<$46.GetAuditLogsResponse> getAuditLogs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.GetAuditLogsRequest> request) async {
    return getAuditLogs(call, await request);
  }

  $async.Future<$46.InitiateLinkingResponse> initiateLinking(
      $grpc.ServiceCall call, $46.InitiateLinkingRequest request);
  $async.Future<$46.VerifyLinkingResponse> verifyLinking(
      $grpc.ServiceCall call, $46.VerifyLinkingRequest request);
  $async.Future<$46.UnlinkAccountResponse> unlinkAccount(
      $grpc.ServiceCall call, $46.UnlinkAccountRequest request);
  $async.Future<$46.GetLinkStatusResponse> getLinkStatus(
      $grpc.ServiceCall call, $46.GetLinkStatusRequest request);
  $async.Future<$46.WebhookResponse> handleWebhook(
      $grpc.ServiceCall call, $46.WebhookRequest request);
  $async.Future<$46.VerifyWebhookResponse> verifyWebhook(
      $grpc.ServiceCall call, $46.VerifyWebhookRequest request);
  $async.Future<$46.GetSessionResponse> getSession(
      $grpc.ServiceCall call, $46.GetSessionRequest request);
  $async.Future<$46.InvalidateSessionResponse> invalidateSession(
      $grpc.ServiceCall call, $46.InvalidateSessionRequest request);
  $async.Future<$46.UpdateSecuritySettingsResponse> updateSecuritySettings(
      $grpc.ServiceCall call, $46.UpdateSecuritySettingsRequest request);
  $async.Future<$46.GetSecuritySettingsResponse> getSecuritySettings(
      $grpc.ServiceCall call, $46.GetSecuritySettingsRequest request);
  $async.Future<$46.GetAuditLogsResponse> getAuditLogs(
      $grpc.ServiceCall call, $46.GetAuditLogsRequest request);
}
