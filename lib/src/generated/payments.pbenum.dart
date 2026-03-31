//
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RecurringFrequency extends $pb.ProtobufEnum {
  static const RecurringFrequency RECURRING_FREQUENCY_UNSPECIFIED = RecurringFrequency._(0, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_UNSPECIFIED');
  static const RecurringFrequency RECURRING_FREQUENCY_DAILY = RecurringFrequency._(1, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_DAILY');
  static const RecurringFrequency RECURRING_FREQUENCY_WEEKLY = RecurringFrequency._(2, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_WEEKLY');
  static const RecurringFrequency RECURRING_FREQUENCY_BIWEEKLY = RecurringFrequency._(3, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_BIWEEKLY');
  static const RecurringFrequency RECURRING_FREQUENCY_MONTHLY = RecurringFrequency._(4, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_MONTHLY');

  static const $core.List<RecurringFrequency> values = <RecurringFrequency> [
    RECURRING_FREQUENCY_UNSPECIFIED,
    RECURRING_FREQUENCY_DAILY,
    RECURRING_FREQUENCY_WEEKLY,
    RECURRING_FREQUENCY_BIWEEKLY,
    RECURRING_FREQUENCY_MONTHLY,
  ];

  static final $core.Map<$core.int, RecurringFrequency> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RecurringFrequency? valueOf($core.int value) => _byValue[value];

  const RecurringFrequency._($core.int v, $core.String n) : super(v, n);
}

class RecurringTransferStatus extends $pb.ProtobufEnum {
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_UNSPECIFIED = RecurringTransferStatus._(0, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_UNSPECIFIED');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_ACTIVE = RecurringTransferStatus._(1, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_ACTIVE');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_PAUSED = RecurringTransferStatus._(2, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_PAUSED');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_CANCELLED = RecurringTransferStatus._(3, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_CANCELLED');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_EXPIRED = RecurringTransferStatus._(4, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_EXPIRED');

  static const $core.List<RecurringTransferStatus> values = <RecurringTransferStatus> [
    RECURRING_TRANSFER_STATUS_UNSPECIFIED,
    RECURRING_TRANSFER_STATUS_ACTIVE,
    RECURRING_TRANSFER_STATUS_PAUSED,
    RECURRING_TRANSFER_STATUS_CANCELLED,
    RECURRING_TRANSFER_STATUS_EXPIRED,
  ];

  static final $core.Map<$core.int, RecurringTransferStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RecurringTransferStatus? valueOf($core.int value) => _byValue[value];

  const RecurringTransferStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
