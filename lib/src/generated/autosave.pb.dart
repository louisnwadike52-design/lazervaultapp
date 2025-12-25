///
//  Generated code. Do not modify.
//  source: autosave.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $28;

import 'autosave.pbenum.dart';

export 'autosave.pbenum.dart';

class AutoSaveRule extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoSaveRule', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<TriggerType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerType', $pb.PbFieldType.OE, defaultOrMaker: TriggerType.TRIGGER_UNKNOWN, valueOf: TriggerType.valueOf, enumValues: TriggerType.values)
    ..e<AmountType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountType', $pb.PbFieldType.OE, defaultOrMaker: AmountType.AMOUNT_UNKNOWN, valueOf: AmountType.valueOf, enumValues: AmountType.values)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..e<AutoSaveStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: AutoSaveStatus.STATUS_UNKNOWN, valueOf: AutoSaveStatus.valueOf, enumValues: AutoSaveStatus.values)
    ..e<ScheduleFrequency>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ScheduleFrequency.FREQUENCY_UNKNOWN, valueOf: ScheduleFrequency.valueOf, enumValues: ScheduleFrequency.values)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleTime')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..aOM<$28.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastTriggeredAt', subBuilder: $28.Timestamp.create)
    ..a<$core.int>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerCount', $pb.PbFieldType.O3)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AutoSaveRule._() : super();
  factory AutoSaveRule({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.String? description,
    TriggerType? triggerType,
    AmountType? amountType,
    $core.double? amountValue,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
    AutoSaveStatus? status,
    ScheduleFrequency? frequency,
    $core.String? scheduleTime,
    $core.int? scheduleDay,
    $core.int? roundUpTo,
    $core.double? targetAmount,
    $core.double? minimumBalance,
    $core.double? maximumPerSave,
    $28.Timestamp? createdAt,
    $28.Timestamp? updatedAt,
    $28.Timestamp? lastTriggeredAt,
    $core.int? triggerCount,
    $core.double? totalSaved,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (triggerType != null) {
      _result.triggerType = triggerType;
    }
    if (amountType != null) {
      _result.amountType = amountType;
    }
    if (amountValue != null) {
      _result.amountValue = amountValue;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (scheduleTime != null) {
      _result.scheduleTime = scheduleTime;
    }
    if (scheduleDay != null) {
      _result.scheduleDay = scheduleDay;
    }
    if (roundUpTo != null) {
      _result.roundUpTo = roundUpTo;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (maximumPerSave != null) {
      _result.maximumPerSave = maximumPerSave;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (lastTriggeredAt != null) {
      _result.lastTriggeredAt = lastTriggeredAt;
    }
    if (triggerCount != null) {
      _result.triggerCount = triggerCount;
    }
    if (totalSaved != null) {
      _result.totalSaved = totalSaved;
    }
    return _result;
  }
  factory AutoSaveRule.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSaveRule.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSaveRule clone() => AutoSaveRule()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSaveRule copyWith(void Function(AutoSaveRule) updates) => super.copyWith((message) => updates(message as AutoSaveRule)) as AutoSaveRule; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoSaveRule create() => AutoSaveRule._();
  AutoSaveRule createEmptyInstance() => create();
  static $pb.PbList<AutoSaveRule> createRepeated() => $pb.PbList<AutoSaveRule>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveRule getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveRule>(create);
  static AutoSaveRule? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  TriggerType get triggerType => $_getN(4);
  @$pb.TagNumber(5)
  set triggerType(TriggerType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTriggerType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTriggerType() => clearField(5);

  @$pb.TagNumber(6)
  AmountType get amountType => $_getN(5);
  @$pb.TagNumber(6)
  set amountType(AmountType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmountType() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountType() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get amountValue => $_getN(6);
  @$pb.TagNumber(7)
  set amountValue($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountValue() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccountId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccountId() => clearField(9);

  @$pb.TagNumber(10)
  AutoSaveStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(AutoSaveStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  ScheduleFrequency get frequency => $_getN(10);
  @$pb.TagNumber(11)
  set frequency(ScheduleFrequency v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasFrequency() => $_has(10);
  @$pb.TagNumber(11)
  void clearFrequency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get scheduleTime => $_getSZ(11);
  @$pb.TagNumber(12)
  set scheduleTime($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasScheduleTime() => $_has(11);
  @$pb.TagNumber(12)
  void clearScheduleTime() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get scheduleDay => $_getIZ(12);
  @$pb.TagNumber(13)
  set scheduleDay($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasScheduleDay() => $_has(12);
  @$pb.TagNumber(13)
  void clearScheduleDay() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get roundUpTo => $_getIZ(13);
  @$pb.TagNumber(14)
  set roundUpTo($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRoundUpTo() => $_has(13);
  @$pb.TagNumber(14)
  void clearRoundUpTo() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get targetAmount => $_getN(14);
  @$pb.TagNumber(15)
  set targetAmount($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTargetAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearTargetAmount() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get minimumBalance => $_getN(15);
  @$pb.TagNumber(16)
  set minimumBalance($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasMinimumBalance() => $_has(15);
  @$pb.TagNumber(16)
  void clearMinimumBalance() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get maximumPerSave => $_getN(16);
  @$pb.TagNumber(17)
  set maximumPerSave($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasMaximumPerSave() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaximumPerSave() => clearField(17);

  @$pb.TagNumber(18)
  $28.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($28.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $28.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $28.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($28.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $28.Timestamp ensureUpdatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $28.Timestamp get lastTriggeredAt => $_getN(19);
  @$pb.TagNumber(20)
  set lastTriggeredAt($28.Timestamp v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasLastTriggeredAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearLastTriggeredAt() => clearField(20);
  @$pb.TagNumber(20)
  $28.Timestamp ensureLastTriggeredAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.int get triggerCount => $_getIZ(20);
  @$pb.TagNumber(21)
  set triggerCount($core.int v) { $_setSignedInt32(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasTriggerCount() => $_has(20);
  @$pb.TagNumber(21)
  void clearTriggerCount() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get totalSaved => $_getN(21);
  @$pb.TagNumber(22)
  set totalSaved($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasTotalSaved() => $_has(21);
  @$pb.TagNumber(22)
  void clearTotalSaved() => clearField(22);
}

class CreateAutoSaveRuleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAutoSaveRuleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<TriggerType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerType', $pb.PbFieldType.OE, defaultOrMaker: TriggerType.TRIGGER_UNKNOWN, valueOf: TriggerType.valueOf, enumValues: TriggerType.values)
    ..e<AmountType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountType', $pb.PbFieldType.OE, defaultOrMaker: AmountType.AMOUNT_UNKNOWN, valueOf: AmountType.valueOf, enumValues: AmountType.values)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..e<ScheduleFrequency>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ScheduleFrequency.FREQUENCY_UNKNOWN, valueOf: ScheduleFrequency.valueOf, enumValues: ScheduleFrequency.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleTime')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CreateAutoSaveRuleRequest._() : super();
  factory CreateAutoSaveRuleRequest({
    $core.String? name,
    $core.String? description,
    TriggerType? triggerType,
    AmountType? amountType,
    $core.double? amountValue,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
    ScheduleFrequency? frequency,
    $core.String? scheduleTime,
    $core.int? scheduleDay,
    $core.int? roundUpTo,
    $core.double? targetAmount,
    $core.double? minimumBalance,
    $core.double? maximumPerSave,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (triggerType != null) {
      _result.triggerType = triggerType;
    }
    if (amountType != null) {
      _result.amountType = amountType;
    }
    if (amountValue != null) {
      _result.amountValue = amountValue;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (scheduleTime != null) {
      _result.scheduleTime = scheduleTime;
    }
    if (scheduleDay != null) {
      _result.scheduleDay = scheduleDay;
    }
    if (roundUpTo != null) {
      _result.roundUpTo = roundUpTo;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (maximumPerSave != null) {
      _result.maximumPerSave = maximumPerSave;
    }
    return _result;
  }
  factory CreateAutoSaveRuleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoSaveRuleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleRequest clone() => CreateAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleRequest copyWith(void Function(CreateAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRuleRequest)) as CreateAutoSaveRuleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest create() => CreateAutoSaveRuleRequest._();
  CreateAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleRequest> createRepeated() => $pb.PbList<CreateAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleRequest>(create);
  static CreateAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  TriggerType get triggerType => $_getN(2);
  @$pb.TagNumber(3)
  set triggerType(TriggerType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTriggerType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTriggerType() => clearField(3);

  @$pb.TagNumber(4)
  AmountType get amountType => $_getN(3);
  @$pb.TagNumber(4)
  set amountType(AmountType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationAccountId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDestinationAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationAccountId() => clearField(7);

  @$pb.TagNumber(8)
  ScheduleFrequency get frequency => $_getN(7);
  @$pb.TagNumber(8)
  set frequency(ScheduleFrequency v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get scheduleTime => $_getSZ(8);
  @$pb.TagNumber(9)
  set scheduleTime($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasScheduleTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearScheduleTime() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get scheduleDay => $_getIZ(9);
  @$pb.TagNumber(10)
  set scheduleDay($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasScheduleDay() => $_has(9);
  @$pb.TagNumber(10)
  void clearScheduleDay() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get roundUpTo => $_getIZ(10);
  @$pb.TagNumber(11)
  set roundUpTo($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRoundUpTo() => $_has(10);
  @$pb.TagNumber(11)
  void clearRoundUpTo() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get targetAmount => $_getN(11);
  @$pb.TagNumber(12)
  set targetAmount($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTargetAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearTargetAmount() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get minimumBalance => $_getN(12);
  @$pb.TagNumber(13)
  set minimumBalance($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMinimumBalance() => $_has(12);
  @$pb.TagNumber(13)
  void clearMinimumBalance() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get maximumPerSave => $_getN(13);
  @$pb.TagNumber(14)
  set maximumPerSave($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMaximumPerSave() => $_has(13);
  @$pb.TagNumber(14)
  void clearMaximumPerSave() => clearField(14);
}

class CreateAutoSaveRuleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAutoSaveRuleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<AutoSaveRule>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  CreateAutoSaveRuleResponse._() : super();
  factory CreateAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveRule? rule,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (rule != null) {
      _result.rule = rule;
    }
    return _result;
  }
  factory CreateAutoSaveRuleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoSaveRuleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleResponse clone() => CreateAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleResponse copyWith(void Function(CreateAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRuleResponse)) as CreateAutoSaveRuleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse create() => CreateAutoSaveRuleResponse._();
  CreateAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleResponse> createRepeated() => $pb.PbList<CreateAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleResponse>(create);
  static CreateAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  AutoSaveRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AutoSaveRule v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => clearField(3);
  @$pb.TagNumber(3)
  AutoSaveRule ensureRule() => $_ensure(2);
}

class GetAutoSaveRulesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveRulesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..e<AutoSaveStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: AutoSaveStatus.STATUS_UNKNOWN, valueOf: AutoSaveStatus.valueOf, enumValues: AutoSaveStatus.values)
    ..hasRequiredFields = false
  ;

  GetAutoSaveRulesRequest._() : super();
  factory GetAutoSaveRulesRequest({
    $core.String? accountId,
    AutoSaveStatus? status,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetAutoSaveRulesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveRulesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesRequest clone() => GetAutoSaveRulesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesRequest copyWith(void Function(GetAutoSaveRulesRequest) updates) => super.copyWith((message) => updates(message as GetAutoSaveRulesRequest)) as GetAutoSaveRulesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest create() => GetAutoSaveRulesRequest._();
  GetAutoSaveRulesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesRequest> createRepeated() => $pb.PbList<GetAutoSaveRulesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesRequest>(create);
  static GetAutoSaveRulesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  AutoSaveStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(AutoSaveStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}

class GetAutoSaveRulesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveRulesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..pc<AutoSaveRule>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rules', $pb.PbFieldType.PM, subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  GetAutoSaveRulesResponse._() : super();
  factory GetAutoSaveRulesResponse({
    $core.bool? success,
    $core.String? msg,
    $core.Iterable<AutoSaveRule>? rules,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (rules != null) {
      _result.rules.addAll(rules);
    }
    return _result;
  }
  factory GetAutoSaveRulesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveRulesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesResponse clone() => GetAutoSaveRulesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesResponse copyWith(void Function(GetAutoSaveRulesResponse) updates) => super.copyWith((message) => updates(message as GetAutoSaveRulesResponse)) as GetAutoSaveRulesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse create() => GetAutoSaveRulesResponse._();
  GetAutoSaveRulesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesResponse> createRepeated() => $pb.PbList<GetAutoSaveRulesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesResponse>(create);
  static GetAutoSaveRulesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<AutoSaveRule> get rules => $_getList(2);
}

class UpdateAutoSaveRuleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAutoSaveRuleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<AmountType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountType', $pb.PbFieldType.OE, defaultOrMaker: AmountType.AMOUNT_UNKNOWN, valueOf: AmountType.valueOf, enumValues: AmountType.values)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..e<ScheduleFrequency>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ScheduleFrequency.FREQUENCY_UNKNOWN, valueOf: ScheduleFrequency.valueOf, enumValues: ScheduleFrequency.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleTime')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateAutoSaveRuleRequest._() : super();
  factory UpdateAutoSaveRuleRequest({
    $core.String? ruleId,
    $core.String? name,
    $core.String? description,
    AmountType? amountType,
    $core.double? amountValue,
    ScheduleFrequency? frequency,
    $core.String? scheduleTime,
    $core.int? scheduleDay,
    $core.int? roundUpTo,
    $core.double? targetAmount,
    $core.double? minimumBalance,
    $core.double? maximumPerSave,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amountType != null) {
      _result.amountType = amountType;
    }
    if (amountValue != null) {
      _result.amountValue = amountValue;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (scheduleTime != null) {
      _result.scheduleTime = scheduleTime;
    }
    if (scheduleDay != null) {
      _result.scheduleDay = scheduleDay;
    }
    if (roundUpTo != null) {
      _result.roundUpTo = roundUpTo;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (maximumPerSave != null) {
      _result.maximumPerSave = maximumPerSave;
    }
    return _result;
  }
  factory UpdateAutoSaveRuleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoSaveRuleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleRequest clone() => UpdateAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleRequest copyWith(void Function(UpdateAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRuleRequest)) as UpdateAutoSaveRuleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest create() => UpdateAutoSaveRuleRequest._();
  UpdateAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleRequest> createRepeated() => $pb.PbList<UpdateAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleRequest>(create);
  static UpdateAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

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
  AmountType get amountType => $_getN(3);
  @$pb.TagNumber(4)
  set amountType(AmountType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => clearField(5);

  @$pb.TagNumber(6)
  ScheduleFrequency get frequency => $_getN(5);
  @$pb.TagNumber(6)
  set frequency(ScheduleFrequency v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get scheduleTime => $_getSZ(6);
  @$pb.TagNumber(7)
  set scheduleTime($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasScheduleTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearScheduleTime() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get scheduleDay => $_getIZ(7);
  @$pb.TagNumber(8)
  set scheduleDay($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasScheduleDay() => $_has(7);
  @$pb.TagNumber(8)
  void clearScheduleDay() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get roundUpTo => $_getIZ(8);
  @$pb.TagNumber(9)
  set roundUpTo($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRoundUpTo() => $_has(8);
  @$pb.TagNumber(9)
  void clearRoundUpTo() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get targetAmount => $_getN(9);
  @$pb.TagNumber(10)
  set targetAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTargetAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTargetAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get minimumBalance => $_getN(10);
  @$pb.TagNumber(11)
  set minimumBalance($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMinimumBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinimumBalance() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get maximumPerSave => $_getN(11);
  @$pb.TagNumber(12)
  set maximumPerSave($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMaximumPerSave() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaximumPerSave() => clearField(12);
}

class UpdateAutoSaveRuleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAutoSaveRuleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<AutoSaveRule>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  UpdateAutoSaveRuleResponse._() : super();
  factory UpdateAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveRule? rule,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (rule != null) {
      _result.rule = rule;
    }
    return _result;
  }
  factory UpdateAutoSaveRuleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoSaveRuleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleResponse clone() => UpdateAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleResponse copyWith(void Function(UpdateAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRuleResponse)) as UpdateAutoSaveRuleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse create() => UpdateAutoSaveRuleResponse._();
  UpdateAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleResponse> createRepeated() => $pb.PbList<UpdateAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleResponse>(create);
  static UpdateAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  AutoSaveRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AutoSaveRule v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => clearField(3);
  @$pb.TagNumber(3)
  AutoSaveRule ensureRule() => $_ensure(2);
}

class ToggleAutoSaveRuleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToggleAutoSaveRuleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action')
    ..hasRequiredFields = false
  ;

  ToggleAutoSaveRuleRequest._() : super();
  factory ToggleAutoSaveRuleRequest({
    $core.String? ruleId,
    $core.String? action,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (action != null) {
      _result.action = action;
    }
    return _result;
  }
  factory ToggleAutoSaveRuleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleAutoSaveRuleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleRequest clone() => ToggleAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleRequest copyWith(void Function(ToggleAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as ToggleAutoSaveRuleRequest)) as ToggleAutoSaveRuleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest create() => ToggleAutoSaveRuleRequest._();
  ToggleAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleRequest> createRepeated() => $pb.PbList<ToggleAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleRequest>(create);
  static ToggleAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => clearField(2);
}

class ToggleAutoSaveRuleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToggleAutoSaveRuleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<AutoSaveRule>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  ToggleAutoSaveRuleResponse._() : super();
  factory ToggleAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveRule? rule,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (rule != null) {
      _result.rule = rule;
    }
    return _result;
  }
  factory ToggleAutoSaveRuleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleAutoSaveRuleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleResponse clone() => ToggleAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleResponse copyWith(void Function(ToggleAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as ToggleAutoSaveRuleResponse)) as ToggleAutoSaveRuleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse create() => ToggleAutoSaveRuleResponse._();
  ToggleAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleResponse> createRepeated() => $pb.PbList<ToggleAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleResponse>(create);
  static ToggleAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  AutoSaveRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AutoSaveRule v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => clearField(3);
  @$pb.TagNumber(3)
  AutoSaveRule ensureRule() => $_ensure(2);
}

class DeleteAutoSaveRuleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteAutoSaveRuleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..hasRequiredFields = false
  ;

  DeleteAutoSaveRuleRequest._() : super();
  factory DeleteAutoSaveRuleRequest({
    $core.String? ruleId,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    return _result;
  }
  factory DeleteAutoSaveRuleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoSaveRuleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleRequest clone() => DeleteAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleRequest copyWith(void Function(DeleteAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRuleRequest)) as DeleteAutoSaveRuleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest create() => DeleteAutoSaveRuleRequest._();
  DeleteAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleRequest> createRepeated() => $pb.PbList<DeleteAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleRequest>(create);
  static DeleteAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);
}

class DeleteAutoSaveRuleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteAutoSaveRuleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  DeleteAutoSaveRuleResponse._() : super();
  factory DeleteAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory DeleteAutoSaveRuleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoSaveRuleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleResponse clone() => DeleteAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleResponse copyWith(void Function(DeleteAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRuleResponse)) as DeleteAutoSaveRuleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse create() => DeleteAutoSaveRuleResponse._();
  DeleteAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleResponse> createRepeated() => $pb.PbList<DeleteAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleResponse>(create);
  static DeleteAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
}

class AutoSaveTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoSaveTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<TriggerType>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerType', $pb.PbFieldType.OE, defaultOrMaker: TriggerType.TRIGGER_UNKNOWN, valueOf: TriggerType.valueOf, enumValues: TriggerType.values)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerReason')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<$28.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  AutoSaveTransaction._() : super();
  factory AutoSaveTransaction({
    $core.String? id,
    $core.String? ruleId,
    $core.String? userId,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
    $core.double? amount,
    TriggerType? triggerType,
    $core.String? triggerReason,
    $core.bool? success,
    $core.String? errorMessage,
    $28.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (triggerType != null) {
      _result.triggerType = triggerType;
    }
    if (triggerReason != null) {
      _result.triggerReason = triggerReason;
    }
    if (success != null) {
      _result.success = success;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory AutoSaveTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSaveTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSaveTransaction clone() => AutoSaveTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSaveTransaction copyWith(void Function(AutoSaveTransaction) updates) => super.copyWith((message) => updates(message as AutoSaveTransaction)) as AutoSaveTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction create() => AutoSaveTransaction._();
  AutoSaveTransaction createEmptyInstance() => create();
  static $pb.PbList<AutoSaveTransaction> createRepeated() => $pb.PbList<AutoSaveTransaction>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveTransaction>(create);
  static AutoSaveTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ruleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ruleId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRuleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRuleId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccountId() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  TriggerType get triggerType => $_getN(6);
  @$pb.TagNumber(7)
  set triggerType(TriggerType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTriggerType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTriggerType() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get triggerReason => $_getSZ(7);
  @$pb.TagNumber(8)
  set triggerReason($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTriggerReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearTriggerReason() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get success => $_getBF(8);
  @$pb.TagNumber(9)
  set success($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSuccess() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuccess() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get errorMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set errorMessage($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasErrorMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearErrorMessage() => clearField(10);

  @$pb.TagNumber(11)
  $28.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($28.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $28.Timestamp ensureCreatedAt() => $_ensure(10);
}

class GetAutoSaveTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoSaveTransactionsRequest._() : super();
  factory GetAutoSaveTransactionsRequest({
    $core.String? ruleId,
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetAutoSaveTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsRequest clone() => GetAutoSaveTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsRequest copyWith(void Function(GetAutoSaveTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetAutoSaveTransactionsRequest)) as GetAutoSaveTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest create() => GetAutoSaveTransactionsRequest._();
  GetAutoSaveTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsRequest> createRepeated() => $pb.PbList<GetAutoSaveTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsRequest>(create);
  static GetAutoSaveTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => clearField(4);
}

class GetAutoSaveTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..pc<AutoSaveTransaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AutoSaveTransaction.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoSaveTransactionsResponse._() : super();
  factory GetAutoSaveTransactionsResponse({
    $core.bool? success,
    $core.String? msg,
    $core.Iterable<AutoSaveTransaction>? transactions,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetAutoSaveTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsResponse clone() => GetAutoSaveTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsResponse copyWith(void Function(GetAutoSaveTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetAutoSaveTransactionsResponse)) as GetAutoSaveTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse create() => GetAutoSaveTransactionsResponse._();
  GetAutoSaveTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsResponse> createRepeated() => $pb.PbList<GetAutoSaveTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsResponse>(create);
  static GetAutoSaveTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<AutoSaveTransaction> get transactions => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => clearField(4);
}

class AutoSaveStatistics extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoSaveStatistics', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeRulesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSavedAllTime', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSavedThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSavedThisWeek', $pb.PbFieldType.OD)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averageSaveAmount', $pb.PbFieldType.OD)
    ..aOM<AutoSaveRule>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mostActiveRule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  AutoSaveStatistics._() : super();
  factory AutoSaveStatistics({
    $core.String? userId,
    $core.int? activeRulesCount,
    $core.double? totalSavedAllTime,
    $core.double? totalSavedThisMonth,
    $core.double? totalSavedThisWeek,
    $core.int? totalTransactions,
    $core.double? averageSaveAmount,
    AutoSaveRule? mostActiveRule,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (activeRulesCount != null) {
      _result.activeRulesCount = activeRulesCount;
    }
    if (totalSavedAllTime != null) {
      _result.totalSavedAllTime = totalSavedAllTime;
    }
    if (totalSavedThisMonth != null) {
      _result.totalSavedThisMonth = totalSavedThisMonth;
    }
    if (totalSavedThisWeek != null) {
      _result.totalSavedThisWeek = totalSavedThisWeek;
    }
    if (totalTransactions != null) {
      _result.totalTransactions = totalTransactions;
    }
    if (averageSaveAmount != null) {
      _result.averageSaveAmount = averageSaveAmount;
    }
    if (mostActiveRule != null) {
      _result.mostActiveRule = mostActiveRule;
    }
    return _result;
  }
  factory AutoSaveStatistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSaveStatistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSaveStatistics clone() => AutoSaveStatistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSaveStatistics copyWith(void Function(AutoSaveStatistics) updates) => super.copyWith((message) => updates(message as AutoSaveStatistics)) as AutoSaveStatistics; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics create() => AutoSaveStatistics._();
  AutoSaveStatistics createEmptyInstance() => create();
  static $pb.PbList<AutoSaveStatistics> createRepeated() => $pb.PbList<AutoSaveStatistics>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveStatistics>(create);
  static AutoSaveStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeRulesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeRulesCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveRulesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveRulesCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSavedAllTime => $_getN(2);
  @$pb.TagNumber(3)
  set totalSavedAllTime($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalSavedAllTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSavedAllTime() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalSavedThisMonth => $_getN(3);
  @$pb.TagNumber(4)
  set totalSavedThisMonth($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalSavedThisMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSavedThisMonth() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalSavedThisWeek => $_getN(4);
  @$pb.TagNumber(5)
  set totalSavedThisWeek($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalSavedThisWeek() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalSavedThisWeek() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalTransactions => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalTransactions($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalTransactions() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalTransactions() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get averageSaveAmount => $_getN(6);
  @$pb.TagNumber(7)
  set averageSaveAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAverageSaveAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAverageSaveAmount() => clearField(7);

  @$pb.TagNumber(8)
  AutoSaveRule get mostActiveRule => $_getN(7);
  @$pb.TagNumber(8)
  set mostActiveRule(AutoSaveRule v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasMostActiveRule() => $_has(7);
  @$pb.TagNumber(8)
  void clearMostActiveRule() => clearField(8);
  @$pb.TagNumber(8)
  AutoSaveRule ensureMostActiveRule() => $_ensure(7);
}

class GetAutoSaveStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetAutoSaveStatisticsRequest._() : super();
  factory GetAutoSaveStatisticsRequest() => create();
  factory GetAutoSaveStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsRequest clone() => GetAutoSaveStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsRequest copyWith(void Function(GetAutoSaveStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetAutoSaveStatisticsRequest)) as GetAutoSaveStatisticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest create() => GetAutoSaveStatisticsRequest._();
  GetAutoSaveStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsRequest> createRepeated() => $pb.PbList<GetAutoSaveStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsRequest>(create);
  static GetAutoSaveStatisticsRequest? _defaultInstance;
}

class GetAutoSaveStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<AutoSaveStatistics>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statistics', subBuilder: AutoSaveStatistics.create)
    ..hasRequiredFields = false
  ;

  GetAutoSaveStatisticsResponse._() : super();
  factory GetAutoSaveStatisticsResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveStatistics? statistics,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (statistics != null) {
      _result.statistics = statistics;
    }
    return _result;
  }
  factory GetAutoSaveStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsResponse clone() => GetAutoSaveStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsResponse copyWith(void Function(GetAutoSaveStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetAutoSaveStatisticsResponse)) as GetAutoSaveStatisticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse create() => GetAutoSaveStatisticsResponse._();
  GetAutoSaveStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsResponse> createRepeated() => $pb.PbList<GetAutoSaveStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsResponse>(create);
  static GetAutoSaveStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  AutoSaveStatistics get statistics => $_getN(2);
  @$pb.TagNumber(3)
  set statistics(AutoSaveStatistics v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatistics() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatistics() => clearField(3);
  @$pb.TagNumber(3)
  AutoSaveStatistics ensureStatistics() => $_ensure(2);
}

class TriggerAutoSaveRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TriggerAutoSaveRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TriggerAutoSaveRequest._() : super();
  factory TriggerAutoSaveRequest({
    $core.String? ruleId,
    $core.double? customAmount,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (customAmount != null) {
      _result.customAmount = customAmount;
    }
    return _result;
  }
  factory TriggerAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveRequest clone() => TriggerAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveRequest copyWith(void Function(TriggerAutoSaveRequest) updates) => super.copyWith((message) => updates(message as TriggerAutoSaveRequest)) as TriggerAutoSaveRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest create() => TriggerAutoSaveRequest._();
  TriggerAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveRequest> createRepeated() => $pb.PbList<TriggerAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveRequest>(create);
  static TriggerAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get customAmount => $_getN(1);
  @$pb.TagNumber(2)
  set customAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomAmount() => clearField(2);
}

class TriggerAutoSaveResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TriggerAutoSaveResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<AutoSaveTransaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: AutoSaveTransaction.create)
    ..hasRequiredFields = false
  ;

  TriggerAutoSaveResponse._() : super();
  factory TriggerAutoSaveResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveTransaction? transaction,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory TriggerAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveResponse clone() => TriggerAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveResponse copyWith(void Function(TriggerAutoSaveResponse) updates) => super.copyWith((message) => updates(message as TriggerAutoSaveResponse)) as TriggerAutoSaveResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse create() => TriggerAutoSaveResponse._();
  TriggerAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveResponse> createRepeated() => $pb.PbList<TriggerAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveResponse>(create);
  static TriggerAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  AutoSaveTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(AutoSaveTransaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  AutoSaveTransaction ensureTransaction() => $_ensure(2);
}

