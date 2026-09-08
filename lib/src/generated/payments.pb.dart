// This is a generated file - do not edit.
//
// Generated from payments.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'payments.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'payments.pbenum.dart';

class GetFraudDetectionSettingRequest extends $pb.GeneratedMessage {
  factory GetFraudDetectionSettingRequest() => create();

  GetFraudDetectionSettingRequest._();

  factory GetFraudDetectionSettingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFraudDetectionSettingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFraudDetectionSettingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFraudDetectionSettingRequest clone() =>
      GetFraudDetectionSettingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFraudDetectionSettingRequest copyWith(
          void Function(GetFraudDetectionSettingRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetFraudDetectionSettingRequest))
          as GetFraudDetectionSettingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFraudDetectionSettingRequest create() =>
      GetFraudDetectionSettingRequest._();
  @$core.override
  GetFraudDetectionSettingRequest createEmptyInstance() => create();
  static $pb.PbList<GetFraudDetectionSettingRequest> createRepeated() =>
      $pb.PbList<GetFraudDetectionSettingRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFraudDetectionSettingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFraudDetectionSettingRequest>(
          create);
  static GetFraudDetectionSettingRequest? _defaultInstance;
}

class SetFraudDetectionSettingRequest extends $pb.GeneratedMessage {
  factory SetFraudDetectionSettingRequest({
    $core.bool? enabled,
  }) {
    final result = create();
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  SetFraudDetectionSettingRequest._();

  factory SetFraudDetectionSettingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetFraudDetectionSettingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetFraudDetectionSettingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetFraudDetectionSettingRequest clone() =>
      SetFraudDetectionSettingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetFraudDetectionSettingRequest copyWith(
          void Function(SetFraudDetectionSettingRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetFraudDetectionSettingRequest))
          as SetFraudDetectionSettingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFraudDetectionSettingRequest create() =>
      SetFraudDetectionSettingRequest._();
  @$core.override
  SetFraudDetectionSettingRequest createEmptyInstance() => create();
  static $pb.PbList<SetFraudDetectionSettingRequest> createRepeated() =>
      $pb.PbList<SetFraudDetectionSettingRequest>();
  @$core.pragma('dart2js:noInline')
  static SetFraudDetectionSettingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetFraudDetectionSettingRequest>(
          create);
  static SetFraudDetectionSettingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => $_clearField(1);
}

class FraudDetectionSetting extends $pb.GeneratedMessage {
  factory FraudDetectionSetting({
    $core.bool? enabled,
  }) {
    final result = create();
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  FraudDetectionSetting._();

  factory FraudDetectionSetting.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FraudDetectionSetting.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FraudDetectionSetting',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FraudDetectionSetting clone() =>
      FraudDetectionSetting()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FraudDetectionSetting copyWith(
          void Function(FraudDetectionSetting) updates) =>
      super.copyWith((message) => updates(message as FraudDetectionSetting))
          as FraudDetectionSetting;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FraudDetectionSetting create() => FraudDetectionSetting._();
  @$core.override
  FraudDetectionSetting createEmptyInstance() => create();
  static $pb.PbList<FraudDetectionSetting> createRepeated() =>
      $pb.PbList<FraudDetectionSetting>();
  @$core.pragma('dart2js:noInline')
  static FraudDetectionSetting getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FraudDetectionSetting>(create);
  static FraudDetectionSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => $_clearField(1);
}

class GetFraudFreezeStatusRequest extends $pb.GeneratedMessage {
  factory GetFraudFreezeStatusRequest() => create();

  GetFraudFreezeStatusRequest._();

  factory GetFraudFreezeStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFraudFreezeStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFraudFreezeStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFraudFreezeStatusRequest clone() =>
      GetFraudFreezeStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFraudFreezeStatusRequest copyWith(
          void Function(GetFraudFreezeStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetFraudFreezeStatusRequest))
          as GetFraudFreezeStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFraudFreezeStatusRequest create() =>
      GetFraudFreezeStatusRequest._();
  @$core.override
  GetFraudFreezeStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetFraudFreezeStatusRequest> createRepeated() =>
      $pb.PbList<GetFraudFreezeStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFraudFreezeStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFraudFreezeStatusRequest>(create);
  static GetFraudFreezeStatusRequest? _defaultInstance;
}

class FraudFreezeStatus extends $pb.GeneratedMessage {
  factory FraudFreezeStatus({
    $core.bool? frozen,
    $core.String? reason,
    $fixnum.Int64? amountMinor,
    $fixnum.Int64? limitMinor,
    $core.String? blockedAt,
    $core.String? reference,
    $core.String? blockedId,
  }) {
    final result = create();
    if (frozen != null) result.frozen = frozen;
    if (reason != null) result.reason = reason;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (limitMinor != null) result.limitMinor = limitMinor;
    if (blockedAt != null) result.blockedAt = blockedAt;
    if (reference != null) result.reference = reference;
    if (blockedId != null) result.blockedId = blockedId;
    return result;
  }

  FraudFreezeStatus._();

