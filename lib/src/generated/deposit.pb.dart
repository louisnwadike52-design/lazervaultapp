///
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $34;
import 'account.pb.dart' as $1;

import 'deposit.pbenum.dart';

export 'deposit.pbenum.dart';

class InitiateDepositRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateDepositRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'target_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source_bank_name')
    ..hasRequiredFields = false
  ;

  InitiateDepositRequest._() : super();
  factory InitiateDepositRequest({
    $fixnum.Int64? targetAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? sourceBankName,
  }) {
    final _result = create();
    if (targetAccountId != null) {
      _result.targetAccountId = targetAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (sourceBankName != null) {
      _result.sourceBankName = sourceBankName;
    }
    return _result;
  }
  factory InitiateDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateDepositRequest clone() => InitiateDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateDepositRequest copyWith(void Function(InitiateDepositRequest) updates) => super.copyWith((message) => updates(message as InitiateDepositRequest)) as InitiateDepositRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest create() => InitiateDepositRequest._();
  InitiateDepositRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateDepositRequest> createRepeated() => $pb.PbList<InitiateDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateDepositRequest>(create);
  static InitiateDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get targetAccountId => $_getI64(0);
  @$pb.TagNumber(1)
  set targetAccountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceBankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceBankName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceBankName() => clearField(4);
}

class InitiateDepositResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateDepositResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deposit_id')
    ..e<DepositStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DepositStatus.DEPOSIT_STATUS_UNSPECIFIED, valueOf: DepositStatus.valueOf, enumValues: DepositStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  InitiateDepositResponse._() : super();
  factory InitiateDepositResponse({
    $core.String? depositId,
    DepositStatus? status,
    $core.String? message,
  }) {
    final _result = create();
    if (depositId != null) {
      _result.depositId = depositId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory InitiateDepositResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateDepositResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateDepositResponse clone() => InitiateDepositResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateDepositResponse copyWith(void Function(InitiateDepositResponse) updates) => super.copyWith((message) => updates(message as InitiateDepositResponse)) as InitiateDepositResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateDepositResponse create() => InitiateDepositResponse._();
  InitiateDepositResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateDepositResponse> createRepeated() => $pb.PbList<InitiateDepositResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateDepositResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateDepositResponse>(create);
  static InitiateDepositResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => clearField(1);

  @$pb.TagNumber(2)
  DepositStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(DepositStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetDepositDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDepositDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deposit_id')
    ..hasRequiredFields = false
  ;

  GetDepositDetailsRequest._() : super();
  factory GetDepositDetailsRequest({
    $core.String? depositId,
  }) {
    final _result = create();
    if (depositId != null) {
      _result.depositId = depositId;
    }
    return _result;
  }
  factory GetDepositDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositDetailsRequest clone() => GetDepositDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositDetailsRequest copyWith(void Function(GetDepositDetailsRequest) updates) => super.copyWith((message) => updates(message as GetDepositDetailsRequest)) as GetDepositDetailsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDepositDetailsRequest create() => GetDepositDetailsRequest._();
  GetDepositDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetDepositDetailsRequest> createRepeated() => $pb.PbList<GetDepositDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDepositDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepositDetailsRequest>(create);
  static GetDepositDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => clearField(1);
}

class GetDepositDetailsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDepositDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deposit_id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'target_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source_bank_name')
    ..e<DepositStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DepositStatus.DEPOSIT_STATUS_UNSPECIFIED, valueOf: DepositStatus.valueOf, enumValues: DepositStatus.values)
    ..aOM<$34.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processing_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completed_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failed_at', subBuilder: $34.Timestamp.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure_reason')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'external_transaction_id')
    ..aOM<$1.AccountDetails>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updated_account', subBuilder: $1.AccountDetails.create)
    ..hasRequiredFields = false
  ;

  GetDepositDetailsResponse._() : super();
  factory GetDepositDetailsResponse({
    $core.String? depositId,
    $fixnum.Int64? targetAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? sourceBankName,
    DepositStatus? status,
    $34.Timestamp? createdAt,
    $34.Timestamp? processingAt,
    $34.Timestamp? completedAt,
    $34.Timestamp? failedAt,
    $core.String? failureReason,
    $core.String? externalTransactionId,
    $1.AccountDetails? updatedAccount,
  }) {
    final _result = create();
    if (depositId != null) {
      _result.depositId = depositId;
    }
    if (targetAccountId != null) {
      _result.targetAccountId = targetAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (sourceBankName != null) {
      _result.sourceBankName = sourceBankName;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (processingAt != null) {
      _result.processingAt = processingAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (failedAt != null) {
      _result.failedAt = failedAt;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (externalTransactionId != null) {
      _result.externalTransactionId = externalTransactionId;
    }
    if (updatedAccount != null) {
      _result.updatedAccount = updatedAccount;
    }
    return _result;
  }
  factory GetDepositDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositDetailsResponse clone() => GetDepositDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositDetailsResponse copyWith(void Function(GetDepositDetailsResponse) updates) => super.copyWith((message) => updates(message as GetDepositDetailsResponse)) as GetDepositDetailsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDepositDetailsResponse create() => GetDepositDetailsResponse._();
  GetDepositDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetDepositDetailsResponse> createRepeated() => $pb.PbList<GetDepositDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDepositDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepositDetailsResponse>(create);
  static GetDepositDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get targetAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set targetAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceBankName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceBankName() => clearField(5);

  @$pb.TagNumber(6)
  DepositStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(DepositStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $34.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($34.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $34.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $34.Timestamp get processingAt => $_getN(7);
  @$pb.TagNumber(8)
  set processingAt($34.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasProcessingAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearProcessingAt() => clearField(8);
  @$pb.TagNumber(8)
  $34.Timestamp ensureProcessingAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $34.Timestamp get completedAt => $_getN(8);
  @$pb.TagNumber(9)
  set completedAt($34.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCompletedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCompletedAt() => clearField(9);
  @$pb.TagNumber(9)
  $34.Timestamp ensureCompletedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $34.Timestamp get failedAt => $_getN(9);
  @$pb.TagNumber(10)
  set failedAt($34.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasFailedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearFailedAt() => clearField(10);
  @$pb.TagNumber(10)
  $34.Timestamp ensureFailedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get failureReason => $_getSZ(10);
  @$pb.TagNumber(11)
  set failureReason($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasFailureReason() => $_has(10);
  @$pb.TagNumber(11)
  void clearFailureReason() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get externalTransactionId => $_getSZ(11);
  @$pb.TagNumber(12)
  set externalTransactionId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasExternalTransactionId() => $_has(11);
  @$pb.TagNumber(12)
  void clearExternalTransactionId() => clearField(12);

  @$pb.TagNumber(13)
  $1.AccountDetails get updatedAccount => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAccount($1.AccountDetails v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAccount() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAccount() => clearField(13);
  @$pb.TagNumber(13)
  $1.AccountDetails ensureUpdatedAccount() => $_ensure(12);
}

