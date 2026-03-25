// This is a generated file - do not edit.
//
// Generated from withdraw.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'withdraw.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'withdraw.pbenum.dart';

/// Represents a withdrawal transaction record
class WithdrawalTransaction extends $pb.GeneratedMessage {
  factory WithdrawalTransaction({
    $core.String? transactionId,
    $fixnum.Int64? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? targetBankName,
    $core.String? targetAccountNumber,
    $core.String? targetSortCode,
    WithdrawalStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
    $1.Timestamp? failedAt,
    $core.String? failureReason,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (targetBankName != null) result.targetBankName = targetBankName;
    if (targetAccountNumber != null)
      result.targetAccountNumber = targetAccountNumber;
    if (targetSortCode != null) result.targetSortCode = targetSortCode;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (failedAt != null) result.failedAt = failedAt;
    if (failureReason != null) result.failureReason = failureReason;
    return result;
  }

  WithdrawalTransaction._();

  factory WithdrawalTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawalTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawalTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'sourceAccountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'targetBankName')
    ..aOS(8, _omitFieldNames ? '' : 'targetAccountNumber')
    ..aOS(9, _omitFieldNames ? '' : 'targetSortCode')
    ..e<WithdrawalStatus>(
        10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED,
        valueOf: WithdrawalStatus.valueOf,
        enumValues: WithdrawalStatus.values)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'failedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(14, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalTransaction clone() =>
      WithdrawalTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalTransaction copyWith(
          void Function(WithdrawalTransaction) updates) =>
      super.copyWith((message) => updates(message as WithdrawalTransaction))
          as WithdrawalTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawalTransaction create() => WithdrawalTransaction._();
  @$core.override
  WithdrawalTransaction createEmptyInstance() => create();
  static $pb.PbList<WithdrawalTransaction> createRepeated() =>
      $pb.PbList<WithdrawalTransaction>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawalTransaction>(create);
  static WithdrawalTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sourceAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set sourceAccountId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  /// uint64 fee = 4;                // Optional withdrawal fee - Changed to uint64
  /// uint64 total_amount = 5;       // Amount + Fee deducted - Changed to uint64
  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get targetBankName => $_getSZ(4);
  @$pb.TagNumber(7)
  set targetBankName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetBankName() => $_has(4);
  @$pb.TagNumber(7)
  void clearTargetBankName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get targetAccountNumber => $_getSZ(5);
  @$pb.TagNumber(8)
  set targetAccountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(8)
  $core.bool hasTargetAccountNumber() => $_has(5);
  @$pb.TagNumber(8)
  void clearTargetAccountNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get targetSortCode => $_getSZ(6);
  @$pb.TagNumber(9)
  set targetSortCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(9)
  $core.bool hasTargetSortCode() => $_has(6);
  @$pb.TagNumber(9)
  void clearTargetSortCode() => $_clearField(9);

  @$pb.TagNumber(10)
  WithdrawalStatus get status => $_getN(7);
  @$pb.TagNumber(10)
  set status(WithdrawalStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(12)
  $1.Timestamp get completedAt => $_getN(9);
  @$pb.TagNumber(12)
  set completedAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCompletedAt() => $_has(9);
  @$pb.TagNumber(12)
  void clearCompletedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCompletedAt() => $_ensure(9);

  @$pb.TagNumber(13)
  $1.Timestamp get failedAt => $_getN(10);
  @$pb.TagNumber(13)
  set failedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasFailedAt() => $_has(10);
  @$pb.TagNumber(13)
  void clearFailedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureFailedAt() => $_ensure(10);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(11);
  @$pb.TagNumber(14)
  set failureReason($core.String value) => $_setString(11, value);
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(11);
  @$pb.TagNumber(14)
  void clearFailureReason() => $_clearField(14);
}

/// Request to initiate a withdrawal
class InitiateWithdrawalRequest extends $pb.GeneratedMessage {
  factory InitiateWithdrawalRequest({
    $fixnum.Int64? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? targetBankName,
    $core.String? targetAccountNumber,
    $core.String? targetSortCode,
  }) {
    final result = create();
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (targetBankName != null) result.targetBankName = targetBankName;
    if (targetAccountNumber != null)
      result.targetAccountNumber = targetAccountNumber;
    if (targetSortCode != null) result.targetSortCode = targetSortCode;
    return result;
  }

  InitiateWithdrawalRequest._();

  factory InitiateWithdrawalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateWithdrawalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateWithdrawalRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'sourceAccountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'targetBankName')
    ..aOS(5, _omitFieldNames ? '' : 'targetAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'targetSortCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateWithdrawalRequest clone() =>
      InitiateWithdrawalRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateWithdrawalRequest copyWith(
          void Function(InitiateWithdrawalRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateWithdrawalRequest))
          as InitiateWithdrawalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest create() => InitiateWithdrawalRequest._();
  @$core.override
  InitiateWithdrawalRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateWithdrawalRequest> createRepeated() =>
      $pb.PbList<InitiateWithdrawalRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateWithdrawalRequest>(create);
  static InitiateWithdrawalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sourceAccountId => $_getI64(0);
  @$pb.TagNumber(1)
  set sourceAccountId($fixnum.Int64 value) => $_setInt64(0, value);
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
  $core.String get targetBankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set targetBankName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetBankName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get targetAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetAccountNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAccountNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get targetSortCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set targetSortCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTargetSortCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetSortCode() => $_clearField(6);
}

/// Response after initiating a withdrawal (Acknowledgement)
class InitiateWithdrawalResponse extends $pb.GeneratedMessage {
  factory InitiateWithdrawalResponse({
    $core.String? withdrawalId,
    WithdrawalStatus? status,
    $core.String? message,
  }) {
    final result = create();
    if (withdrawalId != null) result.withdrawalId = withdrawalId;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  InitiateWithdrawalResponse._();

  factory InitiateWithdrawalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateWithdrawalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateWithdrawalResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawal_id')
    ..e<WithdrawalStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED,
        valueOf: WithdrawalStatus.valueOf,
        enumValues: WithdrawalStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateWithdrawalResponse clone() =>
      InitiateWithdrawalResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateWithdrawalResponse copyWith(
          void Function(InitiateWithdrawalResponse) updates) =>
      super.copyWith(
              (message) => updates(message as InitiateWithdrawalResponse))
          as InitiateWithdrawalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalResponse create() => InitiateWithdrawalResponse._();
  @$core.override
  InitiateWithdrawalResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateWithdrawalResponse> createRepeated() =>
      $pb.PbList<InitiateWithdrawalResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateWithdrawalResponse>(create);
  static InitiateWithdrawalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => $_clearField(1);

  @$pb.TagNumber(2)
  WithdrawalStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(WithdrawalStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Request to get details of a specific withdrawal transaction
class GetWithdrawalDetailsRequest extends $pb.GeneratedMessage {
  factory GetWithdrawalDetailsRequest({
    $core.String? withdrawalId,
  }) {
    final result = create();
    if (withdrawalId != null) result.withdrawalId = withdrawalId;
    return result;
  }

  GetWithdrawalDetailsRequest._();

  factory GetWithdrawalDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWithdrawalDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWithdrawalDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawal_id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWithdrawalDetailsRequest clone() =>
      GetWithdrawalDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWithdrawalDetailsRequest copyWith(
          void Function(GetWithdrawalDetailsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetWithdrawalDetailsRequest))
          as GetWithdrawalDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsRequest create() =>
      GetWithdrawalDetailsRequest._();
  @$core.override
  GetWithdrawalDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetWithdrawalDetailsRequest> createRepeated() =>
      $pb.PbList<GetWithdrawalDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWithdrawalDetailsRequest>(create);
  static GetWithdrawalDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => $_clearField(1);
}

/// Response containing details of a specific withdrawal transaction
class GetWithdrawalDetailsResponse extends $pb.GeneratedMessage {
  factory GetWithdrawalDetailsResponse({
    $core.String? withdrawalId,
    $fixnum.Int64? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? targetBankName,
    $core.String? targetAccountNumber,
    $core.String? targetSortCode,
    WithdrawalStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? processingAt,
    $1.Timestamp? completedAt,
    $1.Timestamp? failedAt,
    $core.String? failureReason,
    $core.String? externalTransactionId,
  }) {
    final result = create();
    if (withdrawalId != null) result.withdrawalId = withdrawalId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (targetBankName != null) result.targetBankName = targetBankName;
    if (targetAccountNumber != null)
      result.targetAccountNumber = targetAccountNumber;
    if (targetSortCode != null) result.targetSortCode = targetSortCode;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (processingAt != null) result.processingAt = processingAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (failedAt != null) result.failedAt = failedAt;
    if (failureReason != null) result.failureReason = failureReason;
    if (externalTransactionId != null)
      result.externalTransactionId = externalTransactionId;
    return result;
  }

  GetWithdrawalDetailsResponse._();

  factory GetWithdrawalDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWithdrawalDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWithdrawalDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawal_id')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'source_account_id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'target_bank_name')
    ..aOS(6, _omitFieldNames ? '' : 'target_account_number')
    ..aOS(7, _omitFieldNames ? '' : 'target_sort_code')
    ..e<WithdrawalStatus>(
        8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED,
        valueOf: WithdrawalStatus.valueOf,
        enumValues: WithdrawalStatus.values)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'created_at',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'processing_at',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'completed_at',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'failed_at',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'failure_reason')
    ..aOS(14, _omitFieldNames ? '' : 'external_transaction_id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWithdrawalDetailsResponse clone() =>
      GetWithdrawalDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWithdrawalDetailsResponse copyWith(
          void Function(GetWithdrawalDetailsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetWithdrawalDetailsResponse))
          as GetWithdrawalDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsResponse create() =>
      GetWithdrawalDetailsResponse._();
  @$core.override
  GetWithdrawalDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetWithdrawalDetailsResponse> createRepeated() =>
      $pb.PbList<GetWithdrawalDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWithdrawalDetailsResponse>(create);
  static GetWithdrawalDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sourceAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set sourceAccountId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  /// Amount represented in the smallest currency unit (e.g., cents)
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
  $core.String get targetBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetBankName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetBankName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get targetAccountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set targetAccountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTargetAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get targetSortCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set targetSortCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetSortCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetSortCode() => $_clearField(7);

  @$pb.TagNumber(8)
  WithdrawalStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(WithdrawalStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get processingAt => $_getN(9);
  @$pb.TagNumber(10)
  set processingAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasProcessingAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearProcessingAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureProcessingAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get completedAt => $_getN(10);
  @$pb.TagNumber(11)
  set completedAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCompletedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get failedAt => $_getN(11);
  @$pb.TagNumber(12)
  set failedAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasFailedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureFailedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get failureReason => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureReason($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFailureReason() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureReason() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get externalTransactionId => $_getSZ(13);
  @$pb.TagNumber(14)
  set externalTransactionId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasExternalTransactionId() => $_has(13);
  @$pb.TagNumber(14)
  void clearExternalTransactionId() => $_clearField(14);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
