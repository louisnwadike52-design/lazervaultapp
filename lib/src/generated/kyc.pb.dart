//
//  Generated code. Do not modify.
//  source: kyc.proto
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
import 'kyc.pbenum.dart';

export 'kyc.pbenum.dart';

/// Country-specific KYC requirements
class CountryKYCRequirements extends $pb.GeneratedMessage {
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
    final $result = create();
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (acceptedIdTypes != null) {
      $result.acceptedIdTypes.addAll(acceptedIdTypes);
    }
    if (mandatoryIdTypes != null) {
      $result.mandatoryIdTypes.addAll(mandatoryIdTypes);
    }
    if (addressProofRequired != null) {
      $result.addressProofRequired = addressProofRequired;
    }
    if (livenessCheckRequired != null) {
      $result.livenessCheckRequired = livenessCheckRequired;
    }
    if (tier1DailyLimit != null) {
      $result.tier1DailyLimit = tier1DailyLimit;
    }
    if (tier2DailyLimit != null) {
      $result.tier2DailyLimit = tier2DailyLimit;
    }
    if (tier3DailyLimit != null) {
      $result.tier3DailyLimit = tier3DailyLimit;
    }
    return $result;
  }
  CountryKYCRequirements._() : super();
  factory CountryKYCRequirements.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CountryKYCRequirements.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CountryKYCRequirements', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..pc<IDType>(2, _omitFieldNames ? '' : 'acceptedIdTypes', $pb.PbFieldType.KE, valueOf: IDType.valueOf, enumValues: IDType.values, defaultEnumValue: IDType.ID_UNKNOWN)
    ..pc<IDType>(3, _omitFieldNames ? '' : 'mandatoryIdTypes', $pb.PbFieldType.KE, valueOf: IDType.valueOf, enumValues: IDType.values, defaultEnumValue: IDType.ID_UNKNOWN)
    ..aOB(4, _omitFieldNames ? '' : 'addressProofRequired')
    ..aOB(5, _omitFieldNames ? '' : 'livenessCheckRequired')
    ..aInt64(6, _omitFieldNames ? '' : 'tier1DailyLimit', protoName: 'tier_1_daily_limit')
    ..aInt64(7, _omitFieldNames ? '' : 'tier2DailyLimit', protoName: 'tier_2_daily_limit')
    ..aInt64(8, _omitFieldNames ? '' : 'tier3DailyLimit', protoName: 'tier_3_daily_limit')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CountryKYCRequirements clone() => CountryKYCRequirements()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CountryKYCRequirements copyWith(void Function(CountryKYCRequirements) updates) => super.copyWith((message) => updates(message as CountryKYCRequirements)) as CountryKYCRequirements;

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

