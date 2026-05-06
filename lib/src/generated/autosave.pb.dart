// This is a generated file - do not edit.
//
// Generated from autosave.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'autosave.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'autosave.pbenum.dart';

/// Auto-save rule definition
class AutoSaveRule extends $pb.GeneratedMessage {
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
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $1.Timestamp? lastTriggeredAt,
    $core.int? triggerCount,
    $core.double? totalSaved,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (triggerType != null) result.triggerType = triggerType;
    if (amountType != null) result.amountType = amountType;
    if (amountValue != null) result.amountValue = amountValue;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null) result.destinationAccountId = destinationAccountId;
    if (status != null) result.status = status;
    if (frequency != null) result.frequency = frequency;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (roundUpTo != null) result.roundUpTo = roundUpTo;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (maximumPerSave != null) result.maximumPerSave = maximumPerSave;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (lastTriggeredAt != null) result.lastTriggeredAt = lastTriggeredAt;
    if (triggerCount != null) result.triggerCount = triggerCount;
    if (totalSaved != null) result.totalSaved = totalSaved;
    return result;
  }

  AutoSaveRule._();

  factory AutoSaveRule.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AutoSaveRule.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutoSaveRule', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..e<TriggerType>(5, _omitFieldNames ? '' : 'triggerType', $pb.PbFieldType.OE, defaultOrMaker: TriggerType.TRIGGER_UNKNOWN, valueOf: TriggerType.valueOf, enumValues: TriggerType.values)
    ..e<AmountType>(6, _omitFieldNames ? '' : 'amountType', $pb.PbFieldType.OE, defaultOrMaker: AmountType.AMOUNT_UNKNOWN, valueOf: AmountType.valueOf, enumValues: AmountType.values)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(9, _omitFieldNames ? '' : 'destinationAccountId')
    ..e<AutoSaveStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: AutoSaveStatus.STATUS_UNKNOWN, valueOf: AutoSaveStatus.valueOf, enumValues: AutoSaveStatus.values)
    ..e<ScheduleFrequency>(11, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ScheduleFrequency.FREQUENCY_UNKNOWN, valueOf: ScheduleFrequency.valueOf, enumValues: ScheduleFrequency.values)
    ..aOS(12, _omitFieldNames ? '' : 'scheduleTime')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(15, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(16, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(17, _omitFieldNames ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'lastTriggeredAt', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(21, _omitFieldNames ? '' : 'triggerCount', $pb.PbFieldType.O3)
    ..a<$core.double>(22, _omitFieldNames ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveRule clone() => AutoSaveRule()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveRule copyWith(void Function(AutoSaveRule) updates) => super.copyWith((message) => updates(message as AutoSaveRule)) as AutoSaveRule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSaveRule create() => AutoSaveRule._();
  @$core.override
  AutoSaveRule createEmptyInstance() => create();
  static $pb.PbList<AutoSaveRule> createRepeated() => $pb.PbList<AutoSaveRule>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveRule getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveRule>(create);
  static AutoSaveRule? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  TriggerType get triggerType => $_getN(4);
  @$pb.TagNumber(5)
  set triggerType(TriggerType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTriggerType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTriggerType() => $_clearField(5);

  @$pb.TagNumber(6)
  AmountType get amountType => $_getN(5);
  @$pb.TagNumber(6)
  set amountType(AmountType value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountType() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get amountValue => $_getN(6);
  @$pb.TagNumber(7)
  set amountValue($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmountValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountValue() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccountId() => $_clearField(9);

  @$pb.TagNumber(10)
  AutoSaveStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(AutoSaveStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  /// For scheduled triggers
  @$pb.TagNumber(11)
  ScheduleFrequency get frequency => $_getN(10);
  @$pb.TagNumber(11)
  set frequency(ScheduleFrequency value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasFrequency() => $_has(10);
  @$pb.TagNumber(11)
  void clearFrequency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get scheduleTime => $_getSZ(11);
  @$pb.TagNumber(12)
  set scheduleTime($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasScheduleTime() => $_has(11);
  @$pb.TagNumber(12)
  void clearScheduleTime() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get scheduleDay => $_getIZ(12);
  @$pb.TagNumber(13)
  set scheduleDay($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasScheduleDay() => $_has(12);
  @$pb.TagNumber(13)
  void clearScheduleDay() => $_clearField(13);

  /// For round-up triggers
  @$pb.TagNumber(14)
  $core.int get roundUpTo => $_getIZ(13);
  @$pb.TagNumber(14)
  set roundUpTo($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasRoundUpTo() => $_has(13);
  @$pb.TagNumber(14)
  void clearRoundUpTo() => $_clearField(14);

  /// Goals and limits
  @$pb.TagNumber(15)
  $core.double get targetAmount => $_getN(14);
  @$pb.TagNumber(15)
  set targetAmount($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasTargetAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearTargetAmount() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.double get minimumBalance => $_getN(15);
  @$pb.TagNumber(16)
  set minimumBalance($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMinimumBalance() => $_has(15);
  @$pb.TagNumber(16)
  void clearMinimumBalance() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get maximumPerSave => $_getN(16);
  @$pb.TagNumber(17)
  set maximumPerSave($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMaximumPerSave() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaximumPerSave() => $_clearField(17);

  /// Metadata
  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get lastTriggeredAt => $_getN(19);
  @$pb.TagNumber(20)
  set lastTriggeredAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasLastTriggeredAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearLastTriggeredAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureLastTriggeredAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.int get triggerCount => $_getIZ(20);
  @$pb.TagNumber(21)
  set triggerCount($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasTriggerCount() => $_has(20);
  @$pb.TagNumber(21)
  void clearTriggerCount() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get totalSaved => $_getN(21);
  @$pb.TagNumber(22)
  set totalSaved($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasTotalSaved() => $_has(21);
  @$pb.TagNumber(22)
  void clearTotalSaved() => $_clearField(22);
}

/// Create auto-save rule request
class CreateAutoSaveRuleRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (triggerType != null) result.triggerType = triggerType;
    if (amountType != null) result.amountType = amountType;
    if (amountValue != null) result.amountValue = amountValue;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null) result.destinationAccountId = destinationAccountId;
    if (frequency != null) result.frequency = frequency;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (roundUpTo != null) result.roundUpTo = roundUpTo;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (maximumPerSave != null) result.maximumPerSave = maximumPerSave;
    return result;
  }

  CreateAutoSaveRuleRequest._();

  factory CreateAutoSaveRuleRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateAutoSaveRuleRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAutoSaveRuleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..e<TriggerType>(3, _omitFieldNames ? '' : 'triggerType', $pb.PbFieldType.OE, defaultOrMaker: TriggerType.TRIGGER_UNKNOWN, valueOf: TriggerType.valueOf, enumValues: TriggerType.values)
    ..e<AmountType>(4, _omitFieldNames ? '' : 'amountType', $pb.PbFieldType.OE, defaultOrMaker: AmountType.AMOUNT_UNKNOWN, valueOf: AmountType.valueOf, enumValues: AmountType.values)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(7, _omitFieldNames ? '' : 'destinationAccountId')
    ..e<ScheduleFrequency>(8, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ScheduleFrequency.FREQUENCY_UNKNOWN, valueOf: ScheduleFrequency.valueOf, enumValues: ScheduleFrequency.values)
    ..aOS(9, _omitFieldNames ? '' : 'scheduleTime')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(14, _omitFieldNames ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleRequest clone() => CreateAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleRequest copyWith(void Function(CreateAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRuleRequest)) as CreateAutoSaveRuleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest create() => CreateAutoSaveRuleRequest._();
  @$core.override
  CreateAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleRequest> createRepeated() => $pb.PbList<CreateAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleRequest>(create);
  static CreateAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  TriggerType get triggerType => $_getN(2);
  @$pb.TagNumber(3)
  set triggerType(TriggerType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTriggerType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTriggerType() => $_clearField(3);

  @$pb.TagNumber(4)
  AmountType get amountType => $_getN(3);
  @$pb.TagNumber(4)
  set amountType(AmountType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDestinationAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationAccountId() => $_clearField(7);

  /// Optional fields based on trigger type
  @$pb.TagNumber(8)
  ScheduleFrequency get frequency => $_getN(7);
  @$pb.TagNumber(8)
  set frequency(ScheduleFrequency value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get scheduleTime => $_getSZ(8);
  @$pb.TagNumber(9)
  set scheduleTime($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasScheduleTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearScheduleTime() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get scheduleDay => $_getIZ(9);
  @$pb.TagNumber(10)
  set scheduleDay($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasScheduleDay() => $_has(9);
  @$pb.TagNumber(10)
  void clearScheduleDay() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get roundUpTo => $_getIZ(10);
  @$pb.TagNumber(11)
  set roundUpTo($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRoundUpTo() => $_has(10);
  @$pb.TagNumber(11)
  void clearRoundUpTo() => $_clearField(11);

  /// Optional goals and limits
  @$pb.TagNumber(12)
  $core.double get targetAmount => $_getN(11);
  @$pb.TagNumber(12)
  set targetAmount($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTargetAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearTargetAmount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get minimumBalance => $_getN(12);
  @$pb.TagNumber(13)
  set minimumBalance($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMinimumBalance() => $_has(12);
  @$pb.TagNumber(13)
  void clearMinimumBalance() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get maximumPerSave => $_getN(13);
  @$pb.TagNumber(14)
  set maximumPerSave($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMaximumPerSave() => $_has(13);
  @$pb.TagNumber(14)
  void clearMaximumPerSave() => $_clearField(14);
}

/// Create auto-save rule response
class CreateAutoSaveRuleResponse extends $pb.GeneratedMessage {
  factory CreateAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveRule? rule,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (rule != null) result.rule = rule;
    return result;
  }

  CreateAutoSaveRuleResponse._();

  factory CreateAutoSaveRuleResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateAutoSaveRuleResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAutoSaveRuleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<AutoSaveRule>(3, _omitFieldNames ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleResponse clone() => CreateAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleResponse copyWith(void Function(CreateAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRuleResponse)) as CreateAutoSaveRuleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse create() => CreateAutoSaveRuleResponse._();
  @$core.override
  CreateAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleResponse> createRepeated() => $pb.PbList<CreateAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleResponse>(create);
  static CreateAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  AutoSaveRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AutoSaveRule value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => $_clearField(3);
  @$pb.TagNumber(3)
  AutoSaveRule ensureRule() => $_ensure(2);
}

/// Get auto-save rules request. Server-side filter / sort / pagination
/// support so the All-Rules screen can scroll through hundreds of
/// rules without loading the full collection on every interaction.
class GetAutoSaveRulesRequest extends $pb.GeneratedMessage {
  factory GetAutoSaveRulesRequest({
    $core.String? accountId,
    AutoSaveStatus? status,
    $core.String? search,
    $core.String? sortBy,
    $core.String? sortDir,
    $core.int? limit,
    $core.int? offset,
    $core.String? triggerType,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (status != null) result.status = status;
    if (search != null) result.search = search;
    if (sortBy != null) result.sortBy = sortBy;
    if (sortDir != null) result.sortDir = sortDir;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (triggerType != null) result.triggerType = triggerType;
    return result;
  }

  GetAutoSaveRulesRequest._();

  factory GetAutoSaveRulesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveRulesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSaveRulesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..e<AutoSaveStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: AutoSaveStatus.STATUS_UNKNOWN, valueOf: AutoSaveStatus.valueOf, enumValues: AutoSaveStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'search')
    ..aOS(4, _omitFieldNames ? '' : 'sortBy')
    ..aOS(5, _omitFieldNames ? '' : 'sortDir')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'triggerType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesRequest clone() => GetAutoSaveRulesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesRequest copyWith(void Function(GetAutoSaveRulesRequest) updates) => super.copyWith((message) => updates(message as GetAutoSaveRulesRequest)) as GetAutoSaveRulesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest create() => GetAutoSaveRulesRequest._();
  @$core.override
  GetAutoSaveRulesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesRequest> createRepeated() => $pb.PbList<GetAutoSaveRulesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesRequest>(create);
  static GetAutoSaveRulesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  AutoSaveStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(AutoSaveStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sortBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set sortBy($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSortBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearSortBy() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sortDir => $_getSZ(4);
  @$pb.TagNumber(5)
  set sortDir($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSortDir() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortDir() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get limit => $_getIZ(5);
  @$pb.TagNumber(6)
  set limit($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get offset => $_getIZ(6);
  @$pb.TagNumber(7)
  set offset($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOffset() => $_has(6);
  @$pb.TagNumber(7)
  void clearOffset() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get triggerType => $_getSZ(7);
  @$pb.TagNumber(8)
  set triggerType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTriggerType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTriggerType() => $_clearField(8);
}

/// Get auto-save rules response
class GetAutoSaveRulesResponse extends $pb.GeneratedMessage {
  factory GetAutoSaveRulesResponse({
    $core.bool? success,
    $core.String? msg,
    $core.Iterable<AutoSaveRule>? rules,
    $core.int? total,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (rules != null) result.rules.addAll(rules);
    if (total != null) result.total = total;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  GetAutoSaveRulesResponse._();

  factory GetAutoSaveRulesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveRulesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSaveRulesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..pc<AutoSaveRule>(3, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM, subBuilder: AutoSaveRule.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesResponse clone() => GetAutoSaveRulesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesResponse copyWith(void Function(GetAutoSaveRulesResponse) updates) => super.copyWith((message) => updates(message as GetAutoSaveRulesResponse)) as GetAutoSaveRulesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse create() => GetAutoSaveRulesResponse._();
  @$core.override
  GetAutoSaveRulesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesResponse> createRepeated() => $pb.PbList<GetAutoSaveRulesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesResponse>(create);
  static GetAutoSaveRulesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<AutoSaveRule> get rules => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get total => $_getIZ(3);
  @$pb.TagNumber(4)
  set total($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotal() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasMore => $_getBF(4);
  @$pb.TagNumber(5)
  set hasMore($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasMore() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasMore() => $_clearField(5);
}

/// Update auto-save rule request
class UpdateAutoSaveRuleRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (amountType != null) result.amountType = amountType;
    if (amountValue != null) result.amountValue = amountValue;
    if (frequency != null) result.frequency = frequency;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (roundUpTo != null) result.roundUpTo = roundUpTo;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (maximumPerSave != null) result.maximumPerSave = maximumPerSave;
    return result;
  }

  UpdateAutoSaveRuleRequest._();

  factory UpdateAutoSaveRuleRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateAutoSaveRuleRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAutoSaveRuleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<AmountType>(4, _omitFieldNames ? '' : 'amountType', $pb.PbFieldType.OE, defaultOrMaker: AmountType.AMOUNT_UNKNOWN, valueOf: AmountType.valueOf, enumValues: AmountType.values)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..e<ScheduleFrequency>(6, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ScheduleFrequency.FREQUENCY_UNKNOWN, valueOf: ScheduleFrequency.valueOf, enumValues: ScheduleFrequency.values)
    ..aOS(7, _omitFieldNames ? '' : 'scheduleTime')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleRequest clone() => UpdateAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleRequest copyWith(void Function(UpdateAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRuleRequest)) as UpdateAutoSaveRuleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest create() => UpdateAutoSaveRuleRequest._();
  @$core.override
  UpdateAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleRequest> createRepeated() => $pb.PbList<UpdateAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleRequest>(create);
  static UpdateAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

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
  AmountType get amountType => $_getN(3);
  @$pb.TagNumber(4)
  set amountType(AmountType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => $_clearField(5);

  /// Optional fields
  @$pb.TagNumber(6)
  ScheduleFrequency get frequency => $_getN(5);
  @$pb.TagNumber(6)
  set frequency(ScheduleFrequency value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get scheduleTime => $_getSZ(6);
  @$pb.TagNumber(7)
  set scheduleTime($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasScheduleTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearScheduleTime() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get scheduleDay => $_getIZ(7);
  @$pb.TagNumber(8)
  set scheduleDay($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasScheduleDay() => $_has(7);
  @$pb.TagNumber(8)
  void clearScheduleDay() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get roundUpTo => $_getIZ(8);
  @$pb.TagNumber(9)
  set roundUpTo($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRoundUpTo() => $_has(8);
  @$pb.TagNumber(9)
  void clearRoundUpTo() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get targetAmount => $_getN(9);
  @$pb.TagNumber(10)
  set targetAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTargetAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTargetAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get minimumBalance => $_getN(10);
  @$pb.TagNumber(11)
  set minimumBalance($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMinimumBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinimumBalance() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get maximumPerSave => $_getN(11);
  @$pb.TagNumber(12)
  set maximumPerSave($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMaximumPerSave() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaximumPerSave() => $_clearField(12);
}

/// Update auto-save rule response
class UpdateAutoSaveRuleResponse extends $pb.GeneratedMessage {
  factory UpdateAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveRule? rule,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (rule != null) result.rule = rule;
    return result;
  }

  UpdateAutoSaveRuleResponse._();

  factory UpdateAutoSaveRuleResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateAutoSaveRuleResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAutoSaveRuleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<AutoSaveRule>(3, _omitFieldNames ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleResponse clone() => UpdateAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleResponse copyWith(void Function(UpdateAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRuleResponse)) as UpdateAutoSaveRuleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse create() => UpdateAutoSaveRuleResponse._();
  @$core.override
  UpdateAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleResponse> createRepeated() => $pb.PbList<UpdateAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleResponse>(create);
  static UpdateAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  AutoSaveRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AutoSaveRule value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => $_clearField(3);
  @$pb.TagNumber(3)
  AutoSaveRule ensureRule() => $_ensure(2);
}

/// Pause/resume auto-save rule request
class ToggleAutoSaveRuleRequest extends $pb.GeneratedMessage {
  factory ToggleAutoSaveRuleRequest({
    $core.String? ruleId,
    $core.String? action,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (action != null) result.action = action;
    return result;
  }

  ToggleAutoSaveRuleRequest._();

  factory ToggleAutoSaveRuleRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ToggleAutoSaveRuleRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ToggleAutoSaveRuleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleRequest clone() => ToggleAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleRequest copyWith(void Function(ToggleAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as ToggleAutoSaveRuleRequest)) as ToggleAutoSaveRuleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest create() => ToggleAutoSaveRuleRequest._();
  @$core.override
  ToggleAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleRequest> createRepeated() => $pb.PbList<ToggleAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleRequest>(create);
  static ToggleAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);
}

/// Pause/resume auto-save rule response
class ToggleAutoSaveRuleResponse extends $pb.GeneratedMessage {
  factory ToggleAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveRule? rule,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (rule != null) result.rule = rule;
    return result;
  }

  ToggleAutoSaveRuleResponse._();

  factory ToggleAutoSaveRuleResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ToggleAutoSaveRuleResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ToggleAutoSaveRuleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<AutoSaveRule>(3, _omitFieldNames ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleResponse clone() => ToggleAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleResponse copyWith(void Function(ToggleAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as ToggleAutoSaveRuleResponse)) as ToggleAutoSaveRuleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse create() => ToggleAutoSaveRuleResponse._();
  @$core.override
  ToggleAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleResponse> createRepeated() => $pb.PbList<ToggleAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleResponse>(create);
  static ToggleAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  AutoSaveRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AutoSaveRule value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => $_clearField(3);
  @$pb.TagNumber(3)
  AutoSaveRule ensureRule() => $_ensure(2);
}

/// Delete auto-save rule request
class DeleteAutoSaveRuleRequest extends $pb.GeneratedMessage {
  factory DeleteAutoSaveRuleRequest({
    $core.String? ruleId,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    return result;
  }

  DeleteAutoSaveRuleRequest._();

  factory DeleteAutoSaveRuleRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory DeleteAutoSaveRuleRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAutoSaveRuleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleRequest clone() => DeleteAutoSaveRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleRequest copyWith(void Function(DeleteAutoSaveRuleRequest) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRuleRequest)) as DeleteAutoSaveRuleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest create() => DeleteAutoSaveRuleRequest._();
  @$core.override
  DeleteAutoSaveRuleRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleRequest> createRepeated() => $pb.PbList<DeleteAutoSaveRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleRequest>(create);
  static DeleteAutoSaveRuleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);
}

/// Delete auto-save rule response
class DeleteAutoSaveRuleResponse extends $pb.GeneratedMessage {
  factory DeleteAutoSaveRuleResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  DeleteAutoSaveRuleResponse._();

  factory DeleteAutoSaveRuleResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory DeleteAutoSaveRuleResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAutoSaveRuleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleResponse clone() => DeleteAutoSaveRuleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleResponse copyWith(void Function(DeleteAutoSaveRuleResponse) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRuleResponse)) as DeleteAutoSaveRuleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse create() => DeleteAutoSaveRuleResponse._();
  @$core.override
  DeleteAutoSaveRuleResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleResponse> createRepeated() => $pb.PbList<DeleteAutoSaveRuleResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleResponse>(create);
  static DeleteAutoSaveRuleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// Auto-save transaction record
class AutoSaveTransaction extends $pb.GeneratedMessage {
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
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (ruleId != null) result.ruleId = ruleId;
    if (userId != null) result.userId = userId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null) result.destinationAccountId = destinationAccountId;
    if (amount != null) result.amount = amount;
    if (triggerType != null) result.triggerType = triggerType;
    if (triggerReason != null) result.triggerReason = triggerReason;
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  AutoSaveTransaction._();

  factory AutoSaveTransaction.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AutoSaveTransaction.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutoSaveTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ruleId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'destinationAccountId')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<TriggerType>(7, _omitFieldNames ? '' : 'triggerType', $pb.PbFieldType.OE, defaultOrMaker: TriggerType.TRIGGER_UNKNOWN, valueOf: TriggerType.valueOf, enumValues: TriggerType.values)
    ..aOS(8, _omitFieldNames ? '' : 'triggerReason')
    ..aOB(9, _omitFieldNames ? '' : 'success')
    ..aOS(10, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveTransaction clone() => AutoSaveTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveTransaction copyWith(void Function(AutoSaveTransaction) updates) => super.copyWith((message) => updates(message as AutoSaveTransaction)) as AutoSaveTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction create() => AutoSaveTransaction._();
  @$core.override
  AutoSaveTransaction createEmptyInstance() => create();
  static $pb.PbList<AutoSaveTransaction> createRepeated() => $pb.PbList<AutoSaveTransaction>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveTransaction>(create);
  static AutoSaveTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ruleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ruleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRuleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRuleId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  TriggerType get triggerType => $_getN(6);
  @$pb.TagNumber(7)
  set triggerType(TriggerType value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTriggerType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTriggerType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get triggerReason => $_getSZ(7);
  @$pb.TagNumber(8)
  set triggerReason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTriggerReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearTriggerReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get success => $_getBF(8);
  @$pb.TagNumber(9)
  set success($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSuccess() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuccess() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get errorMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set errorMessage($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasErrorMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearErrorMessage() => $_clearField(10);

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

/// Get auto-save transactions request
class GetAutoSaveTransactionsRequest extends $pb.GeneratedMessage {
  factory GetAutoSaveTransactionsRequest({
    $core.String? ruleId,
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (accountId != null) result.accountId = accountId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetAutoSaveTransactionsRequest._();

  factory GetAutoSaveTransactionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveTransactionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSaveTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsRequest clone() => GetAutoSaveTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsRequest copyWith(void Function(GetAutoSaveTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetAutoSaveTransactionsRequest)) as GetAutoSaveTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest create() => GetAutoSaveTransactionsRequest._();
  @$core.override
  GetAutoSaveTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsRequest> createRepeated() => $pb.PbList<GetAutoSaveTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsRequest>(create);
  static GetAutoSaveTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

/// Get auto-save transactions response
class GetAutoSaveTransactionsResponse extends $pb.GeneratedMessage {
  factory GetAutoSaveTransactionsResponse({
    $core.bool? success,
    $core.String? msg,
    $core.Iterable<AutoSaveTransaction>? transactions,
    $core.int? totalCount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetAutoSaveTransactionsResponse._();

  factory GetAutoSaveTransactionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveTransactionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSaveTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..pc<AutoSaveTransaction>(3, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AutoSaveTransaction.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsResponse clone() => GetAutoSaveTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsResponse copyWith(void Function(GetAutoSaveTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetAutoSaveTransactionsResponse)) as GetAutoSaveTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse create() => GetAutoSaveTransactionsResponse._();
  @$core.override
  GetAutoSaveTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsResponse> createRepeated() => $pb.PbList<GetAutoSaveTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsResponse>(create);
  static GetAutoSaveTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<AutoSaveTransaction> get transactions => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => $_clearField(4);
}

/// Auto-save statistics
class AutoSaveStatistics extends $pb.GeneratedMessage {
  factory AutoSaveStatistics({
    $core.String? userId,
    $core.int? activeRulesCount,
    $core.double? totalSavedAllTime,
    $core.double? totalSavedThisMonth,
    $core.double? totalSavedThisWeek,
    $core.int? totalTransactions,
    $core.double? averageSaveAmount,
    AutoSaveRule? mostActiveRule,
    AutoSaveRule? topRuleByTotalSaved,
    $core.int? pausedRulesCount,
    $core.int? completedRulesCount,
    $core.int? cancelledRulesCount,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (activeRulesCount != null) result.activeRulesCount = activeRulesCount;
    if (totalSavedAllTime != null) result.totalSavedAllTime = totalSavedAllTime;
    if (totalSavedThisMonth != null) result.totalSavedThisMonth = totalSavedThisMonth;
    if (totalSavedThisWeek != null) result.totalSavedThisWeek = totalSavedThisWeek;
    if (totalTransactions != null) result.totalTransactions = totalTransactions;
    if (averageSaveAmount != null) result.averageSaveAmount = averageSaveAmount;
    if (mostActiveRule != null) result.mostActiveRule = mostActiveRule;
    if (topRuleByTotalSaved != null) result.topRuleByTotalSaved = topRuleByTotalSaved;
    if (pausedRulesCount != null) result.pausedRulesCount = pausedRulesCount;
    if (completedRulesCount != null) result.completedRulesCount = completedRulesCount;
    if (cancelledRulesCount != null) result.cancelledRulesCount = cancelledRulesCount;
    return result;
  }

  AutoSaveStatistics._();

  factory AutoSaveStatistics.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AutoSaveStatistics.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutoSaveStatistics', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'activeRulesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalSavedAllTime', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalSavedThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalSavedThisWeek', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'averageSaveAmount', $pb.PbFieldType.OD)
    ..aOM<AutoSaveRule>(8, _omitFieldNames ? '' : 'mostActiveRule', subBuilder: AutoSaveRule.create)
    ..aOM<AutoSaveRule>(9, _omitFieldNames ? '' : 'topRuleByTotalSaved', subBuilder: AutoSaveRule.create)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'pausedRulesCount', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'completedRulesCount', $pb.PbFieldType.O3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'cancelledRulesCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveStatistics clone() => AutoSaveStatistics()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveStatistics copyWith(void Function(AutoSaveStatistics) updates) => super.copyWith((message) => updates(message as AutoSaveStatistics)) as AutoSaveStatistics;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics create() => AutoSaveStatistics._();
  @$core.override
  AutoSaveStatistics createEmptyInstance() => create();
  static $pb.PbList<AutoSaveStatistics> createRepeated() => $pb.PbList<AutoSaveStatistics>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveStatistics>(create);
  static AutoSaveStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeRulesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeRulesCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveRulesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveRulesCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSavedAllTime => $_getN(2);
  @$pb.TagNumber(3)
  set totalSavedAllTime($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSavedAllTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSavedAllTime() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalSavedThisMonth => $_getN(3);
  @$pb.TagNumber(4)
  set totalSavedThisMonth($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalSavedThisMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSavedThisMonth() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalSavedThisWeek => $_getN(4);
  @$pb.TagNumber(5)
  set totalSavedThisWeek($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalSavedThisWeek() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalSavedThisWeek() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalTransactions => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalTransactions($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalTransactions() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalTransactions() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get averageSaveAmount => $_getN(6);
  @$pb.TagNumber(7)
  set averageSaveAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAverageSaveAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAverageSaveAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  AutoSaveRule get mostActiveRule => $_getN(7);
  @$pb.TagNumber(8)
  set mostActiveRule(AutoSaveRule value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMostActiveRule() => $_has(7);
  @$pb.TagNumber(8)
  void clearMostActiveRule() => $_clearField(8);
  @$pb.TagNumber(8)
  AutoSaveRule ensureMostActiveRule() => $_ensure(7);

  @$pb.TagNumber(9)
  AutoSaveRule get topRuleByTotalSaved => $_getN(8);
  @$pb.TagNumber(9)
  set topRuleByTotalSaved(AutoSaveRule value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTopRuleByTotalSaved() => $_has(8);
  @$pb.TagNumber(9)
  void clearTopRuleByTotalSaved() => $_clearField(9);
  @$pb.TagNumber(9)
  AutoSaveRule ensureTopRuleByTotalSaved() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.int get pausedRulesCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set pausedRulesCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPausedRulesCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearPausedRulesCount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get completedRulesCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set completedRulesCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCompletedRulesCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedRulesCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get cancelledRulesCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set cancelledRulesCount($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCancelledRulesCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearCancelledRulesCount() => $_clearField(12);
}

/// Get auto-save statistics request
class GetAutoSaveStatisticsRequest extends $pb.GeneratedMessage {
  factory GetAutoSaveStatisticsRequest() => create();

  GetAutoSaveStatisticsRequest._();

  factory GetAutoSaveStatisticsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveStatisticsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSaveStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsRequest clone() => GetAutoSaveStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsRequest copyWith(void Function(GetAutoSaveStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetAutoSaveStatisticsRequest)) as GetAutoSaveStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest create() => GetAutoSaveStatisticsRequest._();
  @$core.override
  GetAutoSaveStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsRequest> createRepeated() => $pb.PbList<GetAutoSaveStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsRequest>(create);
  static GetAutoSaveStatisticsRequest? _defaultInstance;
}

/// Get auto-save statistics response
class GetAutoSaveStatisticsResponse extends $pb.GeneratedMessage {
  factory GetAutoSaveStatisticsResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveStatistics? statistics,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (statistics != null) result.statistics = statistics;
    return result;
  }

  GetAutoSaveStatisticsResponse._();

  factory GetAutoSaveStatisticsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveStatisticsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSaveStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<AutoSaveStatistics>(3, _omitFieldNames ? '' : 'statistics', subBuilder: AutoSaveStatistics.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsResponse clone() => GetAutoSaveStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsResponse copyWith(void Function(GetAutoSaveStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetAutoSaveStatisticsResponse)) as GetAutoSaveStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse create() => GetAutoSaveStatisticsResponse._();
  @$core.override
  GetAutoSaveStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsResponse> createRepeated() => $pb.PbList<GetAutoSaveStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsResponse>(create);
  static GetAutoSaveStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  AutoSaveStatistics get statistics => $_getN(2);
  @$pb.TagNumber(3)
  set statistics(AutoSaveStatistics value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatistics() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatistics() => $_clearField(3);
  @$pb.TagNumber(3)
  AutoSaveStatistics ensureStatistics() => $_ensure(2);
}

/// Manual trigger auto-save request (for testing or manual execution)
class TriggerAutoSaveRequest extends $pb.GeneratedMessage {
  factory TriggerAutoSaveRequest({
    $core.String? ruleId,
    $core.double? customAmount,
    $core.String? transactionPinToken,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (customAmount != null) result.customAmount = customAmount;
    if (transactionPinToken != null) result.transactionPinToken = transactionPinToken;
    return result;
  }

  TriggerAutoSaveRequest._();

  factory TriggerAutoSaveRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TriggerAutoSaveRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TriggerAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'customAmount', $pb.PbFieldType.OD)
    ..aOS(15, _omitFieldNames ? '' : 'transactionPinToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveRequest clone() => TriggerAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveRequest copyWith(void Function(TriggerAutoSaveRequest) updates) => super.copyWith((message) => updates(message as TriggerAutoSaveRequest)) as TriggerAutoSaveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest create() => TriggerAutoSaveRequest._();
  @$core.override
  TriggerAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveRequest> createRepeated() => $pb.PbList<TriggerAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveRequest>(create);
  static TriggerAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get customAmount => $_getN(1);
  @$pb.TagNumber(2)
  set customAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCustomAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomAmount() => $_clearField(2);

  @$pb.TagNumber(15)
  $core.String get transactionPinToken => $_getSZ(2);
  @$pb.TagNumber(15)
  set transactionPinToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(15)
  $core.bool hasTransactionPinToken() => $_has(2);
  @$pb.TagNumber(15)
  void clearTransactionPinToken() => $_clearField(15);
}

/// Manual trigger auto-save response
class TriggerAutoSaveResponse extends $pb.GeneratedMessage {
  factory TriggerAutoSaveResponse({
    $core.bool? success,
    $core.String? msg,
    AutoSaveTransaction? transaction,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  TriggerAutoSaveResponse._();

  factory TriggerAutoSaveResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TriggerAutoSaveResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TriggerAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<AutoSaveTransaction>(3, _omitFieldNames ? '' : 'transaction', subBuilder: AutoSaveTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveResponse clone() => TriggerAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveResponse copyWith(void Function(TriggerAutoSaveResponse) updates) => super.copyWith((message) => updates(message as TriggerAutoSaveResponse)) as TriggerAutoSaveResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse create() => TriggerAutoSaveResponse._();
  @$core.override
  TriggerAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveResponse> createRepeated() => $pb.PbList<TriggerAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveResponse>(create);
  static TriggerAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  AutoSaveTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(AutoSaveTransaction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => $_clearField(3);
  @$pb.TagNumber(3)
  AutoSaveTransaction ensureTransaction() => $_ensure(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
