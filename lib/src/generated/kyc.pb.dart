///
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $48;

import 'kyc.pbenum.dart';

export 'kyc.pbenum.dart';

class CountryKYCRequirements extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CountryKYCRequirements', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..pc<IDType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'acceptedIdTypes', $pb.PbFieldType.KE, valueOf: IDType.valueOf, enumValues: IDType.values, defaultEnumValue: IDType.ID_UNKNOWN)
    ..pc<IDType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandatoryIdTypes', $pb.PbFieldType.KE, valueOf: IDType.valueOf, enumValues: IDType.values, defaultEnumValue: IDType.ID_UNKNOWN)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addressProofRequired')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'livenessCheckRequired')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier1DailyLimit', protoName: 'tier_1_daily_limit')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier2DailyLimit', protoName: 'tier_2_daily_limit')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier3DailyLimit', protoName: 'tier_3_daily_limit')
    ..hasRequiredFields = false
  ;

  CountryKYCRequirements._() : super();
  factory CountryKYCRequirements({
    $core.String? countryCode,
    $core.Iterable<IDType>? acceptedIdTypes,
    $core.Iterable<IDType>? mandatoryIdTypes,
    $core.bool? addressProofRequired,
    $core.bool? livenessCheckRequired,
    $fixnum.Int64? tier1DailyLimit,
    $fixnum.Int64? tier2DailyLimit,
    $fixnum.Int64? tier3DailyLimit,
  }) {
    final _result = create();
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (acceptedIdTypes != null) {
      _result.acceptedIdTypes.addAll(acceptedIdTypes);
    }
    if (mandatoryIdTypes != null) {
      _result.mandatoryIdTypes.addAll(mandatoryIdTypes);
    }
    if (addressProofRequired != null) {
      _result.addressProofRequired = addressProofRequired;
    }
    if (livenessCheckRequired != null) {
      _result.livenessCheckRequired = livenessCheckRequired;
    }
    if (tier1DailyLimit != null) {
      _result.tier1DailyLimit = tier1DailyLimit;
    }
    if (tier2DailyLimit != null) {
      _result.tier2DailyLimit = tier2DailyLimit;
    }
    if (tier3DailyLimit != null) {
      _result.tier3DailyLimit = tier3DailyLimit;
    }
    return _result;
  }
  factory CountryKYCRequirements.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CountryKYCRequirements.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CountryKYCRequirements clone() => CountryKYCRequirements()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CountryKYCRequirements copyWith(void Function(CountryKYCRequirements) updates) => super.copyWith((message) => updates(message as CountryKYCRequirements)) as CountryKYCRequirements; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CountryKYCRequirements create() => CountryKYCRequirements._();
  CountryKYCRequirements createEmptyInstance() => create();
  static $pb.PbList<CountryKYCRequirements> createRepeated() => $pb.PbList<CountryKYCRequirements>();
  @$core.pragma('dart2js:noInline')
  static CountryKYCRequirements getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CountryKYCRequirements>(create);
  static CountryKYCRequirements? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<IDType> get acceptedIdTypes => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<IDType> get mandatoryIdTypes => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get addressProofRequired => $_getBF(3);
  @$pb.TagNumber(4)
  set addressProofRequired($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddressProofRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddressProofRequired() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get livenessCheckRequired => $_getBF(4);
  @$pb.TagNumber(5)
  set livenessCheckRequired($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLivenessCheckRequired() => $_has(4);
  @$pb.TagNumber(5)
  void clearLivenessCheckRequired() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get tier1DailyLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set tier1DailyLimit($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTier1DailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearTier1DailyLimit() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get tier2DailyLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set tier2DailyLimit($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTier2DailyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearTier2DailyLimit() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get tier3DailyLimit => $_getI64(7);
  @$pb.TagNumber(8)
  set tier3DailyLimit($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTier3DailyLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearTier3DailyLimit() => clearField(8);
}

class KYCTierInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KYCTierInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..e<KYCTier>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..e<KYCStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'benefits')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyTransactionLimit')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyReceiveLimit')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxBalance')
    ..aOM<$48.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $48.Timestamp.create)
    ..aOM<$48.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $48.Timestamp.create)
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isCurrent')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..hasRequiredFields = false
  ;

  KYCTierInfo._() : super();
  factory KYCTierInfo({
    KYCTier? tier,
    KYCStatus? status,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$core.String>? benefits,
    $fixnum.Int64? dailyTransactionLimit,
    $fixnum.Int64? dailyReceiveLimit,
    $fixnum.Int64? maxBalance,
    $48.Timestamp? verifiedAt,
    $48.Timestamp? expiresAt,
    $core.bool? isCurrent,
    $core.bool? isLocked,
  }) {
    final _result = create();
    if (tier != null) {
      _result.tier = tier;
    }
    if (status != null) {
      _result.status = status;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (description != null) {
      _result.description = description;
    }
    if (benefits != null) {
      _result.benefits.addAll(benefits);
    }
    if (dailyTransactionLimit != null) {
      _result.dailyTransactionLimit = dailyTransactionLimit;
    }
    if (dailyReceiveLimit != null) {
      _result.dailyReceiveLimit = dailyReceiveLimit;
    }
    if (maxBalance != null) {
      _result.maxBalance = maxBalance;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (isCurrent != null) {
      _result.isCurrent = isCurrent;
    }
    if (isLocked != null) {
      _result.isLocked = isLocked;
    }
    return _result;
  }
  factory KYCTierInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KYCTierInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KYCTierInfo clone() => KYCTierInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KYCTierInfo copyWith(void Function(KYCTierInfo) updates) => super.copyWith((message) => updates(message as KYCTierInfo)) as KYCTierInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KYCTierInfo create() => KYCTierInfo._();
  KYCTierInfo createEmptyInstance() => create();
  static $pb.PbList<KYCTierInfo> createRepeated() => $pb.PbList<KYCTierInfo>();
  @$core.pragma('dart2js:noInline')
  static KYCTierInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KYCTierInfo>(create);
  static KYCTierInfo? _defaultInstance;

  @$pb.TagNumber(1)
  KYCTier get tier => $_getN(0);
  @$pb.TagNumber(1)
  set tier(KYCTier v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => clearField(1);

  @$pb.TagNumber(2)
  KYCStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get benefits => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get dailyTransactionLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set dailyTransactionLimit($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDailyTransactionLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyTransactionLimit() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get dailyReceiveLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set dailyReceiveLimit($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDailyReceiveLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearDailyReceiveLimit() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get maxBalance => $_getI64(7);
  @$pb.TagNumber(8)
  set maxBalance($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxBalance() => clearField(8);

  @$pb.TagNumber(9)
  $48.Timestamp get verifiedAt => $_getN(8);
  @$pb.TagNumber(9)
  set verifiedAt($48.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasVerifiedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerifiedAt() => clearField(9);
  @$pb.TagNumber(9)
  $48.Timestamp ensureVerifiedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $48.Timestamp get expiresAt => $_getN(9);
  @$pb.TagNumber(10)
  set expiresAt($48.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => clearField(10);
  @$pb.TagNumber(10)
  $48.Timestamp ensureExpiresAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.bool get isCurrent => $_getBF(10);
  @$pb.TagNumber(11)
  set isCurrent($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIsCurrent() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsCurrent() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isLocked => $_getBF(11);
  @$pb.TagNumber(12)
  set isLocked($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsLocked() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsLocked() => clearField(12);
}

class VerifyIDRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyIDRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<IDType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  VerifyIDRequest._() : super();
  factory VerifyIDRequest({
    $core.String? userId,
    IDType? idType,
    $core.String? idNumber,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (idType != null) {
      _result.idType = idType;
    }
    if (idNumber != null) {
      _result.idNumber = idNumber;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    return _result;
  }
  factory VerifyIDRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDRequest clone() => VerifyIDRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDRequest copyWith(void Function(VerifyIDRequest) updates) => super.copyWith((message) => updates(message as VerifyIDRequest)) as VerifyIDRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyIDRequest create() => VerifyIDRequest._();
  VerifyIDRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyIDRequest> createRepeated() => $pb.PbList<VerifyIDRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyIDRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyIDRequest>(create);
  static VerifyIDRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  IDType get idType => $_getN(1);
  @$pb.TagNumber(2)
  set idType(IDType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdType() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get idNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set idNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIdNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get firstName => $_getSZ(3);
  @$pb.TagNumber(4)
  set firstName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFirstName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastName => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastName() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dateOfBirth => $_getSZ(5);
  @$pb.TagNumber(6)
  set dateOfBirth($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDateOfBirth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDateOfBirth() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => clearField(7);
}

class UploadDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<IDType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentFrontUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentBackUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selfieUrl')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proofOfAddressUrl')
    ..hasRequiredFields = false
  ;

  UploadDocumentRequest._() : super();
  factory UploadDocumentRequest({
    $core.String? userId,
    IDType? documentType,
    $core.String? documentFrontUrl,
    $core.String? documentBackUrl,
    $core.String? selfieUrl,
    $core.String? proofOfAddressUrl,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (documentFrontUrl != null) {
      _result.documentFrontUrl = documentFrontUrl;
    }
    if (documentBackUrl != null) {
      _result.documentBackUrl = documentBackUrl;
    }
    if (selfieUrl != null) {
      _result.selfieUrl = selfieUrl;
    }
    if (proofOfAddressUrl != null) {
      _result.proofOfAddressUrl = proofOfAddressUrl;
    }
    return _result;
  }
  factory UploadDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadDocumentRequest clone() => UploadDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadDocumentRequest copyWith(void Function(UploadDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadDocumentRequest)) as UploadDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest create() => UploadDocumentRequest._();
  UploadDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadDocumentRequest> createRepeated() => $pb.PbList<UploadDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadDocumentRequest>(create);
  static UploadDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  IDType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(IDType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentFrontUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentFrontUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentFrontUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentFrontUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get documentBackUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set documentBackUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDocumentBackUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearDocumentBackUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get selfieUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set selfieUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSelfieUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearSelfieUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get proofOfAddressUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set proofOfAddressUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProofOfAddressUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearProofOfAddressUrl() => clearField(6);
}

class VerifyIDResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyIDResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..e<KYCStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..e<KYCTier>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOM<$48.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $48.Timestamp.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  VerifyIDResponse._() : super();
  factory VerifyIDResponse({
    $core.bool? success,
    $core.String? message,
    KYCStatus? status,
    KYCTier? currentTier,
    $48.Timestamp? verifiedAt,
    $core.String? reference,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (status != null) {
      _result.status = status;
    }
    if (currentTier != null) {
      _result.currentTier = currentTier;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    return _result;
  }
  factory VerifyIDResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDResponse clone() => VerifyIDResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDResponse copyWith(void Function(VerifyIDResponse) updates) => super.copyWith((message) => updates(message as VerifyIDResponse)) as VerifyIDResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyIDResponse create() => VerifyIDResponse._();
  VerifyIDResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyIDResponse> createRepeated() => $pb.PbList<VerifyIDResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyIDResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyIDResponse>(create);
  static VerifyIDResponse? _defaultInstance;

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
  KYCStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(KYCStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  KYCTier get currentTier => $_getN(3);
  @$pb.TagNumber(4)
  set currentTier(KYCTier v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentTier() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentTier() => clearField(4);

  @$pb.TagNumber(5)
  $48.Timestamp get verifiedAt => $_getN(4);
  @$pb.TagNumber(5)
  set verifiedAt($48.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerifiedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerifiedAt() => clearField(5);
  @$pb.TagNumber(5)
  $48.Timestamp ensureVerifiedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);
}

class GetKYCStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetKYCStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetKYCStatusRequest._() : super();
  factory GetKYCStatusRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetKYCStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetKYCStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetKYCStatusRequest clone() => GetKYCStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetKYCStatusRequest copyWith(void Function(GetKYCStatusRequest) updates) => super.copyWith((message) => updates(message as GetKYCStatusRequest)) as GetKYCStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusRequest create() => GetKYCStatusRequest._();
  GetKYCStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetKYCStatusRequest> createRepeated() => $pb.PbList<GetKYCStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetKYCStatusRequest>(create);
  static GetKYCStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetKYCStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetKYCStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..e<KYCStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..e<KYCTier>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..pc<KYCTierInfo>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tierInfo', $pb.PbFieldType.PM, subBuilder: KYCTierInfo.create)
    ..aOM<$48.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $48.Timestamp.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  GetKYCStatusResponse._() : super();
  factory GetKYCStatusResponse({
    $core.bool? success,
    KYCStatus? status,
    KYCTier? currentTier,
    $core.Iterable<KYCTierInfo>? tierInfo,
    $48.Timestamp? lastUpdated,
    $core.String? rejectionReason,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (status != null) {
      _result.status = status;
    }
    if (currentTier != null) {
      _result.currentTier = currentTier;
    }
    if (tierInfo != null) {
      _result.tierInfo.addAll(tierInfo);
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    return _result;
  }
  factory GetKYCStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetKYCStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetKYCStatusResponse clone() => GetKYCStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetKYCStatusResponse copyWith(void Function(GetKYCStatusResponse) updates) => super.copyWith((message) => updates(message as GetKYCStatusResponse)) as GetKYCStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusResponse create() => GetKYCStatusResponse._();
  GetKYCStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetKYCStatusResponse> createRepeated() => $pb.PbList<GetKYCStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetKYCStatusResponse>(create);
  static GetKYCStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  KYCStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  KYCTier get currentTier => $_getN(2);
  @$pb.TagNumber(3)
  set currentTier(KYCTier v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTier() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<KYCTierInfo> get tierInfo => $_getList(3);

  @$pb.TagNumber(5)
  $48.Timestamp get lastUpdated => $_getN(4);
  @$pb.TagNumber(5)
  set lastUpdated($48.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => clearField(5);
  @$pb.TagNumber(5)
  $48.Timestamp ensureLastUpdated() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get rejectionReason => $_getSZ(5);
  @$pb.TagNumber(6)
  set rejectionReason($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRejectionReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearRejectionReason() => clearField(6);
}

class SkipKYCRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SkipKYCRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'skipTier2', protoName: 'skip_tier_2')
    ..hasRequiredFields = false
  ;

  SkipKYCRequest._() : super();
  factory SkipKYCRequest({
    $core.String? userId,
    $core.bool? skipTier2,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (skipTier2 != null) {
      _result.skipTier2 = skipTier2;
    }
    return _result;
  }
  factory SkipKYCRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SkipKYCRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SkipKYCRequest clone() => SkipKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SkipKYCRequest copyWith(void Function(SkipKYCRequest) updates) => super.copyWith((message) => updates(message as SkipKYCRequest)) as SkipKYCRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SkipKYCRequest create() => SkipKYCRequest._();
  SkipKYCRequest createEmptyInstance() => create();
  static $pb.PbList<SkipKYCRequest> createRepeated() => $pb.PbList<SkipKYCRequest>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SkipKYCRequest>(create);
  static SkipKYCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get skipTier2 => $_getBF(1);
  @$pb.TagNumber(2)
  set skipTier2($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSkipTier2() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkipTier2() => clearField(2);
}

class SkipKYCResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SkipKYCResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..e<KYCTier>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assignedTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextSteps')
    ..hasRequiredFields = false
  ;

  SkipKYCResponse._() : super();
  factory SkipKYCResponse({
    $core.bool? success,
    KYCTier? assignedTier,
    $core.String? message,
    $core.Iterable<$core.String>? nextSteps,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (assignedTier != null) {
      _result.assignedTier = assignedTier;
    }
    if (message != null) {
      _result.message = message;
    }
    if (nextSteps != null) {
      _result.nextSteps.addAll(nextSteps);
    }
    return _result;
  }
  factory SkipKYCResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SkipKYCResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SkipKYCResponse clone() => SkipKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SkipKYCResponse copyWith(void Function(SkipKYCResponse) updates) => super.copyWith((message) => updates(message as SkipKYCResponse)) as SkipKYCResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SkipKYCResponse create() => SkipKYCResponse._();
  SkipKYCResponse createEmptyInstance() => create();
  static $pb.PbList<SkipKYCResponse> createRepeated() => $pb.PbList<SkipKYCResponse>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SkipKYCResponse>(create);
  static SkipKYCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  KYCTier get assignedTier => $_getN(1);
  @$pb.TagNumber(2)
  set assignedTier(KYCTier v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAssignedTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssignedTier() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get nextSteps => $_getList(3);
}

class GetCountryRequirementsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCountryRequirementsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  GetCountryRequirementsRequest._() : super();
  factory GetCountryRequirementsRequest({
    $core.String? countryCode,
  }) {
    final _result = create();
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory GetCountryRequirementsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRequirementsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsRequest clone() => GetCountryRequirementsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsRequest copyWith(void Function(GetCountryRequirementsRequest) updates) => super.copyWith((message) => updates(message as GetCountryRequirementsRequest)) as GetCountryRequirementsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsRequest create() => GetCountryRequirementsRequest._();
  GetCountryRequirementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCountryRequirementsRequest> createRepeated() => $pb.PbList<GetCountryRequirementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCountryRequirementsRequest>(create);
  static GetCountryRequirementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);
}

class GetCountryRequirementsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCountryRequirementsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOM<CountryKYCRequirements>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requirements', subBuilder: CountryKYCRequirements.create)
    ..hasRequiredFields = false
  ;

  GetCountryRequirementsResponse._() : super();
  factory GetCountryRequirementsResponse({
    $core.bool? success,
    CountryKYCRequirements? requirements,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (requirements != null) {
      _result.requirements = requirements;
    }
    return _result;
  }
  factory GetCountryRequirementsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRequirementsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsResponse clone() => GetCountryRequirementsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsResponse copyWith(void Function(GetCountryRequirementsResponse) updates) => super.copyWith((message) => updates(message as GetCountryRequirementsResponse)) as GetCountryRequirementsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsResponse create() => GetCountryRequirementsResponse._();
  GetCountryRequirementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCountryRequirementsResponse> createRepeated() => $pb.PbList<GetCountryRequirementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCountryRequirementsResponse>(create);
  static GetCountryRequirementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  CountryKYCRequirements get requirements => $_getN(1);
  @$pb.TagNumber(2)
  set requirements(CountryKYCRequirements v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequirements() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequirements() => clearField(2);
  @$pb.TagNumber(2)
  CountryKYCRequirements ensureRequirements() => $_ensure(1);
}

class InitiateKYCRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateKYCRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<KYCTier>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..hasRequiredFields = false
  ;

  InitiateKYCRequest._() : super();
  factory InitiateKYCRequest({
    $core.String? userId,
    KYCTier? targetTier,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (targetTier != null) {
      _result.targetTier = targetTier;
    }
    return _result;
  }
  factory InitiateKYCRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateKYCRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateKYCRequest clone() => InitiateKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateKYCRequest copyWith(void Function(InitiateKYCRequest) updates) => super.copyWith((message) => updates(message as InitiateKYCRequest)) as InitiateKYCRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest create() => InitiateKYCRequest._();
  InitiateKYCRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCRequest> createRepeated() => $pb.PbList<InitiateKYCRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateKYCRequest>(create);
  static InitiateKYCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  KYCTier get targetTier => $_getN(1);
  @$pb.TagNumber(2)
  set targetTier(KYCTier v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetTier() => clearField(2);
}

class InitiateKYCResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateKYCResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredDocuments')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredFields')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redirectUrl')
    ..hasRequiredFields = false
  ;

  InitiateKYCResponse._() : super();
  factory InitiateKYCResponse({
    $core.bool? success,
    $core.String? sessionId,
    $core.Iterable<$core.String>? requiredDocuments,
    $core.Iterable<$core.String>? requiredFields,
    $core.String? redirectUrl,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (requiredDocuments != null) {
      _result.requiredDocuments.addAll(requiredDocuments);
    }
    if (requiredFields != null) {
      _result.requiredFields.addAll(requiredFields);
    }
    if (redirectUrl != null) {
      _result.redirectUrl = redirectUrl;
    }
    return _result;
  }
  factory InitiateKYCResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateKYCResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateKYCResponse clone() => InitiateKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateKYCResponse copyWith(void Function(InitiateKYCResponse) updates) => super.copyWith((message) => updates(message as InitiateKYCResponse)) as InitiateKYCResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse create() => InitiateKYCResponse._();
  InitiateKYCResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCResponse> createRepeated() => $pb.PbList<InitiateKYCResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateKYCResponse>(create);
  static InitiateKYCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get requiredDocuments => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get requiredFields => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get redirectUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set redirectUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRedirectUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedirectUrl() => clearField(5);
}

class VerificationDocument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerificationDocument', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<IDType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentUrl')
    ..e<DocumentStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DocumentStatus.DOC_STATUS_UNKNOWN, valueOf: DocumentStatus.valueOf, enumValues: DocumentStatus.values)
    ..aOM<$48.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadedAt', subBuilder: $48.Timestamp.create)
    ..aOM<$48.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $48.Timestamp.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  VerificationDocument._() : super();
  factory VerificationDocument({
    $core.String? id,
    IDType? documentType,
    $core.String? documentUrl,
    DocumentStatus? status,
    $48.Timestamp? uploadedAt,
    $48.Timestamp? verifiedAt,
    $core.String? rejectionReason,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (documentUrl != null) {
      _result.documentUrl = documentUrl;
    }
    if (status != null) {
      _result.status = status;
    }
    if (uploadedAt != null) {
      _result.uploadedAt = uploadedAt;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    return _result;
  }
  factory VerificationDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerificationDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerificationDocument clone() => VerificationDocument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerificationDocument copyWith(void Function(VerificationDocument) updates) => super.copyWith((message) => updates(message as VerificationDocument)) as VerificationDocument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerificationDocument create() => VerificationDocument._();
  VerificationDocument createEmptyInstance() => create();
  static $pb.PbList<VerificationDocument> createRepeated() => $pb.PbList<VerificationDocument>();
  @$core.pragma('dart2js:noInline')
  static VerificationDocument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerificationDocument>(create);
  static VerificationDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  IDType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(IDType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentUrl() => clearField(3);

  @$pb.TagNumber(4)
  DocumentStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(DocumentStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $48.Timestamp get uploadedAt => $_getN(4);
  @$pb.TagNumber(5)
  set uploadedAt($48.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUploadedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUploadedAt() => clearField(5);
  @$pb.TagNumber(5)
  $48.Timestamp ensureUploadedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $48.Timestamp get verifiedAt => $_getN(5);
  @$pb.TagNumber(6)
  set verifiedAt($48.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerifiedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerifiedAt() => clearField(6);
  @$pb.TagNumber(6)
  $48.Timestamp ensureVerifiedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get rejectionReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set rejectionReason($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRejectionReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearRejectionReason() => clearField(7);
}

class GetUserDocumentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDocumentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetUserDocumentsRequest._() : super();
  factory GetUserDocumentsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetUserDocumentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDocumentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDocumentsRequest clone() => GetUserDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDocumentsRequest copyWith(void Function(GetUserDocumentsRequest) updates) => super.copyWith((message) => updates(message as GetUserDocumentsRequest)) as GetUserDocumentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest create() => GetUserDocumentsRequest._();
  GetUserDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsRequest> createRepeated() => $pb.PbList<GetUserDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsRequest>(create);
  static GetUserDocumentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetUserDocumentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDocumentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..pc<VerificationDocument>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: VerificationDocument.create)
    ..hasRequiredFields = false
  ;

  GetUserDocumentsResponse._() : super();
  factory GetUserDocumentsResponse({
    $core.bool? success,
    $core.Iterable<VerificationDocument>? documents,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    return _result;
  }
  factory GetUserDocumentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDocumentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDocumentsResponse clone() => GetUserDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDocumentsResponse copyWith(void Function(GetUserDocumentsResponse) updates) => super.copyWith((message) => updates(message as GetUserDocumentsResponse)) as GetUserDocumentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse create() => GetUserDocumentsResponse._();
  GetUserDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsResponse> createRepeated() => $pb.PbList<GetUserDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsResponse>(create);
  static GetUserDocumentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<VerificationDocument> get documents => $_getList(1);
}

class CreateVerificationSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateVerificationSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<KYCTier>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..e<IDType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  CreateVerificationSessionRequest._() : super();
  factory CreateVerificationSessionRequest({
    $core.String? userId,
    KYCTier? targetTier,
    $core.String? countryCode,
    IDType? idType,
    $core.String? idNumber,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (targetTier != null) {
      _result.targetTier = targetTier;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (idType != null) {
      _result.idType = idType;
    }
    if (idNumber != null) {
      _result.idNumber = idNumber;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    return _result;
  }
  factory CreateVerificationSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVerificationSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVerificationSessionRequest clone() => CreateVerificationSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVerificationSessionRequest copyWith(void Function(CreateVerificationSessionRequest) updates) => super.copyWith((message) => updates(message as CreateVerificationSessionRequest)) as CreateVerificationSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionRequest create() => CreateVerificationSessionRequest._();
  CreateVerificationSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVerificationSessionRequest> createRepeated() => $pb.PbList<CreateVerificationSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVerificationSessionRequest>(create);
  static CreateVerificationSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  KYCTier get targetTier => $_getN(1);
  @$pb.TagNumber(2)
  set targetTier(KYCTier v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetTier() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountryCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryCode() => clearField(3);

  @$pb.TagNumber(4)
  IDType get idType => $_getN(3);
  @$pb.TagNumber(4)
  set idType(IDType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdType() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set idNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get firstName => $_getSZ(5);
  @$pb.TagNumber(6)
  set firstName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFirstName() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirstName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get lastName => $_getSZ(6);
  @$pb.TagNumber(7)
  set lastName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastName() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get dateOfBirth => $_getSZ(7);
  @$pb.TagNumber(8)
  set dateOfBirth($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDateOfBirth() => $_has(7);
  @$pb.TagNumber(8)
  void clearDateOfBirth() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get phoneNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set phoneNumber($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPhoneNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneNumber() => clearField(9);
}

class CreateVerificationSessionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateVerificationSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionToken')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..e<KYCStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  CreateVerificationSessionResponse._() : super();
  factory CreateVerificationSessionResponse({
    $core.bool? success,
    $core.String? verificationId,
    $core.String? sessionUrl,
    $core.String? sessionToken,
    $core.String? provider,
    KYCStatus? status,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (verificationId != null) {
      _result.verificationId = verificationId;
    }
    if (sessionUrl != null) {
      _result.sessionUrl = sessionUrl;
    }
    if (sessionToken != null) {
      _result.sessionToken = sessionToken;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (status != null) {
      _result.status = status;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory CreateVerificationSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVerificationSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVerificationSessionResponse clone() => CreateVerificationSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVerificationSessionResponse copyWith(void Function(CreateVerificationSessionResponse) updates) => super.copyWith((message) => updates(message as CreateVerificationSessionResponse)) as CreateVerificationSessionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionResponse create() => CreateVerificationSessionResponse._();
  CreateVerificationSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateVerificationSessionResponse> createRepeated() => $pb.PbList<CreateVerificationSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVerificationSessionResponse>(create);
  static CreateVerificationSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVerificationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSessionUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSessionToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionToken() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => clearField(5);

  @$pb.TagNumber(6)
  KYCStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(KYCStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorMessage($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasErrorMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorMessage() => clearField(7);
}

class ConfirmVerificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConfirmVerificationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerAuthCode')
    ..m<$core.String, $core.String>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'ConfirmVerificationRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('kyc'))
    ..hasRequiredFields = false
  ;

  ConfirmVerificationRequest._() : super();
  factory ConfirmVerificationRequest({
    $core.String? verificationId,
    $core.String? provider,
    $core.String? providerAuthCode,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (verificationId != null) {
      _result.verificationId = verificationId;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (providerAuthCode != null) {
      _result.providerAuthCode = providerAuthCode;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory ConfirmVerificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfirmVerificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfirmVerificationRequest clone() => ConfirmVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfirmVerificationRequest copyWith(void Function(ConfirmVerificationRequest) updates) => super.copyWith((message) => updates(message as ConfirmVerificationRequest)) as ConfirmVerificationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationRequest create() => ConfirmVerificationRequest._();
  ConfirmVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<ConfirmVerificationRequest> createRepeated() => $pb.PbList<ConfirmVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfirmVerificationRequest>(create);
  static ConfirmVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get verificationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVerificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerAuthCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerAuthCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderAuthCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderAuthCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class ConfirmVerificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConfirmVerificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..e<KYCStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..e<KYCTier>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ConfirmVerificationResponse._() : super();
  factory ConfirmVerificationResponse({
    $core.bool? success,
    KYCStatus? status,
    KYCTier? currentTier,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (status != null) {
      _result.status = status;
    }
    if (currentTier != null) {
      _result.currentTier = currentTier;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ConfirmVerificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfirmVerificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfirmVerificationResponse clone() => ConfirmVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfirmVerificationResponse copyWith(void Function(ConfirmVerificationResponse) updates) => super.copyWith((message) => updates(message as ConfirmVerificationResponse)) as ConfirmVerificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationResponse create() => ConfirmVerificationResponse._();
  ConfirmVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<ConfirmVerificationResponse> createRepeated() => $pb.PbList<ConfirmVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfirmVerificationResponse>(create);
  static ConfirmVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  KYCStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  KYCTier get currentTier => $_getN(2);
  @$pb.TagNumber(3)
  set currentTier(KYCTier v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTier() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class GetDocumentUploadURLRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDocumentUploadURLRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType')
    ..hasRequiredFields = false
  ;

  GetDocumentUploadURLRequest._() : super();
  factory GetDocumentUploadURLRequest({
    $core.String? documentType,
    $core.String? contentType,
  }) {
    final _result = create();
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (contentType != null) {
      _result.contentType = contentType;
    }
    return _result;
  }
  factory GetDocumentUploadURLRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDocumentUploadURLRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDocumentUploadURLRequest clone() => GetDocumentUploadURLRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDocumentUploadURLRequest copyWith(void Function(GetDocumentUploadURLRequest) updates) => super.copyWith((message) => updates(message as GetDocumentUploadURLRequest)) as GetDocumentUploadURLRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLRequest create() => GetDocumentUploadURLRequest._();
  GetDocumentUploadURLRequest createEmptyInstance() => create();
  static $pb.PbList<GetDocumentUploadURLRequest> createRepeated() => $pb.PbList<GetDocumentUploadURLRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDocumentUploadURLRequest>(create);
  static GetDocumentUploadURLRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => clearField(2);
}

class GetDocumentUploadURLResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDocumentUploadURLResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadUrl')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'storageKey')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..hasRequiredFields = false
  ;

  GetDocumentUploadURLResponse._() : super();
  factory GetDocumentUploadURLResponse({
    $core.bool? success,
    $core.String? uploadUrl,
    $core.String? storageKey,
    $fixnum.Int64? expiresAt,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (uploadUrl != null) {
      _result.uploadUrl = uploadUrl;
    }
    if (storageKey != null) {
      _result.storageKey = storageKey;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory GetDocumentUploadURLResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDocumentUploadURLResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDocumentUploadURLResponse clone() => GetDocumentUploadURLResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDocumentUploadURLResponse copyWith(void Function(GetDocumentUploadURLResponse) updates) => super.copyWith((message) => updates(message as GetDocumentUploadURLResponse)) as GetDocumentUploadURLResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLResponse create() => GetDocumentUploadURLResponse._();
  GetDocumentUploadURLResponse createEmptyInstance() => create();
  static $pb.PbList<GetDocumentUploadURLResponse> createRepeated() => $pb.PbList<GetDocumentUploadURLResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDocumentUploadURLResponse>(create);
  static GetDocumentUploadURLResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get uploadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set uploadUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUploadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUploadUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get storageKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set storageKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStorageKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearStorageKey() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
}

class SubmitDocumentsForReviewRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitDocumentsForReviewRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..pc<DocumentSubmission>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: DocumentSubmission.create)
    ..hasRequiredFields = false
  ;

  SubmitDocumentsForReviewRequest._() : super();
  factory SubmitDocumentsForReviewRequest({
    $core.String? userId,
    $core.Iterable<DocumentSubmission>? documents,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    return _result;
  }
  factory SubmitDocumentsForReviewRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitDocumentsForReviewRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitDocumentsForReviewRequest clone() => SubmitDocumentsForReviewRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitDocumentsForReviewRequest copyWith(void Function(SubmitDocumentsForReviewRequest) updates) => super.copyWith((message) => updates(message as SubmitDocumentsForReviewRequest)) as SubmitDocumentsForReviewRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewRequest create() => SubmitDocumentsForReviewRequest._();
  SubmitDocumentsForReviewRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitDocumentsForReviewRequest> createRepeated() => $pb.PbList<SubmitDocumentsForReviewRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitDocumentsForReviewRequest>(create);
  static SubmitDocumentsForReviewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<DocumentSubmission> get documents => $_getList(1);
}

class DocumentSubmission extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DocumentSubmission', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'storageKey')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType')
    ..hasRequiredFields = false
  ;

  DocumentSubmission._() : super();
  factory DocumentSubmission({
    $core.String? storageKey,
    $core.String? documentType,
    $core.String? contentType,
  }) {
    final _result = create();
    if (storageKey != null) {
      _result.storageKey = storageKey;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (contentType != null) {
      _result.contentType = contentType;
    }
    return _result;
  }
  factory DocumentSubmission.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DocumentSubmission.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DocumentSubmission clone() => DocumentSubmission()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DocumentSubmission copyWith(void Function(DocumentSubmission) updates) => super.copyWith((message) => updates(message as DocumentSubmission)) as DocumentSubmission; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DocumentSubmission create() => DocumentSubmission._();
  DocumentSubmission createEmptyInstance() => create();
  static $pb.PbList<DocumentSubmission> createRepeated() => $pb.PbList<DocumentSubmission>();
  @$core.pragma('dart2js:noInline')
  static DocumentSubmission getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DocumentSubmission>(create);
  static DocumentSubmission? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storageKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set storageKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStorageKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearStorageKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get contentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set contentType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearContentType() => clearField(3);
}

class SubmitDocumentsForReviewResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitDocumentsForReviewResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..e<KYCStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..hasRequiredFields = false
  ;

  SubmitDocumentsForReviewResponse._() : super();
  factory SubmitDocumentsForReviewResponse({
    $core.bool? success,
    $core.String? message,
    KYCStatus? status,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory SubmitDocumentsForReviewResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitDocumentsForReviewResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitDocumentsForReviewResponse clone() => SubmitDocumentsForReviewResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitDocumentsForReviewResponse copyWith(void Function(SubmitDocumentsForReviewResponse) updates) => super.copyWith((message) => updates(message as SubmitDocumentsForReviewResponse)) as SubmitDocumentsForReviewResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewResponse create() => SubmitDocumentsForReviewResponse._();
  SubmitDocumentsForReviewResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitDocumentsForReviewResponse> createRepeated() => $pb.PbList<SubmitDocumentsForReviewResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitDocumentsForReviewResponse>(create);
  static SubmitDocumentsForReviewResponse? _defaultInstance;

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
  KYCStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(KYCStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class GetPendingReviewsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingReviewsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPendingReviewsRequest._() : super();
  factory GetPendingReviewsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetPendingReviewsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingReviewsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingReviewsRequest clone() => GetPendingReviewsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingReviewsRequest copyWith(void Function(GetPendingReviewsRequest) updates) => super.copyWith((message) => updates(message as GetPendingReviewsRequest)) as GetPendingReviewsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsRequest create() => GetPendingReviewsRequest._();
  GetPendingReviewsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingReviewsRequest> createRepeated() => $pb.PbList<GetPendingReviewsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingReviewsRequest>(create);
  static GetPendingReviewsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetPendingReviewsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingReviewsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..pc<PendingReviewItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: PendingReviewItem.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPendingReviewsResponse._() : super();
  factory GetPendingReviewsResponse({
    $core.bool? success,
    $core.Iterable<PendingReviewItem>? items,
    $core.int? total,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetPendingReviewsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingReviewsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingReviewsResponse clone() => GetPendingReviewsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingReviewsResponse copyWith(void Function(GetPendingReviewsResponse) updates) => super.copyWith((message) => updates(message as GetPendingReviewsResponse)) as GetPendingReviewsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsResponse create() => GetPendingReviewsResponse._();
  GetPendingReviewsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingReviewsResponse> createRepeated() => $pb.PbList<GetPendingReviewsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingReviewsResponse>(create);
  static GetPendingReviewsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<PendingReviewItem> get items => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => clearField(3);
}

class PendingReviewItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PendingReviewItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..e<KYCTier>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..e<KYCTier>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..pc<VerificationDocument>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: VerificationDocument.create)
    ..aOM<$48.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'submittedAt', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PendingReviewItem._() : super();
  factory PendingReviewItem({
    $core.String? userId,
    $core.String? userName,
    $core.String? countryCode,
    KYCTier? currentTier,
    KYCTier? targetTier,
    $core.Iterable<VerificationDocument>? documents,
    $48.Timestamp? submittedAt,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (currentTier != null) {
      _result.currentTier = currentTier;
    }
    if (targetTier != null) {
      _result.targetTier = targetTier;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (submittedAt != null) {
      _result.submittedAt = submittedAt;
    }
    return _result;
  }
  factory PendingReviewItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingReviewItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingReviewItem clone() => PendingReviewItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingReviewItem copyWith(void Function(PendingReviewItem) updates) => super.copyWith((message) => updates(message as PendingReviewItem)) as PendingReviewItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PendingReviewItem create() => PendingReviewItem._();
  PendingReviewItem createEmptyInstance() => create();
  static $pb.PbList<PendingReviewItem> createRepeated() => $pb.PbList<PendingReviewItem>();
  @$core.pragma('dart2js:noInline')
  static PendingReviewItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingReviewItem>(create);
  static PendingReviewItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(1);
  @$pb.TagNumber(2)
  set userName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountryCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryCode() => clearField(3);

  @$pb.TagNumber(4)
  KYCTier get currentTier => $_getN(3);
  @$pb.TagNumber(4)
  set currentTier(KYCTier v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentTier() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentTier() => clearField(4);

  @$pb.TagNumber(5)
  KYCTier get targetTier => $_getN(4);
  @$pb.TagNumber(5)
  set targetTier(KYCTier v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetTier() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetTier() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<VerificationDocument> get documents => $_getList(5);

  @$pb.TagNumber(7)
  $48.Timestamp get submittedAt => $_getN(6);
  @$pb.TagNumber(7)
  set submittedAt($48.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSubmittedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearSubmittedAt() => clearField(7);
  @$pb.TagNumber(7)
  $48.Timestamp ensureSubmittedAt() => $_ensure(6);
}

class ReviewDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReviewDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approved')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminNotes')
    ..hasRequiredFields = false
  ;

  ReviewDocumentRequest._() : super();
  factory ReviewDocumentRequest({
    $core.String? documentId,
    $core.bool? approved,
    $core.String? rejectionReason,
    $core.String? adminNotes,
  }) {
    final _result = create();
    if (documentId != null) {
      _result.documentId = documentId;
    }
    if (approved != null) {
      _result.approved = approved;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (adminNotes != null) {
      _result.adminNotes = adminNotes;
    }
    return _result;
  }
  factory ReviewDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReviewDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReviewDocumentRequest clone() => ReviewDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReviewDocumentRequest copyWith(void Function(ReviewDocumentRequest) updates) => super.copyWith((message) => updates(message as ReviewDocumentRequest)) as ReviewDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReviewDocumentRequest create() => ReviewDocumentRequest._();
  ReviewDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<ReviewDocumentRequest> createRepeated() => $pb.PbList<ReviewDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static ReviewDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReviewDocumentRequest>(create);
  static ReviewDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get approved => $_getBF(1);
  @$pb.TagNumber(2)
  set approved($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasApproved() => $_has(1);
  @$pb.TagNumber(2)
  void clearApproved() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get rejectionReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set rejectionReason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRejectionReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearRejectionReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get adminNotes => $_getSZ(3);
  @$pb.TagNumber(4)
  set adminNotes($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAdminNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminNotes() => clearField(4);
}

class ReviewDocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReviewDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ReviewDocumentResponse._() : super();
  factory ReviewDocumentResponse({
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
  factory ReviewDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReviewDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReviewDocumentResponse clone() => ReviewDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReviewDocumentResponse copyWith(void Function(ReviewDocumentResponse) updates) => super.copyWith((message) => updates(message as ReviewDocumentResponse)) as ReviewDocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReviewDocumentResponse create() => ReviewDocumentResponse._();
  ReviewDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<ReviewDocumentResponse> createRepeated() => $pb.PbList<ReviewDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static ReviewDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReviewDocumentResponse>(create);
  static ReviewDocumentResponse? _defaultInstance;

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

