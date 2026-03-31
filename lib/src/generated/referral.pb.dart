//
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'referral.pbenum.dart';

export 'referral.pbenum.dart';

/// ReferralCode message represents a user's referral code
class ReferralCode extends $pb.GeneratedMessage {
  factory ReferralCode({
    $fixnum.Int64? id,
    $fixnum.Int64? userId,
    $core.String? code,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (code != null) {
      $result.code = code;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  ReferralCode._() : super();
  factory ReferralCode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReferralCode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReferralCode', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aOB(4, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReferralCode clone() => ReferralCode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReferralCode copyWith(void Function(ReferralCode) updates) => super.copyWith((message) => updates(message as ReferralCode)) as ReferralCode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReferralCode create() => ReferralCode._();
  ReferralCode createEmptyInstance() => create();
  static $pb.PbList<ReferralCode> createRepeated() => $pb.PbList<ReferralCode>();
  @$core.pragma('dart2js:noInline')
  static ReferralCode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReferralCode>(create);
  static ReferralCode? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isActive => $_getBF(3);
  @$pb.TagNumber(4)
  set isActive($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsActive() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsActive() => clearField(4);

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

  @$pb.TagNumber(6)
  $1.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureUpdatedAt() => $_ensure(5);
}

/// ReferralTransaction message represents a referral event
class ReferralTransaction extends $pb.GeneratedMessage {
  factory ReferralTransaction({
    $fixnum.Int64? id,
    $fixnum.Int64? referrerUserId,
    $fixnum.Int64? refereeUserId,
    $core.String? referralCodeUsed,
    ReferralStatus? status,
    $core.int? referrerRewardAmount,
    $core.int? refereeRewardAmount,
    $core.String? currency,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
    $core.String? failureReason,
    $core.String? refereeFirstName,
    $core.String? refereeLastName,
    $core.String? refereeUsername,
    $core.String? referrerUsername,
    $core.bool? refereeHasJoined,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (referrerUserId != null) {
      $result.referrerUserId = referrerUserId;
    }
    if (refereeUserId != null) {
      $result.refereeUserId = refereeUserId;
    }
    if (referralCodeUsed != null) {
      $result.referralCodeUsed = referralCodeUsed;
    }
    if (status != null) {
      $result.status = status;
    }
    if (referrerRewardAmount != null) {
      $result.referrerRewardAmount = referrerRewardAmount;
    }
    if (refereeRewardAmount != null) {
      $result.refereeRewardAmount = refereeRewardAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    if (refereeFirstName != null) {
      $result.refereeFirstName = refereeFirstName;
    }
    if (refereeLastName != null) {
      $result.refereeLastName = refereeLastName;
    }
    if (refereeUsername != null) {
      $result.refereeUsername = refereeUsername;
    }
    if (referrerUsername != null) {
      $result.referrerUsername = referrerUsername;
    }
    if (refereeHasJoined != null) {
      $result.refereeHasJoined = refereeHasJoined;
    }
    return $result;
  }
  ReferralTransaction._() : super();
  factory ReferralTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReferralTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReferralTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'referrerUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'refereeUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'referralCodeUsed')
    ..e<ReferralStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ReferralStatus.REFERRAL_STATUS_PENDING, valueOf: ReferralStatus.valueOf, enumValues: ReferralStatus.values)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'referrerRewardAmount', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'refereeRewardAmount', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'failureReason')
    ..aOS(12, _omitFieldNames ? '' : 'refereeFirstName')
    ..aOS(13, _omitFieldNames ? '' : 'refereeLastName')
    ..aOS(14, _omitFieldNames ? '' : 'refereeUsername')
    ..aOS(15, _omitFieldNames ? '' : 'referrerUsername')
    ..aOB(16, _omitFieldNames ? '' : 'refereeHasJoined')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReferralTransaction clone() => ReferralTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReferralTransaction copyWith(void Function(ReferralTransaction) updates) => super.copyWith((message) => updates(message as ReferralTransaction)) as ReferralTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReferralTransaction create() => ReferralTransaction._();
  ReferralTransaction createEmptyInstance() => create();
  static $pb.PbList<ReferralTransaction> createRepeated() => $pb.PbList<ReferralTransaction>();
  @$core.pragma('dart2js:noInline')
  static ReferralTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReferralTransaction>(create);
  static ReferralTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get referrerUserId => $_getI64(1);
  @$pb.TagNumber(2)
  set referrerUserId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReferrerUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferrerUserId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get refereeUserId => $_getI64(2);
  @$pb.TagNumber(3)
  set refereeUserId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefereeUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefereeUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get referralCodeUsed => $_getSZ(3);
  @$pb.TagNumber(4)
  set referralCodeUsed($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReferralCodeUsed() => $_has(3);
  @$pb.TagNumber(4)
  void clearReferralCodeUsed() => clearField(4);

  @$pb.TagNumber(5)
  ReferralStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(ReferralStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get referrerRewardAmount => $_getIZ(5);
  @$pb.TagNumber(6)
  set referrerRewardAmount($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReferrerRewardAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearReferrerRewardAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get refereeRewardAmount => $_getIZ(6);
  @$pb.TagNumber(7)
  set refereeRewardAmount($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRefereeRewardAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearRefereeRewardAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get completedAt => $_getN(9);
  @$pb.TagNumber(10)
  set completedAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCompletedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCompletedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCompletedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get failureReason => $_getSZ(10);
  @$pb.TagNumber(11)
  set failureReason($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasFailureReason() => $_has(10);
  @$pb.TagNumber(11)
  void clearFailureReason() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get refereeFirstName => $_getSZ(11);
  @$pb.TagNumber(12)
  set refereeFirstName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasRefereeFirstName() => $_has(11);
  @$pb.TagNumber(12)
  void clearRefereeFirstName() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get refereeLastName => $_getSZ(12);
  @$pb.TagNumber(13)
  set refereeLastName($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRefereeLastName() => $_has(12);
  @$pb.TagNumber(13)
  void clearRefereeLastName() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get refereeUsername => $_getSZ(13);
  @$pb.TagNumber(14)
  set refereeUsername($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRefereeUsername() => $_has(13);
  @$pb.TagNumber(14)
  void clearRefereeUsername() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get referrerUsername => $_getSZ(14);
  @$pb.TagNumber(15)
  set referrerUsername($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReferrerUsername() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferrerUsername() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get refereeHasJoined => $_getBF(15);
  @$pb.TagNumber(16)
  set refereeHasJoined($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRefereeHasJoined() => $_has(15);
  @$pb.TagNumber(16)
  void clearRefereeHasJoined() => clearField(16);
}

/// CountryRewardConfig message represents country-specific reward configuration
class CountryRewardConfig extends $pb.GeneratedMessage {
  factory CountryRewardConfig({
    $fixnum.Int64? id,
    $core.String? countryCode,
    $core.String? currency,
    $core.int? referrerReward,
    $core.int? refereeReward,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (referrerReward != null) {
      $result.referrerReward = referrerReward;
    }
    if (refereeReward != null) {
      $result.refereeReward = refereeReward;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  CountryRewardConfig._() : super();
  factory CountryRewardConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CountryRewardConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CountryRewardConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'referrerReward', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'refereeReward', $pb.PbFieldType.O3)
    ..aOB(6, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CountryRewardConfig clone() => CountryRewardConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CountryRewardConfig copyWith(void Function(CountryRewardConfig) updates) => super.copyWith((message) => updates(message as CountryRewardConfig)) as CountryRewardConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CountryRewardConfig create() => CountryRewardConfig._();
  CountryRewardConfig createEmptyInstance() => create();
  static $pb.PbList<CountryRewardConfig> createRepeated() => $pb.PbList<CountryRewardConfig>();
  @$core.pragma('dart2js:noInline')
  static CountryRewardConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CountryRewardConfig>(create);
  static CountryRewardConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

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
  $core.int get referrerReward => $_getIZ(3);
  @$pb.TagNumber(4)
  set referrerReward($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReferrerReward() => $_has(3);
  @$pb.TagNumber(4)
  void clearReferrerReward() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get refereeReward => $_getIZ(4);
  @$pb.TagNumber(5)
  set refereeReward($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRefereeReward() => $_has(4);
  @$pb.TagNumber(5)
  void clearRefereeReward() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(5);
  @$pb.TagNumber(6)
  set isActive($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsActive() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureUpdatedAt() => $_ensure(7);
}

/// ReferralStats message represents aggregated referral statistics
class ReferralStats extends $pb.GeneratedMessage {
  factory ReferralStats({
    $fixnum.Int64? totalReferrals,
    $core.int? totalRewardsEarned,
    $core.int? pendingRewards,
    $core.String? currency,
    $core.int? pendingReferrals,
    $core.int? completedReferrals,
  }) {
    final $result = create();
    if (totalReferrals != null) {
      $result.totalReferrals = totalReferrals;
    }
    if (totalRewardsEarned != null) {
      $result.totalRewardsEarned = totalRewardsEarned;
    }
    if (pendingRewards != null) {
      $result.pendingRewards = pendingRewards;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (pendingReferrals != null) {
      $result.pendingReferrals = pendingReferrals;
    }
    if (completedReferrals != null) {
      $result.completedReferrals = completedReferrals;
    }
    return $result;
  }
  ReferralStats._() : super();
  factory ReferralStats.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReferralStats.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReferralStats', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'totalReferrals')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalRewardsEarned', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pendingRewards', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pendingReferrals', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'completedReferrals', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReferralStats clone() => ReferralStats()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReferralStats copyWith(void Function(ReferralStats) updates) => super.copyWith((message) => updates(message as ReferralStats)) as ReferralStats;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReferralStats create() => ReferralStats._();
  ReferralStats createEmptyInstance() => create();
  static $pb.PbList<ReferralStats> createRepeated() => $pb.PbList<ReferralStats>();
  @$core.pragma('dart2js:noInline')
  static ReferralStats getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReferralStats>(create);
  static ReferralStats? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalReferrals => $_getI64(0);
  @$pb.TagNumber(1)
  set totalReferrals($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalReferrals() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalReferrals() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalRewardsEarned => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalRewardsEarned($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalRewardsEarned() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRewardsEarned() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pendingRewards => $_getIZ(2);
  @$pb.TagNumber(3)
  set pendingRewards($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPendingRewards() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingRewards() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pendingReferrals => $_getIZ(4);
  @$pb.TagNumber(5)
  set pendingReferrals($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPendingReferrals() => $_has(4);
  @$pb.TagNumber(5)
  void clearPendingReferrals() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get completedReferrals => $_getIZ(5);
  @$pb.TagNumber(6)
  set completedReferrals($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompletedReferrals() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedReferrals() => clearField(6);
}

/// LeaderboardEntry message represents a top referrer
class LeaderboardEntry extends $pb.GeneratedMessage {
  factory LeaderboardEntry({
    $fixnum.Int64? userId,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? username,
    $fixnum.Int64? totalReferrals,
    $core.int? rank,
    $core.int? totalRewardsEarned,
    $core.String? currency,
    $core.String? profilePicture,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (username != null) {
      $result.username = username;
    }
    if (totalReferrals != null) {
      $result.totalReferrals = totalReferrals;
    }
    if (rank != null) {
      $result.rank = rank;
    }
    if (totalRewardsEarned != null) {
      $result.totalRewardsEarned = totalRewardsEarned;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (profilePicture != null) {
      $result.profilePicture = profilePicture;
    }
    return $result;
  }
  LeaderboardEntry._() : super();
  factory LeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aInt64(5, _omitFieldNames ? '' : 'totalReferrals')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'totalRewardsEarned', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardEntry clone() => LeaderboardEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardEntry copyWith(void Function(LeaderboardEntry) updates) => super.copyWith((message) => updates(message as LeaderboardEntry)) as LeaderboardEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardEntry create() => LeaderboardEntry._();
  LeaderboardEntry createEmptyInstance() => create();
  static $pb.PbList<LeaderboardEntry> createRepeated() => $pb.PbList<LeaderboardEntry>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaderboardEntry>(create);
  static LeaderboardEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalReferrals => $_getI64(4);
  @$pb.TagNumber(5)
  set totalReferrals($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalReferrals() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalReferrals() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get rank => $_getIZ(5);
  @$pb.TagNumber(6)
  set rank($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRank() => $_has(5);
  @$pb.TagNumber(6)
  void clearRank() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get totalRewardsEarned => $_getIZ(6);
  @$pb.TagNumber(7)
  set totalRewardsEarned($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalRewardsEarned() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalRewardsEarned() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get profilePicture => $_getSZ(8);
  @$pb.TagNumber(9)
  set profilePicture($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProfilePicture() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfilePicture() => clearField(9);
}

/// PointTransaction represents a single points ledger entry
class PointTransaction extends $pb.GeneratedMessage {
  factory PointTransaction({
    $fixnum.Int64? id,
    $fixnum.Int64? userId,
    $core.int? points,
    PointSource? source,
    $core.String? referenceId,
    $core.String? description,
    $1.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (points != null) {
      $result.points = points;
    }
    if (source != null) {
      $result.source = source;
    }
    if (referenceId != null) {
      $result.referenceId = referenceId;
    }
    if (description != null) {
      $result.description = description;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  PointTransaction._() : super();
  factory PointTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PointTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PointTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'points', $pb.PbFieldType.O3)
    ..e<PointSource>(4, _omitFieldNames ? '' : 'source', $pb.PbFieldType.OE, defaultOrMaker: PointSource.POINT_SOURCE_REFERRAL, valueOf: PointSource.valueOf, enumValues: PointSource.values)
    ..aOS(5, _omitFieldNames ? '' : 'referenceId')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PointTransaction clone() => PointTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PointTransaction copyWith(void Function(PointTransaction) updates) => super.copyWith((message) => updates(message as PointTransaction)) as PointTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointTransaction create() => PointTransaction._();
  PointTransaction createEmptyInstance() => create();
  static $pb.PbList<PointTransaction> createRepeated() => $pb.PbList<PointTransaction>();
  @$core.pragma('dart2js:noInline')
  static PointTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PointTransaction>(create);
  static PointTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get points => $_getIZ(2);
  @$pb.TagNumber(3)
  set points($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPoints() => $_has(2);
  @$pb.TagNumber(3)
  void clearPoints() => clearField(3);

  @$pb.TagNumber(4)
  PointSource get source => $_getN(3);
  @$pb.TagNumber(4)
  set source(PointSource v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSource() => $_has(3);
  @$pb.TagNumber(4)
  void clearSource() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get referenceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set referenceId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReferenceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReferenceId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCreatedAt() => $_ensure(6);
}

/// PointsBalance represents a user's current points state
class PointsBalance extends $pb.GeneratedMessage {
  factory PointsBalance({
    $core.int? totalEarned,
    $core.int? totalRedeemed,
    $core.int? currentBalance,
    $core.String? tier,
  }) {
    final $result = create();
    if (totalEarned != null) {
      $result.totalEarned = totalEarned;
    }
    if (totalRedeemed != null) {
      $result.totalRedeemed = totalRedeemed;
    }
    if (currentBalance != null) {
      $result.currentBalance = currentBalance;
    }
    if (tier != null) {
      $result.tier = tier;
    }
    return $result;
  }
  PointsBalance._() : super();
  factory PointsBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PointsBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PointsBalance', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalEarned', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalRedeemed', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'currentBalance', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'tier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PointsBalance clone() => PointsBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PointsBalance copyWith(void Function(PointsBalance) updates) => super.copyWith((message) => updates(message as PointsBalance)) as PointsBalance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsBalance create() => PointsBalance._();
  PointsBalance createEmptyInstance() => create();
  static $pb.PbList<PointsBalance> createRepeated() => $pb.PbList<PointsBalance>();
  @$core.pragma('dart2js:noInline')
  static PointsBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PointsBalance>(create);
  static PointsBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalEarned => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalEarned($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalEarned() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalEarned() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalRedeemed => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalRedeemed($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalRedeemed() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRedeemed() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get currentBalance => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentBalance($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get tier => $_getSZ(3);
  @$pb.TagNumber(4)
  set tier($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTier() => $_has(3);
  @$pb.TagNumber(4)
  void clearTier() => clearField(4);
}

/// PointsConfigEntry represents a single earn rule
class PointsConfigEntry extends $pb.GeneratedMessage {
  factory PointsConfigEntry({
    $core.String? source,
    $core.int? pointsAmount,
    $core.String? description,
    $core.bool? isActive,
  }) {
    final $result = create();
    if (source != null) {
      $result.source = source;
    }
    if (pointsAmount != null) {
      $result.pointsAmount = pointsAmount;
    }
    if (description != null) {
      $result.description = description;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    return $result;
  }
  PointsConfigEntry._() : super();
  factory PointsConfigEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PointsConfigEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PointsConfigEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'source')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pointsAmount', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOB(4, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PointsConfigEntry clone() => PointsConfigEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PointsConfigEntry copyWith(void Function(PointsConfigEntry) updates) => super.copyWith((message) => updates(message as PointsConfigEntry)) as PointsConfigEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsConfigEntry create() => PointsConfigEntry._();
  PointsConfigEntry createEmptyInstance() => create();
  static $pb.PbList<PointsConfigEntry> createRepeated() => $pb.PbList<PointsConfigEntry>();
  @$core.pragma('dart2js:noInline')
  static PointsConfigEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PointsConfigEntry>(create);
  static PointsConfigEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get source => $_getSZ(0);
  @$pb.TagNumber(1)
  set source($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pointsAmount => $_getIZ(1);
  @$pb.TagNumber(2)
  set pointsAmount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPointsAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPointsAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isActive => $_getBF(3);
  @$pb.TagNumber(4)
  set isActive($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsActive() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsActive() => clearField(4);
}

/// Request/Response messages for ValidateReferralCode
class ValidateReferralCodeRequest extends $pb.GeneratedMessage {
  factory ValidateReferralCodeRequest({
    $core.String? code,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    return $result;
  }
  ValidateReferralCodeRequest._() : super();
  factory ValidateReferralCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateReferralCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateReferralCodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeRequest clone() => ValidateReferralCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeRequest copyWith(void Function(ValidateReferralCodeRequest) updates) => super.copyWith((message) => updates(message as ValidateReferralCodeRequest)) as ValidateReferralCodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateReferralCodeRequest create() => ValidateReferralCodeRequest._();
  ValidateReferralCodeRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateReferralCodeRequest> createRepeated() => $pb.PbList<ValidateReferralCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateReferralCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateReferralCodeRequest>(create);
  static ValidateReferralCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);
}

class ValidateReferralCodeResponse extends $pb.GeneratedMessage {
  factory ValidateReferralCodeResponse({
    $core.bool? isValid,
    $core.String? message,
  }) {
    final $result = create();
    if (isValid != null) {
      $result.isValid = isValid;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ValidateReferralCodeResponse._() : super();
  factory ValidateReferralCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateReferralCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateReferralCodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeResponse clone() => ValidateReferralCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeResponse copyWith(void Function(ValidateReferralCodeResponse) updates) => super.copyWith((message) => updates(message as ValidateReferralCodeResponse)) as ValidateReferralCodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateReferralCodeResponse create() => ValidateReferralCodeResponse._();
  ValidateReferralCodeResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateReferralCodeResponse> createRepeated() => $pb.PbList<ValidateReferralCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateReferralCodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateReferralCodeResponse>(create);
  static ValidateReferralCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// Request/Response messages for GetMyReferralCode
class GetMyReferralCodeRequest extends $pb.GeneratedMessage {
  factory GetMyReferralCodeRequest() => create();
  GetMyReferralCodeRequest._() : super();
  factory GetMyReferralCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyReferralCodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeRequest clone() => GetMyReferralCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeRequest copyWith(void Function(GetMyReferralCodeRequest) updates) => super.copyWith((message) => updates(message as GetMyReferralCodeRequest)) as GetMyReferralCodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyReferralCodeRequest create() => GetMyReferralCodeRequest._();
  GetMyReferralCodeRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyReferralCodeRequest> createRepeated() => $pb.PbList<GetMyReferralCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyReferralCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyReferralCodeRequest>(create);
  static GetMyReferralCodeRequest? _defaultInstance;
}

class GetMyReferralCodeResponse extends $pb.GeneratedMessage {
  factory GetMyReferralCodeResponse({
    ReferralCode? referralCode,
  }) {
    final $result = create();
    if (referralCode != null) {
      $result.referralCode = referralCode;
    }
    return $result;
  }
  GetMyReferralCodeResponse._() : super();
  factory GetMyReferralCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyReferralCodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ReferralCode>(1, _omitFieldNames ? '' : 'referralCode', subBuilder: ReferralCode.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeResponse clone() => GetMyReferralCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeResponse copyWith(void Function(GetMyReferralCodeResponse) updates) => super.copyWith((message) => updates(message as GetMyReferralCodeResponse)) as GetMyReferralCodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyReferralCodeResponse create() => GetMyReferralCodeResponse._();
  GetMyReferralCodeResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyReferralCodeResponse> createRepeated() => $pb.PbList<GetMyReferralCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyReferralCodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyReferralCodeResponse>(create);
  static GetMyReferralCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ReferralCode get referralCode => $_getN(0);
  @$pb.TagNumber(1)
  set referralCode(ReferralCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReferralCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearReferralCode() => clearField(1);
  @$pb.TagNumber(1)
  ReferralCode ensureReferralCode() => $_ensure(0);
}

/// Request/Response messages for GetMyReferralStats
class GetMyReferralStatsRequest extends $pb.GeneratedMessage {
  factory GetMyReferralStatsRequest() => create();
  GetMyReferralStatsRequest._() : super();
  factory GetMyReferralStatsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralStatsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyReferralStatsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsRequest clone() => GetMyReferralStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsRequest copyWith(void Function(GetMyReferralStatsRequest) updates) => super.copyWith((message) => updates(message as GetMyReferralStatsRequest)) as GetMyReferralStatsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyReferralStatsRequest create() => GetMyReferralStatsRequest._();
  GetMyReferralStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyReferralStatsRequest> createRepeated() => $pb.PbList<GetMyReferralStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyReferralStatsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyReferralStatsRequest>(create);
  static GetMyReferralStatsRequest? _defaultInstance;
}

class GetMyReferralStatsResponse extends $pb.GeneratedMessage {
  factory GetMyReferralStatsResponse({
    ReferralStats? stats,
  }) {
    final $result = create();
    if (stats != null) {
      $result.stats = stats;
    }
    return $result;
  }
  GetMyReferralStatsResponse._() : super();
  factory GetMyReferralStatsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralStatsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyReferralStatsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ReferralStats>(1, _omitFieldNames ? '' : 'stats', subBuilder: ReferralStats.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsResponse clone() => GetMyReferralStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsResponse copyWith(void Function(GetMyReferralStatsResponse) updates) => super.copyWith((message) => updates(message as GetMyReferralStatsResponse)) as GetMyReferralStatsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyReferralStatsResponse create() => GetMyReferralStatsResponse._();
  GetMyReferralStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyReferralStatsResponse> createRepeated() => $pb.PbList<GetMyReferralStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyReferralStatsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyReferralStatsResponse>(create);
  static GetMyReferralStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ReferralStats get stats => $_getN(0);
  @$pb.TagNumber(1)
  set stats(ReferralStats v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStats() => $_has(0);
  @$pb.TagNumber(1)
  void clearStats() => clearField(1);
  @$pb.TagNumber(1)
  ReferralStats ensureStats() => $_ensure(0);
}

/// Request/Response messages for GetMyReferrals
class GetMyReferralsRequest extends $pb.GeneratedMessage {
  factory GetMyReferralsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? filter,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (filter != null) {
      $result.filter = filter;
    }
    return $result;
  }
  GetMyReferralsRequest._() : super();
  factory GetMyReferralsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyReferralsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'filter')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralsRequest clone() => GetMyReferralsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralsRequest copyWith(void Function(GetMyReferralsRequest) updates) => super.copyWith((message) => updates(message as GetMyReferralsRequest)) as GetMyReferralsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyReferralsRequest create() => GetMyReferralsRequest._();
  GetMyReferralsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyReferralsRequest> createRepeated() => $pb.PbList<GetMyReferralsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyReferralsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyReferralsRequest>(create);
  static GetMyReferralsRequest? _defaultInstance;

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
  $core.String get filter => $_getSZ(2);
  @$pb.TagNumber(3)
  set filter($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilter() => clearField(3);
}

class GetMyReferralsResponse extends $pb.GeneratedMessage {
  factory GetMyReferralsResponse({
    $core.Iterable<ReferralTransaction>? referrals,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalCount,
  }) {
    final $result = create();
    if (referrals != null) {
      $result.referrals.addAll(referrals);
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetMyReferralsResponse._() : super();
  factory GetMyReferralsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyReferralsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ReferralTransaction>(1, _omitFieldNames ? '' : 'referrals', $pb.PbFieldType.PM, subBuilder: ReferralTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralsResponse clone() => GetMyReferralsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralsResponse copyWith(void Function(GetMyReferralsResponse) updates) => super.copyWith((message) => updates(message as GetMyReferralsResponse)) as GetMyReferralsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyReferralsResponse create() => GetMyReferralsResponse._();
  GetMyReferralsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyReferralsResponse> createRepeated() => $pb.PbList<GetMyReferralsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyReferralsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyReferralsResponse>(create);
  static GetMyReferralsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ReferralTransaction> get referrals => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => clearField(4);
}

/// Request/Response messages for GetReferralLeaderboard
class GetReferralLeaderboardRequest extends $pb.GeneratedMessage {
  factory GetReferralLeaderboardRequest({
    $core.int? limit,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetReferralLeaderboardRequest._() : super();
  factory GetReferralLeaderboardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReferralLeaderboardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReferralLeaderboardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardRequest clone() => GetReferralLeaderboardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardRequest copyWith(void Function(GetReferralLeaderboardRequest) updates) => super.copyWith((message) => updates(message as GetReferralLeaderboardRequest)) as GetReferralLeaderboardRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReferralLeaderboardRequest create() => GetReferralLeaderboardRequest._();
  GetReferralLeaderboardRequest createEmptyInstance() => create();
  static $pb.PbList<GetReferralLeaderboardRequest> createRepeated() => $pb.PbList<GetReferralLeaderboardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReferralLeaderboardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReferralLeaderboardRequest>(create);
  static GetReferralLeaderboardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);
}

class GetReferralLeaderboardResponse extends $pb.GeneratedMessage {
  factory GetReferralLeaderboardResponse({
    $core.Iterable<LeaderboardEntry>? entries,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    return $result;
  }
  GetReferralLeaderboardResponse._() : super();
  factory GetReferralLeaderboardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReferralLeaderboardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReferralLeaderboardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<LeaderboardEntry>(1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: LeaderboardEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardResponse clone() => GetReferralLeaderboardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardResponse copyWith(void Function(GetReferralLeaderboardResponse) updates) => super.copyWith((message) => updates(message as GetReferralLeaderboardResponse)) as GetReferralLeaderboardResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReferralLeaderboardResponse create() => GetReferralLeaderboardResponse._();
  GetReferralLeaderboardResponse createEmptyInstance() => create();
  static $pb.PbList<GetReferralLeaderboardResponse> createRepeated() => $pb.PbList<GetReferralLeaderboardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReferralLeaderboardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReferralLeaderboardResponse>(create);
  static GetReferralLeaderboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LeaderboardEntry> get entries => $_getList(0);
}

/// Request/Response messages for GetCountryRewardConfig
class GetCountryRewardConfigRequest extends $pb.GeneratedMessage {
  factory GetCountryRewardConfigRequest({
    $core.String? countryCode,
  }) {
    final $result = create();
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    return $result;
  }
  GetCountryRewardConfigRequest._() : super();
  factory GetCountryRewardConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRewardConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCountryRewardConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigRequest clone() => GetCountryRewardConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigRequest copyWith(void Function(GetCountryRewardConfigRequest) updates) => super.copyWith((message) => updates(message as GetCountryRewardConfigRequest)) as GetCountryRewardConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCountryRewardConfigRequest create() => GetCountryRewardConfigRequest._();
  GetCountryRewardConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetCountryRewardConfigRequest> createRepeated() => $pb.PbList<GetCountryRewardConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRewardConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCountryRewardConfigRequest>(create);
  static GetCountryRewardConfigRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);
}

class GetCountryRewardConfigResponse extends $pb.GeneratedMessage {
  factory GetCountryRewardConfigResponse({
    CountryRewardConfig? config,
  }) {
    final $result = create();
    if (config != null) {
      $result.config = config;
    }
    return $result;
  }
  GetCountryRewardConfigResponse._() : super();
  factory GetCountryRewardConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRewardConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCountryRewardConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CountryRewardConfig>(1, _omitFieldNames ? '' : 'config', subBuilder: CountryRewardConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigResponse clone() => GetCountryRewardConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigResponse copyWith(void Function(GetCountryRewardConfigResponse) updates) => super.copyWith((message) => updates(message as GetCountryRewardConfigResponse)) as GetCountryRewardConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCountryRewardConfigResponse create() => GetCountryRewardConfigResponse._();
  GetCountryRewardConfigResponse createEmptyInstance() => create();
  static $pb.PbList<GetCountryRewardConfigResponse> createRepeated() => $pb.PbList<GetCountryRewardConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRewardConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCountryRewardConfigResponse>(create);
  static GetCountryRewardConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CountryRewardConfig get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(CountryRewardConfig v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => clearField(1);
  @$pb.TagNumber(1)
  CountryRewardConfig ensureConfig() => $_ensure(0);
}

/// Request/Response messages for RecordReferral
class RecordReferralRequest extends $pb.GeneratedMessage {
  factory RecordReferralRequest({
    $fixnum.Int64? refereeUserId,
    $core.String? referralCode,
  }) {
    final $result = create();
    if (refereeUserId != null) {
      $result.refereeUserId = refereeUserId;
    }
    if (referralCode != null) {
      $result.referralCode = referralCode;
    }
    return $result;
  }
  RecordReferralRequest._() : super();
  factory RecordReferralRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordReferralRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecordReferralRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'refereeUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'referralCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordReferralRequest clone() => RecordReferralRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordReferralRequest copyWith(void Function(RecordReferralRequest) updates) => super.copyWith((message) => updates(message as RecordReferralRequest)) as RecordReferralRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordReferralRequest create() => RecordReferralRequest._();
  RecordReferralRequest createEmptyInstance() => create();
  static $pb.PbList<RecordReferralRequest> createRepeated() => $pb.PbList<RecordReferralRequest>();
  @$core.pragma('dart2js:noInline')
  static RecordReferralRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordReferralRequest>(create);
  static RecordReferralRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get refereeUserId => $_getI64(0);
  @$pb.TagNumber(1)
  set refereeUserId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefereeUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefereeUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get referralCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set referralCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReferralCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferralCode() => clearField(2);
}

class RecordReferralResponse extends $pb.GeneratedMessage {
  factory RecordReferralResponse({
    $core.bool? success,
    $core.String? message,
    ReferralTransaction? transaction,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  RecordReferralResponse._() : super();
  factory RecordReferralResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordReferralResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecordReferralResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<ReferralTransaction>(3, _omitFieldNames ? '' : 'transaction', subBuilder: ReferralTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordReferralResponse clone() => RecordReferralResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordReferralResponse copyWith(void Function(RecordReferralResponse) updates) => super.copyWith((message) => updates(message as RecordReferralResponse)) as RecordReferralResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordReferralResponse create() => RecordReferralResponse._();
  RecordReferralResponse createEmptyInstance() => create();
  static $pb.PbList<RecordReferralResponse> createRepeated() => $pb.PbList<RecordReferralResponse>();
  @$core.pragma('dart2js:noInline')
  static RecordReferralResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordReferralResponse>(create);
  static RecordReferralResponse? _defaultInstance;

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
  ReferralTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(ReferralTransaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  ReferralTransaction ensureTransaction() => $_ensure(2);
}

/// Request/Response messages for CreditReferralRewards
class CreditReferralRewardsRequest extends $pb.GeneratedMessage {
  factory CreditReferralRewardsRequest({
    $fixnum.Int64? transactionId,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  CreditReferralRewardsRequest._() : super();
  factory CreditReferralRewardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditReferralRewardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditReferralRewardsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsRequest clone() => CreditReferralRewardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsRequest copyWith(void Function(CreditReferralRewardsRequest) updates) => super.copyWith((message) => updates(message as CreditReferralRewardsRequest)) as CreditReferralRewardsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditReferralRewardsRequest create() => CreditReferralRewardsRequest._();
  CreditReferralRewardsRequest createEmptyInstance() => create();
  static $pb.PbList<CreditReferralRewardsRequest> createRepeated() => $pb.PbList<CreditReferralRewardsRequest>();
  @$core.pragma('dart2js:noInline')
  static CreditReferralRewardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditReferralRewardsRequest>(create);
  static CreditReferralRewardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get transactionId => $_getI64(0);
  @$pb.TagNumber(1)
  set transactionId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
}

class CreditReferralRewardsResponse extends $pb.GeneratedMessage {
  factory CreditReferralRewardsResponse({
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
  CreditReferralRewardsResponse._() : super();
  factory CreditReferralRewardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditReferralRewardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditReferralRewardsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsResponse clone() => CreditReferralRewardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsResponse copyWith(void Function(CreditReferralRewardsResponse) updates) => super.copyWith((message) => updates(message as CreditReferralRewardsResponse)) as CreditReferralRewardsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditReferralRewardsResponse create() => CreditReferralRewardsResponse._();
  CreditReferralRewardsResponse createEmptyInstance() => create();
  static $pb.PbList<CreditReferralRewardsResponse> createRepeated() => $pb.PbList<CreditReferralRewardsResponse>();
  @$core.pragma('dart2js:noInline')
  static CreditReferralRewardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditReferralRewardsResponse>(create);
  static CreditReferralRewardsResponse? _defaultInstance;

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

/// Request/Response messages for LazerPoints
class GetMyPointsBalanceRequest extends $pb.GeneratedMessage {
  factory GetMyPointsBalanceRequest() => create();
  GetMyPointsBalanceRequest._() : super();
  factory GetMyPointsBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyPointsBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceRequest clone() => GetMyPointsBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceRequest copyWith(void Function(GetMyPointsBalanceRequest) updates) => super.copyWith((message) => updates(message as GetMyPointsBalanceRequest)) as GetMyPointsBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyPointsBalanceRequest create() => GetMyPointsBalanceRequest._();
  GetMyPointsBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyPointsBalanceRequest> createRepeated() => $pb.PbList<GetMyPointsBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyPointsBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyPointsBalanceRequest>(create);
  static GetMyPointsBalanceRequest? _defaultInstance;
}

class GetMyPointsBalanceResponse extends $pb.GeneratedMessage {
  factory GetMyPointsBalanceResponse({
    PointsBalance? balance,
  }) {
    final $result = create();
    if (balance != null) {
      $result.balance = balance;
    }
    return $result;
  }
  GetMyPointsBalanceResponse._() : super();
  factory GetMyPointsBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyPointsBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PointsBalance>(1, _omitFieldNames ? '' : 'balance', subBuilder: PointsBalance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceResponse clone() => GetMyPointsBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceResponse copyWith(void Function(GetMyPointsBalanceResponse) updates) => super.copyWith((message) => updates(message as GetMyPointsBalanceResponse)) as GetMyPointsBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyPointsBalanceResponse create() => GetMyPointsBalanceResponse._();
  GetMyPointsBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyPointsBalanceResponse> createRepeated() => $pb.PbList<GetMyPointsBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyPointsBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyPointsBalanceResponse>(create);
  static GetMyPointsBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PointsBalance get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance(PointsBalance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);
  @$pb.TagNumber(1)
  PointsBalance ensureBalance() => $_ensure(0);
}

class GetMyPointsHistoryRequest extends $pb.GeneratedMessage {
  factory GetMyPointsHistoryRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetMyPointsHistoryRequest._() : super();
  factory GetMyPointsHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyPointsHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryRequest clone() => GetMyPointsHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryRequest copyWith(void Function(GetMyPointsHistoryRequest) updates) => super.copyWith((message) => updates(message as GetMyPointsHistoryRequest)) as GetMyPointsHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyPointsHistoryRequest create() => GetMyPointsHistoryRequest._();
  GetMyPointsHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyPointsHistoryRequest> createRepeated() => $pb.PbList<GetMyPointsHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyPointsHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyPointsHistoryRequest>(create);
  static GetMyPointsHistoryRequest? _defaultInstance;

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

class GetMyPointsHistoryResponse extends $pb.GeneratedMessage {
  factory GetMyPointsHistoryResponse({
    $core.Iterable<PointTransaction>? transactions,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalCount,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetMyPointsHistoryResponse._() : super();
  factory GetMyPointsHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyPointsHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PointTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: PointTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryResponse clone() => GetMyPointsHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryResponse copyWith(void Function(GetMyPointsHistoryResponse) updates) => super.copyWith((message) => updates(message as GetMyPointsHistoryResponse)) as GetMyPointsHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyPointsHistoryResponse create() => GetMyPointsHistoryResponse._();
  GetMyPointsHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyPointsHistoryResponse> createRepeated() => $pb.PbList<GetMyPointsHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyPointsHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyPointsHistoryResponse>(create);
  static GetMyPointsHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PointTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => clearField(4);
}

class GetPointsConfigRequest extends $pb.GeneratedMessage {
  factory GetPointsConfigRequest() => create();
  GetPointsConfigRequest._() : super();
  factory GetPointsConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPointsConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPointsConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPointsConfigRequest clone() => GetPointsConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPointsConfigRequest copyWith(void Function(GetPointsConfigRequest) updates) => super.copyWith((message) => updates(message as GetPointsConfigRequest)) as GetPointsConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPointsConfigRequest create() => GetPointsConfigRequest._();
  GetPointsConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetPointsConfigRequest> createRepeated() => $pb.PbList<GetPointsConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPointsConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPointsConfigRequest>(create);
  static GetPointsConfigRequest? _defaultInstance;
}

class GetPointsConfigResponse extends $pb.GeneratedMessage {
  factory GetPointsConfigResponse({
    $core.Iterable<PointsConfigEntry>? configs,
  }) {
    final $result = create();
    if (configs != null) {
      $result.configs.addAll(configs);
    }
    return $result;
  }
  GetPointsConfigResponse._() : super();
  factory GetPointsConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPointsConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPointsConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PointsConfigEntry>(1, _omitFieldNames ? '' : 'configs', $pb.PbFieldType.PM, subBuilder: PointsConfigEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPointsConfigResponse clone() => GetPointsConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPointsConfigResponse copyWith(void Function(GetPointsConfigResponse) updates) => super.copyWith((message) => updates(message as GetPointsConfigResponse)) as GetPointsConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPointsConfigResponse create() => GetPointsConfigResponse._();
  GetPointsConfigResponse createEmptyInstance() => create();
  static $pb.PbList<GetPointsConfigResponse> createRepeated() => $pb.PbList<GetPointsConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPointsConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPointsConfigResponse>(create);
  static GetPointsConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PointsConfigEntry> get configs => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
