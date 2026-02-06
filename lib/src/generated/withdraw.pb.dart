//
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $42;
import 'withdraw.pbenum.dart';

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
    $42.Timestamp? createdAt,
    $42.Timestamp? completedAt,
    $42.Timestamp? failedAt,
    $core.String? failureReason,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (targetBankName != null) {
      $result.targetBankName = targetBankName;
    }
    if (targetAccountNumber != null) {
      $result.targetAccountNumber = targetAccountNumber;
    }
    if (targetSortCode != null) {
      $result.targetSortCode = targetSortCode;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (failedAt != null) {
      $result.failedAt = failedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  WithdrawalTransaction._() : super();
  factory WithdrawalTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawalTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawalTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'sourceAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'targetBankName')
    ..aOS(8, _omitFieldNames ? '' : 'targetAccountNumber')
    ..aOS(9, _omitFieldNames ? '' : 'targetSortCode')
    ..e<WithdrawalStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED, valueOf: WithdrawalStatus.valueOf, enumValues: WithdrawalStatus.values)
    ..aOM<$42.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(12, _omitFieldNames ? '' : 'completedAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(13, _omitFieldNames ? '' : 'failedAt', subBuilder: $42.Timestamp.create)
    ..aOS(14, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawalTransaction clone() => WithdrawalTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawalTransaction copyWith(void Function(WithdrawalTransaction) updates) => super.copyWith((message) => updates(message as WithdrawalTransaction)) as WithdrawalTransaction;

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

  /// uint64 fee = 4;                // Optional withdrawal fee - Changed to uint64
  /// uint64 total_amount = 5;       // Amount + Fee deducted - Changed to uint64
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
  $42.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(11)
  set createdAt($42.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $42.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(12)
  $42.Timestamp get completedAt => $_getN(9);
  @$pb.TagNumber(12)
  set completedAt($42.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCompletedAt() => $_has(9);
  @$pb.TagNumber(12)
  void clearCompletedAt() => clearField(12);
  @$pb.TagNumber(12)
  $42.Timestamp ensureCompletedAt() => $_ensure(9);

  @$pb.TagNumber(13)
  $42.Timestamp get failedAt => $_getN(10);
  @$pb.TagNumber(13)
  set failedAt($42.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailedAt() => $_has(10);
  @$pb.TagNumber(13)
  void clearFailedAt() => clearField(13);
  @$pb.TagNumber(13)
  $42.Timestamp ensureFailedAt() => $_ensure(10);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(11);
  @$pb.TagNumber(14)
  set failureReason($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(11);
  @$pb.TagNumber(14)
  void clearFailureReason() => clearField(14);
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
    final $result = create();
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (targetBankName != null) {
      $result.targetBankName = targetBankName;
    }
    if (targetAccountNumber != null) {
      $result.targetAccountNumber = targetAccountNumber;
    }
    if (targetSortCode != null) {
      $result.targetSortCode = targetSortCode;
    }
    return $result;
  }
  InitiateWithdrawalRequest._() : super();
  factory InitiateWithdrawalRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateWithdrawalRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateWithdrawalRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'sourceAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'targetBankName')
    ..aOS(5, _omitFieldNames ? '' : 'targetAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'targetSortCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalRequest clone() => InitiateWithdrawalRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalRequest copyWith(void Function(InitiateWithdrawalRequest) updates) => super.copyWith((message) => updates(message as InitiateWithdrawalRequest)) as InitiateWithdrawalRequest;

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

/// Response after initiating a withdrawal (Acknowledgement)
class InitiateWithdrawalResponse extends $pb.GeneratedMessage {
  factory InitiateWithdrawalResponse({
    $core.String? withdrawalId,
    WithdrawalStatus? status,
    $core.String? message,
  }) {
    final $result = create();
    if (withdrawalId != null) {
      $result.withdrawalId = withdrawalId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  InitiateWithdrawalResponse._() : super();
  factory InitiateWithdrawalResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateWithdrawalResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateWithdrawalResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawal_id')
    ..e<WithdrawalStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED, valueOf: WithdrawalStatus.valueOf, enumValues: WithdrawalStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalResponse clone() => InitiateWithdrawalResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalResponse copyWith(void Function(InitiateWithdrawalResponse) updates) => super.copyWith((message) => updates(message as InitiateWithdrawalResponse)) as InitiateWithdrawalResponse;

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

/// Request to get details of a specific withdrawal transaction
class GetWithdrawalDetailsRequest extends $pb.GeneratedMessage {
  factory GetWithdrawalDetailsRequest({
    $core.String? withdrawalId,
  }) {
    final $result = create();
    if (withdrawalId != null) {
      $result.withdrawalId = withdrawalId;
    }
    return $result;
  }
  GetWithdrawalDetailsRequest._() : super();
  factory GetWithdrawalDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWithdrawalDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWithdrawalDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawal_id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsRequest clone() => GetWithdrawalDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsRequest copyWith(void Function(GetWithdrawalDetailsRequest) updates) => super.copyWith((message) => updates(message as GetWithdrawalDetailsRequest)) as GetWithdrawalDetailsRequest;

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
    $42.Timestamp? createdAt,
    $42.Timestamp? processingAt,
    $42.Timestamp? completedAt,
    $42.Timestamp? failedAt,
    $core.String? failureReason,
    $core.String? externalTransactionId,
  }) {
    final $result = create();
    if (withdrawalId != null) {
      $result.withdrawalId = withdrawalId;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (targetBankName != null) {
      $result.targetBankName = targetBankName;
    }
    if (targetAccountNumber != null) {
      $result.targetAccountNumber = targetAccountNumber;
    }
    if (targetSortCode != null) {
      $result.targetSortCode = targetSortCode;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (processingAt != null) {
      $result.processingAt = processingAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (failedAt != null) {
      $result.failedAt = failedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    if (externalTransactionId != null) {
      $result.externalTransactionId = externalTransactionId;
    }
    return $result;
  }
  GetWithdrawalDetailsResponse._() : super();
  factory GetWithdrawalDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWithdrawalDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWithdrawalDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawal_id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'source_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'target_bank_name')
    ..aOS(6, _omitFieldNames ? '' : 'target_account_number')
    ..aOS(7, _omitFieldNames ? '' : 'target_sort_code')
    ..e<WithdrawalStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: WithdrawalStatus.WITHDRAWAL_STATUS_UNSPECIFIED, valueOf: WithdrawalStatus.valueOf, enumValues: WithdrawalStatus.values)
    ..aOM<$42.Timestamp>(9, _omitFieldNames ? '' : 'created_at', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(10, _omitFieldNames ? '' : 'processing_at', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(11, _omitFieldNames ? '' : 'completed_at', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(12, _omitFieldNames ? '' : 'failed_at', subBuilder: $42.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'failure_reason')
    ..aOS(14, _omitFieldNames ? '' : 'external_transaction_id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsResponse clone() => GetWithdrawalDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWithdrawalDetailsResponse copyWith(void Function(GetWithdrawalDetailsResponse) updates) => super.copyWith((message) => updates(message as GetWithdrawalDetailsResponse)) as GetWithdrawalDetailsResponse;

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

  /// Amount represented in the smallest currency unit (e.g., cents)
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
  $42.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($42.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $42.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $42.Timestamp get processingAt => $_getN(9);
  @$pb.TagNumber(10)
  set processingAt($42.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasProcessingAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearProcessingAt() => clearField(10);
  @$pb.TagNumber(10)
  $42.Timestamp ensureProcessingAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $42.Timestamp get completedAt => $_getN(10);
  @$pb.TagNumber(11)
  set completedAt($42.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => clearField(11);
  @$pb.TagNumber(11)
  $42.Timestamp ensureCompletedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $42.Timestamp get failedAt => $_getN(11);
  @$pb.TagNumber(12)
  set failedAt($42.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasFailedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailedAt() => clearField(12);
  @$pb.TagNumber(12)
  $42.Timestamp ensureFailedAt() => $_ensure(11);

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
