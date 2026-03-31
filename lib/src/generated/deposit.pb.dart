//
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'account.pb.dart' as $0;
import 'deposit.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $2;

export 'deposit.pbenum.dart';

/// Request to initiate a deposit
class InitiateDepositRequest extends $pb.GeneratedMessage {
  factory InitiateDepositRequest({
    $core.String? targetAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? sourceBankName,
    $core.String? countryCode,
    $core.String? locale,
  }) {
    final $result = create();
    if (targetAccountId != null) {
      $result.targetAccountId = targetAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (sourceBankName != null) {
      $result.sourceBankName = sourceBankName;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  InitiateDepositRequest._() : super();
  factory InitiateDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateDepositRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'target_account_id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'source_bank_name')
    ..aOS(5, _omitFieldNames ? '' : 'country_code')
    ..aOS(6, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateDepositRequest clone() => InitiateDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateDepositRequest copyWith(void Function(InitiateDepositRequest) updates) => super.copyWith((message) => updates(message as InitiateDepositRequest)) as InitiateDepositRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest create() => InitiateDepositRequest._();
  InitiateDepositRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateDepositRequest> createRepeated() => $pb.PbList<InitiateDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateDepositRequest>(create);
  static InitiateDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get targetAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetAccountId() => clearField(1);

  /// Amount represented in the smallest currency unit (e.g., cents for GBP/USD)
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

  @$pb.TagNumber(5)
  $core.String get countryCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set countryCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCountryCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountryCode() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get locale => $_getSZ(5);
  @$pb.TagNumber(6)
  set locale($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLocale() => $_has(5);
  @$pb.TagNumber(6)
  void clearLocale() => clearField(6);
}

/// Response after initiating a deposit (acknowledgement)
class InitiateDepositResponse extends $pb.GeneratedMessage {
  factory InitiateDepositResponse({
    $core.String? depositId,
    DepositStatus? status,
    $core.String? message,
    $core.bool? requiresAuthorization,
    $core.String? paymentUrl,
    $core.String? provider,
    $core.String? countryCode,
  }) {
    final $result = create();
    if (depositId != null) {
      $result.depositId = depositId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (message != null) {
      $result.message = message;
    }
    if (requiresAuthorization != null) {
      $result.requiresAuthorization = requiresAuthorization;
    }
    if (paymentUrl != null) {
      $result.paymentUrl = paymentUrl;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    return $result;
  }
  InitiateDepositResponse._() : super();
  factory InitiateDepositResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateDepositResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateDepositResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deposit_id')
    ..e<DepositStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DepositStatus.DEPOSIT_STATUS_UNSPECIFIED, valueOf: DepositStatus.valueOf, enumValues: DepositStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOB(4, _omitFieldNames ? '' : 'requires_authorization')
    ..aOS(5, _omitFieldNames ? '' : 'payment_url')
    ..aOS(6, _omitFieldNames ? '' : 'provider')
    ..aOS(7, _omitFieldNames ? '' : 'country_code')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateDepositResponse clone() => InitiateDepositResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateDepositResponse copyWith(void Function(InitiateDepositResponse) updates) => super.copyWith((message) => updates(message as InitiateDepositResponse)) as InitiateDepositResponse;

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

  @$pb.TagNumber(4)
  $core.bool get requiresAuthorization => $_getBF(3);
  @$pb.TagNumber(4)
  set requiresAuthorization($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequiresAuthorization() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequiresAuthorization() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get paymentUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get provider => $_getSZ(5);
  @$pb.TagNumber(6)
  set provider($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProvider() => $_has(5);
  @$pb.TagNumber(6)
  void clearProvider() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get countryCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set countryCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCountryCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountryCode() => clearField(7);
}

/// Request to get details of a specific deposit transaction
class GetDepositDetailsRequest extends $pb.GeneratedMessage {
  factory GetDepositDetailsRequest({
    $core.String? depositId,
  }) {
    final $result = create();
    if (depositId != null) {
      $result.depositId = depositId;
    }
    return $result;
  }
  GetDepositDetailsRequest._() : super();
  factory GetDepositDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDepositDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deposit_id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositDetailsRequest clone() => GetDepositDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositDetailsRequest copyWith(void Function(GetDepositDetailsRequest) updates) => super.copyWith((message) => updates(message as GetDepositDetailsRequest)) as GetDepositDetailsRequest;

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

/// Response containing details of a specific deposit transaction
class GetDepositDetailsResponse extends $pb.GeneratedMessage {
  factory GetDepositDetailsResponse({
    $core.String? depositId,
    $core.String? targetAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? sourceBankName,
    DepositStatus? status,
    $2.Timestamp? createdAt,
    $2.Timestamp? processingAt,
    $2.Timestamp? completedAt,
    $2.Timestamp? failedAt,
    $core.String? failureReason,
    $core.String? externalTransactionId,
    $0.AccountDetails? updatedAccount,
  }) {
    final $result = create();
    if (depositId != null) {
      $result.depositId = depositId;
    }
    if (targetAccountId != null) {
      $result.targetAccountId = targetAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (sourceBankName != null) {
      $result.sourceBankName = sourceBankName;
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
    if (updatedAccount != null) {
      $result.updatedAccount = updatedAccount;
    }
    return $result;
  }
  GetDepositDetailsResponse._() : super();
  factory GetDepositDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDepositDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deposit_id')
    ..aOS(2, _omitFieldNames ? '' : 'target_account_id')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'source_bank_name')
    ..e<DepositStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DepositStatus.DEPOSIT_STATUS_UNSPECIFIED, valueOf: DepositStatus.valueOf, enumValues: DepositStatus.values)
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'created_at', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(8, _omitFieldNames ? '' : 'processing_at', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(9, _omitFieldNames ? '' : 'completed_at', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(10, _omitFieldNames ? '' : 'failed_at', subBuilder: $2.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'failure_reason')
    ..aOS(12, _omitFieldNames ? '' : 'external_transaction_id')
    ..aOM<$0.AccountDetails>(13, _omitFieldNames ? '' : 'updated_account', subBuilder: $0.AccountDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositDetailsResponse clone() => GetDepositDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositDetailsResponse copyWith(void Function(GetDepositDetailsResponse) updates) => super.copyWith((message) => updates(message as GetDepositDetailsResponse)) as GetDepositDetailsResponse;

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
  $core.String get targetAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set targetAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetAccountId() => clearField(2);

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
  $2.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($2.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $2.Timestamp get processingAt => $_getN(7);
  @$pb.TagNumber(8)
  set processingAt($2.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasProcessingAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearProcessingAt() => clearField(8);
  @$pb.TagNumber(8)
  $2.Timestamp ensureProcessingAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $2.Timestamp get completedAt => $_getN(8);
  @$pb.TagNumber(9)
  set completedAt($2.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCompletedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCompletedAt() => clearField(9);
  @$pb.TagNumber(9)
  $2.Timestamp ensureCompletedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $2.Timestamp get failedAt => $_getN(9);
  @$pb.TagNumber(10)
  set failedAt($2.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasFailedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearFailedAt() => clearField(10);
  @$pb.TagNumber(10)
  $2.Timestamp ensureFailedAt() => $_ensure(9);

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

  /// Updated account details are included only if the deposit status is COMPLETED.
  @$pb.TagNumber(13)
  $0.AccountDetails get updatedAccount => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAccount($0.AccountDetails v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAccount() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAccount() => clearField(13);
  @$pb.TagNumber(13)
  $0.AccountDetails ensureUpdatedAccount() => $_ensure(12);
}

/// Request to simulate a test deposit (sandbox only)
class SimulateTestDepositRequest extends $pb.GeneratedMessage {
  factory SimulateTestDepositRequest({
    $core.String? destinationAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? countryCode,
  }) {
    final $result = create();
    if (destinationAccountId != null) {
      $result.destinationAccountId = destinationAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    return $result;
  }
  SimulateTestDepositRequest._() : super();
  factory SimulateTestDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SimulateTestDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SimulateTestDepositRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destination_account_id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'country_code')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SimulateTestDepositRequest clone() => SimulateTestDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SimulateTestDepositRequest copyWith(void Function(SimulateTestDepositRequest) updates) => super.copyWith((message) => updates(message as SimulateTestDepositRequest)) as SimulateTestDepositRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimulateTestDepositRequest create() => SimulateTestDepositRequest._();
  SimulateTestDepositRequest createEmptyInstance() => create();
  static $pb.PbList<SimulateTestDepositRequest> createRepeated() => $pb.PbList<SimulateTestDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static SimulateTestDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SimulateTestDepositRequest>(create);
  static SimulateTestDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get destinationAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set destinationAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDestinationAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestinationAccountId() => clearField(1);

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
  $core.String get countryCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set countryCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCountryCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountryCode() => clearField(4);
}

/// Request to get available deposit methods for a country
class GetDepositMethodsRequest extends $pb.GeneratedMessage {
  factory GetDepositMethodsRequest({
    $core.String? countryCode,
    $core.String? currency,
  }) {
    final $result = create();
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  GetDepositMethodsRequest._() : super();
  factory GetDepositMethodsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositMethodsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDepositMethodsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'country_code')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositMethodsRequest clone() => GetDepositMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositMethodsRequest copyWith(void Function(GetDepositMethodsRequest) updates) => super.copyWith((message) => updates(message as GetDepositMethodsRequest)) as GetDepositMethodsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsRequest create() => GetDepositMethodsRequest._();
  GetDepositMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetDepositMethodsRequest> createRepeated() => $pb.PbList<GetDepositMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepositMethodsRequest>(create);
  static GetDepositMethodsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);
}

/// Response containing available deposit methods
class GetDepositMethodsResponse extends $pb.GeneratedMessage {
  factory GetDepositMethodsResponse({
    $core.Iterable<DepositMethod>? methods,
    $core.String? countryCode,
    $core.String? currency,
    $core.String? provider,
  }) {
    final $result = create();
    if (methods != null) {
      $result.methods.addAll(methods);
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    return $result;
  }
  GetDepositMethodsResponse._() : super();
  factory GetDepositMethodsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositMethodsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDepositMethodsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<DepositMethod>(1, _omitFieldNames ? '' : 'methods', $pb.PbFieldType.PM, subBuilder: DepositMethod.create)
    ..aOS(2, _omitFieldNames ? '' : 'country_code')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositMethodsResponse clone() => GetDepositMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositMethodsResponse copyWith(void Function(GetDepositMethodsResponse) updates) => super.copyWith((message) => updates(message as GetDepositMethodsResponse)) as GetDepositMethodsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsResponse create() => GetDepositMethodsResponse._();
  GetDepositMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetDepositMethodsResponse> createRepeated() => $pb.PbList<GetDepositMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepositMethodsResponse>(create);
  static GetDepositMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DepositMethod> get methods => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get provider => $_getSZ(3);
  @$pb.TagNumber(4)
  set provider($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearProvider() => clearField(4);
}

/// A single deposit method available for a country
class DepositMethod extends $pb.GeneratedMessage {
  factory DepositMethod({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? icon,
    $core.String? feeDescription,
    $core.String? processingTime,
    $core.bool? available,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (icon != null) {
      $result.icon = icon;
    }
    if (feeDescription != null) {
      $result.feeDescription = feeDescription;
    }
    if (processingTime != null) {
      $result.processingTime = processingTime;
    }
    if (available != null) {
      $result.available = available;
    }
    return $result;
  }
  DepositMethod._() : super();
  factory DepositMethod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositMethod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DepositMethod', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..aOS(5, _omitFieldNames ? '' : 'fee_description')
    ..aOS(6, _omitFieldNames ? '' : 'processing_time')
    ..aOB(7, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositMethod clone() => DepositMethod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositMethod copyWith(void Function(DepositMethod) updates) => super.copyWith((message) => updates(message as DepositMethod)) as DepositMethod;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositMethod create() => DepositMethod._();
  DepositMethod createEmptyInstance() => create();
  static $pb.PbList<DepositMethod> createRepeated() => $pb.PbList<DepositMethod>();
  @$core.pragma('dart2js:noInline')
  static DepositMethod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositMethod>(create);
  static DepositMethod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get feeDescription => $_getSZ(4);
  @$pb.TagNumber(5)
  set feeDescription($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFeeDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get processingTime => $_getSZ(5);
  @$pb.TagNumber(6)
  set processingTime($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProcessingTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearProcessingTime() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get available => $_getBF(6);
  @$pb.TagNumber(7)
  set available($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAvailable() => $_has(6);
  @$pb.TagNumber(7)
  void clearAvailable() => clearField(7);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