  factory FraudFreezeStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FraudFreezeStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FraudFreezeStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'frozen')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'limitMinor')
    ..aOS(5, _omitFieldNames ? '' : 'blockedAt')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..aOS(7, _omitFieldNames ? '' : 'blockedId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FraudFreezeStatus clone() => FraudFreezeStatus()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FraudFreezeStatus copyWith(void Function(FraudFreezeStatus) updates) =>
      super.copyWith((message) => updates(message as FraudFreezeStatus))
          as FraudFreezeStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FraudFreezeStatus create() => FraudFreezeStatus._();
  @$core.override
  FraudFreezeStatus createEmptyInstance() => create();
  static $pb.PbList<FraudFreezeStatus> createRepeated() =>
      $pb.PbList<FraudFreezeStatus>();
  @$core.pragma('dart2js:noInline')
  static FraudFreezeStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FraudFreezeStatus>(create);
  static FraudFreezeStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get frozen => $_getBF(0);
  @$pb.TagNumber(1)
  set frozen($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFrozen() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrozen() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get limitMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set limitMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimitMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimitMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get blockedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set blockedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBlockedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearBlockedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get blockedId => $_getSZ(6);
  @$pb.TagNumber(7)
  set blockedId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBlockedId() => $_has(6);
  @$pb.TagNumber(7)
  void clearBlockedId() => $_clearField(7);
}

class RequestFraudUnfreezeRequest extends $pb.GeneratedMessage {
  factory RequestFraudUnfreezeRequest({
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final result = create();
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  RequestFraudUnfreezeRequest._();

  factory RequestFraudUnfreezeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestFraudUnfreezeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestFraudUnfreezeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestFraudUnfreezeRequest clone() =>
      RequestFraudUnfreezeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestFraudUnfreezeRequest copyWith(
          void Function(RequestFraudUnfreezeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestFraudUnfreezeRequest))
          as RequestFraudUnfreezeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestFraudUnfreezeRequest create() =>
      RequestFraudUnfreezeRequest._();
  @$core.override
  RequestFraudUnfreezeRequest createEmptyInstance() => create();
  static $pb.PbList<RequestFraudUnfreezeRequest> createRepeated() =>
      $pb.PbList<RequestFraudUnfreezeRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestFraudUnfreezeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestFraudUnfreezeRequest>(create);
  static RequestFraudUnfreezeRequest? _defaultInstance;

  /// Transaction-PIN verification token (the SAME token the send-funds flow uses,
  /// minted after the tx-PIN bottomsheet) + the transaction id it is bound to.
  @$pb.TagNumber(1)
  $core.String get verificationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerificationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);
}

class RequestFraudUnfreezeResponse extends $pb.GeneratedMessage {
  factory RequestFraudUnfreezeResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  RequestFraudUnfreezeResponse._();

  factory RequestFraudUnfreezeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestFraudUnfreezeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestFraudUnfreezeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestFraudUnfreezeResponse clone() =>
      RequestFraudUnfreezeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestFraudUnfreezeResponse copyWith(
          void Function(RequestFraudUnfreezeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestFraudUnfreezeResponse))
          as RequestFraudUnfreezeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestFraudUnfreezeResponse create() =>
      RequestFraudUnfreezeResponse._();
  @$core.override
  RequestFraudUnfreezeResponse createEmptyInstance() => create();
  static $pb.PbList<RequestFraudUnfreezeResponse> createRepeated() =>
      $pb.PbList<RequestFraudUnfreezeResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestFraudUnfreezeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestFraudUnfreezeResponse>(create);
  static RequestFraudUnfreezeResponse? _defaultInstance;

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

class Payment extends $pb.GeneratedMessage {
  factory Payment({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? paymentType,
    $core.String? reference,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? recipient,
    $core.String? description,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (paymentType != null) result.paymentType = paymentType;
    if (reference != null) result.reference = reference;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (recipient != null) result.recipient = recipient;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Payment._();

  factory Payment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Payment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Payment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'paymentType')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'recipient')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..aOS(11, _omitFieldNames ? '' : 'metadata')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Payment clone() => Payment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Payment copyWith(void Function(Payment) updates) =>
      super.copyWith((message) => updates(message as Payment)) as Payment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Payment create() => Payment._();
  @$core.override
  Payment createEmptyInstance() => create();
  static $pb.PbList<Payment> createRepeated() => $pb.PbList<Payment>();
  @$core.pragma('dart2js:noInline')
  static Payment getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payment>(create);
  static Payment? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get recipient => $_getSZ(8);
  @$pb.TagNumber(9)
  set recipient($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRecipient() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipient() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get metadata => $_getSZ(10);
  @$pb.TagNumber(11)
  set metadata($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMetadata() => $_has(10);
  @$pb.TagNumber(11)
  void clearMetadata() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
}

class BillProvider extends $pb.GeneratedMessage {
  factory BillProvider({
    $core.String? id,
    $core.String? name,
    $core.String? type,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.double? minAmount,
    $core.double? maxAmount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (type != null) result.type = type;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (isActive != null) result.isActive = isActive;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    return result;
  }

  BillProvider._();

  factory BillProvider.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BillProvider.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BillProvider',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'logoUrl')
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillProvider clone() => BillProvider()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillProvider copyWith(void Function(BillProvider) updates) =>
      super.copyWith((message) => updates(message as BillProvider))
          as BillProvider;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillProvider create() => BillProvider._();
  @$core.override
  BillProvider createEmptyInstance() => create();
  static $pb.PbList<BillProvider> createRepeated() =>
      $pb.PbList<BillProvider>();
  @$core.pragma('dart2js:noInline')
  static BillProvider getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BillProvider>(create);
  static BillProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get minAmount => $_getN(5);
  @$pb.TagNumber(6)
  set minAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMinAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get maxAmount => $_getN(6);
  @$pb.TagNumber(7)
  set maxAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMaxAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxAmount() => $_clearField(7);
}

class AirtimeProvider extends $pb.GeneratedMessage {
  factory AirtimeProvider({
    $core.String? id,
    $core.String? name,
    $core.String? network,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.Iterable<$core.String>? denominations,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (network != null) result.network = network;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (isActive != null) result.isActive = isActive;
    if (denominations != null) result.denominations.addAll(denominations);
    return result;
  }

  AirtimeProvider._();

  factory AirtimeProvider.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AirtimeProvider.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AirtimeProvider',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'network')
    ..aOS(4, _omitFieldNames ? '' : 'logoUrl')
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..pPS(6, _omitFieldNames ? '' : 'denominations')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AirtimeProvider clone() => AirtimeProvider()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AirtimeProvider copyWith(void Function(AirtimeProvider) updates) =>
      super.copyWith((message) => updates(message as AirtimeProvider))
          as AirtimeProvider;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AirtimeProvider create() => AirtimeProvider._();
  @$core.override
  AirtimeProvider createEmptyInstance() => create();
  static $pb.PbList<AirtimeProvider> createRepeated() =>
      $pb.PbList<AirtimeProvider>();
  @$core.pragma('dart2js:noInline')
  static AirtimeProvider getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AirtimeProvider>(create);
  static AirtimeProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get network => $_getSZ(2);
  @$pb.TagNumber(3)
  set network($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearNetwork() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get denominations => $_getList(5);
}

/// ===== SEND FUNDS (Transfer) =====
/// NOTE: user_id extracted from JWT token, not from request
class SendFundsRequest extends $pb.GeneratedMessage {
  factory SendFundsRequest({
    $core.String? fromAccountId,
    $core.String? toAccountNumber,
    $core.double? amount,
    $core.String? description,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? destinationBankCode,
    $core.String? beneficiaryName,
    $core.String? toAccountId,
    $core.String? type,
    $core.int? expenseCategory,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (toAccountNumber != null) result.toAccountNumber = toAccountNumber;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (beneficiaryName != null) result.beneficiaryName = beneficiaryName;
    if (toAccountId != null) result.toAccountId = toAccountId;
    if (type != null) result.type = type;
    if (expenseCategory != null) result.expenseCategory = expenseCategory;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  SendFundsRequest._();

  factory SendFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'toAccountNumber')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(7, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(8, _omitFieldNames ? '' : 'beneficiaryName')
    ..aOS(9, _omitFieldNames ? '' : 'toAccountId')
    ..aOS(10, _omitFieldNames ? '' : 'type')
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'expenseCategory', $pb.PbFieldType.O3)
    ..aOS(12, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendFundsRequest clone() => SendFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendFundsRequest copyWith(void Function(SendFundsRequest) updates) =>
      super.copyWith((message) => updates(message as SendFundsRequest))
          as SendFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendFundsRequest create() => SendFundsRequest._();
  @$core.override
  SendFundsRequest createEmptyInstance() => create();
  static $pb.PbList<SendFundsRequest> createRepeated() =>
      $pb.PbList<SendFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static SendFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendFundsRequest>(create);
  static SendFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toAccountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set toAccountNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAccountNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);

  /// External transfer fields
  @$pb.TagNumber(7)
  $core.String get destinationBankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationBankCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDestinationBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationBankCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get beneficiaryName => $_getSZ(7);
  @$pb.TagNumber(8)
  set beneficiaryName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBeneficiaryName() => $_has(7);
  @$pb.TagNumber(8)
  void clearBeneficiaryName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get toAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set toAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasToAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearToAccountId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get type => $_getSZ(9);
  @$pb.TagNumber(10)
  set type($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasType() => $_has(9);
  @$pb.TagNumber(10)
  void clearType() => $_clearField(10);

  /// Budget tracking
  @$pb.TagNumber(11)
  $core.int get expenseCategory => $_getIZ(10);
  @$pb.TagNumber(11)
  set expenseCategory($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasExpenseCategory() => $_has(10);
  @$pb.TagNumber(11)
  void clearExpenseCategory() => $_clearField(11);

  /// Idempotency key — OPTIONAL, decoupled from transaction_id. transaction_id is
  /// dual-purpose: it binds the PIN verification_token (PreValidate) AND, when this
  /// field is empty, it is ALSO used as the idempotency reference. That conflation
  /// is a money-safety hazard for fan-out payers who share one token-binding id
  /// (e.g. every co-payer of a split bill pays with transaction_id=SPLIT-PAY-{bill}):
  /// the 2nd payer's SendFunds would dedupe against the 1st's cached payment and be
  /// marked paid WITHOUT a debit. When set, the service derives the idempotency
  /// reference from THIS key instead of transaction_id, so each payer dedups
  /// independently while the token still validates against the shared transaction_id.
  @$pb.TagNumber(12)
  $core.String get idempotencyKey => $_getSZ(11);
  @$pb.TagNumber(12)
  set idempotencyKey($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIdempotencyKey() => $_has(11);
  @$pb.TagNumber(12)
  void clearIdempotencyKey() => $_clearField(12);
}

class SendFundsResponse extends $pb.GeneratedMessage {
  factory SendFundsResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? recipientName,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (recipientName != null) result.recipientName = recipientName;
    if (message != null) result.message = message;
    return result;
  }

  SendFundsResponse._();

  factory SendFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendFundsResponse clone() => SendFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendFundsResponse copyWith(void Function(SendFundsResponse) updates) =>
      super.copyWith((message) => updates(message as SendFundsResponse))
          as SendFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendFundsResponse create() => SendFundsResponse._();
  @$core.override
  SendFundsResponse createEmptyInstance() => create();
  static $pb.PbList<SendFundsResponse> createRepeated() =>
      $pb.PbList<SendFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static SendFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendFundsResponse>(create);
  static SendFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

class BatchTransferItem extends $pb.GeneratedMessage {
  factory BatchTransferItem({
    $core.String? toAccountNumber,
    $core.double? amount,
    $core.String? description,
    $core.String? reference,
    $core.String? category,
    $core.String? destinationBankCode,
    $core.String? beneficiaryName,
    $core.String? destinationBankName,
    $core.String? toAccountId,
    $core.String? transferType,
  }) {
    final result = create();
    if (toAccountNumber != null) result.toAccountNumber = toAccountNumber;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (reference != null) result.reference = reference;
    if (category != null) result.category = category;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (beneficiaryName != null) result.beneficiaryName = beneficiaryName;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (toAccountId != null) result.toAccountId = toAccountId;
    if (transferType != null) result.transferType = transferType;
    return result;
  }

  BatchTransferItem._();

  factory BatchTransferItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchTransferItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchTransferItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'toAccountNumber')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOS(6, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(7, _omitFieldNames ? '' : 'beneficiaryName')
    ..aOS(8, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(9, _omitFieldNames ? '' : 'toAccountId')
    ..aOS(10, _omitFieldNames ? '' : 'transferType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferItem clone() => BatchTransferItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferItem copyWith(void Function(BatchTransferItem) updates) =>
      super.copyWith((message) => updates(message as BatchTransferItem))
          as BatchTransferItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchTransferItem create() => BatchTransferItem._();
  @$core.override
  BatchTransferItem createEmptyInstance() => create();
  static $pb.PbList<BatchTransferItem> createRepeated() =>
      $pb.PbList<BatchTransferItem>();
  @$core.pragma('dart2js:noInline')
  static BatchTransferItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchTransferItem>(create);
  static BatchTransferItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get toAccountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set toAccountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearToAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get destinationBankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set destinationBankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDestinationBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get beneficiaryName => $_getSZ(6);
  @$pb.TagNumber(7)
  set beneficiaryName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBeneficiaryName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBeneficiaryName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get destinationBankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set destinationBankName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDestinationBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearDestinationBankName() => $_clearField(8);

  /// SendFunds parity: the recipient's account/user UUID for internal legs —
  /// the stable routing identifier, resolved exactly like SendFunds'
  /// to_account_id (GetAccountByID → user-UUID → primary account).
  @$pb.TagNumber(9)
  $core.String get toAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set toAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasToAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearToAccountId() => $_clearField(9);

  /// "internal" | "external" | "" (legacy: inferred from bank code). Explicit
  /// like SendFunds' type field — an external leg skips internal lookups.
  @$pb.TagNumber(10)
  $core.String get transferType => $_getSZ(9);
  @$pb.TagNumber(10)
  set transferType($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransferType() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransferType() => $_clearField(10);
}

/// NOTE: user_id extracted from JWT token, not from request
class BatchTransferRequest extends $pb.GeneratedMessage {
  factory BatchTransferRequest({
    $core.String? fromAccountId,
    $core.Iterable<BatchTransferItem>? transfers,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (transfers != null) result.transfers.addAll(transfers);
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BatchTransferRequest._();

  factory BatchTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..pc<BatchTransferItem>(
        2, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM,
        subBuilder: BatchTransferItem.create)
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferRequest clone() =>
      BatchTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferRequest copyWith(void Function(BatchTransferRequest) updates) =>
      super.copyWith((message) => updates(message as BatchTransferRequest))
          as BatchTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchTransferRequest create() => BatchTransferRequest._();
  @$core.override
  BatchTransferRequest createEmptyInstance() => create();
  static $pb.PbList<BatchTransferRequest> createRepeated() =>
      $pb.PbList<BatchTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchTransferRequest>(create);
  static BatchTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<BatchTransferItem> get transfers => $_getList(1);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => $_clearField(4);
}

class BatchTransferResponse extends $pb.GeneratedMessage {
  factory BatchTransferResponse({
    $core.String? batchId,
    $core.int? totalTransfers,
    $core.int? successfulTransfers,
    $core.int? failedTransfers,
    $core.Iterable<BatchTransferResultItem>? results,
    $core.double? newBalance,
    $core.String? message,
    $core.String? status,
    $core.double? totalAmount,
    $core.double? totalFee,
    $core.String? createdAt,
    $core.String? completedAt,
  }) {
    final result = create();
    if (batchId != null) result.batchId = batchId;
    if (totalTransfers != null) result.totalTransfers = totalTransfers;
    if (successfulTransfers != null)
      result.successfulTransfers = successfulTransfers;
    if (failedTransfers != null) result.failedTransfers = failedTransfers;
    if (results != null) result.results.addAll(results);
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (totalFee != null) result.totalFee = totalFee;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  BatchTransferResponse._();

  factory BatchTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'batchId')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'totalTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'successfulTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'failedTransfers', $pb.PbFieldType.O3)
    ..pc<BatchTransferResultItem>(
        5, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: BatchTransferResultItem.create)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'message')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'totalFee', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'completedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferResponse clone() =>
      BatchTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferResponse copyWith(
          void Function(BatchTransferResponse) updates) =>
      super.copyWith((message) => updates(message as BatchTransferResponse))
          as BatchTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchTransferResponse create() => BatchTransferResponse._();
  @$core.override
  BatchTransferResponse createEmptyInstance() => create();
  static $pb.PbList<BatchTransferResponse> createRepeated() =>
      $pb.PbList<BatchTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchTransferResponse>(create);
  static BatchTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalTransfers => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalTransfers($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalTransfers() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalTransfers() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get successfulTransfers => $_getIZ(2);
  @$pb.TagNumber(3)
  set successfulTransfers($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccessfulTransfers() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccessfulTransfers() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get failedTransfers => $_getIZ(3);
  @$pb.TagNumber(4)
  set failedTransfers($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFailedTransfers() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailedTransfers() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<BatchTransferResultItem> get results => $_getList(4);

  @$pb.TagNumber(6)
  $core.double get newBalance => $_getN(5);
  @$pb.TagNumber(6)
  set newBalance($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNewBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get totalAmount => $_getN(8);
  @$pb.TagNumber(9)
  set totalAmount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get totalFee => $_getN(9);
  @$pb.TagNumber(10)
  set totalFee($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTotalFee() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalFee() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get completedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set completedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCompletedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCompletedAt() => $_clearField(12);
}

class BatchTransferResultItem extends $pb.GeneratedMessage {
  factory BatchTransferResultItem({
    $core.String? transferId,
    $core.String? status,
    $core.double? amount,
    $core.double? fee,
    $core.String? recipientName,
    $core.String? recipientAccount,
    $core.String? failureReason,
    $core.String? reference,
    $core.String? destinationBankCode,
    $core.String? destinationBankName,
    $core.String? transferType,
    $core.String? beneficiaryName,
    $core.String? recipientUserId,
  }) {
    final result = create();
    if (transferId != null) result.transferId = transferId;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientAccount != null) result.recipientAccount = recipientAccount;
    if (failureReason != null) result.failureReason = failureReason;
    if (reference != null) result.reference = reference;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (transferType != null) result.transferType = transferType;
    if (beneficiaryName != null) result.beneficiaryName = beneficiaryName;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    return result;
  }

  BatchTransferResultItem._();

  factory BatchTransferResultItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchTransferResultItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchTransferResultItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transferId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'recipientName')
    ..aOS(6, _omitFieldNames ? '' : 'recipientAccount')
    ..aOS(7, _omitFieldNames ? '' : 'failureReason')
    ..aOS(8, _omitFieldNames ? '' : 'reference')
    ..aOS(9, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(10, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(11, _omitFieldNames ? '' : 'transferType')
    ..aOS(12, _omitFieldNames ? '' : 'beneficiaryName')
    ..aOS(13, _omitFieldNames ? '' : 'recipientUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferResultItem clone() =>
      BatchTransferResultItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferResultItem copyWith(
          void Function(BatchTransferResultItem) updates) =>
      super.copyWith((message) => updates(message as BatchTransferResultItem))
          as BatchTransferResultItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchTransferResultItem create() => BatchTransferResultItem._();
  @$core.override
  BatchTransferResultItem createEmptyInstance() => create();
  static $pb.PbList<BatchTransferResultItem> createRepeated() =>
      $pb.PbList<BatchTransferResultItem>();
  @$core.pragma('dart2js:noInline')
  static BatchTransferResultItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchTransferResultItem>(create);
  static BatchTransferResultItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transferId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transferId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get fee => $_getN(3);
  @$pb.TagNumber(4)
  set fee($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientAccount => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientAccount($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientAccount() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientAccount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get failureReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set failureReason($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFailureReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailureReason() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reference => $_getSZ(7);
  @$pb.TagNumber(8)
  set reference($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearReference() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationBankCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationBankCode($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationBankCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationBankCode() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get destinationBankName => $_getSZ(9);
  @$pb.TagNumber(10)
  set destinationBankName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDestinationBankName() => $_has(9);
  @$pb.TagNumber(10)
  void clearDestinationBankName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get transferType => $_getSZ(10);
  @$pb.TagNumber(11)
  set transferType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTransferType() => $_has(10);
  @$pb.TagNumber(11)
  void clearTransferType() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get beneficiaryName => $_getSZ(11);
  @$pb.TagNumber(12)
  set beneficiaryName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBeneficiaryName() => $_has(11);
  @$pb.TagNumber(12)
  void clearBeneficiaryName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get recipientUserId => $_getSZ(12);
  @$pb.TagNumber(13)
  set recipientUserId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasRecipientUserId() => $_has(12);
  @$pb.TagNumber(13)
  void clearRecipientUserId() => $_clearField(13);
}

/// ===== WITHDRAW =====
/// NOTE: user_id extracted from JWT token, not from request
class WithdrawRequest extends $pb.GeneratedMessage {
  factory WithdrawRequest({
    $core.String? accountId,
    $core.double? amount,
    $core.String? description,
    $core.String? location,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (location != null) result.location = location;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  WithdrawRequest._();

  factory WithdrawRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'location')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawRequest clone() => WithdrawRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawRequest copyWith(void Function(WithdrawRequest) updates) =>
      super.copyWith((message) => updates(message as WithdrawRequest))
          as WithdrawRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawRequest create() => WithdrawRequest._();
  @$core.override
  WithdrawRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawRequest> createRepeated() =>
      $pb.PbList<WithdrawRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawRequest>(create);
  static WithdrawRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get location => $_getSZ(3);
  @$pb.TagNumber(4)
  set location($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocation() => $_clearField(4);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);
}

class WithdrawResponse extends $pb.GeneratedMessage {
  factory WithdrawResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.double? availableBalance,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (availableBalance != null) result.availableBalance = availableBalance;
    if (message != null) result.message = message;
    return result;
  }

  WithdrawResponse._();

  factory WithdrawResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawResponse clone() => WithdrawResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawResponse copyWith(void Function(WithdrawResponse) updates) =>
      super.copyWith((message) => updates(message as WithdrawResponse))
          as WithdrawResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawResponse create() => WithdrawResponse._();
  @$core.override
  WithdrawResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawResponse> createRepeated() =>
      $pb.PbList<WithdrawResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawResponse>(create);
  static WithdrawResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get availableBalance => $_getN(2);
  @$pb.TagNumber(3)
  set availableBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvailableBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvailableBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// ===== DEPOSIT =====
/// NOTE: user_id extracted from JWT token, not from request
class DepositRequest extends $pb.GeneratedMessage {
  factory DepositRequest({
    $core.String? accountId,
    $core.double? amount,
    $core.String? description,
    $core.String? location,
    $core.String? depositType,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (location != null) result.location = location;
    if (depositType != null) result.depositType = depositType;
    return result;
  }

  DepositRequest._();

  factory DepositRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'location')
    ..aOS(5, _omitFieldNames ? '' : 'depositType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositRequest clone() => DepositRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositRequest copyWith(void Function(DepositRequest) updates) =>
      super.copyWith((message) => updates(message as DepositRequest))
          as DepositRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositRequest create() => DepositRequest._();
  @$core.override
  DepositRequest createEmptyInstance() => create();
  static $pb.PbList<DepositRequest> createRepeated() =>
      $pb.PbList<DepositRequest>();
  @$core.pragma('dart2js:noInline')
  static DepositRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositRequest>(create);
  static DepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get location => $_getSZ(3);
  @$pb.TagNumber(4)
  set location($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocation() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get depositType => $_getSZ(4);
  @$pb.TagNumber(5)
  set depositType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDepositType() => $_has(4);
  @$pb.TagNumber(5)
  void clearDepositType() => $_clearField(5);
}

class DepositResponse extends $pb.GeneratedMessage {
  factory DepositResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.double? availableBalance,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (availableBalance != null) result.availableBalance = availableBalance;
    if (message != null) result.message = message;
    return result;
  }

  DepositResponse._();

  factory DepositResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositResponse clone() => DepositResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositResponse copyWith(void Function(DepositResponse) updates) =>
      super.copyWith((message) => updates(message as DepositResponse))
          as DepositResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositResponse create() => DepositResponse._();
  @$core.override
  DepositResponse createEmptyInstance() => create();
  static $pb.PbList<DepositResponse> createRepeated() =>
      $pb.PbList<DepositResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositResponse>(create);
  static DepositResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get availableBalance => $_getN(2);
  @$pb.TagNumber(3)
  set availableBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvailableBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvailableBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// ===== TAG PAY =====
/// NOTE: user_id extracted from JWT token, not from request
class PayWithTagRequest extends $pb.GeneratedMessage {
  factory PayWithTagRequest({
    $core.String? fromAccountId,
    $core.String? recipientTag,
    $core.double? amount,
    $core.String? description,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (recipientTag != null) result.recipientTag = recipientTag;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  PayWithTagRequest._();

  factory PayWithTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayWithTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayWithTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'recipientTag')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithTagRequest clone() => PayWithTagRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithTagRequest copyWith(void Function(PayWithTagRequest) updates) =>
      super.copyWith((message) => updates(message as PayWithTagRequest))
          as PayWithTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayWithTagRequest create() => PayWithTagRequest._();
  @$core.override
  PayWithTagRequest createEmptyInstance() => create();
  static $pb.PbList<PayWithTagRequest> createRepeated() =>
      $pb.PbList<PayWithTagRequest>();
  @$core.pragma('dart2js:noInline')
  static PayWithTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayWithTagRequest>(create);
  static PayWithTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientTag => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientTag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecipientTag() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientTag() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);
}

class PayWithTagResponse extends $pb.GeneratedMessage {
  factory PayWithTagResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? recipientName,
    $core.String? recipientAccount,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientAccount != null) result.recipientAccount = recipientAccount;
    if (message != null) result.message = message;
    return result;
  }

  PayWithTagResponse._();

  factory PayWithTagResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayWithTagResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayWithTagResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..aOS(4, _omitFieldNames ? '' : 'recipientAccount')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithTagResponse clone() => PayWithTagResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithTagResponse copyWith(void Function(PayWithTagResponse) updates) =>
      super.copyWith((message) => updates(message as PayWithTagResponse))
          as PayWithTagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayWithTagResponse create() => PayWithTagResponse._();
  @$core.override
  PayWithTagResponse createEmptyInstance() => create();
  static $pb.PbList<PayWithTagResponse> createRepeated() =>
      $pb.PbList<PayWithTagResponse>();
  @$core.pragma('dart2js:noInline')
  static PayWithTagResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayWithTagResponse>(create);
  static PayWithTagResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientAccount => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientAccount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientAccount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

/// ===== ELECTRICITY BILL =====
/// NOTE: user_id extracted from JWT token, not from request
class PayElectricityBillRequest extends $pb.GeneratedMessage {
  factory PayElectricityBillRequest({
    $core.String? accountId,
    $core.String? providerId,
    $core.String? meterNumber,
    $core.double? amount,
    $core.String? meterType,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (providerId != null) result.providerId = providerId;
    if (meterNumber != null) result.meterNumber = meterNumber;
    if (amount != null) result.amount = amount;
    if (meterType != null) result.meterType = meterType;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  PayElectricityBillRequest._();

  factory PayElectricityBillRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayElectricityBillRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayElectricityBillRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'providerId')
    ..aOS(3, _omitFieldNames ? '' : 'meterNumber')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'meterType')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayElectricityBillRequest clone() =>
      PayElectricityBillRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayElectricityBillRequest copyWith(
          void Function(PayElectricityBillRequest) updates) =>
      super.copyWith((message) => updates(message as PayElectricityBillRequest))
          as PayElectricityBillRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayElectricityBillRequest create() => PayElectricityBillRequest._();
  @$core.override
  PayElectricityBillRequest createEmptyInstance() => create();
  static $pb.PbList<PayElectricityBillRequest> createRepeated() =>
      $pb.PbList<PayElectricityBillRequest>();
  @$core.pragma('dart2js:noInline')
  static PayElectricityBillRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayElectricityBillRequest>(create);
  static PayElectricityBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get meterNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set meterNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMeterNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearMeterNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterType => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMeterType() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterType() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class PayElectricityBillResponse extends $pb.GeneratedMessage {
  factory PayElectricityBillResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? token,
    $core.String? units,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (token != null) result.token = token;
    if (units != null) result.units = units;
    if (message != null) result.message = message;
    return result;
  }

  PayElectricityBillResponse._();

  factory PayElectricityBillResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayElectricityBillResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayElectricityBillResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'token')
    ..aOS(4, _omitFieldNames ? '' : 'units')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayElectricityBillResponse clone() =>
      PayElectricityBillResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayElectricityBillResponse copyWith(
          void Function(PayElectricityBillResponse) updates) =>
      super.copyWith(
              (message) => updates(message as PayElectricityBillResponse))
          as PayElectricityBillResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayElectricityBillResponse create() => PayElectricityBillResponse._();
  @$core.override
  PayElectricityBillResponse createEmptyInstance() => create();
  static $pb.PbList<PayElectricityBillResponse> createRepeated() =>
      $pb.PbList<PayElectricityBillResponse>();
  @$core.pragma('dart2js:noInline')
  static PayElectricityBillResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayElectricityBillResponse>(create);
  static PayElectricityBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get units => $_getSZ(3);
  @$pb.TagNumber(4)
  set units($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnits() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnits() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

/// ===== AIRTIME =====
/// NOTE: user_id extracted from JWT token, not from request
class BuyAirtimeRequest extends $pb.GeneratedMessage {
  factory BuyAirtimeRequest({
    $core.String? accountId,
    $core.String? providerId,
    $core.String? phoneNumber,
    $core.double? amount,
    $core.String? airtimeType,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (providerId != null) result.providerId = providerId;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (amount != null) result.amount = amount;
    if (airtimeType != null) result.airtimeType = airtimeType;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BuyAirtimeRequest._();

  factory BuyAirtimeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyAirtimeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyAirtimeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'providerId')
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'airtimeType')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyAirtimeRequest clone() => BuyAirtimeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyAirtimeRequest copyWith(void Function(BuyAirtimeRequest) updates) =>
      super.copyWith((message) => updates(message as BuyAirtimeRequest))
          as BuyAirtimeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyAirtimeRequest create() => BuyAirtimeRequest._();
  @$core.override
  BuyAirtimeRequest createEmptyInstance() => create();
  static $pb.PbList<BuyAirtimeRequest> createRepeated() =>
      $pb.PbList<BuyAirtimeRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyAirtimeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyAirtimeRequest>(create);
  static BuyAirtimeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get airtimeType => $_getSZ(4);
  @$pb.TagNumber(5)
  set airtimeType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAirtimeType() => $_has(4);
  @$pb.TagNumber(5)
  void clearAirtimeType() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class BuyAirtimeResponse extends $pb.GeneratedMessage {
  factory BuyAirtimeResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? phoneNumber,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (message != null) result.message = message;
    return result;
  }

  BuyAirtimeResponse._();

  factory BuyAirtimeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyAirtimeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyAirtimeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyAirtimeResponse clone() => BuyAirtimeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyAirtimeResponse copyWith(void Function(BuyAirtimeResponse) updates) =>
      super.copyWith((message) => updates(message as BuyAirtimeResponse))
          as BuyAirtimeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyAirtimeResponse create() => BuyAirtimeResponse._();
  @$core.override
  BuyAirtimeResponse createEmptyInstance() => create();
  static $pb.PbList<BuyAirtimeResponse> createRepeated() =>
      $pb.PbList<BuyAirtimeResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyAirtimeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyAirtimeResponse>(create);
  static BuyAirtimeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// ===== BARCODE PAY =====
/// NOTE: user_id extracted from JWT token, not from request
class BarcodePayRequest extends $pb.GeneratedMessage {
  factory BarcodePayRequest({
    $core.String? accountId,
    $core.String? barcodeData,
    $core.double? amount,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (barcodeData != null) result.barcodeData = barcodeData;
    if (amount != null) result.amount = amount;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BarcodePayRequest._();

  factory BarcodePayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BarcodePayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BarcodePayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'barcodeData')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BarcodePayRequest clone() => BarcodePayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BarcodePayRequest copyWith(void Function(BarcodePayRequest) updates) =>
      super.copyWith((message) => updates(message as BarcodePayRequest))
          as BarcodePayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BarcodePayRequest create() => BarcodePayRequest._();
  @$core.override
  BarcodePayRequest createEmptyInstance() => create();
  static $pb.PbList<BarcodePayRequest> createRepeated() =>
      $pb.PbList<BarcodePayRequest>();
  @$core.pragma('dart2js:noInline')
  static BarcodePayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BarcodePayRequest>(create);
  static BarcodePayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get barcodeData => $_getSZ(1);
  @$pb.TagNumber(2)
  set barcodeData($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBarcodeData() => $_has(1);
  @$pb.TagNumber(2)
  void clearBarcodeData() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => $_clearField(5);
}

class BarcodePayResponse extends $pb.GeneratedMessage {
  factory BarcodePayResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? merchantName,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (merchantName != null) result.merchantName = merchantName;
    if (message != null) result.message = message;
    return result;
  }

  BarcodePayResponse._();

  factory BarcodePayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BarcodePayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BarcodePayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'merchantName')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BarcodePayResponse clone() => BarcodePayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BarcodePayResponse copyWith(void Function(BarcodePayResponse) updates) =>
      super.copyWith((message) => updates(message as BarcodePayResponse))
          as BarcodePayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BarcodePayResponse create() => BarcodePayResponse._();
  @$core.override
  BarcodePayResponse createEmptyInstance() => create();
  static $pb.PbList<BarcodePayResponse> createRepeated() =>
      $pb.PbList<BarcodePayResponse>();
  @$core.pragma('dart2js:noInline')
  static BarcodePayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BarcodePayResponse>(create);
  static BarcodePayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get merchantName => $_getSZ(2);
  @$pb.TagNumber(3)
  set merchantName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMerchantName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMerchantName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// ===== SCAN TO PAY (AI) =====
/// NOTE: user_id extracted from JWT token, not from request
class ScanToPayRequest extends $pb.GeneratedMessage {
  factory ScanToPayRequest({
    $core.String? accountId,
    $core.List<$core.int>? imageData,
    $core.double? amount,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (imageData != null) result.imageData = imageData;
    if (amount != null) result.amount = amount;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  ScanToPayRequest._();

  factory ScanToPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScanToPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScanToPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'imageData', $pb.PbFieldType.OY)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScanToPayRequest clone() => ScanToPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScanToPayRequest copyWith(void Function(ScanToPayRequest) updates) =>
      super.copyWith((message) => updates(message as ScanToPayRequest))
          as ScanToPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScanToPayRequest create() => ScanToPayRequest._();
  @$core.override
  ScanToPayRequest createEmptyInstance() => create();
  static $pb.PbList<ScanToPayRequest> createRepeated() =>
      $pb.PbList<ScanToPayRequest>();
  @$core.pragma('dart2js:noInline')
  static ScanToPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScanToPayRequest>(create);
  static ScanToPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get imageData => $_getN(1);
  @$pb.TagNumber(2)
  set imageData($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageData() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageData() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => $_clearField(5);
}

class ScanToPayResponse extends $pb.GeneratedMessage {
  factory ScanToPayResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? merchantName,
    $core.double? extractedAmount,
    $core.String? billDetails,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (merchantName != null) result.merchantName = merchantName;
    if (extractedAmount != null) result.extractedAmount = extractedAmount;
    if (billDetails != null) result.billDetails = billDetails;
    if (message != null) result.message = message;
    return result;
  }

  ScanToPayResponse._();

  factory ScanToPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScanToPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScanToPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'merchantName')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'extractedAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'billDetails')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScanToPayResponse clone() => ScanToPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScanToPayResponse copyWith(void Function(ScanToPayResponse) updates) =>
      super.copyWith((message) => updates(message as ScanToPayResponse))
          as ScanToPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScanToPayResponse create() => ScanToPayResponse._();
  @$core.override
  ScanToPayResponse createEmptyInstance() => create();
  static $pb.PbList<ScanToPayResponse> createRepeated() =>
      $pb.PbList<ScanToPayResponse>();
  @$core.pragma('dart2js:noInline')
  static ScanToPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScanToPayResponse>(create);
  static ScanToPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get merchantName => $_getSZ(2);
  @$pb.TagNumber(3)
  set merchantName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMerchantName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMerchantName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get extractedAmount => $_getN(3);
  @$pb.TagNumber(4)
  set extractedAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExtractedAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearExtractedAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get billDetails => $_getSZ(4);
  @$pb.TagNumber(5)
  set billDetails($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBillDetails() => $_has(4);
  @$pb.TagNumber(5)
  void clearBillDetails() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

/// ===== PAYMENT HISTORY =====
/// NOTE: user_id extracted from JWT token, not from request
class GetPaymentHistoryRequest extends $pb.GeneratedMessage {
  factory GetPaymentHistoryRequest({
    $core.String? accountId,
    $core.String? paymentType,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (paymentType != null) result.paymentType = paymentType;
    if (status != null) result.status = status;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetPaymentHistoryRequest._();

  factory GetPaymentHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentType')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'startDate')
    ..aOS(5, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentHistoryRequest clone() =>
      GetPaymentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentHistoryRequest copyWith(
          void Function(GetPaymentHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetPaymentHistoryRequest))
          as GetPaymentHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryRequest create() => GetPaymentHistoryRequest._();
  @$core.override
  GetPaymentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentHistoryRequest> createRepeated() =>
      $pb.PbList<GetPaymentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentHistoryRequest>(create);
  static GetPaymentHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get startDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get endDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set endDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get limit => $_getIZ(5);
  @$pb.TagNumber(6)
  set limit($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get offset => $_getIZ(6);
  @$pb.TagNumber(7)
  set offset($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOffset() => $_has(6);
  @$pb.TagNumber(7)
  void clearOffset() => $_clearField(7);
}

/// TransactionItem represents a unified transaction that can be either a Payment or a Transfer
/// This allows the payment history endpoint to return both types in a single response
class TransactionItem extends $pb.GeneratedMessage {
  factory TransactionItem({
    $core.String? id,
    $core.String? type,
    $core.String? userId,
    $fixnum.Int64? createdAt,
    $core.String? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? description,
    $core.String? reference,
    $core.double? fee,
    $core.String? totalAmount,
    $core.String? sourceAccountId,
    $core.String? sourceAccountNumber,
    $core.String? destinationAccountId,
    $core.String? destinationAccountNumber,
    $core.String? destinationName,
    $core.String? destinationBankCode,
    $core.String? destinationBankName,
    $core.String? paymentType,
    $core.String? transferType,
    $core.String? metadata,
    $fixnum.Int64? completedAt,
    $fixnum.Int64? failedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (userId != null) result.userId = userId;
    if (createdAt != null) result.createdAt = createdAt;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (description != null) result.description = description;
    if (reference != null) result.reference = reference;
    if (fee != null) result.fee = fee;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (sourceAccountNumber != null)
      result.sourceAccountNumber = sourceAccountNumber;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (destinationAccountNumber != null)
      result.destinationAccountNumber = destinationAccountNumber;
    if (destinationName != null) result.destinationName = destinationName;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (paymentType != null) result.paymentType = paymentType;
    if (transferType != null) result.transferType = transferType;
    if (metadata != null) result.metadata = metadata;
    if (completedAt != null) result.completedAt = completedAt;
    if (failedAt != null) result.failedAt = failedAt;
    return result;
  }

  TransactionItem._();

  factory TransactionItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aInt64(4, _omitFieldNames ? '' : 'createdAt')
    ..aOS(5, _omitFieldNames ? '' : 'amount')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'totalAmount')
    ..aOS(12, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(13, _omitFieldNames ? '' : 'sourceAccountNumber')
    ..aOS(14, _omitFieldNames ? '' : 'destinationAccountId')
    ..aOS(15, _omitFieldNames ? '' : 'destinationAccountNumber')
    ..aOS(16, _omitFieldNames ? '' : 'destinationName')
    ..aOS(17, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(18, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(19, _omitFieldNames ? '' : 'paymentType')
    ..aOS(20, _omitFieldNames ? '' : 'transferType')
    ..aOS(21, _omitFieldNames ? '' : 'metadata')
    ..aInt64(22, _omitFieldNames ? '' : 'completedAt')
    ..aInt64(23, _omitFieldNames ? '' : 'failedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionItem clone() => TransactionItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionItem copyWith(void Function(TransactionItem) updates) =>
      super.copyWith((message) => updates(message as TransactionItem))
          as TransactionItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionItem create() => TransactionItem._();
  @$core.override
  TransactionItem createEmptyInstance() => create();
  static $pb.PbList<TransactionItem> createRepeated() =>
      $pb.PbList<TransactionItem>();
  @$core.pragma('dart2js:noInline')
  static TransactionItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionItem>(create);
  static TransactionItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get createdAt => $_getI64(3);
  @$pb.TagNumber(4)
  set createdAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get amount => $_getSZ(4);
  @$pb.TagNumber(5)
  set amount($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get fee => $_getN(9);
  @$pb.TagNumber(10)
  set fee($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFee() => $_has(9);
  @$pb.TagNumber(10)
  void clearFee() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get totalAmount => $_getSZ(10);
  @$pb.TagNumber(11)
  set totalAmount($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTotalAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalAmount() => $_clearField(11);

  /// Source information (where funds came from)
  @$pb.TagNumber(12)
  $core.String get sourceAccountId => $_getSZ(11);
  @$pb.TagNumber(12)
  set sourceAccountId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSourceAccountId() => $_has(11);
  @$pb.TagNumber(12)
  void clearSourceAccountId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get sourceAccountNumber => $_getSZ(12);
  @$pb.TagNumber(13)
  set sourceAccountNumber($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSourceAccountNumber() => $_has(12);
  @$pb.TagNumber(13)
  void clearSourceAccountNumber() => $_clearField(13);

  /// Destination information (where funds went to)
  @$pb.TagNumber(14)
  $core.String get destinationAccountId => $_getSZ(13);
  @$pb.TagNumber(14)
  set destinationAccountId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDestinationAccountId() => $_has(13);
  @$pb.TagNumber(14)
  void clearDestinationAccountId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get destinationAccountNumber => $_getSZ(14);
  @$pb.TagNumber(15)
  set destinationAccountNumber($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasDestinationAccountNumber() => $_has(14);
  @$pb.TagNumber(15)
  void clearDestinationAccountNumber() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get destinationName => $_getSZ(15);
  @$pb.TagNumber(16)
  set destinationName($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasDestinationName() => $_has(15);
  @$pb.TagNumber(16)
  void clearDestinationName() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get destinationBankCode => $_getSZ(16);
  @$pb.TagNumber(17)
  set destinationBankCode($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasDestinationBankCode() => $_has(16);
  @$pb.TagNumber(17)
  void clearDestinationBankCode() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get destinationBankName => $_getSZ(17);
  @$pb.TagNumber(18)
  set destinationBankName($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasDestinationBankName() => $_has(17);
  @$pb.TagNumber(18)
  void clearDestinationBankName() => $_clearField(18);

  /// Metadata
  @$pb.TagNumber(19)
  $core.String get paymentType => $_getSZ(18);
  @$pb.TagNumber(19)
  set paymentType($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPaymentType() => $_has(18);
  @$pb.TagNumber(19)
  void clearPaymentType() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get transferType => $_getSZ(19);
  @$pb.TagNumber(20)
  set transferType($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasTransferType() => $_has(19);
  @$pb.TagNumber(20)
  void clearTransferType() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get metadata => $_getSZ(20);
  @$pb.TagNumber(21)
  set metadata($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasMetadata() => $_has(20);
  @$pb.TagNumber(21)
  void clearMetadata() => $_clearField(21);

  /// Timestamps
  @$pb.TagNumber(22)
  $fixnum.Int64 get completedAt => $_getI64(21);
  @$pb.TagNumber(22)
  set completedAt($fixnum.Int64 value) => $_setInt64(21, value);
  @$pb.TagNumber(22)
  $core.bool hasCompletedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearCompletedAt() => $_clearField(22);

  @$pb.TagNumber(23)
  $fixnum.Int64 get failedAt => $_getI64(22);
  @$pb.TagNumber(23)
  set failedAt($fixnum.Int64 value) => $_setInt64(22, value);
  @$pb.TagNumber(23)
  $core.bool hasFailedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearFailedAt() => $_clearField(23);
}

class GetPaymentHistoryResponse extends $pb.GeneratedMessage {
  factory GetPaymentHistoryResponse({
    $core.Iterable<TransactionItem>? transactions,
    $core.int? total,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    return result;
  }

  GetPaymentHistoryResponse._();

  factory GetPaymentHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<TransactionItem>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: TransactionItem.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentHistoryResponse clone() =>
      GetPaymentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentHistoryResponse copyWith(
          void Function(GetPaymentHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetPaymentHistoryResponse))
          as GetPaymentHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryResponse create() => GetPaymentHistoryResponse._();
  @$core.override
  GetPaymentHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentHistoryResponse> createRepeated() =>
      $pb.PbList<GetPaymentHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentHistoryResponse>(create);
  static GetPaymentHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TransactionItem> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetFrequentBanksRequest extends $pb.GeneratedMessage {
  factory GetFrequentBanksRequest({
    $core.int? limit,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    return result;
  }

  GetFrequentBanksRequest._();

  factory GetFrequentBanksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFrequentBanksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFrequentBanksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFrequentBanksRequest clone() =>
      GetFrequentBanksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFrequentBanksRequest copyWith(
          void Function(GetFrequentBanksRequest) updates) =>
      super.copyWith((message) => updates(message as GetFrequentBanksRequest))
          as GetFrequentBanksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFrequentBanksRequest create() => GetFrequentBanksRequest._();
  @$core.override
  GetFrequentBanksRequest createEmptyInstance() => create();
  static $pb.PbList<GetFrequentBanksRequest> createRepeated() =>
      $pb.PbList<GetFrequentBanksRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFrequentBanksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFrequentBanksRequest>(create);
  static GetFrequentBanksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class FrequentBank extends $pb.GeneratedMessage {
  factory FrequentBank({
    $core.String? bankCode,
    $core.String? bankName,
    $fixnum.Int64? count,
  }) {
    final result = create();
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (count != null) result.count = count;
    return result;
  }

  FrequentBank._();

  factory FrequentBank.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FrequentBank.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FrequentBank',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bankCode')
    ..aOS(2, _omitFieldNames ? '' : 'bankName')
    ..aInt64(3, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrequentBank clone() => FrequentBank()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrequentBank copyWith(void Function(FrequentBank) updates) =>
      super.copyWith((message) => updates(message as FrequentBank))
          as FrequentBank;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FrequentBank create() => FrequentBank._();
  @$core.override
  FrequentBank createEmptyInstance() => create();
  static $pb.PbList<FrequentBank> createRepeated() =>
      $pb.PbList<FrequentBank>();
  @$core.pragma('dart2js:noInline')
  static FrequentBank getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FrequentBank>(create);
  static FrequentBank? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bankCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set bankCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBankCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBankCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get count => $_getI64(2);
  @$pb.TagNumber(3)
  set count($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCount() => $_clearField(3);
}

class GetFrequentBanksResponse extends $pb.GeneratedMessage {
  factory GetFrequentBanksResponse({
    $core.Iterable<FrequentBank>? banks,
  }) {
    final result = create();
    if (banks != null) result.banks.addAll(banks);
    return result;
  }

  GetFrequentBanksResponse._();

  factory GetFrequentBanksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFrequentBanksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFrequentBanksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<FrequentBank>(1, _omitFieldNames ? '' : 'banks', $pb.PbFieldType.PM,
        subBuilder: FrequentBank.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFrequentBanksResponse clone() =>
      GetFrequentBanksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFrequentBanksResponse copyWith(
          void Function(GetFrequentBanksResponse) updates) =>
      super.copyWith((message) => updates(message as GetFrequentBanksResponse))
          as GetFrequentBanksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFrequentBanksResponse create() => GetFrequentBanksResponse._();
  @$core.override
  GetFrequentBanksResponse createEmptyInstance() => create();
  static $pb.PbList<GetFrequentBanksResponse> createRepeated() =>
      $pb.PbList<GetFrequentBanksResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFrequentBanksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFrequentBanksResponse>(create);
  static GetFrequentBanksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FrequentBank> get banks => $_getList(0);
}

class GetBillProvidersRequest extends $pb.GeneratedMessage {
  factory GetBillProvidersRequest({
    $core.String? type,
    $core.bool? activeOnly,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (activeOnly != null) result.activeOnly = activeOnly;
    return result;
  }

  GetBillProvidersRequest._();

  factory GetBillProvidersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBillProvidersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBillProvidersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOB(2, _omitFieldNames ? '' : 'activeOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBillProvidersRequest clone() =>
      GetBillProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBillProvidersRequest copyWith(
          void Function(GetBillProvidersRequest) updates) =>
      super.copyWith((message) => updates(message as GetBillProvidersRequest))
          as GetBillProvidersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBillProvidersRequest create() => GetBillProvidersRequest._();
  @$core.override
  GetBillProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetBillProvidersRequest> createRepeated() =>
      $pb.PbList<GetBillProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBillProvidersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBillProvidersRequest>(create);
  static GetBillProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => $_clearField(2);
}

class GetBillProvidersResponse extends $pb.GeneratedMessage {
  factory GetBillProvidersResponse({
    $core.Iterable<BillProvider>? providers,
    $core.int? total,
  }) {
    final result = create();
    if (providers != null) result.providers.addAll(providers);
    if (total != null) result.total = total;
    return result;
  }

  GetBillProvidersResponse._();

  factory GetBillProvidersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBillProvidersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBillProvidersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<BillProvider>(
        1, _omitFieldNames ? '' : 'providers', $pb.PbFieldType.PM,
        subBuilder: BillProvider.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBillProvidersResponse clone() =>
      GetBillProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBillProvidersResponse copyWith(
          void Function(GetBillProvidersResponse) updates) =>
      super.copyWith((message) => updates(message as GetBillProvidersResponse))
          as GetBillProvidersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBillProvidersResponse create() => GetBillProvidersResponse._();
  @$core.override
  GetBillProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetBillProvidersResponse> createRepeated() =>
      $pb.PbList<GetBillProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBillProvidersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBillProvidersResponse>(create);
  static GetBillProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BillProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetAirtimeProvidersRequest extends $pb.GeneratedMessage {
  factory GetAirtimeProvidersRequest({
    $core.bool? activeOnly,
  }) {
    final result = create();
    if (activeOnly != null) result.activeOnly = activeOnly;
    return result;
  }

  GetAirtimeProvidersRequest._();

  factory GetAirtimeProvidersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAirtimeProvidersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAirtimeProvidersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'activeOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAirtimeProvidersRequest clone() =>
      GetAirtimeProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAirtimeProvidersRequest copyWith(
          void Function(GetAirtimeProvidersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAirtimeProvidersRequest))
          as GetAirtimeProvidersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersRequest create() => GetAirtimeProvidersRequest._();
  @$core.override
  GetAirtimeProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeProvidersRequest> createRepeated() =>
      $pb.PbList<GetAirtimeProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAirtimeProvidersRequest>(create);
  static GetAirtimeProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => $_clearField(1);
}

class GetAirtimeProvidersResponse extends $pb.GeneratedMessage {
  factory GetAirtimeProvidersResponse({
    $core.Iterable<AirtimeProvider>? providers,
    $core.int? total,
  }) {
    final result = create();
    if (providers != null) result.providers.addAll(providers);
    if (total != null) result.total = total;
    return result;
  }

  GetAirtimeProvidersResponse._();

  factory GetAirtimeProvidersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAirtimeProvidersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAirtimeProvidersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<AirtimeProvider>(
        1, _omitFieldNames ? '' : 'providers', $pb.PbFieldType.PM,
        subBuilder: AirtimeProvider.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAirtimeProvidersResponse clone() =>
      GetAirtimeProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAirtimeProvidersResponse copyWith(
          void Function(GetAirtimeProvidersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAirtimeProvidersResponse))
          as GetAirtimeProvidersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersResponse create() =>
      GetAirtimeProvidersResponse._();
  @$core.override
  GetAirtimeProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeProvidersResponse> createRepeated() =>
      $pb.PbList<GetAirtimeProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAirtimeProvidersResponse>(create);
  static GetAirtimeProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AirtimeProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class ResolveTagRequest extends $pb.GeneratedMessage {
  factory ResolveTagRequest({
    $core.String? tag,
  }) {
    final result = create();
    if (tag != null) result.tag = tag;
    return result;
  }

  ResolveTagRequest._();

  factory ResolveTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResolveTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveTagRequest clone() => ResolveTagRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveTagRequest copyWith(void Function(ResolveTagRequest) updates) =>
      super.copyWith((message) => updates(message as ResolveTagRequest))
          as ResolveTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveTagRequest create() => ResolveTagRequest._();
  @$core.override
  ResolveTagRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveTagRequest> createRepeated() =>
      $pb.PbList<ResolveTagRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveTagRequest>(create);
  static ResolveTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tag => $_getSZ(0);
  @$pb.TagNumber(1)
  set tag($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTag() => $_has(0);
  @$pb.TagNumber(1)
  void clearTag() => $_clearField(1);
}

class ResolveTagResponse extends $pb.GeneratedMessage {
  factory ResolveTagResponse({
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? tag,
    $core.bool? isValid,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (tag != null) result.tag = tag;
    if (isValid != null) result.isValid = isValid;
    return result;
  }

  ResolveTagResponse._();

  factory ResolveTagResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResolveTagResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveTagResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'accountName')
    ..aOS(3, _omitFieldNames ? '' : 'tag')
    ..aOB(4, _omitFieldNames ? '' : 'isValid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveTagResponse clone() => ResolveTagResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveTagResponse copyWith(void Function(ResolveTagResponse) updates) =>
      super.copyWith((message) => updates(message as ResolveTagResponse))
          as ResolveTagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveTagResponse create() => ResolveTagResponse._();
  @$core.override
  ResolveTagResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveTagResponse> createRepeated() =>
      $pb.PbList<ResolveTagResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveTagResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveTagResponse>(create);
  static ResolveTagResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountName => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountName() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get tag => $_getSZ(2);
  @$pb.TagNumber(3)
  set tag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTag() => $_has(2);
  @$pb.TagNumber(3)
  void clearTag() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isValid => $_getBF(3);
  @$pb.TagNumber(4)
  set isValid($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsValid() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsValid() => $_clearField(4);
}

class BankDetails extends $pb.GeneratedMessage {
  factory BankDetails({
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? routingNumber,
    $core.String? accountType,
    $core.double? confidenceScore,
    $core.String? monoAccountId,
    $core.double? balance,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (bankName != null) result.bankName = bankName;
    if (bankCode != null) result.bankCode = bankCode;
    if (routingNumber != null) result.routingNumber = routingNumber;
    if (accountType != null) result.accountType = accountType;
    if (confidenceScore != null) result.confidenceScore = confidenceScore;
    if (monoAccountId != null) result.monoAccountId = monoAccountId;
    if (balance != null) result.balance = balance;
    return result;
  }

  BankDetails._();

  factory BankDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BankDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BankDetails',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'accountName')
    ..aOS(3, _omitFieldNames ? '' : 'bankName')
    ..aOS(4, _omitFieldNames ? '' : 'bankCode')
    ..aOS(5, _omitFieldNames ? '' : 'routingNumber')
    ..aOS(6, _omitFieldNames ? '' : 'accountType')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'confidenceScore', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'monoAccountId')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankDetails clone() => BankDetails()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankDetails copyWith(void Function(BankDetails) updates) =>
      super.copyWith((message) => updates(message as BankDetails))
          as BankDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BankDetails create() => BankDetails._();
  @$core.override
  BankDetails createEmptyInstance() => create();
  static $pb.PbList<BankDetails> createRepeated() => $pb.PbList<BankDetails>();
  @$core.pragma('dart2js:noInline')
  static BankDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BankDetails>(create);
  static BankDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountName => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountName() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankName => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get bankCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set bankCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBankCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearBankCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get routingNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set routingNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRoutingNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearRoutingNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountType => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountType() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get confidenceScore => $_getN(6);
  @$pb.TagNumber(7)
  set confidenceScore($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasConfidenceScore() => $_has(6);
  @$pb.TagNumber(7)
  void clearConfidenceScore() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get monoAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set monoAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMonoAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearMonoAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get balance => $_getN(8);
  @$pb.TagNumber(9)
  set balance($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearBalance() => $_clearField(9);
}

/// NOTE: user_id extracted from JWT token, not from request
class PayWithBankDetailsRequest extends $pb.GeneratedMessage {
  factory PayWithBankDetailsRequest({
    $core.String? fromAccountId,
    BankDetails? bankDetails,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (bankDetails != null) result.bankDetails = bankDetails;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  PayWithBankDetailsRequest._();

  factory PayWithBankDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayWithBankDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayWithBankDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOM<BankDetails>(2, _omitFieldNames ? '' : 'bankDetails',
        subBuilder: BankDetails.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithBankDetailsRequest clone() =>
      PayWithBankDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithBankDetailsRequest copyWith(
          void Function(PayWithBankDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as PayWithBankDetailsRequest))
          as PayWithBankDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayWithBankDetailsRequest create() => PayWithBankDetailsRequest._();
  @$core.override
  PayWithBankDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<PayWithBankDetailsRequest> createRepeated() =>
      $pb.PbList<PayWithBankDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static PayWithBankDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayWithBankDetailsRequest>(create);
  static PayWithBankDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  BankDetails get bankDetails => $_getN(1);
  @$pb.TagNumber(2)
  set bankDetails(BankDetails value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBankDetails() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankDetails() => $_clearField(2);
  @$pb.TagNumber(2)
  BankDetails ensureBankDetails() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  /// Transaction PIN verification
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class PayWithBankDetailsResponse extends $pb.GeneratedMessage {
  factory PayWithBankDetailsResponse({
    Payment? payment,
    $core.double? newBalance,
    $core.String? recipientName,
    $core.String? transferReference,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (newBalance != null) result.newBalance = newBalance;
    if (recipientName != null) result.recipientName = recipientName;
    if (transferReference != null) result.transferReference = transferReference;
    if (message != null) result.message = message;
    return result;
  }

  PayWithBankDetailsResponse._();

  factory PayWithBankDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayWithBankDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayWithBankDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<Payment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: Payment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..aOS(4, _omitFieldNames ? '' : 'transferReference')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithBankDetailsResponse clone() =>
      PayWithBankDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayWithBankDetailsResponse copyWith(
          void Function(PayWithBankDetailsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as PayWithBankDetailsResponse))
          as PayWithBankDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayWithBankDetailsResponse create() => PayWithBankDetailsResponse._();
  @$core.override
  PayWithBankDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<PayWithBankDetailsResponse> createRepeated() =>
      $pb.PbList<PayWithBankDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static PayWithBankDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayWithBankDetailsResponse>(create);
  static PayWithBankDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transferReference => $_getSZ(3);
  @$pb.TagNumber(4)
  set transferReference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransferReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransferReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class VerifyBankAccountRequest extends $pb.GeneratedMessage {
  factory VerifyBankAccountRequest({
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? country,
  }) {
    final result = create();
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (country != null) result.country = country;
    return result;
  }

  VerifyBankAccountRequest._();

  factory VerifyBankAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyBankAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyBankAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bankCode')
    ..aOS(2, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(3, _omitFieldNames ? '' : 'country')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountRequest clone() =>
      VerifyBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountRequest copyWith(
          void Function(VerifyBankAccountRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyBankAccountRequest))
          as VerifyBankAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountRequest create() => VerifyBankAccountRequest._();
  @$core.override
  VerifyBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBankAccountRequest> createRepeated() =>
      $pb.PbList<VerifyBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyBankAccountRequest>(create);
  static VerifyBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bankCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set bankCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBankCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBankCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => $_clearField(3);
}

class VerifyBankAccountResponse extends $pb.GeneratedMessage {
  factory VerifyBankAccountResponse({
    $core.bool? success,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? verificationStatus,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? userMessage,
    $core.String? provider,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (bankName != null) result.bankName = bankName;
    if (bankCode != null) result.bankCode = bankCode;
    if (verificationStatus != null)
      result.verificationStatus = verificationStatus;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (userMessage != null) result.userMessage = userMessage;
    if (provider != null) result.provider = provider;
    return result;
  }

  VerifyBankAccountResponse._();

  factory VerifyBankAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyBankAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyBankAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(3, _omitFieldNames ? '' : 'accountName')
    ..aOS(4, _omitFieldNames ? '' : 'bankName')
    ..aOS(5, _omitFieldNames ? '' : 'bankCode')
    ..aOS(6, _omitFieldNames ? '' : 'verificationStatus')
    ..aOS(7, _omitFieldNames ? '' : 'errorCode')
    ..aOS(8, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(9, _omitFieldNames ? '' : 'userMessage')
    ..aOS(10, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountResponse clone() =>
      VerifyBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountResponse copyWith(
          void Function(VerifyBankAccountResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyBankAccountResponse))
          as VerifyBankAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountResponse create() => VerifyBankAccountResponse._();
  @$core.override
  VerifyBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyBankAccountResponse> createRepeated() =>
      $pb.PbList<VerifyBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyBankAccountResponse>(create);
  static VerifyBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountName => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountName() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get bankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set bankName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBankName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationStatus => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationStatus($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasErrorCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get errorMessage => $_getSZ(7);
  @$pb.TagNumber(8)
  set errorMessage($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasErrorMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearErrorMessage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get userMessage => $_getSZ(8);
  @$pb.TagNumber(9)
  set userMessage($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUserMessage() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserMessage() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get provider => $_getSZ(9);
  @$pb.TagNumber(10)
  set provider($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProvider() => $_has(9);
  @$pb.TagNumber(10)
  void clearProvider() => $_clearField(10);
}

class SuggestBankAccountsRequest extends $pb.GeneratedMessage {
  factory SuggestBankAccountsRequest({
    $core.String? accountNumber,
    $core.String? country,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (country != null) result.country = country;
    return result;
  }

  SuggestBankAccountsRequest._();

  factory SuggestBankAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SuggestBankAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SuggestBankAccountsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'country')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SuggestBankAccountsRequest clone() =>
      SuggestBankAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SuggestBankAccountsRequest copyWith(
          void Function(SuggestBankAccountsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SuggestBankAccountsRequest))
          as SuggestBankAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SuggestBankAccountsRequest create() => SuggestBankAccountsRequest._();
  @$core.override
  SuggestBankAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<SuggestBankAccountsRequest> createRepeated() =>
      $pb.PbList<SuggestBankAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static SuggestBankAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SuggestBankAccountsRequest>(create);
  static SuggestBankAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => $_clearField(2);
}

class BankAccountMatch extends $pb.GeneratedMessage {
  factory BankAccountMatch({
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? accountName,
    $core.String? accountNumber,
  }) {
    final result = create();
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (accountName != null) result.accountName = accountName;
    if (accountNumber != null) result.accountNumber = accountNumber;
    return result;
  }

  BankAccountMatch._();

  factory BankAccountMatch.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BankAccountMatch.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BankAccountMatch',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bankCode')
    ..aOS(2, _omitFieldNames ? '' : 'bankName')
    ..aOS(3, _omitFieldNames ? '' : 'accountName')
    ..aOS(4, _omitFieldNames ? '' : 'accountNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankAccountMatch clone() => BankAccountMatch()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankAccountMatch copyWith(void Function(BankAccountMatch) updates) =>
      super.copyWith((message) => updates(message as BankAccountMatch))
          as BankAccountMatch;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BankAccountMatch create() => BankAccountMatch._();
  @$core.override
  BankAccountMatch createEmptyInstance() => create();
  static $pb.PbList<BankAccountMatch> createRepeated() =>
      $pb.PbList<BankAccountMatch>();
  @$core.pragma('dart2js:noInline')
  static BankAccountMatch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BankAccountMatch>(create);
  static BankAccountMatch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bankCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set bankCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBankCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBankCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountName => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountName() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);
}

class SuggestBankAccountsResponse extends $pb.GeneratedMessage {
  factory SuggestBankAccountsResponse({
    $core.bool? success,
    $core.Iterable<BankAccountMatch>? matches,
    $core.String? provider,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (matches != null) result.matches.addAll(matches);
    if (provider != null) result.provider = provider;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  SuggestBankAccountsResponse._();

  factory SuggestBankAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SuggestBankAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SuggestBankAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pc<BankAccountMatch>(
        2, _omitFieldNames ? '' : 'matches', $pb.PbFieldType.PM,
        subBuilder: BankAccountMatch.create)
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SuggestBankAccountsResponse clone() =>
      SuggestBankAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SuggestBankAccountsResponse copyWith(
          void Function(SuggestBankAccountsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SuggestBankAccountsResponse))
          as SuggestBankAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SuggestBankAccountsResponse create() =>
      SuggestBankAccountsResponse._();
  @$core.override
  SuggestBankAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<SuggestBankAccountsResponse> createRepeated() =>
      $pb.PbList<SuggestBankAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static SuggestBankAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SuggestBankAccountsResponse>(create);
  static SuggestBankAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<BankAccountMatch> get matches => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => $_clearField(4);
}

class InitiateDomesticTransferRequest extends $pb.GeneratedMessage {
  factory InitiateDomesticTransferRequest({
    $core.String? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? destinationAccount,
    $core.String? destinationBankCode,
    $core.String? destinationName,
    $core.String? narration,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final result = create();
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (destinationAccount != null)
      result.destinationAccount = destinationAccount;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationName != null) result.destinationName = destinationName;
    if (narration != null) result.narration = narration;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  InitiateDomesticTransferRequest._();

  factory InitiateDomesticTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateDomesticTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateDomesticTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceAccountId')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccount')
    ..aOS(5, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(6, _omitFieldNames ? '' : 'destinationName')
    ..aOS(7, _omitFieldNames ? '' : 'narration')
    ..aOS(8, _omitFieldNames ? '' : 'reference')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(10, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(11, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateDomesticTransferRequest clone() =>
      InitiateDomesticTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateDomesticTransferRequest copyWith(
          void Function(InitiateDomesticTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InitiateDomesticTransferRequest))
          as InitiateDomesticTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateDomesticTransferRequest create() =>
      InitiateDomesticTransferRequest._();
  @$core.override
  InitiateDomesticTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateDomesticTransferRequest> createRepeated() =>
      $pb.PbList<InitiateDomesticTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateDomesticTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateDomesticTransferRequest>(
          create);
  static InitiateDomesticTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourceAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccount => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationBankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationBankCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationBankCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get destinationName => $_getSZ(5);
  @$pb.TagNumber(6)
  set destinationName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDestinationName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get narration => $_getSZ(6);
  @$pb.TagNumber(7)
  set narration($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNarration() => $_has(6);
  @$pb.TagNumber(7)
  void clearNarration() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reference => $_getSZ(7);
  @$pb.TagNumber(8)
  set reference($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearReference() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get verificationToken => $_getSZ(9);
  @$pb.TagNumber(10)
  set verificationToken($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasVerificationToken() => $_has(9);
  @$pb.TagNumber(10)
  void clearVerificationToken() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get transactionId => $_getSZ(10);
  @$pb.TagNumber(11)
  set transactionId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTransactionId() => $_has(10);
  @$pb.TagNumber(11)
  void clearTransactionId() => $_clearField(11);
}

class InitiateInternalTransferRequest extends $pb.GeneratedMessage {
  factory InitiateInternalTransferRequest({
    $core.String? fromAccountId,
    $core.String? toAccountId,
    $core.String? toUsername,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
    RecipientInfo? recipientInfo,
  }) {
    final result = create();
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (toAccountId != null) result.toAccountId = toAccountId;
    if (toUsername != null) result.toUsername = toUsername;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    if (recipientInfo != null) result.recipientInfo = recipientInfo;
    return result;
  }

  InitiateInternalTransferRequest._();

  factory InitiateInternalTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateInternalTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateInternalTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'toAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'toUsername')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'narration')
    ..aOS(7, _omitFieldNames ? '' : 'reference')
    ..aOS(8, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(9, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(10, _omitFieldNames ? '' : 'transactionId')
    ..aOM<RecipientInfo>(11, _omitFieldNames ? '' : 'recipientInfo',
        subBuilder: RecipientInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternalTransferRequest clone() =>
      InitiateInternalTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternalTransferRequest copyWith(
          void Function(InitiateInternalTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InitiateInternalTransferRequest))
          as InitiateInternalTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateInternalTransferRequest create() =>
      InitiateInternalTransferRequest._();
  @$core.override
  InitiateInternalTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateInternalTransferRequest> createRepeated() =>
      $pb.PbList<InitiateInternalTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateInternalTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateInternalTransferRequest>(
          create);
  static InitiateInternalTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set toAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set toUsername($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearToUsername() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get narration => $_getSZ(5);
  @$pb.TagNumber(6)
  set narration($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNarration() => $_has(5);
  @$pb.TagNumber(6)
  void clearNarration() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get reference => $_getSZ(6);
  @$pb.TagNumber(7)
  set reference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get verificationToken => $_getSZ(8);
  @$pb.TagNumber(9)
  set verificationToken($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVerificationToken() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerificationToken() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => $_clearField(10);

  @$pb.TagNumber(11)
  RecipientInfo get recipientInfo => $_getN(10);
  @$pb.TagNumber(11)
  set recipientInfo(RecipientInfo value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasRecipientInfo() => $_has(10);
  @$pb.TagNumber(11)
  void clearRecipientInfo() => $_clearField(11);
  @$pb.TagNumber(11)
  RecipientInfo ensureRecipientInfo() => $_ensure(10);
}

class RecipientInfo extends $pb.GeneratedMessage {
  factory RecipientInfo({
    $core.String? name,
    $core.String? recipientType,
    $core.String? recipientSource,
    $core.String? username,
    $core.String? userId,
    $core.String? accountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (recipientType != null) result.recipientType = recipientType;
    if (recipientSource != null) result.recipientSource = recipientSource;
    if (username != null) result.username = username;
    if (userId != null) result.userId = userId;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  RecipientInfo._();

  factory RecipientInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecipientInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecipientInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'recipientType')
    ..aOS(3, _omitFieldNames ? '' : 'recipientSource')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..aOS(6, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'bankName')
    ..aOS(9, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientInfo clone() => RecipientInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientInfo copyWith(void Function(RecipientInfo) updates) =>
      super.copyWith((message) => updates(message as RecipientInfo))
          as RecipientInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecipientInfo create() => RecipientInfo._();
  @$core.override
  RecipientInfo createEmptyInstance() => create();
  static $pb.PbList<RecipientInfo> createRepeated() =>
      $pb.PbList<RecipientInfo>();
  @$core.pragma('dart2js:noInline')
  static RecipientInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecipientInfo>(create);
  static RecipientInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientType => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecipientType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientSource => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientSource($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientSource() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get phoneNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set phoneNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPhoneNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneNumber() => $_clearField(9);
}

class InitiateInternationalTransferRequest extends $pb.GeneratedMessage {
  factory InitiateInternationalTransferRequest({
    $core.String? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? sourceCurrency,
    $core.String? destinationCurrency,
    $core.String? destinationCountry,
    $core.String? recipientType,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        recipientDetails,
    $core.String? narration,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final result = create();
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (sourceCurrency != null) result.sourceCurrency = sourceCurrency;
    if (destinationCurrency != null)
      result.destinationCurrency = destinationCurrency;
    if (destinationCountry != null)
      result.destinationCountry = destinationCountry;
    if (recipientType != null) result.recipientType = recipientType;
    if (recipientDetails != null)
      result.recipientDetails.addEntries(recipientDetails);
    if (narration != null) result.narration = narration;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  InitiateInternationalTransferRequest._();

  factory InitiateInternationalTransferRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateInternationalTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateInternationalTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceAccountId')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'sourceCurrency')
    ..aOS(4, _omitFieldNames ? '' : 'destinationCurrency')
    ..aOS(5, _omitFieldNames ? '' : 'destinationCountry')
    ..aOS(6, _omitFieldNames ? '' : 'recipientType')
    ..m<$core.String, $core.String>(
        7, _omitFieldNames ? '' : 'recipientDetails',
        entryClassName:
            'InitiateInternationalTransferRequest.RecipientDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('payments'))
    ..aOS(8, _omitFieldNames ? '' : 'narration')
    ..aOS(9, _omitFieldNames ? '' : 'reference')
    ..aOS(10, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(11, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(12, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternationalTransferRequest clone() =>
      InitiateInternationalTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternationalTransferRequest copyWith(
          void Function(InitiateInternationalTransferRequest) updates) =>
      super.copyWith((message) =>
              updates(message as InitiateInternationalTransferRequest))
          as InitiateInternationalTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferRequest create() =>
      InitiateInternationalTransferRequest._();
  @$core.override
  InitiateInternationalTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateInternationalTransferRequest> createRepeated() =>
      $pb.PbList<InitiateInternationalTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InitiateInternationalTransferRequest>(create);
  static InitiateInternationalTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourceAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceCurrency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationCurrency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationCountry => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationCountry($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationCountry() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationCountry() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientType => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientType() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientType() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbMap<$core.String, $core.String> get recipientDetails => $_getMap(6);

  @$pb.TagNumber(8)
  $core.String get narration => $_getSZ(7);
  @$pb.TagNumber(8)
  set narration($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNarration() => $_has(7);
  @$pb.TagNumber(8)
  void clearNarration() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get idempotencyKey => $_getSZ(9);
  @$pb.TagNumber(10)
  set idempotencyKey($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIdempotencyKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdempotencyKey() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get verificationToken => $_getSZ(10);
  @$pb.TagNumber(11)
  set verificationToken($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasVerificationToken() => $_has(10);
  @$pb.TagNumber(11)
  void clearVerificationToken() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get transactionId => $_getSZ(11);
  @$pb.TagNumber(12)
  set transactionId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTransactionId() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransactionId() => $_clearField(12);
}

/// InitiateUserTransferRequest initiates a transfer to a LazerVault user
/// Uses userId (UUID) as the stable identifier for the recipient
class InitiateUserTransferRequest extends $pb.GeneratedMessage {
  factory InitiateUserTransferRequest({
    $core.String? recipient,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final result = create();
    if (recipient != null) result.recipient = recipient;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  InitiateUserTransferRequest._();

  factory InitiateUserTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateUserTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateUserTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipient')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'narration')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(7, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateUserTransferRequest clone() =>
      InitiateUserTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateUserTransferRequest copyWith(
          void Function(InitiateUserTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InitiateUserTransferRequest))
          as InitiateUserTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateUserTransferRequest create() =>
      InitiateUserTransferRequest._();
  @$core.override
  InitiateUserTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateUserTransferRequest> createRepeated() =>
      $pb.PbList<InitiateUserTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateUserTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateUserTransferRequest>(create);
  static InitiateUserTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipient => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipient($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get narration => $_getSZ(3);
  @$pb.TagNumber(4)
  set narration($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNarration() => $_has(3);
  @$pb.TagNumber(4)
  void clearNarration() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => $_clearField(7);
}

class InitiatePhoneTransferRequest extends $pb.GeneratedMessage {
  factory InitiatePhoneTransferRequest({
    $core.String? toPhone,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final result = create();
    if (toPhone != null) result.toPhone = toPhone;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  InitiatePhoneTransferRequest._();

  factory InitiatePhoneTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiatePhoneTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiatePhoneTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'toPhone')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'narration')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(7, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiatePhoneTransferRequest clone() =>
      InitiatePhoneTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiatePhoneTransferRequest copyWith(
          void Function(InitiatePhoneTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InitiatePhoneTransferRequest))
          as InitiatePhoneTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiatePhoneTransferRequest create() =>
      InitiatePhoneTransferRequest._();
  @$core.override
  InitiatePhoneTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiatePhoneTransferRequest> createRepeated() =>
      $pb.PbList<InitiatePhoneTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiatePhoneTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiatePhoneTransferRequest>(create);
  static InitiatePhoneTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get toPhone => $_getSZ(0);
  @$pb.TagNumber(1)
  set toPhone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearToPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get narration => $_getSZ(3);
  @$pb.TagNumber(4)
  set narration($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNarration() => $_has(3);
  @$pb.TagNumber(4)
  void clearNarration() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => $_clearField(7);
}

class InitiateTransferResponse extends $pb.GeneratedMessage {
  factory InitiateTransferResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    TransferDetail? transfer,
    $fixnum.Int64? senderNewBalance,
    $fixnum.Int64? senderAvailableBalance,
    $fixnum.Int64? recipientNewBalance,
    $fixnum.Int64? recipientAvailableBalance,
    $core.bool? balancesAvailable,
    $core.String? senderAccountId,
    $core.String? recipientAccountId,
    $core.String? recipientUserId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfer != null) result.transfer = transfer;
    if (senderNewBalance != null) result.senderNewBalance = senderNewBalance;
    if (senderAvailableBalance != null)
      result.senderAvailableBalance = senderAvailableBalance;
    if (recipientNewBalance != null)
      result.recipientNewBalance = recipientNewBalance;
    if (recipientAvailableBalance != null)
      result.recipientAvailableBalance = recipientAvailableBalance;
    if (balancesAvailable != null) result.balancesAvailable = balancesAvailable;
    if (senderAccountId != null) result.senderAccountId = senderAccountId;
    if (recipientAccountId != null)
      result.recipientAccountId = recipientAccountId;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    return result;
  }

  InitiateTransferResponse._();

  factory InitiateTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<TransferDetail>(4, _omitFieldNames ? '' : 'transfer',
        subBuilder: TransferDetail.create)
    ..aInt64(5, _omitFieldNames ? '' : 'senderNewBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'senderAvailableBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'recipientNewBalance')
    ..aInt64(8, _omitFieldNames ? '' : 'recipientAvailableBalance')
    ..aOB(9, _omitFieldNames ? '' : 'balancesAvailable')
    ..aOS(10, _omitFieldNames ? '' : 'senderAccountId')
    ..aOS(11, _omitFieldNames ? '' : 'recipientAccountId')
    ..aOS(12, _omitFieldNames ? '' : 'recipientUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateTransferResponse clone() =>
      InitiateTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateTransferResponse copyWith(
          void Function(InitiateTransferResponse) updates) =>
      super.copyWith((message) => updates(message as InitiateTransferResponse))
          as InitiateTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse create() => InitiateTransferResponse._();
  @$core.override
  InitiateTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferResponse> createRepeated() =>
      $pb.PbList<InitiateTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateTransferResponse>(create);
  static InitiateTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  TransferDetail get transfer => $_getN(3);
  @$pb.TagNumber(4)
  set transfer(TransferDetail value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTransfer() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransfer() => $_clearField(4);
  @$pb.TagNumber(4)
  TransferDetail ensureTransfer() => $_ensure(3);

  /// ---- Post-transfer balance snapshot (INTERNAL account-to-account transfers)
  /// All amounts are in MINOR units (kobo/cents), matching TransferDetail.amount
  /// and accounts-service's TransferBalanceResponse.
  ///
  /// These exist so a caller can push a live balance to the app without a second
  /// round-trip to accounts-service. They are populated by
  /// InitiateInternalTransfer and InitiateUserTransfer; EXTERNAL/provider
  /// transfer paths leave them zero, so treat zero as "no snapshot available"
  /// rather than "balance is zero" (see balances_available).
  @$pb.TagNumber(5)
  $fixnum.Int64 get senderNewBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set senderNewBalance($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSenderNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderNewBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get senderAvailableBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set senderAvailableBalance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSenderAvailableBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearSenderAvailableBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get recipientNewBalance => $_getI64(6);
  @$pb.TagNumber(7)
  set recipientNewBalance($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientNewBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientNewBalance() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get recipientAvailableBalance => $_getI64(7);
  @$pb.TagNumber(8)
  set recipientAvailableBalance($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRecipientAvailableBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipientAvailableBalance() => $_clearField(8);

  /// True when the four balance fields above carry a real snapshot. Needed
  /// because a genuinely-zero balance is indistinguishable from "not populated"
  /// on the numbers alone — an account drained to exactly 0 is a real outcome.
  @$pb.TagNumber(9)
  $core.bool get balancesAvailable => $_getBF(8);
  @$pb.TagNumber(9)
  set balancesAvailable($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBalancesAvailable() => $_has(8);
  @$pb.TagNumber(9)
  void clearBalancesAvailable() => $_clearField(9);

  /// RESOLVED LazerVault account UUIDs for the two sides of an internal
  /// transfer. The request's to_account_id may be an account ID, a user ID or a
  /// tag — callers therefore cannot derive the destination account themselves,
  /// and TransferDetail.destination_account echoes back whatever was sent in.
  /// recipient_account_id is the account the money actually landed in.
  @$pb.TagNumber(10)
  $core.String get senderAccountId => $_getSZ(9);
  @$pb.TagNumber(10)
  set senderAccountId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSenderAccountId() => $_has(9);
  @$pb.TagNumber(10)
  void clearSenderAccountId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get recipientAccountId => $_getSZ(10);
  @$pb.TagNumber(11)
  set recipientAccountId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRecipientAccountId() => $_has(10);
  @$pb.TagNumber(11)
  void clearRecipientAccountId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get recipientUserId => $_getSZ(11);
  @$pb.TagNumber(12)
  set recipientUserId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasRecipientUserId() => $_has(11);
  @$pb.TagNumber(12)
  void clearRecipientUserId() => $_clearField(12);
}

class TransferDetail extends $pb.GeneratedMessage {
  factory TransferDetail({
    $core.String? id,
    $core.String? userId,
    $core.String? type,
    $core.String? status,
    $fixnum.Int64? amount,
    $core.String? currency,
    $fixnum.Int64? fee,
    $core.String? sourceAccountId,
    $core.String? destinationAccount,
    $core.String? destinationBankCode,
    $core.String? destinationBankName,
    $core.String? destinationName,
    $core.String? destinationCountry,
    $core.String? reference,
    $core.String? providerRef,
    $core.String? provider,
    $core.String? narration,
    $core.String? failureReason,
    $core.String? createdAt,
    $core.String? completedAt,
    $core.String? scheduledAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (type != null) result.type = type;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (fee != null) result.fee = fee;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccount != null)
      result.destinationAccount = destinationAccount;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (destinationName != null) result.destinationName = destinationName;
    if (destinationCountry != null)
      result.destinationCountry = destinationCountry;
    if (reference != null) result.reference = reference;
    if (providerRef != null) result.providerRef = providerRef;
    if (provider != null) result.provider = provider;
    if (narration != null) result.narration = narration;
    if (failureReason != null) result.failureReason = failureReason;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (scheduledAt != null) result.scheduledAt = scheduledAt;
    return result;
  }

  TransferDetail._();

  factory TransferDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aInt64(7, _omitFieldNames ? '' : 'fee')
    ..aOS(8, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(9, _omitFieldNames ? '' : 'destinationAccount')
    ..aOS(10, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(11, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(12, _omitFieldNames ? '' : 'destinationName')
    ..aOS(13, _omitFieldNames ? '' : 'destinationCountry')
    ..aOS(14, _omitFieldNames ? '' : 'reference')
    ..aOS(15, _omitFieldNames ? '' : 'providerRef')
    ..aOS(16, _omitFieldNames ? '' : 'provider')
    ..aOS(17, _omitFieldNames ? '' : 'narration')
    ..aOS(18, _omitFieldNames ? '' : 'failureReason')
    ..aOS(19, _omitFieldNames ? '' : 'createdAt')
    ..aOS(20, _omitFieldNames ? '' : 'completedAt')
    ..aOS(21, _omitFieldNames ? '' : 'scheduledAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferDetail clone() => TransferDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferDetail copyWith(void Function(TransferDetail) updates) =>
      super.copyWith((message) => updates(message as TransferDetail))
          as TransferDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferDetail create() => TransferDetail._();
  @$core.override
  TransferDetail createEmptyInstance() => create();
  static $pb.PbList<TransferDetail> createRepeated() =>
      $pb.PbList<TransferDetail>();
  @$core.pragma('dart2js:noInline')
  static TransferDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferDetail>(create);
  static TransferDetail? _defaultInstance;

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
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(6);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccount => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccount($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccount() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get destinationBankCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set destinationBankCode($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDestinationBankCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearDestinationBankCode() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get destinationBankName => $_getSZ(10);
  @$pb.TagNumber(11)
  set destinationBankName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDestinationBankName() => $_has(10);
  @$pb.TagNumber(11)
  void clearDestinationBankName() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get destinationName => $_getSZ(11);
  @$pb.TagNumber(12)
  set destinationName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDestinationName() => $_has(11);
  @$pb.TagNumber(12)
  void clearDestinationName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get destinationCountry => $_getSZ(12);
  @$pb.TagNumber(13)
  set destinationCountry($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDestinationCountry() => $_has(12);
  @$pb.TagNumber(13)
  void clearDestinationCountry() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get reference => $_getSZ(13);
  @$pb.TagNumber(14)
  set reference($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearReference() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerRef => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerRef($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProviderRef() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderRef() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get provider => $_getSZ(15);
  @$pb.TagNumber(16)
  set provider($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProvider() => $_has(15);
  @$pb.TagNumber(16)
  void clearProvider() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get narration => $_getSZ(16);
  @$pb.TagNumber(17)
  set narration($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasNarration() => $_has(16);
  @$pb.TagNumber(17)
  void clearNarration() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get failureReason => $_getSZ(17);
  @$pb.TagNumber(18)
  set failureReason($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasFailureReason() => $_has(17);
  @$pb.TagNumber(18)
  void clearFailureReason() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get createdAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set createdAt($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get completedAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set completedAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCompletedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCompletedAt() => $_clearField(20);

  /// Fire time for status=="scheduled" rows (RFC3339); empty otherwise.
  @$pb.TagNumber(21)
  $core.String get scheduledAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set scheduledAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasScheduledAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearScheduledAt() => $_clearField(21);
}

class GetTransferStatusRequest extends $pb.GeneratedMessage {
  factory GetTransferStatusRequest({
    $core.String? reference,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    return result;
  }

  GetTransferStatusRequest._();

  factory GetTransferStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferStatusRequest clone() =>
      GetTransferStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferStatusRequest copyWith(
          void Function(GetTransferStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetTransferStatusRequest))
          as GetTransferStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferStatusRequest create() => GetTransferStatusRequest._();
  @$core.override
  GetTransferStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferStatusRequest> createRepeated() =>
      $pb.PbList<GetTransferStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferStatusRequest>(create);
  static GetTransferStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

class GetTransferStatusResponse extends $pb.GeneratedMessage {
  factory GetTransferStatusResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    TransferDetail? transfer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfer != null) result.transfer = transfer;
    return result;
  }

  GetTransferStatusResponse._();

  factory GetTransferStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<TransferDetail>(4, _omitFieldNames ? '' : 'transfer',
        subBuilder: TransferDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferStatusResponse clone() =>
      GetTransferStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferStatusResponse copyWith(
          void Function(GetTransferStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetTransferStatusResponse))
          as GetTransferStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferStatusResponse create() => GetTransferStatusResponse._();
  @$core.override
  GetTransferStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferStatusResponse> createRepeated() =>
      $pb.PbList<GetTransferStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferStatusResponse>(create);
  static GetTransferStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  TransferDetail get transfer => $_getN(3);
  @$pb.TagNumber(4)
  set transfer(TransferDetail value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTransfer() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransfer() => $_clearField(4);
  @$pb.TagNumber(4)
  TransferDetail ensureTransfer() => $_ensure(3);
}

class CancelScheduledTransferRequest extends $pb.GeneratedMessage {
  factory CancelScheduledTransferRequest({
    $core.String? paymentId,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    return result;
  }

  CancelScheduledTransferRequest._();

  factory CancelScheduledTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelScheduledTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelScheduledTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledTransferRequest clone() =>
      CancelScheduledTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledTransferRequest copyWith(
          void Function(CancelScheduledTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CancelScheduledTransferRequest))
          as CancelScheduledTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelScheduledTransferRequest create() =>
      CancelScheduledTransferRequest._();
  @$core.override
  CancelScheduledTransferRequest createEmptyInstance() => create();
  static $pb.PbList<CancelScheduledTransferRequest> createRepeated() =>
      $pb.PbList<CancelScheduledTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelScheduledTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelScheduledTransferRequest>(create);
  static CancelScheduledTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

class CancelScheduledTransferResponse extends $pb.GeneratedMessage {
  factory CancelScheduledTransferResponse({
    $core.bool? success,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  CancelScheduledTransferResponse._();

  factory CancelScheduledTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelScheduledTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelScheduledTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledTransferResponse clone() =>
      CancelScheduledTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledTransferResponse copyWith(
          void Function(CancelScheduledTransferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CancelScheduledTransferResponse))
          as CancelScheduledTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelScheduledTransferResponse create() =>
      CancelScheduledTransferResponse._();
  @$core.override
  CancelScheduledTransferResponse createEmptyInstance() => create();
  static $pb.PbList<CancelScheduledTransferResponse> createRepeated() =>
      $pb.PbList<CancelScheduledTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelScheduledTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelScheduledTransferResponse>(
          create);
  static CancelScheduledTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => $_clearField(2);
}

class GetUserTransfersRequest extends $pb.GeneratedMessage {
  factory GetUserTransfersRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? transferType,
    $core.String? status,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (transferType != null) result.transferType = transferType;
    if (status != null) result.status = status;
    return result;
  }

  GetUserTransfersRequest._();

  factory GetUserTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'transferType')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTransfersRequest clone() =>
      GetUserTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTransfersRequest copyWith(
          void Function(GetUserTransfersRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserTransfersRequest))
          as GetUserTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTransfersRequest create() => GetUserTransfersRequest._();
  @$core.override
  GetUserTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserTransfersRequest> createRepeated() =>
      $pb.PbList<GetUserTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserTransfersRequest>(create);
  static GetUserTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transferType => $_getSZ(2);
  @$pb.TagNumber(3)
  set transferType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransferType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransferType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

class GetUserTransfersResponse extends $pb.GeneratedMessage {
  factory GetUserTransfersResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<TransferDetail>? transfers,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfers != null) result.transfers.addAll(transfers);
    if (total != null) result.total = total;
    return result;
  }

  GetUserTransfersResponse._();

  factory GetUserTransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserTransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserTransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<TransferDetail>(
        4, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM,
        subBuilder: TransferDetail.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTransfersResponse clone() =>
      GetUserTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTransfersResponse copyWith(
          void Function(GetUserTransfersResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserTransfersResponse))
          as GetUserTransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTransfersResponse create() => GetUserTransfersResponse._();
  @$core.override
  GetUserTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserTransfersResponse> createRepeated() =>
      $pb.PbList<GetUserTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserTransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserTransfersResponse>(create);
  static GetUserTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<TransferDetail> get transfers => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);
}

class GetTransferFeeRequest extends $pb.GeneratedMessage {
  factory GetTransferFeeRequest({
    $core.String? transferType,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? destinationCountry,
  }) {
    final result = create();
    if (transferType != null) result.transferType = transferType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (destinationCountry != null)
      result.destinationCountry = destinationCountry;
    return result;
  }

  GetTransferFeeRequest._();

  factory GetTransferFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transferType')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'destinationCountry')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeRequest clone() =>
      GetTransferFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeRequest copyWith(
          void Function(GetTransferFeeRequest) updates) =>
      super.copyWith((message) => updates(message as GetTransferFeeRequest))
          as GetTransferFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferFeeRequest create() => GetTransferFeeRequest._();
  @$core.override
  GetTransferFeeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferFeeRequest> createRepeated() =>
      $pb.PbList<GetTransferFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferFeeRequest>(create);
  static GetTransferFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transferType => $_getSZ(0);
  @$pb.TagNumber(1)
  set transferType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransferType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferType() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationCountry => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationCountry($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationCountry() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationCountry() => $_clearField(4);
}

class GetTransferFeeResponse extends $pb.GeneratedMessage {
  factory GetTransferFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? fee,
    $core.String? currency,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (fee != null) result.fee = fee;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetTransferFeeResponse._();

  factory GetTransferFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'fee')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeResponse clone() =>
      GetTransferFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeResponse copyWith(
          void Function(GetTransferFeeResponse) updates) =>
      super.copyWith((message) => updates(message as GetTransferFeeResponse))
          as GetTransferFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferFeeResponse create() => GetTransferFeeResponse._();
  @$core.override
  GetTransferFeeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferFeeResponse> createRepeated() =>
      $pb.PbList<GetTransferFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferFeeResponse>(create);
  static GetTransferFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fee => $_getI64(3);
  @$pb.TagNumber(4)
  set fee($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);
}

class GetDailyUsageRequest extends $pb.GeneratedMessage {
  factory GetDailyUsageRequest() => create();

  GetDailyUsageRequest._();

  factory GetDailyUsageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDailyUsageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDailyUsageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyUsageRequest clone() =>
      GetDailyUsageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyUsageRequest copyWith(void Function(GetDailyUsageRequest) updates) =>
      super.copyWith((message) => updates(message as GetDailyUsageRequest))
          as GetDailyUsageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDailyUsageRequest create() => GetDailyUsageRequest._();
  @$core.override
  GetDailyUsageRequest createEmptyInstance() => create();
  static $pb.PbList<GetDailyUsageRequest> createRepeated() =>
      $pb.PbList<GetDailyUsageRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDailyUsageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDailyUsageRequest>(create);
  static GetDailyUsageRequest? _defaultInstance;
}

class GetDailyUsageResponse extends $pb.GeneratedMessage {
  factory GetDailyUsageResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? totalTransferred,
    $core.int? transferCount,
    $fixnum.Int64? dailyLimit,
    $fixnum.Int64? remainingLimit,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (totalTransferred != null) result.totalTransferred = totalTransferred;
    if (transferCount != null) result.transferCount = transferCount;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (remainingLimit != null) result.remainingLimit = remainingLimit;
    return result;
  }

  GetDailyUsageResponse._();

  factory GetDailyUsageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDailyUsageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDailyUsageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'totalTransferred')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'transferCount', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'dailyLimit')
    ..aInt64(7, _omitFieldNames ? '' : 'remainingLimit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyUsageResponse clone() =>
      GetDailyUsageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyUsageResponse copyWith(
          void Function(GetDailyUsageResponse) updates) =>
      super.copyWith((message) => updates(message as GetDailyUsageResponse))
          as GetDailyUsageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDailyUsageResponse create() => GetDailyUsageResponse._();
  @$core.override
  GetDailyUsageResponse createEmptyInstance() => create();
  static $pb.PbList<GetDailyUsageResponse> createRepeated() =>
      $pb.PbList<GetDailyUsageResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDailyUsageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDailyUsageResponse>(create);
  static GetDailyUsageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalTransferred => $_getI64(3);
  @$pb.TagNumber(4)
  set totalTransferred($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalTransferred() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalTransferred() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transferCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transferCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransferCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransferCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get dailyLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set dailyLimit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get remainingLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set remainingLimit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRemainingLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemainingLimit() => $_clearField(7);
}

class GetExchangeRateRequest extends $pb.GeneratedMessage {
  factory GetExchangeRateRequest({
    $core.String? sourceCurrency,
    $core.String? destinationCurrency,
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (sourceCurrency != null) result.sourceCurrency = sourceCurrency;
    if (destinationCurrency != null)
      result.destinationCurrency = destinationCurrency;
    if (amount != null) result.amount = amount;
    return result;
  }

  GetExchangeRateRequest._();

  factory GetExchangeRateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'destinationCurrency')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateRequest clone() =>
      GetExchangeRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateRequest copyWith(
          void Function(GetExchangeRateRequest) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRateRequest))
          as GetExchangeRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest create() => GetExchangeRateRequest._();
  @$core.override
  GetExchangeRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateRequest> createRepeated() =>
      $pb.PbList<GetExchangeRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRateRequest>(create);
  static GetExchangeRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourceCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get destinationCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set destinationCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDestinationCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestinationCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
}

class GetExchangeRateResponse extends $pb.GeneratedMessage {
  factory GetExchangeRateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? sourceCurrency,
    $core.String? destinationCurrency,
    $core.double? rate,
    $fixnum.Int64? fee,
    $fixnum.Int64? destinationAmount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (sourceCurrency != null) result.sourceCurrency = sourceCurrency;
    if (destinationCurrency != null)
      result.destinationCurrency = destinationCurrency;
    if (rate != null) result.rate = rate;
    if (fee != null) result.fee = fee;
    if (destinationAmount != null) result.destinationAmount = destinationAmount;
    return result;
  }

  GetExchangeRateResponse._();

  factory GetExchangeRateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'sourceCurrency')
    ..aOS(5, _omitFieldNames ? '' : 'destinationCurrency')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aInt64(7, _omitFieldNames ? '' : 'fee')
    ..aInt64(8, _omitFieldNames ? '' : 'destinationAmount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateResponse clone() =>
      GetExchangeRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateResponse copyWith(
          void Function(GetExchangeRateResponse) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRateResponse))
          as GetExchangeRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateResponse create() => GetExchangeRateResponse._();
  @$core.override
  GetExchangeRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateResponse> createRepeated() =>
      $pb.PbList<GetExchangeRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRateResponse>(create);
  static GetExchangeRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceCurrency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationCurrency => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationCurrency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get rate => $_getN(5);
  @$pb.TagNumber(6)
  set rate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(6);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get destinationAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set destinationAmount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDestinationAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearDestinationAmount() => $_clearField(8);
}

class HandleTransferWebhookRequest extends $pb.GeneratedMessage {
  factory HandleTransferWebhookRequest({
    $core.String? provider,
    $core.List<$core.int>? payload,
    $core.String? signature,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  HandleTransferWebhookRequest._();

  factory HandleTransferWebhookRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HandleTransferWebhookRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HandleTransferWebhookRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HandleTransferWebhookRequest clone() =>
      HandleTransferWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HandleTransferWebhookRequest copyWith(
          void Function(HandleTransferWebhookRequest) updates) =>
      super.copyWith(
              (message) => updates(message as HandleTransferWebhookRequest))
          as HandleTransferWebhookRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HandleTransferWebhookRequest create() =>
      HandleTransferWebhookRequest._();
  @$core.override
  HandleTransferWebhookRequest createEmptyInstance() => create();
  static $pb.PbList<HandleTransferWebhookRequest> createRepeated() =>
      $pb.PbList<HandleTransferWebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static HandleTransferWebhookRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HandleTransferWebhookRequest>(create);
  static HandleTransferWebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get payload => $_getN(1);
  @$pb.TagNumber(2)
  set payload($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayload() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get signature => $_getSZ(2);
  @$pb.TagNumber(3)
  set signature($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => $_clearField(3);
}

class HandleTransferWebhookResponse extends $pb.GeneratedMessage {
  factory HandleTransferWebhookResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  HandleTransferWebhookResponse._();

  factory HandleTransferWebhookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HandleTransferWebhookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HandleTransferWebhookResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HandleTransferWebhookResponse clone() =>
      HandleTransferWebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HandleTransferWebhookResponse copyWith(
          void Function(HandleTransferWebhookResponse) updates) =>
      super.copyWith(
              (message) => updates(message as HandleTransferWebhookResponse))
          as HandleTransferWebhookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HandleTransferWebhookResponse create() =>
      HandleTransferWebhookResponse._();
  @$core.override
  HandleTransferWebhookResponse createEmptyInstance() => create();
  static $pb.PbList<HandleTransferWebhookResponse> createRepeated() =>
      $pb.PbList<HandleTransferWebhookResponse>();
  @$core.pragma('dart2js:noInline')
  static HandleTransferWebhookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HandleTransferWebhookResponse>(create);
  static HandleTransferWebhookResponse? _defaultInstance;

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

class PayPlatformFeeRequest extends $pb.GeneratedMessage {
  factory PayPlatformFeeRequest({
    $core.String? userAccountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
    $core.String? walletCode,
    $core.String? metadata,
    $core.String? serviceName,
  }) {
    final result = create();
    if (userAccountId != null) result.userAccountId = userAccountId;
    if (userId != null) result.userId = userId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    if (walletCode != null) result.walletCode = walletCode;
    if (metadata != null) result.metadata = metadata;
    if (serviceName != null) result.serviceName = serviceName;
    return result;
  }

  PayPlatformFeeRequest._();

  factory PayPlatformFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayPlatformFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayPlatformFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'reference')
    ..aOS(8, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(9, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(10, _omitFieldNames ? '' : 'transactionId')
    ..aOS(11, _omitFieldNames ? '' : 'walletCode')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..aOS(13, _omitFieldNames ? '' : 'serviceName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayPlatformFeeRequest clone() =>
      PayPlatformFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayPlatformFeeRequest copyWith(
          void Function(PayPlatformFeeRequest) updates) =>
      super.copyWith((message) => updates(message as PayPlatformFeeRequest))
          as PayPlatformFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayPlatformFeeRequest create() => PayPlatformFeeRequest._();
  @$core.override
  PayPlatformFeeRequest createEmptyInstance() => create();
  static $pb.PbList<PayPlatformFeeRequest> createRepeated() =>
      $pb.PbList<PayPlatformFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static PayPlatformFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayPlatformFeeRequest>(create);
  static PayPlatformFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get reference => $_getSZ(6);
  @$pb.TagNumber(7)
  set reference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get verificationToken => $_getSZ(8);
  @$pb.TagNumber(9)
  set verificationToken($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVerificationToken() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerificationToken() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get walletCode => $_getSZ(10);
  @$pb.TagNumber(11)
  set walletCode($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasWalletCode() => $_has(10);
  @$pb.TagNumber(11)
  void clearWalletCode() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get serviceName => $_getSZ(12);
  @$pb.TagNumber(13)
  set serviceName($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasServiceName() => $_has(12);
  @$pb.TagNumber(13)
  void clearServiceName() => $_clearField(13);
}

class PayPlatformFeeResponse extends $pb.GeneratedMessage {
  factory PayPlatformFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? debitTransactionId,
    $core.String? platformTransactionId,
    $fixnum.Int64? userNewBalance,
    $core.String? reference,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (debitTransactionId != null)
      result.debitTransactionId = debitTransactionId;
    if (platformTransactionId != null)
      result.platformTransactionId = platformTransactionId;
    if (userNewBalance != null) result.userNewBalance = userNewBalance;
    if (reference != null) result.reference = reference;
    return result;
  }

  PayPlatformFeeResponse._();

  factory PayPlatformFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayPlatformFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayPlatformFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'debitTransactionId')
    ..aOS(5, _omitFieldNames ? '' : 'platformTransactionId')
    ..aInt64(6, _omitFieldNames ? '' : 'userNewBalance')
    ..aOS(7, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayPlatformFeeResponse clone() =>
      PayPlatformFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayPlatformFeeResponse copyWith(
          void Function(PayPlatformFeeResponse) updates) =>
      super.copyWith((message) => updates(message as PayPlatformFeeResponse))
          as PayPlatformFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayPlatformFeeResponse create() => PayPlatformFeeResponse._();
  @$core.override
  PayPlatformFeeResponse createEmptyInstance() => create();
  static $pb.PbList<PayPlatformFeeResponse> createRepeated() =>
      $pb.PbList<PayPlatformFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static PayPlatformFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayPlatformFeeResponse>(create);
  static PayPlatformFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get debitTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set debitTransactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDebitTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDebitTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get platformTransactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set platformTransactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPlatformTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlatformTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get userNewBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set userNewBalance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUserNewBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserNewBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get reference => $_getSZ(6);
  @$pb.TagNumber(7)
  set reference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearReference() => $_clearField(7);
}

class RefundFromPlatformWalletRequest extends $pb.GeneratedMessage {
  factory RefundFromPlatformWalletRequest({
    $core.String? userAccountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.String? walletCode,
  }) {
    final result = create();
    if (userAccountId != null) result.userAccountId = userAccountId;
    if (userId != null) result.userId = userId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (walletCode != null) result.walletCode = walletCode;
    return result;
  }

  RefundFromPlatformWalletRequest._();

  factory RefundFromPlatformWalletRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefundFromPlatformWalletRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefundFromPlatformWalletRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'reference')
    ..aOS(8, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(9, _omitFieldNames ? '' : 'walletCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundFromPlatformWalletRequest clone() =>
      RefundFromPlatformWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundFromPlatformWalletRequest copyWith(
          void Function(RefundFromPlatformWalletRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RefundFromPlatformWalletRequest))
          as RefundFromPlatformWalletRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefundFromPlatformWalletRequest create() =>
      RefundFromPlatformWalletRequest._();
  @$core.override
  RefundFromPlatformWalletRequest createEmptyInstance() => create();
  static $pb.PbList<RefundFromPlatformWalletRequest> createRepeated() =>
      $pb.PbList<RefundFromPlatformWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static RefundFromPlatformWalletRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefundFromPlatformWalletRequest>(
          create);
  static RefundFromPlatformWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get reference => $_getSZ(6);
  @$pb.TagNumber(7)
  set reference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get walletCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set walletCode($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasWalletCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearWalletCode() => $_clearField(9);
}

class RefundFromPlatformWalletResponse extends $pb.GeneratedMessage {
  factory RefundFromPlatformWalletResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? creditTransactionId,
    $fixnum.Int64? userNewBalance,
    $core.String? reference,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (creditTransactionId != null)
      result.creditTransactionId = creditTransactionId;
    if (userNewBalance != null) result.userNewBalance = userNewBalance;
    if (reference != null) result.reference = reference;
    return result;
  }

  RefundFromPlatformWalletResponse._();

  factory RefundFromPlatformWalletResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefundFromPlatformWalletResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefundFromPlatformWalletResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'creditTransactionId')
    ..aInt64(5, _omitFieldNames ? '' : 'userNewBalance')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundFromPlatformWalletResponse clone() =>
      RefundFromPlatformWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundFromPlatformWalletResponse copyWith(
          void Function(RefundFromPlatformWalletResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RefundFromPlatformWalletResponse))
          as RefundFromPlatformWalletResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefundFromPlatformWalletResponse create() =>
      RefundFromPlatformWalletResponse._();
  @$core.override
  RefundFromPlatformWalletResponse createEmptyInstance() => create();
  static $pb.PbList<RefundFromPlatformWalletResponse> createRepeated() =>
      $pb.PbList<RefundFromPlatformWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static RefundFromPlatformWalletResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefundFromPlatformWalletResponse>(
          create);
  static RefundFromPlatformWalletResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creditTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set creditTransactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreditTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreditTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get userNewBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set userNewBalance($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserNewBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => $_clearField(6);
}

class GenerateQRTokenRequest extends $pb.GeneratedMessage {
  factory GenerateQRTokenRequest({
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? description,
    $core.int? expiryMinutes,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (expiryMinutes != null) result.expiryMinutes = expiryMinutes;
    return result;
  }

  GenerateQRTokenRequest._();

  factory GenerateQRTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateQRTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateQRTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'expiryMinutes', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateQRTokenRequest clone() =>
      GenerateQRTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateQRTokenRequest copyWith(
          void Function(GenerateQRTokenRequest) updates) =>
      super.copyWith((message) => updates(message as GenerateQRTokenRequest))
          as GenerateQRTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateQRTokenRequest create() => GenerateQRTokenRequest._();
  @$core.override
  GenerateQRTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateQRTokenRequest> createRepeated() =>
      $pb.PbList<GenerateQRTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateQRTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateQRTokenRequest>(create);
  static GenerateQRTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get expiryMinutes => $_getIZ(3);
  @$pb.TagNumber(4)
  set expiryMinutes($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiryMinutes() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiryMinutes() => $_clearField(4);
}

class GenerateQRTokenResponse extends $pb.GeneratedMessage {
  factory GenerateQRTokenResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? qrToken,
    $core.String? qrData,
    $core.String? expiresAt,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (qrToken != null) result.qrToken = qrToken;
    if (qrData != null) result.qrData = qrData;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  GenerateQRTokenResponse._();

  factory GenerateQRTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateQRTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateQRTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'qrToken')
    ..aOS(5, _omitFieldNames ? '' : 'qrData')
    ..aOS(6, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateQRTokenResponse clone() =>
      GenerateQRTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateQRTokenResponse copyWith(
          void Function(GenerateQRTokenResponse) updates) =>
      super.copyWith((message) => updates(message as GenerateQRTokenResponse))
          as GenerateQRTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateQRTokenResponse create() => GenerateQRTokenResponse._();
  @$core.override
  GenerateQRTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateQRTokenResponse> createRepeated() =>
      $pb.PbList<GenerateQRTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateQRTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateQRTokenResponse>(create);
  static GenerateQRTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get qrToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set qrToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQrToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearQrToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get qrData => $_getSZ(4);
  @$pb.TagNumber(5)
  set qrData($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQrData() => $_has(4);
  @$pb.TagNumber(5)
  void clearQrData() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get expiresAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set expiresAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpiresAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiresAt() => $_clearField(6);
}

class ValidateQRTokenRequest extends $pb.GeneratedMessage {
  factory ValidateQRTokenRequest({
    $core.String? qrToken,
  }) {
    final result = create();
    if (qrToken != null) result.qrToken = qrToken;
    return result;
  }

  ValidateQRTokenRequest._();

  factory ValidateQRTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateQRTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateQRTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'qrToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateQRTokenRequest clone() =>
      ValidateQRTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateQRTokenRequest copyWith(
          void Function(ValidateQRTokenRequest) updates) =>
      super.copyWith((message) => updates(message as ValidateQRTokenRequest))
          as ValidateQRTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateQRTokenRequest create() => ValidateQRTokenRequest._();
  @$core.override
  ValidateQRTokenRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateQRTokenRequest> createRepeated() =>
      $pb.PbList<ValidateQRTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateQRTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateQRTokenRequest>(create);
  static ValidateQRTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get qrToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set qrToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQrToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearQrToken() => $_clearField(1);
}

class ValidateQRTokenResponse extends $pb.GeneratedMessage {
  factory ValidateQRTokenResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? recipientUserId,
    $core.String? recipientUsername,
    $core.String? recipientName,
    $core.String? recipientAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.bool? isExpired,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    if (recipientUsername != null) result.recipientUsername = recipientUsername;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientAccountId != null)
      result.recipientAccountId = recipientAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (isExpired != null) result.isExpired = isExpired;
    return result;
  }

  ValidateQRTokenResponse._();

  factory ValidateQRTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateQRTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateQRTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'recipientUserId')
    ..aOS(5, _omitFieldNames ? '' : 'recipientUsername')
    ..aOS(6, _omitFieldNames ? '' : 'recipientName')
    ..aOS(7, _omitFieldNames ? '' : 'recipientAccountId')
    ..aInt64(8, _omitFieldNames ? '' : 'amount')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOB(10, _omitFieldNames ? '' : 'isExpired')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateQRTokenResponse clone() =>
      ValidateQRTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateQRTokenResponse copyWith(
          void Function(ValidateQRTokenResponse) updates) =>
      super.copyWith((message) => updates(message as ValidateQRTokenResponse))
          as ValidateQRTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateQRTokenResponse create() => ValidateQRTokenResponse._();
  @$core.override
  ValidateQRTokenResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateQRTokenResponse> createRepeated() =>
      $pb.PbList<ValidateQRTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateQRTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateQRTokenResponse>(create);
  static ValidateQRTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientUsername($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientUsername() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientName => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientName() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientAccountId() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get amount => $_getI64(7);
  @$pb.TagNumber(8)
  set amount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isExpired => $_getBF(9);
  @$pb.TagNumber(10)
  set isExpired($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsExpired() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsExpired() => $_clearField(10);
}

class GetBatchTransfersRequest extends $pb.GeneratedMessage {
  factory GetBatchTransfersRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetBatchTransfersRequest._();

  factory GetBatchTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBatchTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBatchTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransfersRequest clone() =>
      GetBatchTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransfersRequest copyWith(
          void Function(GetBatchTransfersRequest) updates) =>
      super.copyWith((message) => updates(message as GetBatchTransfersRequest))
          as GetBatchTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBatchTransfersRequest create() => GetBatchTransfersRequest._();
  @$core.override
  GetBatchTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransfersRequest> createRepeated() =>
      $pb.PbList<GetBatchTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBatchTransfersRequest>(create);
  static GetBatchTransfersRequest? _defaultInstance;

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
}

class BatchTransferSummary extends $pb.GeneratedMessage {
  factory BatchTransferSummary({
    $core.String? batchId,
    $core.int? totalRecipients,
    $core.int? successful,
    $core.int? failed,
    $core.double? totalAmount,
    $core.double? totalFees,
    $core.String? status,
    $core.String? createdAt,
    $core.String? currency,
  }) {
    final result = create();
    if (batchId != null) result.batchId = batchId;
    if (totalRecipients != null) result.totalRecipients = totalRecipients;
    if (successful != null) result.successful = successful;
    if (failed != null) result.failed = failed;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (totalFees != null) result.totalFees = totalFees;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (currency != null) result.currency = currency;
    return result;
  }

  BatchTransferSummary._();

  factory BatchTransferSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchTransferSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchTransferSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'batchId')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'totalRecipients', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'successful', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'failed', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'totalFees', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferSummary clone() =>
      BatchTransferSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchTransferSummary copyWith(void Function(BatchTransferSummary) updates) =>
      super.copyWith((message) => updates(message as BatchTransferSummary))
          as BatchTransferSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchTransferSummary create() => BatchTransferSummary._();
  @$core.override
  BatchTransferSummary createEmptyInstance() => create();
  static $pb.PbList<BatchTransferSummary> createRepeated() =>
      $pb.PbList<BatchTransferSummary>();
  @$core.pragma('dart2js:noInline')
  static BatchTransferSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchTransferSummary>(create);
  static BatchTransferSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalRecipients => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalRecipients($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalRecipients() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRecipients() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get successful => $_getIZ(2);
  @$pb.TagNumber(3)
  set successful($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccessful() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccessful() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get failed => $_getIZ(3);
  @$pb.TagNumber(4)
  set failed($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFailed() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailed() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalFees => $_getN(5);
  @$pb.TagNumber(6)
  set totalFees($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalFees() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalFees() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);
}

class GetBatchTransfersResponse extends $pb.GeneratedMessage {
  factory GetBatchTransfersResponse({
    $core.Iterable<BatchTransferSummary>? batches,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (batches != null) result.batches.addAll(batches);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetBatchTransfersResponse._();

  factory GetBatchTransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBatchTransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBatchTransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<BatchTransferSummary>(
        1, _omitFieldNames ? '' : 'batches', $pb.PbFieldType.PM,
        subBuilder: BatchTransferSummary.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransfersResponse clone() =>
      GetBatchTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransfersResponse copyWith(
          void Function(GetBatchTransfersResponse) updates) =>
      super.copyWith((message) => updates(message as GetBatchTransfersResponse))
          as GetBatchTransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBatchTransfersResponse create() => GetBatchTransfersResponse._();
  @$core.override
  GetBatchTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransfersResponse> createRepeated() =>
      $pb.PbList<GetBatchTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBatchTransfersResponse>(create);
  static GetBatchTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BatchTransferSummary> get batches => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class GetBatchTransferDetailRequest extends $pb.GeneratedMessage {
  factory GetBatchTransferDetailRequest({
    $core.String? batchId,
  }) {
    final result = create();
    if (batchId != null) result.batchId = batchId;
    return result;
  }

  GetBatchTransferDetailRequest._();

  factory GetBatchTransferDetailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBatchTransferDetailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBatchTransferDetailRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'batchId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransferDetailRequest clone() =>
      GetBatchTransferDetailRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransferDetailRequest copyWith(
          void Function(GetBatchTransferDetailRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetBatchTransferDetailRequest))
          as GetBatchTransferDetailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBatchTransferDetailRequest create() =>
      GetBatchTransferDetailRequest._();
  @$core.override
  GetBatchTransferDetailRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransferDetailRequest> createRepeated() =>
      $pb.PbList<GetBatchTransferDetailRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferDetailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBatchTransferDetailRequest>(create);
  static GetBatchTransferDetailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => $_clearField(1);
}

class GetBatchTransferDetailResponse extends $pb.GeneratedMessage {
  factory GetBatchTransferDetailResponse({
    BatchTransferSummary? summary,
    $core.Iterable<BatchTransferResultItem>? items,
    $core.String? sourceAccountNumber,
    $core.String? sourceAccountName,
  }) {
    final result = create();
    if (summary != null) result.summary = summary;
    if (items != null) result.items.addAll(items);
    if (sourceAccountNumber != null)
      result.sourceAccountNumber = sourceAccountNumber;
    if (sourceAccountName != null) result.sourceAccountName = sourceAccountName;
    return result;
  }

  GetBatchTransferDetailResponse._();

  factory GetBatchTransferDetailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBatchTransferDetailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBatchTransferDetailResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<BatchTransferSummary>(1, _omitFieldNames ? '' : 'summary',
        subBuilder: BatchTransferSummary.create)
    ..pc<BatchTransferResultItem>(
        2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: BatchTransferResultItem.create)
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountNumber')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransferDetailResponse clone() =>
      GetBatchTransferDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchTransferDetailResponse copyWith(
          void Function(GetBatchTransferDetailResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetBatchTransferDetailResponse))
          as GetBatchTransferDetailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBatchTransferDetailResponse create() =>
      GetBatchTransferDetailResponse._();
  @$core.override
  GetBatchTransferDetailResponse createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransferDetailResponse> createRepeated() =>
      $pb.PbList<GetBatchTransferDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferDetailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBatchTransferDetailResponse>(create);
  static GetBatchTransferDetailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BatchTransferSummary get summary => $_getN(0);
  @$pb.TagNumber(1)
  set summary(BatchTransferSummary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSummary() => $_has(0);
  @$pb.TagNumber(1)
  void clearSummary() => $_clearField(1);
  @$pb.TagNumber(1)
  BatchTransferSummary ensureSummary() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<BatchTransferResultItem> get items => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get sourceAccountNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountName => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountName() => $_clearField(4);
}

class VerifyMultiCountryIdentityRequest extends $pb.GeneratedMessage {
  factory VerifyMultiCountryIdentityRequest({
    $core.String? userId,
    $core.String? countryCode,
    $core.String? idType,
    $core.String? idNumber,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (countryCode != null) result.countryCode = countryCode;
    if (idType != null) result.idType = idType;
    if (idNumber != null) result.idNumber = idNumber;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  VerifyMultiCountryIdentityRequest._();

  factory VerifyMultiCountryIdentityRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyMultiCountryIdentityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyMultiCountryIdentityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'idType')
    ..aOS(4, _omitFieldNames ? '' : 'idNumber')
    ..aOS(5, _omitFieldNames ? '' : 'firstName')
    ..aOS(6, _omitFieldNames ? '' : 'lastName')
    ..aOS(7, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(8, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyMultiCountryIdentityRequest clone() =>
      VerifyMultiCountryIdentityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyMultiCountryIdentityRequest copyWith(
          void Function(VerifyMultiCountryIdentityRequest) updates) =>
      super.copyWith((message) =>
              updates(message as VerifyMultiCountryIdentityRequest))
          as VerifyMultiCountryIdentityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyMultiCountryIdentityRequest create() =>
      VerifyMultiCountryIdentityRequest._();
  @$core.override
  VerifyMultiCountryIdentityRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyMultiCountryIdentityRequest> createRepeated() =>
      $pb.PbList<VerifyMultiCountryIdentityRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyMultiCountryIdentityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyMultiCountryIdentityRequest>(
          create);
  static VerifyMultiCountryIdentityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get idType => $_getSZ(2);
  @$pb.TagNumber(3)
  set idType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIdType() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get idNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set idNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIdNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get firstName => $_getSZ(4);
  @$pb.TagNumber(5)
  set firstName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFirstName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFirstName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastName => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastName() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get phoneNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set phoneNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPhoneNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearPhoneNumber() => $_clearField(8);
}

class VerifyMultiCountryIdentityResponse extends $pb.GeneratedMessage {
  factory VerifyMultiCountryIdentityResponse({
    $core.bool? success,
    $core.bool? verified,
    $core.String? verificationId,
    $core.String? status,
    $core.String? sessionUrl,
    $core.String? sessionToken,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? provider,
    VerifiedIdentityInfo? verifiedIdentity,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (verified != null) result.verified = verified;
    if (verificationId != null) result.verificationId = verificationId;
    if (status != null) result.status = status;
    if (sessionUrl != null) result.sessionUrl = sessionUrl;
    if (sessionToken != null) result.sessionToken = sessionToken;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (provider != null) result.provider = provider;
    if (verifiedIdentity != null) result.verifiedIdentity = verifiedIdentity;
    return result;
  }

  VerifyMultiCountryIdentityResponse._();

  factory VerifyMultiCountryIdentityResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyMultiCountryIdentityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyMultiCountryIdentityResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOB(2, _omitFieldNames ? '' : 'verified')
    ..aOS(3, _omitFieldNames ? '' : 'verificationId')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'sessionUrl')
    ..aOS(6, _omitFieldNames ? '' : 'sessionToken')
    ..aOS(7, _omitFieldNames ? '' : 'errorCode')
    ..aOS(8, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(9, _omitFieldNames ? '' : 'provider')
    ..aOM<VerifiedIdentityInfo>(10, _omitFieldNames ? '' : 'verifiedIdentity',
        subBuilder: VerifiedIdentityInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyMultiCountryIdentityResponse clone() =>
      VerifyMultiCountryIdentityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyMultiCountryIdentityResponse copyWith(
          void Function(VerifyMultiCountryIdentityResponse) updates) =>
      super.copyWith((message) =>
              updates(message as VerifyMultiCountryIdentityResponse))
          as VerifyMultiCountryIdentityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyMultiCountryIdentityResponse create() =>
      VerifyMultiCountryIdentityResponse._();
  @$core.override
  VerifyMultiCountryIdentityResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyMultiCountryIdentityResponse> createRepeated() =>
      $pb.PbList<VerifyMultiCountryIdentityResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyMultiCountryIdentityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyMultiCountryIdentityResponse>(
          create);
  static VerifyMultiCountryIdentityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sessionUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set sessionUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSessionUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sessionToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set sessionToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSessionToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearSessionToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasErrorCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get errorMessage => $_getSZ(7);
  @$pb.TagNumber(8)
  set errorMessage($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasErrorMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearErrorMessage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get provider => $_getSZ(8);
  @$pb.TagNumber(9)
  set provider($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProvider() => $_has(8);
  @$pb.TagNumber(9)
  void clearProvider() => $_clearField(9);

  @$pb.TagNumber(10)
  VerifiedIdentityInfo get verifiedIdentity => $_getN(9);
  @$pb.TagNumber(10)
  set verifiedIdentity(VerifiedIdentityInfo value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasVerifiedIdentity() => $_has(9);
  @$pb.TagNumber(10)
  void clearVerifiedIdentity() => $_clearField(10);
  @$pb.TagNumber(10)
  VerifiedIdentityInfo ensureVerifiedIdentity() => $_ensure(9);
}

class VerifiedIdentityInfo extends $pb.GeneratedMessage {
  factory VerifiedIdentityInfo({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? middleName,
    $core.String? dateOfBirth,
    $core.String? gender,
    $core.String? phoneNumber,
    $core.String? photoUrl,
    $core.String? address,
  }) {
    final result = create();
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (middleName != null) result.middleName = middleName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (gender != null) result.gender = gender;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (address != null) result.address = address;
    return result;
  }

  VerifiedIdentityInfo._();

  factory VerifiedIdentityInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifiedIdentityInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifiedIdentityInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'lastName')
    ..aOS(3, _omitFieldNames ? '' : 'middleName')
    ..aOS(4, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(5, _omitFieldNames ? '' : 'gender')
    ..aOS(6, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(7, _omitFieldNames ? '' : 'photoUrl')
    ..aOS(8, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifiedIdentityInfo clone() =>
      VerifiedIdentityInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifiedIdentityInfo copyWith(void Function(VerifiedIdentityInfo) updates) =>
      super.copyWith((message) => updates(message as VerifiedIdentityInfo))
          as VerifiedIdentityInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifiedIdentityInfo create() => VerifiedIdentityInfo._();
  @$core.override
  VerifiedIdentityInfo createEmptyInstance() => create();
  static $pb.PbList<VerifiedIdentityInfo> createRepeated() =>
      $pb.PbList<VerifiedIdentityInfo>();
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentityInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifiedIdentityInfo>(create);
  static VerifiedIdentityInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get middleName => $_getSZ(2);
  @$pb.TagNumber(3)
  set middleName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMiddleName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMiddleName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get dateOfBirth => $_getSZ(3);
  @$pb.TagNumber(4)
  set dateOfBirth($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDateOfBirth() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateOfBirth() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get gender => $_getSZ(4);
  @$pb.TagNumber(5)
  set gender($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGender() => $_has(4);
  @$pb.TagNumber(5)
  void clearGender() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get photoUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set photoUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhotoUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhotoUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(8)
  set address($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearAddress() => $_clearField(8);
}

class GetKYCVerificationStatusRequest extends $pb.GeneratedMessage {
  factory GetKYCVerificationStatusRequest({
    $core.String? verificationId,
    $core.String? provider,
  }) {
    final result = create();
    if (verificationId != null) result.verificationId = verificationId;
    if (provider != null) result.provider = provider;
    return result;
  }

  GetKYCVerificationStatusRequest._();

  factory GetKYCVerificationStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetKYCVerificationStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetKYCVerificationStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'verificationId')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCVerificationStatusRequest clone() =>
      GetKYCVerificationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCVerificationStatusRequest copyWith(
          void Function(GetKYCVerificationStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetKYCVerificationStatusRequest))
          as GetKYCVerificationStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetKYCVerificationStatusRequest create() =>
      GetKYCVerificationStatusRequest._();
  @$core.override
  GetKYCVerificationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetKYCVerificationStatusRequest> createRepeated() =>
      $pb.PbList<GetKYCVerificationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetKYCVerificationStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetKYCVerificationStatusRequest>(
          create);
  static GetKYCVerificationStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get verificationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);
}

class GetKYCVerificationStatusResponse extends $pb.GeneratedMessage {
  factory GetKYCVerificationStatusResponse({
    $core.bool? success,
    $core.String? status,
    $core.bool? verified,
    $core.String? errorMessage,
    VerifiedIdentityInfo? identity,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (status != null) result.status = status;
    if (verified != null) result.verified = verified;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (identity != null) result.identity = identity;
    return result;
  }

  GetKYCVerificationStatusResponse._();

  factory GetKYCVerificationStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetKYCVerificationStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetKYCVerificationStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOB(3, _omitFieldNames ? '' : 'verified')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<VerifiedIdentityInfo>(5, _omitFieldNames ? '' : 'identity',
        subBuilder: VerifiedIdentityInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCVerificationStatusResponse clone() =>
      GetKYCVerificationStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCVerificationStatusResponse copyWith(
          void Function(GetKYCVerificationStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetKYCVerificationStatusResponse))
          as GetKYCVerificationStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetKYCVerificationStatusResponse create() =>
      GetKYCVerificationStatusResponse._();
  @$core.override
  GetKYCVerificationStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetKYCVerificationStatusResponse> createRepeated() =>
      $pb.PbList<GetKYCVerificationStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetKYCVerificationStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetKYCVerificationStatusResponse>(
          create);
  static GetKYCVerificationStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get verified => $_getBF(2);
  @$pb.TagNumber(3)
  set verified($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerified() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  VerifiedIdentityInfo get identity => $_getN(4);
  @$pb.TagNumber(5)
  set identity(VerifiedIdentityInfo value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasIdentity() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentity() => $_clearField(5);
  @$pb.TagNumber(5)
  VerifiedIdentityInfo ensureIdentity() => $_ensure(4);
}

class RecurringTransferDetail extends $pb.GeneratedMessage {
  factory RecurringTransferDetail({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? recipientAccountNumber,
    $core.String? recipientName,
    $core.String? recipientBankCode,
    $core.String? recipientBankName,
    $core.String? transferType,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    RecurringFrequency? frequency,
    $core.int? scheduleDay,
    $core.String? scheduleTime,
    RecurringTransferStatus? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.String? nextRunAt,
    $core.int? totalExecutions,
    $core.int? successfulExecutions,
    $core.int? failedExecutions,
    $core.int? consecutiveFailures,
    $core.String? lastExecutedAt,
    $core.String? lastFailureReason,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (recipientAccountNumber != null)
      result.recipientAccountNumber = recipientAccountNumber;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientBankCode != null) result.recipientBankCode = recipientBankCode;
    if (recipientBankName != null) result.recipientBankName = recipientBankName;
    if (transferType != null) result.transferType = transferType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (frequency != null) result.frequency = frequency;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (status != null) result.status = status;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (nextRunAt != null) result.nextRunAt = nextRunAt;
    if (totalExecutions != null) result.totalExecutions = totalExecutions;
    if (successfulExecutions != null)
      result.successfulExecutions = successfulExecutions;
    if (failedExecutions != null) result.failedExecutions = failedExecutions;
    if (consecutiveFailures != null)
      result.consecutiveFailures = consecutiveFailures;
    if (lastExecutedAt != null) result.lastExecutedAt = lastExecutedAt;
    if (lastFailureReason != null) result.lastFailureReason = lastFailureReason;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  RecurringTransferDetail._();

  factory RecurringTransferDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecurringTransferDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringTransferDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'recipientAccountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'recipientName')
    ..aOS(6, _omitFieldNames ? '' : 'recipientBankCode')
    ..aOS(7, _omitFieldNames ? '' : 'recipientBankName')
    ..aOS(8, _omitFieldNames ? '' : 'transferType')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..e<RecurringFrequency>(
        12, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE,
        defaultOrMaker: RecurringFrequency.RECURRING_FREQUENCY_UNSPECIFIED,
        valueOf: RecurringFrequency.valueOf,
        enumValues: RecurringFrequency.values)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..aOS(14, _omitFieldNames ? '' : 'scheduleTime')
    ..e<RecurringTransferStatus>(
        15, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            RecurringTransferStatus.RECURRING_TRANSFER_STATUS_UNSPECIFIED,
        valueOf: RecurringTransferStatus.valueOf,
        enumValues: RecurringTransferStatus.values)
    ..aOS(16, _omitFieldNames ? '' : 'startDate')
    ..aOS(17, _omitFieldNames ? '' : 'endDate')
    ..aOS(18, _omitFieldNames ? '' : 'nextRunAt')
    ..a<$core.int>(
        19, _omitFieldNames ? '' : 'totalExecutions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        20, _omitFieldNames ? '' : 'successfulExecutions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        21, _omitFieldNames ? '' : 'failedExecutions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        22, _omitFieldNames ? '' : 'consecutiveFailures', $pb.PbFieldType.O3)
    ..aOS(23, _omitFieldNames ? '' : 'lastExecutedAt')
    ..aOS(24, _omitFieldNames ? '' : 'lastFailureReason')
    ..aOS(25, _omitFieldNames ? '' : 'createdAt')
    ..aOS(26, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringTransferDetail clone() =>
      RecurringTransferDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringTransferDetail copyWith(
          void Function(RecurringTransferDetail) updates) =>
      super.copyWith((message) => updates(message as RecurringTransferDetail))
          as RecurringTransferDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecurringTransferDetail create() => RecurringTransferDetail._();
  @$core.override
  RecurringTransferDetail createEmptyInstance() => create();
  static $pb.PbList<RecurringTransferDetail> createRepeated() =>
      $pb.PbList<RecurringTransferDetail>();
  @$core.pragma('dart2js:noInline')
  static RecurringTransferDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecurringTransferDetail>(create);
  static RecurringTransferDetail? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientAccountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientAccountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientBankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientBankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientBankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientBankName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientBankName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get transferType => $_getSZ(7);
  @$pb.TagNumber(8)
  set transferType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTransferType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransferType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get amount => $_getN(8);
  @$pb.TagNumber(9)
  set amount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => $_clearField(11);

  @$pb.TagNumber(12)
  RecurringFrequency get frequency => $_getN(11);
  @$pb.TagNumber(12)
  set frequency(RecurringFrequency value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasFrequency() => $_has(11);
  @$pb.TagNumber(12)
  void clearFrequency() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get scheduleDay => $_getIZ(12);
  @$pb.TagNumber(13)
  set scheduleDay($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasScheduleDay() => $_has(12);
  @$pb.TagNumber(13)
  void clearScheduleDay() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get scheduleTime => $_getSZ(13);
  @$pb.TagNumber(14)
  set scheduleTime($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasScheduleTime() => $_has(13);
  @$pb.TagNumber(14)
  void clearScheduleTime() => $_clearField(14);

  @$pb.TagNumber(15)
  RecurringTransferStatus get status => $_getN(14);
  @$pb.TagNumber(15)
  set status(RecurringTransferStatus value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get startDate => $_getSZ(15);
  @$pb.TagNumber(16)
  set startDate($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasStartDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearStartDate() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get endDate => $_getSZ(16);
  @$pb.TagNumber(17)
  set endDate($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasEndDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearEndDate() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get nextRunAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set nextRunAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasNextRunAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearNextRunAt() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get totalExecutions => $_getIZ(18);
  @$pb.TagNumber(19)
  set totalExecutions($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasTotalExecutions() => $_has(18);
  @$pb.TagNumber(19)
  void clearTotalExecutions() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.int get successfulExecutions => $_getIZ(19);
  @$pb.TagNumber(20)
  set successfulExecutions($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasSuccessfulExecutions() => $_has(19);
  @$pb.TagNumber(20)
  void clearSuccessfulExecutions() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.int get failedExecutions => $_getIZ(20);
  @$pb.TagNumber(21)
  set failedExecutions($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasFailedExecutions() => $_has(20);
  @$pb.TagNumber(21)
  void clearFailedExecutions() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.int get consecutiveFailures => $_getIZ(21);
  @$pb.TagNumber(22)
  set consecutiveFailures($core.int value) => $_setSignedInt32(21, value);
  @$pb.TagNumber(22)
  $core.bool hasConsecutiveFailures() => $_has(21);
  @$pb.TagNumber(22)
  void clearConsecutiveFailures() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get lastExecutedAt => $_getSZ(22);
  @$pb.TagNumber(23)
  set lastExecutedAt($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasLastExecutedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearLastExecutedAt() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get lastFailureReason => $_getSZ(23);
  @$pb.TagNumber(24)
  set lastFailureReason($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasLastFailureReason() => $_has(23);
  @$pb.TagNumber(24)
  void clearLastFailureReason() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get createdAt => $_getSZ(24);
  @$pb.TagNumber(25)
  set createdAt($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasCreatedAt() => $_has(24);
  @$pb.TagNumber(25)
  void clearCreatedAt() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get updatedAt => $_getSZ(25);
  @$pb.TagNumber(26)
  set updatedAt($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasUpdatedAt() => $_has(25);
  @$pb.TagNumber(26)
  void clearUpdatedAt() => $_clearField(26);
}

class RecurringTransferExecutionDetail extends $pb.GeneratedMessage {
  factory RecurringTransferExecutionDetail({
    $core.String? id,
    $core.String? recurringTransferId,
    $core.String? paymentId,
    $core.String? reference,
    $core.String? status,
    $core.double? amount,
    $core.double? fee,
    $core.String? currency,
    $core.String? failureReason,
    $core.String? scheduledFor,
    $core.String? executedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (recurringTransferId != null)
      result.recurringTransferId = recurringTransferId;
    if (paymentId != null) result.paymentId = paymentId;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (currency != null) result.currency = currency;
    if (failureReason != null) result.failureReason = failureReason;
    if (scheduledFor != null) result.scheduledFor = scheduledFor;
    if (executedAt != null) result.executedAt = executedAt;
    return result;
  }

  RecurringTransferExecutionDetail._();

  factory RecurringTransferExecutionDetail.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecurringTransferExecutionDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringTransferExecutionDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'recurringTransferId')
    ..aOS(3, _omitFieldNames ? '' : 'paymentId')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'failureReason')
    ..aOS(10, _omitFieldNames ? '' : 'scheduledFor')
    ..aOS(11, _omitFieldNames ? '' : 'executedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringTransferExecutionDetail clone() =>
      RecurringTransferExecutionDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringTransferExecutionDetail copyWith(
          void Function(RecurringTransferExecutionDetail) updates) =>
      super.copyWith(
              (message) => updates(message as RecurringTransferExecutionDetail))
          as RecurringTransferExecutionDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecurringTransferExecutionDetail create() =>
      RecurringTransferExecutionDetail._();
  @$core.override
  RecurringTransferExecutionDetail createEmptyInstance() => create();
  static $pb.PbList<RecurringTransferExecutionDetail> createRepeated() =>
      $pb.PbList<RecurringTransferExecutionDetail>();
  @$core.pragma('dart2js:noInline')
  static RecurringTransferExecutionDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecurringTransferExecutionDetail>(
          create);
  static RecurringTransferExecutionDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recurringTransferId => $_getSZ(1);
  @$pb.TagNumber(2)
  set recurringTransferId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecurringTransferId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecurringTransferId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get paymentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPaymentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get fee => $_getN(6);
  @$pb.TagNumber(7)
  set fee($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get scheduledFor => $_getSZ(9);
  @$pb.TagNumber(10)
  set scheduledFor($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasScheduledFor() => $_has(9);
  @$pb.TagNumber(10)
  void clearScheduledFor() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get executedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set executedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasExecutedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearExecutedAt() => $_clearField(11);
}

class CreateRecurringTransferRequest extends $pb.GeneratedMessage {
  factory CreateRecurringTransferRequest({
    $core.String? fromAccountId,
    $core.String? toAccountNumber,
    $core.String? recipientName,
    $core.String? recipientBankCode,
    $core.String? recipientBankName,
    $core.double? amount,
    $core.String? description,
    RecurringFrequency? frequency,
    $core.int? scheduleDay,
    $core.String? scheduleTime,
    $core.String? endDate,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (toAccountNumber != null) result.toAccountNumber = toAccountNumber;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientBankCode != null) result.recipientBankCode = recipientBankCode;
    if (recipientBankName != null) result.recipientBankName = recipientBankName;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (frequency != null) result.frequency = frequency;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (endDate != null) result.endDate = endDate;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  CreateRecurringTransferRequest._();

  factory CreateRecurringTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecurringTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecurringTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'toAccountNumber')
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..aOS(4, _omitFieldNames ? '' : 'recipientBankCode')
    ..aOS(5, _omitFieldNames ? '' : 'recipientBankName')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'description')
    ..e<RecurringFrequency>(
        8, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE,
        defaultOrMaker: RecurringFrequency.RECURRING_FREQUENCY_UNSPECIFIED,
        valueOf: RecurringFrequency.valueOf,
        enumValues: RecurringFrequency.values)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'scheduleTime')
    ..aOS(11, _omitFieldNames ? '' : 'endDate')
    ..aOS(12, _omitFieldNames ? '' : 'transactionId')
    ..aOS(13, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringTransferRequest clone() =>
      CreateRecurringTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringTransferRequest copyWith(
          void Function(CreateRecurringTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateRecurringTransferRequest))
          as CreateRecurringTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecurringTransferRequest create() =>
      CreateRecurringTransferRequest._();
  @$core.override
  CreateRecurringTransferRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRecurringTransferRequest> createRepeated() =>
      $pb.PbList<CreateRecurringTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRecurringTransferRequest>(create);
  static CreateRecurringTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toAccountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set toAccountNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAccountNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientBankCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientBankCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientBankCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientBankCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientBankName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientBankName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => $_clearField(7);

  @$pb.TagNumber(8)
  RecurringFrequency get frequency => $_getN(7);
  @$pb.TagNumber(8)
  set frequency(RecurringFrequency value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get scheduleDay => $_getIZ(8);
  @$pb.TagNumber(9)
  set scheduleDay($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasScheduleDay() => $_has(8);
  @$pb.TagNumber(9)
  void clearScheduleDay() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get scheduleTime => $_getSZ(9);
  @$pb.TagNumber(10)
  set scheduleTime($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasScheduleTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearScheduleTime() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get endDate => $_getSZ(10);
  @$pb.TagNumber(11)
  set endDate($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEndDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearEndDate() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get transactionId => $_getSZ(11);
  @$pb.TagNumber(12)
  set transactionId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTransactionId() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransactionId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get verificationToken => $_getSZ(12);
  @$pb.TagNumber(13)
  set verificationToken($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasVerificationToken() => $_has(12);
  @$pb.TagNumber(13)
  void clearVerificationToken() => $_clearField(13);
}

class CreateRecurringTransferResponse extends $pb.GeneratedMessage {
  factory CreateRecurringTransferResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    RecurringTransferDetail? recurringTransfer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (recurringTransfer != null) result.recurringTransfer = recurringTransfer;
    return result;
  }

  CreateRecurringTransferResponse._();

  factory CreateRecurringTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecurringTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecurringTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<RecurringTransferDetail>(
        4, _omitFieldNames ? '' : 'recurringTransfer',
        subBuilder: RecurringTransferDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringTransferResponse clone() =>
      CreateRecurringTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringTransferResponse copyWith(
          void Function(CreateRecurringTransferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateRecurringTransferResponse))
          as CreateRecurringTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecurringTransferResponse create() =>
      CreateRecurringTransferResponse._();
  @$core.override
  CreateRecurringTransferResponse createEmptyInstance() => create();
  static $pb.PbList<CreateRecurringTransferResponse> createRepeated() =>
      $pb.PbList<CreateRecurringTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRecurringTransferResponse>(
          create);
  static CreateRecurringTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  RecurringTransferDetail get recurringTransfer => $_getN(3);
  @$pb.TagNumber(4)
  set recurringTransfer(RecurringTransferDetail value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRecurringTransfer() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecurringTransfer() => $_clearField(4);
  @$pb.TagNumber(4)
  RecurringTransferDetail ensureRecurringTransfer() => $_ensure(3);
}

class GetRecurringTransfersRequest extends $pb.GeneratedMessage {
  factory GetRecurringTransfersRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? status,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (status != null) result.status = status;
    return result;
  }

  GetRecurringTransfersRequest._();

  factory GetRecurringTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersRequest clone() =>
      GetRecurringTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersRequest copyWith(
          void Function(GetRecurringTransfersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecurringTransfersRequest))
          as GetRecurringTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersRequest create() =>
      GetRecurringTransfersRequest._();
  @$core.override
  GetRecurringTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransfersRequest> createRepeated() =>
      $pb.PbList<GetRecurringTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecurringTransfersRequest>(create);
  static GetRecurringTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class GetRecurringTransfersResponse extends $pb.GeneratedMessage {
  factory GetRecurringTransfersResponse({
    $core.Iterable<RecurringTransferDetail>? recurringTransfers,
    $core.int? total,
  }) {
    final result = create();
    if (recurringTransfers != null)
      result.recurringTransfers.addAll(recurringTransfers);
    if (total != null) result.total = total;
    return result;
  }

  GetRecurringTransfersResponse._();

  factory GetRecurringTransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<RecurringTransferDetail>(
        1, _omitFieldNames ? '' : 'recurringTransfers', $pb.PbFieldType.PM,
        subBuilder: RecurringTransferDetail.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersResponse clone() =>
      GetRecurringTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersResponse copyWith(
          void Function(GetRecurringTransfersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecurringTransfersResponse))
          as GetRecurringTransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersResponse create() =>
      GetRecurringTransfersResponse._();
  @$core.override
  GetRecurringTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransfersResponse> createRepeated() =>
      $pb.PbList<GetRecurringTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecurringTransfersResponse>(create);
  static GetRecurringTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecurringTransferDetail> get recurringTransfers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetRecurringTransferRequest extends $pb.GeneratedMessage {
  factory GetRecurringTransferRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetRecurringTransferRequest._();

  factory GetRecurringTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferRequest clone() =>
      GetRecurringTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferRequest copyWith(
          void Function(GetRecurringTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecurringTransferRequest))
          as GetRecurringTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferRequest create() =>
      GetRecurringTransferRequest._();
  @$core.override
  GetRecurringTransferRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransferRequest> createRepeated() =>
      $pb.PbList<GetRecurringTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecurringTransferRequest>(create);
  static GetRecurringTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetRecurringTransferResponse extends $pb.GeneratedMessage {
  factory GetRecurringTransferResponse({
    RecurringTransferDetail? recurringTransfer,
  }) {
    final result = create();
    if (recurringTransfer != null) result.recurringTransfer = recurringTransfer;
    return result;
  }

  GetRecurringTransferResponse._();

  factory GetRecurringTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOM<RecurringTransferDetail>(
        1, _omitFieldNames ? '' : 'recurringTransfer',
        subBuilder: RecurringTransferDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferResponse clone() =>
      GetRecurringTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferResponse copyWith(
          void Function(GetRecurringTransferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecurringTransferResponse))
          as GetRecurringTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferResponse create() =>
      GetRecurringTransferResponse._();
  @$core.override
  GetRecurringTransferResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransferResponse> createRepeated() =>
      $pb.PbList<GetRecurringTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecurringTransferResponse>(create);
  static GetRecurringTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringTransferDetail get recurringTransfer => $_getN(0);
  @$pb.TagNumber(1)
  set recurringTransfer(RecurringTransferDetail value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringTransfer() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringTransferDetail ensureRecurringTransfer() => $_ensure(0);
}

class UpdateRecurringTransferRequest extends $pb.GeneratedMessage {
  factory UpdateRecurringTransferRequest({
    $core.String? id,
    $core.String? status,
    $core.double? amount,
    $core.String? scheduleTime,
    $core.String? endDate,
    $core.String? description,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (endDate != null) result.endDate = endDate;
    if (description != null) result.description = description;
    return result;
  }

  UpdateRecurringTransferRequest._();

  factory UpdateRecurringTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRecurringTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRecurringTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'scheduleTime')
    ..aOS(5, _omitFieldNames ? '' : 'endDate')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringTransferRequest clone() =>
      UpdateRecurringTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringTransferRequest copyWith(
          void Function(UpdateRecurringTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateRecurringTransferRequest))
          as UpdateRecurringTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRecurringTransferRequest create() =>
      UpdateRecurringTransferRequest._();
  @$core.override
  UpdateRecurringTransferRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateRecurringTransferRequest> createRepeated() =>
      $pb.PbList<UpdateRecurringTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateRecurringTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRecurringTransferRequest>(create);
  static UpdateRecurringTransferRequest? _defaultInstance;

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
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get scheduleTime => $_getSZ(3);
  @$pb.TagNumber(4)
  set scheduleTime($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScheduleTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearScheduleTime() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get endDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set endDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);
}

class UpdateRecurringTransferResponse extends $pb.GeneratedMessage {
  factory UpdateRecurringTransferResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    RecurringTransferDetail? recurringTransfer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (recurringTransfer != null) result.recurringTransfer = recurringTransfer;
    return result;
  }

  UpdateRecurringTransferResponse._();

  factory UpdateRecurringTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRecurringTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRecurringTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<RecurringTransferDetail>(
        4, _omitFieldNames ? '' : 'recurringTransfer',
        subBuilder: RecurringTransferDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringTransferResponse clone() =>
      UpdateRecurringTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringTransferResponse copyWith(
          void Function(UpdateRecurringTransferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateRecurringTransferResponse))
          as UpdateRecurringTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRecurringTransferResponse create() =>
      UpdateRecurringTransferResponse._();
  @$core.override
  UpdateRecurringTransferResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateRecurringTransferResponse> createRepeated() =>
      $pb.PbList<UpdateRecurringTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateRecurringTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRecurringTransferResponse>(
          create);
  static UpdateRecurringTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  RecurringTransferDetail get recurringTransfer => $_getN(3);
  @$pb.TagNumber(4)
  set recurringTransfer(RecurringTransferDetail value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRecurringTransfer() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecurringTransfer() => $_clearField(4);
  @$pb.TagNumber(4)
  RecurringTransferDetail ensureRecurringTransfer() => $_ensure(3);
}

class DeleteRecurringTransferRequest extends $pb.GeneratedMessage {
  factory DeleteRecurringTransferRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteRecurringTransferRequest._();

  factory DeleteRecurringTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRecurringTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRecurringTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringTransferRequest clone() =>
      DeleteRecurringTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringTransferRequest copyWith(
          void Function(DeleteRecurringTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteRecurringTransferRequest))
          as DeleteRecurringTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRecurringTransferRequest create() =>
      DeleteRecurringTransferRequest._();
  @$core.override
  DeleteRecurringTransferRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRecurringTransferRequest> createRepeated() =>
      $pb.PbList<DeleteRecurringTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRecurringTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRecurringTransferRequest>(create);
  static DeleteRecurringTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class DeleteRecurringTransferResponse extends $pb.GeneratedMessage {
  factory DeleteRecurringTransferResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteRecurringTransferResponse._();

  factory DeleteRecurringTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRecurringTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRecurringTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringTransferResponse clone() =>
      DeleteRecurringTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringTransferResponse copyWith(
          void Function(DeleteRecurringTransferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteRecurringTransferResponse))
          as DeleteRecurringTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRecurringTransferResponse create() =>
      DeleteRecurringTransferResponse._();
  @$core.override
  DeleteRecurringTransferResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteRecurringTransferResponse> createRepeated() =>
      $pb.PbList<DeleteRecurringTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteRecurringTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRecurringTransferResponse>(
          create);
  static DeleteRecurringTransferResponse? _defaultInstance;

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

class GetRecurringTransferExecutionsRequest extends $pb.GeneratedMessage {
  factory GetRecurringTransferExecutionsRequest({
    $core.String? recurringTransferId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (recurringTransferId != null)
      result.recurringTransferId = recurringTransferId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetRecurringTransferExecutionsRequest._();

  factory GetRecurringTransferExecutionsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransferExecutionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransferExecutionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recurringTransferId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferExecutionsRequest clone() =>
      GetRecurringTransferExecutionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferExecutionsRequest copyWith(
          void Function(GetRecurringTransferExecutionsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetRecurringTransferExecutionsRequest))
          as GetRecurringTransferExecutionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferExecutionsRequest create() =>
      GetRecurringTransferExecutionsRequest._();
  @$core.override
  GetRecurringTransferExecutionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransferExecutionsRequest> createRepeated() =>
      $pb.PbList<GetRecurringTransferExecutionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferExecutionsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetRecurringTransferExecutionsRequest>(create);
  static GetRecurringTransferExecutionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recurringTransferId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recurringTransferId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringTransferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetRecurringTransferExecutionsResponse extends $pb.GeneratedMessage {
  factory GetRecurringTransferExecutionsResponse({
    $core.Iterable<RecurringTransferExecutionDetail>? executions,
    $core.int? total,
  }) {
    final result = create();
    if (executions != null) result.executions.addAll(executions);
    if (total != null) result.total = total;
    return result;
  }

  GetRecurringTransferExecutionsResponse._();

  factory GetRecurringTransferExecutionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransferExecutionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransferExecutionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<RecurringTransferExecutionDetail>(
        1, _omitFieldNames ? '' : 'executions', $pb.PbFieldType.PM,
        subBuilder: RecurringTransferExecutionDetail.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferExecutionsResponse clone() =>
      GetRecurringTransferExecutionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransferExecutionsResponse copyWith(
          void Function(GetRecurringTransferExecutionsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetRecurringTransferExecutionsResponse))
          as GetRecurringTransferExecutionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferExecutionsResponse create() =>
      GetRecurringTransferExecutionsResponse._();
  @$core.override
  GetRecurringTransferExecutionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransferExecutionsResponse> createRepeated() =>
      $pb.PbList<GetRecurringTransferExecutionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransferExecutionsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetRecurringTransferExecutionsResponse>(create);
  static GetRecurringTransferExecutionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecurringTransferExecutionDetail> get executions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetRecurringTransfersByRecipientRequest extends $pb.GeneratedMessage {
  factory GetRecurringTransfersByRecipientRequest({
    $core.String? recipientAccount,
  }) {
    final result = create();
    if (recipientAccount != null) result.recipientAccount = recipientAccount;
    return result;
  }

  GetRecurringTransfersByRecipientRequest._();

  factory GetRecurringTransfersByRecipientRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransfersByRecipientRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransfersByRecipientRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipientAccount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersByRecipientRequest clone() =>
      GetRecurringTransfersByRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersByRecipientRequest copyWith(
          void Function(GetRecurringTransfersByRecipientRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetRecurringTransfersByRecipientRequest))
          as GetRecurringTransfersByRecipientRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersByRecipientRequest create() =>
      GetRecurringTransfersByRecipientRequest._();
  @$core.override
  GetRecurringTransfersByRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransfersByRecipientRequest> createRepeated() =>
      $pb.PbList<GetRecurringTransfersByRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersByRecipientRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetRecurringTransfersByRecipientRequest>(create);
  static GetRecurringTransfersByRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipientAccount => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientAccount($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientAccount() => $_clearField(1);
}

class GetRecurringTransfersByRecipientResponse extends $pb.GeneratedMessage {
  factory GetRecurringTransfersByRecipientResponse({
    $core.Iterable<RecurringTransferDetail>? recurringTransfers,
  }) {
    final result = create();
    if (recurringTransfers != null)
      result.recurringTransfers.addAll(recurringTransfers);
    return result;
  }

  GetRecurringTransfersByRecipientResponse._();

  factory GetRecurringTransfersByRecipientResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringTransfersByRecipientResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringTransfersByRecipientResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<RecurringTransferDetail>(
        1, _omitFieldNames ? '' : 'recurringTransfers', $pb.PbFieldType.PM,
        subBuilder: RecurringTransferDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersByRecipientResponse clone() =>
      GetRecurringTransfersByRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringTransfersByRecipientResponse copyWith(
          void Function(GetRecurringTransfersByRecipientResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetRecurringTransfersByRecipientResponse))
          as GetRecurringTransfersByRecipientResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersByRecipientResponse create() =>
      GetRecurringTransfersByRecipientResponse._();
  @$core.override
  GetRecurringTransfersByRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecurringTransfersByRecipientResponse>
      createRepeated() =>
          $pb.PbList<GetRecurringTransfersByRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecurringTransfersByRecipientResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetRecurringTransfersByRecipientResponse>(create);
  static GetRecurringTransfersByRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecurringTransferDetail> get recurringTransfers => $_getList(0);
}

class AdminRunReconciliationRequest extends $pb.GeneratedMessage {
  factory AdminRunReconciliationRequest({
    $core.String? date,
  }) {
    final result = create();
    if (date != null) result.date = date;
    return result;
  }

  AdminRunReconciliationRequest._();

  factory AdminRunReconciliationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminRunReconciliationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminRunReconciliationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRunReconciliationRequest clone() =>
      AdminRunReconciliationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRunReconciliationRequest copyWith(
          void Function(AdminRunReconciliationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminRunReconciliationRequest))
          as AdminRunReconciliationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminRunReconciliationRequest create() =>
      AdminRunReconciliationRequest._();
  @$core.override
  AdminRunReconciliationRequest createEmptyInstance() => create();
  static $pb.PbList<AdminRunReconciliationRequest> createRepeated() =>
      $pb.PbList<AdminRunReconciliationRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminRunReconciliationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminRunReconciliationRequest>(create);
  static AdminRunReconciliationRequest? _defaultInstance;

  /// Optional: specify date to reconcile (defaults to today)
  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
}

class AdminReconciliationResult extends $pb.GeneratedMessage {
  factory AdminReconciliationResult({
    $core.String? reconciliationId,
    $core.String? date,
    $fixnum.Int64? totalLedgerBalance,
    $fixnum.Int64? pooledAccountBalance,
    $fixnum.Int64? discrepancy,
    $core.double? discrepancyPercent,
    $core.String? status,
    $core.int? expiredHoldsReleased,
    $core.int? stuckTransfersFixed,
    $core.int? stuckDepositsFixed,
    $core.Iterable<$core.String>? errors,
    $core.Iterable<$core.String>? warnings,
  }) {
    final result = create();
    if (reconciliationId != null) result.reconciliationId = reconciliationId;
    if (date != null) result.date = date;
    if (totalLedgerBalance != null)
      result.totalLedgerBalance = totalLedgerBalance;
    if (pooledAccountBalance != null)
      result.pooledAccountBalance = pooledAccountBalance;
    if (discrepancy != null) result.discrepancy = discrepancy;
    if (discrepancyPercent != null)
      result.discrepancyPercent = discrepancyPercent;
    if (status != null) result.status = status;
    if (expiredHoldsReleased != null)
      result.expiredHoldsReleased = expiredHoldsReleased;
    if (stuckTransfersFixed != null)
      result.stuckTransfersFixed = stuckTransfersFixed;
    if (stuckDepositsFixed != null)
      result.stuckDepositsFixed = stuckDepositsFixed;
    if (errors != null) result.errors.addAll(errors);
    if (warnings != null) result.warnings.addAll(warnings);
    return result;
  }

  AdminReconciliationResult._();

  factory AdminReconciliationResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminReconciliationResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminReconciliationResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reconciliationId')
    ..aOS(2, _omitFieldNames ? '' : 'date')
    ..aInt64(3, _omitFieldNames ? '' : 'totalLedgerBalance')
    ..aInt64(4, _omitFieldNames ? '' : 'pooledAccountBalance')
    ..aInt64(5, _omitFieldNames ? '' : 'discrepancy')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'discrepancyPercent', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'expiredHoldsReleased', $pb.PbFieldType.O3)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'stuckTransfersFixed', $pb.PbFieldType.O3)
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'stuckDepositsFixed', $pb.PbFieldType.O3)
    ..pPS(11, _omitFieldNames ? '' : 'errors')
    ..pPS(12, _omitFieldNames ? '' : 'warnings')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminReconciliationResult clone() =>
      AdminReconciliationResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminReconciliationResult copyWith(
          void Function(AdminReconciliationResult) updates) =>
      super.copyWith((message) => updates(message as AdminReconciliationResult))
          as AdminReconciliationResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminReconciliationResult create() => AdminReconciliationResult._();
  @$core.override
  AdminReconciliationResult createEmptyInstance() => create();
  static $pb.PbList<AdminReconciliationResult> createRepeated() =>
      $pb.PbList<AdminReconciliationResult>();
  @$core.pragma('dart2js:noInline')
  static AdminReconciliationResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminReconciliationResult>(create);
  static AdminReconciliationResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reconciliationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reconciliationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReconciliationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReconciliationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get date => $_getSZ(1);
  @$pb.TagNumber(2)
  set date($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set totalLedgerBalance($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalLedgerBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalLedgerBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get pooledAccountBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set pooledAccountBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPooledAccountBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearPooledAccountBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get discrepancy => $_getI64(4);
  @$pb.TagNumber(5)
  set discrepancy($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDiscrepancy() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscrepancy() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get discrepancyPercent => $_getN(5);
  @$pb.TagNumber(6)
  set discrepancyPercent($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDiscrepancyPercent() => $_has(5);
  @$pb.TagNumber(6)
  void clearDiscrepancyPercent() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get expiredHoldsReleased => $_getIZ(7);
  @$pb.TagNumber(8)
  set expiredHoldsReleased($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasExpiredHoldsReleased() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpiredHoldsReleased() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get stuckTransfersFixed => $_getIZ(8);
  @$pb.TagNumber(9)
  set stuckTransfersFixed($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStuckTransfersFixed() => $_has(8);
  @$pb.TagNumber(9)
  void clearStuckTransfersFixed() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get stuckDepositsFixed => $_getIZ(9);
  @$pb.TagNumber(10)
  set stuckDepositsFixed($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStuckDepositsFixed() => $_has(9);
  @$pb.TagNumber(10)
  void clearStuckDepositsFixed() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get errors => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get warnings => $_getList(11);
}

class AdminReconciliationHistoryRequest extends $pb.GeneratedMessage {
  factory AdminReconciliationHistoryRequest({
    $core.int? days,
  }) {
    final result = create();
    if (days != null) result.days = days;
    return result;
  }

  AdminReconciliationHistoryRequest._();

  factory AdminReconciliationHistoryRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminReconciliationHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminReconciliationHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminReconciliationHistoryRequest clone() =>
      AdminReconciliationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminReconciliationHistoryRequest copyWith(
          void Function(AdminReconciliationHistoryRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminReconciliationHistoryRequest))
          as AdminReconciliationHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminReconciliationHistoryRequest create() =>
      AdminReconciliationHistoryRequest._();
  @$core.override
  AdminReconciliationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<AdminReconciliationHistoryRequest> createRepeated() =>
      $pb.PbList<AdminReconciliationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminReconciliationHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminReconciliationHistoryRequest>(
          create);
  static AdminReconciliationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => $_clearField(1);
}

class AdminReconciliationHistoryResponse extends $pb.GeneratedMessage {
  factory AdminReconciliationHistoryResponse({
    $core.Iterable<AdminReconciliationResult>? results,
    $core.int? total,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    if (total != null) result.total = total;
    return result;
  }

  AdminReconciliationHistoryResponse._();

  factory AdminReconciliationHistoryResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminReconciliationHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminReconciliationHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<AdminReconciliationResult>(
        1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: AdminReconciliationResult.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminReconciliationHistoryResponse clone() =>
      AdminReconciliationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminReconciliationHistoryResponse copyWith(
          void Function(AdminReconciliationHistoryResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminReconciliationHistoryResponse))
          as AdminReconciliationHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminReconciliationHistoryResponse create() =>
      AdminReconciliationHistoryResponse._();
  @$core.override
  AdminReconciliationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<AdminReconciliationHistoryResponse> createRepeated() =>
      $pb.PbList<AdminReconciliationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminReconciliationHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminReconciliationHistoryResponse>(
          create);
  static AdminReconciliationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AdminReconciliationResult> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class AdminGetLastReconciliationRequest extends $pb.GeneratedMessage {
  factory AdminGetLastReconciliationRequest() => create();

  AdminGetLastReconciliationRequest._();

  factory AdminGetLastReconciliationRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetLastReconciliationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetLastReconciliationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetLastReconciliationRequest clone() =>
      AdminGetLastReconciliationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetLastReconciliationRequest copyWith(
          void Function(AdminGetLastReconciliationRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminGetLastReconciliationRequest))
          as AdminGetLastReconciliationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetLastReconciliationRequest create() =>
      AdminGetLastReconciliationRequest._();
  @$core.override
  AdminGetLastReconciliationRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetLastReconciliationRequest> createRepeated() =>
      $pb.PbList<AdminGetLastReconciliationRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetLastReconciliationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetLastReconciliationRequest>(
          create);
  static AdminGetLastReconciliationRequest? _defaultInstance;
}

/// Slice 10i: per-currency withdrawal-hold rollup.
class AdminGetWithdrawalHoldsSummaryRequest extends $pb.GeneratedMessage {
  factory AdminGetWithdrawalHoldsSummaryRequest() => create();

  AdminGetWithdrawalHoldsSummaryRequest._();

  factory AdminGetWithdrawalHoldsSummaryRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetWithdrawalHoldsSummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetWithdrawalHoldsSummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetWithdrawalHoldsSummaryRequest clone() =>
      AdminGetWithdrawalHoldsSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetWithdrawalHoldsSummaryRequest copyWith(
          void Function(AdminGetWithdrawalHoldsSummaryRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminGetWithdrawalHoldsSummaryRequest))
          as AdminGetWithdrawalHoldsSummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetWithdrawalHoldsSummaryRequest create() =>
      AdminGetWithdrawalHoldsSummaryRequest._();
  @$core.override
  AdminGetWithdrawalHoldsSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetWithdrawalHoldsSummaryRequest> createRepeated() =>
      $pb.PbList<AdminGetWithdrawalHoldsSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetWithdrawalHoldsSummaryRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminGetWithdrawalHoldsSummaryRequest>(create);
  static AdminGetWithdrawalHoldsSummaryRequest? _defaultInstance;
}

class AdminGetWithdrawalHoldsSummaryResponse extends $pb.GeneratedMessage {
  factory AdminGetWithdrawalHoldsSummaryResponse({
    $core.Iterable<WithdrawalHoldsByCurrency>? holds,
  }) {
    final result = create();
    if (holds != null) result.holds.addAll(holds);
    return result;
  }

  AdminGetWithdrawalHoldsSummaryResponse._();

  factory AdminGetWithdrawalHoldsSummaryResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetWithdrawalHoldsSummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetWithdrawalHoldsSummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<WithdrawalHoldsByCurrency>(
        1, _omitFieldNames ? '' : 'holds', $pb.PbFieldType.PM,
        subBuilder: WithdrawalHoldsByCurrency.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetWithdrawalHoldsSummaryResponse clone() =>
      AdminGetWithdrawalHoldsSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetWithdrawalHoldsSummaryResponse copyWith(
          void Function(AdminGetWithdrawalHoldsSummaryResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminGetWithdrawalHoldsSummaryResponse))
          as AdminGetWithdrawalHoldsSummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetWithdrawalHoldsSummaryResponse create() =>
      AdminGetWithdrawalHoldsSummaryResponse._();
  @$core.override
  AdminGetWithdrawalHoldsSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetWithdrawalHoldsSummaryResponse> createRepeated() =>
      $pb.PbList<AdminGetWithdrawalHoldsSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetWithdrawalHoldsSummaryResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminGetWithdrawalHoldsSummaryResponse>(create);
  static AdminGetWithdrawalHoldsSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<WithdrawalHoldsByCurrency> get holds => $_getList(0);
}

class WithdrawalHoldsByCurrency extends $pb.GeneratedMessage {
  factory WithdrawalHoldsByCurrency({
    $core.String? currency,
    $core.double? total,
    $core.int? holdCount,
  }) {
    final result = create();
    if (currency != null) result.currency = currency;
    if (total != null) result.total = total;
    if (holdCount != null) result.holdCount = holdCount;
    return result;
  }

  WithdrawalHoldsByCurrency._();

  factory WithdrawalHoldsByCurrency.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawalHoldsByCurrency.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawalHoldsByCurrency',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'holdCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalHoldsByCurrency clone() =>
      WithdrawalHoldsByCurrency()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalHoldsByCurrency copyWith(
          void Function(WithdrawalHoldsByCurrency) updates) =>
      super.copyWith((message) => updates(message as WithdrawalHoldsByCurrency))
          as WithdrawalHoldsByCurrency;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawalHoldsByCurrency create() => WithdrawalHoldsByCurrency._();
  @$core.override
  WithdrawalHoldsByCurrency createEmptyInstance() => create();
  static $pb.PbList<WithdrawalHoldsByCurrency> createRepeated() =>
      $pb.PbList<WithdrawalHoldsByCurrency>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalHoldsByCurrency getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawalHoldsByCurrency>(create);
  static WithdrawalHoldsByCurrency? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get total => $_getN(1);
  @$pb.TagNumber(2)
  set total($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get holdCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set holdCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHoldCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearHoldCount() => $_clearField(3);
}

class AdminAutoResolveRequest extends $pb.GeneratedMessage {
  factory AdminAutoResolveRequest({
    $core.int? staleThresholdMinutes,
    $core.bool? dryRun,
  }) {
    final result = create();
    if (staleThresholdMinutes != null)
      result.staleThresholdMinutes = staleThresholdMinutes;
    if (dryRun != null) result.dryRun = dryRun;
    return result;
  }

  AdminAutoResolveRequest._();

  factory AdminAutoResolveRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminAutoResolveRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminAutoResolveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'staleThresholdMinutes', $pb.PbFieldType.O3)
    ..aOB(2, _omitFieldNames ? '' : 'dryRun')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminAutoResolveRequest clone() =>
      AdminAutoResolveRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminAutoResolveRequest copyWith(
          void Function(AdminAutoResolveRequest) updates) =>
      super.copyWith((message) => updates(message as AdminAutoResolveRequest))
          as AdminAutoResolveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAutoResolveRequest create() => AdminAutoResolveRequest._();
  @$core.override
  AdminAutoResolveRequest createEmptyInstance() => create();
  static $pb.PbList<AdminAutoResolveRequest> createRepeated() =>
      $pb.PbList<AdminAutoResolveRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminAutoResolveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminAutoResolveRequest>(create);
  static AdminAutoResolveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get staleThresholdMinutes => $_getIZ(0);
  @$pb.TagNumber(1)
  set staleThresholdMinutes($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStaleThresholdMinutes() => $_has(0);
  @$pb.TagNumber(1)
  void clearStaleThresholdMinutes() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get dryRun => $_getBF(1);
  @$pb.TagNumber(2)
  set dryRun($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDryRun() => $_has(1);
  @$pb.TagNumber(2)
  void clearDryRun() => $_clearField(2);
}

class AdminAutoResolveResponse extends $pb.GeneratedMessage {
  factory AdminAutoResolveResponse({
    $core.int? totalStaleHolds,
    $core.int? resolvedCount,
    $core.int? skippedCount,
    $core.int? errorCount,
    $core.Iterable<AdminHoldResolution>? resolutions,
    $core.String? summary,
  }) {
    final result = create();
    if (totalStaleHolds != null) result.totalStaleHolds = totalStaleHolds;
    if (resolvedCount != null) result.resolvedCount = resolvedCount;
    if (skippedCount != null) result.skippedCount = skippedCount;
    if (errorCount != null) result.errorCount = errorCount;
    if (resolutions != null) result.resolutions.addAll(resolutions);
    if (summary != null) result.summary = summary;
    return result;
  }

  AdminAutoResolveResponse._();

  factory AdminAutoResolveResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminAutoResolveResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminAutoResolveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalStaleHolds', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'resolvedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'skippedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'errorCount', $pb.PbFieldType.O3)
    ..pc<AdminHoldResolution>(
        5, _omitFieldNames ? '' : 'resolutions', $pb.PbFieldType.PM,
        subBuilder: AdminHoldResolution.create)
    ..aOS(6, _omitFieldNames ? '' : 'summary')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminAutoResolveResponse clone() =>
      AdminAutoResolveResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminAutoResolveResponse copyWith(
          void Function(AdminAutoResolveResponse) updates) =>
      super.copyWith((message) => updates(message as AdminAutoResolveResponse))
          as AdminAutoResolveResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAutoResolveResponse create() => AdminAutoResolveResponse._();
  @$core.override
  AdminAutoResolveResponse createEmptyInstance() => create();
  static $pb.PbList<AdminAutoResolveResponse> createRepeated() =>
      $pb.PbList<AdminAutoResolveResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminAutoResolveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminAutoResolveResponse>(create);
  static AdminAutoResolveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalStaleHolds => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalStaleHolds($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalStaleHolds() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalStaleHolds() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get resolvedCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set resolvedCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolvedCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolvedCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get skippedCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set skippedCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSkippedCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearSkippedCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get errorCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set errorCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<AdminHoldResolution> get resolutions => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get summary => $_getSZ(5);
  @$pb.TagNumber(6)
  set summary($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSummary() => $_has(5);
  @$pb.TagNumber(6)
  void clearSummary() => $_clearField(6);
}

class AdminHoldResolution extends $pb.GeneratedMessage {
  factory AdminHoldResolution({
    $core.String? holdId,
    $core.String? accountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? transferReference,
    $core.String? providerStatus,
    $core.String? actionTaken,
    $core.String? reason,
    $core.String? errorMessage,
    $core.String? createdAt,
    $core.String? expiresAt,
  }) {
    final result = create();
    if (holdId != null) result.holdId = holdId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (transferReference != null) result.transferReference = transferReference;
    if (providerStatus != null) result.providerStatus = providerStatus;
    if (actionTaken != null) result.actionTaken = actionTaken;
    if (reason != null) result.reason = reason;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (createdAt != null) result.createdAt = createdAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  AdminHoldResolution._();

  factory AdminHoldResolution.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminHoldResolution.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminHoldResolution',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'holdId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'transferReference')
    ..aOS(6, _omitFieldNames ? '' : 'providerStatus')
    ..aOS(7, _omitFieldNames ? '' : 'actionTaken')
    ..aOS(8, _omitFieldNames ? '' : 'reason')
    ..aOS(9, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminHoldResolution clone() => AdminHoldResolution()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminHoldResolution copyWith(void Function(AdminHoldResolution) updates) =>
      super.copyWith((message) => updates(message as AdminHoldResolution))
          as AdminHoldResolution;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminHoldResolution create() => AdminHoldResolution._();
  @$core.override
  AdminHoldResolution createEmptyInstance() => create();
  static $pb.PbList<AdminHoldResolution> createRepeated() =>
      $pb.PbList<AdminHoldResolution>();
  @$core.pragma('dart2js:noInline')
  static AdminHoldResolution getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminHoldResolution>(create);
  static AdminHoldResolution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get holdId => $_getSZ(0);
  @$pb.TagNumber(1)
  set holdId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHoldId() => $_has(0);
  @$pb.TagNumber(1)
  void clearHoldId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get transferReference => $_getSZ(4);
  @$pb.TagNumber(5)
  set transferReference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransferReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransferReference() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerStatus => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerStatus($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get actionTaken => $_getSZ(6);
  @$pb.TagNumber(7)
  set actionTaken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasActionTaken() => $_has(6);
  @$pb.TagNumber(7)
  void clearActionTaken() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get errorMessage => $_getSZ(8);
  @$pb.TagNumber(9)
  set errorMessage($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasErrorMessage() => $_has(8);
  @$pb.TagNumber(9)
  void clearErrorMessage() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get expiresAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set expiresAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasExpiresAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearExpiresAt() => $_clearField(11);
}

class AdminCheckHoldProviderRequest extends $pb.GeneratedMessage {
  factory AdminCheckHoldProviderRequest({
    $core.String? holdReference,
  }) {
    final result = create();
    if (holdReference != null) result.holdReference = holdReference;
    return result;
  }

  AdminCheckHoldProviderRequest._();

  factory AdminCheckHoldProviderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminCheckHoldProviderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminCheckHoldProviderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'holdReference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCheckHoldProviderRequest clone() =>
      AdminCheckHoldProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCheckHoldProviderRequest copyWith(
          void Function(AdminCheckHoldProviderRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminCheckHoldProviderRequest))
          as AdminCheckHoldProviderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCheckHoldProviderRequest create() =>
      AdminCheckHoldProviderRequest._();
  @$core.override
  AdminCheckHoldProviderRequest createEmptyInstance() => create();
  static $pb.PbList<AdminCheckHoldProviderRequest> createRepeated() =>
      $pb.PbList<AdminCheckHoldProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminCheckHoldProviderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminCheckHoldProviderRequest>(create);
  static AdminCheckHoldProviderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get holdReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set holdReference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHoldReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearHoldReference() => $_clearField(1);
}

class AdminProviderStatusResponse extends $pb.GeneratedMessage {
  factory AdminProviderStatusResponse({
    $core.String? holdId,
    $core.String? transferReference,
    $core.String? holdStatus,
    $fixnum.Int64? holdAmount,
    $core.String? holdCurrency,
    $core.String? holdCreatedAt,
    $core.String? holdExpiresAt,
    $core.String? providerName,
    $core.String? providerStatus,
    $core.String? providerMessage,
    $core.String? mappedStatus,
    $core.String? transferId,
    $core.String? transferStatus,
    $core.String? accountId,
    $core.String? userId,
  }) {
    final result = create();
    if (holdId != null) result.holdId = holdId;
    if (transferReference != null) result.transferReference = transferReference;
    if (holdStatus != null) result.holdStatus = holdStatus;
    if (holdAmount != null) result.holdAmount = holdAmount;
    if (holdCurrency != null) result.holdCurrency = holdCurrency;
    if (holdCreatedAt != null) result.holdCreatedAt = holdCreatedAt;
    if (holdExpiresAt != null) result.holdExpiresAt = holdExpiresAt;
    if (providerName != null) result.providerName = providerName;
    if (providerStatus != null) result.providerStatus = providerStatus;
    if (providerMessage != null) result.providerMessage = providerMessage;
    if (mappedStatus != null) result.mappedStatus = mappedStatus;
    if (transferId != null) result.transferId = transferId;
    if (transferStatus != null) result.transferStatus = transferStatus;
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    return result;
  }

  AdminProviderStatusResponse._();

  factory AdminProviderStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminProviderStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminProviderStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'holdId')
    ..aOS(2, _omitFieldNames ? '' : 'transferReference')
    ..aOS(3, _omitFieldNames ? '' : 'holdStatus')
    ..aInt64(4, _omitFieldNames ? '' : 'holdAmount')
    ..aOS(5, _omitFieldNames ? '' : 'holdCurrency')
    ..aOS(6, _omitFieldNames ? '' : 'holdCreatedAt')
    ..aOS(7, _omitFieldNames ? '' : 'holdExpiresAt')
    ..aOS(8, _omitFieldNames ? '' : 'providerName')
    ..aOS(9, _omitFieldNames ? '' : 'providerStatus')
    ..aOS(10, _omitFieldNames ? '' : 'providerMessage')
    ..aOS(11, _omitFieldNames ? '' : 'mappedStatus')
    ..aOS(12, _omitFieldNames ? '' : 'transferId')
    ..aOS(13, _omitFieldNames ? '' : 'transferStatus')
    ..aOS(14, _omitFieldNames ? '' : 'accountId')
    ..aOS(15, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminProviderStatusResponse clone() =>
      AdminProviderStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminProviderStatusResponse copyWith(
          void Function(AdminProviderStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminProviderStatusResponse))
          as AdminProviderStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminProviderStatusResponse create() =>
      AdminProviderStatusResponse._();
  @$core.override
  AdminProviderStatusResponse createEmptyInstance() => create();
  static $pb.PbList<AdminProviderStatusResponse> createRepeated() =>
      $pb.PbList<AdminProviderStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminProviderStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminProviderStatusResponse>(create);
  static AdminProviderStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get holdId => $_getSZ(0);
  @$pb.TagNumber(1)
  set holdId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHoldId() => $_has(0);
  @$pb.TagNumber(1)
  void clearHoldId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transferReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set transferReference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransferReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransferReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get holdStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set holdStatus($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHoldStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearHoldStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get holdAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set holdAmount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHoldAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearHoldAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get holdCurrency => $_getSZ(4);
  @$pb.TagNumber(5)
  set holdCurrency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHoldCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearHoldCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get holdCreatedAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set holdCreatedAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHoldCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearHoldCreatedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get holdExpiresAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set holdExpiresAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHoldExpiresAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearHoldExpiresAt() => $_clearField(7);

  /// Provider details
  @$pb.TagNumber(8)
  $core.String get providerName => $_getSZ(7);
  @$pb.TagNumber(8)
  set providerName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProviderName() => $_has(7);
  @$pb.TagNumber(8)
  void clearProviderName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get providerStatus => $_getSZ(8);
  @$pb.TagNumber(9)
  set providerStatus($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProviderStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearProviderStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerMessage($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProviderMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderMessage() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get mappedStatus => $_getSZ(10);
  @$pb.TagNumber(11)
  set mappedStatus($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMappedStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearMappedStatus() => $_clearField(11);

  /// Transfer details
  @$pb.TagNumber(12)
  $core.String get transferId => $_getSZ(11);
  @$pb.TagNumber(12)
  set transferId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTransferId() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransferId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get transferStatus => $_getSZ(12);
  @$pb.TagNumber(13)
  set transferStatus($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTransferStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearTransferStatus() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get accountId => $_getSZ(13);
  @$pb.TagNumber(14)
  set accountId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAccountId() => $_has(13);
  @$pb.TagNumber(14)
  void clearAccountId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get userId => $_getSZ(14);
  @$pb.TagNumber(15)
  set userId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasUserId() => $_has(14);
  @$pb.TagNumber(15)
  void clearUserId() => $_clearField(15);
}

class AdminGetFailedOperationsRequest extends $pb.GeneratedMessage {
  factory AdminGetFailedOperationsRequest({
    $core.int? hours,
    $core.String? operationType,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (hours != null) result.hours = hours;
    if (operationType != null) result.operationType = operationType;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  AdminGetFailedOperationsRequest._();

  factory AdminGetFailedOperationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetFailedOperationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetFailedOperationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'operationType')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFailedOperationsRequest clone() =>
      AdminGetFailedOperationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFailedOperationsRequest copyWith(
          void Function(AdminGetFailedOperationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminGetFailedOperationsRequest))
          as AdminGetFailedOperationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetFailedOperationsRequest create() =>
      AdminGetFailedOperationsRequest._();
  @$core.override
  AdminGetFailedOperationsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetFailedOperationsRequest> createRepeated() =>
      $pb.PbList<AdminGetFailedOperationsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetFailedOperationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetFailedOperationsRequest>(
          create);
  static AdminGetFailedOperationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get hours => $_getIZ(0);
  @$pb.TagNumber(1)
  set hours($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHours() => $_has(0);
  @$pb.TagNumber(1)
  void clearHours() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get operationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set operationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOperationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperationType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class AdminGetFailedOperationsResponse extends $pb.GeneratedMessage {
  factory AdminGetFailedOperationsResponse({
    $core.Iterable<AdminFailedOperation>? operations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (operations != null) result.operations.addAll(operations);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  AdminGetFailedOperationsResponse._();

  factory AdminGetFailedOperationsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetFailedOperationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetFailedOperationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<AdminFailedOperation>(
        1, _omitFieldNames ? '' : 'operations', $pb.PbFieldType.PM,
        subBuilder: AdminFailedOperation.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFailedOperationsResponse clone() =>
      AdminGetFailedOperationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFailedOperationsResponse copyWith(
          void Function(AdminGetFailedOperationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminGetFailedOperationsResponse))
          as AdminGetFailedOperationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetFailedOperationsResponse create() =>
      AdminGetFailedOperationsResponse._();
  @$core.override
  AdminGetFailedOperationsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetFailedOperationsResponse> createRepeated() =>
      $pb.PbList<AdminGetFailedOperationsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetFailedOperationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetFailedOperationsResponse>(
          create);
  static AdminGetFailedOperationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AdminFailedOperation> get operations => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class AdminFailedOperation extends $pb.GeneratedMessage {
  factory AdminFailedOperation({
    $core.String? id,
    $core.String? type,
    $core.String? reference,
    $core.String? userId,
    $core.String? accountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? failureCode,
    $core.String? failureReason,
    $core.String? provider,
    $core.String? providerRef,
    $core.bool? hasFundHold,
    $core.String? fundHoldStatus,
    $core.bool? hasRollbackRecord,
    $core.String? rollbackStatus,
    $core.String? createdAt,
    $core.String? failedAt,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (reference != null) result.reference = reference;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (failureCode != null) result.failureCode = failureCode;
    if (failureReason != null) result.failureReason = failureReason;
    if (provider != null) result.provider = provider;
    if (providerRef != null) result.providerRef = providerRef;
    if (hasFundHold != null) result.hasFundHold = hasFundHold;
    if (fundHoldStatus != null) result.fundHoldStatus = fundHoldStatus;
    if (hasRollbackRecord != null) result.hasRollbackRecord = hasRollbackRecord;
    if (rollbackStatus != null) result.rollbackStatus = rollbackStatus;
    if (createdAt != null) result.createdAt = createdAt;
    if (failedAt != null) result.failedAt = failedAt;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  AdminFailedOperation._();

  factory AdminFailedOperation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFailedOperation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFailedOperation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..aOS(5, _omitFieldNames ? '' : 'accountId')
    ..aInt64(6, _omitFieldNames ? '' : 'amount')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'failureCode')
    ..aOS(10, _omitFieldNames ? '' : 'failureReason')
    ..aOS(11, _omitFieldNames ? '' : 'provider')
    ..aOS(12, _omitFieldNames ? '' : 'providerRef')
    ..aOB(13, _omitFieldNames ? '' : 'hasFundHold')
    ..aOS(14, _omitFieldNames ? '' : 'fundHoldStatus')
    ..aOB(15, _omitFieldNames ? '' : 'hasRollbackRecord')
    ..aOS(16, _omitFieldNames ? '' : 'rollbackStatus')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'failedAt')
    ..aOS(19, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFailedOperation clone() =>
      AdminFailedOperation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFailedOperation copyWith(void Function(AdminFailedOperation) updates) =>
      super.copyWith((message) => updates(message as AdminFailedOperation))
          as AdminFailedOperation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFailedOperation create() => AdminFailedOperation._();
  @$core.override
  AdminFailedOperation createEmptyInstance() => create();
  static $pb.PbList<AdminFailedOperation> createRepeated() =>
      $pb.PbList<AdminFailedOperation>();
  @$core.pragma('dart2js:noInline')
  static AdminFailedOperation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminFailedOperation>(create);
  static AdminFailedOperation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureCode($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFailureCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureCode() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get failureReason => $_getSZ(9);
  @$pb.TagNumber(10)
  set failureReason($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFailureReason() => $_has(9);
  @$pb.TagNumber(10)
  void clearFailureReason() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get provider => $_getSZ(10);
  @$pb.TagNumber(11)
  set provider($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProvider() => $_has(10);
  @$pb.TagNumber(11)
  void clearProvider() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerRef => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerRef($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProviderRef() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderRef() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get hasFundHold => $_getBF(12);
  @$pb.TagNumber(13)
  set hasFundHold($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasHasFundHold() => $_has(12);
  @$pb.TagNumber(13)
  void clearHasFundHold() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get fundHoldStatus => $_getSZ(13);
  @$pb.TagNumber(14)
  set fundHoldStatus($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFundHoldStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearFundHoldStatus() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get hasRollbackRecord => $_getBF(14);
  @$pb.TagNumber(15)
  set hasRollbackRecord($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasHasRollbackRecord() => $_has(14);
  @$pb.TagNumber(15)
  void clearHasRollbackRecord() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get rollbackStatus => $_getSZ(15);
  @$pb.TagNumber(16)
  set rollbackStatus($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRollbackStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearRollbackStatus() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get failedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set failedAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasFailedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearFailedAt() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get metadata => $_getSZ(18);
  @$pb.TagNumber(19)
  set metadata($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasMetadata() => $_has(18);
  @$pb.TagNumber(19)
  void clearMetadata() => $_clearField(19);
}

class ListTransfersRequest extends $pb.GeneratedMessage {
  factory ListTransfersRequest({
    $core.String? status,
    $core.String? type,
    $core.String? userId,
    $core.String? reference,
    $core.String? startDate,
    $core.String? endDate,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (type != null) result.type = type;
    if (userId != null) result.userId = userId;
    if (reference != null) result.reference = reference;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListTransfersRequest._();

  factory ListTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'startDate')
    ..aOS(6, _omitFieldNames ? '' : 'endDate')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersRequest clone() =>
      ListTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersRequest copyWith(void Function(ListTransfersRequest) updates) =>
      super.copyWith((message) => updates(message as ListTransfersRequest))
          as ListTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest create() => ListTransfersRequest._();
  @$core.override
  ListTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<ListTransfersRequest> createRepeated() =>
      $pb.PbList<ListTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTransfersRequest>(create);
  static ListTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get startDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set startDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStartDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get endDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set endDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEndDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get minAmount => $_getN(6);
  @$pb.TagNumber(7)
  set minAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxAmount => $_getN(7);
  @$pb.TagNumber(8)
  set maxAmount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get page => $_getIZ(8);
  @$pb.TagNumber(9)
  set page($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPage() => $_has(8);
  @$pb.TagNumber(9)
  void clearPage() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get limit => $_getIZ(9);
  @$pb.TagNumber(10)
  set limit($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLimit() => $_has(9);
  @$pb.TagNumber(10)
  void clearLimit() => $_clearField(10);
}

class ListTransfersResponse extends $pb.GeneratedMessage {
  factory ListTransfersResponse({
    $core.Iterable<AdminTransferDetail>? transfers,
    $core.int? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (transfers != null) result.transfers.addAll(transfers);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListTransfersResponse._();

  factory ListTransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<AdminTransferDetail>(
        1, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM,
        subBuilder: AdminTransferDetail.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersResponse clone() =>
      ListTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersResponse copyWith(
          void Function(ListTransfersResponse) updates) =>
      super.copyWith((message) => updates(message as ListTransfersResponse))
          as ListTransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse create() => ListTransfersResponse._();
  @$core.override
  ListTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<ListTransfersResponse> createRepeated() =>
      $pb.PbList<ListTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTransfersResponse>(create);
  static ListTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AdminTransferDetail> get transfers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class AdminTransferDetail extends $pb.GeneratedMessage {
  factory AdminTransferDetail({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? reference,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? type,
    $core.String? recipientAccount,
    $core.String? recipientName,
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? description,
    $core.String? feeCode,
    $core.double? feeAmount,
    $core.String? provider,
    $core.String? providerRef,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? scheduledAt,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (reference != null) result.reference = reference;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (type != null) result.type = type;
    if (recipientAccount != null) result.recipientAccount = recipientAccount;
    if (recipientName != null) result.recipientName = recipientName;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (description != null) result.description = description;
    if (feeCode != null) result.feeCode = feeCode;
    if (feeAmount != null) result.feeAmount = feeAmount;
    if (provider != null) result.provider = provider;
    if (providerRef != null) result.providerRef = providerRef;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (scheduledAt != null) result.scheduledAt = scheduledAt;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  AdminTransferDetail._();

  factory AdminTransferDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminTransferDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminTransferDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'type')
    ..aOS(9, _omitFieldNames ? '' : 'recipientAccount')
    ..aOS(10, _omitFieldNames ? '' : 'recipientName')
    ..aOS(11, _omitFieldNames ? '' : 'bankCode')
    ..aOS(12, _omitFieldNames ? '' : 'bankName')
    ..aOS(13, _omitFieldNames ? '' : 'description')
    ..aOS(14, _omitFieldNames ? '' : 'feeCode')
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'provider')
    ..aOS(17, _omitFieldNames ? '' : 'providerRef')
    ..aOS(18, _omitFieldNames ? '' : 'createdAt')
    ..aOS(19, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(20, _omitFieldNames ? '' : 'scheduledAt')
    ..aOS(21, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminTransferDetail clone() => AdminTransferDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminTransferDetail copyWith(void Function(AdminTransferDetail) updates) =>
      super.copyWith((message) => updates(message as AdminTransferDetail))
          as AdminTransferDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminTransferDetail create() => AdminTransferDetail._();
  @$core.override
  AdminTransferDetail createEmptyInstance() => create();
  static $pb.PbList<AdminTransferDetail> createRepeated() =>
      $pb.PbList<AdminTransferDetail>();
  @$core.pragma('dart2js:noInline')
  static AdminTransferDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminTransferDetail>(create);
  static AdminTransferDetail? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get type => $_getSZ(7);
  @$pb.TagNumber(8)
  set type($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(7);
  @$pb.TagNumber(8)
  void clearType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get recipientAccount => $_getSZ(8);
  @$pb.TagNumber(9)
  set recipientAccount($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRecipientAccount() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipientAccount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipientName => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipientName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRecipientName() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankCode => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankCode($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBankCode() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankCode() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankName => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBankName() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get description => $_getSZ(12);
  @$pb.TagNumber(13)
  set description($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDescription() => $_has(12);
  @$pb.TagNumber(13)
  void clearDescription() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get feeCode => $_getSZ(13);
  @$pb.TagNumber(14)
  set feeCode($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFeeCode() => $_has(13);
  @$pb.TagNumber(14)
  void clearFeeCode() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get feeAmount => $_getN(14);
  @$pb.TagNumber(15)
  set feeAmount($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasFeeAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearFeeAmount() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get provider => $_getSZ(15);
  @$pb.TagNumber(16)
  set provider($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProvider() => $_has(15);
  @$pb.TagNumber(16)
  void clearProvider() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerRef => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerRef($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasProviderRef() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderRef() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get createdAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set createdAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get updatedAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set updatedAt($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get scheduledAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set scheduledAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasScheduledAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearScheduledAt() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get metadata => $_getSZ(20);
  @$pb.TagNumber(21)
  set metadata($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasMetadata() => $_has(20);
  @$pb.TagNumber(21)
  void clearMetadata() => $_clearField(21);
}

class GetTransferByReferenceRequest extends $pb.GeneratedMessage {
  factory GetTransferByReferenceRequest({
    $core.String? reference,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    return result;
  }

  GetTransferByReferenceRequest._();

  factory GetTransferByReferenceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferByReferenceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferByReferenceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferByReferenceRequest clone() =>
      GetTransferByReferenceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferByReferenceRequest copyWith(
          void Function(GetTransferByReferenceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransferByReferenceRequest))
          as GetTransferByReferenceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferByReferenceRequest create() =>
      GetTransferByReferenceRequest._();
  @$core.override
  GetTransferByReferenceRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferByReferenceRequest> createRepeated() =>
      $pb.PbList<GetTransferByReferenceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferByReferenceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferByReferenceRequest>(create);
  static GetTransferByReferenceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

/// One leg of the double-entry ledger for an internal transfer, sourced from
/// accounts-service (the balance source of truth).
class LedgerEntry extends $pb.GeneratedMessage {
  factory LedgerEntry({
    $core.String? id,
    $core.String? accountId,
    $core.String? reference,
    $core.String? type,
    $core.String? category,
    $core.double? amount,
    $core.double? balanceBefore,
    $core.double? balanceAfter,
    $core.String? counterpartyName,
    $core.String? counterpartyAccount,
    $core.String? status,
    $core.String? description,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (accountId != null) result.accountId = accountId;
    if (reference != null) result.reference = reference;
    if (type != null) result.type = type;
    if (category != null) result.category = category;
    if (amount != null) result.amount = amount;
    if (balanceBefore != null) result.balanceBefore = balanceBefore;
    if (balanceAfter != null) result.balanceAfter = balanceAfter;
    if (counterpartyName != null) result.counterpartyName = counterpartyName;
    if (counterpartyAccount != null)
      result.counterpartyAccount = counterpartyAccount;
    if (status != null) result.status = status;
    if (description != null) result.description = description;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  LedgerEntry._();

  factory LedgerEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LedgerEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LedgerEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'balanceBefore', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'balanceAfter', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(10, _omitFieldNames ? '' : 'counterpartyAccount')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'description')
    ..aOS(13, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LedgerEntry clone() => LedgerEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LedgerEntry copyWith(void Function(LedgerEntry) updates) =>
      super.copyWith((message) => updates(message as LedgerEntry))
          as LedgerEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LedgerEntry create() => LedgerEntry._();
  @$core.override
  LedgerEntry createEmptyInstance() => create();
  static $pb.PbList<LedgerEntry> createRepeated() => $pb.PbList<LedgerEntry>();
  @$core.pragma('dart2js:noInline')
  static LedgerEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LedgerEntry>(create);
  static LedgerEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get balanceBefore => $_getN(6);
  @$pb.TagNumber(7)
  set balanceBefore($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBalanceBefore() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceBefore() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get balanceAfter => $_getN(7);
  @$pb.TagNumber(8)
  set balanceAfter($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBalanceAfter() => $_has(7);
  @$pb.TagNumber(8)
  void clearBalanceAfter() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get counterpartyName => $_getSZ(8);
  @$pb.TagNumber(9)
  set counterpartyName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCounterpartyName() => $_has(8);
  @$pb.TagNumber(9)
  void clearCounterpartyName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get counterpartyAccount => $_getSZ(9);
  @$pb.TagNumber(10)
  set counterpartyAccount($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCounterpartyAccount() => $_has(9);
  @$pb.TagNumber(10)
  void clearCounterpartyAccount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get description => $_getSZ(11);
  @$pb.TagNumber(12)
  set description($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDescription() => $_has(11);
  @$pb.TagNumber(12)
  void clearDescription() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
}

/// A family-pool spend record (reserve/capture/release/refund) for transfers
/// whose source is a family account. Empty for ordinary transfers.
class FamilySpendRecord extends $pb.GeneratedMessage {
  factory FamilySpendRecord({
    $core.String? reference,
    $core.double? amount,
    $core.String? phase,
    $core.String? createdAt,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    if (amount != null) result.amount = amount;
    if (phase != null) result.phase = phase;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  FamilySpendRecord._();

  factory FamilySpendRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilySpendRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilySpendRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'phase')
    ..aOS(4, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilySpendRecord clone() => FamilySpendRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilySpendRecord copyWith(void Function(FamilySpendRecord) updates) =>
      super.copyWith((message) => updates(message as FamilySpendRecord))
          as FamilySpendRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilySpendRecord create() => FamilySpendRecord._();
  @$core.override
  FamilySpendRecord createEmptyInstance() => create();
  static $pb.PbList<FamilySpendRecord> createRepeated() =>
      $pb.PbList<FamilySpendRecord>();
  @$core.pragma('dart2js:noInline')
  static FamilySpendRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilySpendRecord>(create);
  static FamilySpendRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phase => $_getSZ(2);
  @$pb.TagNumber(3)
  set phase($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhase() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhase() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get createdAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set createdAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
}

/// Full admin audit for an internal C2C transfer: the payments audit row + the
/// double-entry ledger + optional family-spend records.
class InternalTransferDetail extends $pb.GeneratedMessage {
  factory InternalTransferDetail({
    $core.String? paymentId,
    $core.String? userId,
    $core.String? accountId,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? paymentType,
    $core.String? recipient,
    $core.String? description,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<LedgerEntry>? ledger,
    $core.Iterable<FamilySpendRecord>? familySpend,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (paymentType != null) result.paymentType = paymentType;
    if (recipient != null) result.recipient = recipient;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (ledger != null) result.ledger.addAll(ledger);
    if (familySpend != null) result.familySpend.addAll(familySpend);
    return result;
  }

  InternalTransferDetail._();

  factory InternalTransferDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InternalTransferDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InternalTransferDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'paymentType')
    ..aOS(10, _omitFieldNames ? '' : 'recipient')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..aOS(13, _omitFieldNames ? '' : 'createdAt')
    ..aOS(14, _omitFieldNames ? '' : 'updatedAt')
    ..pc<LedgerEntry>(15, _omitFieldNames ? '' : 'ledger', $pb.PbFieldType.PM,
        subBuilder: LedgerEntry.create)
    ..pc<FamilySpendRecord>(
        16, _omitFieldNames ? '' : 'familySpend', $pb.PbFieldType.PM,
        subBuilder: FamilySpendRecord.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternalTransferDetail clone() =>
      InternalTransferDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternalTransferDetail copyWith(
          void Function(InternalTransferDetail) updates) =>
      super.copyWith((message) => updates(message as InternalTransferDetail))
          as InternalTransferDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InternalTransferDetail create() => InternalTransferDetail._();
  @$core.override
  InternalTransferDetail createEmptyInstance() => create();
  static $pb.PbList<InternalTransferDetail> createRepeated() =>
      $pb.PbList<InternalTransferDetail>();
  @$core.pragma('dart2js:noInline')
  static InternalTransferDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InternalTransferDetail>(create);
  static InternalTransferDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get paymentType => $_getSZ(8);
  @$pb.TagNumber(9)
  set paymentType($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPaymentType() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaymentType() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipient => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipient($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRecipient() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipient() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get updatedAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set updatedAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $pb.PbList<LedgerEntry> get ledger => $_getList(14);

  @$pb.TagNumber(16)
  $pb.PbList<FamilySpendRecord> get familySpend => $_getList(15);
}

class ListPaymentsRequest extends $pb.GeneratedMessage {
  factory ListPaymentsRequest({
    $core.String? paymentType,
    $core.String? status,
    $core.String? userId,
    $core.String? accountId,
    $core.String? reference,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (paymentType != null) result.paymentType = paymentType;
    if (status != null) result.status = status;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (reference != null) result.reference = reference;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListPaymentsRequest._();

  factory ListPaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentType')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'accountId')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOS(6, _omitFieldNames ? '' : 'startDate')
    ..aOS(7, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaymentsRequest clone() => ListPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaymentsRequest copyWith(void Function(ListPaymentsRequest) updates) =>
      super.copyWith((message) => updates(message as ListPaymentsRequest))
          as ListPaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaymentsRequest create() => ListPaymentsRequest._();
  @$core.override
  ListPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPaymentsRequest> createRepeated() =>
      $pb.PbList<ListPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPaymentsRequest>(create);
  static ListPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get startDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set startDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get endDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set endDate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get page => $_getIZ(7);
  @$pb.TagNumber(8)
  set page($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPage() => $_has(7);
  @$pb.TagNumber(8)
  void clearPage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get limit => $_getIZ(8);
  @$pb.TagNumber(9)
  set limit($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasLimit() => $_has(8);
  @$pb.TagNumber(9)
  void clearLimit() => $_clearField(9);
}

class ListPaymentsResponse extends $pb.GeneratedMessage {
  factory ListPaymentsResponse({
    $core.Iterable<PaymentDetail>? payments,
    $core.int? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListPaymentsResponse._();

  factory ListPaymentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<PaymentDetail>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: PaymentDetail.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaymentsResponse clone() =>
      ListPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaymentsResponse copyWith(void Function(ListPaymentsResponse) updates) =>
      super.copyWith((message) => updates(message as ListPaymentsResponse))
          as ListPaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaymentsResponse create() => ListPaymentsResponse._();
  @$core.override
  ListPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPaymentsResponse> createRepeated() =>
      $pb.PbList<ListPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPaymentsResponse>(create);
  static ListPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PaymentDetail> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class PaymentDetail extends $pb.GeneratedMessage {
  factory PaymentDetail({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? paymentType,
    $core.String? reference,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? recipient,
    $core.String? description,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? scheduledAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (paymentType != null) result.paymentType = paymentType;
    if (reference != null) result.reference = reference;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (recipient != null) result.recipient = recipient;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (scheduledAt != null) result.scheduledAt = scheduledAt;
    return result;
  }

  PaymentDetail._();

  factory PaymentDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'paymentType')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'recipient')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..aOS(11, _omitFieldNames ? '' : 'metadata')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(14, _omitFieldNames ? '' : 'scheduledAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentDetail clone() => PaymentDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentDetail copyWith(void Function(PaymentDetail) updates) =>
      super.copyWith((message) => updates(message as PaymentDetail))
          as PaymentDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentDetail create() => PaymentDetail._();
  @$core.override
  PaymentDetail createEmptyInstance() => create();
  static $pb.PbList<PaymentDetail> createRepeated() =>
      $pb.PbList<PaymentDetail>();
  @$core.pragma('dart2js:noInline')
  static PaymentDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentDetail>(create);
  static PaymentDetail? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get recipient => $_getSZ(8);
  @$pb.TagNumber(9)
  set recipient($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRecipient() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipient() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get metadata => $_getSZ(10);
  @$pb.TagNumber(11)
  set metadata($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMetadata() => $_has(10);
  @$pb.TagNumber(11)
  void clearMetadata() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get scheduledAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set scheduledAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasScheduledAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearScheduledAt() => $_clearField(14);
}

class AdminGetDailyUsageRequest extends $pb.GeneratedMessage {
  factory AdminGetDailyUsageRequest({
    $core.String? userId,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  AdminGetDailyUsageRequest._();

  factory AdminGetDailyUsageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetDailyUsageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetDailyUsageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetDailyUsageRequest clone() =>
      AdminGetDailyUsageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetDailyUsageRequest copyWith(
          void Function(AdminGetDailyUsageRequest) updates) =>
      super.copyWith((message) => updates(message as AdminGetDailyUsageRequest))
          as AdminGetDailyUsageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetDailyUsageRequest create() => AdminGetDailyUsageRequest._();
  @$core.override
  AdminGetDailyUsageRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetDailyUsageRequest> createRepeated() =>
      $pb.PbList<AdminGetDailyUsageRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetDailyUsageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetDailyUsageRequest>(create);
  static AdminGetDailyUsageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get endDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set endDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => $_clearField(5);
}

class AdminGetDailyUsageResponse extends $pb.GeneratedMessage {
  factory AdminGetDailyUsageResponse({
    $core.Iterable<DailyUsageRecord>? records,
    $core.int? total,
    DailyUsageSummary? summary,
  }) {
    final result = create();
    if (records != null) result.records.addAll(records);
    if (total != null) result.total = total;
    if (summary != null) result.summary = summary;
    return result;
  }

  AdminGetDailyUsageResponse._();

  factory AdminGetDailyUsageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetDailyUsageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetDailyUsageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<DailyUsageRecord>(
        1, _omitFieldNames ? '' : 'records', $pb.PbFieldType.PM,
        subBuilder: DailyUsageRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOM<DailyUsageSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: DailyUsageSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetDailyUsageResponse clone() =>
      AdminGetDailyUsageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetDailyUsageResponse copyWith(
          void Function(AdminGetDailyUsageResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminGetDailyUsageResponse))
          as AdminGetDailyUsageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetDailyUsageResponse create() => AdminGetDailyUsageResponse._();
  @$core.override
  AdminGetDailyUsageResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetDailyUsageResponse> createRepeated() =>
      $pb.PbList<AdminGetDailyUsageResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetDailyUsageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetDailyUsageResponse>(create);
  static AdminGetDailyUsageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DailyUsageRecord> get records => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  DailyUsageSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(DailyUsageSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  DailyUsageSummary ensureSummary() => $_ensure(2);
}

class DailyUsageRecord extends $pb.GeneratedMessage {
  factory DailyUsageRecord({
    $core.String? id,
    $core.String? userId,
    $core.String? usageDate,
    $fixnum.Int64? totalTransferred,
    $core.int? transferCount,
    $core.int? internalTransferCount,
    $core.int? externalTransferCount,
    $fixnum.Int64? totalWithdrawn,
    $core.int? withdrawalCount,
    $fixnum.Int64? totalInternational,
    $core.int? internationalCount,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (usageDate != null) result.usageDate = usageDate;
    if (totalTransferred != null) result.totalTransferred = totalTransferred;
    if (transferCount != null) result.transferCount = transferCount;
    if (internalTransferCount != null)
      result.internalTransferCount = internalTransferCount;
    if (externalTransferCount != null)
      result.externalTransferCount = externalTransferCount;
    if (totalWithdrawn != null) result.totalWithdrawn = totalWithdrawn;
    if (withdrawalCount != null) result.withdrawalCount = withdrawalCount;
    if (totalInternational != null)
      result.totalInternational = totalInternational;
    if (internationalCount != null)
      result.internationalCount = internationalCount;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  DailyUsageRecord._();

  factory DailyUsageRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailyUsageRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailyUsageRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'usageDate')
    ..aInt64(4, _omitFieldNames ? '' : 'totalTransferred')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'transferCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'internalTransferCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'externalTransferCount', $pb.PbFieldType.O3)
    ..aInt64(8, _omitFieldNames ? '' : 'totalWithdrawn')
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'withdrawalCount', $pb.PbFieldType.O3)
    ..aInt64(10, _omitFieldNames ? '' : 'totalInternational')
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'internationalCount', $pb.PbFieldType.O3)
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyUsageRecord clone() => DailyUsageRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyUsageRecord copyWith(void Function(DailyUsageRecord) updates) =>
      super.copyWith((message) => updates(message as DailyUsageRecord))
          as DailyUsageRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyUsageRecord create() => DailyUsageRecord._();
  @$core.override
  DailyUsageRecord createEmptyInstance() => create();
  static $pb.PbList<DailyUsageRecord> createRepeated() =>
      $pb.PbList<DailyUsageRecord>();
  @$core.pragma('dart2js:noInline')
  static DailyUsageRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailyUsageRecord>(create);
  static DailyUsageRecord? _defaultInstance;

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
  $core.String get usageDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set usageDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUsageDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsageDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalTransferred => $_getI64(3);
  @$pb.TagNumber(4)
  set totalTransferred($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalTransferred() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalTransferred() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transferCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transferCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransferCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransferCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get internalTransferCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set internalTransferCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInternalTransferCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearInternalTransferCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get externalTransferCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set externalTransferCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasExternalTransferCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearExternalTransferCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalWithdrawn => $_getI64(7);
  @$pb.TagNumber(8)
  set totalWithdrawn($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalWithdrawn() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalWithdrawn() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get withdrawalCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set withdrawalCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasWithdrawalCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearWithdrawalCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get totalInternational => $_getI64(9);
  @$pb.TagNumber(10)
  set totalInternational($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTotalInternational() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalInternational() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get internationalCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set internationalCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasInternationalCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearInternationalCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
}

class DailyUsageSummary extends $pb.GeneratedMessage {
  factory DailyUsageSummary({
    $fixnum.Int64? totalAmountTransferred,
    $core.int? totalTransfers,
    $fixnum.Int64? totalWithdrawn,
    $core.int? totalWithdrawals,
    $fixnum.Int64? totalInternational,
    $core.int? totalInternationalTransfers,
    $core.int? uniqueUsers,
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final result = create();
    if (totalAmountTransferred != null)
      result.totalAmountTransferred = totalAmountTransferred;
    if (totalTransfers != null) result.totalTransfers = totalTransfers;
    if (totalWithdrawn != null) result.totalWithdrawn = totalWithdrawn;
    if (totalWithdrawals != null) result.totalWithdrawals = totalWithdrawals;
    if (totalInternational != null)
      result.totalInternational = totalInternational;
    if (totalInternationalTransfers != null)
      result.totalInternationalTransfers = totalInternationalTransfers;
    if (uniqueUsers != null) result.uniqueUsers = uniqueUsers;
    if (periodStart != null) result.periodStart = periodStart;
    if (periodEnd != null) result.periodEnd = periodEnd;
    return result;
  }

  DailyUsageSummary._();

  factory DailyUsageSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailyUsageSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailyUsageSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'totalAmountTransferred')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'totalTransfers', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'totalWithdrawn')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'totalWithdrawals', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'totalInternational')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'totalInternationalTransfers',
        $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'uniqueUsers', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'periodStart')
    ..aOS(9, _omitFieldNames ? '' : 'periodEnd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyUsageSummary clone() => DailyUsageSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyUsageSummary copyWith(void Function(DailyUsageSummary) updates) =>
      super.copyWith((message) => updates(message as DailyUsageSummary))
          as DailyUsageSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyUsageSummary create() => DailyUsageSummary._();
  @$core.override
  DailyUsageSummary createEmptyInstance() => create();
  static $pb.PbList<DailyUsageSummary> createRepeated() =>
      $pb.PbList<DailyUsageSummary>();
  @$core.pragma('dart2js:noInline')
  static DailyUsageSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailyUsageSummary>(create);
  static DailyUsageSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalAmountTransferred => $_getI64(0);
  @$pb.TagNumber(1)
  set totalAmountTransferred($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalAmountTransferred() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAmountTransferred() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalTransfers => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalTransfers($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalTransfers() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalTransfers() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalWithdrawn => $_getI64(2);
  @$pb.TagNumber(3)
  set totalWithdrawn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalWithdrawn() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalWithdrawn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalWithdrawals => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalWithdrawals($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalWithdrawals() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalWithdrawals() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalInternational => $_getI64(4);
  @$pb.TagNumber(5)
  set totalInternational($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalInternational() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalInternational() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalInternationalTransfers => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalInternationalTransfers($core.int value) =>
      $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalInternationalTransfers() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalInternationalTransfers() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get uniqueUsers => $_getIZ(6);
  @$pb.TagNumber(7)
  set uniqueUsers($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUniqueUsers() => $_has(6);
  @$pb.TagNumber(7)
  void clearUniqueUsers() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get periodStart => $_getSZ(7);
  @$pb.TagNumber(8)
  set periodStart($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPeriodStart() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriodStart() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get periodEnd => $_getSZ(8);
  @$pb.TagNumber(9)
  set periodEnd($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPeriodEnd() => $_has(8);
  @$pb.TagNumber(9)
  void clearPeriodEnd() => $_clearField(9);
}

class GetProviderBalancesRequest extends $pb.GeneratedMessage {
  factory GetProviderBalancesRequest() => create();

  GetProviderBalancesRequest._();

  factory GetProviderBalancesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProviderBalancesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProviderBalancesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProviderBalancesRequest clone() =>
      GetProviderBalancesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProviderBalancesRequest copyWith(
          void Function(GetProviderBalancesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetProviderBalancesRequest))
          as GetProviderBalancesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProviderBalancesRequest create() => GetProviderBalancesRequest._();
  @$core.override
  GetProviderBalancesRequest createEmptyInstance() => create();
  static $pb.PbList<GetProviderBalancesRequest> createRepeated() =>
      $pb.PbList<GetProviderBalancesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProviderBalancesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProviderBalancesRequest>(create);
  static GetProviderBalancesRequest? _defaultInstance;
}

class ProviderBalances extends $pb.GeneratedMessage {
  factory ProviderBalances({
    $core.Iterable<ProviderBalance>? balances,
    $core.String? lastCheckedAt,
  }) {
    final result = create();
    if (balances != null) result.balances.addAll(balances);
    if (lastCheckedAt != null) result.lastCheckedAt = lastCheckedAt;
    return result;
  }

  ProviderBalances._();

  factory ProviderBalances.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProviderBalances.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProviderBalances',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<ProviderBalance>(
        1, _omitFieldNames ? '' : 'balances', $pb.PbFieldType.PM,
        subBuilder: ProviderBalance.create)
    ..aOS(2, _omitFieldNames ? '' : 'lastCheckedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderBalances clone() => ProviderBalances()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderBalances copyWith(void Function(ProviderBalances) updates) =>
      super.copyWith((message) => updates(message as ProviderBalances))
          as ProviderBalances;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderBalances create() => ProviderBalances._();
  @$core.override
  ProviderBalances createEmptyInstance() => create();
  static $pb.PbList<ProviderBalances> createRepeated() =>
      $pb.PbList<ProviderBalances>();
  @$core.pragma('dart2js:noInline')
  static ProviderBalances getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProviderBalances>(create);
  static ProviderBalances? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ProviderBalance> get balances => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get lastCheckedAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastCheckedAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastCheckedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastCheckedAt() => $_clearField(2);
}

class ProviderBalance extends $pb.GeneratedMessage {
  factory ProviderBalance({
    $core.String? provider,
    $core.String? balanceType,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? lastUpdated,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (balanceType != null) result.balanceType = balanceType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  ProviderBalance._();

  factory ProviderBalance.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProviderBalance.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProviderBalance',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'balanceType')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOS(6, _omitFieldNames ? '' : 'lastUpdated')
    ..aOS(7, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderBalance clone() => ProviderBalance()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderBalance copyWith(void Function(ProviderBalance) updates) =>
      super.copyWith((message) => updates(message as ProviderBalance))
          as ProviderBalance;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderBalance create() => ProviderBalance._();
  @$core.override
  ProviderBalance createEmptyInstance() => create();
  static $pb.PbList<ProviderBalance> createRepeated() =>
      $pb.PbList<ProviderBalance>();
  @$core.pragma('dart2js:noInline')
  static ProviderBalance getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProviderBalance>(create);
  static ProviderBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get balanceType => $_getSZ(1);
  @$pb.TagNumber(2)
  set balanceType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBalanceType() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalanceType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastUpdated => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastUpdated($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastUpdated() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUpdated() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorMessage($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasErrorMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorMessage() => $_clearField(7);
}

class ProviderSettlementReport extends $pb.GeneratedMessage {
  factory ProviderSettlementReport({
    $core.String? provider,
    $core.String? periodStart,
    $core.String? periodEnd,
    $core.double? totalDebits,
    $core.double? totalCredits,
    $core.double? netSettlement,
    $core.int? transactionCount,
    $core.double? ourLedgerBalance,
    $core.double? providerLedgerBalance,
    $core.double? discrepancy,
    $core.String? status,
    $core.Iterable<$core.String>? discrepancies,
    $core.String? generatedAt,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (periodStart != null) result.periodStart = periodStart;
    if (periodEnd != null) result.periodEnd = periodEnd;
    if (totalDebits != null) result.totalDebits = totalDebits;
    if (totalCredits != null) result.totalCredits = totalCredits;
    if (netSettlement != null) result.netSettlement = netSettlement;
    if (transactionCount != null) result.transactionCount = transactionCount;
    if (ourLedgerBalance != null) result.ourLedgerBalance = ourLedgerBalance;
    if (providerLedgerBalance != null)
      result.providerLedgerBalance = providerLedgerBalance;
    if (discrepancy != null) result.discrepancy = discrepancy;
    if (status != null) result.status = status;
    if (discrepancies != null) result.discrepancies.addAll(discrepancies);
    if (generatedAt != null) result.generatedAt = generatedAt;
    return result;
  }

  ProviderSettlementReport._();

  factory ProviderSettlementReport.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProviderSettlementReport.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProviderSettlementReport',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'periodStart')
    ..aOS(3, _omitFieldNames ? '' : 'periodEnd')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalDebits', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalCredits', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'netSettlement', $pb.PbFieldType.OD)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'ourLedgerBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'providerLedgerBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'discrepancy', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..pPS(12, _omitFieldNames ? '' : 'discrepancies')
    ..aOS(13, _omitFieldNames ? '' : 'generatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderSettlementReport clone() =>
      ProviderSettlementReport()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderSettlementReport copyWith(
          void Function(ProviderSettlementReport) updates) =>
      super.copyWith((message) => updates(message as ProviderSettlementReport))
          as ProviderSettlementReport;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderSettlementReport create() => ProviderSettlementReport._();
  @$core.override
  ProviderSettlementReport createEmptyInstance() => create();
  static $pb.PbList<ProviderSettlementReport> createRepeated() =>
      $pb.PbList<ProviderSettlementReport>();
  @$core.pragma('dart2js:noInline')
  static ProviderSettlementReport getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProviderSettlementReport>(create);
  static ProviderSettlementReport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodStart => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodStart($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriodStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodStart() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get periodEnd => $_getSZ(2);
  @$pb.TagNumber(3)
  set periodEnd($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPeriodEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriodEnd() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalDebits => $_getN(3);
  @$pb.TagNumber(4)
  set totalDebits($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalDebits() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalDebits() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalCredits => $_getN(4);
  @$pb.TagNumber(5)
  set totalCredits($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalCredits() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalCredits() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get netSettlement => $_getN(5);
  @$pb.TagNumber(6)
  set netSettlement($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNetSettlement() => $_has(5);
  @$pb.TagNumber(6)
  void clearNetSettlement() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get transactionCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set transactionCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get ourLedgerBalance => $_getN(7);
  @$pb.TagNumber(8)
  set ourLedgerBalance($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOurLedgerBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearOurLedgerBalance() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get providerLedgerBalance => $_getN(8);
  @$pb.TagNumber(9)
  set providerLedgerBalance($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProviderLedgerBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearProviderLedgerBalance() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get discrepancy => $_getN(9);
  @$pb.TagNumber(10)
  set discrepancy($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDiscrepancy() => $_has(9);
  @$pb.TagNumber(10)
  void clearDiscrepancy() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get discrepancies => $_getList(11);

  @$pb.TagNumber(13)
  $core.String get generatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set generatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasGeneratedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearGeneratedAt() => $_clearField(13);
}

class GetWebhookAuditTrailRequest extends $pb.GeneratedMessage {
  factory GetWebhookAuditTrailRequest({
    $core.String? provider,
    $core.String? reference,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetWebhookAuditTrailRequest._();

  factory GetWebhookAuditTrailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWebhookAuditTrailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWebhookAuditTrailRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'startDate')
    ..aOS(5, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWebhookAuditTrailRequest clone() =>
      GetWebhookAuditTrailRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWebhookAuditTrailRequest copyWith(
          void Function(GetWebhookAuditTrailRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetWebhookAuditTrailRequest))
          as GetWebhookAuditTrailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWebhookAuditTrailRequest create() =>
      GetWebhookAuditTrailRequest._();
  @$core.override
  GetWebhookAuditTrailRequest createEmptyInstance() => create();
  static $pb.PbList<GetWebhookAuditTrailRequest> createRepeated() =>
      $pb.PbList<GetWebhookAuditTrailRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWebhookAuditTrailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWebhookAuditTrailRequest>(create);
  static GetWebhookAuditTrailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get startDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get endDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set endDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get page => $_getIZ(5);
  @$pb.TagNumber(6)
  set page($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPage() => $_has(5);
  @$pb.TagNumber(6)
  void clearPage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get limit => $_getIZ(6);
  @$pb.TagNumber(7)
  set limit($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearLimit() => $_clearField(7);
}

class WebhookAuditTrailResponse extends $pb.GeneratedMessage {
  factory WebhookAuditTrailResponse({
    $core.Iterable<WebhookAuditEntry>? entries,
    $core.int? total,
    WebhookAuditSummary? summary,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    if (total != null) result.total = total;
    if (summary != null) result.summary = summary;
    return result;
  }

  WebhookAuditTrailResponse._();

  factory WebhookAuditTrailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookAuditTrailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookAuditTrailResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<WebhookAuditEntry>(
        1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: WebhookAuditEntry.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOM<WebhookAuditSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: WebhookAuditSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookAuditTrailResponse clone() =>
      WebhookAuditTrailResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookAuditTrailResponse copyWith(
          void Function(WebhookAuditTrailResponse) updates) =>
      super.copyWith((message) => updates(message as WebhookAuditTrailResponse))
          as WebhookAuditTrailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookAuditTrailResponse create() => WebhookAuditTrailResponse._();
  @$core.override
  WebhookAuditTrailResponse createEmptyInstance() => create();
  static $pb.PbList<WebhookAuditTrailResponse> createRepeated() =>
      $pb.PbList<WebhookAuditTrailResponse>();
  @$core.pragma('dart2js:noInline')
  static WebhookAuditTrailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookAuditTrailResponse>(create);
  static WebhookAuditTrailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<WebhookAuditEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  WebhookAuditSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(WebhookAuditSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  WebhookAuditSummary ensureSummary() => $_ensure(2);
}

class WebhookAuditEntry extends $pb.GeneratedMessage {
  factory WebhookAuditEntry({
    $core.String? id,
    $core.String? provider,
    $core.String? eventType,
    $core.String? reference,
    $core.String? providerRef,
    $core.String? status,
    $core.int? httpStatusCode,
    $core.String? requestPayload,
    $core.String? responseBody,
    $core.String? errorMessage,
    $core.String? processedAt,
    $core.String? createdAt,
    $core.String? ipAddress,
    $core.String? signature,
    $core.bool? signatureValid,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (provider != null) result.provider = provider;
    if (eventType != null) result.eventType = eventType;
    if (reference != null) result.reference = reference;
    if (providerRef != null) result.providerRef = providerRef;
    if (status != null) result.status = status;
    if (httpStatusCode != null) result.httpStatusCode = httpStatusCode;
    if (requestPayload != null) result.requestPayload = requestPayload;
    if (responseBody != null) result.responseBody = responseBody;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (processedAt != null) result.processedAt = processedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (ipAddress != null) result.ipAddress = ipAddress;
    if (signature != null) result.signature = signature;
    if (signatureValid != null) result.signatureValid = signatureValid;
    return result;
  }

  WebhookAuditEntry._();

  factory WebhookAuditEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookAuditEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookAuditEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..aOS(3, _omitFieldNames ? '' : 'eventType')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'providerRef')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'httpStatusCode', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'requestPayload')
    ..aOS(9, _omitFieldNames ? '' : 'responseBody')
    ..aOS(10, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(11, _omitFieldNames ? '' : 'processedAt')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'ipAddress')
    ..aOS(14, _omitFieldNames ? '' : 'signature')
    ..aOB(15, _omitFieldNames ? '' : 'signatureValid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookAuditEntry clone() => WebhookAuditEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookAuditEntry copyWith(void Function(WebhookAuditEntry) updates) =>
      super.copyWith((message) => updates(message as WebhookAuditEntry))
          as WebhookAuditEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookAuditEntry create() => WebhookAuditEntry._();
  @$core.override
  WebhookAuditEntry createEmptyInstance() => create();
  static $pb.PbList<WebhookAuditEntry> createRepeated() =>
      $pb.PbList<WebhookAuditEntry>();
  @$core.pragma('dart2js:noInline')
  static WebhookAuditEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookAuditEntry>(create);
  static WebhookAuditEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventType => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerRef => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerRef($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderRef() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderRef() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get httpStatusCode => $_getIZ(6);
  @$pb.TagNumber(7)
  set httpStatusCode($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHttpStatusCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearHttpStatusCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get requestPayload => $_getSZ(7);
  @$pb.TagNumber(8)
  set requestPayload($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRequestPayload() => $_has(7);
  @$pb.TagNumber(8)
  void clearRequestPayload() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get responseBody => $_getSZ(8);
  @$pb.TagNumber(9)
  set responseBody($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasResponseBody() => $_has(8);
  @$pb.TagNumber(9)
  void clearResponseBody() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get errorMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set errorMessage($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasErrorMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearErrorMessage() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get processedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set processedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProcessedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearProcessedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get ipAddress => $_getSZ(12);
  @$pb.TagNumber(13)
  set ipAddress($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIpAddress() => $_has(12);
  @$pb.TagNumber(13)
  void clearIpAddress() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get signature => $_getSZ(13);
  @$pb.TagNumber(14)
  set signature($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSignature() => $_has(13);
  @$pb.TagNumber(14)
  void clearSignature() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get signatureValid => $_getBF(14);
  @$pb.TagNumber(15)
  set signatureValid($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSignatureValid() => $_has(14);
  @$pb.TagNumber(15)
  void clearSignatureValid() => $_clearField(15);
}

class WebhookAuditSummary extends $pb.GeneratedMessage {
  factory WebhookAuditSummary({
    $core.int? totalWebhooks,
    $core.int? successfulWebhooks,
    $core.int? failedWebhooks,
    $core.int? pendingWebhooks,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? byProvider,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? byEventType,
  }) {
    final result = create();
    if (totalWebhooks != null) result.totalWebhooks = totalWebhooks;
    if (successfulWebhooks != null)
      result.successfulWebhooks = successfulWebhooks;
    if (failedWebhooks != null) result.failedWebhooks = failedWebhooks;
    if (pendingWebhooks != null) result.pendingWebhooks = pendingWebhooks;
    if (byProvider != null) result.byProvider.addEntries(byProvider);
    if (byEventType != null) result.byEventType.addEntries(byEventType);
    return result;
  }

  WebhookAuditSummary._();

  factory WebhookAuditSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookAuditSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookAuditSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalWebhooks', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'successfulWebhooks', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'failedWebhooks', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'pendingWebhooks', $pb.PbFieldType.O3)
    ..m<$core.String, $core.int>(5, _omitFieldNames ? '' : 'byProvider',
        entryClassName: 'WebhookAuditSummary.ByProviderEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('payments'))
    ..m<$core.String, $core.int>(6, _omitFieldNames ? '' : 'byEventType',
        entryClassName: 'WebhookAuditSummary.ByEventTypeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('payments'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookAuditSummary clone() => WebhookAuditSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookAuditSummary copyWith(void Function(WebhookAuditSummary) updates) =>
      super.copyWith((message) => updates(message as WebhookAuditSummary))
          as WebhookAuditSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookAuditSummary create() => WebhookAuditSummary._();
  @$core.override
  WebhookAuditSummary createEmptyInstance() => create();
  static $pb.PbList<WebhookAuditSummary> createRepeated() =>
      $pb.PbList<WebhookAuditSummary>();
  @$core.pragma('dart2js:noInline')
  static WebhookAuditSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookAuditSummary>(create);
  static WebhookAuditSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalWebhooks => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalWebhooks($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalWebhooks() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalWebhooks() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get successfulWebhooks => $_getIZ(1);
  @$pb.TagNumber(2)
  set successfulWebhooks($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccessfulWebhooks() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessfulWebhooks() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get failedWebhooks => $_getIZ(2);
  @$pb.TagNumber(3)
  set failedWebhooks($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFailedWebhooks() => $_has(2);
  @$pb.TagNumber(3)
  void clearFailedWebhooks() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pendingWebhooks => $_getIZ(3);
  @$pb.TagNumber(4)
  set pendingWebhooks($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPendingWebhooks() => $_has(3);
  @$pb.TagNumber(4)
  void clearPendingWebhooks() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.int> get byProvider => $_getMap(4);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.int> get byEventType => $_getMap(5);
}

class GetTransferAsyncConfigRequest extends $pb.GeneratedMessage {
  factory GetTransferAsyncConfigRequest() => create();

  GetTransferAsyncConfigRequest._();

  factory GetTransferAsyncConfigRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferAsyncConfigRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferAsyncConfigRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferAsyncConfigRequest clone() =>
      GetTransferAsyncConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferAsyncConfigRequest copyWith(
          void Function(GetTransferAsyncConfigRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransferAsyncConfigRequest))
          as GetTransferAsyncConfigRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferAsyncConfigRequest create() =>
      GetTransferAsyncConfigRequest._();
  @$core.override
  GetTransferAsyncConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferAsyncConfigRequest> createRepeated() =>
      $pb.PbList<GetTransferAsyncConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferAsyncConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferAsyncConfigRequest>(create);
  static GetTransferAsyncConfigRequest? _defaultInstance;
}

class UpdateTransferAsyncConfigRequest extends $pb.GeneratedMessage {
  factory UpdateTransferAsyncConfigRequest({
    $core.bool? asyncExternalTransferEnabled,
    $core.bool? asyncBatchTransferEnabled,
    $core.String? flutterwaveWebhookUrl,
    $core.int? staleReconcilerIntervalSeconds,
    $core.int? rollbackProcessorIntervalSeconds,
    $core.int? holdExtensionIntervalSeconds,
    $core.int? batchSupervisorIntervalSeconds,
    $core.int? batchSettlementIntervalSeconds,
    $core.int? batchRollbackIntervalSeconds,
    $core.int? batchHoldExpiryIntervalSeconds,
  }) {
    final result = create();
    if (asyncExternalTransferEnabled != null)
      result.asyncExternalTransferEnabled = asyncExternalTransferEnabled;
    if (asyncBatchTransferEnabled != null)
      result.asyncBatchTransferEnabled = asyncBatchTransferEnabled;
    if (flutterwaveWebhookUrl != null)
      result.flutterwaveWebhookUrl = flutterwaveWebhookUrl;
    if (staleReconcilerIntervalSeconds != null)
      result.staleReconcilerIntervalSeconds = staleReconcilerIntervalSeconds;
    if (rollbackProcessorIntervalSeconds != null)
      result.rollbackProcessorIntervalSeconds =
          rollbackProcessorIntervalSeconds;
    if (holdExtensionIntervalSeconds != null)
      result.holdExtensionIntervalSeconds = holdExtensionIntervalSeconds;
    if (batchSupervisorIntervalSeconds != null)
      result.batchSupervisorIntervalSeconds = batchSupervisorIntervalSeconds;
    if (batchSettlementIntervalSeconds != null)
      result.batchSettlementIntervalSeconds = batchSettlementIntervalSeconds;
    if (batchRollbackIntervalSeconds != null)
      result.batchRollbackIntervalSeconds = batchRollbackIntervalSeconds;
    if (batchHoldExpiryIntervalSeconds != null)
      result.batchHoldExpiryIntervalSeconds = batchHoldExpiryIntervalSeconds;
    return result;
  }

  UpdateTransferAsyncConfigRequest._();

  factory UpdateTransferAsyncConfigRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTransferAsyncConfigRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTransferAsyncConfigRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'asyncExternalTransferEnabled')
    ..aOB(2, _omitFieldNames ? '' : 'asyncBatchTransferEnabled')
    ..aOS(3, _omitFieldNames ? '' : 'flutterwaveWebhookUrl')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'staleReconcilerIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        11,
        _omitFieldNames ? '' : 'rollbackProcessorIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'holdExtensionIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'batchSupervisorIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'batchSettlementIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(15, _omitFieldNames ? '' : 'batchRollbackIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(16, _omitFieldNames ? '' : 'batchHoldExpiryIntervalSeconds',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTransferAsyncConfigRequest clone() =>
      UpdateTransferAsyncConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTransferAsyncConfigRequest copyWith(
          void Function(UpdateTransferAsyncConfigRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateTransferAsyncConfigRequest))
          as UpdateTransferAsyncConfigRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTransferAsyncConfigRequest create() =>
      UpdateTransferAsyncConfigRequest._();
  @$core.override
  UpdateTransferAsyncConfigRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTransferAsyncConfigRequest> createRepeated() =>
      $pb.PbList<UpdateTransferAsyncConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTransferAsyncConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTransferAsyncConfigRequest>(
          create);
  static UpdateTransferAsyncConfigRequest? _defaultInstance;

  /// Each field is optional. Omit to leave the corresponding system_setting
  /// row untouched (proto3 doesn't distinguish unset bool from false, so we
  /// use HasField semantics via the optional keyword).
  @$pb.TagNumber(1)
  $core.bool get asyncExternalTransferEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set asyncExternalTransferEnabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAsyncExternalTransferEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearAsyncExternalTransferEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get asyncBatchTransferEnabled => $_getBF(1);
  @$pb.TagNumber(2)
  set asyncBatchTransferEnabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAsyncBatchTransferEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearAsyncBatchTransferEnabled() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get flutterwaveWebhookUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set flutterwaveWebhookUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFlutterwaveWebhookUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlutterwaveWebhookUrl() => $_clearField(3);

  /// Worker tick intervals (seconds). All default to 3600 (1 h) to keep DB
  /// pressure low. Admin can shorten in prod for faster recovery — the UI
  /// surfaces these as sliders. The thresholds (stale_threshold,
  /// rollback_max_attempts, etc.) are intentionally NOT exposed here as
  /// they govern WHEN a row qualifies for pickup, not HOW OFTEN we look.
  @$pb.TagNumber(10)
  $core.int get staleReconcilerIntervalSeconds => $_getIZ(3);
  @$pb.TagNumber(10)
  set staleReconcilerIntervalSeconds($core.int value) =>
      $_setSignedInt32(3, value);
  @$pb.TagNumber(10)
  $core.bool hasStaleReconcilerIntervalSeconds() => $_has(3);
  @$pb.TagNumber(10)
  void clearStaleReconcilerIntervalSeconds() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get rollbackProcessorIntervalSeconds => $_getIZ(4);
  @$pb.TagNumber(11)
  set rollbackProcessorIntervalSeconds($core.int value) =>
      $_setSignedInt32(4, value);
  @$pb.TagNumber(11)
  $core.bool hasRollbackProcessorIntervalSeconds() => $_has(4);
  @$pb.TagNumber(11)
  void clearRollbackProcessorIntervalSeconds() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get holdExtensionIntervalSeconds => $_getIZ(5);
  @$pb.TagNumber(12)
  set holdExtensionIntervalSeconds($core.int value) =>
      $_setSignedInt32(5, value);
  @$pb.TagNumber(12)
  $core.bool hasHoldExtensionIntervalSeconds() => $_has(5);
  @$pb.TagNumber(12)
  void clearHoldExtensionIntervalSeconds() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get batchSupervisorIntervalSeconds => $_getIZ(6);
  @$pb.TagNumber(13)
  set batchSupervisorIntervalSeconds($core.int value) =>
      $_setSignedInt32(6, value);
  @$pb.TagNumber(13)
  $core.bool hasBatchSupervisorIntervalSeconds() => $_has(6);
  @$pb.TagNumber(13)
  void clearBatchSupervisorIntervalSeconds() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get batchSettlementIntervalSeconds => $_getIZ(7);
  @$pb.TagNumber(14)
  set batchSettlementIntervalSeconds($core.int value) =>
      $_setSignedInt32(7, value);
  @$pb.TagNumber(14)
  $core.bool hasBatchSettlementIntervalSeconds() => $_has(7);
  @$pb.TagNumber(14)
  void clearBatchSettlementIntervalSeconds() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get batchRollbackIntervalSeconds => $_getIZ(8);
  @$pb.TagNumber(15)
  set batchRollbackIntervalSeconds($core.int value) =>
      $_setSignedInt32(8, value);
  @$pb.TagNumber(15)
  $core.bool hasBatchRollbackIntervalSeconds() => $_has(8);
  @$pb.TagNumber(15)
  void clearBatchRollbackIntervalSeconds() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get batchHoldExpiryIntervalSeconds => $_getIZ(9);
  @$pb.TagNumber(16)
  set batchHoldExpiryIntervalSeconds($core.int value) =>
      $_setSignedInt32(9, value);
  @$pb.TagNumber(16)
  $core.bool hasBatchHoldExpiryIntervalSeconds() => $_has(9);
  @$pb.TagNumber(16)
  void clearBatchHoldExpiryIntervalSeconds() => $_clearField(16);
}

class TransferAsyncConfig extends $pb.GeneratedMessage {
  factory TransferAsyncConfig({
    $core.bool? asyncExternalTransferEnabled,
    $core.bool? asyncBatchTransferEnabled,
    $core.String? flutterwaveWebhookUrl,
    $core.String? flutterwaveWebhookUrlUpdatedAt,
    $core.int? staleReconcilerIntervalSeconds,
    $core.int? rollbackProcessorIntervalSeconds,
    $core.int? holdExtensionIntervalSeconds,
    $core.int? batchSupervisorIntervalSeconds,
    $core.int? batchSettlementIntervalSeconds,
    $core.int? batchRollbackIntervalSeconds,
    $core.int? batchHoldExpiryIntervalSeconds,
  }) {
    final result = create();
    if (asyncExternalTransferEnabled != null)
      result.asyncExternalTransferEnabled = asyncExternalTransferEnabled;
    if (asyncBatchTransferEnabled != null)
      result.asyncBatchTransferEnabled = asyncBatchTransferEnabled;
    if (flutterwaveWebhookUrl != null)
      result.flutterwaveWebhookUrl = flutterwaveWebhookUrl;
    if (flutterwaveWebhookUrlUpdatedAt != null)
      result.flutterwaveWebhookUrlUpdatedAt = flutterwaveWebhookUrlUpdatedAt;
    if (staleReconcilerIntervalSeconds != null)
      result.staleReconcilerIntervalSeconds = staleReconcilerIntervalSeconds;
    if (rollbackProcessorIntervalSeconds != null)
      result.rollbackProcessorIntervalSeconds =
          rollbackProcessorIntervalSeconds;
    if (holdExtensionIntervalSeconds != null)
      result.holdExtensionIntervalSeconds = holdExtensionIntervalSeconds;
    if (batchSupervisorIntervalSeconds != null)
      result.batchSupervisorIntervalSeconds = batchSupervisorIntervalSeconds;
    if (batchSettlementIntervalSeconds != null)
      result.batchSettlementIntervalSeconds = batchSettlementIntervalSeconds;
    if (batchRollbackIntervalSeconds != null)
      result.batchRollbackIntervalSeconds = batchRollbackIntervalSeconds;
    if (batchHoldExpiryIntervalSeconds != null)
      result.batchHoldExpiryIntervalSeconds = batchHoldExpiryIntervalSeconds;
    return result;
  }

  TransferAsyncConfig._();

  factory TransferAsyncConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferAsyncConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferAsyncConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'asyncExternalTransferEnabled')
    ..aOB(2, _omitFieldNames ? '' : 'asyncBatchTransferEnabled')
    ..aOS(3, _omitFieldNames ? '' : 'flutterwaveWebhookUrl')
    ..aOS(4, _omitFieldNames ? '' : 'flutterwaveWebhookUrlUpdatedAt')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'staleReconcilerIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        11,
        _omitFieldNames ? '' : 'rollbackProcessorIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'holdExtensionIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'batchSupervisorIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'batchSettlementIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(15, _omitFieldNames ? '' : 'batchRollbackIntervalSeconds',
        $pb.PbFieldType.O3)
    ..a<$core.int>(16, _omitFieldNames ? '' : 'batchHoldExpiryIntervalSeconds',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferAsyncConfig clone() => TransferAsyncConfig()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferAsyncConfig copyWith(void Function(TransferAsyncConfig) updates) =>
      super.copyWith((message) => updates(message as TransferAsyncConfig))
          as TransferAsyncConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferAsyncConfig create() => TransferAsyncConfig._();
  @$core.override
  TransferAsyncConfig createEmptyInstance() => create();
  static $pb.PbList<TransferAsyncConfig> createRepeated() =>
      $pb.PbList<TransferAsyncConfig>();
  @$core.pragma('dart2js:noInline')
  static TransferAsyncConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferAsyncConfig>(create);
  static TransferAsyncConfig? _defaultInstance;

  /// Current configured values from system_settings.
  @$pb.TagNumber(1)
  $core.bool get asyncExternalTransferEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set asyncExternalTransferEnabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAsyncExternalTransferEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearAsyncExternalTransferEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get asyncBatchTransferEnabled => $_getBF(1);
  @$pb.TagNumber(2)
  set asyncBatchTransferEnabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAsyncBatchTransferEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearAsyncBatchTransferEnabled() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get flutterwaveWebhookUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set flutterwaveWebhookUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFlutterwaveWebhookUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlutterwaveWebhookUrl() => $_clearField(3);

  /// Display-only: when an operator last saved the URL. Helps ops
  /// see whether the URL in the Flutterwave dashboard is still aligned with
  /// the live tunnel.
  @$pb.TagNumber(4)
  $core.String get flutterwaveWebhookUrlUpdatedAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set flutterwaveWebhookUrlUpdatedAt($core.String value) =>
      $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFlutterwaveWebhookUrlUpdatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearFlutterwaveWebhookUrlUpdatedAt() => $_clearField(4);

  /// Worker tick intervals (seconds). All default to 3600 if no DB override.
  @$pb.TagNumber(10)
  $core.int get staleReconcilerIntervalSeconds => $_getIZ(4);
  @$pb.TagNumber(10)
  set staleReconcilerIntervalSeconds($core.int value) =>
      $_setSignedInt32(4, value);
  @$pb.TagNumber(10)
  $core.bool hasStaleReconcilerIntervalSeconds() => $_has(4);
  @$pb.TagNumber(10)
  void clearStaleReconcilerIntervalSeconds() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get rollbackProcessorIntervalSeconds => $_getIZ(5);
  @$pb.TagNumber(11)
  set rollbackProcessorIntervalSeconds($core.int value) =>
      $_setSignedInt32(5, value);
  @$pb.TagNumber(11)
  $core.bool hasRollbackProcessorIntervalSeconds() => $_has(5);
  @$pb.TagNumber(11)
  void clearRollbackProcessorIntervalSeconds() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get holdExtensionIntervalSeconds => $_getIZ(6);
  @$pb.TagNumber(12)
  set holdExtensionIntervalSeconds($core.int value) =>
      $_setSignedInt32(6, value);
  @$pb.TagNumber(12)
  $core.bool hasHoldExtensionIntervalSeconds() => $_has(6);
  @$pb.TagNumber(12)
  void clearHoldExtensionIntervalSeconds() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get batchSupervisorIntervalSeconds => $_getIZ(7);
  @$pb.TagNumber(13)
  set batchSupervisorIntervalSeconds($core.int value) =>
      $_setSignedInt32(7, value);
  @$pb.TagNumber(13)
  $core.bool hasBatchSupervisorIntervalSeconds() => $_has(7);
  @$pb.TagNumber(13)
  void clearBatchSupervisorIntervalSeconds() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get batchSettlementIntervalSeconds => $_getIZ(8);
  @$pb.TagNumber(14)
  set batchSettlementIntervalSeconds($core.int value) =>
      $_setSignedInt32(8, value);
  @$pb.TagNumber(14)
  $core.bool hasBatchSettlementIntervalSeconds() => $_has(8);
  @$pb.TagNumber(14)
  void clearBatchSettlementIntervalSeconds() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get batchRollbackIntervalSeconds => $_getIZ(9);
  @$pb.TagNumber(15)
  set batchRollbackIntervalSeconds($core.int value) =>
      $_setSignedInt32(9, value);
  @$pb.TagNumber(15)
  $core.bool hasBatchRollbackIntervalSeconds() => $_has(9);
  @$pb.TagNumber(15)
  void clearBatchRollbackIntervalSeconds() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get batchHoldExpiryIntervalSeconds => $_getIZ(10);
  @$pb.TagNumber(16)
  set batchHoldExpiryIntervalSeconds($core.int value) =>
      $_setSignedInt32(10, value);
  @$pb.TagNumber(16)
  $core.bool hasBatchHoldExpiryIntervalSeconds() => $_has(10);
  @$pb.TagNumber(16)
  void clearBatchHoldExpiryIntervalSeconds() => $_clearField(16);
}

class AdminForceRefundTransferRequest extends $pb.GeneratedMessage {
  factory AdminForceRefundTransferRequest({
    $core.String? reference,
    $core.String? reason,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdminForceRefundTransferRequest._();

  factory AdminForceRefundTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminForceRefundTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminForceRefundTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceRefundTransferRequest clone() =>
      AdminForceRefundTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceRefundTransferRequest copyWith(
          void Function(AdminForceRefundTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminForceRefundTransferRequest))
          as AdminForceRefundTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminForceRefundTransferRequest create() =>
      AdminForceRefundTransferRequest._();
  @$core.override
  AdminForceRefundTransferRequest createEmptyInstance() => create();
  static $pb.PbList<AdminForceRefundTransferRequest> createRepeated() =>
      $pb.PbList<AdminForceRefundTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminForceRefundTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminForceRefundTransferRequest>(
          create);
  static AdminForceRefundTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class AdminForceRefundTransferResponse extends $pb.GeneratedMessage {
  factory AdminForceRefundTransferResponse({
    $core.bool? success,
    $core.String? rollbackRecordId,
    $core.String? paymentId,
    $core.String? status,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (rollbackRecordId != null) result.rollbackRecordId = rollbackRecordId;
    if (paymentId != null) result.paymentId = paymentId;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  AdminForceRefundTransferResponse._();

  factory AdminForceRefundTransferResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminForceRefundTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminForceRefundTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'rollbackRecordId')
    ..aOS(3, _omitFieldNames ? '' : 'paymentId')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceRefundTransferResponse clone() =>
      AdminForceRefundTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceRefundTransferResponse copyWith(
          void Function(AdminForceRefundTransferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminForceRefundTransferResponse))
          as AdminForceRefundTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminForceRefundTransferResponse create() =>
      AdminForceRefundTransferResponse._();
  @$core.override
  AdminForceRefundTransferResponse createEmptyInstance() => create();
  static $pb.PbList<AdminForceRefundTransferResponse> createRepeated() =>
      $pb.PbList<AdminForceRefundTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminForceRefundTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminForceRefundTransferResponse>(
          create);
  static AdminForceRefundTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get rollbackRecordId => $_getSZ(1);
  @$pb.TagNumber(2)
  set rollbackRecordId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRollbackRecordId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRollbackRecordId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get paymentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPaymentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class AdminManualReconcileTransferRequest extends $pb.GeneratedMessage {
  factory AdminManualReconcileTransferRequest({
    $core.String? reference,
    $core.String? reason,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdminManualReconcileTransferRequest._();

  factory AdminManualReconcileTransferRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminManualReconcileTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminManualReconcileTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminManualReconcileTransferRequest clone() =>
      AdminManualReconcileTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminManualReconcileTransferRequest copyWith(
          void Function(AdminManualReconcileTransferRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminManualReconcileTransferRequest))
          as AdminManualReconcileTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminManualReconcileTransferRequest create() =>
      AdminManualReconcileTransferRequest._();
  @$core.override
  AdminManualReconcileTransferRequest createEmptyInstance() => create();
  static $pb.PbList<AdminManualReconcileTransferRequest> createRepeated() =>
      $pb.PbList<AdminManualReconcileTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminManualReconcileTransferRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminManualReconcileTransferRequest>(create);
  static AdminManualReconcileTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class AdminManualReconcileTransferResponse extends $pb.GeneratedMessage {
  factory AdminManualReconcileTransferResponse({
    $core.bool? success,
    $core.String? paymentId,
    $core.String? oldStatus,
    $core.String? newStatus,
    $core.String? providerStatus,
    $core.String? completeMessage,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (paymentId != null) result.paymentId = paymentId;
    if (oldStatus != null) result.oldStatus = oldStatus;
    if (newStatus != null) result.newStatus = newStatus;
    if (providerStatus != null) result.providerStatus = providerStatus;
    if (completeMessage != null) result.completeMessage = completeMessage;
    if (message != null) result.message = message;
    return result;
  }

  AdminManualReconcileTransferResponse._();

  factory AdminManualReconcileTransferResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminManualReconcileTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminManualReconcileTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'paymentId')
    ..aOS(3, _omitFieldNames ? '' : 'oldStatus')
    ..aOS(4, _omitFieldNames ? '' : 'newStatus')
    ..aOS(5, _omitFieldNames ? '' : 'providerStatus')
    ..aOS(6, _omitFieldNames ? '' : 'completeMessage')
    ..aOS(7, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminManualReconcileTransferResponse clone() =>
      AdminManualReconcileTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminManualReconcileTransferResponse copyWith(
          void Function(AdminManualReconcileTransferResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminManualReconcileTransferResponse))
          as AdminManualReconcileTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminManualReconcileTransferResponse create() =>
      AdminManualReconcileTransferResponse._();
  @$core.override
  AdminManualReconcileTransferResponse createEmptyInstance() => create();
  static $pb.PbList<AdminManualReconcileTransferResponse> createRepeated() =>
      $pb.PbList<AdminManualReconcileTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminManualReconcileTransferResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminManualReconcileTransferResponse>(create);
  static AdminManualReconcileTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get oldStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set oldStatus($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOldStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearOldStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get newStatus => $_getSZ(3);
  @$pb.TagNumber(4)
  set newStatus($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerStatus => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerStatus($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get completeMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set completeMessage($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCompleteMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompleteMessage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => $_clearField(7);
}

class AdminGetExternalTransferFeeAuditRequest extends $pb.GeneratedMessage {
  factory AdminGetExternalTransferFeeAuditRequest({
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  AdminGetExternalTransferFeeAuditRequest._();

  factory AdminGetExternalTransferFeeAuditRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetExternalTransferFeeAuditRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetExternalTransferFeeAuditRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetExternalTransferFeeAuditRequest clone() =>
      AdminGetExternalTransferFeeAuditRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetExternalTransferFeeAuditRequest copyWith(
          void Function(AdminGetExternalTransferFeeAuditRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminGetExternalTransferFeeAuditRequest))
          as AdminGetExternalTransferFeeAuditRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetExternalTransferFeeAuditRequest create() =>
      AdminGetExternalTransferFeeAuditRequest._();
  @$core.override
  AdminGetExternalTransferFeeAuditRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetExternalTransferFeeAuditRequest> createRepeated() =>
      $pb.PbList<AdminGetExternalTransferFeeAuditRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetExternalTransferFeeAuditRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminGetExternalTransferFeeAuditRequest>(create);
  static AdminGetExternalTransferFeeAuditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startDate => $_getSZ(0);
  @$pb.TagNumber(1)
  set startDate($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set endDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class ExternalTransferFeeAuditRow extends $pb.GeneratedMessage {
  factory ExternalTransferFeeAuditRow({
    $core.String? reference,
    $fixnum.Int64? amountMinor,
    $fixnum.Int64? estimateMinor,
    $fixnum.Int64? actualMinor,
    $fixnum.Int64? deltaMinor,
    $core.String? status,
    $core.String? createdAt,
    $core.bool? hasActual,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (estimateMinor != null) result.estimateMinor = estimateMinor;
    if (actualMinor != null) result.actualMinor = actualMinor;
    if (deltaMinor != null) result.deltaMinor = deltaMinor;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (hasActual != null) result.hasActual = hasActual;
    return result;
  }

  ExternalTransferFeeAuditRow._();

  factory ExternalTransferFeeAuditRow.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExternalTransferFeeAuditRow.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExternalTransferFeeAuditRow',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..aInt64(2, _omitFieldNames ? '' : 'amountMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'estimateMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'actualMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'deltaMinor')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'createdAt')
    ..aOB(8, _omitFieldNames ? '' : 'hasActual')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalTransferFeeAuditRow clone() =>
      ExternalTransferFeeAuditRow()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalTransferFeeAuditRow copyWith(
          void Function(ExternalTransferFeeAuditRow) updates) =>
      super.copyWith(
              (message) => updates(message as ExternalTransferFeeAuditRow))
          as ExternalTransferFeeAuditRow;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExternalTransferFeeAuditRow create() =>
      ExternalTransferFeeAuditRow._();
  @$core.override
  ExternalTransferFeeAuditRow createEmptyInstance() => create();
  static $pb.PbList<ExternalTransferFeeAuditRow> createRepeated() =>
      $pb.PbList<ExternalTransferFeeAuditRow>();
  @$core.pragma('dart2js:noInline')
  static ExternalTransferFeeAuditRow getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExternalTransferFeeAuditRow>(create);
  static ExternalTransferFeeAuditRow? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get estimateMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set estimateMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEstimateMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearEstimateMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get actualMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set actualMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActualMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearActualMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get deltaMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set deltaMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDeltaMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeltaMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get createdAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set createdAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get hasActual => $_getBF(7);
  @$pb.TagNumber(8)
  set hasActual($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasHasActual() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasActual() => $_clearField(8);
}

class ExternalTransferFeeAuditSummary extends $pb.GeneratedMessage {
  factory ExternalTransferFeeAuditSummary({
    $fixnum.Int64? count,
    $fixnum.Int64? withActualCount,
    $fixnum.Int64? totalEstimateMinor,
    $fixnum.Int64? totalActualMinor,
    $fixnum.Int64? totalOvercollectedMinor,
    $fixnum.Int64? totalUndercollectedMinor,
    $fixnum.Int64? netMinor,
  }) {
    final result = create();
    if (count != null) result.count = count;
    if (withActualCount != null) result.withActualCount = withActualCount;
    if (totalEstimateMinor != null)
      result.totalEstimateMinor = totalEstimateMinor;
    if (totalActualMinor != null) result.totalActualMinor = totalActualMinor;
    if (totalOvercollectedMinor != null)
      result.totalOvercollectedMinor = totalOvercollectedMinor;
    if (totalUndercollectedMinor != null)
      result.totalUndercollectedMinor = totalUndercollectedMinor;
    if (netMinor != null) result.netMinor = netMinor;
    return result;
  }

  ExternalTransferFeeAuditSummary._();

  factory ExternalTransferFeeAuditSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExternalTransferFeeAuditSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExternalTransferFeeAuditSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'count')
    ..aInt64(2, _omitFieldNames ? '' : 'withActualCount')
    ..aInt64(3, _omitFieldNames ? '' : 'totalEstimateMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'totalActualMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'totalOvercollectedMinor')
    ..aInt64(6, _omitFieldNames ? '' : 'totalUndercollectedMinor')
    ..aInt64(7, _omitFieldNames ? '' : 'netMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalTransferFeeAuditSummary clone() =>
      ExternalTransferFeeAuditSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalTransferFeeAuditSummary copyWith(
          void Function(ExternalTransferFeeAuditSummary) updates) =>
      super.copyWith(
              (message) => updates(message as ExternalTransferFeeAuditSummary))
          as ExternalTransferFeeAuditSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExternalTransferFeeAuditSummary create() =>
      ExternalTransferFeeAuditSummary._();
  @$core.override
  ExternalTransferFeeAuditSummary createEmptyInstance() => create();
  static $pb.PbList<ExternalTransferFeeAuditSummary> createRepeated() =>
      $pb.PbList<ExternalTransferFeeAuditSummary>();
  @$core.pragma('dart2js:noInline')
  static ExternalTransferFeeAuditSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExternalTransferFeeAuditSummary>(
          create);
  static ExternalTransferFeeAuditSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get count => $_getI64(0);
  @$pb.TagNumber(1)
  set count($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get withActualCount => $_getI64(1);
  @$pb.TagNumber(2)
  set withActualCount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWithActualCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearWithActualCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalEstimateMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set totalEstimateMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalEstimateMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalEstimateMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalActualMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set totalActualMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalActualMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalActualMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalOvercollectedMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set totalOvercollectedMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalOvercollectedMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalOvercollectedMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalUndercollectedMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set totalUndercollectedMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalUndercollectedMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalUndercollectedMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get netMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set netMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNetMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetMinor() => $_clearField(7);
}

class AdminGetExternalTransferFeeAuditResponse extends $pb.GeneratedMessage {
  factory AdminGetExternalTransferFeeAuditResponse({
    $core.Iterable<ExternalTransferFeeAuditRow>? rows,
    ExternalTransferFeeAuditSummary? summary,
  }) {
    final result = create();
    if (rows != null) result.rows.addAll(rows);
    if (summary != null) result.summary = summary;
    return result;
  }

  AdminGetExternalTransferFeeAuditResponse._();

  factory AdminGetExternalTransferFeeAuditResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetExternalTransferFeeAuditResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetExternalTransferFeeAuditResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<ExternalTransferFeeAuditRow>(
        1, _omitFieldNames ? '' : 'rows', $pb.PbFieldType.PM,
        subBuilder: ExternalTransferFeeAuditRow.create)
    ..aOM<ExternalTransferFeeAuditSummary>(2, _omitFieldNames ? '' : 'summary',
        subBuilder: ExternalTransferFeeAuditSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetExternalTransferFeeAuditResponse clone() =>
      AdminGetExternalTransferFeeAuditResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetExternalTransferFeeAuditResponse copyWith(
          void Function(AdminGetExternalTransferFeeAuditResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminGetExternalTransferFeeAuditResponse))
          as AdminGetExternalTransferFeeAuditResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetExternalTransferFeeAuditResponse create() =>
      AdminGetExternalTransferFeeAuditResponse._();
  @$core.override
  AdminGetExternalTransferFeeAuditResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetExternalTransferFeeAuditResponse>
      createRepeated() =>
          $pb.PbList<AdminGetExternalTransferFeeAuditResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetExternalTransferFeeAuditResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminGetExternalTransferFeeAuditResponse>(create);
  static AdminGetExternalTransferFeeAuditResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ExternalTransferFeeAuditRow> get rows => $_getList(0);

  @$pb.TagNumber(2)
  ExternalTransferFeeAuditSummary get summary => $_getN(1);
  @$pb.TagNumber(2)
  set summary(ExternalTransferFeeAuditSummary value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => $_clearField(2);
  @$pb.TagNumber(2)
  ExternalTransferFeeAuditSummary ensureSummary() => $_ensure(1);
}

class GetTransferSuccessPredictionRequest extends $pb.GeneratedMessage {
  factory GetTransferSuccessPredictionRequest({
    $core.String? bankCode,
    $core.String? accountNumber,
  }) {
    final result = create();
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    return result;
  }

  GetTransferSuccessPredictionRequest._();

  factory GetTransferSuccessPredictionRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferSuccessPredictionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferSuccessPredictionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bankCode')
    ..aOS(2, _omitFieldNames ? '' : 'accountNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferSuccessPredictionRequest clone() =>
      GetTransferSuccessPredictionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferSuccessPredictionRequest copyWith(
          void Function(GetTransferSuccessPredictionRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetTransferSuccessPredictionRequest))
          as GetTransferSuccessPredictionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferSuccessPredictionRequest create() =>
      GetTransferSuccessPredictionRequest._();
  @$core.override
  GetTransferSuccessPredictionRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferSuccessPredictionRequest> createRepeated() =>
      $pb.PbList<GetTransferSuccessPredictionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferSuccessPredictionRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTransferSuccessPredictionRequest>(create);
  static GetTransferSuccessPredictionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bankCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set bankCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBankCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBankCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => $_clearField(2);
}

class GetTransferSuccessPredictionResponse extends $pb.GeneratedMessage {
  factory GetTransferSuccessPredictionResponse({
    $core.int? bankAvailabilityPct,
    $core.String? bankBand,
    $core.int? bankSampleSize,
    $core.String? recipientTrustBand,
    $core.int? priorTransferCount,
    $fixnum.Int64? recipientKnownSinceUnix,
    $core.bool? blocklisted,
  }) {
    final result = create();
    if (bankAvailabilityPct != null)
      result.bankAvailabilityPct = bankAvailabilityPct;
    if (bankBand != null) result.bankBand = bankBand;
    if (bankSampleSize != null) result.bankSampleSize = bankSampleSize;
    if (recipientTrustBand != null)
      result.recipientTrustBand = recipientTrustBand;
    if (priorTransferCount != null)
      result.priorTransferCount = priorTransferCount;
    if (recipientKnownSinceUnix != null)
      result.recipientKnownSinceUnix = recipientKnownSinceUnix;
    if (blocklisted != null) result.blocklisted = blocklisted;
    return result;
  }

  GetTransferSuccessPredictionResponse._();

  factory GetTransferSuccessPredictionResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferSuccessPredictionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferSuccessPredictionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'bankAvailabilityPct', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'bankBand')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'bankSampleSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'recipientTrustBand')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'priorTransferCount', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'recipientKnownSinceUnix')
    ..aOB(7, _omitFieldNames ? '' : 'blocklisted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferSuccessPredictionResponse clone() =>
      GetTransferSuccessPredictionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferSuccessPredictionResponse copyWith(
          void Function(GetTransferSuccessPredictionResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTransferSuccessPredictionResponse))
          as GetTransferSuccessPredictionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferSuccessPredictionResponse create() =>
      GetTransferSuccessPredictionResponse._();
  @$core.override
  GetTransferSuccessPredictionResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferSuccessPredictionResponse> createRepeated() =>
      $pb.PbList<GetTransferSuccessPredictionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferSuccessPredictionResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTransferSuccessPredictionResponse>(create);
  static GetTransferSuccessPredictionResponse? _defaultInstance;

  /// Bank availability: rolling-window success rate to this destination bank.
  @$pb.TagNumber(1)
  $core.int get bankAvailabilityPct => $_getIZ(0);
  @$pb.TagNumber(1)
  set bankAvailabilityPct($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBankAvailabilityPct() => $_has(0);
  @$pb.TagNumber(1)
  void clearBankAvailabilityPct() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankBand => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankBand($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankBand() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankBand() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get bankSampleSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set bankSampleSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankSampleSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankSampleSize() => $_clearField(3);

  /// Recipient trust: prior successful transfers to this (bank, account).
  @$pb.TagNumber(4)
  $core.String get recipientTrustBand => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientTrustBand($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientTrustBand() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientTrustBand() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get priorTransferCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set priorTransferCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriorTransferCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriorTransferCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get recipientKnownSinceUnix => $_getI64(5);
  @$pb.TagNumber(6)
  set recipientKnownSinceUnix($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientKnownSinceUnix() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientKnownSinceUnix() => $_clearField(6);

  /// Fraud signal.
  @$pb.TagNumber(7)
  $core.bool get blocklisted => $_getBF(6);
  @$pb.TagNumber(7)
  set blocklisted($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBlocklisted() => $_has(6);
  @$pb.TagNumber(7)
  void clearBlocklisted() => $_clearField(7);
}

class SavedBatchItemInput extends $pb.GeneratedMessage {
  factory SavedBatchItemInput({
    $core.String? recipientType,
    $core.String? recipientUserId,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? beneficiaryName,
    $core.double? amount,
    $core.String? narration,
    $core.int? sortOrder,
  }) {
    final result = create();
    if (recipientType != null) result.recipientType = recipientType;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (beneficiaryName != null) result.beneficiaryName = beneficiaryName;
    if (amount != null) result.amount = amount;
    if (narration != null) result.narration = narration;
    if (sortOrder != null) result.sortOrder = sortOrder;
    return result;
  }

  SavedBatchItemInput._();

  factory SavedBatchItemInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SavedBatchItemInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SavedBatchItemInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipientType')
    ..aOS(2, _omitFieldNames ? '' : 'recipientUserId')
    ..aOS(3, _omitFieldNames ? '' : 'bankCode')
    ..aOS(4, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'beneficiaryName')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'narration')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'sortOrder', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavedBatchItemInput clone() => SavedBatchItemInput()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavedBatchItemInput copyWith(void Function(SavedBatchItemInput) updates) =>
      super.copyWith((message) => updates(message as SavedBatchItemInput))
          as SavedBatchItemInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SavedBatchItemInput create() => SavedBatchItemInput._();
  @$core.override
  SavedBatchItemInput createEmptyInstance() => create();
  static $pb.PbList<SavedBatchItemInput> createRepeated() =>
      $pb.PbList<SavedBatchItemInput>();
  @$core.pragma('dart2js:noInline')
  static SavedBatchItemInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SavedBatchItemInput>(create);
  static SavedBatchItemInput? _defaultInstance;

  /// Free-form recipient category. Mirrors models.SavedBatchRecipient*:
  /// "internal_lazervault" | "external_bank" | "tagpay" | "contact".
  /// Used by the executor to route each item correctly. Defaults to
  /// "external_bank" if blank.
  @$pb.TagNumber(1)
  $core.String get recipientType => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientType() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecipientUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get beneficiaryName => $_getSZ(4);
  @$pb.TagNumber(5)
  set beneficiaryName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBeneficiaryName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBeneficiaryName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get narration => $_getSZ(6);
  @$pb.TagNumber(7)
  set narration($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNarration() => $_has(6);
  @$pb.TagNumber(7)
  void clearNarration() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get sortOrder => $_getIZ(7);
  @$pb.TagNumber(8)
  set sortOrder($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSortOrder() => $_has(7);
  @$pb.TagNumber(8)
  void clearSortOrder() => $_clearField(8);
}

class SavedBatchItem extends $pb.GeneratedMessage {
  factory SavedBatchItem({
    $core.String? id,
    $core.String? savedBatchId,
    $core.String? recipientType,
    $core.String? recipientUserId,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? beneficiaryName,
    $core.double? amount,
    $core.String? narration,
    $core.int? sortOrder,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (savedBatchId != null) result.savedBatchId = savedBatchId;
    if (recipientType != null) result.recipientType = recipientType;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (beneficiaryName != null) result.beneficiaryName = beneficiaryName;
    if (amount != null) result.amount = amount;
    if (narration != null) result.narration = narration;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SavedBatchItem._();

  factory SavedBatchItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SavedBatchItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SavedBatchItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'savedBatchId')
    ..aOS(3, _omitFieldNames ? '' : 'recipientType')
    ..aOS(4, _omitFieldNames ? '' : 'recipientUserId')
    ..aOS(5, _omitFieldNames ? '' : 'bankCode')
    ..aOS(6, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'beneficiaryName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'narration')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'sortOrder', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavedBatchItem clone() => SavedBatchItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavedBatchItem copyWith(void Function(SavedBatchItem) updates) =>
      super.copyWith((message) => updates(message as SavedBatchItem))
          as SavedBatchItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SavedBatchItem create() => SavedBatchItem._();
  @$core.override
  SavedBatchItem createEmptyInstance() => create();
  static $pb.PbList<SavedBatchItem> createRepeated() =>
      $pb.PbList<SavedBatchItem>();
  @$core.pragma('dart2js:noInline')
  static SavedBatchItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SavedBatchItem>(create);
  static SavedBatchItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get savedBatchId => $_getSZ(1);
  @$pb.TagNumber(2)
  set savedBatchId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSavedBatchId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSavedBatchId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientType => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientType() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get beneficiaryName => $_getSZ(6);
  @$pb.TagNumber(7)
  set beneficiaryName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBeneficiaryName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBeneficiaryName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get narration => $_getSZ(8);
  @$pb.TagNumber(9)
  set narration($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNarration() => $_has(8);
  @$pb.TagNumber(9)
  void clearNarration() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get sortOrder => $_getIZ(9);
  @$pb.TagNumber(10)
  set sortOrder($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSortOrder() => $_has(9);
  @$pb.TagNumber(10)
  void clearSortOrder() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get updatedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set updatedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
}

class SavedBatch extends $pb.GeneratedMessage {
  factory SavedBatch({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.String? currency,
    $core.String? sourceAccountId,
    $core.double? totalAmount,
    $core.int? itemCount,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<SavedBatchItem>? items,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (currency != null) result.currency = currency;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (itemCount != null) result.itemCount = itemCount;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (items != null) result.items.addAll(items);
    return result;
  }

  SavedBatch._();

  factory SavedBatch.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SavedBatch.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SavedBatch',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'sourceAccountId')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'itemCount', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..pc<SavedBatchItem>(10, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: SavedBatchItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavedBatch clone() => SavedBatch()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavedBatch copyWith(void Function(SavedBatch) updates) =>
      super.copyWith((message) => updates(message as SavedBatch)) as SavedBatch;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SavedBatch create() => SavedBatch._();
  @$core.override
  SavedBatch createEmptyInstance() => create();
  static $pb.PbList<SavedBatch> createRepeated() => $pb.PbList<SavedBatch>();
  @$core.pragma('dart2js:noInline')
  static SavedBatch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SavedBatch>(create);
  static SavedBatch? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalAmount => $_getN(5);
  @$pb.TagNumber(6)
  set totalAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get itemCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set itemCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasItemCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearItemCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<SavedBatchItem> get items => $_getList(9);
}

class SaveBatchDraftRequest extends $pb.GeneratedMessage {
  factory SaveBatchDraftRequest({
    $core.String? name,
    $core.String? currency,
    $core.String? sourceAccountId,
    $core.Iterable<SavedBatchItemInput>? items,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (currency != null) result.currency = currency;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (items != null) result.items.addAll(items);
    return result;
  }

  SaveBatchDraftRequest._();

  factory SaveBatchDraftRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveBatchDraftRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveBatchDraftRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..pc<SavedBatchItemInput>(
        4, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: SavedBatchItemInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveBatchDraftRequest clone() =>
      SaveBatchDraftRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveBatchDraftRequest copyWith(
          void Function(SaveBatchDraftRequest) updates) =>
      super.copyWith((message) => updates(message as SaveBatchDraftRequest))
          as SaveBatchDraftRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveBatchDraftRequest create() => SaveBatchDraftRequest._();
  @$core.override
  SaveBatchDraftRequest createEmptyInstance() => create();
  static $pb.PbList<SaveBatchDraftRequest> createRepeated() =>
      $pb.PbList<SaveBatchDraftRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveBatchDraftRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveBatchDraftRequest>(create);
  static SaveBatchDraftRequest? _defaultInstance;

  /// Name is optional — most clients fill this with a friendly label.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<SavedBatchItemInput> get items => $_getList(3);
}

class ListSavedBatchesRequest extends $pb.GeneratedMessage {
  factory ListSavedBatchesRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  ListSavedBatchesRequest._();

  factory ListSavedBatchesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSavedBatchesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSavedBatchesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSavedBatchesRequest clone() =>
      ListSavedBatchesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSavedBatchesRequest copyWith(
          void Function(ListSavedBatchesRequest) updates) =>
      super.copyWith((message) => updates(message as ListSavedBatchesRequest))
          as ListSavedBatchesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesRequest create() => ListSavedBatchesRequest._();
  @$core.override
  ListSavedBatchesRequest createEmptyInstance() => create();
  static $pb.PbList<ListSavedBatchesRequest> createRepeated() =>
      $pb.PbList<ListSavedBatchesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSavedBatchesRequest>(create);
  static ListSavedBatchesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);
}

class ListSavedBatchesResponse extends $pb.GeneratedMessage {
  factory ListSavedBatchesResponse({
    $core.Iterable<SavedBatch>? batches,
    $fixnum.Int64? total,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (batches != null) result.batches.addAll(batches);
    if (total != null) result.total = total;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  ListSavedBatchesResponse._();

  factory ListSavedBatchesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSavedBatchesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSavedBatchesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..pc<SavedBatch>(1, _omitFieldNames ? '' : 'batches', $pb.PbFieldType.PM,
        subBuilder: SavedBatch.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSavedBatchesResponse clone() =>
      ListSavedBatchesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSavedBatchesResponse copyWith(
          void Function(ListSavedBatchesResponse) updates) =>
      super.copyWith((message) => updates(message as ListSavedBatchesResponse))
          as ListSavedBatchesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesResponse create() => ListSavedBatchesResponse._();
  @$core.override
  ListSavedBatchesResponse createEmptyInstance() => create();
  static $pb.PbList<ListSavedBatchesResponse> createRepeated() =>
      $pb.PbList<ListSavedBatchesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSavedBatchesResponse>(create);
  static ListSavedBatchesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SavedBatch> get batches => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class GetSavedBatchRequest extends $pb.GeneratedMessage {
  factory GetSavedBatchRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetSavedBatchRequest._();

  factory GetSavedBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSavedBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSavedBatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSavedBatchRequest clone() =>
      GetSavedBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSavedBatchRequest copyWith(void Function(GetSavedBatchRequest) updates) =>
      super.copyWith((message) => updates(message as GetSavedBatchRequest))
          as GetSavedBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSavedBatchRequest create() => GetSavedBatchRequest._();
  @$core.override
  GetSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<GetSavedBatchRequest> createRepeated() =>
      $pb.PbList<GetSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSavedBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSavedBatchRequest>(create);
  static GetSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class UpdateSavedBatchRequest extends $pb.GeneratedMessage {
  factory UpdateSavedBatchRequest({
    $core.String? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  UpdateSavedBatchRequest._();

  factory UpdateSavedBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSavedBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSavedBatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSavedBatchRequest clone() =>
      UpdateSavedBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSavedBatchRequest copyWith(
          void Function(UpdateSavedBatchRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateSavedBatchRequest))
          as UpdateSavedBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchRequest create() => UpdateSavedBatchRequest._();
  @$core.override
  UpdateSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSavedBatchRequest> createRepeated() =>
      $pb.PbList<UpdateSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSavedBatchRequest>(create);
  static UpdateSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class DeleteSavedBatchRequest extends $pb.GeneratedMessage {
  factory DeleteSavedBatchRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteSavedBatchRequest._();

  factory DeleteSavedBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteSavedBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteSavedBatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSavedBatchRequest clone() =>
      DeleteSavedBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSavedBatchRequest copyWith(
          void Function(DeleteSavedBatchRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteSavedBatchRequest))
          as DeleteSavedBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchRequest create() => DeleteSavedBatchRequest._();
  @$core.override
  DeleteSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteSavedBatchRequest> createRepeated() =>
      $pb.PbList<DeleteSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteSavedBatchRequest>(create);
  static DeleteSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class DeleteSavedBatchResponse extends $pb.GeneratedMessage {
  factory DeleteSavedBatchResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  DeleteSavedBatchResponse._();

  factory DeleteSavedBatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteSavedBatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteSavedBatchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSavedBatchResponse clone() =>
      DeleteSavedBatchResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSavedBatchResponse copyWith(
          void Function(DeleteSavedBatchResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteSavedBatchResponse))
          as DeleteSavedBatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchResponse create() => DeleteSavedBatchResponse._();
  @$core.override
  DeleteSavedBatchResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteSavedBatchResponse> createRepeated() =>
      $pb.PbList<DeleteSavedBatchResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteSavedBatchResponse>(create);
  static DeleteSavedBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AddSavedBatchItemRequest extends $pb.GeneratedMessage {
  factory AddSavedBatchItemRequest({
    $core.String? savedBatchId,
    SavedBatchItemInput? item,
  }) {
    final result = create();
    if (savedBatchId != null) result.savedBatchId = savedBatchId;
    if (item != null) result.item = item;
    return result;
  }

  AddSavedBatchItemRequest._();

  factory AddSavedBatchItemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddSavedBatchItemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddSavedBatchItemRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'savedBatchId')
    ..aOM<SavedBatchItemInput>(2, _omitFieldNames ? '' : 'item',
        subBuilder: SavedBatchItemInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSavedBatchItemRequest clone() =>
      AddSavedBatchItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSavedBatchItemRequest copyWith(
          void Function(AddSavedBatchItemRequest) updates) =>
      super.copyWith((message) => updates(message as AddSavedBatchItemRequest))
          as AddSavedBatchItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSavedBatchItemRequest create() => AddSavedBatchItemRequest._();
  @$core.override
  AddSavedBatchItemRequest createEmptyInstance() => create();
  static $pb.PbList<AddSavedBatchItemRequest> createRepeated() =>
      $pb.PbList<AddSavedBatchItemRequest>();
  @$core.pragma('dart2js:noInline')
  static AddSavedBatchItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddSavedBatchItemRequest>(create);
  static AddSavedBatchItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSavedBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavedBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  SavedBatchItemInput get item => $_getN(1);
  @$pb.TagNumber(2)
  set item(SavedBatchItemInput value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasItem() => $_has(1);
  @$pb.TagNumber(2)
  void clearItem() => $_clearField(2);
  @$pb.TagNumber(2)
  SavedBatchItemInput ensureItem() => $_ensure(1);
}

class RemoveSavedBatchItemRequest extends $pb.GeneratedMessage {
  factory RemoveSavedBatchItemRequest({
    $core.String? savedBatchId,
    $core.String? itemId,
  }) {
    final result = create();
    if (savedBatchId != null) result.savedBatchId = savedBatchId;
    if (itemId != null) result.itemId = itemId;
    return result;
  }

  RemoveSavedBatchItemRequest._();

  factory RemoveSavedBatchItemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveSavedBatchItemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveSavedBatchItemRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'savedBatchId')
    ..aOS(2, _omitFieldNames ? '' : 'itemId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSavedBatchItemRequest clone() =>
      RemoveSavedBatchItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSavedBatchItemRequest copyWith(
          void Function(RemoveSavedBatchItemRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveSavedBatchItemRequest))
          as RemoveSavedBatchItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSavedBatchItemRequest create() =>
      RemoveSavedBatchItemRequest._();
  @$core.override
  RemoveSavedBatchItemRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveSavedBatchItemRequest> createRepeated() =>
      $pb.PbList<RemoveSavedBatchItemRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveSavedBatchItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveSavedBatchItemRequest>(create);
  static RemoveSavedBatchItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSavedBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavedBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemId() => $_clearField(2);
}

class UpdateSavedBatchItemAmountRequest extends $pb.GeneratedMessage {
  factory UpdateSavedBatchItemAmountRequest({
    $core.String? savedBatchId,
    $core.String? itemId,
    $core.double? amount,
  }) {
    final result = create();
    if (savedBatchId != null) result.savedBatchId = savedBatchId;
    if (itemId != null) result.itemId = itemId;
    if (amount != null) result.amount = amount;
    return result;
  }

  UpdateSavedBatchItemAmountRequest._();

  factory UpdateSavedBatchItemAmountRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSavedBatchItemAmountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSavedBatchItemAmountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'savedBatchId')
    ..aOS(2, _omitFieldNames ? '' : 'itemId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSavedBatchItemAmountRequest clone() =>
      UpdateSavedBatchItemAmountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSavedBatchItemAmountRequest copyWith(
          void Function(UpdateSavedBatchItemAmountRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateSavedBatchItemAmountRequest))
          as UpdateSavedBatchItemAmountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchItemAmountRequest create() =>
      UpdateSavedBatchItemAmountRequest._();
  @$core.override
  UpdateSavedBatchItemAmountRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSavedBatchItemAmountRequest> createRepeated() =>
      $pb.PbList<UpdateSavedBatchItemAmountRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchItemAmountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSavedBatchItemAmountRequest>(
          create);
  static UpdateSavedBatchItemAmountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSavedBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavedBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
}

enum ApplyCollectiveAmountRequest_Mode { multiplier, amountPerItem, notSet }

class ApplyCollectiveAmountRequest extends $pb.GeneratedMessage {
  factory ApplyCollectiveAmountRequest({
    $core.String? savedBatchId,
    $core.double? multiplier,
    $core.double? amountPerItem,
  }) {
    final result = create();
    if (savedBatchId != null) result.savedBatchId = savedBatchId;
    if (multiplier != null) result.multiplier = multiplier;
    if (amountPerItem != null) result.amountPerItem = amountPerItem;
    return result;
  }

  ApplyCollectiveAmountRequest._();

  factory ApplyCollectiveAmountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApplyCollectiveAmountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ApplyCollectiveAmountRequest_Mode>
      _ApplyCollectiveAmountRequest_ModeByTag = {
    2: ApplyCollectiveAmountRequest_Mode.multiplier,
    3: ApplyCollectiveAmountRequest_Mode.amountPerItem,
    0: ApplyCollectiveAmountRequest_Mode.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApplyCollectiveAmountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'savedBatchId')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'multiplier', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'amountPerItem', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApplyCollectiveAmountRequest clone() =>
      ApplyCollectiveAmountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApplyCollectiveAmountRequest copyWith(
          void Function(ApplyCollectiveAmountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ApplyCollectiveAmountRequest))
          as ApplyCollectiveAmountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApplyCollectiveAmountRequest create() =>
      ApplyCollectiveAmountRequest._();
  @$core.override
  ApplyCollectiveAmountRequest createEmptyInstance() => create();
  static $pb.PbList<ApplyCollectiveAmountRequest> createRepeated() =>
      $pb.PbList<ApplyCollectiveAmountRequest>();
  @$core.pragma('dart2js:noInline')
  static ApplyCollectiveAmountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApplyCollectiveAmountRequest>(create);
  static ApplyCollectiveAmountRequest? _defaultInstance;

  ApplyCollectiveAmountRequest_Mode whichMode() =>
      _ApplyCollectiveAmountRequest_ModeByTag[$_whichOneof(0)]!;
  void clearMode() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSavedBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavedBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get multiplier => $_getN(1);
  @$pb.TagNumber(2)
  set multiplier($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMultiplier() => $_has(1);
  @$pb.TagNumber(2)
  void clearMultiplier() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amountPerItem => $_getN(2);
  @$pb.TagNumber(3)
  set amountPerItem($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountPerItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountPerItem() => $_clearField(3);
}

class ExecuteFromSavedBatchRequest extends $pb.GeneratedMessage {
  factory ExecuteFromSavedBatchRequest({
    $core.String? savedBatchId,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>?
        perItemOverrides,
    $core.String? sourceAccountId,
  }) {
    final result = create();
    if (savedBatchId != null) result.savedBatchId = savedBatchId;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (perItemOverrides != null)
      result.perItemOverrides.addEntries(perItemOverrides);
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    return result;
  }

  ExecuteFromSavedBatchRequest._();

  factory ExecuteFromSavedBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecuteFromSavedBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecuteFromSavedBatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'savedBatchId')
    ..aOS(2, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..m<$core.String, $core.double>(
        5, _omitFieldNames ? '' : 'perItemOverrides',
        entryClassName: 'ExecuteFromSavedBatchRequest.PerItemOverridesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('payments'))
    ..aOS(6, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecuteFromSavedBatchRequest clone() =>
      ExecuteFromSavedBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecuteFromSavedBatchRequest copyWith(
          void Function(ExecuteFromSavedBatchRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ExecuteFromSavedBatchRequest))
          as ExecuteFromSavedBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecuteFromSavedBatchRequest create() =>
      ExecuteFromSavedBatchRequest._();
  @$core.override
  ExecuteFromSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<ExecuteFromSavedBatchRequest> createRepeated() =>
      $pb.PbList<ExecuteFromSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static ExecuteFromSavedBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecuteFromSavedBatchRequest>(create);
  static ExecuteFromSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSavedBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavedBatchId() => $_clearField(1);

  /// Required: idempotency_key is forwarded into the BatchTransfer path so a
  /// double-tap on the Execute button can never charge twice.
  @$pb.TagNumber(2)
  $core.String get idempotencyKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set idempotencyKey($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdempotencyKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdempotencyKey() => $_clearField(2);

  /// Transaction-PIN verification, same shape as BatchTransferRequest.
  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => $_clearField(4);

  /// Optional: override per-item amounts at execute time (keyed by item_id).
  /// Items not in the map use the saved amount. Unknown ids are ignored.
  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.double> get perItemOverrides => $_getMap(4);

  /// Optional: override the source account. If unset, the active account
  /// from context (x-account-id) is used — same convention as BatchTransfer.
  @$pb.TagNumber(6)
  $core.String get sourceAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountId() => $_clearField(6);
}

class BatchReceiptItem extends $pb.GeneratedMessage {
  factory BatchReceiptItem({
    $core.String? itemId,
    $core.String? status,
    $core.double? amount,
    $core.double? fee,
    $core.String? currency,
    $core.String? reference,
    $core.String? recipientName,
    $core.String? recipientAccount,
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? transferType,
    $core.String? narration,
    $core.String? failureReason,
    $core.String? classification,
    $core.String? providerName,
    $core.String? providerRef,
    $core.String? providerStatus,
    $core.String? paymentId,
    $core.String? paymentStatus,
    $core.String? paymentReference,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? transactionDate,
    $core.String? holdCapturedAt,
    $core.String? holdReleasedAt,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientAccount != null) result.recipientAccount = recipientAccount;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (transferType != null) result.transferType = transferType;
    if (narration != null) result.narration = narration;
    if (failureReason != null) result.failureReason = failureReason;
    if (classification != null) result.classification = classification;
    if (providerName != null) result.providerName = providerName;
    if (providerRef != null) result.providerRef = providerRef;
    if (providerStatus != null) result.providerStatus = providerStatus;
    if (paymentId != null) result.paymentId = paymentId;
    if (paymentStatus != null) result.paymentStatus = paymentStatus;
    if (paymentReference != null) result.paymentReference = paymentReference;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (holdCapturedAt != null) result.holdCapturedAt = holdCapturedAt;
    if (holdReleasedAt != null) result.holdReleasedAt = holdReleasedAt;
    return result;
  }

  BatchReceiptItem._();

  factory BatchReceiptItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchReceiptItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchReceiptItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..aOS(7, _omitFieldNames ? '' : 'recipientName')
    ..aOS(8, _omitFieldNames ? '' : 'recipientAccount')
    ..aOS(9, _omitFieldNames ? '' : 'bankCode')
    ..aOS(10, _omitFieldNames ? '' : 'bankName')
    ..aOS(11, _omitFieldNames ? '' : 'transferType')
    ..aOS(12, _omitFieldNames ? '' : 'narration')
    ..aOS(13, _omitFieldNames ? '' : 'failureReason')
    ..aOS(14, _omitFieldNames ? '' : 'classification')
    ..aOS(15, _omitFieldNames ? '' : 'providerName')
    ..aOS(16, _omitFieldNames ? '' : 'providerRef')
    ..aOS(17, _omitFieldNames ? '' : 'providerStatus')
    ..aOS(18, _omitFieldNames ? '' : 'paymentId')
    ..aOS(19, _omitFieldNames ? '' : 'paymentStatus')
    ..aOS(20, _omitFieldNames ? '' : 'paymentReference')
    ..aOS(21, _omitFieldNames ? '' : 'createdAt')
    ..aOS(22, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(23, _omitFieldNames ? '' : 'transactionDate')
    ..aOS(24, _omitFieldNames ? '' : 'holdCapturedAt')
    ..aOS(25, _omitFieldNames ? '' : 'holdReleasedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchReceiptItem clone() => BatchReceiptItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchReceiptItem copyWith(void Function(BatchReceiptItem) updates) =>
      super.copyWith((message) => updates(message as BatchReceiptItem))
          as BatchReceiptItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchReceiptItem create() => BatchReceiptItem._();
  @$core.override
  BatchReceiptItem createEmptyInstance() => create();
  static $pb.PbList<BatchReceiptItem> createRepeated() =>
      $pb.PbList<BatchReceiptItem>();
  @$core.pragma('dart2js:noInline')
  static BatchReceiptItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchReceiptItem>(create);
  static BatchReceiptItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get fee => $_getN(3);
  @$pb.TagNumber(4)
  set fee($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientName => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get recipientAccount => $_getSZ(7);
  @$pb.TagNumber(8)
  set recipientAccount($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRecipientAccount() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipientAccount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankCode($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBankCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankCode() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get bankName => $_getSZ(9);
  @$pb.TagNumber(10)
  set bankName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBankName() => $_has(9);
  @$pb.TagNumber(10)
  void clearBankName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get transferType => $_getSZ(10);
  @$pb.TagNumber(11)
  set transferType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTransferType() => $_has(10);
  @$pb.TagNumber(11)
  void clearTransferType() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get narration => $_getSZ(11);
  @$pb.TagNumber(12)
  set narration($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNarration() => $_has(11);
  @$pb.TagNumber(12)
  void clearNarration() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get failureReason => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureReason($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFailureReason() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureReason() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get classification => $_getSZ(13);
  @$pb.TagNumber(14)
  set classification($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasClassification() => $_has(13);
  @$pb.TagNumber(14)
  void clearClassification() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerName => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerName($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProviderName() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderName() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get providerRef => $_getSZ(15);
  @$pb.TagNumber(16)
  set providerRef($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProviderRef() => $_has(15);
  @$pb.TagNumber(16)
  void clearProviderRef() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerStatus => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerStatus($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasProviderStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderStatus() => $_clearField(17);

  /// Payment row (when item produced a payments row via the executor).
  @$pb.TagNumber(18)
  $core.String get paymentId => $_getSZ(17);
  @$pb.TagNumber(18)
  set paymentId($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPaymentId() => $_has(17);
  @$pb.TagNumber(18)
  void clearPaymentId() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get paymentStatus => $_getSZ(18);
  @$pb.TagNumber(19)
  set paymentStatus($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPaymentStatus() => $_has(18);
  @$pb.TagNumber(19)
  void clearPaymentStatus() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get paymentReference => $_getSZ(19);
  @$pb.TagNumber(20)
  set paymentReference($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasPaymentReference() => $_has(19);
  @$pb.TagNumber(20)
  void clearPaymentReference() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set createdAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get updatedAt => $_getSZ(21);
  @$pb.TagNumber(22)
  set updatedAt($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get transactionDate => $_getSZ(22);
  @$pb.TagNumber(23)
  set transactionDate($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasTransactionDate() => $_has(22);
  @$pb.TagNumber(23)
  void clearTransactionDate() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get holdCapturedAt => $_getSZ(23);
  @$pb.TagNumber(24)
  set holdCapturedAt($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasHoldCapturedAt() => $_has(23);
  @$pb.TagNumber(24)
  void clearHoldCapturedAt() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get holdReleasedAt => $_getSZ(24);
  @$pb.TagNumber(25)
  set holdReleasedAt($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasHoldReleasedAt() => $_has(24);
  @$pb.TagNumber(25)
  void clearHoldReleasedAt() => $_clearField(25);
}

class BatchReceipt extends $pb.GeneratedMessage {
  factory BatchReceipt({
    $core.String? batchId,
    $core.String? userId,
    $core.String? status,
    $core.String? currency,
    $core.int? totalTransfers,
    $core.int? successfulTransfers,
    $core.int? failedTransfers,
    $core.double? totalAmount,
    $core.double? totalFees,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? finalizedAt,
    $core.String? sourceAccountId,
    $core.String? sourceAccountNumber,
    $core.String? sourceAccountName,
    $core.Iterable<BatchReceiptItem>? items,
  }) {
    final result = create();
    if (batchId != null) result.batchId = batchId;
    if (userId != null) result.userId = userId;
    if (status != null) result.status = status;
    if (currency != null) result.currency = currency;
    if (totalTransfers != null) result.totalTransfers = totalTransfers;
    if (successfulTransfers != null)
      result.successfulTransfers = successfulTransfers;
    if (failedTransfers != null) result.failedTransfers = failedTransfers;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (totalFees != null) result.totalFees = totalFees;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (finalizedAt != null) result.finalizedAt = finalizedAt;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (sourceAccountNumber != null)
      result.sourceAccountNumber = sourceAccountNumber;
    if (sourceAccountName != null) result.sourceAccountName = sourceAccountName;
    if (items != null) result.items.addAll(items);
    return result;
  }

  BatchReceipt._();

  factory BatchReceipt.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchReceipt.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchReceipt',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'batchId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'totalTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'successfulTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'failedTransfers', $pb.PbFieldType.O3)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'totalFees', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(12, _omitFieldNames ? '' : 'finalizedAt')
    ..aOS(13, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(14, _omitFieldNames ? '' : 'sourceAccountNumber')
    ..aOS(15, _omitFieldNames ? '' : 'sourceAccountName')
    ..pc<BatchReceiptItem>(
        20, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: BatchReceiptItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchReceipt clone() => BatchReceipt()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchReceipt copyWith(void Function(BatchReceipt) updates) =>
      super.copyWith((message) => updates(message as BatchReceipt))
          as BatchReceipt;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchReceipt create() => BatchReceipt._();
  @$core.override
  BatchReceipt createEmptyInstance() => create();
  static $pb.PbList<BatchReceipt> createRepeated() =>
      $pb.PbList<BatchReceipt>();
  @$core.pragma('dart2js:noInline')
  static BatchReceipt getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchReceipt>(create);
  static BatchReceipt? _defaultInstance;

  /// Collective summary
  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalTransfers => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalTransfers($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalTransfers() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalTransfers() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get successfulTransfers => $_getIZ(5);
  @$pb.TagNumber(6)
  set successfulTransfers($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSuccessfulTransfers() => $_has(5);
  @$pb.TagNumber(6)
  void clearSuccessfulTransfers() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get failedTransfers => $_getIZ(6);
  @$pb.TagNumber(7)
  set failedTransfers($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFailedTransfers() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailedTransfers() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalAmount => $_getN(7);
  @$pb.TagNumber(8)
  set totalAmount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get totalFees => $_getN(8);
  @$pb.TagNumber(9)
  set totalFees($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalFees() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalFees() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get finalizedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set finalizedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasFinalizedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearFinalizedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get sourceAccountId => $_getSZ(12);
  @$pb.TagNumber(13)
  set sourceAccountId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSourceAccountId() => $_has(12);
  @$pb.TagNumber(13)
  void clearSourceAccountId() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get sourceAccountNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set sourceAccountNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSourceAccountNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearSourceAccountNumber() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get sourceAccountName => $_getSZ(14);
  @$pb.TagNumber(15)
  set sourceAccountName($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSourceAccountName() => $_has(14);
  @$pb.TagNumber(15)
  void clearSourceAccountName() => $_clearField(15);

  /// Per-item rows
  @$pb.TagNumber(20)
  $pb.PbList<BatchReceiptItem> get items => $_getList(15);
}

class GetBatchReceiptRequest extends $pb.GeneratedMessage {
  factory GetBatchReceiptRequest({
    $core.String? batchId,
  }) {
    final result = create();
    if (batchId != null) result.batchId = batchId;
    return result;
  }

  GetBatchReceiptRequest._();

  factory GetBatchReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBatchReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBatchReceiptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'batchId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchReceiptRequest clone() =>
      GetBatchReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchReceiptRequest copyWith(
          void Function(GetBatchReceiptRequest) updates) =>
      super.copyWith((message) => updates(message as GetBatchReceiptRequest))
          as GetBatchReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBatchReceiptRequest create() => GetBatchReceiptRequest._();
  @$core.override
  GetBatchReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchReceiptRequest> createRepeated() =>
      $pb.PbList<GetBatchReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBatchReceiptRequest>(create);
  static GetBatchReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => $_clearField(1);
}

class GetBatchItemReceiptRequest extends $pb.GeneratedMessage {
  factory GetBatchItemReceiptRequest({
    $core.String? itemId,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    return result;
  }

  GetBatchItemReceiptRequest._();

  factory GetBatchItemReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBatchItemReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBatchItemReceiptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchItemReceiptRequest clone() =>
      GetBatchItemReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBatchItemReceiptRequest copyWith(
          void Function(GetBatchItemReceiptRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetBatchItemReceiptRequest))
          as GetBatchItemReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBatchItemReceiptRequest create() => GetBatchItemReceiptRequest._();
  @$core.override
  GetBatchItemReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchItemReceiptRequest> createRepeated() =>
      $pb.PbList<GetBatchItemReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchItemReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBatchItemReceiptRequest>(create);
  static GetBatchItemReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);
}

class BatchItemReceipt extends $pb.GeneratedMessage {
  factory BatchItemReceipt({
    $core.String? batchId,
    $core.String? batchStatus,
    $core.String? sourceAccountId,
    $core.String? sourceAccountNumber,
    $core.String? sourceAccountName,
    BatchReceiptItem? item,
  }) {
    final result = create();
    if (batchId != null) result.batchId = batchId;
    if (batchStatus != null) result.batchStatus = batchStatus;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (sourceAccountNumber != null)
      result.sourceAccountNumber = sourceAccountNumber;
    if (sourceAccountName != null) result.sourceAccountName = sourceAccountName;
    if (item != null) result.item = item;
    return result;
  }

  BatchItemReceipt._();

  factory BatchItemReceipt.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchItemReceipt.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchItemReceipt',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'batchId')
    ..aOS(2, _omitFieldNames ? '' : 'batchStatus')
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'sourceAccountName')
    ..aOM<BatchReceiptItem>(6, _omitFieldNames ? '' : 'item',
        subBuilder: BatchReceiptItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchItemReceipt clone() => BatchItemReceipt()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchItemReceipt copyWith(void Function(BatchItemReceipt) updates) =>
      super.copyWith((message) => updates(message as BatchItemReceipt))
          as BatchItemReceipt;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchItemReceipt create() => BatchItemReceipt._();
  @$core.override
  BatchItemReceipt createEmptyInstance() => create();
  static $pb.PbList<BatchItemReceipt> createRepeated() =>
      $pb.PbList<BatchItemReceipt>();
  @$core.pragma('dart2js:noInline')
  static BatchItemReceipt getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchItemReceipt>(create);
  static BatchItemReceipt? _defaultInstance;

  /// The single item + parent batch identity for navigation.
  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get batchStatus => $_getSZ(1);
  @$pb.TagNumber(2)
  set batchStatus($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBatchStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearBatchStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceAccountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceAccountName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountName() => $_clearField(5);

  @$pb.TagNumber(6)
  BatchReceiptItem get item => $_getN(5);
  @$pb.TagNumber(6)
  set item(BatchReceiptItem value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasItem() => $_has(5);
  @$pb.TagNumber(6)
  void clearItem() => $_clearField(6);
  @$pb.TagNumber(6)
  BatchReceiptItem ensureItem() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
