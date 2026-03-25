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

/// Auto-save rule trigger types
class TriggerType extends $pb.ProtobufEnum {
  static const TriggerType TRIGGER_UNKNOWN =
      TriggerType._(0, _omitEnumNames ? '' : 'TRIGGER_UNKNOWN');
  static const TriggerType TRIGGER_ON_DEPOSIT =
      TriggerType._(1, _omitEnumNames ? '' : 'TRIGGER_ON_DEPOSIT');
  static const TriggerType TRIGGER_SCHEDULED =
      TriggerType._(2, _omitEnumNames ? '' : 'TRIGGER_SCHEDULED');
  static const TriggerType TRIGGER_ROUND_UP =
      TriggerType._(3, _omitEnumNames ? '' : 'TRIGGER_ROUND_UP');

  static const $core.List<TriggerType> values = <TriggerType>[
    TRIGGER_UNKNOWN,
    TRIGGER_ON_DEPOSIT,
    TRIGGER_SCHEDULED,
    TRIGGER_ROUND_UP,
  ];

  static final $core.List<TriggerType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TriggerType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TriggerType._(super.value, super.name);
}

/// Schedule frequency for scheduled auto-saves
class ScheduleFrequency extends $pb.ProtobufEnum {
  static const ScheduleFrequency FREQUENCY_UNKNOWN =
      ScheduleFrequency._(0, _omitEnumNames ? '' : 'FREQUENCY_UNKNOWN');
  static const ScheduleFrequency FREQUENCY_DAILY =
      ScheduleFrequency._(1, _omitEnumNames ? '' : 'FREQUENCY_DAILY');
  static const ScheduleFrequency FREQUENCY_WEEKLY =
      ScheduleFrequency._(2, _omitEnumNames ? '' : 'FREQUENCY_WEEKLY');
  static const ScheduleFrequency FREQUENCY_BIWEEKLY =
      ScheduleFrequency._(3, _omitEnumNames ? '' : 'FREQUENCY_BIWEEKLY');
  static const ScheduleFrequency FREQUENCY_MONTHLY =
      ScheduleFrequency._(4, _omitEnumNames ? '' : 'FREQUENCY_MONTHLY');

  static const $core.List<ScheduleFrequency> values = <ScheduleFrequency>[
    FREQUENCY_UNKNOWN,
    FREQUENCY_DAILY,
    FREQUENCY_WEEKLY,
    FREQUENCY_BIWEEKLY,
    FREQUENCY_MONTHLY,
  ];

  static final $core.List<ScheduleFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ScheduleFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ScheduleFrequency._(super.value, super.name);
}

/// Auto-save rule status
class AutoSaveStatus extends $pb.ProtobufEnum {
  static const AutoSaveStatus STATUS_UNKNOWN =
      AutoSaveStatus._(0, _omitEnumNames ? '' : 'STATUS_UNKNOWN');
  static const AutoSaveStatus STATUS_ACTIVE =
      AutoSaveStatus._(1, _omitEnumNames ? '' : 'STATUS_ACTIVE');
  static const AutoSaveStatus STATUS_PAUSED =
      AutoSaveStatus._(2, _omitEnumNames ? '' : 'STATUS_PAUSED');
  static const AutoSaveStatus STATUS_COMPLETED =
      AutoSaveStatus._(3, _omitEnumNames ? '' : 'STATUS_COMPLETED');
  static const AutoSaveStatus STATUS_CANCELLED =
      AutoSaveStatus._(4, _omitEnumNames ? '' : 'STATUS_CANCELLED');

  static const $core.List<AutoSaveStatus> values = <AutoSaveStatus>[
    STATUS_UNKNOWN,
    STATUS_ACTIVE,
    STATUS_PAUSED,
    STATUS_COMPLETED,
    STATUS_CANCELLED,
  ];

  static final $core.List<AutoSaveStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static AutoSaveStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AutoSaveStatus._(super.value, super.name);
}

/// Amount calculation type
class AmountType extends $pb.ProtobufEnum {
  static const AmountType AMOUNT_UNKNOWN =
      AmountType._(0, _omitEnumNames ? '' : 'AMOUNT_UNKNOWN');
  static const AmountType AMOUNT_FIXED =
      AmountType._(1, _omitEnumNames ? '' : 'AMOUNT_FIXED');
  static const AmountType AMOUNT_PERCENTAGE =
      AmountType._(2, _omitEnumNames ? '' : 'AMOUNT_PERCENTAGE');

  static const $core.List<AmountType> values = <AmountType>[
    AMOUNT_UNKNOWN,
    AMOUNT_FIXED,
    AMOUNT_PERCENTAGE,
  ];

  static final $core.List<AmountType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AmountType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AmountType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
