// This is a generated file - do not edit.
//
// Generated from whatsapp.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InitiateLinkingRequest extends $pb.GeneratedMessage {
  factory InitiateLinkingRequest({
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  InitiateLinkingRequest._();

  factory InitiateLinkingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateLinkingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateLinkingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateLinkingRequest clone() =>
      InitiateLinkingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateLinkingRequest copyWith(
          void Function(InitiateLinkingRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateLinkingRequest))
          as InitiateLinkingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateLinkingRequest create() => InitiateLinkingRequest._();
  @$core.override
  InitiateLinkingRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateLinkingRequest> createRepeated() =>
      $pb.PbList<InitiateLinkingRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateLinkingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateLinkingRequest>(create);
  static InitiateLinkingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);
}

class InitiateLinkingResponse extends $pb.GeneratedMessage {
  factory InitiateLinkingResponse({
    $core.String? otpReference,
    $core.String? message,
    $1.Timestamp? expiresAt,
  }) {
    final result = create();
    if (otpReference != null) result.otpReference = otpReference;
    if (message != null) result.message = message;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  InitiateLinkingResponse._();

  factory InitiateLinkingResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateLinkingResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateLinkingResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'otpReference')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateLinkingResponse clone() =>
      InitiateLinkingResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateLinkingResponse copyWith(
          void Function(InitiateLinkingResponse) updates) =>
      super.copyWith((message) => updates(message as InitiateLinkingResponse))
          as InitiateLinkingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateLinkingResponse create() => InitiateLinkingResponse._();
  @$core.override
  InitiateLinkingResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateLinkingResponse> createRepeated() =>
      $pb.PbList<InitiateLinkingResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateLinkingResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateLinkingResponse>(create);
  static InitiateLinkingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get otpReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set otpReference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOtpReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearOtpReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureExpiresAt() => $_ensure(2);
}

