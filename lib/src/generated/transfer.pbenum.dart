//
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Transfer Type Enum
class TransferType extends $pb.ProtobufEnum {
  static const TransferType TRANSFER_TYPE_UNSPECIFIED = TransferType._(0, _omitEnumNames ? '' : 'TRANSFER_TYPE_UNSPECIFIED');
  static const TransferType TRANSFER_TYPE_INCOME = TransferType._(1, _omitEnumNames ? '' : 'TRANSFER_TYPE_INCOME');
  static const TransferType TRANSFER_TYPE_EXPENSE = TransferType._(2, _omitEnumNames ? '' : 'TRANSFER_TYPE_EXPENSE');
  static const TransferType TRANSFER_TYPE_INTERNAL = TransferType._(3, _omitEnumNames ? '' : 'TRANSFER_TYPE_INTERNAL');

  static const $core.List<TransferType> values = <TransferType> [
    TRANSFER_TYPE_UNSPECIFIED,
    TRANSFER_TYPE_INCOME,
    TRANSFER_TYPE_EXPENSE,
    TRANSFER_TYPE_INTERNAL,
  ];

  static final $core.Map<$core.int, TransferType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransferType? valueOf($core.int value) => _byValue[value];

  const TransferType._($core.int v, $core.String n) : super(v, n);
}

/// Time Period Enum for Statistics
class TimePeriod extends $pb.ProtobufEnum {
  static const TimePeriod TIME_PERIOD_UNSPECIFIED = TimePeriod._(0, _omitEnumNames ? '' : 'TIME_PERIOD_UNSPECIFIED');
  static const TimePeriod TIME_PERIOD_WEEK = TimePeriod._(1, _omitEnumNames ? '' : 'TIME_PERIOD_WEEK');
  static const TimePeriod TIME_PERIOD_MONTH = TimePeriod._(2, _omitEnumNames ? '' : 'TIME_PERIOD_MONTH');
  static const TimePeriod TIME_PERIOD_QUARTER = TimePeriod._(3, _omitEnumNames ? '' : 'TIME_PERIOD_QUARTER');
  static const TimePeriod TIME_PERIOD_YEAR = TimePeriod._(4, _omitEnumNames ? '' : 'TIME_PERIOD_YEAR');
  static const TimePeriod TIME_PERIOD_ALL = TimePeriod._(5, _omitEnumNames ? '' : 'TIME_PERIOD_ALL');

  static const $core.List<TimePeriod> values = <TimePeriod> [
    TIME_PERIOD_UNSPECIFIED,
    TIME_PERIOD_WEEK,
    TIME_PERIOD_MONTH,
    TIME_PERIOD_QUARTER,
    TIME_PERIOD_YEAR,
    TIME_PERIOD_ALL,
  ];

  static final $core.Map<$core.int, TimePeriod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TimePeriod? valueOf($core.int value) => _byValue[value];

  const TimePeriod._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
