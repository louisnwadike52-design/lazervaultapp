//
//  Generated code. Do not modify.
//  source: whatsapp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class InitiateLinkingRequest extends $pb.GeneratedMessage {
  factory InitiateLinkingRequest({
    $core.String? phoneNumber,
  }) {
    final $result = create();
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    return $result;
  }
  InitiateLinkingRequest._() : super();
  factory InitiateLinkingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateLinkingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateLinkingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateLinkingRequest clone() => InitiateLinkingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateLinkingRequest copyWith(void Function(InitiateLinkingRequest) updates) => super.copyWith((message) => updates(message as InitiateLinkingRequest)) as InitiateLinkingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateLinkingRequest create() => InitiateLinkingRequest._();
  InitiateLinkingRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateLinkingRequest> createRepeated() => $pb.PbList<InitiateLinkingRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateLinkingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateLinkingRequest>(create);
  static InitiateLinkingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);
}

class InitiateLinkingResponse extends $pb.GeneratedMessage {
  factory InitiateLinkingResponse({
    $core.String? otpReference,
    $core.String? message,
    $1.Timestamp? expiresAt,
  }) {
    final $result = create();
    if (otpReference != null) {
      $result.otpReference = otpReference;
    }
    if (message != null) {
      $result.message = message;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    return $result;
  }
  InitiateLinkingResponse._() : super();
  factory InitiateLinkingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateLinkingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateLinkingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'otpReference')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateLinkingResponse clone() => InitiateLinkingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateLinkingResponse copyWith(void Function(InitiateLinkingResponse) updates) => super.copyWith((message) => updates(message as InitiateLinkingResponse)) as InitiateLinkingResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateLinkingResponse create() => InitiateLinkingResponse._();
  InitiateLinkingResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateLinkingResponse> createRepeated() => $pb.PbList<InitiateLinkingResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateLinkingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateLinkingResponse>(create);
  static InitiateLinkingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get otpReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set otpReference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOtpReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearOtpReference() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureExpiresAt() => $_ensure(2);
}

class VerifyLinkingRequest extends $pb.GeneratedMessage {
  factory VerifyLinkingRequest({
    $core.String? phoneNumber,
    $core.String? otpCode,
  }) {
    final $result = create();
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (otpCode != null) {
      $result.otpCode = otpCode;
    }
    return $result;
  }
  VerifyLinkingRequest._() : super();
  factory VerifyLinkingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyLinkingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyLinkingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'otpCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyLinkingRequest clone() => VerifyLinkingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyLinkingRequest copyWith(void Function(VerifyLinkingRequest) updates) => super.copyWith((message) => updates(message as VerifyLinkingRequest)) as VerifyLinkingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyLinkingRequest create() => VerifyLinkingRequest._();
  VerifyLinkingRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyLinkingRequest> createRepeated() => $pb.PbList<VerifyLinkingRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyLinkingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyLinkingRequest>(create);
  static VerifyLinkingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get otpCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set otpCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOtpCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearOtpCode() => clearField(2);
}

