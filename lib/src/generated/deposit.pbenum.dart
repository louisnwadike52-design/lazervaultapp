// This is a generated file - do not edit.
//
// Generated from deposit.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Represents the status of a deposit transaction
class DepositStatus extends $pb.ProtobufEnum {
  static const DepositStatus DEPOSIT_STATUS_UNSPECIFIED =
      DepositStatus._(0, _omitEnumNames ? '' : 'DEPOSIT_STATUS_UNSPECIFIED');
  static const DepositStatus DEPOSIT_STATUS_PENDING =
      DepositStatus._(1, _omitEnumNames ? '' : 'DEPOSIT_STATUS_PENDING');
  static const DepositStatus DEPOSIT_STATUS_PROCESSING =
      DepositStatus._(2, _omitEnumNames ? '' : 'DEPOSIT_STATUS_PROCESSING');
  static const DepositStatus DEPOSIT_STATUS_COMPLETED =
      DepositStatus._(3, _omitEnumNames ? '' : 'DEPOSIT_STATUS_COMPLETED');
  static const DepositStatus DEPOSIT_STATUS_FAILED =
      DepositStatus._(4, _omitEnumNames ? '' : 'DEPOSIT_STATUS_FAILED');

  static const $core.List<DepositStatus> values = <DepositStatus>[
    DEPOSIT_STATUS_UNSPECIFIED,
    DEPOSIT_STATUS_PENDING,
    DEPOSIT_STATUS_PROCESSING,
    DEPOSIT_STATUS_COMPLETED,
    DEPOSIT_STATUS_FAILED,
  ];

  static final $core.List<DepositStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static DepositStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DepositStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