/// KYC Tier information
class KYCTierInfo extends $pb.GeneratedMessage {
  factory KYCTierInfo({
    KYCTier? tier,
    KYCStatus? status,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$core.String>? benefits,
    $fixnum.Int64? dailyTransactionLimit,
    $fixnum.Int64? dailyReceiveLimit,
    $fixnum.Int64? maxBalance,
    $42.Timestamp? verifiedAt,
    $42.Timestamp? expiresAt,
    $core.bool? isCurrent,
    $core.bool? isLocked,
  }) {
    final $result = create();
    if (tier != null) {
      $result.tier = tier;
    }
    if (status != null) {
      $result.status = status;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (description != null) {
      $result.description = description;
    }
    if (benefits != null) {
      $result.benefits.addAll(benefits);
    }
    if (dailyTransactionLimit != null) {
      $result.dailyTransactionLimit = dailyTransactionLimit;
    }
    if (dailyReceiveLimit != null) {
      $result.dailyReceiveLimit = dailyReceiveLimit;
    }
    if (maxBalance != null) {
      $result.maxBalance = maxBalance;
    }
    if (verifiedAt != null) {
      $result.verifiedAt = verifiedAt;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (isCurrent != null) {
      $result.isCurrent = isCurrent;
    }
    if (isLocked != null) {
      $result.isLocked = isLocked;
    }
    return $result;
  }
  KYCTierInfo._() : super();
  factory KYCTierInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KYCTierInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KYCTierInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..e<KYCTier>(1, _omitFieldNames ? '' : 'tier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..e<KYCStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..pPS(5, _omitFieldNames ? '' : 'benefits')
    ..aInt64(6, _omitFieldNames ? '' : 'dailyTransactionLimit')
    ..aInt64(7, _omitFieldNames ? '' : 'dailyReceiveLimit')
    ..aInt64(8, _omitFieldNames ? '' : 'maxBalance')
    ..aOM<$42.Timestamp>(9, _omitFieldNames ? '' : 'verifiedAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(10, _omitFieldNames ? '' : 'expiresAt', subBuilder: $42.Timestamp.create)
    ..aOB(11, _omitFieldNames ? '' : 'isCurrent')
    ..aOB(12, _omitFieldNames ? '' : 'isLocked')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KYCTierInfo clone() => KYCTierInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KYCTierInfo copyWith(void Function(KYCTierInfo) updates) => super.copyWith((message) => updates(message as KYCTierInfo)) as KYCTierInfo;

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
  $42.Timestamp get verifiedAt => $_getN(8);
  @$pb.TagNumber(9)
  set verifiedAt($42.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasVerifiedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerifiedAt() => clearField(9);
  @$pb.TagNumber(9)
  $42.Timestamp ensureVerifiedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $42.Timestamp get expiresAt => $_getN(9);
  @$pb.TagNumber(10)
  set expiresAt($42.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => clearField(10);
  @$pb.TagNumber(10)
  $42.Timestamp ensureExpiresAt() => $_ensure(9);

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

/// ID Verification request
class VerifyIDRequest extends $pb.GeneratedMessage {
  factory VerifyIDRequest({
    $core.String? userId,
    IDType? idType,
    $core.String? idNumber,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (idType != null) {
      $result.idType = idType;
    }
    if (idNumber != null) {
      $result.idNumber = idNumber;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (dateOfBirth != null) {
      $result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    return $result;
  }
  VerifyIDRequest._() : super();
  factory VerifyIDRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyIDRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<IDType>(2, _omitFieldNames ? '' : 'idType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(3, _omitFieldNames ? '' : 'idNumber')
    ..aOS(4, _omitFieldNames ? '' : 'firstName')
    ..aOS(5, _omitFieldNames ? '' : 'lastName')
    ..aOS(6, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(7, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDRequest clone() => VerifyIDRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDRequest copyWith(void Function(VerifyIDRequest) updates) => super.copyWith((message) => updates(message as VerifyIDRequest)) as VerifyIDRequest;

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

/// Document upload request
class UploadDocumentRequest extends $pb.GeneratedMessage {
  factory UploadDocumentRequest({
    $core.String? userId,
    IDType? documentType,
    $core.String? documentFrontUrl,
    $core.String? documentBackUrl,
    $core.String? selfieUrl,
    $core.String? proofOfAddressUrl,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (documentType != null) {
      $result.documentType = documentType;
    }
    if (documentFrontUrl != null) {
      $result.documentFrontUrl = documentFrontUrl;
    }
    if (documentBackUrl != null) {
      $result.documentBackUrl = documentBackUrl;
    }
    if (selfieUrl != null) {
      $result.selfieUrl = selfieUrl;
    }
    if (proofOfAddressUrl != null) {
      $result.proofOfAddressUrl = proofOfAddressUrl;
    }
    return $result;
  }
  UploadDocumentRequest._() : super();
  factory UploadDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadDocumentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<IDType>(2, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(3, _omitFieldNames ? '' : 'documentFrontUrl')
    ..aOS(4, _omitFieldNames ? '' : 'documentBackUrl')
    ..aOS(5, _omitFieldNames ? '' : 'selfieUrl')
    ..aOS(6, _omitFieldNames ? '' : 'proofOfAddressUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadDocumentRequest clone() => UploadDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadDocumentRequest copyWith(void Function(UploadDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadDocumentRequest)) as UploadDocumentRequest;

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

/// KYC Verification response
class VerifyIDResponse extends $pb.GeneratedMessage {
  factory VerifyIDResponse({
    $core.bool? success,
    $core.String? message,
    KYCStatus? status,
    KYCTier? currentTier,
    $42.Timestamp? verifiedAt,
    $core.String? reference,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (status != null) {
      $result.status = status;
    }
    if (currentTier != null) {
      $result.currentTier = currentTier;
    }
    if (verifiedAt != null) {
      $result.verifiedAt = verifiedAt;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    return $result;
  }
  VerifyIDResponse._() : super();
  factory VerifyIDResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyIDResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<KYCStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..e<KYCTier>(4, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOM<$42.Timestamp>(5, _omitFieldNames ? '' : 'verifiedAt', subBuilder: $42.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDResponse clone() => VerifyIDResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDResponse copyWith(void Function(VerifyIDResponse) updates) => super.copyWith((message) => updates(message as VerifyIDResponse)) as VerifyIDResponse;

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
  $42.Timestamp get verifiedAt => $_getN(4);
  @$pb.TagNumber(5)
  set verifiedAt($42.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerifiedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerifiedAt() => clearField(5);
  @$pb.TagNumber(5)
  $42.Timestamp ensureVerifiedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);
}

/// Get user KYC status request
class GetKYCStatusRequest extends $pb.GeneratedMessage {
  factory GetKYCStatusRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetKYCStatusRequest._() : super();
  factory GetKYCStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetKYCStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetKYCStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetKYCStatusRequest clone() => GetKYCStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetKYCStatusRequest copyWith(void Function(GetKYCStatusRequest) updates) => super.copyWith((message) => updates(message as GetKYCStatusRequest)) as GetKYCStatusRequest;

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

/// Get user KYC status response
class GetKYCStatusResponse extends $pb.GeneratedMessage {
  factory GetKYCStatusResponse({
    $core.bool? success,
    KYCStatus? status,
    KYCTier? currentTier,
    $core.Iterable<KYCTierInfo>? tierInfo,
    $42.Timestamp? lastUpdated,
    $core.String? rejectionReason,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (status != null) {
      $result.status = status;
    }
    if (currentTier != null) {
      $result.currentTier = currentTier;
    }
    if (tierInfo != null) {
      $result.tierInfo.addAll(tierInfo);
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    if (rejectionReason != null) {
      $result.rejectionReason = rejectionReason;
    }
    return $result;
  }
  GetKYCStatusResponse._() : super();
  factory GetKYCStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetKYCStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetKYCStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KYCStatus.STATUS_UNKNOWN, valueOf: KYCStatus.valueOf, enumValues: KYCStatus.values)
    ..e<KYCTier>(3, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..pc<KYCTierInfo>(4, _omitFieldNames ? '' : 'tierInfo', $pb.PbFieldType.PM, subBuilder: KYCTierInfo.create)
    ..aOM<$42.Timestamp>(5, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $42.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetKYCStatusResponse clone() => GetKYCStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetKYCStatusResponse copyWith(void Function(GetKYCStatusResponse) updates) => super.copyWith((message) => updates(message as GetKYCStatusResponse)) as GetKYCStatusResponse;

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
  $42.Timestamp get lastUpdated => $_getN(4);
  @$pb.TagNumber(5)
  set lastUpdated($42.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => clearField(5);
  @$pb.TagNumber(5)
  $42.Timestamp ensureLastUpdated() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get rejectionReason => $_getSZ(5);
  @$pb.TagNumber(6)
  set rejectionReason($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRejectionReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearRejectionReason() => clearField(6);
}

/// Skip KYC request (for progressive onboarding)
class SkipKYCRequest extends $pb.GeneratedMessage {
  factory SkipKYCRequest({
    $core.String? userId,
    $core.bool? skipTier2,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (skipTier2 != null) {
      $result.skipTier2 = skipTier2;
    }
    return $result;
  }
  SkipKYCRequest._() : super();
  factory SkipKYCRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SkipKYCRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SkipKYCRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'skipTier2', protoName: 'skip_tier_2')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SkipKYCRequest clone() => SkipKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SkipKYCRequest copyWith(void Function(SkipKYCRequest) updates) => super.copyWith((message) => updates(message as SkipKYCRequest)) as SkipKYCRequest;

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

/// Skip KYC response
class SkipKYCResponse extends $pb.GeneratedMessage {
  factory SkipKYCResponse({
    $core.bool? success,
    KYCTier? assignedTier,
    $core.String? message,
    $core.Iterable<$core.String>? nextSteps,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (assignedTier != null) {
      $result.assignedTier = assignedTier;
    }
    if (message != null) {
      $result.message = message;
    }
    if (nextSteps != null) {
      $result.nextSteps.addAll(nextSteps);
    }
    return $result;
  }
  SkipKYCResponse._() : super();
  factory SkipKYCResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SkipKYCResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SkipKYCResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCTier>(2, _omitFieldNames ? '' : 'assignedTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..pPS(4, _omitFieldNames ? '' : 'nextSteps')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SkipKYCResponse clone() => SkipKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SkipKYCResponse copyWith(void Function(SkipKYCResponse) updates) => super.copyWith((message) => updates(message as SkipKYCResponse)) as SkipKYCResponse;

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

/// Get country requirements request
class GetCountryRequirementsRequest extends $pb.GeneratedMessage {
  factory GetCountryRequirementsRequest({
    $core.String? countryCode,
  }) {
    final $result = create();
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    return $result;
  }
  GetCountryRequirementsRequest._() : super();
  factory GetCountryRequirementsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRequirementsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCountryRequirementsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsRequest clone() => GetCountryRequirementsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsRequest copyWith(void Function(GetCountryRequirementsRequest) updates) => super.copyWith((message) => updates(message as GetCountryRequirementsRequest)) as GetCountryRequirementsRequest;

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

/// Get country requirements response
class GetCountryRequirementsResponse extends $pb.GeneratedMessage {
  factory GetCountryRequirementsResponse({
    $core.bool? success,
    CountryKYCRequirements? requirements,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (requirements != null) {
      $result.requirements = requirements;
    }
    return $result;
  }
  GetCountryRequirementsResponse._() : super();
  factory GetCountryRequirementsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCountryRequirementsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCountryRequirementsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<CountryKYCRequirements>(2, _omitFieldNames ? '' : 'requirements', subBuilder: CountryKYCRequirements.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsResponse clone() => GetCountryRequirementsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCountryRequirementsResponse copyWith(void Function(GetCountryRequirementsResponse) updates) => super.copyWith((message) => updates(message as GetCountryRequirementsResponse)) as GetCountryRequirementsResponse;

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

/// Initiate KYC request (starts verification flow)
class InitiateKYCRequest extends $pb.GeneratedMessage {
  factory InitiateKYCRequest({
    $core.String? userId,
    KYCTier? targetTier,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (targetTier != null) {
      $result.targetTier = targetTier;
    }
    return $result;
  }
  InitiateKYCRequest._() : super();
  factory InitiateKYCRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateKYCRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateKYCRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<KYCTier>(2, _omitFieldNames ? '' : 'targetTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateKYCRequest clone() => InitiateKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateKYCRequest copyWith(void Function(InitiateKYCRequest) updates) => super.copyWith((message) => updates(message as InitiateKYCRequest)) as InitiateKYCRequest;

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

/// Initiate KYC response
class InitiateKYCResponse extends $pb.GeneratedMessage {
  factory InitiateKYCResponse({
    $core.bool? success,
    $core.String? sessionId,
    $core.Iterable<$core.String>? requiredDocuments,
    $core.Iterable<$core.String>? requiredFields,
    $core.String? redirectUrl,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (requiredDocuments != null) {
      $result.requiredDocuments.addAll(requiredDocuments);
    }
    if (requiredFields != null) {
      $result.requiredFields.addAll(requiredFields);
    }
    if (redirectUrl != null) {
      $result.redirectUrl = redirectUrl;
    }
    return $result;
  }
  InitiateKYCResponse._() : super();
  factory InitiateKYCResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateKYCResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateKYCResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..pPS(3, _omitFieldNames ? '' : 'requiredDocuments')
    ..pPS(4, _omitFieldNames ? '' : 'requiredFields')
    ..aOS(5, _omitFieldNames ? '' : 'redirectUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateKYCResponse clone() => InitiateKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateKYCResponse copyWith(void Function(InitiateKYCResponse) updates) => super.copyWith((message) => updates(message as InitiateKYCResponse)) as InitiateKYCResponse;

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

/// Verification document metadata
class VerificationDocument extends $pb.GeneratedMessage {
  factory VerificationDocument({
    $core.String? id,
    IDType? documentType,
    $core.String? documentUrl,
    DocumentStatus? status,
    $42.Timestamp? uploadedAt,
    $42.Timestamp? verifiedAt,
    $core.String? rejectionReason,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (documentType != null) {
      $result.documentType = documentType;
    }
    if (documentUrl != null) {
      $result.documentUrl = documentUrl;
    }
    if (status != null) {
      $result.status = status;
    }
    if (uploadedAt != null) {
      $result.uploadedAt = uploadedAt;
    }
    if (verifiedAt != null) {
      $result.verifiedAt = verifiedAt;
    }
    if (rejectionReason != null) {
      $result.rejectionReason = rejectionReason;
    }
    return $result;
  }
  VerificationDocument._() : super();
  factory VerificationDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerificationDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerificationDocument', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..e<IDType>(2, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: IDType.ID_UNKNOWN, valueOf: IDType.valueOf, enumValues: IDType.values)
    ..aOS(3, _omitFieldNames ? '' : 'documentUrl')
    ..e<DocumentStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DocumentStatus.DOC_STATUS_UNKNOWN, valueOf: DocumentStatus.valueOf, enumValues: DocumentStatus.values)
    ..aOM<$42.Timestamp>(5, _omitFieldNames ? '' : 'uploadedAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(6, _omitFieldNames ? '' : 'verifiedAt', subBuilder: $42.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerificationDocument clone() => VerificationDocument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerificationDocument copyWith(void Function(VerificationDocument) updates) => super.copyWith((message) => updates(message as VerificationDocument)) as VerificationDocument;

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
  $42.Timestamp get uploadedAt => $_getN(4);
  @$pb.TagNumber(5)
  set uploadedAt($42.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUploadedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUploadedAt() => clearField(5);
  @$pb.TagNumber(5)
  $42.Timestamp ensureUploadedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $42.Timestamp get verifiedAt => $_getN(5);
  @$pb.TagNumber(6)
  set verifiedAt($42.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerifiedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerifiedAt() => clearField(6);
  @$pb.TagNumber(6)
  $42.Timestamp ensureVerifiedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get rejectionReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set rejectionReason($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRejectionReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearRejectionReason() => clearField(7);
}

/// Get user documents request
class GetUserDocumentsRequest extends $pb.GeneratedMessage {
  factory GetUserDocumentsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetUserDocumentsRequest._() : super();
  factory GetUserDocumentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDocumentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDocumentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDocumentsRequest clone() => GetUserDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDocumentsRequest copyWith(void Function(GetUserDocumentsRequest) updates) => super.copyWith((message) => updates(message as GetUserDocumentsRequest)) as GetUserDocumentsRequest;

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

/// Get user documents response
class GetUserDocumentsResponse extends $pb.GeneratedMessage {
  factory GetUserDocumentsResponse({
    $core.bool? success,
    $core.Iterable<VerificationDocument>? documents,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (documents != null) {
      $result.documents.addAll(documents);
    }
    return $result;
  }
  GetUserDocumentsResponse._() : super();
  factory GetUserDocumentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDocumentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDocumentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pc<VerificationDocument>(2, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: VerificationDocument.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDocumentsResponse clone() => GetUserDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDocumentsResponse copyWith(void Function(GetUserDocumentsResponse) updates) => super.copyWith((message) => updates(message as GetUserDocumentsResponse)) as GetUserDocumentsResponse;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
