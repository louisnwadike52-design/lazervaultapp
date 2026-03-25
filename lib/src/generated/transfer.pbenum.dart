// This is a generated file - do not edit.
//
// Generated from transfer.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Transfer Type Enum
class TransferType extends $pb.ProtobufEnum {
  static const TransferType TRANSFER_TYPE_UNSPECIFIED =
      TransferType._(0, _omitEnumNames ? '' : 'TRANSFER_TYPE_UNSPECIFIED');
  static const TransferType TRANSFER_TYPE_INCOME =
      TransferType._(1, _omitEnumNames ? '' : 'TRANSFER_TYPE_INCOME');
  static const TransferType TRANSFER_TYPE_EXPENSE =
      TransferType._(2, _omitEnumNames ? '' : 'TRANSFER_TYPE_EXPENSE');
  static const TransferType TRANSFER_TYPE_INTERNAL =
      TransferType._(3, _omitEnumNames ? '' : 'TRANSFER_TYPE_INTERNAL');

  static const $core.List<TransferType> values = <TransferType>[
    TRANSFER_TYPE_UNSPECIFIED,
    TRANSFER_TYPE_INCOME,
    TRANSFER_TYPE_EXPENSE,
    TRANSFER_TYPE_INTERNAL,
  ];

  static final $core.List<TransferType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TransferType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TransferType._(super.value, super.name);
}

/// Time Period Enum for Statistics
class TimePeriod extends $pb.ProtobufEnum {
  static const TimePeriod TIME_PERIOD_UNSPECIFIED =
      TimePeriod._(0, _omitEnumNames ? '' : 'TIME_PERIOD_UNSPECIFIED');
  static const TimePeriod TIME_PERIOD_WEEK =
      TimePeriod._(1, _omitEnumNames ? '' : 'TIME_PERIOD_WEEK');
  static const TimePeriod TIME_PERIOD_MONTH =
      TimePeriod._(2, _omitEnumNames ? '' : 'TIME_PERIOD_MONTH');
  static const TimePeriod TIME_PERIOD_QUARTER =
      TimePeriod._(3, _omitEnumNames ? '' : 'TIME_PERIOD_QUARTER');
  static const TimePeriod TIME_PERIOD_YEAR =
      TimePeriod._(4, _omitEnumNames ? '' : 'TIME_PERIOD_YEAR');
  static const TimePeriod TIME_PERIOD_ALL =
      TimePeriod._(5, _omitEnumNames ? '' : 'TIME_PERIOD_ALL');

  static const $core.List<TimePeriod> values = <TimePeriod>[
    TIME_PERIOD_UNSPECIFIED,
    TIME_PERIOD_WEEK,
    TIME_PERIOD_MONTH,
    TIME_PERIOD_QUARTER,
    TIME_PERIOD_YEAR,
    TIME_PERIOD_ALL,
  ];

  static final $core.List<TimePeriod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static TimePeriod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TimePeriod._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
