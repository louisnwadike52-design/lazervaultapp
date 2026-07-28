// This is a generated file - do not edit.
//
// Generated from lock_funds.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Lock type enumeration
class LockType extends $pb.ProtobufEnum {
  static const LockType LOCK_TYPE_UNSPECIFIED =
      LockType._(0, _omitEnumNames ? '' : 'LOCK_TYPE_UNSPECIFIED');
  static const LockType LOCK_TYPE_SAVINGS =
      LockType._(1, _omitEnumNames ? '' : 'LOCK_TYPE_SAVINGS');
  static const LockType LOCK_TYPE_INVESTMENT =
      LockType._(2, _omitEnumNames ? '' : 'LOCK_TYPE_INVESTMENT');
  static const LockType LOCK_TYPE_EMERGENCY_FUND =
      LockType._(3, _omitEnumNames ? '' : 'LOCK_TYPE_EMERGENCY_FUND');
  static const LockType LOCK_TYPE_GOAL_BASED =
      LockType._(4, _omitEnumNames ? '' : 'LOCK_TYPE_GOAL_BASED');

  static const $core.List<LockType> values = <LockType>[
    LOCK_TYPE_UNSPECIFIED,
    LOCK_TYPE_SAVINGS,
    LOCK_TYPE_INVESTMENT,
    LOCK_TYPE_EMERGENCY_FUND,
    LOCK_TYPE_GOAL_BASED,
  ];

  static final $core.List<LockType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static LockType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LockType._(super.value, super.name);
}

/// Lock status enumeration
class LockStatus extends $pb.ProtobufEnum {
  static const LockStatus LOCK_STATUS_UNSPECIFIED =
      LockStatus._(0, _omitEnumNames ? '' : 'LOCK_STATUS_UNSPECIFIED');
  static const LockStatus LOCK_STATUS_ACTIVE =
      LockStatus._(1, _omitEnumNames ? '' : 'LOCK_STATUS_ACTIVE');
  static const LockStatus LOCK_STATUS_MATURED =
      LockStatus._(2, _omitEnumNames ? '' : 'LOCK_STATUS_MATURED');
  static const LockStatus LOCK_STATUS_UNLOCKED =
      LockStatus._(3, _omitEnumNames ? '' : 'LOCK_STATUS_UNLOCKED');
  static const LockStatus LOCK_STATUS_CANCELLED =
      LockStatus._(4, _omitEnumNames ? '' : 'LOCK_STATUS_CANCELLED');

  static const $core.List<LockStatus> values = <LockStatus>[
    LOCK_STATUS_UNSPECIFIED,
    LOCK_STATUS_ACTIVE,
    LOCK_STATUS_MATURED,
    LOCK_STATUS_UNLOCKED,
    LOCK_STATUS_CANCELLED,
  ];

  static final $core.List<LockStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static LockStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LockStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
