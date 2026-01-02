///
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $34;

import 'withdraw.pbenum.dart';

export 'withdraw.pbenum.dart';

class WithdrawalTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawalTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetBankName')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAccountNumber')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetSortCode')
    ..e<WithdrawalStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED, valueOf: WithdrawalStatus.valueOf, enumValues: WithdrawalStatus.values)
    ..aOM<$34.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedAt', subBuilder: $34.Timestamp.create)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  WithdrawalTransaction._() : super();
  factory WithdrawalTransaction({
    $core.String? transactionId,
    $fixnum.Int64? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? targetBankName,
    $core.String? targetAccountNumber,
    $core.String? targetSortCode,
    WithdrawalStatus? status,
    $34.Timestamp? createdAt,
    $34.Timestamp? completedAt,
    $34.Timestamp? failedAt,
    $core.String? failureReason,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (targetBankName != null) {
      _result.targetBankName = targetBankName;
    }
    if (targetAccountNumber != null) {
      _result.targetAccountNumber = targetAccountNumber;
    }
    if (targetSortCode != null) {
      _result.targetSortCode = targetSortCode;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
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
    return _result;
  }
  factory WithdrawalTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawalTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawalTransaction clone() => WithdrawalTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawalTransaction copyWith(void Function(WithdrawalTransaction) updates) => super.copyWith((message) => updates(message as WithdrawalTransaction)) as WithdrawalTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WithdrawalTransaction create() => WithdrawalTransaction._();
  WithdrawalTransaction createEmptyInstance() => create();
  static $pb.PbList<WithdrawalTransaction> createRepeated() => $pb.PbList<WithdrawalTransaction>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawalTransaction>(create);
  static WithdrawalTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sourceAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set sourceAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get targetBankName => $_getSZ(4);
  @$pb.TagNumber(7)
  set targetBankName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetBankName() => $_has(4);
  @$pb.TagNumber(7)
  void clearTargetBankName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get targetAccountNumber => $_getSZ(5);
  @$pb.TagNumber(8)
  set targetAccountNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasTargetAccountNumber() => $_has(5);
  @$pb.TagNumber(8)
  void clearTargetAccountNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get targetSortCode => $_getSZ(6);
  @$pb.TagNumber(9)
  set targetSortCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(9)
  $core.bool hasTargetSortCode() => $_has(6);
  @$pb.TagNumber(9)
  void clearTargetSortCode() => clearField(9);

  @$pb.TagNumber(10)
  WithdrawalStatus get status => $_getN(7);
  @$pb.TagNumber(10)
  set status(WithdrawalStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $34.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(11)
  set createdAt($34.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $34.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(12)
  $34.Timestamp get completedAt => $_getN(9);
  @$pb.TagNumber(12)
  set completedAt($34.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCompletedAt() => $_has(9);
  @$pb.TagNumber(12)
  void clearCompletedAt() => clearField(12);
  @$pb.TagNumber(12)
  $34.Timestamp ensureCompletedAt() => $_ensure(9);

  @$pb.TagNumber(13)
  $34.Timestamp get failedAt => $_getN(10);
  @$pb.TagNumber(13)
  set failedAt($34.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailedAt() => $_has(10);
  @$pb.TagNumber(13)
  void clearFailedAt() => clearField(13);
  @$pb.TagNumber(13)
  $34.Timestamp ensureFailedAt() => $_ensure(10);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(11);
  @$pb.TagNumber(14)
  set failureReason($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(11);
  @$pb.TagNumber(14)
  void clearFailureReason() => clearField(14);
}

class InitiateWithdrawalRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateWithdrawalRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetBankName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAccountNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetSortCode')
    ..hasRequiredFields = false
  ;

  InitiateWithdrawalRequest._() : super();
  factory InitiateWithdrawalRequest({
    $fixnum.Int64? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? targetBankName,
    $core.String? targetAccountNumber,
    $core.String? targetSortCode,
  }) {
    final _result = create();
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (targetBankName != null) {
      _result.targetBankName = targetBankName;
    }
    if (targetAccountNumber != null) {
      _result.targetAccountNumber = targetAccountNumber;
    }
    if (targetSortCode != null) {
      _result.targetSortCode = targetSortCode;
    }
    return _result;
  }
  factory InitiateWithdrawalRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateWithdrawalRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalRequest clone() => InitiateWithdrawalRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalRequest copyWith(void Function(InitiateWithdrawalRequest) updates) => super.copyWith((message) => updates(message as InitiateWithdrawalRequest)) as InitiateWithdrawalRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest create() => InitiateWithdrawalRequest._();
  InitiateWithdrawalRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateWithdrawalRequest> createRepeated() => $pb.PbList<InitiateWithdrawalRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateWithdrawalRequest>(create);
  static InitiateWithdrawalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sourceAccountId => $_getI64(0);
  @$pb.TagNumber(1)
  set sourceAccountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSourceAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceAccountId() => clearField(1);

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
  $core.String get targetBankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set targetBankName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetBankName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get targetAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetAccountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAccountNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get targetSortCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set targetSortCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetSortCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetSortCode() => clearField(6);
}

class InitiateWithdrawalResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateWithdrawalResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawal_id')
    ..e<WithdrawalStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED, valueOf: WithdrawalStatus.valueOf, enumValues: WithdrawalStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  InitiateWithdrawalResponse._() : super();
  factory InitiateWithdrawalResponse({
    $core.String? withdrawalId,
    WithdrawalStatus? status,
    $core.String? message,
  }) {
    final _result = create();
    if (withdrawalId != null) {
      _result.withdrawalId = withdrawalId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory InitiateWithdrawalResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateWithdrawalResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalResponse clone() => InitiateWithdrawalResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalResponse copyWith(void Function(InitiateWithdrawalResponse) updates) => super.copyWith((message) => updates(message as InitiateWithdrawalResponse)) as InitiateWithdrawalResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalResponse create() => InitiateWithdrawalResponse._();
  InitiateWithdrawalResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateWithdrawalResponse> createRepeated() => $pb.PbList<InitiateWithdrawalResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateWithdrawalResponse>(create);
  static InitiateWithdrawalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => clearField(1);

  @$pb.TagNumber(2)
  WithdrawalStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(WithdrawalStatus v) { setField(2, v); }
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

class GetWithdrawalDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWithdrawalDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawal_id')
    ..hasRequiredFields = false
  ;

  GetWithdrawalDetailsRequest._() : super();
  factory GetWithdrawalDetailsRequest({
    $core.String? withdrawalId,
  }) {
    final _result = create();
    if (withdrawalId != null) {
      _result.withdrawalId = withdrawalId;
    }
    return _result;
  }
  factory GetWithdrawalDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWithdrawalDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsRequest clone() => GetWithdrawalDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsRequest copyWith(void Function(GetWithdrawalDetailsRequest) updates) => super.copyWith((message) => updates(message as GetWithdrawalDetailsRequest)) as GetWithdrawalDetailsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsRequest create() => GetWithdrawalDetailsRequest._();
  GetWithdrawalDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetWithdrawalDetailsRequest> createRepeated() => $pb.PbList<GetWithdrawalDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWithdrawalDetailsRequest>(create);
  static GetWithdrawalDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => clearField(1);
}

class GetWithdrawalDetailsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWithdrawalDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawal_id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'target_bank_name')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'target_account_number')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'target_sort_code')
    ..e<WithdrawalStatus>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED, valueOf: WithdrawalStatus.valueOf, enumValues: WithdrawalStatus.values)
    ..aOM<$34.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processing_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completed_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failed_at', subBuilder: $34.Timestamp.create)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure_reason')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'external_transaction_id')
    ..hasRequiredFields = false
  ;

  GetWithdrawalDetailsResponse._() : super();
  factory GetWithdrawalDetailsResponse({
    $core.String? withdrawalId,
    $fixnum.Int64? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? targetBankName,
    $core.String? targetAccountNumber,
    $core.String? targetSortCode,
    WithdrawalStatus? status,
    $34.Timestamp? createdAt,
    $34.Timestamp? processingAt,
    $34.Timestamp? completedAt,
    $34.Timestamp? failedAt,
    $core.String? failureReason,
    $core.String? externalTransactionId,
  }) {
    final _result = create();
    if (withdrawalId != null) {
      _result.withdrawalId = withdrawalId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (targetBankName != null) {
      _result.targetBankName = targetBankName;
    }
    if (targetAccountNumber != null) {
      _result.targetAccountNumber = targetAccountNumber;
    }
    if (targetSortCode != null) {
      _result.targetSortCode = targetSortCode;
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
    return _result;
  }
  factory GetWithdrawalDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWithdrawalDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsResponse clone() => GetWithdrawalDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsResponse copyWith(void Function(GetWithdrawalDetailsResponse) updates) => super.copyWith((message) => updates(message as GetWithdrawalDetailsResponse)) as GetWithdrawalDetailsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsResponse create() => GetWithdrawalDetailsResponse._();
  GetWithdrawalDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetWithdrawalDetailsResponse> createRepeated() => $pb.PbList<GetWithdrawalDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWithdrawalDetailsResponse>(create);
  static GetWithdrawalDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sourceAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set sourceAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

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
  $core.String get targetBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetBankName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetBankName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get targetAccountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set targetAccountNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetAccountNumber() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get targetSortCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set targetSortCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetSortCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetSortCode() => clearField(7);

  @$pb.TagNumber(8)
  WithdrawalStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(WithdrawalStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $34.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($34.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $34.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $34.Timestamp get processingAt => $_getN(9);
  @$pb.TagNumber(10)
  set processingAt($34.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasProcessingAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearProcessingAt() => clearField(10);
  @$pb.TagNumber(10)
  $34.Timestamp ensureProcessingAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $34.Timestamp get completedAt => $_getN(10);
  @$pb.TagNumber(11)
  set completedAt($34.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => clearField(11);
  @$pb.TagNumber(11)
  $34.Timestamp ensureCompletedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $34.Timestamp get failedAt => $_getN(11);
  @$pb.TagNumber(12)
  set failedAt($34.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasFailedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailedAt() => clearField(12);
  @$pb.TagNumber(12)
  $34.Timestamp ensureFailedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get failureReason => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureReason($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailureReason() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureReason() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get externalTransactionId => $_getSZ(13);
  @$pb.TagNumber(14)
  set externalTransactionId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasExternalTransactionId() => $_has(13);
  @$pb.TagNumber(14)
  void clearExternalTransactionId() => clearField(14);
}