class VerifyLinkingRequest extends $pb.GeneratedMessage {
  factory VerifyLinkingRequest({
    $core.String? phoneNumber,
    $core.String? otpCode,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (otpCode != null) result.otpCode = otpCode;
    return result;
  }

  VerifyLinkingRequest._();

  factory VerifyLinkingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyLinkingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyLinkingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'otpCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyLinkingRequest clone() =>
      VerifyLinkingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyLinkingRequest copyWith(void Function(VerifyLinkingRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyLinkingRequest))
          as VerifyLinkingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyLinkingRequest create() => VerifyLinkingRequest._();
  @$core.override
  VerifyLinkingRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyLinkingRequest> createRepeated() =>
      $pb.PbList<VerifyLinkingRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyLinkingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyLinkingRequest>(create);
  static VerifyLinkingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get otpCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set otpCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOtpCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearOtpCode() => $_clearField(2);
}

class VerifyLinkingResponse extends $pb.GeneratedMessage {
  factory VerifyLinkingResponse({
    $core.bool? success,
    $core.String? message,
    WhatsAppUser? whatsappUser,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (whatsappUser != null) result.whatsappUser = whatsappUser;
    return result;
  }

  VerifyLinkingResponse._();

  factory VerifyLinkingResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyLinkingResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyLinkingResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<WhatsAppUser>(3, _omitFieldNames ? '' : 'whatsappUser',
        subBuilder: WhatsAppUser.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyLinkingResponse clone() =>
      VerifyLinkingResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyLinkingResponse copyWith(
          void Function(VerifyLinkingResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyLinkingResponse))
          as VerifyLinkingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyLinkingResponse create() => VerifyLinkingResponse._();
  @$core.override
  VerifyLinkingResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyLinkingResponse> createRepeated() =>
      $pb.PbList<VerifyLinkingResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyLinkingResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyLinkingResponse>(create);
  static VerifyLinkingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  WhatsAppUser get whatsappUser => $_getN(2);
  @$pb.TagNumber(3)
  set whatsappUser(WhatsAppUser value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasWhatsappUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhatsappUser() => $_clearField(3);
  @$pb.TagNumber(3)
  WhatsAppUser ensureWhatsappUser() => $_ensure(2);
}

class UnlinkAccountRequest extends $pb.GeneratedMessage {
  factory UnlinkAccountRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  UnlinkAccountRequest._();

  factory UnlinkAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlinkAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlinkAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkAccountRequest clone() =>
      UnlinkAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkAccountRequest copyWith(void Function(UnlinkAccountRequest) updates) =>
      super.copyWith((message) => updates(message as UnlinkAccountRequest))
          as UnlinkAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkAccountRequest create() => UnlinkAccountRequest._();
  @$core.override
  UnlinkAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnlinkAccountRequest> createRepeated() =>
      $pb.PbList<UnlinkAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlinkAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlinkAccountRequest>(create);
  static UnlinkAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class UnlinkAccountResponse extends $pb.GeneratedMessage {
  factory UnlinkAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UnlinkAccountResponse._();

  factory UnlinkAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlinkAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlinkAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkAccountResponse clone() =>
      UnlinkAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkAccountResponse copyWith(
          void Function(UnlinkAccountResponse) updates) =>
      super.copyWith((message) => updates(message as UnlinkAccountResponse))
          as UnlinkAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkAccountResponse create() => UnlinkAccountResponse._();
  @$core.override
  UnlinkAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnlinkAccountResponse> createRepeated() =>
      $pb.PbList<UnlinkAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlinkAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlinkAccountResponse>(create);
  static UnlinkAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetLinkStatusRequest extends $pb.GeneratedMessage {
  factory GetLinkStatusRequest() => create();

  GetLinkStatusRequest._();

  factory GetLinkStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLinkStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLinkStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkStatusRequest clone() =>
      GetLinkStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkStatusRequest copyWith(void Function(GetLinkStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetLinkStatusRequest))
          as GetLinkStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkStatusRequest create() => GetLinkStatusRequest._();
  @$core.override
  GetLinkStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkStatusRequest> createRepeated() =>
      $pb.PbList<GetLinkStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLinkStatusRequest>(create);
  static GetLinkStatusRequest? _defaultInstance;
}

class GetLinkStatusResponse extends $pb.GeneratedMessage {
  factory GetLinkStatusResponse({
    WhatsAppUser? whatsappUser,
  }) {
    final result = create();
    if (whatsappUser != null) result.whatsappUser = whatsappUser;
    return result;
  }

  GetLinkStatusResponse._();

  factory GetLinkStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLinkStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLinkStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOM<WhatsAppUser>(1, _omitFieldNames ? '' : 'whatsappUser',
        subBuilder: WhatsAppUser.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkStatusResponse clone() =>
      GetLinkStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkStatusResponse copyWith(
          void Function(GetLinkStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetLinkStatusResponse))
          as GetLinkStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkStatusResponse create() => GetLinkStatusResponse._();
  @$core.override
  GetLinkStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetLinkStatusResponse> createRepeated() =>
      $pb.PbList<GetLinkStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLinkStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLinkStatusResponse>(create);
  static GetLinkStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WhatsAppUser get whatsappUser => $_getN(0);
  @$pb.TagNumber(1)
  set whatsappUser(WhatsAppUser value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWhatsappUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearWhatsappUser() => $_clearField(1);
  @$pb.TagNumber(1)
  WhatsAppUser ensureWhatsappUser() => $_ensure(0);
}

class WebhookRequest extends $pb.GeneratedMessage {
  factory WebhookRequest({
    $core.String? object,
    $core.Iterable<WebhookEntry>? entry,
  }) {
    final result = create();
    if (object != null) result.object = object;
    if (entry != null) result.entry.addAll(entry);
    return result;
  }

  WebhookRequest._();

  factory WebhookRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'object')
    ..pc<WebhookEntry>(2, _omitFieldNames ? '' : 'entry', $pb.PbFieldType.PM,
        subBuilder: WebhookEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookRequest clone() => WebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookRequest copyWith(void Function(WebhookRequest) updates) =>
      super.copyWith((message) => updates(message as WebhookRequest))
          as WebhookRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookRequest create() => WebhookRequest._();
  @$core.override
  WebhookRequest createEmptyInstance() => create();
  static $pb.PbList<WebhookRequest> createRepeated() =>
      $pb.PbList<WebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static WebhookRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookRequest>(create);
  static WebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get object => $_getSZ(0);
  @$pb.TagNumber(1)
  set object($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasObject() => $_has(0);
  @$pb.TagNumber(1)
  void clearObject() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<WebhookEntry> get entry => $_getList(1);
}

class WebhookEntry extends $pb.GeneratedMessage {
  factory WebhookEntry({
    $core.String? id,
    $core.Iterable<WebhookChange>? changes,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (changes != null) result.changes.addAll(changes);
    return result;
  }

  WebhookEntry._();

  factory WebhookEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pc<WebhookChange>(2, _omitFieldNames ? '' : 'changes', $pb.PbFieldType.PM,
        subBuilder: WebhookChange.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookEntry clone() => WebhookEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookEntry copyWith(void Function(WebhookEntry) updates) =>
      super.copyWith((message) => updates(message as WebhookEntry))
          as WebhookEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookEntry create() => WebhookEntry._();
  @$core.override
  WebhookEntry createEmptyInstance() => create();
  static $pb.PbList<WebhookEntry> createRepeated() =>
      $pb.PbList<WebhookEntry>();
  @$core.pragma('dart2js:noInline')
  static WebhookEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookEntry>(create);
  static WebhookEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<WebhookChange> get changes => $_getList(1);
}

class WebhookChange extends $pb.GeneratedMessage {
  factory WebhookChange({
    $core.String? field_1,
    WebhookValue? value,
  }) {
    final result = create();
    if (field_1 != null) result.field_1 = field_1;
    if (value != null) result.value = value;
    return result;
  }

  WebhookChange._();

  factory WebhookChange.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookChange.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookChange',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOM<WebhookValue>(2, _omitFieldNames ? '' : 'value',
        subBuilder: WebhookValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookChange clone() => WebhookChange()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookChange copyWith(void Function(WebhookChange) updates) =>
      super.copyWith((message) => updates(message as WebhookChange))
          as WebhookChange;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookChange create() => WebhookChange._();
  @$core.override
  WebhookChange createEmptyInstance() => create();
  static $pb.PbList<WebhookChange> createRepeated() =>
      $pb.PbList<WebhookChange>();
  @$core.pragma('dart2js:noInline')
  static WebhookChange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookChange>(create);
  static WebhookChange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => $_clearField(1);

  @$pb.TagNumber(2)
  WebhookValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(WebhookValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
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
    final result = create();
    if (messagingProduct != null) result.messagingProduct = messagingProduct;
    if (metadata != null) result.metadata = metadata;
    if (contacts != null) result.contacts.addAll(contacts);
    if (messages != null) result.messages.addAll(messages);
    if (statuses != null) result.statuses.addAll(statuses);
    return result;
  }

  WebhookValue._();

  factory WebhookValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messagingProduct')
    ..aOM<WebhookMetadata>(2, _omitFieldNames ? '' : 'metadata',
        subBuilder: WebhookMetadata.create)
    ..pc<WebhookContact>(
        3, _omitFieldNames ? '' : 'contacts', $pb.PbFieldType.PM,
        subBuilder: WebhookContact.create)
    ..pc<WebhookMessage>(
        4, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM,
        subBuilder: WebhookMessage.create)
    ..pc<WebhookStatus>(
        5, _omitFieldNames ? '' : 'statuses', $pb.PbFieldType.PM,
        subBuilder: WebhookStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookValue clone() => WebhookValue()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookValue copyWith(void Function(WebhookValue) updates) =>
      super.copyWith((message) => updates(message as WebhookValue))
          as WebhookValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookValue create() => WebhookValue._();
  @$core.override
  WebhookValue createEmptyInstance() => create();
  static $pb.PbList<WebhookValue> createRepeated() =>
      $pb.PbList<WebhookValue>();
  @$core.pragma('dart2js:noInline')
  static WebhookValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookValue>(create);
  static WebhookValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messagingProduct => $_getSZ(0);
  @$pb.TagNumber(1)
  set messagingProduct($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessagingProduct() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessagingProduct() => $_clearField(1);

  @$pb.TagNumber(2)
  WebhookMetadata get metadata => $_getN(1);
  @$pb.TagNumber(2)
  set metadata(WebhookMetadata value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);
  @$pb.TagNumber(2)
  WebhookMetadata ensureMetadata() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<WebhookContact> get contacts => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<WebhookMessage> get messages => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<WebhookStatus> get statuses => $_getList(4);
}

class WebhookMetadata extends $pb.GeneratedMessage {
  factory WebhookMetadata({
    $core.String? displayPhoneNumber,
    $core.String? phoneNumberId,
  }) {
    final result = create();
    if (displayPhoneNumber != null)
      result.displayPhoneNumber = displayPhoneNumber;
    if (phoneNumberId != null) result.phoneNumberId = phoneNumberId;
    return result;
  }

  WebhookMetadata._();

  factory WebhookMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookMetadata',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'displayPhoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'phoneNumberId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookMetadata clone() => WebhookMetadata()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookMetadata copyWith(void Function(WebhookMetadata) updates) =>
      super.copyWith((message) => updates(message as WebhookMetadata))
          as WebhookMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookMetadata create() => WebhookMetadata._();
  @$core.override
  WebhookMetadata createEmptyInstance() => create();
  static $pb.PbList<WebhookMetadata> createRepeated() =>
      $pb.PbList<WebhookMetadata>();
  @$core.pragma('dart2js:noInline')
  static WebhookMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookMetadata>(create);
  static WebhookMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayPhoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayPhoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDisplayPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get phoneNumberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set phoneNumberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPhoneNumberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoneNumberId() => $_clearField(2);
}

class WebhookContact extends $pb.GeneratedMessage {
  factory WebhookContact({
    $core.String? profileName,
    $core.String? waId,
  }) {
    final result = create();
    if (profileName != null) result.profileName = profileName;
    if (waId != null) result.waId = waId;
    return result;
  }

  WebhookContact._();

  factory WebhookContact.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookContact.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookContact',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'profileName')
    ..aOS(2, _omitFieldNames ? '' : 'waId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookContact clone() => WebhookContact()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookContact copyWith(void Function(WebhookContact) updates) =>
      super.copyWith((message) => updates(message as WebhookContact))
          as WebhookContact;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookContact create() => WebhookContact._();
  @$core.override
  WebhookContact createEmptyInstance() => create();
  static $pb.PbList<WebhookContact> createRepeated() =>
      $pb.PbList<WebhookContact>();
  @$core.pragma('dart2js:noInline')
  static WebhookContact getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookContact>(create);
  static WebhookContact? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get profileName => $_getSZ(0);
  @$pb.TagNumber(1)
  set profileName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProfileName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfileName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get waId => $_getSZ(1);
  @$pb.TagNumber(2)
  set waId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWaId() => $_clearField(2);
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
    final result = create();
    if (from != null) result.from = from;
    if (id != null) result.id = id;
    if (timestamp != null) result.timestamp = timestamp;
    if (type != null) result.type = type;
    if (text != null) result.text = text;
    if (interactive != null) result.interactive = interactive;
    return result;
  }

  WebhookMessage._();

  factory WebhookMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'from')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOM<WebhookTextMessage>(5, _omitFieldNames ? '' : 'text',
        subBuilder: WebhookTextMessage.create)
    ..aOM<WebhookInteractiveMessage>(6, _omitFieldNames ? '' : 'interactive',
        subBuilder: WebhookInteractiveMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookMessage clone() => WebhookMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookMessage copyWith(void Function(WebhookMessage) updates) =>
      super.copyWith((message) => updates(message as WebhookMessage))
          as WebhookMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookMessage create() => WebhookMessage._();
  @$core.override
  WebhookMessage createEmptyInstance() => create();
  static $pb.PbList<WebhookMessage> createRepeated() =>
      $pb.PbList<WebhookMessage>();
  @$core.pragma('dart2js:noInline')
  static WebhookMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookMessage>(create);
  static WebhookMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get from => $_getSZ(0);
  @$pb.TagNumber(1)
  set from($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(5)
  WebhookTextMessage get text => $_getN(4);
  @$pb.TagNumber(5)
  set text(WebhookTextMessage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasText() => $_has(4);
  @$pb.TagNumber(5)
  void clearText() => $_clearField(5);
  @$pb.TagNumber(5)
  WebhookTextMessage ensureText() => $_ensure(4);

  @$pb.TagNumber(6)
  WebhookInteractiveMessage get interactive => $_getN(5);
  @$pb.TagNumber(6)
  set interactive(WebhookInteractiveMessage value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasInteractive() => $_has(5);
  @$pb.TagNumber(6)
  void clearInteractive() => $_clearField(6);
  @$pb.TagNumber(6)
  WebhookInteractiveMessage ensureInteractive() => $_ensure(5);
}

class WebhookTextMessage extends $pb.GeneratedMessage {
  factory WebhookTextMessage({
    $core.String? body,
  }) {
    final result = create();
    if (body != null) result.body = body;
    return result;
  }

  WebhookTextMessage._();

  factory WebhookTextMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookTextMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookTextMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookTextMessage clone() => WebhookTextMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookTextMessage copyWith(void Function(WebhookTextMessage) updates) =>
      super.copyWith((message) => updates(message as WebhookTextMessage))
          as WebhookTextMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookTextMessage create() => WebhookTextMessage._();
  @$core.override
  WebhookTextMessage createEmptyInstance() => create();
  static $pb.PbList<WebhookTextMessage> createRepeated() =>
      $pb.PbList<WebhookTextMessage>();
  @$core.pragma('dart2js:noInline')
  static WebhookTextMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookTextMessage>(create);
  static WebhookTextMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get body => $_getSZ(0);
  @$pb.TagNumber(1)
  set body($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBody() => $_has(0);
  @$pb.TagNumber(1)
  void clearBody() => $_clearField(1);
}

class WebhookInteractiveMessage extends $pb.GeneratedMessage {
  factory WebhookInteractiveMessage({
    $core.String? type,
    WebhookButtonReply? buttonReply,
    WebhookListReply? listReply,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (buttonReply != null) result.buttonReply = buttonReply;
    if (listReply != null) result.listReply = listReply;
    return result;
  }

  WebhookInteractiveMessage._();

  factory WebhookInteractiveMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookInteractiveMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookInteractiveMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOM<WebhookButtonReply>(2, _omitFieldNames ? '' : 'buttonReply',
        subBuilder: WebhookButtonReply.create)
    ..aOM<WebhookListReply>(3, _omitFieldNames ? '' : 'listReply',
        subBuilder: WebhookListReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookInteractiveMessage clone() =>
      WebhookInteractiveMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookInteractiveMessage copyWith(
          void Function(WebhookInteractiveMessage) updates) =>
      super.copyWith((message) => updates(message as WebhookInteractiveMessage))
          as WebhookInteractiveMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookInteractiveMessage create() => WebhookInteractiveMessage._();
  @$core.override
  WebhookInteractiveMessage createEmptyInstance() => create();
  static $pb.PbList<WebhookInteractiveMessage> createRepeated() =>
      $pb.PbList<WebhookInteractiveMessage>();
  @$core.pragma('dart2js:noInline')
  static WebhookInteractiveMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookInteractiveMessage>(create);
  static WebhookInteractiveMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  WebhookButtonReply get buttonReply => $_getN(1);
  @$pb.TagNumber(2)
  set buttonReply(WebhookButtonReply value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasButtonReply() => $_has(1);
  @$pb.TagNumber(2)
  void clearButtonReply() => $_clearField(2);
  @$pb.TagNumber(2)
  WebhookButtonReply ensureButtonReply() => $_ensure(1);

  @$pb.TagNumber(3)
  WebhookListReply get listReply => $_getN(2);
  @$pb.TagNumber(3)
  set listReply(WebhookListReply value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasListReply() => $_has(2);
  @$pb.TagNumber(3)
  void clearListReply() => $_clearField(3);
  @$pb.TagNumber(3)
  WebhookListReply ensureListReply() => $_ensure(2);
}

class WebhookButtonReply extends $pb.GeneratedMessage {
  factory WebhookButtonReply({
    $core.String? id,
    $core.String? title,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    return result;
  }

  WebhookButtonReply._();

  factory WebhookButtonReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookButtonReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookButtonReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookButtonReply clone() => WebhookButtonReply()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookButtonReply copyWith(void Function(WebhookButtonReply) updates) =>
      super.copyWith((message) => updates(message as WebhookButtonReply))
          as WebhookButtonReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookButtonReply create() => WebhookButtonReply._();
  @$core.override
  WebhookButtonReply createEmptyInstance() => create();
  static $pb.PbList<WebhookButtonReply> createRepeated() =>
      $pb.PbList<WebhookButtonReply>();
  @$core.pragma('dart2js:noInline')
  static WebhookButtonReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookButtonReply>(create);
  static WebhookButtonReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);
}

class WebhookListReply extends $pb.GeneratedMessage {
  factory WebhookListReply({
    $core.String? id,
    $core.String? title,
    $core.String? description,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    return result;
  }

  WebhookListReply._();

  factory WebhookListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookListReply clone() => WebhookListReply()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookListReply copyWith(void Function(WebhookListReply) updates) =>
      super.copyWith((message) => updates(message as WebhookListReply))
          as WebhookListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookListReply create() => WebhookListReply._();
  @$core.override
  WebhookListReply createEmptyInstance() => create();
  static $pb.PbList<WebhookListReply> createRepeated() =>
      $pb.PbList<WebhookListReply>();
  @$core.pragma('dart2js:noInline')
  static WebhookListReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookListReply>(create);
  static WebhookListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
}

class WebhookStatus extends $pb.GeneratedMessage {
  factory WebhookStatus({
    $core.String? id,
    $core.String? status,
    $core.String? timestamp,
    $core.String? recipientId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (timestamp != null) result.timestamp = timestamp;
    if (recipientId != null) result.recipientId = recipientId;
    return result;
  }

  WebhookStatus._();

  factory WebhookStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'recipientId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookStatus clone() => WebhookStatus()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookStatus copyWith(void Function(WebhookStatus) updates) =>
      super.copyWith((message) => updates(message as WebhookStatus))
          as WebhookStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookStatus create() => WebhookStatus._();
  @$core.override
  WebhookStatus createEmptyInstance() => create();
  static $pb.PbList<WebhookStatus> createRepeated() =>
      $pb.PbList<WebhookStatus>();
  @$core.pragma('dart2js:noInline')
  static WebhookStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookStatus>(create);
  static WebhookStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientId => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientId() => $_clearField(4);
}

class WebhookResponse extends $pb.GeneratedMessage {
  factory WebhookResponse({
    $core.String? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  WebhookResponse._();

  factory WebhookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookResponse clone() => WebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookResponse copyWith(void Function(WebhookResponse) updates) =>
      super.copyWith((message) => updates(message as WebhookResponse))
          as WebhookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookResponse create() => WebhookResponse._();
  @$core.override
  WebhookResponse createEmptyInstance() => create();
  static $pb.PbList<WebhookResponse> createRepeated() =>
      $pb.PbList<WebhookResponse>();
  @$core.pragma('dart2js:noInline')
  static WebhookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookResponse>(create);
  static WebhookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class VerifyWebhookRequest extends $pb.GeneratedMessage {
  factory VerifyWebhookRequest({
    $core.String? hubMode,
    $core.String? hubVerifyToken,
    $core.String? hubChallenge,
  }) {
    final result = create();
    if (hubMode != null) result.hubMode = hubMode;
    if (hubVerifyToken != null) result.hubVerifyToken = hubVerifyToken;
    if (hubChallenge != null) result.hubChallenge = hubChallenge;
    return result;
  }

  VerifyWebhookRequest._();

  factory VerifyWebhookRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyWebhookRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyWebhookRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hubMode')
    ..aOS(2, _omitFieldNames ? '' : 'hubVerifyToken')
    ..aOS(3, _omitFieldNames ? '' : 'hubChallenge')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyWebhookRequest clone() =>
      VerifyWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyWebhookRequest copyWith(void Function(VerifyWebhookRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyWebhookRequest))
          as VerifyWebhookRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyWebhookRequest create() => VerifyWebhookRequest._();
  @$core.override
  VerifyWebhookRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyWebhookRequest> createRepeated() =>
      $pb.PbList<VerifyWebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyWebhookRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyWebhookRequest>(create);
  static VerifyWebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hubMode => $_getSZ(0);
  @$pb.TagNumber(1)
  set hubMode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHubMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearHubMode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get hubVerifyToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set hubVerifyToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHubVerifyToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearHubVerifyToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get hubChallenge => $_getSZ(2);
  @$pb.TagNumber(3)
  set hubChallenge($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHubChallenge() => $_has(2);
  @$pb.TagNumber(3)
  void clearHubChallenge() => $_clearField(3);
}

class VerifyWebhookResponse extends $pb.GeneratedMessage {
  factory VerifyWebhookResponse({
    $core.String? challenge,
  }) {
    final result = create();
    if (challenge != null) result.challenge = challenge;
    return result;
  }

  VerifyWebhookResponse._();

  factory VerifyWebhookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyWebhookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyWebhookResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'challenge')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyWebhookResponse clone() =>
      VerifyWebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyWebhookResponse copyWith(
          void Function(VerifyWebhookResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyWebhookResponse))
          as VerifyWebhookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyWebhookResponse create() => VerifyWebhookResponse._();
  @$core.override
  VerifyWebhookResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyWebhookResponse> createRepeated() =>
      $pb.PbList<VerifyWebhookResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyWebhookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyWebhookResponse>(create);
  static VerifyWebhookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challenge => $_getSZ(0);
  @$pb.TagNumber(1)
  set challenge($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChallenge() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallenge() => $_clearField(1);
}

class GetSessionRequest extends $pb.GeneratedMessage {
  factory GetSessionRequest({
    $core.String? sessionId,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  GetSessionRequest._();

  factory GetSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSessionRequest clone() => GetSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSessionRequest copyWith(void Function(GetSessionRequest) updates) =>
      super.copyWith((message) => updates(message as GetSessionRequest))
          as GetSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSessionRequest create() => GetSessionRequest._();
  @$core.override
  GetSessionRequest createEmptyInstance() => create();
  static $pb.PbList<GetSessionRequest> createRepeated() =>
      $pb.PbList<GetSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSessionRequest>(create);
  static GetSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class GetSessionResponse extends $pb.GeneratedMessage {
  factory GetSessionResponse({
    WhatsAppSession? session,
  }) {
    final result = create();
    if (session != null) result.session = session;
    return result;
  }

  GetSessionResponse._();

  factory GetSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOM<WhatsAppSession>(1, _omitFieldNames ? '' : 'session',
        subBuilder: WhatsAppSession.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSessionResponse clone() => GetSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSessionResponse copyWith(void Function(GetSessionResponse) updates) =>
      super.copyWith((message) => updates(message as GetSessionResponse))
          as GetSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSessionResponse create() => GetSessionResponse._();
  @$core.override
  GetSessionResponse createEmptyInstance() => create();
  static $pb.PbList<GetSessionResponse> createRepeated() =>
      $pb.PbList<GetSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSessionResponse>(create);
  static GetSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WhatsAppSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(WhatsAppSession value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);
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
    final result = create();
    if (id != null) result.id = id;
    if (whatsappUserId != null) result.whatsappUserId = whatsappUserId;
    if (isAuthenticated != null) result.isAuthenticated = isAuthenticated;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (lastActivityAt != null) result.lastActivityAt = lastActivityAt;
    return result;
  }

  WhatsAppSession._();

  factory WhatsAppSession.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WhatsAppSession.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WhatsAppSession',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'whatsappUserId')
    ..aOB(3, _omitFieldNames ? '' : 'isAuthenticated')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'lastActivityAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppSession clone() => WhatsAppSession()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppSession copyWith(void Function(WhatsAppSession) updates) =>
      super.copyWith((message) => updates(message as WhatsAppSession))
          as WhatsAppSession;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppSession create() => WhatsAppSession._();
  @$core.override
  WhatsAppSession createEmptyInstance() => create();
  static $pb.PbList<WhatsAppSession> createRepeated() =>
      $pb.PbList<WhatsAppSession>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppSession getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WhatsAppSession>(create);
  static WhatsAppSession? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get whatsappUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set whatsappUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWhatsappUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWhatsappUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isAuthenticated => $_getBF(2);
  @$pb.TagNumber(3)
  set isAuthenticated($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsAuthenticated() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsAuthenticated() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureExpiresAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get lastActivityAt => $_getN(4);
  @$pb.TagNumber(5)
  set lastActivityAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLastActivityAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastActivityAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureLastActivityAt() => $_ensure(4);
}

class InvalidateSessionRequest extends $pb.GeneratedMessage {
  factory InvalidateSessionRequest({
    $core.String? sessionId,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  InvalidateSessionRequest._();

  factory InvalidateSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvalidateSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvalidateSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidateSessionRequest clone() =>
      InvalidateSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidateSessionRequest copyWith(
          void Function(InvalidateSessionRequest) updates) =>
      super.copyWith((message) => updates(message as InvalidateSessionRequest))
          as InvalidateSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvalidateSessionRequest create() => InvalidateSessionRequest._();
  @$core.override
  InvalidateSessionRequest createEmptyInstance() => create();
  static $pb.PbList<InvalidateSessionRequest> createRepeated() =>
      $pb.PbList<InvalidateSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static InvalidateSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvalidateSessionRequest>(create);
  static InvalidateSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class InvalidateSessionResponse extends $pb.GeneratedMessage {
  factory InvalidateSessionResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  InvalidateSessionResponse._();

  factory InvalidateSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvalidateSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvalidateSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidateSessionResponse clone() =>
      InvalidateSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidateSessionResponse copyWith(
          void Function(InvalidateSessionResponse) updates) =>
      super.copyWith((message) => updates(message as InvalidateSessionResponse))
          as InvalidateSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvalidateSessionResponse create() => InvalidateSessionResponse._();
  @$core.override
  InvalidateSessionResponse createEmptyInstance() => create();
  static $pb.PbList<InvalidateSessionResponse> createRepeated() =>
      $pb.PbList<InvalidateSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static InvalidateSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvalidateSessionResponse>(create);
  static InvalidateSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class UpdateSecuritySettingsRequest extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsRequest({
    $core.double? dailyTransactionLimit,
    $core.double? perTransactionLimit,
    $core.bool? requirePinForAll,
    $core.double? biometricThreshold,
  }) {
    final result = create();
    if (dailyTransactionLimit != null)
      result.dailyTransactionLimit = dailyTransactionLimit;
    if (perTransactionLimit != null)
      result.perTransactionLimit = perTransactionLimit;
    if (requirePinForAll != null) result.requirePinForAll = requirePinForAll;
    if (biometricThreshold != null)
      result.biometricThreshold = biometricThreshold;
    return result;
  }

  UpdateSecuritySettingsRequest._();

  factory UpdateSecuritySettingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSecuritySettingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSecuritySettingsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'dailyTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'requirePinForAll')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'biometricThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSecuritySettingsRequest clone() =>
      UpdateSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSecuritySettingsRequest copyWith(
          void Function(UpdateSecuritySettingsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateSecuritySettingsRequest))
          as UpdateSecuritySettingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsRequest create() =>
      UpdateSecuritySettingsRequest._();
  @$core.override
  UpdateSecuritySettingsRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSecuritySettingsRequest> createRepeated() =>
      $pb.PbList<UpdateSecuritySettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSecuritySettingsRequest>(create);
  static UpdateSecuritySettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get dailyTransactionLimit => $_getN(0);
  @$pb.TagNumber(1)
  set dailyTransactionLimit($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDailyTransactionLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearDailyTransactionLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get perTransactionLimit => $_getN(1);
  @$pb.TagNumber(2)
  set perTransactionLimit($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerTransactionLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerTransactionLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get requirePinForAll => $_getBF(2);
  @$pb.TagNumber(3)
  set requirePinForAll($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequirePinForAll() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequirePinForAll() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get biometricThreshold => $_getN(3);
  @$pb.TagNumber(4)
  set biometricThreshold($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBiometricThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearBiometricThreshold() => $_clearField(4);
}

class UpdateSecuritySettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsResponse({
    SecuritySettings? settings,
  }) {
    final result = create();
    if (settings != null) result.settings = settings;
    return result;
  }

  UpdateSecuritySettingsResponse._();

  factory UpdateSecuritySettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSecuritySettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSecuritySettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOM<SecuritySettings>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSecuritySettingsResponse clone() =>
      UpdateSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSecuritySettingsResponse copyWith(
          void Function(UpdateSecuritySettingsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateSecuritySettingsResponse))
          as UpdateSecuritySettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsResponse create() =>
      UpdateSecuritySettingsResponse._();
  @$core.override
  UpdateSecuritySettingsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSecuritySettingsResponse> createRepeated() =>
      $pb.PbList<UpdateSecuritySettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSecuritySettingsResponse>(create);
  static UpdateSecuritySettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SecuritySettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(SecuritySettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  SecuritySettings ensureSettings() => $_ensure(0);
}

class GetSecuritySettingsRequest extends $pb.GeneratedMessage {
  factory GetSecuritySettingsRequest() => create();

  GetSecuritySettingsRequest._();

  factory GetSecuritySettingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSecuritySettingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSecuritySettingsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSecuritySettingsRequest clone() =>
      GetSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSecuritySettingsRequest copyWith(
          void Function(GetSecuritySettingsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSecuritySettingsRequest))
          as GetSecuritySettingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsRequest create() => GetSecuritySettingsRequest._();
  @$core.override
  GetSecuritySettingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSecuritySettingsRequest> createRepeated() =>
      $pb.PbList<GetSecuritySettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSecuritySettingsRequest>(create);
  static GetSecuritySettingsRequest? _defaultInstance;
}

class GetSecuritySettingsResponse extends $pb.GeneratedMessage {
  factory GetSecuritySettingsResponse({
    SecuritySettings? settings,
  }) {
    final result = create();
    if (settings != null) result.settings = settings;
    return result;
  }

  GetSecuritySettingsResponse._();

  factory GetSecuritySettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSecuritySettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSecuritySettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOM<SecuritySettings>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSecuritySettingsResponse clone() =>
      GetSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSecuritySettingsResponse copyWith(
          void Function(GetSecuritySettingsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSecuritySettingsResponse))
          as GetSecuritySettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsResponse create() =>
      GetSecuritySettingsResponse._();
  @$core.override
  GetSecuritySettingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSecuritySettingsResponse> createRepeated() =>
      $pb.PbList<GetSecuritySettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSecuritySettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSecuritySettingsResponse>(create);
  static GetSecuritySettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SecuritySettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(SecuritySettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => $_clearField(1);
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
    final result = create();
    if (dailyTransactionLimit != null)
      result.dailyTransactionLimit = dailyTransactionLimit;
    if (perTransactionLimit != null)
      result.perTransactionLimit = perTransactionLimit;
    if (requirePinForAll != null) result.requirePinForAll = requirePinForAll;
    if (biometricThreshold != null)
      result.biometricThreshold = biometricThreshold;
    return result;
  }

  SecuritySettings._();

  factory SecuritySettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SecuritySettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SecuritySettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'dailyTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'requirePinForAll')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'biometricThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SecuritySettings clone() => SecuritySettings()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SecuritySettings copyWith(void Function(SecuritySettings) updates) =>
      super.copyWith((message) => updates(message as SecuritySettings))
          as SecuritySettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecuritySettings create() => SecuritySettings._();
  @$core.override
  SecuritySettings createEmptyInstance() => create();
  static $pb.PbList<SecuritySettings> createRepeated() =>
      $pb.PbList<SecuritySettings>();
  @$core.pragma('dart2js:noInline')
  static SecuritySettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SecuritySettings>(create);
  static SecuritySettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get dailyTransactionLimit => $_getN(0);
  @$pb.TagNumber(1)
  set dailyTransactionLimit($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDailyTransactionLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearDailyTransactionLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get perTransactionLimit => $_getN(1);
  @$pb.TagNumber(2)
  set perTransactionLimit($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerTransactionLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerTransactionLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get requirePinForAll => $_getBF(2);
  @$pb.TagNumber(3)
  set requirePinForAll($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequirePinForAll() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequirePinForAll() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get biometricThreshold => $_getN(3);
  @$pb.TagNumber(4)
  set biometricThreshold($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBiometricThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearBiometricThreshold() => $_clearField(4);
}

class GetAuditLogsRequest extends $pb.GeneratedMessage {
  factory GetAuditLogsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetAuditLogsRequest._();

  factory GetAuditLogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAuditLogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAuditLogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuditLogsRequest clone() => GetAuditLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuditLogsRequest copyWith(void Function(GetAuditLogsRequest) updates) =>
      super.copyWith((message) => updates(message as GetAuditLogsRequest))
          as GetAuditLogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAuditLogsRequest create() => GetAuditLogsRequest._();
  @$core.override
  GetAuditLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAuditLogsRequest> createRepeated() =>
      $pb.PbList<GetAuditLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAuditLogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAuditLogsRequest>(create);
  static GetAuditLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);
}

class GetAuditLogsResponse extends $pb.GeneratedMessage {
  factory GetAuditLogsResponse({
    $core.Iterable<AuditLog>? logs,
    $core.int? total,
  }) {
    final result = create();
    if (logs != null) result.logs.addAll(logs);
    if (total != null) result.total = total;
    return result;
  }

  GetAuditLogsResponse._();

  factory GetAuditLogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAuditLogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAuditLogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..pc<AuditLog>(1, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM,
        subBuilder: AuditLog.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuditLogsResponse clone() =>
      GetAuditLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuditLogsResponse copyWith(void Function(GetAuditLogsResponse) updates) =>
      super.copyWith((message) => updates(message as GetAuditLogsResponse))
          as GetAuditLogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAuditLogsResponse create() => GetAuditLogsResponse._();
  @$core.override
  GetAuditLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAuditLogsResponse> createRepeated() =>
      $pb.PbList<GetAuditLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAuditLogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAuditLogsResponse>(create);
  static GetAuditLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AuditLog> get logs => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class AuditLog extends $pb.GeneratedMessage {
  factory AuditLog({
    $core.String? id,
    $core.String? action,
    $core.String? serviceType,
    $core.String? status,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (action != null) result.action = action;
    if (serviceType != null) result.serviceType = serviceType;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  AuditLog._();

  factory AuditLog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuditLog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditLog',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..aOS(3, _omitFieldNames ? '' : 'serviceType')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuditLog clone() => AuditLog()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuditLog copyWith(void Function(AuditLog) updates) =>
      super.copyWith((message) => updates(message as AuditLog)) as AuditLog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditLog create() => AuditLog._();
  @$core.override
  AuditLog createEmptyInstance() => create();
  static $pb.PbList<AuditLog> createRepeated() => $pb.PbList<AuditLog>();
  @$core.pragma('dart2js:noInline')
  static AuditLog getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditLog>(create);
  static AuditLog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceType => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServiceType() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
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
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (whatsappId != null) result.whatsappId = whatsappId;
    if (linkStatus != null) result.linkStatus = linkStatus;
    if (linkedAt != null) result.linkedAt = linkedAt;
    if (lastActiveAt != null) result.lastActiveAt = lastActiveAt;
    return result;
  }

  WhatsAppUser._();

  factory WhatsAppUser.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WhatsAppUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WhatsAppUser',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'whatsapp'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(4, _omitFieldNames ? '' : 'whatsappId')
    ..aOS(5, _omitFieldNames ? '' : 'linkStatus')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'linkedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'lastActiveAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppUser clone() => WhatsAppUser()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppUser copyWith(void Function(WhatsAppUser) updates) =>
      super.copyWith((message) => updates(message as WhatsAppUser))
          as WhatsAppUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppUser create() => WhatsAppUser._();
  @$core.override
  WhatsAppUser createEmptyInstance() => create();
  static $pb.PbList<WhatsAppUser> createRepeated() =>
      $pb.PbList<WhatsAppUser>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppUser getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WhatsAppUser>(create);
  static WhatsAppUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get whatsappId => $_getSZ(3);
  @$pb.TagNumber(4)
  set whatsappId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWhatsappId() => $_has(3);
  @$pb.TagNumber(4)
  void clearWhatsappId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get linkStatus => $_getSZ(4);
  @$pb.TagNumber(5)
  set linkStatus($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLinkStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearLinkStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get linkedAt => $_getN(5);
  @$pb.TagNumber(6)
  set linkedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLinkedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLinkedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLinkedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get lastActiveAt => $_getN(6);
  @$pb.TagNumber(7)
  set lastActiveAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLastActiveAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastActiveAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureLastActiveAt() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