class VerifyLinkingResponse extends $pb.GeneratedMessage {
  factory VerifyLinkingResponse({
    $core.bool? success,
    $core.String? message,
    WhatsAppUser? whatsappUser,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (whatsappUser != null) {
      $result.whatsappUser = whatsappUser;
    }
    return $result;
  }
  VerifyLinkingResponse._() : super();
  factory VerifyLinkingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyLinkingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyLinkingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<WhatsAppUser>(3, _omitFieldNames ? '' : 'whatsappUser', subBuilder: WhatsAppUser.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyLinkingResponse clone() => VerifyLinkingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyLinkingResponse copyWith(void Function(VerifyLinkingResponse) updates) => super.copyWith((message) => updates(message as VerifyLinkingResponse)) as VerifyLinkingResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyLinkingResponse create() => VerifyLinkingResponse._();
  VerifyLinkingResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyLinkingResponse> createRepeated() => $pb.PbList<VerifyLinkingResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyLinkingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyLinkingResponse>(create);
  static VerifyLinkingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  WhatsAppUser get whatsappUser => $_getN(2);
  @$pb.TagNumber(3)
  set whatsappUser(WhatsAppUser v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWhatsappUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhatsappUser() => clearField(3);
  @$pb.TagNumber(3)
  WhatsAppUser ensureWhatsappUser() => $_ensure(2);
}

class UnlinkAccountRequest extends $pb.GeneratedMessage {
  factory UnlinkAccountRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  UnlinkAccountRequest._() : super();
  factory UnlinkAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnlinkAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkAccountRequest clone() => UnlinkAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkAccountRequest copyWith(void Function(UnlinkAccountRequest) updates) => super.copyWith((message) => updates(message as UnlinkAccountRequest)) as UnlinkAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkAccountRequest create() => UnlinkAccountRequest._();
  UnlinkAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnlinkAccountRequest> createRepeated() => $pb.PbList<UnlinkAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlinkAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlinkAccountRequest>(create);
  static UnlinkAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class UnlinkAccountResponse extends $pb.GeneratedMessage {
  factory UnlinkAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UnlinkAccountResponse._() : super();
  factory UnlinkAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnlinkAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkAccountResponse clone() => UnlinkAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkAccountResponse copyWith(void Function(UnlinkAccountResponse) updates) => super.copyWith((message) => updates(message as UnlinkAccountResponse)) as UnlinkAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkAccountResponse create() => UnlinkAccountResponse._();
  UnlinkAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnlinkAccountResponse> createRepeated() => $pb.PbList<UnlinkAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlinkAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlinkAccountResponse>(create);
  static UnlinkAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetLinkStatusRequest extends $pb.GeneratedMessage {
  factory GetLinkStatusRequest() => create();
  GetLinkStatusRequest._() : super();
  factory GetLinkStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLinkStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkStatusRequest clone() => GetLinkStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkStatusRequest copyWith(void Function(GetLinkStatusRequest) updates) => super.copyWith((message) => updates(message as GetLinkStatusRequest)) as GetLinkStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkStatusRequest create() => GetLinkStatusRequest._();
  GetLinkStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkStatusRequest> createRepeated() => $pb.PbList<GetLinkStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLinkStatusRequest>(create);
  static GetLinkStatusRequest? _defaultInstance;
}

class GetLinkStatusResponse extends $pb.GeneratedMessage {
  factory GetLinkStatusResponse({
    WhatsAppUser? whatsappUser,
  }) {
    final $result = create();
    if (whatsappUser != null) {
      $result.whatsappUser = whatsappUser;
    }
    return $result;
  }
  GetLinkStatusResponse._() : super();
  factory GetLinkStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLinkStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<WhatsAppUser>(1, _omitFieldNames ? '' : 'whatsappUser', subBuilder: WhatsAppUser.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkStatusResponse clone() => GetLinkStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkStatusResponse copyWith(void Function(GetLinkStatusResponse) updates) => super.copyWith((message) => updates(message as GetLinkStatusResponse)) as GetLinkStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkStatusResponse create() => GetLinkStatusResponse._();
  GetLinkStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetLinkStatusResponse> createRepeated() => $pb.PbList<GetLinkStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLinkStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLinkStatusResponse>(create);
  static GetLinkStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WhatsAppUser get whatsappUser => $_getN(0);
  @$pb.TagNumber(1)
  set whatsappUser(WhatsAppUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWhatsappUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearWhatsappUser() => clearField(1);
  @$pb.TagNumber(1)
  WhatsAppUser ensureWhatsappUser() => $_ensure(0);
}

class WebhookRequest extends $pb.GeneratedMessage {
  factory WebhookRequest({
    $core.String? object,
    $core.Iterable<WebhookEntry>? entry,
  }) {
    final $result = create();
    if (object != null) {
      $result.object = object;
    }
    if (entry != null) {
      $result.entry.addAll(entry);
    }
    return $result;
  }
  WebhookRequest._() : super();
  factory WebhookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'object')
    ..pc<WebhookEntry>(2, _omitFieldNames ? '' : 'entry', $pb.PbFieldType.PM, subBuilder: WebhookEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookRequest clone() => WebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookRequest copyWith(void Function(WebhookRequest) updates) => super.copyWith((message) => updates(message as WebhookRequest)) as WebhookRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookRequest create() => WebhookRequest._();
  WebhookRequest createEmptyInstance() => create();
  static $pb.PbList<WebhookRequest> createRepeated() => $pb.PbList<WebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static WebhookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookRequest>(create);
  static WebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get object => $_getSZ(0);
  @$pb.TagNumber(1)
  set object($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObject() => $_has(0);
  @$pb.TagNumber(1)
  void clearObject() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<WebhookEntry> get entry => $_getList(1);
}

class WebhookEntry extends $pb.GeneratedMessage {
  factory WebhookEntry({
    $core.String? id,
    $core.Iterable<WebhookChange>? changes,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (changes != null) {
      $result.changes.addAll(changes);
    }
    return $result;
  }
  WebhookEntry._() : super();
  factory WebhookEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pc<WebhookChange>(2, _omitFieldNames ? '' : 'changes', $pb.PbFieldType.PM, subBuilder: WebhookChange.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookEntry clone() => WebhookEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookEntry copyWith(void Function(WebhookEntry) updates) => super.copyWith((message) => updates(message as WebhookEntry)) as WebhookEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookEntry create() => WebhookEntry._();
  WebhookEntry createEmptyInstance() => create();
  static $pb.PbList<WebhookEntry> createRepeated() => $pb.PbList<WebhookEntry>();
  @$core.pragma('dart2js:noInline')
  static WebhookEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookEntry>(create);
  static WebhookEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<WebhookChange> get changes => $_getList(1);
}

class WebhookChange extends $pb.GeneratedMessage {
  factory WebhookChange({
    $core.String? field_1,
    WebhookValue? value,
  }) {
    final $result = create();
    if (field_1 != null) {
      $result.field_1 = field_1;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  WebhookChange._() : super();
  factory WebhookChange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookChange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookChange', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOM<WebhookValue>(2, _omitFieldNames ? '' : 'value', subBuilder: WebhookValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookChange clone() => WebhookChange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookChange copyWith(void Function(WebhookChange) updates) => super.copyWith((message) => updates(message as WebhookChange)) as WebhookChange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookChange create() => WebhookChange._();
  WebhookChange createEmptyInstance() => create();
  static $pb.PbList<WebhookChange> createRepeated() => $pb.PbList<WebhookChange>();
  @$core.pragma('dart2js:noInline')
  static WebhookChange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookChange>(create);
  static WebhookChange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => clearField(1);

  @$pb.TagNumber(2)
  WebhookValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(WebhookValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  WebhookValue ensureValue() => $_ensure(1);
}

class WebhookValue extends $pb.GeneratedMessage {
  factory WebhookValue({
    $core.String? messagingProduct,
    WebhookMetadata? metadata,
    $core.Iterable<WebhookContact>? contacts,
    $core.Iterable<WebhookMessage>? messages,
    $core.Iterable<WebhookStatus>? statuses,
  }) {
    final $result = create();
    if (messagingProduct != null) {
      $result.messagingProduct = messagingProduct;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (contacts != null) {
      $result.contacts.addAll(contacts);
    }
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    if (statuses != null) {
      $result.statuses.addAll(statuses);
    }
    return $result;
  }
  WebhookValue._() : super();
  factory WebhookValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messagingProduct')
    ..aOM<WebhookMetadata>(2, _omitFieldNames ? '' : 'metadata', subBuilder: WebhookMetadata.create)
    ..pc<WebhookContact>(3, _omitFieldNames ? '' : 'contacts', $pb.PbFieldType.PM, subBuilder: WebhookContact.create)
    ..pc<WebhookMessage>(4, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: WebhookMessage.create)
    ..pc<WebhookStatus>(5, _omitFieldNames ? '' : 'statuses', $pb.PbFieldType.PM, subBuilder: WebhookStatus.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookValue clone() => WebhookValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookValue copyWith(void Function(WebhookValue) updates) => super.copyWith((message) => updates(message as WebhookValue)) as WebhookValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookValue create() => WebhookValue._();
  WebhookValue createEmptyInstance() => create();
  static $pb.PbList<WebhookValue> createRepeated() => $pb.PbList<WebhookValue>();
  @$core.pragma('dart2js:noInline')
  static WebhookValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookValue>(create);
  static WebhookValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messagingProduct => $_getSZ(0);
  @$pb.TagNumber(1)
  set messagingProduct($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessagingProduct() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessagingProduct() => clearField(1);

  @$pb.TagNumber(2)
  WebhookMetadata get metadata => $_getN(1);
  @$pb.TagNumber(2)
  set metadata(WebhookMetadata v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => clearField(2);
  @$pb.TagNumber(2)
  WebhookMetadata ensureMetadata() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<WebhookContact> get contacts => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<WebhookMessage> get messages => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<WebhookStatus> get statuses => $_getList(4);
}

class WebhookMetadata extends $pb.GeneratedMessage {
  factory WebhookMetadata({
    $core.String? displayPhoneNumber,
    $core.String? phoneNumberId,
  }) {
    final $result = create();
    if (displayPhoneNumber != null) {
      $result.displayPhoneNumber = displayPhoneNumber;
    }
    if (phoneNumberId != null) {
      $result.phoneNumberId = phoneNumberId;
    }
    return $result;
  }
  WebhookMetadata._() : super();
  factory WebhookMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'displayPhoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'phoneNumberId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookMetadata clone() => WebhookMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookMetadata copyWith(void Function(WebhookMetadata) updates) => super.copyWith((message) => updates(message as WebhookMetadata)) as WebhookMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookMetadata create() => WebhookMetadata._();
  WebhookMetadata createEmptyInstance() => create();
  static $pb.PbList<WebhookMetadata> createRepeated() => $pb.PbList<WebhookMetadata>();
  @$core.pragma('dart2js:noInline')
  static WebhookMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookMetadata>(create);
  static WebhookMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayPhoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayPhoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisplayPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get phoneNumberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set phoneNumberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPhoneNumberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoneNumberId() => clearField(2);
}

class WebhookContact extends $pb.GeneratedMessage {
  factory WebhookContact({
    $core.String? profileName,
    $core.String? waId,
  }) {
    final $result = create();
    if (profileName != null) {
      $result.profileName = profileName;
    }
    if (waId != null) {
      $result.waId = waId;
    }
    return $result;
  }
  WebhookContact._() : super();
  factory WebhookContact.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookContact.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookContact', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'profileName')
    ..aOS(2, _omitFieldNames ? '' : 'waId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookContact clone() => WebhookContact()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookContact copyWith(void Function(WebhookContact) updates) => super.copyWith((message) => updates(message as WebhookContact)) as WebhookContact;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookContact create() => WebhookContact._();
  WebhookContact createEmptyInstance() => create();
  static $pb.PbList<WebhookContact> createRepeated() => $pb.PbList<WebhookContact>();
  @$core.pragma('dart2js:noInline')
  static WebhookContact getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookContact>(create);
  static WebhookContact? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get profileName => $_getSZ(0);
  @$pb.TagNumber(1)
  set profileName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfileName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfileName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get waId => $_getSZ(1);
  @$pb.TagNumber(2)
  set waId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWaId() => clearField(2);
}

class WebhookMessage extends $pb.GeneratedMessage {
  factory WebhookMessage({
    $core.String? from,
    $core.String? id,
    $core.String? timestamp,
    $core.String? type,
    WebhookTextMessage? text,
    WebhookInteractiveMessage? interactive,
  }) {
    final $result = create();
    if (from != null) {
      $result.from = from;
    }
    if (id != null) {
      $result.id = id;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (type != null) {
      $result.type = type;
    }
    if (text != null) {
      $result.text = text;
    }
    if (interactive != null) {
      $result.interactive = interactive;
    }
    return $result;
  }
  WebhookMessage._() : super();
  factory WebhookMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'from')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOM<WebhookTextMessage>(5, _omitFieldNames ? '' : 'text', subBuilder: WebhookTextMessage.create)
    ..aOM<WebhookInteractiveMessage>(6, _omitFieldNames ? '' : 'interactive', subBuilder: WebhookInteractiveMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookMessage clone() => WebhookMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookMessage copyWith(void Function(WebhookMessage) updates) => super.copyWith((message) => updates(message as WebhookMessage)) as WebhookMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookMessage create() => WebhookMessage._();
  WebhookMessage createEmptyInstance() => create();
  static $pb.PbList<WebhookMessage> createRepeated() => $pb.PbList<WebhookMessage>();
  @$core.pragma('dart2js:noInline')
  static WebhookMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookMessage>(create);
  static WebhookMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get from => $_getSZ(0);
  @$pb.TagNumber(1)
  set from($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  WebhookTextMessage get text => $_getN(4);
  @$pb.TagNumber(5)
  set text(WebhookTextMessage v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasText() => $_has(4);
  @$pb.TagNumber(5)
  void clearText() => clearField(5);
  @$pb.TagNumber(5)
  WebhookTextMessage ensureText() => $_ensure(4);

  @$pb.TagNumber(6)
  WebhookInteractiveMessage get interactive => $_getN(5);
  @$pb.TagNumber(6)
  set interactive(WebhookInteractiveMessage v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasInteractive() => $_has(5);
  @$pb.TagNumber(6)
  void clearInteractive() => clearField(6);
  @$pb.TagNumber(6)
  WebhookInteractiveMessage ensureInteractive() => $_ensure(5);
}

class WebhookTextMessage extends $pb.GeneratedMessage {
  factory WebhookTextMessage({
    $core.String? body,
  }) {
    final $result = create();
    if (body != null) {
      $result.body = body;
    }
    return $result;
  }
  WebhookTextMessage._() : super();
  factory WebhookTextMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookTextMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookTextMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookTextMessage clone() => WebhookTextMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookTextMessage copyWith(void Function(WebhookTextMessage) updates) => super.copyWith((message) => updates(message as WebhookTextMessage)) as WebhookTextMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookTextMessage create() => WebhookTextMessage._();
  WebhookTextMessage createEmptyInstance() => create();
  static $pb.PbList<WebhookTextMessage> createRepeated() => $pb.PbList<WebhookTextMessage>();
  @$core.pragma('dart2js:noInline')
  static WebhookTextMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookTextMessage>(create);
  static WebhookTextMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get body => $_getSZ(0);
  @$pb.TagNumber(1)
  set body($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBody() => $_has(0);
  @$pb.TagNumber(1)
  void clearBody() => clearField(1);
}

class WebhookInteractiveMessage extends $pb.GeneratedMessage {
  factory WebhookInteractiveMessage({
    $core.String? type,
    WebhookButtonReply? buttonReply,
    WebhookListReply? listReply,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (buttonReply != null) {
      $result.buttonReply = buttonReply;
    }
    if (listReply != null) {
      $result.listReply = listReply;
    }
    return $result;
  }
  WebhookInteractiveMessage._() : super();
  factory WebhookInteractiveMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookInteractiveMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookInteractiveMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOM<WebhookButtonReply>(2, _omitFieldNames ? '' : 'buttonReply', subBuilder: WebhookButtonReply.create)
    ..aOM<WebhookListReply>(3, _omitFieldNames ? '' : 'listReply', subBuilder: WebhookListReply.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookInteractiveMessage clone() => WebhookInteractiveMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookInteractiveMessage copyWith(void Function(WebhookInteractiveMessage) updates) => super.copyWith((message) => updates(message as WebhookInteractiveMessage)) as WebhookInteractiveMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookInteractiveMessage create() => WebhookInteractiveMessage._();
  WebhookInteractiveMessage createEmptyInstance() => create();
  static $pb.PbList<WebhookInteractiveMessage> createRepeated() => $pb.PbList<WebhookInteractiveMessage>();
  @$core.pragma('dart2js:noInline')
  static WebhookInteractiveMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookInteractiveMessage>(create);
  static WebhookInteractiveMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  WebhookButtonReply get buttonReply => $_getN(1);
  @$pb.TagNumber(2)
  set buttonReply(WebhookButtonReply v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasButtonReply() => $_has(1);
  @$pb.TagNumber(2)
  void clearButtonReply() => clearField(2);
  @$pb.TagNumber(2)
  WebhookButtonReply ensureButtonReply() => $_ensure(1);

  @$pb.TagNumber(3)
  WebhookListReply get listReply => $_getN(2);
  @$pb.TagNumber(3)
  set listReply(WebhookListReply v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasListReply() => $_has(2);
  @$pb.TagNumber(3)
  void clearListReply() => clearField(3);
  @$pb.TagNumber(3)
  WebhookListReply ensureListReply() => $_ensure(2);
}

class WebhookButtonReply extends $pb.GeneratedMessage {
  factory WebhookButtonReply({
    $core.String? id,
    $core.String? title,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    return $result;
  }
  WebhookButtonReply._() : super();
  factory WebhookButtonReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookButtonReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookButtonReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookButtonReply clone() => WebhookButtonReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookButtonReply copyWith(void Function(WebhookButtonReply) updates) => super.copyWith((message) => updates(message as WebhookButtonReply)) as WebhookButtonReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookButtonReply create() => WebhookButtonReply._();
  WebhookButtonReply createEmptyInstance() => create();
  static $pb.PbList<WebhookButtonReply> createRepeated() => $pb.PbList<WebhookButtonReply>();
  @$core.pragma('dart2js:noInline')
  static WebhookButtonReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookButtonReply>(create);
  static WebhookButtonReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);
}

class WebhookListReply extends $pb.GeneratedMessage {
  factory WebhookListReply({
    $core.String? id,
    $core.String? title,
    $core.String? description,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  WebhookListReply._() : super();
  factory WebhookListReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookListReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookListReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookListReply clone() => WebhookListReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookListReply copyWith(void Function(WebhookListReply) updates) => super.copyWith((message) => updates(message as WebhookListReply)) as WebhookListReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookListReply create() => WebhookListReply._();
  WebhookListReply createEmptyInstance() => create();
  static $pb.PbList<WebhookListReply> createRepeated() => $pb.PbList<WebhookListReply>();
  @$core.pragma('dart2js:noInline')
  static WebhookListReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookListReply>(create);
  static WebhookListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class WebhookStatus extends $pb.GeneratedMessage {
  factory WebhookStatus({
    $core.String? id,
    $core.String? status,
    $core.String? timestamp,
    $core.String? recipientId,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (status != null) {
      $result.status = status;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    return $result;
  }
  WebhookStatus._() : super();
  factory WebhookStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'recipientId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookStatus clone() => WebhookStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookStatus copyWith(void Function(WebhookStatus) updates) => super.copyWith((message) => updates(message as WebhookStatus)) as WebhookStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookStatus create() => WebhookStatus._();
  WebhookStatus createEmptyInstance() => create();
  static $pb.PbList<WebhookStatus> createRepeated() => $pb.PbList<WebhookStatus>();
  @$core.pragma('dart2js:noInline')
  static WebhookStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookStatus>(create);
  static WebhookStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientId => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecipientId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientId() => clearField(4);
}

class WebhookResponse extends $pb.GeneratedMessage {
  factory WebhookResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  WebhookResponse._() : super();
  factory WebhookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebhookResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookResponse clone() => WebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookResponse copyWith(void Function(WebhookResponse) updates) => super.copyWith((message) => updates(message as WebhookResponse)) as WebhookResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookResponse create() => WebhookResponse._();
  WebhookResponse createEmptyInstance() => create();
  static $pb.PbList<WebhookResponse> createRepeated() => $pb.PbList<WebhookResponse>();
  @$core.pragma('dart2js:noInline')
  static WebhookResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookResponse>(create);
  static WebhookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class VerifyWebhookRequest extends $pb.GeneratedMessage {
  factory VerifyWebhookRequest({
    $core.String? hubMode,
    $core.String? hubVerifyToken,
    $core.String? hubChallenge,
  }) {
    final $result = create();
    if (hubMode != null) {
      $result.hubMode = hubMode;
    }
    if (hubVerifyToken != null) {
      $result.hubVerifyToken = hubVerifyToken;
    }
    if (hubChallenge != null) {
      $result.hubChallenge = hubChallenge;
    }
    return $result;
  }
  VerifyWebhookRequest._() : super();
  factory VerifyWebhookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyWebhookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyWebhookRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hubMode')
    ..aOS(2, _omitFieldNames ? '' : 'hubVerifyToken')
    ..aOS(3, _omitFieldNames ? '' : 'hubChallenge')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyWebhookRequest clone() => VerifyWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyWebhookRequest copyWith(void Function(VerifyWebhookRequest) updates) => super.copyWith((message) => updates(message as VerifyWebhookRequest)) as VerifyWebhookRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyWebhookRequest create() => VerifyWebhookRequest._();
  VerifyWebhookRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyWebhookRequest> createRepeated() => $pb.PbList<VerifyWebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyWebhookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyWebhookRequest>(create);
  static VerifyWebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hubMode => $_getSZ(0);
  @$pb.TagNumber(1)
  set hubMode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHubMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearHubMode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get hubVerifyToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set hubVerifyToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHubVerifyToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearHubVerifyToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get hubChallenge => $_getSZ(2);
  @$pb.TagNumber(3)
  set hubChallenge($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHubChallenge() => $_has(2);
  @$pb.TagNumber(3)
  void clearHubChallenge() => clearField(3);
}

class VerifyWebhookResponse extends $pb.GeneratedMessage {
  factory VerifyWebhookResponse({
    $core.String? challenge,
  }) {
    final $result = create();
    if (challenge != null) {
      $result.challenge = challenge;
    }
    return $result;
  }
  VerifyWebhookResponse._() : super();
  factory VerifyWebhookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyWebhookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyWebhookResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'challenge')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyWebhookResponse clone() => VerifyWebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyWebhookResponse copyWith(void Function(VerifyWebhookResponse) updates) => super.copyWith((message) => updates(message as VerifyWebhookResponse)) as VerifyWebhookResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyWebhookResponse create() => VerifyWebhookResponse._();
  VerifyWebhookResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyWebhookResponse> createRepeated() => $pb.PbList<VerifyWebhookResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyWebhookResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyWebhookResponse>(create);
  static VerifyWebhookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challenge => $_getSZ(0);
  @$pb.TagNumber(1)
  set challenge($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChallenge() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallenge() => clearField(1);
}

class GetSessionRequest extends $pb.GeneratedMessage {
  factory GetSessionRequest({
    $core.String? sessionId,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    return $result;
  }
  GetSessionRequest._() : super();
  factory GetSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSessionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSessionRequest clone() => GetSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSessionRequest copyWith(void Function(GetSessionRequest) updates) => super.copyWith((message) => updates(message as GetSessionRequest)) as GetSessionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSessionRequest create() => GetSessionRequest._();
  GetSessionRequest createEmptyInstance() => create();
  static $pb.PbList<GetSessionRequest> createRepeated() => $pb.PbList<GetSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSessionRequest>(create);
  static GetSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);
}

class GetSessionResponse extends $pb.GeneratedMessage {
  factory GetSessionResponse({
    WhatsAppSession? session,
  }) {
    final $result = create();
    if (session != null) {
      $result.session = session;
    }
    return $result;
  }
  GetSessionResponse._() : super();
  factory GetSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSessionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<WhatsAppSession>(1, _omitFieldNames ? '' : 'session', subBuilder: WhatsAppSession.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSessionResponse clone() => GetSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSessionResponse copyWith(void Function(GetSessionResponse) updates) => super.copyWith((message) => updates(message as GetSessionResponse)) as GetSessionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSessionResponse create() => GetSessionResponse._();
  GetSessionResponse createEmptyInstance() => create();
  static $pb.PbList<GetSessionResponse> createRepeated() => $pb.PbList<GetSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSessionResponse>(create);
  static GetSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WhatsAppSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(WhatsAppSession v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => clearField(1);
  @$pb.TagNumber(1)
  WhatsAppSession ensureSession() => $_ensure(0);
}

class WhatsAppSession extends $pb.GeneratedMessage {
  factory WhatsAppSession({
    $core.String? id,
    $core.String? whatsappUserId,
    $core.bool? isAuthenticated,
    $1.Timestamp? expiresAt,
    $1.Timestamp? lastActivityAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (whatsappUserId != null) {
      $result.whatsappUserId = whatsappUserId;
    }
    if (isAuthenticated != null) {
      $result.isAuthenticated = isAuthenticated;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (lastActivityAt != null) {
      $result.lastActivityAt = lastActivityAt;
    }
    return $result;
  }
  WhatsAppSession._() : super();
  factory WhatsAppSession.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppSession.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WhatsAppSession', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'whatsappUserId')
    ..aOB(3, _omitFieldNames ? '' : 'isAuthenticated')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'lastActivityAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppSession clone() => WhatsAppSession()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppSession copyWith(void Function(WhatsAppSession) updates) => super.copyWith((message) => updates(message as WhatsAppSession)) as WhatsAppSession;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppSession create() => WhatsAppSession._();
  WhatsAppSession createEmptyInstance() => create();
  static $pb.PbList<WhatsAppSession> createRepeated() => $pb.PbList<WhatsAppSession>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppSession getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WhatsAppSession>(create);
  static WhatsAppSession? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get whatsappUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set whatsappUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWhatsappUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWhatsappUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isAuthenticated => $_getBF(2);
  @$pb.TagNumber(3)
  set isAuthenticated($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsAuthenticated() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsAuthenticated() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureExpiresAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get lastActivityAt => $_getN(4);
  @$pb.TagNumber(5)
  set lastActivityAt($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastActivityAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastActivityAt() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureLastActivityAt() => $_ensure(4);
}

class InvalidateSessionRequest extends $pb.GeneratedMessage {
  factory InvalidateSessionRequest({
    $core.String? sessionId,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    return $result;
  }
  InvalidateSessionRequest._() : super();
  factory InvalidateSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvalidateSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvalidateSessionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvalidateSessionRequest clone() => InvalidateSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvalidateSessionRequest copyWith(void Function(InvalidateSessionRequest) updates) => super.copyWith((message) => updates(message as InvalidateSessionRequest)) as InvalidateSessionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvalidateSessionRequest create() => InvalidateSessionRequest._();
  InvalidateSessionRequest createEmptyInstance() => create();
  static $pb.PbList<InvalidateSessionRequest> createRepeated() => $pb.PbList<InvalidateSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static InvalidateSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvalidateSessionRequest>(create);
  static InvalidateSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);
}

class InvalidateSessionResponse extends $pb.GeneratedMessage {
  factory InvalidateSessionResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  InvalidateSessionResponse._() : super();
  factory InvalidateSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvalidateSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvalidateSessionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvalidateSessionResponse clone() => InvalidateSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvalidateSessionResponse copyWith(void Function(InvalidateSessionResponse) updates) => super.copyWith((message) => updates(message as InvalidateSessionResponse)) as InvalidateSessionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvalidateSessionResponse create() => InvalidateSessionResponse._();
  InvalidateSessionResponse createEmptyInstance() => create();
  static $pb.PbList<InvalidateSessionResponse> createRepeated() => $pb.PbList<InvalidateSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static InvalidateSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvalidateSessionResponse>(create);
  static InvalidateSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class UpdateSecuritySettingsRequest extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsRequest({
    $core.double? dailyTransactionLimit,
    $core.double? perTransactionLimit,
    $core.bool? requirePinForAll,
    $core.double? biometricThreshold,
  }) {
    final $result = create();
    if (dailyTransactionLimit != null) {
      $result.dailyTransactionLimit = dailyTransactionLimit;
    }
    if (perTransactionLimit != null) {
      $result.perTransactionLimit = perTransactionLimit;
    }
    if (requirePinForAll != null) {
      $result.requirePinForAll = requirePinForAll;
    }
    if (biometricThreshold != null) {
      $result.biometricThreshold = biometricThreshold;
    }
    return $result;
  }
  UpdateSecuritySettingsRequest._() : super();
  factory UpdateSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSecuritySettingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'dailyTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'requirePinForAll')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'biometricThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest clone() => UpdateSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest copyWith(void Function(UpdateSecuritySettingsRequest) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsRequest)) as UpdateSecuritySettingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsRequest create() => UpdateSecuritySettingsRequest._();
  UpdateSecuritySettingsRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSecuritySettingsRequest> createRepeated() => $pb.PbList<UpdateSecuritySettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSecuritySettingsRequest>(create);
  static UpdateSecuritySettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get dailyTransactionLimit => $_getN(0);
  @$pb.TagNumber(1)
  set dailyTransactionLimit($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDailyTransactionLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearDailyTransactionLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get perTransactionLimit => $_getN(1);
  @$pb.TagNumber(2)
  set perTransactionLimit($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerTransactionLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerTransactionLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get requirePinForAll => $_getBF(2);
  @$pb.TagNumber(3)
  set requirePinForAll($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequirePinForAll() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequirePinForAll() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get biometricThreshold => $_getN(3);
  @$pb.TagNumber(4)
  set biometricThreshold($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBiometricThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearBiometricThreshold() => clearField(4);
}

class UpdateSecuritySettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsResponse({
    SecuritySettings? settings,
  }) {
    final $result = create();
    if (settings != null) {
      $result.settings = settings;
    }
    return $result;
  }
  UpdateSecuritySettingsResponse._() : super();
  factory UpdateSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSecuritySettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<SecuritySettings>(1, _omitFieldNames ? '' : 'settings', subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse clone() => UpdateSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse copyWith(void Function(UpdateSecuritySettingsResponse) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsResponse)) as UpdateSecuritySettingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsResponse create() => UpdateSecuritySettingsResponse._();
  UpdateSecuritySettingsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSecuritySettingsResponse> createRepeated() => $pb.PbList<UpdateSecuritySettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSecuritySettingsResponse>(create);
  static UpdateSecuritySettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SecuritySettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(SecuritySettings v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => clearField(1);
  @$pb.TagNumber(1)
  SecuritySettings ensureSettings() => $_ensure(0);
}

class GetSecuritySettingsRequest extends $pb.GeneratedMessage {
  factory GetSecuritySettingsRequest() => create();
  GetSecuritySettingsRequest._() : super();
  factory GetSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSecuritySettingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsRequest clone() => GetSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsRequest copyWith(void Function(GetSecuritySettingsRequest) updates) => super.copyWith((message) => updates(message as GetSecuritySettingsRequest)) as GetSecuritySettingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsRequest create() => GetSecuritySettingsRequest._();
  GetSecuritySettingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSecuritySettingsRequest> createRepeated() => $pb.PbList<GetSecuritySettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSecuritySettingsRequest>(create);
  static GetSecuritySettingsRequest? _defaultInstance;
}

class GetSecuritySettingsResponse extends $pb.GeneratedMessage {
  factory GetSecuritySettingsResponse({
    SecuritySettings? settings,
  }) {
    final $result = create();
    if (settings != null) {
      $result.settings = settings;
    }
    return $result;
  }
  GetSecuritySettingsResponse._() : super();
  factory GetSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSecuritySettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<SecuritySettings>(1, _omitFieldNames ? '' : 'settings', subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsResponse clone() => GetSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsResponse copyWith(void Function(GetSecuritySettingsResponse) updates) => super.copyWith((message) => updates(message as GetSecuritySettingsResponse)) as GetSecuritySettingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsResponse create() => GetSecuritySettingsResponse._();
  GetSecuritySettingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSecuritySettingsResponse> createRepeated() => $pb.PbList<GetSecuritySettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSecuritySettingsResponse>(create);
  static GetSecuritySettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SecuritySettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(SecuritySettings v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => clearField(1);
  @$pb.TagNumber(1)
  SecuritySettings ensureSettings() => $_ensure(0);
}

class SecuritySettings extends $pb.GeneratedMessage {
  factory SecuritySettings({
    $core.double? dailyTransactionLimit,
    $core.double? perTransactionLimit,
    $core.bool? requirePinForAll,
    $core.double? biometricThreshold,
  }) {
    final $result = create();
    if (dailyTransactionLimit != null) {
      $result.dailyTransactionLimit = dailyTransactionLimit;
    }
    if (perTransactionLimit != null) {
      $result.perTransactionLimit = perTransactionLimit;
    }
    if (requirePinForAll != null) {
      $result.requirePinForAll = requirePinForAll;
    }
    if (biometricThreshold != null) {
      $result.biometricThreshold = biometricThreshold;
    }
    return $result;
  }
  SecuritySettings._() : super();
  factory SecuritySettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecuritySettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecuritySettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'dailyTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'requirePinForAll')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'biometricThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecuritySettings clone() => SecuritySettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecuritySettings copyWith(void Function(SecuritySettings) updates) => super.copyWith((message) => updates(message as SecuritySettings)) as SecuritySettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecuritySettings create() => SecuritySettings._();
  SecuritySettings createEmptyInstance() => create();
  static $pb.PbList<SecuritySettings> createRepeated() => $pb.PbList<SecuritySettings>();
  @$core.pragma('dart2js:noInline')
  static SecuritySettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecuritySettings>(create);
  static SecuritySettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get dailyTransactionLimit => $_getN(0);
  @$pb.TagNumber(1)
  set dailyTransactionLimit($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDailyTransactionLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearDailyTransactionLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get perTransactionLimit => $_getN(1);
  @$pb.TagNumber(2)
  set perTransactionLimit($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerTransactionLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerTransactionLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get requirePinForAll => $_getBF(2);
  @$pb.TagNumber(3)
  set requirePinForAll($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequirePinForAll() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequirePinForAll() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get biometricThreshold => $_getN(3);
  @$pb.TagNumber(4)
  set biometricThreshold($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBiometricThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearBiometricThreshold() => clearField(4);
}

class GetAuditLogsRequest extends $pb.GeneratedMessage {
  factory GetAuditLogsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    return $result;
  }
  GetAuditLogsRequest._() : super();
  factory GetAuditLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAuditLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAuditLogsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAuditLogsRequest clone() => GetAuditLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAuditLogsRequest copyWith(void Function(GetAuditLogsRequest) updates) => super.copyWith((message) => updates(message as GetAuditLogsRequest)) as GetAuditLogsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAuditLogsRequest create() => GetAuditLogsRequest._();
  GetAuditLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAuditLogsRequest> createRepeated() => $pb.PbList<GetAuditLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAuditLogsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAuditLogsRequest>(create);
  static GetAuditLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => clearField(4);
}

class GetAuditLogsResponse extends $pb.GeneratedMessage {
  factory GetAuditLogsResponse({
    $core.Iterable<AuditLog>? logs,
    $core.int? total,
  }) {
    final $result = create();
    if (logs != null) {
      $result.logs.addAll(logs);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetAuditLogsResponse._() : super();
  factory GetAuditLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAuditLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAuditLogsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..pc<AuditLog>(1, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: AuditLog.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAuditLogsResponse clone() => GetAuditLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAuditLogsResponse copyWith(void Function(GetAuditLogsResponse) updates) => super.copyWith((message) => updates(message as GetAuditLogsResponse)) as GetAuditLogsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAuditLogsResponse create() => GetAuditLogsResponse._();
  GetAuditLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAuditLogsResponse> createRepeated() => $pb.PbList<GetAuditLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAuditLogsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAuditLogsResponse>(create);
  static GetAuditLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AuditLog> get logs => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AuditLog extends $pb.GeneratedMessage {
  factory AuditLog({
    $core.String? id,
    $core.String? action,
    $core.String? serviceType,
    $core.String? status,
    $1.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (action != null) {
      $result.action = action;
    }
    if (serviceType != null) {
      $result.serviceType = serviceType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  AuditLog._() : super();
  factory AuditLog.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AuditLog.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AuditLog', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..aOS(3, _omitFieldNames ? '' : 'serviceType')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AuditLog clone() => AuditLog()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AuditLog copyWith(void Function(AuditLog) updates) => super.copyWith((message) => updates(message as AuditLog)) as AuditLog;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditLog create() => AuditLog._();
  AuditLog createEmptyInstance() => create();
  static $pb.PbList<AuditLog> createRepeated() => $pb.PbList<AuditLog>();
  @$core.pragma('dart2js:noInline')
  static AuditLog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditLog>(create);
  static AuditLog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceType => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceType() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureCreatedAt() => $_ensure(4);
}

class WhatsAppUser extends $pb.GeneratedMessage {
  factory WhatsAppUser({
    $core.String? id,
    $core.String? userId,
    $core.String? phoneNumber,
    $core.String? whatsappId,
    $core.String? linkStatus,
    $1.Timestamp? linkedAt,
    $1.Timestamp? lastActiveAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (whatsappId != null) {
      $result.whatsappId = whatsappId;
    }
    if (linkStatus != null) {
      $result.linkStatus = linkStatus;
    }
    if (linkedAt != null) {
      $result.linkedAt = linkedAt;
    }
    if (lastActiveAt != null) {
      $result.lastActiveAt = lastActiveAt;
    }
    return $result;
  }
  WhatsAppUser._() : super();
  factory WhatsAppUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WhatsAppUser', package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(4, _omitFieldNames ? '' : 'whatsappId')
    ..aOS(5, _omitFieldNames ? '' : 'linkStatus')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'linkedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'lastActiveAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppUser clone() => WhatsAppUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppUser copyWith(void Function(WhatsAppUser) updates) => super.copyWith((message) => updates(message as WhatsAppUser)) as WhatsAppUser;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppUser create() => WhatsAppUser._();
  WhatsAppUser createEmptyInstance() => create();
  static $pb.PbList<WhatsAppUser> createRepeated() => $pb.PbList<WhatsAppUser>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WhatsAppUser>(create);
  static WhatsAppUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get whatsappId => $_getSZ(3);
  @$pb.TagNumber(4)
  set whatsappId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWhatsappId() => $_has(3);
  @$pb.TagNumber(4)
  void clearWhatsappId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get linkStatus => $_getSZ(4);
  @$pb.TagNumber(5)
  set linkStatus($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLinkStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearLinkStatus() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get linkedAt => $_getN(5);
  @$pb.TagNumber(6)
  set linkedAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLinkedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLinkedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLinkedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get lastActiveAt => $_getN(6);
  @$pb.TagNumber(7)
  set lastActiveAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastActiveAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastActiveAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureLastActiveAt() => $_ensure(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
