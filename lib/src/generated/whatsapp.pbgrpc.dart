//
//  Generated code. Do not modify.
//  source: whatsapp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'whatsapp.pb.dart' as $0;

export 'whatsapp.pb.dart';

@$pb.GrpcServiceName('whatsapp.WhatsAppService')
class WhatsAppServiceClient extends $grpc.Client {
  static final _$initiateLinking = $grpc.ClientMethod<$0.InitiateLinkingRequest, $0.InitiateLinkingResponse>(
      '/whatsapp.WhatsAppService/InitiateLinking',
      ($0.InitiateLinkingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InitiateLinkingResponse.fromBuffer(value));
  static final _$verifyLinking = $grpc.ClientMethod<$0.VerifyLinkingRequest, $0.VerifyLinkingResponse>(
      '/whatsapp.WhatsAppService/VerifyLinking',
      ($0.VerifyLinkingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyLinkingResponse.fromBuffer(value));
  static final _$unlinkAccount = $grpc.ClientMethod<$0.UnlinkAccountRequest, $0.UnlinkAccountResponse>(
      '/whatsapp.WhatsAppService/UnlinkAccount',
      ($0.UnlinkAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnlinkAccountResponse.fromBuffer(value));
  static final _$getLinkStatus = $grpc.ClientMethod<$0.GetLinkStatusRequest, $0.GetLinkStatusResponse>(
      '/whatsapp.WhatsAppService/GetLinkStatus',
      ($0.GetLinkStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLinkStatusResponse.fromBuffer(value));
  static final _$handleWebhook = $grpc.ClientMethod<$0.WebhookRequest, $0.WebhookResponse>(
      '/whatsapp.WhatsAppService/HandleWebhook',
      ($0.WebhookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.WebhookResponse.fromBuffer(value));
  static final _$verifyWebhook = $grpc.ClientMethod<$0.VerifyWebhookRequest, $0.VerifyWebhookResponse>(
      '/whatsapp.WhatsAppService/VerifyWebhook',
      ($0.VerifyWebhookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyWebhookResponse.fromBuffer(value));
  static final _$getSession = $grpc.ClientMethod<$0.GetSessionRequest, $0.GetSessionResponse>(
      '/whatsapp.WhatsAppService/GetSession',
      ($0.GetSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSessionResponse.fromBuffer(value));
  static final _$invalidateSession = $grpc.ClientMethod<$0.InvalidateSessionRequest, $0.InvalidateSessionResponse>(
      '/whatsapp.WhatsAppService/InvalidateSession',
      ($0.InvalidateSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InvalidateSessionResponse.fromBuffer(value));
  static final _$updateSecuritySettings = $grpc.ClientMethod<$0.UpdateSecuritySettingsRequest, $0.UpdateSecuritySettingsResponse>(
      '/whatsapp.WhatsAppService/UpdateSecuritySettings',
      ($0.UpdateSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateSecuritySettingsResponse.fromBuffer(value));
  static final _$getSecuritySettings = $grpc.ClientMethod<$0.GetSecuritySettingsRequest, $0.GetSecuritySettingsResponse>(
      '/whatsapp.WhatsAppService/GetSecuritySettings',
      ($0.GetSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSecuritySettingsResponse.fromBuffer(value));
  static final _$getAuditLogs = $grpc.ClientMethod<$0.GetAuditLogsRequest, $0.GetAuditLogsResponse>(
      '/whatsapp.WhatsAppService/GetAuditLogs',
      ($0.GetAuditLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAuditLogsResponse.fromBuffer(value));

  WhatsAppServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.InitiateLinkingResponse> initiateLinking($0.InitiateLinkingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateLinking, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyLinkingResponse> verifyLinking($0.VerifyLinkingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyLinking, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnlinkAccountResponse> unlinkAccount($0.UnlinkAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlinkAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLinkStatusResponse> getLinkStatus($0.GetLinkStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLinkStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.WebhookResponse> handleWebhook($0.WebhookRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$handleWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyWebhookResponse> verifyWebhook($0.VerifyWebhookRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSessionResponse> getSession($0.GetSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSession, request, options: options);
  }

  $grpc.ResponseFuture<$0.InvalidateSessionResponse> invalidateSession($0.InvalidateSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$invalidateSession, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSecuritySettingsResponse> updateSecuritySettings($0.UpdateSecuritySettingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSecuritySettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSecuritySettingsResponse> getSecuritySettings($0.GetSecuritySettingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSecuritySettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAuditLogsResponse> getAuditLogs($0.GetAuditLogsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAuditLogs, request, options: options);
  }
}

@$pb.GrpcServiceName('whatsapp.WhatsAppService')
abstract class WhatsAppServiceBase extends $grpc.Service {
  $core.String get $name => 'whatsapp.WhatsAppService';

  WhatsAppServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InitiateLinkingRequest, $0.InitiateLinkingResponse>(
        'InitiateLinking',
        initiateLinking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InitiateLinkingRequest.fromBuffer(value),
        ($0.InitiateLinkingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyLinkingRequest, $0.VerifyLinkingResponse>(
        'VerifyLinking',
        verifyLinking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyLinkingRequest.fromBuffer(value),
        ($0.VerifyLinkingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlinkAccountRequest, $0.UnlinkAccountResponse>(
        'UnlinkAccount',
        unlinkAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnlinkAccountRequest.fromBuffer(value),
        ($0.UnlinkAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLinkStatusRequest, $0.GetLinkStatusResponse>(
        'GetLinkStatus',
        getLinkStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLinkStatusRequest.fromBuffer(value),
        ($0.GetLinkStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WebhookRequest, $0.WebhookResponse>(
        'HandleWebhook',
        handleWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WebhookRequest.fromBuffer(value),
        ($0.WebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyWebhookRequest, $0.VerifyWebhookResponse>(
        'VerifyWebhook',
        verifyWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyWebhookRequest.fromBuffer(value),
        ($0.VerifyWebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSessionRequest, $0.GetSessionResponse>(
        'GetSession',
        getSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSessionRequest.fromBuffer(value),
        ($0.GetSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InvalidateSessionRequest, $0.InvalidateSessionResponse>(
        'InvalidateSession',
        invalidateSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InvalidateSessionRequest.fromBuffer(value),
        ($0.InvalidateSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSecuritySettingsRequest, $0.UpdateSecuritySettingsResponse>(
        'UpdateSecuritySettings',
        updateSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateSecuritySettingsRequest.fromBuffer(value),
        ($0.UpdateSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSecuritySettingsRequest, $0.GetSecuritySettingsResponse>(
        'GetSecuritySettings',
        getSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSecuritySettingsRequest.fromBuffer(value),
        ($0.GetSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAuditLogsRequest, $0.GetAuditLogsResponse>(
        'GetAuditLogs',
        getAuditLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAuditLogsRequest.fromBuffer(value),
        ($0.GetAuditLogsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.InitiateLinkingResponse> initiateLinking_Pre($grpc.ServiceCall call, $async.Future<$0.InitiateLinkingRequest> request) async {
    return initiateLinking(call, await request);
  }

  $async.Future<$0.VerifyLinkingResponse> verifyLinking_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyLinkingRequest> request) async {
    return verifyLinking(call, await request);
  }

  $async.Future<$0.UnlinkAccountResponse> unlinkAccount_Pre($grpc.ServiceCall call, $async.Future<$0.UnlinkAccountRequest> request) async {
    return unlinkAccount(call, await request);
  }

  $async.Future<$0.GetLinkStatusResponse> getLinkStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetLinkStatusRequest> request) async {
    return getLinkStatus(call, await request);
  }

  $async.Future<$0.WebhookResponse> handleWebhook_Pre($grpc.ServiceCall call, $async.Future<$0.WebhookRequest> request) async {
    return handleWebhook(call, await request);
  }

  $async.Future<$0.VerifyWebhookResponse> verifyWebhook_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyWebhookRequest> request) async {
    return verifyWebhook(call, await request);
  }

  $async.Future<$0.GetSessionResponse> getSession_Pre($grpc.ServiceCall call, $async.Future<$0.GetSessionRequest> request) async {
    return getSession(call, await request);
  }

  $async.Future<$0.InvalidateSessionResponse> invalidateSession_Pre($grpc.ServiceCall call, $async.Future<$0.InvalidateSessionRequest> request) async {
    return invalidateSession(call, await request);
  }

  $async.Future<$0.UpdateSecuritySettingsResponse> updateSecuritySettings_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateSecuritySettingsRequest> request) async {
    return updateSecuritySettings(call, await request);
  }

  $async.Future<$0.GetSecuritySettingsResponse> getSecuritySettings_Pre($grpc.ServiceCall call, $async.Future<$0.GetSecuritySettingsRequest> request) async {
    return getSecuritySettings(call, await request);
  }

  $async.Future<$0.GetAuditLogsResponse> getAuditLogs_Pre($grpc.ServiceCall call, $async.Future<$0.GetAuditLogsRequest> request) async {
    return getAuditLogs(call, await request);
  }

  $async.Future<$0.InitiateLinkingResponse> initiateLinking($grpc.ServiceCall call, $0.InitiateLinkingRequest request);
  $async.Future<$0.VerifyLinkingResponse> verifyLinking($grpc.ServiceCall call, $0.VerifyLinkingRequest request);
  $async.Future<$0.UnlinkAccountResponse> unlinkAccount($grpc.ServiceCall call, $0.UnlinkAccountRequest request);
  $async.Future<$0.GetLinkStatusResponse> getLinkStatus($grpc.ServiceCall call, $0.GetLinkStatusRequest request);
  $async.Future<$0.WebhookResponse> handleWebhook($grpc.ServiceCall call, $0.WebhookRequest request);
  $async.Future<$0.VerifyWebhookResponse> verifyWebhook($grpc.ServiceCall call, $0.VerifyWebhookRequest request);
  $async.Future<$0.GetSessionResponse> getSession($grpc.ServiceCall call, $0.GetSessionRequest request);
  $async.Future<$0.InvalidateSessionResponse> invalidateSession($grpc.ServiceCall call, $0.InvalidateSessionRequest request);
  $async.Future<$0.UpdateSecuritySettingsResponse> updateSecuritySettings($grpc.ServiceCall call, $0.UpdateSecuritySettingsRequest request);
  $async.Future<$0.GetSecuritySettingsResponse> getSecuritySettings($grpc.ServiceCall call, $0.GetSecuritySettingsRequest request);
  $async.Future<$0.GetAuditLogsResponse> getAuditLogs($grpc.ServiceCall call, $0.GetAuditLogsRequest request);
}
