// This is a generated file - do not edit.
//
// Generated from kyc.proto.

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
import 'kyc.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    if (acceptedIdTypes != null) result.acceptedIdTypes.addAll(acceptedIdTypes);
    if (mandatoryIdTypes != null)
      result.mandatoryIdTypes.addAll(mandatoryIdTypes);
    if (addressProofRequired != null)
      result.addressProofRequired = addressProofRequired;
    if (livenessCheckRequired != null)
      result.livenessCheckRequired = livenessCheckRequired;
    if (tier1DailyLimit != null) result.tier1DailyLimit = tier1DailyLimit;
    if (tier2DailyLimit != null) result.tier2DailyLimit = tier2DailyLimit;
    if (tier3DailyLimit != null) result.tier3DailyLimit = tier3DailyLimit;
    return result;
  }

  CountryKYCRequirements._();

  factory CountryKYCRequirements.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CountryKYCRequirements.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountryKYCRequirements',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..pc<IDType>(
        2, _omitFieldNames ? '' : 'acceptedIdTypes', $pb.PbFieldType.KE,
        valueOf: IDType.valueOf,
        enumValues: IDType.values,
        defaultEnumValue: IDType.ID_UNKNOWN)
    ..pc<IDType>(
        3, _omitFieldNames ? '' : 'mandatoryIdTypes', $pb.PbFieldType.KE,
        valueOf: IDType.valueOf,
        enumValues: IDType.values,
        defaultEnumValue: IDType.ID_UNKNOWN)
    ..aOB(4, _omitFieldNames ? '' : 'addressProofRequired')
    ..aOB(5, _omitFieldNames ? '' : 'livenessCheckRequired')
    ..aInt64(6, _omitFieldNames ? '' : 'tier1DailyLimit',
        protoName: 'tier_1_daily_limit')
    ..aInt64(7, _omitFieldNames ? '' : 'tier2DailyLimit',
        protoName: 'tier_2_daily_limit')
    ..aInt64(8, _omitFieldNames ? '' : 'tier3DailyLimit',
        protoName: 'tier_3_daily_limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountryKYCRequirements clone() =>
      CountryKYCRequirements()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountryKYCRequirements copyWith(
          void Function(CountryKYCRequirements) updates) =>
      super.copyWith((message) => updates(message as CountryKYCRequirements))
          as CountryKYCRequirements;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CountryKYCRequirements create() => CountryKYCRequirements._();
  @$core.override
  CountryKYCRequirements createEmptyInstance() => create();
  static $pb.PbList<CountryKYCRequirements> createRepeated() =>
      $pb.PbList<CountryKYCRequirements>();
  @$core.pragma('dart2js:noInline')
  static CountryKYCRequirements getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountryKYCRequirements>(create);
  static CountryKYCRequirements? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<IDType> get acceptedIdTypes => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<IDType> get mandatoryIdTypes => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get addressProofRequired => $_getBF(3);
  @$pb.TagNumber(4)
  set addressProofRequired($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAddressProofRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddressProofRequired() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get livenessCheckRequired => $_getBF(4);
  @$pb.TagNumber(5)
  set livenessCheckRequired($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLivenessCheckRequired() => $_has(4);
  @$pb.TagNumber(5)
  void clearLivenessCheckRequired() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get tier1DailyLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set tier1DailyLimit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTier1DailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearTier1DailyLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get tier2DailyLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set tier2DailyLimit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTier2DailyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearTier2DailyLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get tier3DailyLimit => $_getI64(7);
  @$pb.TagNumber(8)
  set tier3DailyLimit($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTier3DailyLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearTier3DailyLimit() => $_clearField(8);
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
    $1.Timestamp? verifiedAt,
    $1.Timestamp? expiresAt,
    $core.bool? isCurrent,
    $core.bool? isLocked,
  }) {
    final result = create();
    if (tier != null) result.tier = tier;
    if (status != null) result.status = status;
    if (displayName != null) result.displayName = displayName;
    if (description != null) result.description = description;
    if (benefits != null) result.benefits.addAll(benefits);
    if (dailyTransactionLimit != null)
      result.dailyTransactionLimit = dailyTransactionLimit;
    if (dailyReceiveLimit != null) result.dailyReceiveLimit = dailyReceiveLimit;
    if (maxBalance != null) result.maxBalance = maxBalance;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (isCurrent != null) result.isCurrent = isCurrent;
    if (isLocked != null) result.isLocked = isLocked;
    return result;
  }

  KYCTierInfo._();

  factory KYCTierInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KYCTierInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KYCTierInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..e<KYCTier>(1, _omitFieldNames ? '' : 'tier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..e<KYCStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCStatus.STATUS_UNKNOWN,
        valueOf: KYCStatus.valueOf,
        enumValues: KYCStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..pPS(5, _omitFieldNames ? '' : 'benefits')
    ..aInt64(6, _omitFieldNames ? '' : 'dailyTransactionLimit')
    ..aInt64(7, _omitFieldNames ? '' : 'dailyReceiveLimit')
    ..aInt64(8, _omitFieldNames ? '' : 'maxBalance')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'verifiedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(11, _omitFieldNames ? '' : 'isCurrent')
    ..aOB(12, _omitFieldNames ? '' : 'isLocked')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KYCTierInfo clone() => KYCTierInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KYCTierInfo copyWith(void Function(KYCTierInfo) updates) =>
      super.copyWith((message) => updates(message as KYCTierInfo))
          as KYCTierInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KYCTierInfo create() => KYCTierInfo._();
  @$core.override
  KYCTierInfo createEmptyInstance() => create();
  static $pb.PbList<KYCTierInfo> createRepeated() => $pb.PbList<KYCTierInfo>();
  @$core.pragma('dart2js:noInline')
  static KYCTierInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KYCTierInfo>(create);
  static KYCTierInfo? _defaultInstance;

  @$pb.TagNumber(1)
  KYCTier get tier => $_getN(0);
  @$pb.TagNumber(1)
  set tier(KYCTier value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get benefits => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get dailyTransactionLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set dailyTransactionLimit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDailyTransactionLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyTransactionLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get dailyReceiveLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set dailyReceiveLimit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDailyReceiveLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearDailyReceiveLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get maxBalance => $_getI64(7);
  @$pb.TagNumber(8)
  set maxBalance($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxBalance() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get verifiedAt => $_getN(8);
  @$pb.TagNumber(9)
  set verifiedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasVerifiedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerifiedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureVerifiedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get expiresAt => $_getN(9);
  @$pb.TagNumber(10)
  set expiresAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureExpiresAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.bool get isCurrent => $_getBF(10);
  @$pb.TagNumber(11)
  set isCurrent($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsCurrent() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsCurrent() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isLocked => $_getBF(11);
  @$pb.TagNumber(12)
  set isLocked($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsLocked() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsLocked() => $_clearField(12);
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
    final result = create();
    if (userId != null) result.userId = userId;
    if (idType != null) result.idType = idType;
    if (idNumber != null) result.idNumber = idNumber;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  VerifyIDRequest._();

  factory VerifyIDRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyIDRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyIDRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<IDType>(2, _omitFieldNames ? '' : 'idType', $pb.PbFieldType.OE,
        defaultOrMaker: IDType.ID_UNKNOWN,
        valueOf: IDType.valueOf,
        enumValues: IDType.values)
    ..aOS(3, _omitFieldNames ? '' : 'idNumber')
    ..aOS(4, _omitFieldNames ? '' : 'firstName')
    ..aOS(5, _omitFieldNames ? '' : 'lastName')
    ..aOS(6, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(7, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIDRequest clone() => VerifyIDRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIDRequest copyWith(void Function(VerifyIDRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyIDRequest))
          as VerifyIDRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyIDRequest create() => VerifyIDRequest._();
  @$core.override
  VerifyIDRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyIDRequest> createRepeated() =>
      $pb.PbList<VerifyIDRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyIDRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyIDRequest>(create);
  static VerifyIDRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  IDType get idType => $_getN(1);
  @$pb.TagNumber(2)
  set idType(IDType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIdType() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get idNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set idNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIdNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get firstName => $_getSZ(3);
  @$pb.TagNumber(4)
  set firstName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastName => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastName() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get dateOfBirth => $_getSZ(5);
  @$pb.TagNumber(6)
  set dateOfBirth($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDateOfBirth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDateOfBirth() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => $_clearField(7);
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
    final result = create();
    if (userId != null) result.userId = userId;
    if (documentType != null) result.documentType = documentType;
    if (documentFrontUrl != null) result.documentFrontUrl = documentFrontUrl;
    if (documentBackUrl != null) result.documentBackUrl = documentBackUrl;
    if (selfieUrl != null) result.selfieUrl = selfieUrl;
    if (proofOfAddressUrl != null) result.proofOfAddressUrl = proofOfAddressUrl;
    return result;
  }

  UploadDocumentRequest._();

  factory UploadDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadDocumentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<IDType>(2, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: IDType.ID_UNKNOWN,
        valueOf: IDType.valueOf,
        enumValues: IDType.values)
    ..aOS(3, _omitFieldNames ? '' : 'documentFrontUrl')
    ..aOS(4, _omitFieldNames ? '' : 'documentBackUrl')
    ..aOS(5, _omitFieldNames ? '' : 'selfieUrl')
    ..aOS(6, _omitFieldNames ? '' : 'proofOfAddressUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadDocumentRequest clone() =>
      UploadDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadDocumentRequest copyWith(
          void Function(UploadDocumentRequest) updates) =>
      super.copyWith((message) => updates(message as UploadDocumentRequest))
          as UploadDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest create() => UploadDocumentRequest._();
  @$core.override
  UploadDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadDocumentRequest> createRepeated() =>
      $pb.PbList<UploadDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadDocumentRequest>(create);
  static UploadDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  IDType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(IDType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentFrontUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentFrontUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentFrontUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentFrontUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get documentBackUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set documentBackUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDocumentBackUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearDocumentBackUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get selfieUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set selfieUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSelfieUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearSelfieUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get proofOfAddressUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set proofOfAddressUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProofOfAddressUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearProofOfAddressUrl() => $_clearField(6);
}

/// KYC Verification response
class VerifyIDResponse extends $pb.GeneratedMessage {
  factory VerifyIDResponse({
    $core.bool? success,
    $core.String? message,
    KYCStatus? status,
    KYCTier? currentTier,
    $1.Timestamp? verifiedAt,
    $core.String? reference,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    if (currentTier != null) result.currentTier = currentTier;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    if (reference != null) result.reference = reference;
    return result;
  }

  VerifyIDResponse._();

  factory VerifyIDResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyIDResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyIDResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<KYCStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCStatus.STATUS_UNKNOWN,
        valueOf: KYCStatus.valueOf,
        enumValues: KYCStatus.values)
    ..e<KYCTier>(4, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'verifiedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIDResponse clone() => VerifyIDResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIDResponse copyWith(void Function(VerifyIDResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyIDResponse))
          as VerifyIDResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyIDResponse create() => VerifyIDResponse._();
  @$core.override
  VerifyIDResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyIDResponse> createRepeated() =>
      $pb.PbList<VerifyIDResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyIDResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyIDResponse>(create);
  static VerifyIDResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  KYCStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(KYCStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  KYCTier get currentTier => $_getN(3);
  @$pb.TagNumber(4)
  set currentTier(KYCTier value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentTier() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentTier() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get verifiedAt => $_getN(4);
  @$pb.TagNumber(5)
  set verifiedAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVerifiedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerifiedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureVerifiedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => $_clearField(6);
}

/// Get user KYC status request
class GetKYCStatusRequest extends $pb.GeneratedMessage {
  factory GetKYCStatusRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetKYCStatusRequest._();

  factory GetKYCStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetKYCStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetKYCStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusRequest clone() => GetKYCStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusRequest copyWith(void Function(GetKYCStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetKYCStatusRequest))
          as GetKYCStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetKYCStatusRequest create() => GetKYCStatusRequest._();
  @$core.override
  GetKYCStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetKYCStatusRequest> createRepeated() =>
      $pb.PbList<GetKYCStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetKYCStatusRequest>(create);
  static GetKYCStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

/// Get user KYC status response
class GetKYCStatusResponse extends $pb.GeneratedMessage {
  factory GetKYCStatusResponse({
    $core.bool? success,
    KYCStatus? status,
    KYCTier? currentTier,
    $core.Iterable<KYCTierInfo>? tierInfo,
    $1.Timestamp? lastUpdated,
    $core.String? rejectionReason,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (status != null) result.status = status;
    if (currentTier != null) result.currentTier = currentTier;
    if (tierInfo != null) result.tierInfo.addAll(tierInfo);
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    return result;
  }

  GetKYCStatusResponse._();

  factory GetKYCStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetKYCStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetKYCStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCStatus.STATUS_UNKNOWN,
        valueOf: KYCStatus.valueOf,
        enumValues: KYCStatus.values)
    ..e<KYCTier>(3, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..pc<KYCTierInfo>(4, _omitFieldNames ? '' : 'tierInfo', $pb.PbFieldType.PM,
        subBuilder: KYCTierInfo.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusResponse clone() =>
      GetKYCStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusResponse copyWith(void Function(GetKYCStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetKYCStatusResponse))
          as GetKYCStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetKYCStatusResponse create() => GetKYCStatusResponse._();
  @$core.override
  GetKYCStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetKYCStatusResponse> createRepeated() =>
      $pb.PbList<GetKYCStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetKYCStatusResponse>(create);
  static GetKYCStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  KYCTier get currentTier => $_getN(2);
  @$pb.TagNumber(3)
  set currentTier(KYCTier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTier() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<KYCTierInfo> get tierInfo => $_getList(3);

  @$pb.TagNumber(5)
  $1.Timestamp get lastUpdated => $_getN(4);
  @$pb.TagNumber(5)
  set lastUpdated($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureLastUpdated() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get rejectionReason => $_getSZ(5);
  @$pb.TagNumber(6)
  set rejectionReason($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRejectionReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearRejectionReason() => $_clearField(6);
}

/// Skip KYC request (for progressive onboarding)
class SkipKYCRequest extends $pb.GeneratedMessage {
  factory SkipKYCRequest({
    $core.String? userId,
    $core.bool? skipTier2,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (skipTier2 != null) result.skipTier2 = skipTier2;
    return result;
  }

  SkipKYCRequest._();

  factory SkipKYCRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SkipKYCRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SkipKYCRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'skipTier2', protoName: 'skip_tier_2')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCRequest clone() => SkipKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCRequest copyWith(void Function(SkipKYCRequest) updates) =>
      super.copyWith((message) => updates(message as SkipKYCRequest))
          as SkipKYCRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SkipKYCRequest create() => SkipKYCRequest._();
  @$core.override
  SkipKYCRequest createEmptyInstance() => create();
  static $pb.PbList<SkipKYCRequest> createRepeated() =>
      $pb.PbList<SkipKYCRequest>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SkipKYCRequest>(create);
  static SkipKYCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get skipTier2 => $_getBF(1);
  @$pb.TagNumber(2)
  set skipTier2($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSkipTier2() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkipTier2() => $_clearField(2);
}

/// Skip KYC response
class SkipKYCResponse extends $pb.GeneratedMessage {
  factory SkipKYCResponse({
    $core.bool? success,
    KYCTier? assignedTier,
    $core.String? message,
    $core.Iterable<$core.String>? nextSteps,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (assignedTier != null) result.assignedTier = assignedTier;
    if (message != null) result.message = message;
    if (nextSteps != null) result.nextSteps.addAll(nextSteps);
    return result;
  }

  SkipKYCResponse._();

  factory SkipKYCResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SkipKYCResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SkipKYCResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCTier>(2, _omitFieldNames ? '' : 'assignedTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..pPS(4, _omitFieldNames ? '' : 'nextSteps')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCResponse clone() => SkipKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCResponse copyWith(void Function(SkipKYCResponse) updates) =>
      super.copyWith((message) => updates(message as SkipKYCResponse))
          as SkipKYCResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SkipKYCResponse create() => SkipKYCResponse._();
  @$core.override
  SkipKYCResponse createEmptyInstance() => create();
  static $pb.PbList<SkipKYCResponse> createRepeated() =>
      $pb.PbList<SkipKYCResponse>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SkipKYCResponse>(create);
  static SkipKYCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCTier get assignedTier => $_getN(1);
  @$pb.TagNumber(2)
  set assignedTier(KYCTier value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAssignedTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssignedTier() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get nextSteps => $_getList(3);
}

/// Get country requirements request
class GetCountryRequirementsRequest extends $pb.GeneratedMessage {
  factory GetCountryRequirementsRequest({
    $core.String? countryCode,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  GetCountryRequirementsRequest._();

  factory GetCountryRequirementsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCountryRequirementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCountryRequirementsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsRequest clone() =>
      GetCountryRequirementsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsRequest copyWith(
          void Function(GetCountryRequirementsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCountryRequirementsRequest))
          as GetCountryRequirementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsRequest create() =>
      GetCountryRequirementsRequest._();
  @$core.override
  GetCountryRequirementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCountryRequirementsRequest> createRepeated() =>
      $pb.PbList<GetCountryRequirementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCountryRequirementsRequest>(create);
  static GetCountryRequirementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);
}

/// Get country requirements response
class GetCountryRequirementsResponse extends $pb.GeneratedMessage {
  factory GetCountryRequirementsResponse({
    $core.bool? success,
    CountryKYCRequirements? requirements,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (requirements != null) result.requirements = requirements;
    return result;
  }

  GetCountryRequirementsResponse._();

  factory GetCountryRequirementsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCountryRequirementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCountryRequirementsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<CountryKYCRequirements>(2, _omitFieldNames ? '' : 'requirements',
        subBuilder: CountryKYCRequirements.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsResponse clone() =>
      GetCountryRequirementsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsResponse copyWith(
          void Function(GetCountryRequirementsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCountryRequirementsResponse))
          as GetCountryRequirementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsResponse create() =>
      GetCountryRequirementsResponse._();
  @$core.override
  GetCountryRequirementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCountryRequirementsResponse> createRepeated() =>
      $pb.PbList<GetCountryRequirementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCountryRequirementsResponse>(create);
  static GetCountryRequirementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  CountryKYCRequirements get requirements => $_getN(1);
  @$pb.TagNumber(2)
  set requirements(CountryKYCRequirements value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRequirements() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequirements() => $_clearField(2);
  @$pb.TagNumber(2)
  CountryKYCRequirements ensureRequirements() => $_ensure(1);
}

/// Initiate KYC request (starts verification flow)
class InitiateKYCRequest extends $pb.GeneratedMessage {
  factory InitiateKYCRequest({
    $core.String? userId,
    KYCTier? targetTier,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (targetTier != null) result.targetTier = targetTier;
    return result;
  }

  InitiateKYCRequest._();

  factory InitiateKYCRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateKYCRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateKYCRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<KYCTier>(2, _omitFieldNames ? '' : 'targetTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCRequest clone() => InitiateKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCRequest copyWith(void Function(InitiateKYCRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateKYCRequest))
          as InitiateKYCRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest create() => InitiateKYCRequest._();
  @$core.override
  InitiateKYCRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCRequest> createRepeated() =>
      $pb.PbList<InitiateKYCRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateKYCRequest>(create);
  static InitiateKYCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCTier get targetTier => $_getN(1);
  @$pb.TagNumber(2)
  set targetTier(KYCTier value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetTier() => $_clearField(2);
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
    final result = create();
    if (success != null) result.success = success;
    if (sessionId != null) result.sessionId = sessionId;
    if (requiredDocuments != null)
      result.requiredDocuments.addAll(requiredDocuments);
    if (requiredFields != null) result.requiredFields.addAll(requiredFields);
    if (redirectUrl != null) result.redirectUrl = redirectUrl;
    return result;
  }

  InitiateKYCResponse._();

  factory InitiateKYCResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateKYCResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateKYCResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..pPS(3, _omitFieldNames ? '' : 'requiredDocuments')
    ..pPS(4, _omitFieldNames ? '' : 'requiredFields')
    ..aOS(5, _omitFieldNames ? '' : 'redirectUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCResponse clone() => InitiateKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCResponse copyWith(void Function(InitiateKYCResponse) updates) =>
      super.copyWith((message) => updates(message as InitiateKYCResponse))
          as InitiateKYCResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse create() => InitiateKYCResponse._();
  @$core.override
  InitiateKYCResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCResponse> createRepeated() =>
      $pb.PbList<InitiateKYCResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateKYCResponse>(create);
  static InitiateKYCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get requiredDocuments => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get requiredFields => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get redirectUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set redirectUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRedirectUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedirectUrl() => $_clearField(5);
}

/// Verification document metadata
class VerificationDocument extends $pb.GeneratedMessage {
  factory VerificationDocument({
    $core.String? id,
    IDType? documentType,
    $core.String? documentUrl,
    DocumentStatus? status,
    $1.Timestamp? uploadedAt,
    $1.Timestamp? verifiedAt,
    $core.String? rejectionReason,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (documentType != null) result.documentType = documentType;
    if (documentUrl != null) result.documentUrl = documentUrl;
    if (status != null) result.status = status;
    if (uploadedAt != null) result.uploadedAt = uploadedAt;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    return result;
  }

  VerificationDocument._();

  factory VerificationDocument.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerificationDocument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerificationDocument',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..e<IDType>(2, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: IDType.ID_UNKNOWN,
        valueOf: IDType.valueOf,
        enumValues: IDType.values)
    ..aOS(3, _omitFieldNames ? '' : 'documentUrl')
    ..e<DocumentStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: DocumentStatus.DOC_STATUS_UNKNOWN,
        valueOf: DocumentStatus.valueOf,
        enumValues: DocumentStatus.values)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'uploadedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'verifiedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerificationDocument clone() =>
      VerificationDocument()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerificationDocument copyWith(void Function(VerificationDocument) updates) =>
      super.copyWith((message) => updates(message as VerificationDocument))
          as VerificationDocument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerificationDocument create() => VerificationDocument._();
  @$core.override
  VerificationDocument createEmptyInstance() => create();
  static $pb.PbList<VerificationDocument> createRepeated() =>
      $pb.PbList<VerificationDocument>();
  @$core.pragma('dart2js:noInline')
  static VerificationDocument getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerificationDocument>(create);
  static VerificationDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  IDType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(IDType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  DocumentStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(DocumentStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get uploadedAt => $_getN(4);
  @$pb.TagNumber(5)
  set uploadedAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasUploadedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUploadedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureUploadedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get verifiedAt => $_getN(5);
  @$pb.TagNumber(6)
  set verifiedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVerifiedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerifiedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureVerifiedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get rejectionReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set rejectionReason($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRejectionReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearRejectionReason() => $_clearField(7);
}

/// Get user documents request
class GetUserDocumentsRequest extends $pb.GeneratedMessage {
  factory GetUserDocumentsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserDocumentsRequest._();

  factory GetUserDocumentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDocumentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDocumentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsRequest clone() =>
      GetUserDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsRequest copyWith(
          void Function(GetUserDocumentsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserDocumentsRequest))
          as GetUserDocumentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest create() => GetUserDocumentsRequest._();
  @$core.override
  GetUserDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsRequest> createRepeated() =>
      $pb.PbList<GetUserDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsRequest>(create);
  static GetUserDocumentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

/// Get user documents response
class GetUserDocumentsResponse extends $pb.GeneratedMessage {
  factory GetUserDocumentsResponse({
    $core.bool? success,
    $core.Iterable<VerificationDocument>? documents,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  GetUserDocumentsResponse._();

  factory GetUserDocumentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDocumentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDocumentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pc<VerificationDocument>(
        2, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM,
        subBuilder: VerificationDocument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsResponse clone() =>
      GetUserDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsResponse copyWith(
          void Function(GetUserDocumentsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserDocumentsResponse))
          as GetUserDocumentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse create() => GetUserDocumentsResponse._();
  @$core.override
  GetUserDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsResponse> createRepeated() =>
      $pb.PbList<GetUserDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsResponse>(create);
  static GetUserDocumentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<VerificationDocument> get documents => $_getList(1);
}

/// Create verification session request (replaces direct VerifyID for async providers)
class CreateVerificationSessionRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (userId != null) result.userId = userId;
    if (targetTier != null) result.targetTier = targetTier;
    if (countryCode != null) result.countryCode = countryCode;
    if (idType != null) result.idType = idType;
    if (idNumber != null) result.idNumber = idNumber;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  CreateVerificationSessionRequest._();

  factory CreateVerificationSessionRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVerificationSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVerificationSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<KYCTier>(2, _omitFieldNames ? '' : 'targetTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(3, _omitFieldNames ? '' : 'countryCode')
    ..e<IDType>(4, _omitFieldNames ? '' : 'idType', $pb.PbFieldType.OE,
        defaultOrMaker: IDType.ID_UNKNOWN,
        valueOf: IDType.valueOf,
        enumValues: IDType.values)
    ..aOS(5, _omitFieldNames ? '' : 'idNumber')
    ..aOS(6, _omitFieldNames ? '' : 'firstName')
    ..aOS(7, _omitFieldNames ? '' : 'lastName')
    ..aOS(8, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(9, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionRequest clone() =>
      CreateVerificationSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionRequest copyWith(
          void Function(CreateVerificationSessionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateVerificationSessionRequest))
          as CreateVerificationSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionRequest create() =>
      CreateVerificationSessionRequest._();
  @$core.override
  CreateVerificationSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVerificationSessionRequest> createRepeated() =>
      $pb.PbList<CreateVerificationSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVerificationSessionRequest>(
          create);
  static CreateVerificationSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCTier get targetTier => $_getN(1);
  @$pb.TagNumber(2)
  set targetTier(KYCTier value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetTier() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountryCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryCode() => $_clearField(3);

  @$pb.TagNumber(4)
  IDType get idType => $_getN(3);
  @$pb.TagNumber(4)
  set idType(IDType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasIdType() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set idNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get firstName => $_getSZ(5);
  @$pb.TagNumber(6)
  set firstName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFirstName() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirstName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get lastName => $_getSZ(6);
  @$pb.TagNumber(7)
  set lastName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLastName() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get dateOfBirth => $_getSZ(7);
  @$pb.TagNumber(8)
  set dateOfBirth($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDateOfBirth() => $_has(7);
  @$pb.TagNumber(8)
  void clearDateOfBirth() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get phoneNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set phoneNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPhoneNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneNumber() => $_clearField(9);
}

class CreateVerificationSessionResponse extends $pb.GeneratedMessage {
  factory CreateVerificationSessionResponse({
    $core.bool? success,
    $core.String? verificationId,
    $core.String? sessionUrl,
    $core.String? sessionToken,
    $core.String? provider,
    KYCStatus? status,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (verificationId != null) result.verificationId = verificationId;
    if (sessionUrl != null) result.sessionUrl = sessionUrl;
    if (sessionToken != null) result.sessionToken = sessionToken;
    if (provider != null) result.provider = provider;
    if (status != null) result.status = status;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  CreateVerificationSessionResponse._();

  factory CreateVerificationSessionResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVerificationSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVerificationSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'verificationId')
    ..aOS(3, _omitFieldNames ? '' : 'sessionUrl')
    ..aOS(4, _omitFieldNames ? '' : 'sessionToken')
    ..aOS(5, _omitFieldNames ? '' : 'provider')
    ..e<KYCStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCStatus.STATUS_UNKNOWN,
        valueOf: KYCStatus.valueOf,
        enumValues: KYCStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionResponse clone() =>
      CreateVerificationSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionResponse copyWith(
          void Function(CreateVerificationSessionResponse) updates) =>
      super.copyWith((message) =>
              updates(message as CreateVerificationSessionResponse))
          as CreateVerificationSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionResponse create() =>
      CreateVerificationSessionResponse._();
  @$core.override
  CreateVerificationSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateVerificationSessionResponse> createRepeated() =>
      $pb.PbList<CreateVerificationSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVerificationSessionResponse>(
          create);
  static CreateVerificationSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerificationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSessionUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSessionToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => $_clearField(5);

  @$pb.TagNumber(6)
  KYCStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(KYCStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorMessage($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasErrorMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorMessage() => $_clearField(7);
}

/// Confirm after SDK/WebView completion
class ConfirmVerificationRequest extends $pb.GeneratedMessage {
  factory ConfirmVerificationRequest({
    $core.String? verificationId,
    $core.String? provider,
    $core.String? providerAuthCode,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (verificationId != null) result.verificationId = verificationId;
    if (provider != null) result.provider = provider;
    if (providerAuthCode != null) result.providerAuthCode = providerAuthCode;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  ConfirmVerificationRequest._();

  factory ConfirmVerificationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmVerificationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmVerificationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'verificationId')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..aOS(3, _omitFieldNames ? '' : 'providerAuthCode')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ConfirmVerificationRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('kyc'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationRequest clone() =>
      ConfirmVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationRequest copyWith(
          void Function(ConfirmVerificationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ConfirmVerificationRequest))
          as ConfirmVerificationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationRequest create() => ConfirmVerificationRequest._();
  @$core.override
  ConfirmVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<ConfirmVerificationRequest> createRepeated() =>
      $pb.PbList<ConfirmVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmVerificationRequest>(create);
  static ConfirmVerificationRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get providerAuthCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerAuthCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProviderAuthCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderAuthCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class ConfirmVerificationResponse extends $pb.GeneratedMessage {
  factory ConfirmVerificationResponse({
    $core.bool? success,
    KYCStatus? status,
    KYCTier? currentTier,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (status != null) result.status = status;
    if (currentTier != null) result.currentTier = currentTier;
    if (message != null) result.message = message;
    return result;
  }

  ConfirmVerificationResponse._();

  factory ConfirmVerificationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCStatus.STATUS_UNKNOWN,
        valueOf: KYCStatus.valueOf,
        enumValues: KYCStatus.values)
    ..e<KYCTier>(3, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationResponse clone() =>
      ConfirmVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationResponse copyWith(
          void Function(ConfirmVerificationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ConfirmVerificationResponse))
          as ConfirmVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationResponse create() =>
      ConfirmVerificationResponse._();
  @$core.override
  ConfirmVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<ConfirmVerificationResponse> createRepeated() =>
      $pb.PbList<ConfirmVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmVerificationResponse>(create);
  static ConfirmVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  KYCTier get currentTier => $_getN(2);
  @$pb.TagNumber(3)
  set currentTier(KYCTier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTier() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// GCS presigned URL for document upload (Tier 3)
class GetDocumentUploadURLRequest extends $pb.GeneratedMessage {
  factory GetDocumentUploadURLRequest({
    $core.String? documentType,
    $core.String? contentType,
  }) {
    final result = create();
    if (documentType != null) result.documentType = documentType;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  GetDocumentUploadURLRequest._();

  factory GetDocumentUploadURLRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDocumentUploadURLRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDocumentUploadURLRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentType')
    ..aOS(2, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLRequest clone() =>
      GetDocumentUploadURLRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLRequest copyWith(
          void Function(GetDocumentUploadURLRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetDocumentUploadURLRequest))
          as GetDocumentUploadURLRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLRequest create() =>
      GetDocumentUploadURLRequest._();
  @$core.override
  GetDocumentUploadURLRequest createEmptyInstance() => create();
  static $pb.PbList<GetDocumentUploadURLRequest> createRepeated() =>
      $pb.PbList<GetDocumentUploadURLRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDocumentUploadURLRequest>(create);
  static GetDocumentUploadURLRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => $_clearField(2);
}

class GetDocumentUploadURLResponse extends $pb.GeneratedMessage {
  factory GetDocumentUploadURLResponse({
    $core.bool? success,
    $core.String? uploadUrl,
    $core.String? storageKey,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (uploadUrl != null) result.uploadUrl = uploadUrl;
    if (storageKey != null) result.storageKey = storageKey;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  GetDocumentUploadURLResponse._();

  factory GetDocumentUploadURLResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDocumentUploadURLResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDocumentUploadURLResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'uploadUrl')
    ..aOS(3, _omitFieldNames ? '' : 'storageKey')
    ..aInt64(4, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLResponse clone() =>
      GetDocumentUploadURLResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLResponse copyWith(
          void Function(GetDocumentUploadURLResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetDocumentUploadURLResponse))
          as GetDocumentUploadURLResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLResponse create() =>
      GetDocumentUploadURLResponse._();
  @$core.override
  GetDocumentUploadURLResponse createEmptyInstance() => create();
  static $pb.PbList<GetDocumentUploadURLResponse> createRepeated() =>
      $pb.PbList<GetDocumentUploadURLResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDocumentUploadURLResponse>(create);
  static GetDocumentUploadURLResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get uploadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set uploadUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUploadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUploadUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get storageKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set storageKey($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStorageKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearStorageKey() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);
}

/// Submit uploaded documents for Tier 3 review
class SubmitDocumentsForReviewRequest extends $pb.GeneratedMessage {
  factory SubmitDocumentsForReviewRequest({
    $core.String? userId,
    $core.Iterable<DocumentSubmission>? documents,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  SubmitDocumentsForReviewRequest._();

  factory SubmitDocumentsForReviewRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitDocumentsForReviewRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitDocumentsForReviewRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..pc<DocumentSubmission>(
        2, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM,
        subBuilder: DocumentSubmission.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewRequest clone() =>
      SubmitDocumentsForReviewRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewRequest copyWith(
          void Function(SubmitDocumentsForReviewRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitDocumentsForReviewRequest))
          as SubmitDocumentsForReviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewRequest create() =>
      SubmitDocumentsForReviewRequest._();
  @$core.override
  SubmitDocumentsForReviewRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitDocumentsForReviewRequest> createRepeated() =>
      $pb.PbList<SubmitDocumentsForReviewRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitDocumentsForReviewRequest>(
          create);
  static SubmitDocumentsForReviewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<DocumentSubmission> get documents => $_getList(1);
}

class DocumentSubmission extends $pb.GeneratedMessage {
  factory DocumentSubmission({
    $core.String? storageKey,
    $core.String? documentType,
    $core.String? contentType,
  }) {
    final result = create();
    if (storageKey != null) result.storageKey = storageKey;
    if (documentType != null) result.documentType = documentType;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  DocumentSubmission._();

  factory DocumentSubmission.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DocumentSubmission.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DocumentSubmission',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storageKey')
    ..aOS(2, _omitFieldNames ? '' : 'documentType')
    ..aOS(3, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DocumentSubmission clone() => DocumentSubmission()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DocumentSubmission copyWith(void Function(DocumentSubmission) updates) =>
      super.copyWith((message) => updates(message as DocumentSubmission))
          as DocumentSubmission;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DocumentSubmission create() => DocumentSubmission._();
  @$core.override
  DocumentSubmission createEmptyInstance() => create();
  static $pb.PbList<DocumentSubmission> createRepeated() =>
      $pb.PbList<DocumentSubmission>();
  @$core.pragma('dart2js:noInline')
  static DocumentSubmission getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DocumentSubmission>(create);
  static DocumentSubmission? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storageKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set storageKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStorageKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearStorageKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get contentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set contentType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearContentType() => $_clearField(3);
}

class SubmitDocumentsForReviewResponse extends $pb.GeneratedMessage {
  factory SubmitDocumentsForReviewResponse({
    $core.bool? success,
    $core.String? message,
    KYCStatus? status,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    return result;
  }

  SubmitDocumentsForReviewResponse._();

  factory SubmitDocumentsForReviewResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitDocumentsForReviewResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitDocumentsForReviewResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<KYCStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCStatus.STATUS_UNKNOWN,
        valueOf: KYCStatus.valueOf,
        enumValues: KYCStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewResponse clone() =>
      SubmitDocumentsForReviewResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewResponse copyWith(
          void Function(SubmitDocumentsForReviewResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitDocumentsForReviewResponse))
          as SubmitDocumentsForReviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewResponse create() =>
      SubmitDocumentsForReviewResponse._();
  @$core.override
  SubmitDocumentsForReviewResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitDocumentsForReviewResponse> createRepeated() =>
      $pb.PbList<SubmitDocumentsForReviewResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitDocumentsForReviewResponse>(
          create);
  static SubmitDocumentsForReviewResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  KYCStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(KYCStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class GetPendingReviewsRequest extends $pb.GeneratedMessage {
  factory GetPendingReviewsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetPendingReviewsRequest._();

  factory GetPendingReviewsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPendingReviewsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPendingReviewsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingReviewsRequest clone() =>
      GetPendingReviewsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingReviewsRequest copyWith(
          void Function(GetPendingReviewsRequest) updates) =>
      super.copyWith((message) => updates(message as GetPendingReviewsRequest))
          as GetPendingReviewsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsRequest create() => GetPendingReviewsRequest._();
  @$core.override
  GetPendingReviewsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingReviewsRequest> createRepeated() =>
      $pb.PbList<GetPendingReviewsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPendingReviewsRequest>(create);
  static GetPendingReviewsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetPendingReviewsResponse extends $pb.GeneratedMessage {
  factory GetPendingReviewsResponse({
    $core.bool? success,
    $core.Iterable<PendingReviewItem>? items,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (items != null) result.items.addAll(items);
    if (total != null) result.total = total;
    return result;
  }

  GetPendingReviewsResponse._();

  factory GetPendingReviewsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPendingReviewsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPendingReviewsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pc<PendingReviewItem>(
        2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: PendingReviewItem.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingReviewsResponse clone() =>
      GetPendingReviewsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingReviewsResponse copyWith(
          void Function(GetPendingReviewsResponse) updates) =>
      super.copyWith((message) => updates(message as GetPendingReviewsResponse))
          as GetPendingReviewsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsResponse create() => GetPendingReviewsResponse._();
  @$core.override
  GetPendingReviewsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingReviewsResponse> createRepeated() =>
      $pb.PbList<GetPendingReviewsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingReviewsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPendingReviewsResponse>(create);
  static GetPendingReviewsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PendingReviewItem> get items => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
}

class PendingReviewItem extends $pb.GeneratedMessage {
  factory PendingReviewItem({
    $core.String? userId,
    $core.String? userName,
    $core.String? countryCode,
    KYCTier? currentTier,
    KYCTier? targetTier,
    $core.Iterable<VerificationDocument>? documents,
    $1.Timestamp? submittedAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (countryCode != null) result.countryCode = countryCode;
    if (currentTier != null) result.currentTier = currentTier;
    if (targetTier != null) result.targetTier = targetTier;
    if (documents != null) result.documents.addAll(documents);
    if (submittedAt != null) result.submittedAt = submittedAt;
    return result;
  }

  PendingReviewItem._();

  factory PendingReviewItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PendingReviewItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PendingReviewItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'userName')
    ..aOS(3, _omitFieldNames ? '' : 'countryCode')
    ..e<KYCTier>(4, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..e<KYCTier>(5, _omitFieldNames ? '' : 'targetTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..pc<VerificationDocument>(
        6, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM,
        subBuilder: VerificationDocument.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'submittedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PendingReviewItem clone() => PendingReviewItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PendingReviewItem copyWith(void Function(PendingReviewItem) updates) =>
      super.copyWith((message) => updates(message as PendingReviewItem))
          as PendingReviewItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingReviewItem create() => PendingReviewItem._();
  @$core.override
  PendingReviewItem createEmptyInstance() => create();
  static $pb.PbList<PendingReviewItem> createRepeated() =>
      $pb.PbList<PendingReviewItem>();
  @$core.pragma('dart2js:noInline')
  static PendingReviewItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PendingReviewItem>(create);
  static PendingReviewItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(1);
  @$pb.TagNumber(2)
  set userName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountryCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryCode() => $_clearField(3);

  @$pb.TagNumber(4)
  KYCTier get currentTier => $_getN(3);
  @$pb.TagNumber(4)
  set currentTier(KYCTier value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentTier() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentTier() => $_clearField(4);

  @$pb.TagNumber(5)
  KYCTier get targetTier => $_getN(4);
  @$pb.TagNumber(5)
  set targetTier(KYCTier value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetTier() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetTier() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<VerificationDocument> get documents => $_getList(5);

  @$pb.TagNumber(7)
  $1.Timestamp get submittedAt => $_getN(6);
  @$pb.TagNumber(7)
  set submittedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSubmittedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearSubmittedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureSubmittedAt() => $_ensure(6);
}

class ReviewDocumentRequest extends $pb.GeneratedMessage {
  factory ReviewDocumentRequest({
    $core.String? documentId,
    $core.bool? approved,
    $core.String? rejectionReason,
    $core.String? adminNotes,
  }) {
    final result = create();
    if (documentId != null) result.documentId = documentId;
    if (approved != null) result.approved = approved;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (adminNotes != null) result.adminNotes = adminNotes;
    return result;
  }

  ReviewDocumentRequest._();

  factory ReviewDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewDocumentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..aOB(2, _omitFieldNames ? '' : 'approved')
    ..aOS(3, _omitFieldNames ? '' : 'rejectionReason')
    ..aOS(4, _omitFieldNames ? '' : 'adminNotes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewDocumentRequest clone() =>
      ReviewDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewDocumentRequest copyWith(
          void Function(ReviewDocumentRequest) updates) =>
      super.copyWith((message) => updates(message as ReviewDocumentRequest))
          as ReviewDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewDocumentRequest create() => ReviewDocumentRequest._();
  @$core.override
  ReviewDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<ReviewDocumentRequest> createRepeated() =>
      $pb.PbList<ReviewDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static ReviewDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewDocumentRequest>(create);
  static ReviewDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get approved => $_getBF(1);
  @$pb.TagNumber(2)
  set approved($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApproved() => $_has(1);
  @$pb.TagNumber(2)
  void clearApproved() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get rejectionReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set rejectionReason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRejectionReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearRejectionReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get adminNotes => $_getSZ(3);
  @$pb.TagNumber(4)
  set adminNotes($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdminNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminNotes() => $_clearField(4);
}

class ReviewDocumentResponse extends $pb.GeneratedMessage {
  factory ReviewDocumentResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  ReviewDocumentResponse._();

  factory ReviewDocumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewDocumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewDocumentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'kyc'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewDocumentResponse clone() =>
      ReviewDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewDocumentResponse copyWith(
          void Function(ReviewDocumentResponse) updates) =>
      super.copyWith((message) => updates(message as ReviewDocumentResponse))
          as ReviewDocumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewDocumentResponse create() => ReviewDocumentResponse._();
  @$core.override
  ReviewDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<ReviewDocumentResponse> createRepeated() =>
      $pb.PbList<ReviewDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static ReviewDocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewDocumentResponse>(create);
  static ReviewDocumentResponse? _defaultInstance;

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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
