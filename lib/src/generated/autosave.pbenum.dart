///
//  Generated code. Do not modify.
//  source: autosave.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TriggerType extends $pb.ProtobufEnum {
  static const TriggerType TRIGGER_UNKNOWN = TriggerType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRIGGER_UNKNOWN');
  static const TriggerType TRIGGER_ON_DEPOSIT = TriggerType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRIGGER_ON_DEPOSIT');
  static const TriggerType TRIGGER_SCHEDULED = TriggerType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRIGGER_SCHEDULED');
  static const TriggerType TRIGGER_ROUND_UP = TriggerType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRIGGER_ROUND_UP');

  static const $core.List<TriggerType> values = <TriggerType> [
    TRIGGER_UNKNOWN,
    TRIGGER_ON_DEPOSIT,
    TRIGGER_SCHEDULED,
    TRIGGER_ROUND_UP,
  ];

  static final $core.Map<$core.int, TriggerType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TriggerType? valueOf($core.int value) => _byValue[value];

  const TriggerType._($core.int v, $core.String n) : super(v, n);
}

class ScheduleFrequency extends $pb.ProtobufEnum {
  static const ScheduleFrequency FREQUENCY_UNKNOWN = ScheduleFrequency._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FREQUENCY_UNKNOWN');
  static const ScheduleFrequency FREQUENCY_DAILY = ScheduleFrequency._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FREQUENCY_DAILY');
  static const ScheduleFrequency FREQUENCY_WEEKLY = ScheduleFrequency._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FREQUENCY_WEEKLY');
  static const ScheduleFrequency FREQUENCY_BIWEEKLY = ScheduleFrequency._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FREQUENCY_BIWEEKLY');
  static const ScheduleFrequency FREQUENCY_MONTHLY = ScheduleFrequency._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FREQUENCY_MONTHLY');

  static const $core.List<ScheduleFrequency> values = <ScheduleFrequency> [
    FREQUENCY_UNKNOWN,
    FREQUENCY_DAILY,
    FREQUENCY_WEEKLY,
    FREQUENCY_BIWEEKLY,
    FREQUENCY_MONTHLY,
  ];

  static final $core.Map<$core.int, ScheduleFrequency> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ScheduleFrequency? valueOf($core.int value) => _byValue[value];

  const ScheduleFrequency._($core.int v, $core.String n) : super(v, n);
}

class AutoSaveStatus extends $pb.ProtobufEnum {
  static const AutoSaveStatus STATUS_UNKNOWN = AutoSaveStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_UNKNOWN');
  static const AutoSaveStatus STATUS_ACTIVE = AutoSaveStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_ACTIVE');
  static const AutoSaveStatus STATUS_PAUSED = AutoSaveStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_PAUSED');
  static const AutoSaveStatus STATUS_COMPLETED = AutoSaveStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_COMPLETED');
  static const AutoSaveStatus STATUS_CANCELLED = AutoSaveStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_CANCELLED');

  static const $core.List<AutoSaveStatus> values = <AutoSaveStatus> [
    STATUS_UNKNOWN,
    STATUS_ACTIVE,
    STATUS_PAUSED,
    STATUS_COMPLETED,
    STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, AutoSaveStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutoSaveStatus? valueOf($core.int value) => _byValue[value];

  const AutoSaveStatus._($core.int v, $core.String n) : super(v, n);
}

class AmountType extends $pb.ProtobufEnum {
  static const AmountType AMOUNT_UNKNOWN = AmountType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AMOUNT_UNKNOWN');
  static const AmountType AMOUNT_FIXED = AmountType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AMOUNT_FIXED');
  static const AmountType AMOUNT_PERCENTAGE = AmountType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AMOUNT_PERCENTAGE');

  static const $core.List<AmountType> values = <AmountType> [
    AMOUNT_UNKNOWN,
    AMOUNT_FIXED,
    AMOUNT_PERCENTAGE,
  ];

  static final $core.Map<$core.int, AmountType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AmountType? valueOf($core.int value) => _byValue[value];

  const AmountType._($core.int v, $core.String n) : super(v, n);
}

