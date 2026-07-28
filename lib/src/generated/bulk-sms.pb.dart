// This is a generated file - do not edit.
//
// Generated from bulk-sms.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'bulk-sms.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'bulk-sms.pbenum.dart';

class SmsProvider extends $pb.GeneratedMessage {
  factory SmsProvider({
    $core.String? id,
    $core.String? name,
    $core.String? displayName,
    $core.Iterable<$core.String>? supportedCountries,
    $core.bool? isActive,
    $core.bool? supportsDnd,
    $core.bool? supportsScheduling,
    $core.bool? supportsUnicode,
    $core.bool? supportsTemplates,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (displayName != null) result.displayName = displayName;
    if (supportedCountries != null)
      result.supportedCountries.addAll(supportedCountries);
    if (isActive != null) result.isActive = isActive;
    if (supportsDnd != null) result.supportsDnd = supportsDnd;
    if (supportsScheduling != null)
      result.supportsScheduling = supportsScheduling;
    if (supportsUnicode != null) result.supportsUnicode = supportsUnicode;
    if (supportsTemplates != null) result.supportsTemplates = supportsTemplates;
    return result;
  }

  SmsProvider._();

  factory SmsProvider.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsProvider.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsProvider',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..pPS(4, _omitFieldNames ? '' : 'supportedCountries')
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..aOB(6, _omitFieldNames ? '' : 'supportsDnd')
    ..aOB(7, _omitFieldNames ? '' : 'supportsScheduling')
    ..aOB(8, _omitFieldNames ? '' : 'supportsUnicode')
    ..aOB(9, _omitFieldNames ? '' : 'supportsTemplates')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsProvider clone() => SmsProvider()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsProvider copyWith(void Function(SmsProvider) updates) =>
      super.copyWith((message) => updates(message as SmsProvider))
          as SmsProvider;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsProvider create() => SmsProvider._();
  @$core.override
  SmsProvider createEmptyInstance() => create();
  static $pb.PbList<SmsProvider> createRepeated() => $pb.PbList<SmsProvider>();
  @$core.pragma('dart2js:noInline')
  static SmsProvider getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsProvider>(create);
  static SmsProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get supportedCountries => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsDnd => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsDnd($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSupportsDnd() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsDnd() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get supportsScheduling => $_getBF(6);
  @$pb.TagNumber(7)
  set supportsScheduling($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSupportsScheduling() => $_has(6);
  @$pb.TagNumber(7)
  void clearSupportsScheduling() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get supportsUnicode => $_getBF(7);
  @$pb.TagNumber(8)
  set supportsUnicode($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSupportsUnicode() => $_has(7);
  @$pb.TagNumber(8)
  void clearSupportsUnicode() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get supportsTemplates => $_getBF(8);
  @$pb.TagNumber(9)
  set supportsTemplates($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSupportsTemplates() => $_has(8);
  @$pb.TagNumber(9)
  void clearSupportsTemplates() => $_clearField(9);
}

class SmsPackage extends $pb.GeneratedMessage {
  factory SmsPackage({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.int? creditCount,
    $fixnum.Int64? priceKobo,
    $core.String? currency,
    $core.String? providerName,
    $core.int? validityDays,
    $core.bool? isActive,
    $core.bool? isPopular,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (creditCount != null) result.creditCount = creditCount;
    if (priceKobo != null) result.priceKobo = priceKobo;
    if (currency != null) result.currency = currency;
    if (providerName != null) result.providerName = providerName;
    if (validityDays != null) result.validityDays = validityDays;
    if (isActive != null) result.isActive = isActive;
    if (isPopular != null) result.isPopular = isPopular;
    return result;
  }

  SmsPackage._();

  factory SmsPackage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsPackage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsPackage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'creditCount', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'priceKobo')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'providerName')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'validityDays', $pb.PbFieldType.O3)
    ..aOB(9, _omitFieldNames ? '' : 'isActive')
    ..aOB(10, _omitFieldNames ? '' : 'isPopular')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsPackage clone() => SmsPackage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsPackage copyWith(void Function(SmsPackage) updates) =>
      super.copyWith((message) => updates(message as SmsPackage)) as SmsPackage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsPackage create() => SmsPackage._();
  @$core.override
  SmsPackage createEmptyInstance() => create();
  static $pb.PbList<SmsPackage> createRepeated() => $pb.PbList<SmsPackage>();
  @$core.pragma('dart2js:noInline')
  static SmsPackage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsPackage>(create);
  static SmsPackage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get creditCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set creditCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreditCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreditCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get priceKobo => $_getI64(4);
  @$pb.TagNumber(5)
  set priceKobo($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriceKobo() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceKobo() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get providerName => $_getSZ(6);
  @$pb.TagNumber(7)
  set providerName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProviderName() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get validityDays => $_getIZ(7);
  @$pb.TagNumber(8)
  set validityDays($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasValidityDays() => $_has(7);
  @$pb.TagNumber(8)
  void clearValidityDays() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isActive => $_getBF(8);
  @$pb.TagNumber(9)
  set isActive($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsActive() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsActive() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPopular => $_getBF(9);
  @$pb.TagNumber(10)
  set isPopular($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPopular() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPopular() => $_clearField(10);
}

class SmsRecipient extends $pb.GeneratedMessage {
  factory SmsRecipient({
    $core.String? phoneNumber,
    $core.String? name,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? variables,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (name != null) result.name = name;
    if (variables != null) result.variables.addEntries(variables);
    return result;
  }

  SmsRecipient._();

  factory SmsRecipient.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsRecipient.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsRecipient',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'variables',
        entryClassName: 'SmsRecipient.VariablesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('bulksms'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsRecipient clone() => SmsRecipient()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsRecipient copyWith(void Function(SmsRecipient) updates) =>
      super.copyWith((message) => updates(message as SmsRecipient))
          as SmsRecipient;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsRecipient create() => SmsRecipient._();
  @$core.override
  SmsRecipient createEmptyInstance() => create();
  static $pb.PbList<SmsRecipient> createRepeated() =>
      $pb.PbList<SmsRecipient>();
  @$core.pragma('dart2js:noInline')
  static SmsRecipient getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsRecipient>(create);
  static SmsRecipient? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.String> get variables => $_getMap(2);
}

class SmsCampaign extends $pb.GeneratedMessage {
  factory SmsCampaign({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? providerName,
    $core.String? senderId,
    $core.String? messageTemplate,
    $core.int? recipientsCount,
    $core.int? deliveredCount,
    $core.int? failedCount,
    $core.int? dndFilteredCount,
    $core.int? pendingCount,
    CampaignStatus? status,
    $fixnum.Int64? costKobo,
    $core.String? currency,
    $core.String? reference,
    $1.Timestamp? createdAt,
    $1.Timestamp? scheduledAt,
    $1.Timestamp? completedAt,
    $core.int? creditsUsed,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (providerName != null) result.providerName = providerName;
    if (senderId != null) result.senderId = senderId;
    if (messageTemplate != null) result.messageTemplate = messageTemplate;
    if (recipientsCount != null) result.recipientsCount = recipientsCount;
    if (deliveredCount != null) result.deliveredCount = deliveredCount;
    if (failedCount != null) result.failedCount = failedCount;
    if (dndFilteredCount != null) result.dndFilteredCount = dndFilteredCount;
    if (pendingCount != null) result.pendingCount = pendingCount;
    if (status != null) result.status = status;
    if (costKobo != null) result.costKobo = costKobo;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (createdAt != null) result.createdAt = createdAt;
    if (scheduledAt != null) result.scheduledAt = scheduledAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (creditsUsed != null) result.creditsUsed = creditsUsed;
    return result;
  }

  SmsCampaign._();

  factory SmsCampaign.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsCampaign.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsCampaign',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'providerName')
    ..aOS(5, _omitFieldNames ? '' : 'senderId')
    ..aOS(6, _omitFieldNames ? '' : 'messageTemplate')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'recipientsCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'deliveredCount', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'failedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'dndFilteredCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'pendingCount', $pb.PbFieldType.O3)
    ..e<CampaignStatus>(12, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: CampaignStatus.CAMPAIGN_STATUS_UNSPECIFIED,
        valueOf: CampaignStatus.valueOf,
        enumValues: CampaignStatus.values)
    ..aInt64(13, _omitFieldNames ? '' : 'costKobo')
    ..aOS(14, _omitFieldNames ? '' : 'currency')
    ..aOS(15, _omitFieldNames ? '' : 'reference')
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'scheduledAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(19, _omitFieldNames ? '' : 'creditsUsed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsCampaign clone() => SmsCampaign()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsCampaign copyWith(void Function(SmsCampaign) updates) =>
      super.copyWith((message) => updates(message as SmsCampaign))
          as SmsCampaign;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsCampaign create() => SmsCampaign._();
  @$core.override
  SmsCampaign createEmptyInstance() => create();
  static $pb.PbList<SmsCampaign> createRepeated() => $pb.PbList<SmsCampaign>();
  @$core.pragma('dart2js:noInline')
  static SmsCampaign getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsCampaign>(create);
  static SmsCampaign? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get senderId => $_getSZ(4);
  @$pb.TagNumber(5)
  set senderId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSenderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get messageTemplate => $_getSZ(5);
  @$pb.TagNumber(6)
  set messageTemplate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessageTemplate() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageTemplate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get recipientsCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set recipientsCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientsCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientsCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get deliveredCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set deliveredCount($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDeliveredCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeliveredCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get failedCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set failedCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFailedCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailedCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get dndFilteredCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set dndFilteredCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDndFilteredCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearDndFilteredCount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get pendingCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set pendingCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPendingCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearPendingCount() => $_clearField(11);

  @$pb.TagNumber(12)
  CampaignStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(CampaignStatus value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get costKobo => $_getI64(12);
  @$pb.TagNumber(13)
  set costKobo($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCostKobo() => $_has(12);
  @$pb.TagNumber(13)
  void clearCostKobo() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get currency => $_getSZ(13);
  @$pb.TagNumber(14)
  set currency($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrency() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get reference => $_getSZ(14);
  @$pb.TagNumber(15)
  set reference($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasReference() => $_has(14);
  @$pb.TagNumber(15)
  void clearReference() => $_clearField(15);

  @$pb.TagNumber(16)
  $1.Timestamp get createdAt => $_getN(15);
  @$pb.TagNumber(16)
  set createdAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCreatedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get scheduledAt => $_getN(16);
  @$pb.TagNumber(17)
  set scheduledAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasScheduledAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearScheduledAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureScheduledAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get completedAt => $_getN(17);
  @$pb.TagNumber(18)
  set completedAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCompletedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCompletedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCompletedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $core.int get creditsUsed => $_getIZ(18);
  @$pb.TagNumber(19)
  set creditsUsed($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCreditsUsed() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreditsUsed() => $_clearField(19);
}

class SmsDeliveryReport extends $pb.GeneratedMessage {
  factory SmsDeliveryReport({
    $core.String? id,
    $core.String? campaignId,
    $core.String? phoneNumber,
    $core.String? recipientName,
    DeliveryStatus? status,
    $core.String? providerMessageId,
    $1.Timestamp? sentAt,
    $1.Timestamp? deliveredAt,
    $core.String? failureReason,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (campaignId != null) result.campaignId = campaignId;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (recipientName != null) result.recipientName = recipientName;
    if (status != null) result.status = status;
    if (providerMessageId != null) result.providerMessageId = providerMessageId;
    if (sentAt != null) result.sentAt = sentAt;
    if (deliveredAt != null) result.deliveredAt = deliveredAt;
    if (failureReason != null) result.failureReason = failureReason;
    return result;
  }

  SmsDeliveryReport._();

  factory SmsDeliveryReport.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsDeliveryReport.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsDeliveryReport',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'campaignId')
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(4, _omitFieldNames ? '' : 'recipientName')
    ..e<DeliveryStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: DeliveryStatus.DELIVERY_STATUS_UNSPECIFIED,
        valueOf: DeliveryStatus.valueOf,
        enumValues: DeliveryStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'providerMessageId')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'sentAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'deliveredAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsDeliveryReport clone() => SmsDeliveryReport()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsDeliveryReport copyWith(void Function(SmsDeliveryReport) updates) =>
      super.copyWith((message) => updates(message as SmsDeliveryReport))
          as SmsDeliveryReport;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsDeliveryReport create() => SmsDeliveryReport._();
  @$core.override
  SmsDeliveryReport createEmptyInstance() => create();
  static $pb.PbList<SmsDeliveryReport> createRepeated() =>
      $pb.PbList<SmsDeliveryReport>();
  @$core.pragma('dart2js:noInline')
  static SmsDeliveryReport getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsDeliveryReport>(create);
  static SmsDeliveryReport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientName => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientName() => $_clearField(4);

  @$pb.TagNumber(5)
  DeliveryStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(DeliveryStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerMessageId => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerMessageId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderMessageId() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderMessageId() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get sentAt => $_getN(6);
  @$pb.TagNumber(7)
  set sentAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSentAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearSentAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureSentAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get deliveredAt => $_getN(7);
  @$pb.TagNumber(8)
  set deliveredAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDeliveredAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeliveredAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureDeliveredAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => $_clearField(9);
}

class SmsBalance extends $pb.GeneratedMessage {
  factory SmsBalance({
    $core.int? creditsRemaining,
    $core.String? providerName,
    $1.Timestamp? lastPurchaseAt,
  }) {
    final result = create();
    if (creditsRemaining != null) result.creditsRemaining = creditsRemaining;
    if (providerName != null) result.providerName = providerName;
    if (lastPurchaseAt != null) result.lastPurchaseAt = lastPurchaseAt;
    return result;
  }

  SmsBalance._();

  factory SmsBalance.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsBalance.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsBalance',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'creditsRemaining', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'providerName')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'lastPurchaseAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsBalance clone() => SmsBalance()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsBalance copyWith(void Function(SmsBalance) updates) =>
      super.copyWith((message) => updates(message as SmsBalance)) as SmsBalance;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsBalance create() => SmsBalance._();
  @$core.override
  SmsBalance createEmptyInstance() => create();
  static $pb.PbList<SmsBalance> createRepeated() => $pb.PbList<SmsBalance>();
  @$core.pragma('dart2js:noInline')
  static SmsBalance getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsBalance>(create);
  static SmsBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get creditsRemaining => $_getIZ(0);
  @$pb.TagNumber(1)
  set creditsRemaining($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCreditsRemaining() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreditsRemaining() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderName() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get lastPurchaseAt => $_getN(2);
  @$pb.TagNumber(3)
  set lastPurchaseAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLastPurchaseAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastPurchaseAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureLastPurchaseAt() => $_ensure(2);
}

class SmsPurchase extends $pb.GeneratedMessage {
  factory SmsPurchase({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? providerName,
    $core.String? packageId,
    $core.int? creditsPurchased,
    $fixnum.Int64? amountKobo,
    $core.String? currency,
    $core.String? reference,
    $core.String? status,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (providerName != null) result.providerName = providerName;
    if (packageId != null) result.packageId = packageId;
    if (creditsPurchased != null) result.creditsPurchased = creditsPurchased;
    if (amountKobo != null) result.amountKobo = amountKobo;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  SmsPurchase._();

  factory SmsPurchase.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SmsPurchase.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsPurchase',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'providerName')
    ..aOS(5, _omitFieldNames ? '' : 'packageId')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'creditsPurchased', $pb.PbFieldType.O3)
    ..aInt64(7, _omitFieldNames ? '' : 'amountKobo')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'reference')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsPurchase clone() => SmsPurchase()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsPurchase copyWith(void Function(SmsPurchase) updates) =>
      super.copyWith((message) => updates(message as SmsPurchase))
          as SmsPurchase;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsPurchase create() => SmsPurchase._();
  @$core.override
  SmsPurchase createEmptyInstance() => create();
  static $pb.PbList<SmsPurchase> createRepeated() => $pb.PbList<SmsPurchase>();
  @$core.pragma('dart2js:noInline')
  static SmsPurchase getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsPurchase>(create);
  static SmsPurchase? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get packageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set packageId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPackageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPackageId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get creditsPurchased => $_getIZ(5);
  @$pb.TagNumber(6)
  set creditsPurchased($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreditsPurchased() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreditsPurchased() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amountKobo => $_getI64(6);
  @$pb.TagNumber(7)
  set amountKobo($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmountKobo() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountKobo() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);
}

class SenderId extends $pb.GeneratedMessage {
  factory SenderId({
    $core.String? id,
    $core.String? userId,
    $core.String? senderId,
    SenderIdStatus? status,
    $core.String? country,
    $1.Timestamp? requestedAt,
    $1.Timestamp? approvedAt,
    $core.String? rejectionReason,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (senderId != null) result.senderId = senderId;
    if (status != null) result.status = status;
    if (country != null) result.country = country;
    if (requestedAt != null) result.requestedAt = requestedAt;
    if (approvedAt != null) result.approvedAt = approvedAt;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    return result;
  }

  SenderId._();

  factory SenderId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SenderId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SenderId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId')
    ..e<SenderIdStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SenderIdStatus.SENDER_ID_STATUS_UNSPECIFIED,
        valueOf: SenderIdStatus.valueOf,
        enumValues: SenderIdStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'country')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'requestedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'approvedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SenderId clone() => SenderId()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SenderId copyWith(void Function(SenderId) updates) =>
      super.copyWith((message) => updates(message as SenderId)) as SenderId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SenderId create() => SenderId._();
  @$core.override
  SenderId createEmptyInstance() => create();
  static $pb.PbList<SenderId> createRepeated() => $pb.PbList<SenderId>();
  @$core.pragma('dart2js:noInline')
  static SenderId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SenderId>(create);
  static SenderId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  SenderIdStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(SenderIdStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get country => $_getSZ(4);
  @$pb.TagNumber(5)
  set country($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCountry() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountry() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get requestedAt => $_getN(5);
  @$pb.TagNumber(6)
  set requestedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasRequestedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequestedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureRequestedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get approvedAt => $_getN(6);
  @$pb.TagNumber(7)
  set approvedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasApprovedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearApprovedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureApprovedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get rejectionReason => $_getSZ(7);
  @$pb.TagNumber(8)
  set rejectionReason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRejectionReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearRejectionReason() => $_clearField(8);
}

class PaginationInfo extends $pb.GeneratedMessage {
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final result = create();
    if (currentPage != null) result.currentPage = currentPage;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalItems != null) result.totalItems = totalItems;
    if (itemsPerPage != null) result.itemsPerPage = itemsPerPage;
    if (hasNext != null) result.hasNext = hasNext;
    if (hasPrev != null) result.hasPrev = hasPrev;
    return result;
  }

  PaginationInfo._();

  factory PaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginationInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) =>
      super.copyWith((message) => updates(message as PaginationInfo))
          as PaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginationInfo create() => PaginationInfo._();
  @$core.override
  PaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaginationInfo> createRepeated() =>
      $pb.PbList<PaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginationInfo>(create);
  static PaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => $_clearField(6);
}

/// --- GetSmsProviders ---
class GetSmsProvidersRequest extends $pb.GeneratedMessage {
  factory GetSmsProvidersRequest({
    $core.String? country,
  }) {
    final result = create();
    if (country != null) result.country = country;
    return result;
  }

  GetSmsProvidersRequest._();

  factory GetSmsProvidersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsProvidersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsProvidersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'country')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsProvidersRequest clone() =>
      GetSmsProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsProvidersRequest copyWith(
          void Function(GetSmsProvidersRequest) updates) =>
      super.copyWith((message) => updates(message as GetSmsProvidersRequest))
          as GetSmsProvidersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersRequest create() => GetSmsProvidersRequest._();
  @$core.override
  GetSmsProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsProvidersRequest> createRepeated() =>
      $pb.PbList<GetSmsProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsProvidersRequest>(create);
  static GetSmsProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => $_clearField(1);
}

class GetSmsProvidersResponse extends $pb.GeneratedMessage {
  factory GetSmsProvidersResponse({
    $core.Iterable<SmsProvider>? providers,
  }) {
    final result = create();
    if (providers != null) result.providers.addAll(providers);
    return result;
  }

  GetSmsProvidersResponse._();

  factory GetSmsProvidersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsProvidersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsProvidersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..pc<SmsProvider>(1, _omitFieldNames ? '' : 'providers', $pb.PbFieldType.PM,
        subBuilder: SmsProvider.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsProvidersResponse clone() =>
      GetSmsProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsProvidersResponse copyWith(
          void Function(GetSmsProvidersResponse) updates) =>
      super.copyWith((message) => updates(message as GetSmsProvidersResponse))
          as GetSmsProvidersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersResponse create() => GetSmsProvidersResponse._();
  @$core.override
  GetSmsProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsProvidersResponse> createRepeated() =>
      $pb.PbList<GetSmsProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsProvidersResponse>(create);
  static GetSmsProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SmsProvider> get providers => $_getList(0);
}

/// --- GetSmsPackages ---
class GetSmsPackagesRequest extends $pb.GeneratedMessage {
  factory GetSmsPackagesRequest({
    $core.String? country,
    $core.String? currency,
  }) {
    final result = create();
    if (country != null) result.country = country;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetSmsPackagesRequest._();

  factory GetSmsPackagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsPackagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsPackagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'country')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsPackagesRequest clone() =>
      GetSmsPackagesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsPackagesRequest copyWith(
          void Function(GetSmsPackagesRequest) updates) =>
      super.copyWith((message) => updates(message as GetSmsPackagesRequest))
          as GetSmsPackagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesRequest create() => GetSmsPackagesRequest._();
  @$core.override
  GetSmsPackagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsPackagesRequest> createRepeated() =>
      $pb.PbList<GetSmsPackagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsPackagesRequest>(create);
  static GetSmsPackagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);
}

class GetSmsPackagesResponse extends $pb.GeneratedMessage {
  factory GetSmsPackagesResponse({
    $core.Iterable<SmsPackage>? packages,
    $core.String? providerName,
  }) {
    final result = create();
    if (packages != null) result.packages.addAll(packages);
    if (providerName != null) result.providerName = providerName;
    return result;
  }

  GetSmsPackagesResponse._();

  factory GetSmsPackagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsPackagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsPackagesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..pc<SmsPackage>(1, _omitFieldNames ? '' : 'packages', $pb.PbFieldType.PM,
        subBuilder: SmsPackage.create)
    ..aOS(2, _omitFieldNames ? '' : 'providerName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsPackagesResponse clone() =>
      GetSmsPackagesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsPackagesResponse copyWith(
          void Function(GetSmsPackagesResponse) updates) =>
      super.copyWith((message) => updates(message as GetSmsPackagesResponse))
          as GetSmsPackagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesResponse create() => GetSmsPackagesResponse._();
  @$core.override
  GetSmsPackagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsPackagesResponse> createRepeated() =>
      $pb.PbList<GetSmsPackagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsPackagesResponse>(create);
  static GetSmsPackagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SmsPackage> get packages => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get providerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderName() => $_clearField(2);
}

/// --- GetSmsBalance ---
class GetSmsBalanceRequest extends $pb.GeneratedMessage {
  factory GetSmsBalanceRequest() => create();

  GetSmsBalanceRequest._();

  factory GetSmsBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsBalanceRequest clone() =>
      GetSmsBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsBalanceRequest copyWith(void Function(GetSmsBalanceRequest) updates) =>
      super.copyWith((message) => updates(message as GetSmsBalanceRequest))
          as GetSmsBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceRequest create() => GetSmsBalanceRequest._();
  @$core.override
  GetSmsBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsBalanceRequest> createRepeated() =>
      $pb.PbList<GetSmsBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsBalanceRequest>(create);
  static GetSmsBalanceRequest? _defaultInstance;
}

class GetSmsBalanceResponse extends $pb.GeneratedMessage {
  factory GetSmsBalanceResponse({
    $core.Iterable<SmsBalance>? balances,
    $core.int? totalCredits,
  }) {
    final result = create();
    if (balances != null) result.balances.addAll(balances);
    if (totalCredits != null) result.totalCredits = totalCredits;
    return result;
  }

  GetSmsBalanceResponse._();

  factory GetSmsBalanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..pc<SmsBalance>(1, _omitFieldNames ? '' : 'balances', $pb.PbFieldType.PM,
        subBuilder: SmsBalance.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCredits', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsBalanceResponse clone() =>
      GetSmsBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsBalanceResponse copyWith(
          void Function(GetSmsBalanceResponse) updates) =>
      super.copyWith((message) => updates(message as GetSmsBalanceResponse))
          as GetSmsBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceResponse create() => GetSmsBalanceResponse._();
  @$core.override
  GetSmsBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsBalanceResponse> createRepeated() =>
      $pb.PbList<GetSmsBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsBalanceResponse>(create);
  static GetSmsBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SmsBalance> get balances => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCredits => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCredits($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCredits() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCredits() => $_clearField(2);
}

/// --- PurchaseSmsCredits ---
class PurchaseSmsCreditRequest extends $pb.GeneratedMessage {
  factory PurchaseSmsCreditRequest({
    $core.String? packageId,
    $core.String? providerName,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? currency,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    if (providerName != null) result.providerName = providerName;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (currency != null) result.currency = currency;
    return result;
  }

  PurchaseSmsCreditRequest._();

  factory PurchaseSmsCreditRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseSmsCreditRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseSmsCreditRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..aOS(2, _omitFieldNames ? '' : 'providerName')
    ..aOS(3, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseSmsCreditRequest clone() =>
      PurchaseSmsCreditRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseSmsCreditRequest copyWith(
          void Function(PurchaseSmsCreditRequest) updates) =>
      super.copyWith((message) => updates(message as PurchaseSmsCreditRequest))
          as PurchaseSmsCreditRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditRequest create() => PurchaseSmsCreditRequest._();
  @$core.override
  PurchaseSmsCreditRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseSmsCreditRequest> createRepeated() =>
      $pb.PbList<PurchaseSmsCreditRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseSmsCreditRequest>(create);
  static PurchaseSmsCreditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get idempotencyKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set idempotencyKey($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIdempotencyKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdempotencyKey() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);
}

class PurchaseSmsCreditResponse extends $pb.GeneratedMessage {
  factory PurchaseSmsCreditResponse({
    SmsPurchase? purchase,
    $core.int? newCreditBalance,
    $core.double? newWalletBalance,
    $core.String? message,
  }) {
    final result = create();
    if (purchase != null) result.purchase = purchase;
    if (newCreditBalance != null) result.newCreditBalance = newCreditBalance;
    if (newWalletBalance != null) result.newWalletBalance = newWalletBalance;
    if (message != null) result.message = message;
    return result;
  }

  PurchaseSmsCreditResponse._();

  factory PurchaseSmsCreditResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseSmsCreditResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseSmsCreditResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOM<SmsPurchase>(1, _omitFieldNames ? '' : 'purchase',
        subBuilder: SmsPurchase.create)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'newWalletBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseSmsCreditResponse clone() =>
      PurchaseSmsCreditResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseSmsCreditResponse copyWith(
          void Function(PurchaseSmsCreditResponse) updates) =>
      super.copyWith((message) => updates(message as PurchaseSmsCreditResponse))
          as PurchaseSmsCreditResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditResponse create() => PurchaseSmsCreditResponse._();
  @$core.override
  PurchaseSmsCreditResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseSmsCreditResponse> createRepeated() =>
      $pb.PbList<PurchaseSmsCreditResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseSmsCreditResponse>(create);
  static PurchaseSmsCreditResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsPurchase get purchase => $_getN(0);
  @$pb.TagNumber(1)
  set purchase(SmsPurchase value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchase() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchase() => $_clearField(1);
  @$pb.TagNumber(1)
  SmsPurchase ensurePurchase() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get newCreditBalance => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCreditBalance($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewCreditBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCreditBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get newWalletBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newWalletBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewWalletBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewWalletBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// --- SendBulkSms ---
class SendBulkSmsRequest extends $pb.GeneratedMessage {
  factory SendBulkSmsRequest({
    $core.String? providerName,
    $core.String? senderId,
    $core.String? messageTemplate,
    $core.Iterable<SmsRecipient>? recipients,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (providerName != null) result.providerName = providerName;
    if (senderId != null) result.senderId = senderId;
    if (messageTemplate != null) result.messageTemplate = messageTemplate;
    if (recipients != null) result.recipients.addAll(recipients);
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  SendBulkSmsRequest._();

  factory SendBulkSmsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendBulkSmsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendBulkSmsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerName')
    ..aOS(2, _omitFieldNames ? '' : 'senderId')
    ..aOS(3, _omitFieldNames ? '' : 'messageTemplate')
    ..pc<SmsRecipient>(
        4, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM,
        subBuilder: SmsRecipient.create)
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendBulkSmsRequest clone() => SendBulkSmsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendBulkSmsRequest copyWith(void Function(SendBulkSmsRequest) updates) =>
      super.copyWith((message) => updates(message as SendBulkSmsRequest))
          as SendBulkSmsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendBulkSmsRequest create() => SendBulkSmsRequest._();
  @$core.override
  SendBulkSmsRequest createEmptyInstance() => create();
  static $pb.PbList<SendBulkSmsRequest> createRepeated() =>
      $pb.PbList<SendBulkSmsRequest>();
  @$core.pragma('dart2js:noInline')
  static SendBulkSmsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendBulkSmsRequest>(create);
  static SendBulkSmsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerName => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProviderName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageTemplate => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageTemplate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessageTemplate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageTemplate() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<SmsRecipient> get recipients => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class SendBulkSmsResponse extends $pb.GeneratedMessage {
  factory SendBulkSmsResponse({
    SmsCampaign? campaign,
    $core.int? newCreditBalance,
    $core.String? message,
  }) {
    final result = create();
    if (campaign != null) result.campaign = campaign;
    if (newCreditBalance != null) result.newCreditBalance = newCreditBalance;
    if (message != null) result.message = message;
    return result;
  }

  SendBulkSmsResponse._();

  factory SendBulkSmsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendBulkSmsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendBulkSmsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOM<SmsCampaign>(1, _omitFieldNames ? '' : 'campaign',
        subBuilder: SmsCampaign.create)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendBulkSmsResponse clone() => SendBulkSmsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendBulkSmsResponse copyWith(void Function(SendBulkSmsResponse) updates) =>
      super.copyWith((message) => updates(message as SendBulkSmsResponse))
          as SendBulkSmsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendBulkSmsResponse create() => SendBulkSmsResponse._();
  @$core.override
  SendBulkSmsResponse createEmptyInstance() => create();
  static $pb.PbList<SendBulkSmsResponse> createRepeated() =>
      $pb.PbList<SendBulkSmsResponse>();
  @$core.pragma('dart2js:noInline')
  static SendBulkSmsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendBulkSmsResponse>(create);
  static SendBulkSmsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsCampaign get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(SmsCampaign value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => $_clearField(1);
  @$pb.TagNumber(1)
  SmsCampaign ensureCampaign() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get newCreditBalance => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCreditBalance($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewCreditBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCreditBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// --- ScheduleSms ---
class ScheduleSmsRequest extends $pb.GeneratedMessage {
  factory ScheduleSmsRequest({
    $core.String? providerName,
    $core.String? senderId,
    $core.String? messageTemplate,
    $core.Iterable<SmsRecipient>? recipients,
    $1.Timestamp? scheduledAt,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (providerName != null) result.providerName = providerName;
    if (senderId != null) result.senderId = senderId;
    if (messageTemplate != null) result.messageTemplate = messageTemplate;
    if (recipients != null) result.recipients.addAll(recipients);
    if (scheduledAt != null) result.scheduledAt = scheduledAt;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  ScheduleSmsRequest._();

  factory ScheduleSmsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScheduleSmsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScheduleSmsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerName')
    ..aOS(2, _omitFieldNames ? '' : 'senderId')
    ..aOS(3, _omitFieldNames ? '' : 'messageTemplate')
    ..pc<SmsRecipient>(
        4, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM,
        subBuilder: SmsRecipient.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'scheduledAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(7, _omitFieldNames ? '' : 'transactionId')
    ..aOS(8, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleSmsRequest clone() => ScheduleSmsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleSmsRequest copyWith(void Function(ScheduleSmsRequest) updates) =>
      super.copyWith((message) => updates(message as ScheduleSmsRequest))
          as ScheduleSmsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScheduleSmsRequest create() => ScheduleSmsRequest._();
  @$core.override
  ScheduleSmsRequest createEmptyInstance() => create();
  static $pb.PbList<ScheduleSmsRequest> createRepeated() =>
      $pb.PbList<ScheduleSmsRequest>();
  @$core.pragma('dart2js:noInline')
  static ScheduleSmsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScheduleSmsRequest>(create);
  static ScheduleSmsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerName => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProviderName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageTemplate => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageTemplate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessageTemplate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageTemplate() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<SmsRecipient> get recipients => $_getList(3);

  @$pb.TagNumber(5)
  $1.Timestamp get scheduledAt => $_getN(4);
  @$pb.TagNumber(5)
  set scheduledAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasScheduledAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureScheduledAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get verificationToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set verificationToken($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVerificationToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerificationToken() => $_clearField(8);
}

class ScheduleSmsResponse extends $pb.GeneratedMessage {
  factory ScheduleSmsResponse({
    SmsCampaign? campaign,
    $core.int? newCreditBalance,
    $core.String? message,
  }) {
    final result = create();
    if (campaign != null) result.campaign = campaign;
    if (newCreditBalance != null) result.newCreditBalance = newCreditBalance;
    if (message != null) result.message = message;
    return result;
  }

  ScheduleSmsResponse._();

  factory ScheduleSmsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScheduleSmsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScheduleSmsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOM<SmsCampaign>(1, _omitFieldNames ? '' : 'campaign',
        subBuilder: SmsCampaign.create)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleSmsResponse clone() => ScheduleSmsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleSmsResponse copyWith(void Function(ScheduleSmsResponse) updates) =>
      super.copyWith((message) => updates(message as ScheduleSmsResponse))
          as ScheduleSmsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScheduleSmsResponse create() => ScheduleSmsResponse._();
  @$core.override
  ScheduleSmsResponse createEmptyInstance() => create();
  static $pb.PbList<ScheduleSmsResponse> createRepeated() =>
      $pb.PbList<ScheduleSmsResponse>();
  @$core.pragma('dart2js:noInline')
  static ScheduleSmsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScheduleSmsResponse>(create);
  static ScheduleSmsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsCampaign get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(SmsCampaign value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => $_clearField(1);
  @$pb.TagNumber(1)
  SmsCampaign ensureCampaign() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get newCreditBalance => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCreditBalance($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewCreditBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCreditBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// --- CancelScheduledSms ---
class CancelScheduledSmsRequest extends $pb.GeneratedMessage {
  factory CancelScheduledSmsRequest({
    $core.String? campaignId,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    return result;
  }

  CancelScheduledSmsRequest._();

  factory CancelScheduledSmsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelScheduledSmsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelScheduledSmsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledSmsRequest clone() =>
      CancelScheduledSmsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledSmsRequest copyWith(
          void Function(CancelScheduledSmsRequest) updates) =>
      super.copyWith((message) => updates(message as CancelScheduledSmsRequest))
          as CancelScheduledSmsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsRequest create() => CancelScheduledSmsRequest._();
  @$core.override
  CancelScheduledSmsRequest createEmptyInstance() => create();
  static $pb.PbList<CancelScheduledSmsRequest> createRepeated() =>
      $pb.PbList<CancelScheduledSmsRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelScheduledSmsRequest>(create);
  static CancelScheduledSmsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);
}

class CancelScheduledSmsResponse extends $pb.GeneratedMessage {
  factory CancelScheduledSmsResponse({
    $core.bool? success,
    $core.int? creditsRefunded,
    $core.int? newCreditBalance,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (creditsRefunded != null) result.creditsRefunded = creditsRefunded;
    if (newCreditBalance != null) result.newCreditBalance = newCreditBalance;
    if (message != null) result.message = message;
    return result;
  }

  CancelScheduledSmsResponse._();

  factory CancelScheduledSmsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelScheduledSmsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelScheduledSmsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'creditsRefunded', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledSmsResponse clone() =>
      CancelScheduledSmsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelScheduledSmsResponse copyWith(
          void Function(CancelScheduledSmsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CancelScheduledSmsResponse))
          as CancelScheduledSmsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsResponse create() => CancelScheduledSmsResponse._();
  @$core.override
  CancelScheduledSmsResponse createEmptyInstance() => create();
  static $pb.PbList<CancelScheduledSmsResponse> createRepeated() =>
      $pb.PbList<CancelScheduledSmsResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelScheduledSmsResponse>(create);
  static CancelScheduledSmsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get creditsRefunded => $_getIZ(1);
  @$pb.TagNumber(2)
  set creditsRefunded($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreditsRefunded() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreditsRefunded() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get newCreditBalance => $_getIZ(2);
  @$pb.TagNumber(3)
  set newCreditBalance($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewCreditBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewCreditBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// --- GetSmsCampaignStatus ---
class GetSmsCampaignStatusRequest extends $pb.GeneratedMessage {
  factory GetSmsCampaignStatusRequest({
    $core.String? campaignId,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    return result;
  }

  GetSmsCampaignStatusRequest._();

  factory GetSmsCampaignStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsCampaignStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsCampaignStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsCampaignStatusRequest clone() =>
      GetSmsCampaignStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsCampaignStatusRequest copyWith(
          void Function(GetSmsCampaignStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSmsCampaignStatusRequest))
          as GetSmsCampaignStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusRequest create() =>
      GetSmsCampaignStatusRequest._();
  @$core.override
  GetSmsCampaignStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsCampaignStatusRequest> createRepeated() =>
      $pb.PbList<GetSmsCampaignStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsCampaignStatusRequest>(create);
  static GetSmsCampaignStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);
}

class GetSmsCampaignStatusResponse extends $pb.GeneratedMessage {
  factory GetSmsCampaignStatusResponse({
    SmsCampaign? campaign,
  }) {
    final result = create();
    if (campaign != null) result.campaign = campaign;
    return result;
  }

  GetSmsCampaignStatusResponse._();

  factory GetSmsCampaignStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsCampaignStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsCampaignStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOM<SmsCampaign>(1, _omitFieldNames ? '' : 'campaign',
        subBuilder: SmsCampaign.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsCampaignStatusResponse clone() =>
      GetSmsCampaignStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsCampaignStatusResponse copyWith(
          void Function(GetSmsCampaignStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSmsCampaignStatusResponse))
          as GetSmsCampaignStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusResponse create() =>
      GetSmsCampaignStatusResponse._();
  @$core.override
  GetSmsCampaignStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsCampaignStatusResponse> createRepeated() =>
      $pb.PbList<GetSmsCampaignStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsCampaignStatusResponse>(create);
  static GetSmsCampaignStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsCampaign get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(SmsCampaign value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => $_clearField(1);
  @$pb.TagNumber(1)
  SmsCampaign ensureCampaign() => $_ensure(0);
}

/// --- GetDeliveryReport ---
class GetDeliveryReportRequest extends $pb.GeneratedMessage {
  factory GetDeliveryReportRequest({
    $core.String? campaignId,
    $core.int? page,
    $core.int? pageSize,
    $core.String? statusFilter,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (statusFilter != null) result.statusFilter = statusFilter;
    return result;
  }

  GetDeliveryReportRequest._();

  factory GetDeliveryReportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDeliveryReportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDeliveryReportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'statusFilter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeliveryReportRequest clone() =>
      GetDeliveryReportRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeliveryReportRequest copyWith(
          void Function(GetDeliveryReportRequest) updates) =>
      super.copyWith((message) => updates(message as GetDeliveryReportRequest))
          as GetDeliveryReportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportRequest create() => GetDeliveryReportRequest._();
  @$core.override
  GetDeliveryReportRequest createEmptyInstance() => create();
  static $pb.PbList<GetDeliveryReportRequest> createRepeated() =>
      $pb.PbList<GetDeliveryReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDeliveryReportRequest>(create);
  static GetDeliveryReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get statusFilter => $_getSZ(3);
  @$pb.TagNumber(4)
  set statusFilter($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatusFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatusFilter() => $_clearField(4);
}

class GetDeliveryReportResponse extends $pb.GeneratedMessage {
  factory GetDeliveryReportResponse({
    $core.Iterable<SmsDeliveryReport>? reports,
    PaginationInfo? pagination,
  }) {
    final result = create();
    if (reports != null) result.reports.addAll(reports);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetDeliveryReportResponse._();

  factory GetDeliveryReportResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDeliveryReportResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDeliveryReportResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..pc<SmsDeliveryReport>(
        1, _omitFieldNames ? '' : 'reports', $pb.PbFieldType.PM,
        subBuilder: SmsDeliveryReport.create)
    ..aOM<PaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeliveryReportResponse clone() =>
      GetDeliveryReportResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeliveryReportResponse copyWith(
          void Function(GetDeliveryReportResponse) updates) =>
      super.copyWith((message) => updates(message as GetDeliveryReportResponse))
          as GetDeliveryReportResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportResponse create() => GetDeliveryReportResponse._();
  @$core.override
  GetDeliveryReportResponse createEmptyInstance() => create();
  static $pb.PbList<GetDeliveryReportResponse> createRepeated() =>
      $pb.PbList<GetDeliveryReportResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDeliveryReportResponse>(create);
  static GetDeliveryReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SmsDeliveryReport> get reports => $_getList(0);

  @$pb.TagNumber(2)
  PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PaginationInfo ensurePagination() => $_ensure(1);
}

/// --- GetSmsHistory ---
class GetSmsHistoryRequest extends $pb.GeneratedMessage {
  factory GetSmsHistoryRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? statusFilter,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (statusFilter != null) result.statusFilter = statusFilter;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetSmsHistoryRequest._();

  factory GetSmsHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'statusFilter')
    ..aOS(4, _omitFieldNames ? '' : 'startDate')
    ..aOS(5, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsHistoryRequest clone() =>
      GetSmsHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsHistoryRequest copyWith(void Function(GetSmsHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetSmsHistoryRequest))
          as GetSmsHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryRequest create() => GetSmsHistoryRequest._();
  @$core.override
  GetSmsHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsHistoryRequest> createRepeated() =>
      $pb.PbList<GetSmsHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsHistoryRequest>(create);
  static GetSmsHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get statusFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set statusFilter($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get startDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get endDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set endDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => $_clearField(5);
}

class GetSmsHistoryResponse extends $pb.GeneratedMessage {
  factory GetSmsHistoryResponse({
    $core.Iterable<SmsCampaign>? campaigns,
    PaginationInfo? pagination,
  }) {
    final result = create();
    if (campaigns != null) result.campaigns.addAll(campaigns);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetSmsHistoryResponse._();

  factory GetSmsHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSmsHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSmsHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..pc<SmsCampaign>(1, _omitFieldNames ? '' : 'campaigns', $pb.PbFieldType.PM,
        subBuilder: SmsCampaign.create)
    ..aOM<PaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsHistoryResponse clone() =>
      GetSmsHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSmsHistoryResponse copyWith(
          void Function(GetSmsHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetSmsHistoryResponse))
          as GetSmsHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryResponse create() => GetSmsHistoryResponse._();
  @$core.override
  GetSmsHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsHistoryResponse> createRepeated() =>
      $pb.PbList<GetSmsHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSmsHistoryResponse>(create);
  static GetSmsHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SmsCampaign> get campaigns => $_getList(0);

  @$pb.TagNumber(2)
  PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PaginationInfo ensurePagination() => $_ensure(1);
}

/// --- GetSenderIds ---
class GetSenderIdsRequest extends $pb.GeneratedMessage {
  factory GetSenderIdsRequest() => create();

  GetSenderIdsRequest._();

  factory GetSenderIdsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSenderIdsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSenderIdsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSenderIdsRequest clone() => GetSenderIdsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSenderIdsRequest copyWith(void Function(GetSenderIdsRequest) updates) =>
      super.copyWith((message) => updates(message as GetSenderIdsRequest))
          as GetSenderIdsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSenderIdsRequest create() => GetSenderIdsRequest._();
  @$core.override
  GetSenderIdsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSenderIdsRequest> createRepeated() =>
      $pb.PbList<GetSenderIdsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSenderIdsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSenderIdsRequest>(create);
  static GetSenderIdsRequest? _defaultInstance;
}

class GetSenderIdsResponse extends $pb.GeneratedMessage {
  factory GetSenderIdsResponse({
    $core.Iterable<SenderId>? senderIds,
  }) {
    final result = create();
    if (senderIds != null) result.senderIds.addAll(senderIds);
    return result;
  }

  GetSenderIdsResponse._();

  factory GetSenderIdsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSenderIdsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSenderIdsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..pc<SenderId>(1, _omitFieldNames ? '' : 'senderIds', $pb.PbFieldType.PM,
        subBuilder: SenderId.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSenderIdsResponse clone() =>
      GetSenderIdsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSenderIdsResponse copyWith(void Function(GetSenderIdsResponse) updates) =>
      super.copyWith((message) => updates(message as GetSenderIdsResponse))
          as GetSenderIdsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSenderIdsResponse create() => GetSenderIdsResponse._();
  @$core.override
  GetSenderIdsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSenderIdsResponse> createRepeated() =>
      $pb.PbList<GetSenderIdsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSenderIdsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSenderIdsResponse>(create);
  static GetSenderIdsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SenderId> get senderIds => $_getList(0);
}

/// --- RequestSenderId ---
class RequestSenderIdRequest extends $pb.GeneratedMessage {
  factory RequestSenderIdRequest({
    $core.String? senderId,
    $core.String? country,
    $core.String? purpose,
  }) {
    final result = create();
    if (senderId != null) result.senderId = senderId;
    if (country != null) result.country = country;
    if (purpose != null) result.purpose = purpose;
    return result;
  }

  RequestSenderIdRequest._();

  factory RequestSenderIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestSenderIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestSenderIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderId')
    ..aOS(2, _omitFieldNames ? '' : 'country')
    ..aOS(3, _omitFieldNames ? '' : 'purpose')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestSenderIdRequest clone() =>
      RequestSenderIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestSenderIdRequest copyWith(
          void Function(RequestSenderIdRequest) updates) =>
      super.copyWith((message) => updates(message as RequestSenderIdRequest))
          as RequestSenderIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestSenderIdRequest create() => RequestSenderIdRequest._();
  @$core.override
  RequestSenderIdRequest createEmptyInstance() => create();
  static $pb.PbList<RequestSenderIdRequest> createRepeated() =>
      $pb.PbList<RequestSenderIdRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestSenderIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestSenderIdRequest>(create);
  static RequestSenderIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get purpose => $_getSZ(2);
  @$pb.TagNumber(3)
  set purpose($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPurpose() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurpose() => $_clearField(3);
}

class RequestSenderIdResponse extends $pb.GeneratedMessage {
  factory RequestSenderIdResponse({
    SenderId? senderId,
    $core.String? message,
  }) {
    final result = create();
    if (senderId != null) result.senderId = senderId;
    if (message != null) result.message = message;
    return result;
  }

  RequestSenderIdResponse._();

  factory RequestSenderIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestSenderIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestSenderIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'bulksms'),
      createEmptyInstance: create)
    ..aOM<SenderId>(1, _omitFieldNames ? '' : 'senderId',
        subBuilder: SenderId.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestSenderIdResponse clone() =>
      RequestSenderIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestSenderIdResponse copyWith(
          void Function(RequestSenderIdResponse) updates) =>
      super.copyWith((message) => updates(message as RequestSenderIdResponse))
          as RequestSenderIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestSenderIdResponse create() => RequestSenderIdResponse._();
  @$core.override
  RequestSenderIdResponse createEmptyInstance() => create();
  static $pb.PbList<RequestSenderIdResponse> createRepeated() =>
      $pb.PbList<RequestSenderIdResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestSenderIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestSenderIdResponse>(create);
  static RequestSenderIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SenderId get senderId => $_getN(0);
  @$pb.TagNumber(1)
  set senderId(SenderId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderId() => $_clearField(1);
  @$pb.TagNumber(1)
  SenderId ensureSenderId() => $_ensure(0);

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
