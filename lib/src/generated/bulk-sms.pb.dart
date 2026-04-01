///
//  Generated code. Do not modify.
//  source: bulk-sms.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'bulk-sms.pbenum.dart';

export 'bulk-sms.pbenum.dart';

class SmsProvider extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsProvider', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedCountries')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsDnd')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsScheduling')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsUnicode')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsTemplates')
    ..hasRequiredFields = false
  ;

  SmsProvider._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (supportedCountries != null) {
      _result.supportedCountries.addAll(supportedCountries);
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (supportsDnd != null) {
      _result.supportsDnd = supportsDnd;
    }
    if (supportsScheduling != null) {
      _result.supportsScheduling = supportsScheduling;
    }
    if (supportsUnicode != null) {
      _result.supportsUnicode = supportsUnicode;
    }
    if (supportsTemplates != null) {
      _result.supportsTemplates = supportsTemplates;
    }
    return _result;
  }
  factory SmsProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsProvider clone() => SmsProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsProvider copyWith(void Function(SmsProvider) updates) => super.copyWith((message) => updates(message as SmsProvider)) as SmsProvider; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsProvider create() => SmsProvider._();
  SmsProvider createEmptyInstance() => create();
  static $pb.PbList<SmsProvider> createRepeated() => $pb.PbList<SmsProvider>();
  @$core.pragma('dart2js:noInline')
  static SmsProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsProvider>(create);
  static SmsProvider? _defaultInstance;

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
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get supportedCountries => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsDnd => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsDnd($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSupportsDnd() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsDnd() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get supportsScheduling => $_getBF(6);
  @$pb.TagNumber(7)
  set supportsScheduling($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSupportsScheduling() => $_has(6);
  @$pb.TagNumber(7)
  void clearSupportsScheduling() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get supportsUnicode => $_getBF(7);
  @$pb.TagNumber(8)
  set supportsUnicode($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSupportsUnicode() => $_has(7);
  @$pb.TagNumber(8)
  void clearSupportsUnicode() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get supportsTemplates => $_getBF(8);
  @$pb.TagNumber(9)
  set supportsTemplates($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSupportsTemplates() => $_has(8);
  @$pb.TagNumber(9)
  void clearSupportsTemplates() => clearField(9);
}

class SmsPackage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsPackage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditCount', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceKobo')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validityDays', $pb.PbFieldType.O3)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPopular')
    ..hasRequiredFields = false
  ;

  SmsPackage._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (creditCount != null) {
      _result.creditCount = creditCount;
    }
    if (priceKobo != null) {
      _result.priceKobo = priceKobo;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (validityDays != null) {
      _result.validityDays = validityDays;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (isPopular != null) {
      _result.isPopular = isPopular;
    }
    return _result;
  }
  factory SmsPackage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsPackage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsPackage clone() => SmsPackage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsPackage copyWith(void Function(SmsPackage) updates) => super.copyWith((message) => updates(message as SmsPackage)) as SmsPackage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsPackage create() => SmsPackage._();
  SmsPackage createEmptyInstance() => create();
  static $pb.PbList<SmsPackage> createRepeated() => $pb.PbList<SmsPackage>();
  @$core.pragma('dart2js:noInline')
  static SmsPackage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsPackage>(create);
  static SmsPackage? _defaultInstance;

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
  $core.int get creditCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set creditCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreditCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreditCount() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get priceKobo => $_getI64(4);
  @$pb.TagNumber(5)
  set priceKobo($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPriceKobo() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceKobo() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get providerName => $_getSZ(6);
  @$pb.TagNumber(7)
  set providerName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProviderName() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderName() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get validityDays => $_getIZ(7);
  @$pb.TagNumber(8)
  set validityDays($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasValidityDays() => $_has(7);
  @$pb.TagNumber(8)
  void clearValidityDays() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isActive => $_getBF(8);
  @$pb.TagNumber(9)
  set isActive($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsActive() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsActive() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPopular => $_getBF(9);
  @$pb.TagNumber(10)
  set isPopular($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsPopular() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPopular() => clearField(10);
}

class SmsRecipient extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsRecipient', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..m<$core.String, $core.String>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variables', entryClassName: 'SmsRecipient.VariablesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('bulksms'))
    ..hasRequiredFields = false
  ;

  SmsRecipient._() : super();
  factory SmsRecipient({
    $core.String? phoneNumber,
    $core.String? name,
    $core.Map<$core.String, $core.String>? variables,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (name != null) {
      _result.name = name;
    }
    if (variables != null) {
      _result.variables.addAll(variables);
    }
    return _result;
  }
  factory SmsRecipient.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsRecipient.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsRecipient clone() => SmsRecipient()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsRecipient copyWith(void Function(SmsRecipient) updates) => super.copyWith((message) => updates(message as SmsRecipient)) as SmsRecipient; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsRecipient create() => SmsRecipient._();
  SmsRecipient createEmptyInstance() => create();
  static $pb.PbList<SmsRecipient> createRepeated() => $pb.PbList<SmsRecipient>();
  @$core.pragma('dart2js:noInline')
  static SmsRecipient getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsRecipient>(create);
  static SmsRecipient? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get variables => $_getMap(2);
}

class SmsCampaign extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsCampaign', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageTemplate')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientsCount', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveredCount', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dndFilteredCount', $pb.PbFieldType.O3)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingCount', $pb.PbFieldType.O3)
    ..e<CampaignStatus>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CampaignStatus.CAMPAIGN_STATUS_UNSPECIFIED, valueOf: CampaignStatus.valueOf, enumValues: CampaignStatus.values)
    ..aInt64(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'costKobo')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOM<$1.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditsUsed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SmsCampaign._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (messageTemplate != null) {
      _result.messageTemplate = messageTemplate;
    }
    if (recipientsCount != null) {
      _result.recipientsCount = recipientsCount;
    }
    if (deliveredCount != null) {
      _result.deliveredCount = deliveredCount;
    }
    if (failedCount != null) {
      _result.failedCount = failedCount;
    }
    if (dndFilteredCount != null) {
      _result.dndFilteredCount = dndFilteredCount;
    }
    if (pendingCount != null) {
      _result.pendingCount = pendingCount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (costKobo != null) {
      _result.costKobo = costKobo;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (scheduledAt != null) {
      _result.scheduledAt = scheduledAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (creditsUsed != null) {
      _result.creditsUsed = creditsUsed;
    }
    return _result;
  }
  factory SmsCampaign.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsCampaign.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsCampaign clone() => SmsCampaign()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsCampaign copyWith(void Function(SmsCampaign) updates) => super.copyWith((message) => updates(message as SmsCampaign)) as SmsCampaign; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsCampaign create() => SmsCampaign._();
  SmsCampaign createEmptyInstance() => create();
  static $pb.PbList<SmsCampaign> createRepeated() => $pb.PbList<SmsCampaign>();
  @$core.pragma('dart2js:noInline')
  static SmsCampaign getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsCampaign>(create);
  static SmsCampaign? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get senderId => $_getSZ(4);
  @$pb.TagNumber(5)
  set senderId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSenderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get messageTemplate => $_getSZ(5);
  @$pb.TagNumber(6)
  set messageTemplate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessageTemplate() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageTemplate() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get recipientsCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set recipientsCount($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecipientsCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientsCount() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get deliveredCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set deliveredCount($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDeliveredCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeliveredCount() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get failedCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set failedCount($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFailedCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailedCount() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get dndFilteredCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set dndFilteredCount($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDndFilteredCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearDndFilteredCount() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get pendingCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set pendingCount($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPendingCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearPendingCount() => clearField(11);

  @$pb.TagNumber(12)
  CampaignStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(CampaignStatus v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get costKobo => $_getI64(12);
  @$pb.TagNumber(13)
  set costKobo($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCostKobo() => $_has(12);
  @$pb.TagNumber(13)
  void clearCostKobo() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get currency => $_getSZ(13);
  @$pb.TagNumber(14)
  set currency($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrency() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get reference => $_getSZ(14);
  @$pb.TagNumber(15)
  set reference($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReference() => $_has(14);
  @$pb.TagNumber(15)
  void clearReference() => clearField(15);

  @$pb.TagNumber(16)
  $1.Timestamp get createdAt => $_getN(15);
  @$pb.TagNumber(16)
  set createdAt($1.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCreatedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get scheduledAt => $_getN(16);
  @$pb.TagNumber(17)
  set scheduledAt($1.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasScheduledAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearScheduledAt() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureScheduledAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get completedAt => $_getN(17);
  @$pb.TagNumber(18)
  set completedAt($1.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCompletedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCompletedAt() => clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCompletedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $core.int get creditsUsed => $_getIZ(18);
  @$pb.TagNumber(19)
  set creditsUsed($core.int v) { $_setSignedInt32(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreditsUsed() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreditsUsed() => clearField(19);
}

class SmsDeliveryReport extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsDeliveryReport', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaignId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..e<DeliveryStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DeliveryStatus.DELIVERY_STATUS_UNSPECIFIED, valueOf: DeliveryStatus.valueOf, enumValues: DeliveryStatus.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerMessageId')
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sentAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveredAt', subBuilder: $1.Timestamp.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  SmsDeliveryReport._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (campaignId != null) {
      _result.campaignId = campaignId;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerMessageId != null) {
      _result.providerMessageId = providerMessageId;
    }
    if (sentAt != null) {
      _result.sentAt = sentAt;
    }
    if (deliveredAt != null) {
      _result.deliveredAt = deliveredAt;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    return _result;
  }
  factory SmsDeliveryReport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsDeliveryReport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsDeliveryReport clone() => SmsDeliveryReport()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsDeliveryReport copyWith(void Function(SmsDeliveryReport) updates) => super.copyWith((message) => updates(message as SmsDeliveryReport)) as SmsDeliveryReport; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsDeliveryReport create() => SmsDeliveryReport._();
  SmsDeliveryReport createEmptyInstance() => create();
  static $pb.PbList<SmsDeliveryReport> createRepeated() => $pb.PbList<SmsDeliveryReport>();
  @$core.pragma('dart2js:noInline')
  static SmsDeliveryReport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsDeliveryReport>(create);
  static SmsDeliveryReport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientName => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecipientName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientName() => clearField(4);

  @$pb.TagNumber(5)
  DeliveryStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(DeliveryStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerMessageId => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerMessageId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderMessageId() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderMessageId() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get sentAt => $_getN(6);
  @$pb.TagNumber(7)
  set sentAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSentAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearSentAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureSentAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get deliveredAt => $_getN(7);
  @$pb.TagNumber(8)
  set deliveredAt($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDeliveredAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeliveredAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureDeliveredAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => clearField(9);
}

class SmsBalance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsBalance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditsRemaining', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOM<$1.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastPurchaseAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  SmsBalance._() : super();
  factory SmsBalance({
    $core.int? creditsRemaining,
    $core.String? providerName,
    $1.Timestamp? lastPurchaseAt,
  }) {
    final _result = create();
    if (creditsRemaining != null) {
      _result.creditsRemaining = creditsRemaining;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (lastPurchaseAt != null) {
      _result.lastPurchaseAt = lastPurchaseAt;
    }
    return _result;
  }
  factory SmsBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsBalance clone() => SmsBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsBalance copyWith(void Function(SmsBalance) updates) => super.copyWith((message) => updates(message as SmsBalance)) as SmsBalance; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsBalance create() => SmsBalance._();
  SmsBalance createEmptyInstance() => create();
  static $pb.PbList<SmsBalance> createRepeated() => $pb.PbList<SmsBalance>();
  @$core.pragma('dart2js:noInline')
  static SmsBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsBalance>(create);
  static SmsBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get creditsRemaining => $_getIZ(0);
  @$pb.TagNumber(1)
  set creditsRemaining($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreditsRemaining() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreditsRemaining() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderName() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get lastPurchaseAt => $_getN(2);
  @$pb.TagNumber(3)
  set lastPurchaseAt($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastPurchaseAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastPurchaseAt() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureLastPurchaseAt() => $_ensure(2);
}

class SmsPurchase extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmsPurchase', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packageId')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditsPurchased', $pb.PbFieldType.O3)
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountKobo')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  SmsPurchase._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (packageId != null) {
      _result.packageId = packageId;
    }
    if (creditsPurchased != null) {
      _result.creditsPurchased = creditsPurchased;
    }
    if (amountKobo != null) {
      _result.amountKobo = amountKobo;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory SmsPurchase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsPurchase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsPurchase clone() => SmsPurchase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsPurchase copyWith(void Function(SmsPurchase) updates) => super.copyWith((message) => updates(message as SmsPurchase)) as SmsPurchase; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmsPurchase create() => SmsPurchase._();
  SmsPurchase createEmptyInstance() => create();
  static $pb.PbList<SmsPurchase> createRepeated() => $pb.PbList<SmsPurchase>();
  @$core.pragma('dart2js:noInline')
  static SmsPurchase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsPurchase>(create);
  static SmsPurchase? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get packageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set packageId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPackageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPackageId() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get creditsPurchased => $_getIZ(5);
  @$pb.TagNumber(6)
  set creditsPurchased($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreditsPurchased() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreditsPurchased() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amountKobo => $_getI64(6);
  @$pb.TagNumber(7)
  set amountKobo($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountKobo() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountKobo() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);
}

class SenderId extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SenderId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..e<SenderIdStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SenderIdStatus.SENDER_ID_STATUS_UNSPECIFIED, valueOf: SenderIdStatus.valueOf, enumValues: SenderIdStatus.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedAt', subBuilder: $1.Timestamp.create)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  SenderId._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (country != null) {
      _result.country = country;
    }
    if (requestedAt != null) {
      _result.requestedAt = requestedAt;
    }
    if (approvedAt != null) {
      _result.approvedAt = approvedAt;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    return _result;
  }
  factory SenderId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SenderId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SenderId clone() => SenderId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SenderId copyWith(void Function(SenderId) updates) => super.copyWith((message) => updates(message as SenderId)) as SenderId; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SenderId create() => SenderId._();
  SenderId createEmptyInstance() => create();
  static $pb.PbList<SenderId> createRepeated() => $pb.PbList<SenderId>();
  @$core.pragma('dart2js:noInline')
  static SenderId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SenderId>(create);
  static SenderId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => clearField(3);

  @$pb.TagNumber(4)
  SenderIdStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(SenderIdStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get country => $_getSZ(4);
  @$pb.TagNumber(5)
  set country($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCountry() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountry() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get requestedAt => $_getN(5);
  @$pb.TagNumber(6)
  set requestedAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRequestedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequestedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureRequestedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get approvedAt => $_getN(6);
  @$pb.TagNumber(7)
  set approvedAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasApprovedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearApprovedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureApprovedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get rejectionReason => $_getSZ(7);
  @$pb.TagNumber(8)
  set rejectionReason($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRejectionReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearRejectionReason() => clearField(8);
}

class PaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  PaginationInfo._() : super();
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory PaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) => super.copyWith((message) => updates(message as PaginationInfo)) as PaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaginationInfo create() => PaginationInfo._();
  PaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaginationInfo> createRepeated() => $pb.PbList<PaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginationInfo>(create);
  static PaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => clearField(6);
}

class GetSmsProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..hasRequiredFields = false
  ;

  GetSmsProvidersRequest._() : super();
  factory GetSmsProvidersRequest({
    $core.String? country,
  }) {
    final _result = create();
    if (country != null) {
      _result.country = country;
    }
    return _result;
  }
  factory GetSmsProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsProvidersRequest clone() => GetSmsProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsProvidersRequest copyWith(void Function(GetSmsProvidersRequest) updates) => super.copyWith((message) => updates(message as GetSmsProvidersRequest)) as GetSmsProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersRequest create() => GetSmsProvidersRequest._();
  GetSmsProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsProvidersRequest> createRepeated() => $pb.PbList<GetSmsProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsProvidersRequest>(create);
  static GetSmsProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => clearField(1);
}

class GetSmsProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..pc<SmsProvider>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: SmsProvider.create)
    ..hasRequiredFields = false
  ;

  GetSmsProvidersResponse._() : super();
  factory GetSmsProvidersResponse({
    $core.Iterable<SmsProvider>? providers,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    return _result;
  }
  factory GetSmsProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsProvidersResponse clone() => GetSmsProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsProvidersResponse copyWith(void Function(GetSmsProvidersResponse) updates) => super.copyWith((message) => updates(message as GetSmsProvidersResponse)) as GetSmsProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersResponse create() => GetSmsProvidersResponse._();
  GetSmsProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsProvidersResponse> createRepeated() => $pb.PbList<GetSmsProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsProvidersResponse>(create);
  static GetSmsProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SmsProvider> get providers => $_getList(0);
}

class GetSmsPackagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsPackagesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  GetSmsPackagesRequest._() : super();
  factory GetSmsPackagesRequest({
    $core.String? country,
    $core.String? currency,
  }) {
    final _result = create();
    if (country != null) {
      _result.country = country;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory GetSmsPackagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsPackagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsPackagesRequest clone() => GetSmsPackagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsPackagesRequest copyWith(void Function(GetSmsPackagesRequest) updates) => super.copyWith((message) => updates(message as GetSmsPackagesRequest)) as GetSmsPackagesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesRequest create() => GetSmsPackagesRequest._();
  GetSmsPackagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsPackagesRequest> createRepeated() => $pb.PbList<GetSmsPackagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsPackagesRequest>(create);
  static GetSmsPackagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);
}

class GetSmsPackagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsPackagesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..pc<SmsPackage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packages', $pb.PbFieldType.PM, subBuilder: SmsPackage.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..hasRequiredFields = false
  ;

  GetSmsPackagesResponse._() : super();
  factory GetSmsPackagesResponse({
    $core.Iterable<SmsPackage>? packages,
    $core.String? providerName,
  }) {
    final _result = create();
    if (packages != null) {
      _result.packages.addAll(packages);
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    return _result;
  }
  factory GetSmsPackagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsPackagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsPackagesResponse clone() => GetSmsPackagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsPackagesResponse copyWith(void Function(GetSmsPackagesResponse) updates) => super.copyWith((message) => updates(message as GetSmsPackagesResponse)) as GetSmsPackagesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesResponse create() => GetSmsPackagesResponse._();
  GetSmsPackagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsPackagesResponse> createRepeated() => $pb.PbList<GetSmsPackagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsPackagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsPackagesResponse>(create);
  static GetSmsPackagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SmsPackage> get packages => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get providerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderName() => clearField(2);
}

class GetSmsBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSmsBalanceRequest._() : super();
  factory GetSmsBalanceRequest() => create();
  factory GetSmsBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsBalanceRequest clone() => GetSmsBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsBalanceRequest copyWith(void Function(GetSmsBalanceRequest) updates) => super.copyWith((message) => updates(message as GetSmsBalanceRequest)) as GetSmsBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceRequest create() => GetSmsBalanceRequest._();
  GetSmsBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsBalanceRequest> createRepeated() => $pb.PbList<GetSmsBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsBalanceRequest>(create);
  static GetSmsBalanceRequest? _defaultInstance;
}

class GetSmsBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..pc<SmsBalance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balances', $pb.PbFieldType.PM, subBuilder: SmsBalance.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCredits', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSmsBalanceResponse._() : super();
  factory GetSmsBalanceResponse({
    $core.Iterable<SmsBalance>? balances,
    $core.int? totalCredits,
  }) {
    final _result = create();
    if (balances != null) {
      _result.balances.addAll(balances);
    }
    if (totalCredits != null) {
      _result.totalCredits = totalCredits;
    }
    return _result;
  }
  factory GetSmsBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsBalanceResponse clone() => GetSmsBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsBalanceResponse copyWith(void Function(GetSmsBalanceResponse) updates) => super.copyWith((message) => updates(message as GetSmsBalanceResponse)) as GetSmsBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceResponse create() => GetSmsBalanceResponse._();
  GetSmsBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsBalanceResponse> createRepeated() => $pb.PbList<GetSmsBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsBalanceResponse>(create);
  static GetSmsBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SmsBalance> get balances => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCredits => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCredits($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCredits() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCredits() => clearField(2);
}

class PurchaseSmsCreditRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseSmsCreditRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packageId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  PurchaseSmsCreditRequest._() : super();
  factory PurchaseSmsCreditRequest({
    $core.String? packageId,
    $core.String? providerName,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? currency,
  }) {
    final _result = create();
    if (packageId != null) {
      _result.packageId = packageId;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory PurchaseSmsCreditRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseSmsCreditRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseSmsCreditRequest clone() => PurchaseSmsCreditRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseSmsCreditRequest copyWith(void Function(PurchaseSmsCreditRequest) updates) => super.copyWith((message) => updates(message as PurchaseSmsCreditRequest)) as PurchaseSmsCreditRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditRequest create() => PurchaseSmsCreditRequest._();
  PurchaseSmsCreditRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseSmsCreditRequest> createRepeated() => $pb.PbList<PurchaseSmsCreditRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseSmsCreditRequest>(create);
  static PurchaseSmsCreditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get idempotencyKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set idempotencyKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIdempotencyKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdempotencyKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);
}

class PurchaseSmsCreditResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseSmsCreditResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOM<SmsPurchase>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchase', subBuilder: SmsPurchase.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newWalletBalance', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PurchaseSmsCreditResponse._() : super();
  factory PurchaseSmsCreditResponse({
    SmsPurchase? purchase,
    $core.int? newCreditBalance,
    $core.double? newWalletBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (purchase != null) {
      _result.purchase = purchase;
    }
    if (newCreditBalance != null) {
      _result.newCreditBalance = newCreditBalance;
    }
    if (newWalletBalance != null) {
      _result.newWalletBalance = newWalletBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PurchaseSmsCreditResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseSmsCreditResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseSmsCreditResponse clone() => PurchaseSmsCreditResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseSmsCreditResponse copyWith(void Function(PurchaseSmsCreditResponse) updates) => super.copyWith((message) => updates(message as PurchaseSmsCreditResponse)) as PurchaseSmsCreditResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditResponse create() => PurchaseSmsCreditResponse._();
  PurchaseSmsCreditResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseSmsCreditResponse> createRepeated() => $pb.PbList<PurchaseSmsCreditResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseSmsCreditResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseSmsCreditResponse>(create);
  static PurchaseSmsCreditResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsPurchase get purchase => $_getN(0);
  @$pb.TagNumber(1)
  set purchase(SmsPurchase v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchase() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchase() => clearField(1);
  @$pb.TagNumber(1)
  SmsPurchase ensurePurchase() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get newCreditBalance => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCreditBalance($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewCreditBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCreditBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get newWalletBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newWalletBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewWalletBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewWalletBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class SendBulkSmsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendBulkSmsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageTemplate')
    ..pc<SmsRecipient>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: SmsRecipient.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  SendBulkSmsRequest._() : super();
  factory SendBulkSmsRequest({
    $core.String? providerName,
    $core.String? senderId,
    $core.String? messageTemplate,
    $core.Iterable<SmsRecipient>? recipients,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final _result = create();
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (messageTemplate != null) {
      _result.messageTemplate = messageTemplate;
    }
    if (recipients != null) {
      _result.recipients.addAll(recipients);
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    return _result;
  }
  factory SendBulkSmsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendBulkSmsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendBulkSmsRequest clone() => SendBulkSmsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendBulkSmsRequest copyWith(void Function(SendBulkSmsRequest) updates) => super.copyWith((message) => updates(message as SendBulkSmsRequest)) as SendBulkSmsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendBulkSmsRequest create() => SendBulkSmsRequest._();
  SendBulkSmsRequest createEmptyInstance() => create();
  static $pb.PbList<SendBulkSmsRequest> createRepeated() => $pb.PbList<SendBulkSmsRequest>();
  @$core.pragma('dart2js:noInline')
  static SendBulkSmsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendBulkSmsRequest>(create);
  static SendBulkSmsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerName => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageTemplate => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageTemplate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessageTemplate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageTemplate() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<SmsRecipient> get recipients => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);
}

class SendBulkSmsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendBulkSmsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOM<SmsCampaign>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaign', subBuilder: SmsCampaign.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SendBulkSmsResponse._() : super();
  factory SendBulkSmsResponse({
    SmsCampaign? campaign,
    $core.int? newCreditBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (campaign != null) {
      _result.campaign = campaign;
    }
    if (newCreditBalance != null) {
      _result.newCreditBalance = newCreditBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SendBulkSmsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendBulkSmsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendBulkSmsResponse clone() => SendBulkSmsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendBulkSmsResponse copyWith(void Function(SendBulkSmsResponse) updates) => super.copyWith((message) => updates(message as SendBulkSmsResponse)) as SendBulkSmsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendBulkSmsResponse create() => SendBulkSmsResponse._();
  SendBulkSmsResponse createEmptyInstance() => create();
  static $pb.PbList<SendBulkSmsResponse> createRepeated() => $pb.PbList<SendBulkSmsResponse>();
  @$core.pragma('dart2js:noInline')
  static SendBulkSmsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendBulkSmsResponse>(create);
  static SendBulkSmsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsCampaign get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(SmsCampaign v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => clearField(1);
  @$pb.TagNumber(1)
  SmsCampaign ensureCampaign() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get newCreditBalance => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCreditBalance($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewCreditBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCreditBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class ScheduleSmsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScheduleSmsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageTemplate')
    ..pc<SmsRecipient>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: SmsRecipient.create)
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledAt', subBuilder: $1.Timestamp.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  ScheduleSmsRequest._() : super();
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
    final _result = create();
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (messageTemplate != null) {
      _result.messageTemplate = messageTemplate;
    }
    if (recipients != null) {
      _result.recipients.addAll(recipients);
    }
    if (scheduledAt != null) {
      _result.scheduledAt = scheduledAt;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    return _result;
  }
  factory ScheduleSmsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScheduleSmsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScheduleSmsRequest clone() => ScheduleSmsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScheduleSmsRequest copyWith(void Function(ScheduleSmsRequest) updates) => super.copyWith((message) => updates(message as ScheduleSmsRequest)) as ScheduleSmsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScheduleSmsRequest create() => ScheduleSmsRequest._();
  ScheduleSmsRequest createEmptyInstance() => create();
  static $pb.PbList<ScheduleSmsRequest> createRepeated() => $pb.PbList<ScheduleSmsRequest>();
  @$core.pragma('dart2js:noInline')
  static ScheduleSmsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScheduleSmsRequest>(create);
  static ScheduleSmsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerName => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageTemplate => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageTemplate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessageTemplate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageTemplate() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<SmsRecipient> get recipients => $_getList(3);

  @$pb.TagNumber(5)
  $1.Timestamp get scheduledAt => $_getN(4);
  @$pb.TagNumber(5)
  set scheduledAt($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasScheduledAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledAt() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureScheduledAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get verificationToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set verificationToken($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVerificationToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerificationToken() => clearField(8);
}

class ScheduleSmsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScheduleSmsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOM<SmsCampaign>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaign', subBuilder: SmsCampaign.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ScheduleSmsResponse._() : super();
  factory ScheduleSmsResponse({
    SmsCampaign? campaign,
    $core.int? newCreditBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (campaign != null) {
      _result.campaign = campaign;
    }
    if (newCreditBalance != null) {
      _result.newCreditBalance = newCreditBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ScheduleSmsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScheduleSmsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScheduleSmsResponse clone() => ScheduleSmsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScheduleSmsResponse copyWith(void Function(ScheduleSmsResponse) updates) => super.copyWith((message) => updates(message as ScheduleSmsResponse)) as ScheduleSmsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScheduleSmsResponse create() => ScheduleSmsResponse._();
  ScheduleSmsResponse createEmptyInstance() => create();
  static $pb.PbList<ScheduleSmsResponse> createRepeated() => $pb.PbList<ScheduleSmsResponse>();
  @$core.pragma('dart2js:noInline')
  static ScheduleSmsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScheduleSmsResponse>(create);
  static ScheduleSmsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsCampaign get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(SmsCampaign v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => clearField(1);
  @$pb.TagNumber(1)
  SmsCampaign ensureCampaign() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get newCreditBalance => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCreditBalance($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewCreditBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCreditBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CancelScheduledSmsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelScheduledSmsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaignId')
    ..hasRequiredFields = false
  ;

  CancelScheduledSmsRequest._() : super();
  factory CancelScheduledSmsRequest({
    $core.String? campaignId,
  }) {
    final _result = create();
    if (campaignId != null) {
      _result.campaignId = campaignId;
    }
    return _result;
  }
  factory CancelScheduledSmsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelScheduledSmsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelScheduledSmsRequest clone() => CancelScheduledSmsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelScheduledSmsRequest copyWith(void Function(CancelScheduledSmsRequest) updates) => super.copyWith((message) => updates(message as CancelScheduledSmsRequest)) as CancelScheduledSmsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsRequest create() => CancelScheduledSmsRequest._();
  CancelScheduledSmsRequest createEmptyInstance() => create();
  static $pb.PbList<CancelScheduledSmsRequest> createRepeated() => $pb.PbList<CancelScheduledSmsRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelScheduledSmsRequest>(create);
  static CancelScheduledSmsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => clearField(1);
}

class CancelScheduledSmsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelScheduledSmsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditsRefunded', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newCreditBalance', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CancelScheduledSmsResponse._() : super();
  factory CancelScheduledSmsResponse({
    $core.bool? success,
    $core.int? creditsRefunded,
    $core.int? newCreditBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (creditsRefunded != null) {
      _result.creditsRefunded = creditsRefunded;
    }
    if (newCreditBalance != null) {
      _result.newCreditBalance = newCreditBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CancelScheduledSmsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelScheduledSmsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelScheduledSmsResponse clone() => CancelScheduledSmsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelScheduledSmsResponse copyWith(void Function(CancelScheduledSmsResponse) updates) => super.copyWith((message) => updates(message as CancelScheduledSmsResponse)) as CancelScheduledSmsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsResponse create() => CancelScheduledSmsResponse._();
  CancelScheduledSmsResponse createEmptyInstance() => create();
  static $pb.PbList<CancelScheduledSmsResponse> createRepeated() => $pb.PbList<CancelScheduledSmsResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelScheduledSmsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelScheduledSmsResponse>(create);
  static CancelScheduledSmsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get creditsRefunded => $_getIZ(1);
  @$pb.TagNumber(2)
  set creditsRefunded($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreditsRefunded() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreditsRefunded() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get newCreditBalance => $_getIZ(2);
  @$pb.TagNumber(3)
  set newCreditBalance($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewCreditBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewCreditBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class GetSmsCampaignStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsCampaignStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaignId')
    ..hasRequiredFields = false
  ;

  GetSmsCampaignStatusRequest._() : super();
  factory GetSmsCampaignStatusRequest({
    $core.String? campaignId,
  }) {
    final _result = create();
    if (campaignId != null) {
      _result.campaignId = campaignId;
    }
    return _result;
  }
  factory GetSmsCampaignStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsCampaignStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsCampaignStatusRequest clone() => GetSmsCampaignStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsCampaignStatusRequest copyWith(void Function(GetSmsCampaignStatusRequest) updates) => super.copyWith((message) => updates(message as GetSmsCampaignStatusRequest)) as GetSmsCampaignStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusRequest create() => GetSmsCampaignStatusRequest._();
  GetSmsCampaignStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsCampaignStatusRequest> createRepeated() => $pb.PbList<GetSmsCampaignStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsCampaignStatusRequest>(create);
  static GetSmsCampaignStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => clearField(1);
}

class GetSmsCampaignStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsCampaignStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOM<SmsCampaign>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaign', subBuilder: SmsCampaign.create)
    ..hasRequiredFields = false
  ;

  GetSmsCampaignStatusResponse._() : super();
  factory GetSmsCampaignStatusResponse({
    SmsCampaign? campaign,
  }) {
    final _result = create();
    if (campaign != null) {
      _result.campaign = campaign;
    }
    return _result;
  }
  factory GetSmsCampaignStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsCampaignStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsCampaignStatusResponse clone() => GetSmsCampaignStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsCampaignStatusResponse copyWith(void Function(GetSmsCampaignStatusResponse) updates) => super.copyWith((message) => updates(message as GetSmsCampaignStatusResponse)) as GetSmsCampaignStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusResponse create() => GetSmsCampaignStatusResponse._();
  GetSmsCampaignStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsCampaignStatusResponse> createRepeated() => $pb.PbList<GetSmsCampaignStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsCampaignStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsCampaignStatusResponse>(create);
  static GetSmsCampaignStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmsCampaign get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(SmsCampaign v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => clearField(1);
  @$pb.TagNumber(1)
  SmsCampaign ensureCampaign() => $_ensure(0);
}

class GetDeliveryReportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDeliveryReportRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaignId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter')
    ..hasRequiredFields = false
  ;

  GetDeliveryReportRequest._() : super();
  factory GetDeliveryReportRequest({
    $core.String? campaignId,
    $core.int? page,
    $core.int? pageSize,
    $core.String? statusFilter,
  }) {
    final _result = create();
    if (campaignId != null) {
      _result.campaignId = campaignId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    return _result;
  }
  factory GetDeliveryReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDeliveryReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDeliveryReportRequest clone() => GetDeliveryReportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDeliveryReportRequest copyWith(void Function(GetDeliveryReportRequest) updates) => super.copyWith((message) => updates(message as GetDeliveryReportRequest)) as GetDeliveryReportRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportRequest create() => GetDeliveryReportRequest._();
  GetDeliveryReportRequest createEmptyInstance() => create();
  static $pb.PbList<GetDeliveryReportRequest> createRepeated() => $pb.PbList<GetDeliveryReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDeliveryReportRequest>(create);
  static GetDeliveryReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => clearField(1);

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
  $core.String get statusFilter => $_getSZ(3);
  @$pb.TagNumber(4)
  set statusFilter($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatusFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatusFilter() => clearField(4);
}

class GetDeliveryReportResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDeliveryReportResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..pc<SmsDeliveryReport>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reports', $pb.PbFieldType.PM, subBuilder: SmsDeliveryReport.create)
    ..aOM<PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetDeliveryReportResponse._() : super();
  factory GetDeliveryReportResponse({
    $core.Iterable<SmsDeliveryReport>? reports,
    PaginationInfo? pagination,
  }) {
    final _result = create();
    if (reports != null) {
      _result.reports.addAll(reports);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetDeliveryReportResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDeliveryReportResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDeliveryReportResponse clone() => GetDeliveryReportResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDeliveryReportResponse copyWith(void Function(GetDeliveryReportResponse) updates) => super.copyWith((message) => updates(message as GetDeliveryReportResponse)) as GetDeliveryReportResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportResponse create() => GetDeliveryReportResponse._();
  GetDeliveryReportResponse createEmptyInstance() => create();
  static $pb.PbList<GetDeliveryReportResponse> createRepeated() => $pb.PbList<GetDeliveryReportResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDeliveryReportResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDeliveryReportResponse>(create);
  static GetDeliveryReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SmsDeliveryReport> get reports => $_getList(0);

  @$pb.TagNumber(2)
  PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PaginationInfo ensurePagination() => $_ensure(1);
}

class GetSmsHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  GetSmsHistoryRequest._() : super();
  factory GetSmsHistoryRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? statusFilter,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetSmsHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsHistoryRequest clone() => GetSmsHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsHistoryRequest copyWith(void Function(GetSmsHistoryRequest) updates) => super.copyWith((message) => updates(message as GetSmsHistoryRequest)) as GetSmsHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryRequest create() => GetSmsHistoryRequest._();
  GetSmsHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetSmsHistoryRequest> createRepeated() => $pb.PbList<GetSmsHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsHistoryRequest>(create);
  static GetSmsHistoryRequest? _defaultInstance;

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
  $core.String get statusFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set statusFilter($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get startDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get endDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set endDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => clearField(5);
}

class GetSmsHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSmsHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..pc<SmsCampaign>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'campaigns', $pb.PbFieldType.PM, subBuilder: SmsCampaign.create)
    ..aOM<PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetSmsHistoryResponse._() : super();
  factory GetSmsHistoryResponse({
    $core.Iterable<SmsCampaign>? campaigns,
    PaginationInfo? pagination,
  }) {
    final _result = create();
    if (campaigns != null) {
      _result.campaigns.addAll(campaigns);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetSmsHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSmsHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSmsHistoryResponse clone() => GetSmsHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSmsHistoryResponse copyWith(void Function(GetSmsHistoryResponse) updates) => super.copyWith((message) => updates(message as GetSmsHistoryResponse)) as GetSmsHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryResponse create() => GetSmsHistoryResponse._();
  GetSmsHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetSmsHistoryResponse> createRepeated() => $pb.PbList<GetSmsHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSmsHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSmsHistoryResponse>(create);
  static GetSmsHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SmsCampaign> get campaigns => $_getList(0);

  @$pb.TagNumber(2)
  PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PaginationInfo ensurePagination() => $_ensure(1);
}

class GetSenderIdsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSenderIdsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSenderIdsRequest._() : super();
  factory GetSenderIdsRequest() => create();
  factory GetSenderIdsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSenderIdsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSenderIdsRequest clone() => GetSenderIdsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSenderIdsRequest copyWith(void Function(GetSenderIdsRequest) updates) => super.copyWith((message) => updates(message as GetSenderIdsRequest)) as GetSenderIdsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSenderIdsRequest create() => GetSenderIdsRequest._();
  GetSenderIdsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSenderIdsRequest> createRepeated() => $pb.PbList<GetSenderIdsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSenderIdsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSenderIdsRequest>(create);
  static GetSenderIdsRequest? _defaultInstance;
}

class GetSenderIdsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSenderIdsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..pc<SenderId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderIds', $pb.PbFieldType.PM, subBuilder: SenderId.create)
    ..hasRequiredFields = false
  ;

  GetSenderIdsResponse._() : super();
  factory GetSenderIdsResponse({
    $core.Iterable<SenderId>? senderIds,
  }) {
    final _result = create();
    if (senderIds != null) {
      _result.senderIds.addAll(senderIds);
    }
    return _result;
  }
  factory GetSenderIdsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSenderIdsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSenderIdsResponse clone() => GetSenderIdsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSenderIdsResponse copyWith(void Function(GetSenderIdsResponse) updates) => super.copyWith((message) => updates(message as GetSenderIdsResponse)) as GetSenderIdsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSenderIdsResponse create() => GetSenderIdsResponse._();
  GetSenderIdsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSenderIdsResponse> createRepeated() => $pb.PbList<GetSenderIdsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSenderIdsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSenderIdsResponse>(create);
  static GetSenderIdsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SenderId> get senderIds => $_getList(0);
}

class RequestSenderIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestSenderIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..hasRequiredFields = false
  ;

  RequestSenderIdRequest._() : super();
  factory RequestSenderIdRequest({
    $core.String? senderId,
    $core.String? country,
    $core.String? purpose,
  }) {
    final _result = create();
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (country != null) {
      _result.country = country;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    return _result;
  }
  factory RequestSenderIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestSenderIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestSenderIdRequest clone() => RequestSenderIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestSenderIdRequest copyWith(void Function(RequestSenderIdRequest) updates) => super.copyWith((message) => updates(message as RequestSenderIdRequest)) as RequestSenderIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestSenderIdRequest create() => RequestSenderIdRequest._();
  RequestSenderIdRequest createEmptyInstance() => create();
  static $pb.PbList<RequestSenderIdRequest> createRepeated() => $pb.PbList<RequestSenderIdRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestSenderIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestSenderIdRequest>(create);
  static RequestSenderIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get purpose => $_getSZ(2);
  @$pb.TagNumber(3)
  set purpose($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPurpose() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurpose() => clearField(3);
}

class RequestSenderIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestSenderIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'bulksms'), createEmptyInstance: create)
    ..aOM<SenderId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId', subBuilder: SenderId.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RequestSenderIdResponse._() : super();
  factory RequestSenderIdResponse({
    SenderId? senderId,
    $core.String? message,
  }) {
    final _result = create();
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RequestSenderIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestSenderIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestSenderIdResponse clone() => RequestSenderIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestSenderIdResponse copyWith(void Function(RequestSenderIdResponse) updates) => super.copyWith((message) => updates(message as RequestSenderIdResponse)) as RequestSenderIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestSenderIdResponse create() => RequestSenderIdResponse._();
  RequestSenderIdResponse createEmptyInstance() => create();
  static $pb.PbList<RequestSenderIdResponse> createRepeated() => $pb.PbList<RequestSenderIdResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestSenderIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestSenderIdResponse>(create);
  static RequestSenderIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SenderId get senderId => $_getN(0);
  @$pb.TagNumber(1)
  set senderId(SenderId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderId() => clearField(1);
  @$pb.TagNumber(1)
  SenderId ensureSenderId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

