// This is a generated file - do not edit.
//
// Generated from withdraw.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Represents the status of a withdrawal transaction
class WithdrawalStatus extends $pb.ProtobufEnum {
  static const WithdrawalStatus WITHDRAWAL_STATUS_UNSPECIFIED =
      WithdrawalStatus._(
          0, _omitEnumNames ? '' : 'WITHDRAWAL_STATUS_UNSPECIFIED');
  static const WithdrawalStatus WITHDRAWAL_STATUS_PENDING =
      WithdrawalStatus._(1, _omitEnumNames ? '' : 'WITHDRAWAL_STATUS_PENDING');
  static const WithdrawalStatus WITHDRAWAL_STATUS_PROCESSING =
      WithdrawalStatus._(
          2, _omitEnumNames ? '' : 'WITHDRAWAL_STATUS_PROCESSING');
  static const WithdrawalStatus WITHDRAWAL_STATUS_COMPLETED =
      WithdrawalStatus._(
          3, _omitEnumNames ? '' : 'WITHDRAWAL_STATUS_COMPLETED');
  static const WithdrawalStatus WITHDRAWAL_STATUS_FAILED =
      WithdrawalStatus._(4, _omitEnumNames ? '' : 'WITHDRAWAL_STATUS_FAILED');

  static const $core.List<WithdrawalStatus> values = <WithdrawalStatus>[
    WITHDRAWAL_STATUS_UNSPECIFIED,
    WITHDRAWAL_STATUS_PENDING,
    WITHDRAWAL_STATUS_PROCESSING,
    WITHDRAWAL_STATUS_COMPLETED,
    WITHDRAWAL_STATUS_FAILED,
  ];

  static final $core.List<WithdrawalStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static WithdrawalStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const WithdrawalStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
