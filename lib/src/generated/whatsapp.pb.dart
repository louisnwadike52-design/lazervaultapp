///
//  Generated code. Do not modify.
//  source: whatsapp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $ts;

import 'whatsapp.pbenum.dart';

export 'whatsapp.pbenum.dart';

class InitiateLinkingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateLinkingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  InitiateLinkingRequest._() : super();
  factory InitiateLinkingRequest({
    $core.String? phoneNumber,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    return _result;
  }
  factory InitiateLinkingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateLinkingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateLinkingRequest clone() => InitiateLinkingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateLinkingRequest copyWith(void Function(InitiateLinkingRequest) updates) => super.copyWith((message) => updates(message as InitiateLinkingRequest)) as InitiateLinkingRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateLinkingResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otpReference')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<$ts.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $ts.Timestamp.create)
    ..hasRequiredFields = false
  ;

  InitiateLinkingResponse._() : super();
  factory InitiateLinkingResponse({
    $core.String? otpReference,
    $core.String? message,
    $ts.Timestamp? expiresAt,
  }) {
    final _result = create();
    if (otpReference != null) {
      _result.otpReference = otpReference;
    }
    if (message != null) {
      _result.message = message;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory InitiateLinkingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateLinkingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateLinkingResponse clone() => InitiateLinkingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateLinkingResponse copyWith(void Function(InitiateLinkingResponse) updates) => super.copyWith((message) => updates(message as InitiateLinkingResponse)) as InitiateLinkingResponse; // ignore: deprecated_member_use
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
  $ts.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($ts.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => clearField(3);
  @$pb.TagNumber(3)
  $ts.Timestamp ensureExpiresAt() => $_ensure(2);
}

class VerifyLinkingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyLinkingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otpCode')
    ..hasRequiredFields = false
  ;

  VerifyLinkingRequest._() : super();
  factory VerifyLinkingRequest({
    $core.String? phoneNumber,
    $core.String? otpCode,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (otpCode != null) {
      _result.otpCode = otpCode;
    }
    return _result;
  }
  factory VerifyLinkingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyLinkingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyLinkingRequest clone() => VerifyLinkingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyLinkingRequest copyWith(void Function(VerifyLinkingRequest) updates) => super.copyWith((message) => updates(message as VerifyLinkingRequest)) as VerifyLinkingRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyLinkingResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<WhatsAppUser>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whatsappUser', subBuilder: WhatsAppUser.create)
    ..hasRequiredFields = false
  ;

  VerifyLinkingResponse._() : super();
  factory VerifyLinkingResponse({
    $core.bool? success,
    $core.String? message,
    WhatsAppUser? whatsappUser,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (whatsappUser != null) {
      _result.whatsappUser = whatsappUser;
    }
    return _result;
  }
  factory VerifyLinkingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyLinkingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyLinkingResponse clone() => VerifyLinkingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyLinkingResponse copyWith(void Function(VerifyLinkingResponse) updates) => super.copyWith((message) => updates(message as VerifyLinkingResponse)) as VerifyLinkingResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlinkAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  UnlinkAccountRequest._() : super();
  factory UnlinkAccountRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory UnlinkAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkAccountRequest clone() => UnlinkAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkAccountRequest copyWith(void Function(UnlinkAccountRequest) updates) => super.copyWith((message) => updates(message as UnlinkAccountRequest)) as UnlinkAccountRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlinkAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UnlinkAccountResponse._() : super();
  factory UnlinkAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UnlinkAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkAccountResponse clone() => UnlinkAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkAccountResponse copyWith(void Function(UnlinkAccountResponse) updates) => super.copyWith((message) => updates(message as UnlinkAccountResponse)) as UnlinkAccountResponse; // ignore: deprecated_member_use
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

class SecuritySettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SecuritySettings', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requirePinForAll')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'biometricThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SecuritySettings._() : super();
  factory SecuritySettings({
    $core.double? dailyTransactionLimit,
    $core.double? perTransactionLimit,
    $core.bool? requirePinForAll,
    $core.double? biometricThreshold,
  }) {
    final _result = create();
    if (dailyTransactionLimit != null) {
      _result.dailyTransactionLimit = dailyTransactionLimit;
    }
    if (perTransactionLimit != null) {
      _result.perTransactionLimit = perTransactionLimit;
    }
    if (requirePinForAll != null) {
      _result.requirePinForAll = requirePinForAll;
    }
    if (biometricThreshold != null) {
      _result.biometricThreshold = biometricThreshold;
    }
    return _result;
  }
  factory SecuritySettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecuritySettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecuritySettings clone() => SecuritySettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecuritySettings copyWith(void Function(SecuritySettings) updates) => super.copyWith((message) => updates(message as SecuritySettings)) as SecuritySettings; // ignore: deprecated_member_use
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

class UpdateSecuritySettingsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSecuritySettingsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requirePinForAll')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'biometricThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateSecuritySettingsRequest._() : super();
  factory UpdateSecuritySettingsRequest({
    $core.double? dailyTransactionLimit,
    $core.double? perTransactionLimit,
    $core.bool? requirePinForAll,
    $core.double? biometricThreshold,
  }) {
    final _result = create();
    if (dailyTransactionLimit != null) {
      _result.dailyTransactionLimit = dailyTransactionLimit;
    }
    if (perTransactionLimit != null) {
      _result.perTransactionLimit = perTransactionLimit;
    }
    if (requirePinForAll != null) {
      _result.requirePinForAll = requirePinForAll;
    }
    if (biometricThreshold != null) {
      _result.biometricThreshold = biometricThreshold;
    }
    return _result;
  }
  factory UpdateSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest clone() => UpdateSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest copyWith(void Function(UpdateSecuritySettingsRequest) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsRequest)) as UpdateSecuritySettingsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSecuritySettingsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<SecuritySettings>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false
  ;

  UpdateSecuritySettingsResponse._() : super();
  factory UpdateSecuritySettingsResponse({
    SecuritySettings? settings,
  }) {
    final _result = create();
    if (settings != null) {
      _result.settings = settings;
    }
    return _result;
  }
  factory UpdateSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse clone() => UpdateSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse copyWith(void Function(UpdateSecuritySettingsResponse) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsResponse)) as UpdateSecuritySettingsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSecuritySettingsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSecuritySettingsRequest._() : super();
  factory GetSecuritySettingsRequest() => create();
  factory GetSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsRequest clone() => GetSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsRequest copyWith(void Function(GetSecuritySettingsRequest) updates) => super.copyWith((message) => updates(message as GetSecuritySettingsRequest)) as GetSecuritySettingsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSecuritySettingsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<SecuritySettings>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false
  ;

  GetSecuritySettingsResponse._() : super();
  factory GetSecuritySettingsResponse({
    SecuritySettings? settings,
  }) {
    final _result = create();
    if (settings != null) {
      _result.settings = settings;
    }
    return _result;
  }
  factory GetSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsResponse clone() => GetSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSecuritySettingsResponse copyWith(void Function(GetSecuritySettingsResponse) updates) => super.copyWith((message) => updates(message as GetSecuritySettingsResponse)) as GetSecuritySettingsResponse; // ignore: deprecated_member_use
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

class WhatsAppUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WhatsAppUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whatsappId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkStatus')
    ..aOM<$ts.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAt', subBuilder: $ts.Timestamp.create)
    ..aOM<$ts.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastActiveAt', subBuilder: $ts.Timestamp.create)
    ..hasRequiredFields = false
  ;

  WhatsAppUser._() : super();
  factory WhatsAppUser({
    $core.String? id,
    $core.String? userId,
    $core.String? phoneNumber,
    $core.String? whatsappId,
    $core.String? linkStatus,
    $ts.Timestamp? linkedAt,
    $ts.Timestamp? lastActiveAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (whatsappId != null) {
      _result.whatsappId = whatsappId;
    }
    if (linkStatus != null) {
      _result.linkStatus = linkStatus;
    }
    if (linkedAt != null) {
      _result.linkedAt = linkedAt;
    }
    if (lastActiveAt != null) {
      _result.lastActiveAt = lastActiveAt;
    }
    return _result;
  }
  factory WhatsAppUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppUser clone() => WhatsAppUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppUser copyWith(void Function(WhatsAppUser) updates) => super.copyWith((message) => updates(message as WhatsAppUser)) as WhatsAppUser; // ignore: deprecated_member_use
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
  $ts.Timestamp get linkedAt => $_getN(5);
  @$pb.TagNumber(6)
  set linkedAt($ts.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLinkedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLinkedAt() => clearField(6);
  @$pb.TagNumber(6)
  $ts.Timestamp ensureLinkedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $ts.Timestamp get lastActiveAt => $_getN(6);
  @$pb.TagNumber(7)
  set lastActiveAt($ts.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastActiveAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastActiveAt() => clearField(7);
  @$pb.TagNumber(7)
  $ts.Timestamp ensureLastActiveAt() => $_ensure(6);
}

class GetLinkStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLinkStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetLinkStatusRequest._() : super();
  factory GetLinkStatusRequest() => create();
  factory GetLinkStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkStatusRequest clone() => GetLinkStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkStatusRequest copyWith(void Function(GetLinkStatusRequest) updates) => super.copyWith((message) => updates(message as GetLinkStatusRequest)) as GetLinkStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLinkStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOM<WhatsAppUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whatsappUser', subBuilder: WhatsAppUser.create)
    ..hasRequiredFields = false
  ;

  GetLinkStatusResponse._() : super();
  factory GetLinkStatusResponse({
    WhatsAppUser? whatsappUser,
  }) {
    final _result = create();
    if (whatsappUser != null) {
      _result.whatsappUser = whatsappUser;
    }
    return _result;
  }
  factory GetLinkStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkStatusResponse clone() => GetLinkStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkStatusResponse copyWith(void Function(GetLinkStatusResponse) updates) => super.copyWith((message) => updates(message as GetLinkStatusResponse)) as GetLinkStatusResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WebhookRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'object')
    ..hasRequiredFields = false
  ;

  WebhookRequest._() : super();
  factory WebhookRequest({
    $core.String? object_,
  }) {
    final _result = create();
    if (object_ != null) {
      _result.object_ = object_;
    }
    return _result;
  }
  factory WebhookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookRequest clone() => WebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookRequest copyWith(void Function(WebhookRequest) updates) => super.copyWith((message) => updates(message as WebhookRequest)) as WebhookRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WebhookRequest create() => WebhookRequest._();
  WebhookRequest createEmptyInstance() => create();
  static $pb.PbList<WebhookRequest> createRepeated() => $pb.PbList<WebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static WebhookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebhookRequest>(create);
  static WebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get object_ => $_getSZ(0);
  @$pb.TagNumber(1)
  set object_($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObject_() => $_has(0);
  @$pb.TagNumber(1)
  void clearObject_() => clearField(1);
}

class WebhookResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WebhookResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  WebhookResponse._() : super();
  factory WebhookResponse({
    $core.String? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory WebhookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebhookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebhookResponse clone() => WebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebhookResponse copyWith(void Function(WebhookResponse) updates) => super.copyWith((message) => updates(message as WebhookResponse)) as WebhookResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyWebhookRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hubMode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hubVerifyToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hubChallenge')
    ..hasRequiredFields = false
  ;

  VerifyWebhookRequest._() : super();
  factory VerifyWebhookRequest({
    $core.String? hubMode,
    $core.String? hubVerifyToken,
    $core.String? hubChallenge,
  }) {
    final _result = create();
    if (hubMode != null) {
      _result.hubMode = hubMode;
    }
    if (hubVerifyToken != null) {
      _result.hubVerifyToken = hubVerifyToken;
    }
    if (hubChallenge != null) {
      _result.hubChallenge = hubChallenge;
    }
    return _result;
  }
  factory VerifyWebhookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyWebhookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyWebhookRequest clone() => VerifyWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyWebhookRequest copyWith(void Function(VerifyWebhookRequest) updates) => super.copyWith((message) => updates(message as VerifyWebhookRequest)) as VerifyWebhookRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyWebhookResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'challenge')
    ..hasRequiredFields = false
  ;

  VerifyWebhookResponse._() : super();
  factory VerifyWebhookResponse({
    $core.String? challenge,
  }) {
    final _result = create();
    if (challenge != null) {
      _result.challenge = challenge;
    }
    return _result;
  }
  factory VerifyWebhookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyWebhookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyWebhookResponse clone() => VerifyWebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyWebhookResponse copyWith(void Function(VerifyWebhookResponse) updates) => super.copyWith((message) => updates(message as VerifyWebhookResponse)) as VerifyWebhookResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  GetSessionRequest._() : super();
  factory GetSessionRequest({
    $core.String? sessionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory GetSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSessionRequest clone() => GetSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSessionRequest copyWith(void Function(GetSessionRequest) updates) => super.copyWith((message) => updates(message as GetSessionRequest)) as GetSessionRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSessionResponse._() : super();
  factory GetSessionResponse() => create();
  factory GetSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSessionResponse clone() => GetSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSessionResponse copyWith(void Function(GetSessionResponse) updates) => super.copyWith((message) => updates(message as GetSessionResponse)) as GetSessionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSessionResponse create() => GetSessionResponse._();
  GetSessionResponse createEmptyInstance() => create();
  static $pb.PbList<GetSessionResponse> createRepeated() => $pb.PbList<GetSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSessionResponse>(create);
  static GetSessionResponse? _defaultInstance;
}

class InvalidateSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvalidateSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  InvalidateSessionRequest._() : super();
  factory InvalidateSessionRequest({
    $core.String? sessionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory InvalidateSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvalidateSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvalidateSessionRequest clone() => InvalidateSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvalidateSessionRequest copyWith(void Function(InvalidateSessionRequest) updates) => super.copyWith((message) => updates(message as InvalidateSessionRequest)) as InvalidateSessionRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvalidateSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  InvalidateSessionResponse._() : super();
  factory InvalidateSessionResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory InvalidateSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvalidateSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvalidateSessionResponse clone() => InvalidateSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvalidateSessionResponse copyWith(void Function(InvalidateSessionResponse) updates) => super.copyWith((message) => updates(message as InvalidateSessionResponse)) as InvalidateSessionResponse; // ignore: deprecated_member_use
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

class GetAuditLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAuditLogsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAuditLogsRequest._() : super();
  factory GetAuditLogsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetAuditLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAuditLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAuditLogsRequest clone() => GetAuditLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAuditLogsRequest copyWith(void Function(GetAuditLogsRequest) updates) => super.copyWith((message) => updates(message as GetAuditLogsRequest)) as GetAuditLogsRequest; // ignore: deprecated_member_use
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
}

class GetAuditLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAuditLogsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'whatsapp'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetAuditLogsResponse._() : super();
  factory GetAuditLogsResponse() => create();
  factory GetAuditLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAuditLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAuditLogsResponse clone() => GetAuditLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAuditLogsResponse copyWith(void Function(GetAuditLogsResponse) updates) => super.copyWith((message) => updates(message as GetAuditLogsResponse)) as GetAuditLogsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAuditLogsResponse create() => GetAuditLogsResponse._();
  GetAuditLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAuditLogsResponse> createRepeated() => $pb.PbList<GetAuditLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAuditLogsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAuditLogsResponse>(create);
  static GetAuditLogsResponse? _defaultInstance;
}
