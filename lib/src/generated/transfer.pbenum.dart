///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TransferType extends $pb.ProtobufEnum {
  static const TransferType TRANSFER_TYPE_UNSPECIFIED = TransferType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSFER_TYPE_UNSPECIFIED');
  static const TransferType TRANSFER_TYPE_INCOME = TransferType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSFER_TYPE_INCOME');
  static const TransferType TRANSFER_TYPE_EXPENSE = TransferType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSFER_TYPE_EXPENSE');
  static const TransferType TRANSFER_TYPE_INTERNAL = TransferType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSFER_TYPE_INTERNAL');

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

class TimePeriod extends $pb.ProtobufEnum {
  static const TimePeriod TIME_PERIOD_UNSPECIFIED = TimePeriod._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME_PERIOD_UNSPECIFIED');
  static const TimePeriod TIME_PERIOD_WEEK = TimePeriod._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME_PERIOD_WEEK');
  static const TimePeriod TIME_PERIOD_MONTH = TimePeriod._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME_PERIOD_MONTH');
  static const TimePeriod TIME_PERIOD_QUARTER = TimePeriod._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME_PERIOD_QUARTER');
  static const TimePeriod TIME_PERIOD_YEAR = TimePeriod._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME_PERIOD_YEAR');
  static const TimePeriod TIME_PERIOD_ALL = TimePeriod._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME_PERIOD_ALL');

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

