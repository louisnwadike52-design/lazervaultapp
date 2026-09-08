// This is a generated file - do not edit.
//
// Generated from payments.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RecurringFrequency extends $pb.ProtobufEnum {
  static const RecurringFrequency RECURRING_FREQUENCY_UNSPECIFIED =
      RecurringFrequency._(
          0, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_UNSPECIFIED');
  static const RecurringFrequency RECURRING_FREQUENCY_DAILY =
      RecurringFrequency._(
          1, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_DAILY');
  static const RecurringFrequency RECURRING_FREQUENCY_WEEKLY =
      RecurringFrequency._(
          2, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_WEEKLY');
  static const RecurringFrequency RECURRING_FREQUENCY_BIWEEKLY =
      RecurringFrequency._(
          3, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_BIWEEKLY');
  static const RecurringFrequency RECURRING_FREQUENCY_MONTHLY =
      RecurringFrequency._(
          4, _omitEnumNames ? '' : 'RECURRING_FREQUENCY_MONTHLY');

  static const $core.List<RecurringFrequency> values = <RecurringFrequency>[
    RECURRING_FREQUENCY_UNSPECIFIED,
    RECURRING_FREQUENCY_DAILY,
    RECURRING_FREQUENCY_WEEKLY,
    RECURRING_FREQUENCY_BIWEEKLY,
    RECURRING_FREQUENCY_MONTHLY,
  ];

  static final $core.List<RecurringFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static RecurringFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RecurringFrequency._(super.value, super.name);
}

class RecurringTransferStatus extends $pb.ProtobufEnum {
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_UNSPECIFIED =
      RecurringTransferStatus._(
          0, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_UNSPECIFIED');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_ACTIVE =
      RecurringTransferStatus._(
          1, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_ACTIVE');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_PAUSED =
      RecurringTransferStatus._(
          2, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_PAUSED');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_CANCELLED =
      RecurringTransferStatus._(
          3, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_CANCELLED');
  static const RecurringTransferStatus RECURRING_TRANSFER_STATUS_EXPIRED =
      RecurringTransferStatus._(
          4, _omitEnumNames ? '' : 'RECURRING_TRANSFER_STATUS_EXPIRED');

  static const $core.List<RecurringTransferStatus> values =
      <RecurringTransferStatus>[
    RECURRING_TRANSFER_STATUS_UNSPECIFIED,
    RECURRING_TRANSFER_STATUS_ACTIVE,
    RECURRING_TRANSFER_STATUS_PAUSED,
    RECURRING_TRANSFER_STATUS_CANCELLED,
    RECURRING_TRANSFER_STATUS_EXPIRED,
  ];

  static final $core.List<RecurringTransferStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static RecurringTransferStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RecurringTransferStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
