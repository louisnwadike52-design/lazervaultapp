///
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'referral.pbenum.dart';

export 'referral.pbenum.dart';

class ReferralCode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReferralCode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ReferralCode._() : super();
  factory ReferralCode({
    $fixnum.Int64? id,
    $fixnum.Int64? userId,
    $core.String? code,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (code != null) {
      _result.code = code;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory ReferralCode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReferralCode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReferralCode clone() => ReferralCode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReferralCode copyWith(void Function(ReferralCode) updates) => super.copyWith((message) => updates(message as ReferralCode)) as ReferralCode; // ignore: deprecated_member_use
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

class ReferralTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReferralTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referrerUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referralCodeUsed')
    ..e<ReferralStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ReferralStatus.REFERRAL_STATUS_PENDING, valueOf: ReferralStatus.valueOf, enumValues: ReferralStatus.values)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referrerRewardAmount', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeRewardAmount', $pb.PbFieldType.O3)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeFirstName')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeLastName')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeUsername')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referrerUsername')
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeHasJoined')
    ..hasRequiredFields = false
  ;

  ReferralTransaction._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (referrerUserId != null) {
      _result.referrerUserId = referrerUserId;
    }
    if (refereeUserId != null) {
      _result.refereeUserId = refereeUserId;
    }
    if (referralCodeUsed != null) {
      _result.referralCodeUsed = referralCodeUsed;
    }
    if (status != null) {
      _result.status = status;
    }
    if (referrerRewardAmount != null) {
      _result.referrerRewardAmount = referrerRewardAmount;
    }
    if (refereeRewardAmount != null) {
      _result.refereeRewardAmount = refereeRewardAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (refereeFirstName != null) {
      _result.refereeFirstName = refereeFirstName;
    }
    if (refereeLastName != null) {
      _result.refereeLastName = refereeLastName;
    }
    if (refereeUsername != null) {
      _result.refereeUsername = refereeUsername;
    }
    if (referrerUsername != null) {
      _result.referrerUsername = referrerUsername;
    }
    if (refereeHasJoined != null) {
      _result.refereeHasJoined = refereeHasJoined;
    }
    return _result;
  }
  factory ReferralTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReferralTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReferralTransaction clone() => ReferralTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReferralTransaction copyWith(void Function(ReferralTransaction) updates) => super.copyWith((message) => updates(message as ReferralTransaction)) as ReferralTransaction; // ignore: deprecated_member_use
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

class CountryRewardConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CountryRewardConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referrerReward', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeReward', $pb.PbFieldType.O3)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CountryRewardConfig._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (referrerReward != null) {
      _result.referrerReward = referrerReward;
    }
    if (refereeReward != null) {
      _result.refereeReward = refereeReward;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory CountryRewardConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CountryRewardConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CountryRewardConfig clone() => CountryRewardConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CountryRewardConfig copyWith(void Function(CountryRewardConfig) updates) => super.copyWith((message) => updates(message as CountryRewardConfig)) as CountryRewardConfig; // ignore: deprecated_member_use
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

class ReferralStats extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReferralStats', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalReferrals')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRewardsEarned', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingRewards', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingReferrals', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedReferrals', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReferralStats._() : super();
  factory ReferralStats({
    $fixnum.Int64? totalReferrals,
    $core.int? totalRewardsEarned,
    $core.int? pendingRewards,
    $core.String? currency,
    $core.int? pendingReferrals,
    $core.int? completedReferrals,
  }) {
    final _result = create();
    if (totalReferrals != null) {
      _result.totalReferrals = totalReferrals;
    }
    if (totalRewardsEarned != null) {
      _result.totalRewardsEarned = totalRewardsEarned;
    }
    if (pendingRewards != null) {
      _result.pendingRewards = pendingRewards;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (pendingReferrals != null) {
      _result.pendingReferrals = pendingReferrals;
    }
    if (completedReferrals != null) {
      _result.completedReferrals = completedReferrals;
    }
    return _result;
  }
  factory ReferralStats.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReferralStats.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReferralStats clone() => ReferralStats()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReferralStats copyWith(void Function(ReferralStats) updates) => super.copyWith((message) => updates(message as ReferralStats)) as ReferralStats; // ignore: deprecated_member_use
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

class LeaderboardEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LeaderboardEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalReferrals')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rank', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRewardsEarned', $pb.PbFieldType.O3)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  LeaderboardEntry._() : super();
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
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (username != null) {
      _result.username = username;
    }
    if (totalReferrals != null) {
      _result.totalReferrals = totalReferrals;
    }
    if (rank != null) {
      _result.rank = rank;
    }
    if (totalRewardsEarned != null) {
      _result.totalRewardsEarned = totalRewardsEarned;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    return _result;
  }
  factory LeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardEntry clone() => LeaderboardEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardEntry copyWith(void Function(LeaderboardEntry) updates) => super.copyWith((message) => updates(message as LeaderboardEntry)) as LeaderboardEntry; // ignore: deprecated_member_use
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

class PointTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PointTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'points', $pb.PbFieldType.O3)
    ..e<PointSource>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source', $pb.PbFieldType.OE, defaultOrMaker: PointSource.POINT_SOURCE_REFERRAL, valueOf: PointSource.valueOf, enumValues: PointSource.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PointTransaction._() : super();
  factory PointTransaction({
    $fixnum.Int64? id,
    $fixnum.Int64? userId,
    $core.int? points,
    PointSource? source,
    $core.String? referenceId,
    $core.String? description,
    $1.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (points != null) {
      _result.points = points;
    }
    if (source != null) {
      _result.source = source;
    }
    if (referenceId != null) {
      _result.referenceId = referenceId;
    }
    if (description != null) {
      _result.description = description;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory PointTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PointTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PointTransaction clone() => PointTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PointTransaction copyWith(void Function(PointTransaction) updates) => super.copyWith((message) => updates(message as PointTransaction)) as PointTransaction; // ignore: deprecated_member_use
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

class PointsBalance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PointsBalance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalEarned', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRedeemed', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentBalance', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier')
    ..hasRequiredFields = false
  ;

  PointsBalance._() : super();
  factory PointsBalance({
    $core.int? totalEarned,
    $core.int? totalRedeemed,
    $core.int? currentBalance,
    $core.String? tier,
  }) {
    final _result = create();
    if (totalEarned != null) {
      _result.totalEarned = totalEarned;
    }
    if (totalRedeemed != null) {
      _result.totalRedeemed = totalRedeemed;
    }
    if (currentBalance != null) {
      _result.currentBalance = currentBalance;
    }
    if (tier != null) {
      _result.tier = tier;
    }
    return _result;
  }
  factory PointsBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PointsBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PointsBalance clone() => PointsBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PointsBalance copyWith(void Function(PointsBalance) updates) => super.copyWith((message) => updates(message as PointsBalance)) as PointsBalance; // ignore: deprecated_member_use
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

class PointsConfigEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PointsConfigEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pointsAmount', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  PointsConfigEntry._() : super();
  factory PointsConfigEntry({
    $core.String? source,
    $core.int? pointsAmount,
    $core.String? description,
    $core.bool? isActive,
  }) {
    final _result = create();
    if (source != null) {
      _result.source = source;
    }
    if (pointsAmount != null) {
      _result.pointsAmount = pointsAmount;
    }
    if (description != null) {
      _result.description = description;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory PointsConfigEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PointsConfigEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PointsConfigEntry clone() => PointsConfigEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PointsConfigEntry copyWith(void Function(PointsConfigEntry) updates) => super.copyWith((message) => updates(message as PointsConfigEntry)) as PointsConfigEntry; // ignore: deprecated_member_use
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

class ValidateReferralCodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateReferralCodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..hasRequiredFields = false
  ;

  ValidateReferralCodeRequest._() : super();
  factory ValidateReferralCodeRequest({
    $core.String? code,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    return _result;
  }
  factory ValidateReferralCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateReferralCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeRequest clone() => ValidateReferralCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeRequest copyWith(void Function(ValidateReferralCodeRequest) updates) => super.copyWith((message) => updates(message as ValidateReferralCodeRequest)) as ValidateReferralCodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateReferralCodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ValidateReferralCodeResponse._() : super();
  factory ValidateReferralCodeResponse({
    $core.bool? isValid,
    $core.String? message,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ValidateReferralCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateReferralCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeResponse clone() => ValidateReferralCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateReferralCodeResponse copyWith(void Function(ValidateReferralCodeResponse) updates) => super.copyWith((message) => updates(message as ValidateReferralCodeResponse)) as ValidateReferralCodeResponse; // ignore: deprecated_member_use
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

class GetMyReferralCodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyReferralCodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyReferralCodeRequest._() : super();
  factory GetMyReferralCodeRequest() => create();
  factory GetMyReferralCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeRequest clone() => GetMyReferralCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeRequest copyWith(void Function(GetMyReferralCodeRequest) updates) => super.copyWith((message) => updates(message as GetMyReferralCodeRequest)) as GetMyReferralCodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyReferralCodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ReferralCode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referralCode', subBuilder: ReferralCode.create)
    ..hasRequiredFields = false
  ;

  GetMyReferralCodeResponse._() : super();
  factory GetMyReferralCodeResponse({
    ReferralCode? referralCode,
  }) {
    final _result = create();
    if (referralCode != null) {
      _result.referralCode = referralCode;
    }
    return _result;
  }
  factory GetMyReferralCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeResponse clone() => GetMyReferralCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralCodeResponse copyWith(void Function(GetMyReferralCodeResponse) updates) => super.copyWith((message) => updates(message as GetMyReferralCodeResponse)) as GetMyReferralCodeResponse; // ignore: deprecated_member_use
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

class GetMyReferralStatsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyReferralStatsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyReferralStatsRequest._() : super();
  factory GetMyReferralStatsRequest() => create();
  factory GetMyReferralStatsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralStatsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsRequest clone() => GetMyReferralStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsRequest copyWith(void Function(GetMyReferralStatsRequest) updates) => super.copyWith((message) => updates(message as GetMyReferralStatsRequest)) as GetMyReferralStatsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyReferralStatsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ReferralStats>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stats', subBuilder: ReferralStats.create)
    ..hasRequiredFields = false
  ;

  GetMyReferralStatsResponse._() : super();
  factory GetMyReferralStatsResponse({
    ReferralStats? stats,
  }) {
    final _result = create();
    if (stats != null) {
      _result.stats = stats;
    }
    return _result;
  }
  factory GetMyReferralStatsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralStatsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsResponse clone() => GetMyReferralStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralStatsResponse copyWith(void Function(GetMyReferralStatsResponse) updates) => super.copyWith((message) => updates(message as GetMyReferralStatsResponse)) as GetMyReferralStatsResponse; // ignore: deprecated_member_use
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

class GetMyReferralsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyReferralsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter')
    ..hasRequiredFields = false
  ;

  GetMyReferralsRequest._() : super();
  factory GetMyReferralsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? filter,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (filter != null) {
      _result.filter = filter;
    }
    return _result;
  }
  factory GetMyReferralsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralsRequest clone() => GetMyReferralsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralsRequest copyWith(void Function(GetMyReferralsRequest) updates) => super.copyWith((message) => updates(message as GetMyReferralsRequest)) as GetMyReferralsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyReferralsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ReferralTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referrals', $pb.PbFieldType.PM, subBuilder: ReferralTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyReferralsResponse._() : super();
  factory GetMyReferralsResponse({
    $core.Iterable<ReferralTransaction>? referrals,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (referrals != null) {
      _result.referrals.addAll(referrals);
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetMyReferralsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyReferralsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyReferralsResponse clone() => GetMyReferralsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyReferralsResponse copyWith(void Function(GetMyReferralsResponse) updates) => super.copyWith((message) => updates(message as GetMyReferralsResponse)) as GetMyReferralsResponse; // ignore: deprecated_member_use
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

class GetReferralLeaderboardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReferralLeaderboardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetReferralLeaderboardRequest._() : super();
  factory GetReferralLeaderboardRequest({
    $core.int? limit,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetReferralLeaderboardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReferralLeaderboardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardRequest clone() => GetReferralLeaderboardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardRequest copyWith(void Function(GetReferralLeaderboardRequest) updates) => super.copyWith((message) => updates(message as GetReferralLeaderboardRequest)) as GetReferralLeaderboardRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReferralLeaderboardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<LeaderboardEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: LeaderboardEntry.create)
    ..hasRequiredFields = false
  ;

  GetReferralLeaderboardResponse._() : super();
  factory GetReferralLeaderboardResponse({
    $core.Iterable<LeaderboardEntry>? entries,
  }) {
    final _result = create();
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    return _result;
  }
  factory GetReferralLeaderboardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReferralLeaderboardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardResponse clone() => GetReferralLeaderboardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReferralLeaderboardResponse copyWith(void Function(GetReferralLeaderboardResponse) updates) => super.copyWith((message) => updates(message as GetReferralLeaderboardResponse)) as GetReferralLeaderboardResponse; // ignore: deprecated_member_use
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

class GetCountryRewardConfigRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCountryRewardConfigRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  GetCountryRewardConfigRequest._() : super();
  factory GetCountryRewardConfigRequest({
    $core.String? countryCode,
  }) {
    final _result = create();
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory GetCountryRewardConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRewardConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigRequest clone() => GetCountryRewardConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigRequest copyWith(void Function(GetCountryRewardConfigRequest) updates) => super.copyWith((message) => updates(message as GetCountryRewardConfigRequest)) as GetCountryRewardConfigRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCountryRewardConfigResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CountryRewardConfig>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'config', subBuilder: CountryRewardConfig.create)
    ..hasRequiredFields = false
  ;

  GetCountryRewardConfigResponse._() : super();
  factory GetCountryRewardConfigResponse({
    CountryRewardConfig? config,
  }) {
    final _result = create();
    if (config != null) {
      _result.config = config;
    }
    return _result;
  }
  factory GetCountryRewardConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRewardConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigResponse clone() => GetCountryRewardConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRewardConfigResponse copyWith(void Function(GetCountryRewardConfigResponse) updates) => super.copyWith((message) => updates(message as GetCountryRewardConfigResponse)) as GetCountryRewardConfigResponse; // ignore: deprecated_member_use
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

class RecordReferralRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordReferralRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refereeUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referralCode')
    ..hasRequiredFields = false
  ;

  RecordReferralRequest._() : super();
  factory RecordReferralRequest({
    $fixnum.Int64? refereeUserId,
    $core.String? referralCode,
  }) {
    final _result = create();
    if (refereeUserId != null) {
      _result.refereeUserId = refereeUserId;
    }
    if (referralCode != null) {
      _result.referralCode = referralCode;
    }
    return _result;
  }
  factory RecordReferralRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordReferralRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordReferralRequest clone() => RecordReferralRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordReferralRequest copyWith(void Function(RecordReferralRequest) updates) => super.copyWith((message) => updates(message as RecordReferralRequest)) as RecordReferralRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordReferralResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<ReferralTransaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: ReferralTransaction.create)
    ..hasRequiredFields = false
  ;

  RecordReferralResponse._() : super();
  factory RecordReferralResponse({
    $core.bool? success,
    $core.String? message,
    ReferralTransaction? transaction,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory RecordReferralResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordReferralResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordReferralResponse clone() => RecordReferralResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordReferralResponse copyWith(void Function(RecordReferralResponse) updates) => super.copyWith((message) => updates(message as RecordReferralResponse)) as RecordReferralResponse; // ignore: deprecated_member_use
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

class CreditReferralRewardsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreditReferralRewardsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  CreditReferralRewardsRequest._() : super();
  factory CreditReferralRewardsRequest({
    $fixnum.Int64? transactionId,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory CreditReferralRewardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditReferralRewardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsRequest clone() => CreditReferralRewardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsRequest copyWith(void Function(CreditReferralRewardsRequest) updates) => super.copyWith((message) => updates(message as CreditReferralRewardsRequest)) as CreditReferralRewardsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreditReferralRewardsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreditReferralRewardsResponse._() : super();
  factory CreditReferralRewardsResponse({
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
  factory CreditReferralRewardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditReferralRewardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsResponse clone() => CreditReferralRewardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditReferralRewardsResponse copyWith(void Function(CreditReferralRewardsResponse) updates) => super.copyWith((message) => updates(message as CreditReferralRewardsResponse)) as CreditReferralRewardsResponse; // ignore: deprecated_member_use
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

class GetMyPointsBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyPointsBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyPointsBalanceRequest._() : super();
  factory GetMyPointsBalanceRequest() => create();
  factory GetMyPointsBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceRequest clone() => GetMyPointsBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceRequest copyWith(void Function(GetMyPointsBalanceRequest) updates) => super.copyWith((message) => updates(message as GetMyPointsBalanceRequest)) as GetMyPointsBalanceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyPointsBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PointsBalance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', subBuilder: PointsBalance.create)
    ..hasRequiredFields = false
  ;

  GetMyPointsBalanceResponse._() : super();
  factory GetMyPointsBalanceResponse({
    PointsBalance? balance,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    return _result;
  }
  factory GetMyPointsBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceResponse clone() => GetMyPointsBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsBalanceResponse copyWith(void Function(GetMyPointsBalanceResponse) updates) => super.copyWith((message) => updates(message as GetMyPointsBalanceResponse)) as GetMyPointsBalanceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyPointsHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyPointsHistoryRequest._() : super();
  factory GetMyPointsHistoryRequest({
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
  factory GetMyPointsHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryRequest clone() => GetMyPointsHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryRequest copyWith(void Function(GetMyPointsHistoryRequest) updates) => super.copyWith((message) => updates(message as GetMyPointsHistoryRequest)) as GetMyPointsHistoryRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyPointsHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PointTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: PointTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyPointsHistoryResponse._() : super();
  factory GetMyPointsHistoryResponse({
    $core.Iterable<PointTransaction>? transactions,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetMyPointsHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPointsHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryResponse clone() => GetMyPointsHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPointsHistoryResponse copyWith(void Function(GetMyPointsHistoryResponse) updates) => super.copyWith((message) => updates(message as GetMyPointsHistoryResponse)) as GetMyPointsHistoryResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPointsConfigRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetPointsConfigRequest._() : super();
  factory GetPointsConfigRequest() => create();
  factory GetPointsConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPointsConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPointsConfigRequest clone() => GetPointsConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPointsConfigRequest copyWith(void Function(GetPointsConfigRequest) updates) => super.copyWith((message) => updates(message as GetPointsConfigRequest)) as GetPointsConfigRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPointsConfigResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PointsConfigEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'configs', $pb.PbFieldType.PM, subBuilder: PointsConfigEntry.create)
    ..hasRequiredFields = false
  ;

  GetPointsConfigResponse._() : super();
  factory GetPointsConfigResponse({
    $core.Iterable<PointsConfigEntry>? configs,
  }) {
    final _result = create();
    if (configs != null) {
      _result.configs.addAll(configs);
    }
    return _result;
  }
  factory GetPointsConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPointsConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPointsConfigResponse clone() => GetPointsConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPointsConfigResponse copyWith(void Function(GetPointsConfigResponse) updates) => super.copyWith((message) => updates(message as GetPointsConfigResponse)) as GetPointsConfigResponse; // ignore: deprecated_member_use
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

